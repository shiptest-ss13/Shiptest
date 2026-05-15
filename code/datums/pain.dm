// -- Pain for bodyparts --

/*
 * The pain controller datum.
 *
 * Attatched to a /carbon/human, this datum tracks all the pain values on all their bodyparts and handles updating them.
 * This datum processes on alive humans every 2 seconds.
 */
/datum/pain
	/// The parent mob we're tracking.
	var/mob/living/carbon/parent
	/// Modifier applied to all [adjust_pain] amounts
	var/pain_modifier = 1
	/// List of all pain modifiers we have
	var/list/pain_mods = list()
	/// Assoc list [zones] to [references to bodyparts]
	var/list/body_zones = list()
	/// Natural amount of decay given to each limb per 5 ticks of process
	var/natural_pain_decay = -0.2
	/// Counter to track pain decay. Pain decay is only done once every 5 ticks.
	var/natural_decay_counter = 0
	/// Cooldown to track the last time we lost pain.
	COOLDOWN_DECLARE(time_since_last_pain_loss)
	/// Cooldown to track last time we sent a pain message.
	COOLDOWN_DECLARE(time_since_last_pain_message)
	var/debugging = FALSE

/datum/pain/New(mob/living/carbon/human/new_parent)
	if(!iscarbon(new_parent) || istype(new_parent, /mob/living/carbon/human/dummy))
		qdel(src) // If we're not a carbon, or a dummy, delete us
		return

	parent = new_parent
	for(var/obj/item/bodypart/parent_bodypart in parent.bodyparts)
		add_bodypart(parent, parent_bodypart, TRUE)

	if(!body_zones.len)
		stack_trace("Pain datum failed to find any body_zones to track!")
		qdel(src) // If we have no bodyparts, delete us
		return

	RegisterParentSignals()
	if(new_parent.stat == CONSCIOUS)
		start_pain_processing()

/datum/pain/Destroy()
	for(var/part in body_zones)
		body_zones -= part
	stop_pain_processing()
	UnregisterParentSignals()
	parent = null
	return ..()

/*
 * Register all of our signals with our parent.
 */
/datum/pain/proc/RegisterParentSignals()
	if(!parent)
		CRASH("Attempted to register pain signals on null parent!")

	RegisterSignal(parent, COMSIG_CARBON_ATTACH_LIMB, .proc/add_bodypart)
	RegisterSignal(parent, COMSIG_CARBON_REMOVE_LIMB, .proc/remove_bodypart)
	RegisterSignal(parent, COMSIG_MOB_APPLY_DAMGE, .proc/add_damage_pain)
	RegisterSignal(parent, COMSIG_CARBON_GAIN_WOUND, .proc/add_wound_pain)
	RegisterSignal(parent, COMSIG_CARBON_LOSE_WOUND, .proc/remove_wound_pain)
	RegisterSignal(parent, COMSIG_LIVING_REVIVE, .proc/start_pain_processing)
	RegisterSignal(parent, COMSIG_LIVING_DEATH, .proc/stop_pain_processing)
	RegisterSignal(parent, COMSIG_LIVING_POST_FULLY_HEAL, .proc/remove_all_pain)
	RegisterSignal(parent, COMSIG_MOB_HEALTHSCANNED, .proc/on_analyzed)

/*
 * Unregister all of our signals from our parent when we're done, if we have signals to unregister.
 */
/datum/pain/proc/UnregisterParentSignals()
	if(!parent)
		return

	UnregisterSignal(parent, list(
		COMSIG_CARBON_ATTACH_LIMB,
		COMSIG_CARBON_REMOVE_LIMB,
		COMSIG_MOB_APPLY_DAMGE,
		COMSIG_CARBON_GAIN_WOUND,
		COMSIG_CARBON_LOSE_WOUND,
		COMSIG_LIVING_REVIVE,
		COMSIG_LIVING_DEATH,
		COMSIG_LIVING_POST_FULLY_HEAL,
		COMSIG_MOB_HEALTHSCANNED,
	))

/*
 * Add a limb to be tracked.
 *
 * source - source of the signal / the mob who is gaining the limb / parent
 * new_limb - the bodypart being attatched
 * special - whether this limb being attatched should have side effects (if TRUE, likely being attatched on initialization)
 */
/datum/pain/proc/add_bodypart(mob/living/carbon/source, obj/item/bodypart/new_limb, special)
	SIGNAL_HANDLER

	if(!istype(new_limb))
		return

	if(new_limb.body_zone in body_zones)
		if(body_zones[new_limb.body_zone]) // if we already have a val assigned to this key
			remove_bodypart(lost_limb = body_zones[new_limb.body_zone], special = special)
		else // if we somehow don't have a val assigned to this key
			body_zones -= new_limb.body_zone

	body_zones[new_limb.body_zone] = new_limb

	if(special)
		new_limb.pain = 0
	else
		adjust_bodypart_pain(new_limb.body_zone, new_limb.pain)
		adjust_bodypart_pain(BODY_ZONE_CHEST, new_limb.pain / 3)

/*
 * Remove a limb from being tracked.
 *
 * source - source of the signal / the mob who is losing the limb / parent
 * lost_limb - the bodypart being removed
 * special - whether this limb being removed should have side effects (if TRUE, likely being removed on initialization)
 * dismembered - whether this limb was dismembered
 */
/datum/pain/proc/remove_bodypart(mob/living/carbon/source, obj/item/bodypart/lost_limb, special, dismembered)
	SIGNAL_HANDLER

	if(!special)
		var/limb_removed_pain = dismembered ? PAIN_LIMB_DISMEMBERED : PAIN_LIMB_REMOVED
		adjust_bodypart_pain(BODY_ZONE_CHEST, limb_removed_pain)
		adjust_bodypart_pain(BODY_ZONE_HEAD, limb_removed_pain / 4)
		lost_limb.pain = initial(lost_limb.pain)
		lost_limb.max_stamina_damage = initial(lost_limb.max_stamina_damage)

	body_zones -= lost_limb

/*
 * Add a pain modifier and update our overall modifier.
 *
 * key - key of the added modifier
 * amount - multiplier of the modifier
 *
 * returns TRUE if our pain mod actually changed
 */
/datum/pain/proc/set_pain_modifier(key, amount)
	if(!isnull(pain_mods[key]))
		if(amount > 1 && pain_mods[key] >= amount)
			return FALSE
		if(amount < 1 && pain_mods[key] <= amount)
			return FALSE
		if(amount == 1)
			return FALSE

	pain_mods[key] = amount
	return update_pain_modifier()

/*
 * Remove a pain modifier and update our overall modifier.
 *
 * key - key of the removed modifier
 *
 * returns TRUE if our pain mod actually changed
 */
/datum/pain/proc/unset_pain_modifier(key)
	if(isnull(pain_mods[key]))
		return FALSE

	pain_mods -= key
	return update_pain_modifier()

/*
 * Update our overall pain modifier.
 * The pain modifier is multiplicative based on all the pain modifiers we have.
 *
 * returns TRUE if our pain modifier was changed after update, FALSE if it remained the same
 */
/datum/pain/proc/update_pain_modifier()
	var/old_pain_mod = pain_modifier
	pain_modifier = 1
	for(var/mod in pain_mods)
		pain_modifier *= pain_mods[mod]
	return old_pain_mod != pain_modifier

/*
 * Adjust the amount of pain in all [def_zones] provided by [amount] (multiplied by the [pain_modifier] if positive).
 *
 * def_zones - list of all zones being adjusted. Can be passed a non-list.
 * amount - amount of pain being applied to all items in [def_zones]. If posiitve, multiplied by [pain_modifier].
 */
/datum/pain/proc/adjust_bodypart_pain(list/def_zones, amount, type = BRUTE)
	SHOULD_NOT_SLEEP(TRUE) // This needs to be asyncronously called in a lot of places, it should already check that this doesn't sleep but just in case.

	if(!islist(def_zones))
		def_zones = list(def_zones)

	if(!amount)
		return

	shuffle_inplace(def_zones)
	for(var/zone in def_zones)
		var/adjusted_amount = round(amount, 0.01)
		var/obj/item/bodypart/adjusted_bodypart = body_zones[zone]
		if(!adjusted_bodypart)
			continue
		if(amount < 0 && adjusted_bodypart.pain <= adjusted_bodypart.min_pain)
			continue
		if(amount > 0 && adjusted_bodypart.pain >= adjusted_bodypart.max_pain)
			continue
		if(adjusted_amount > 0)
			adjusted_bodypart.last_recieved_pain_type = type
			adjusted_amount = round(adjusted_amount * pain_modifier * adjusted_bodypart.bodypart_pain_modifier, 0.01)
		adjusted_bodypart.pain = clamp(adjusted_bodypart.pain + adjusted_amount, adjusted_bodypart.min_pain, adjusted_bodypart.max_pain)

		if(adjusted_amount > 0)
			INVOKE_ASYNC(src, .proc/on_pain_gain, adjusted_bodypart, amount, type)
		else if(COOLDOWN_FINISHED(src, time_since_last_pain_loss))
			INVOKE_ASYNC(src, .proc/on_pain_loss, adjusted_bodypart, amount, type)

		if(debugging)
			message_admins("DEBUG: [parent] recived [adjusted_amount] pain to [adjusted_bodypart]. Part pain: [adjusted_bodypart.pain]")

	return TRUE

/*
 * Set the minimum amount of pain in all [def_zones] by [amount].
 *
 * def_zones - list of all zones being adjusted. Can be passed a non-list.
 * amount - amount of pain being all items in [def_zones] are set to.
 */
/datum/pain/proc/adjust_bodypart_min_pain(list/def_zones, amount)
	if(!amount)
		return

	if(!islist(def_zones))
		def_zones = list(def_zones)

	for(var/zone in def_zones)
		var/obj/item/bodypart/adjusted_bodypart = body_zones[zone]
		if(!adjusted_bodypart)
			CRASH("Pain component attempted to adjust_bodypart_pain of untracked or invalid zone [zone].")
		adjusted_bodypart.min_pain = round(clamp(adjusted_bodypart.min_pain + amount, 0, adjusted_bodypart.max_pain), 0.01)
		adjusted_bodypart.pain = clamp(adjusted_bodypart.pain, adjusted_bodypart.min_pain, adjusted_bodypart.max_pain)

	return TRUE

/*
 * Called when pain is gained to apply side effects.
 * Calls [affected_part]'s [on_gain_pain_effects] proc with arguments [amount].
 * Sends signal [COMSIG_CARBON_PAIN_GAINED] with arguments [mob/living/carbon/parent, obj/item/bodypart/affected_part, amount].
 *
 * affected_part - the bodypart that gained the pain
 * amount - amount of pain that was gained, post-[pain_modifier] applied
 */
/datum/pain/proc/on_pain_gain(obj/item/bodypart/affected_part, amount, type)
	affected_part.on_gain_pain_effects(amount)
	apply_pain_attributes()
	SEND_SIGNAL(parent, COMSIG_CARBON_PAIN_GAINED, affected_part, amount, type)
	COOLDOWN_START(src, time_since_last_pain_loss, 60 SECONDS)

	if(amount > 12 && prob(20))
		do_pain_emote("scream", 5 SECONDS)
	else if(amount > 6 && prob(25))
		do_pain_emote(pick(PAIN_EMOTES))

/*
 * Called when pain is lost, if the mob did not lose pain in the last 60 seconds.
 * Calls [affected_part]'s [on_lose_pain_effects] proc with arguments [amount].
 * Sends signal [COMSIG_CARBON_PAIN_LOST] with arguments [mob/living/carbon/parent, obj/item/bodypart/affected_part, amount].
 *
 * affected_part - the bodypart that lost pain
 * amount - amount of pain that was lost
 */
/datum/pain/proc/on_pain_loss(obj/item/bodypart/affected_part, amount, type)
	affected_part.on_lose_pain_effects(amount)
	apply_pain_attributes()
	SEND_SIGNAL(parent, COMSIG_CARBON_PAIN_LOST, affected_part, amount, type)

/*
 * Hook into [/mob/living/proc/apply_damage] proc via signal and apply pain based on how much damage was gained.
 *
 * source - source of the signal / the mob being damaged / parent
 * damage - the amount of damage sustained
 * damagetype - the type of damage sustained
 * def_zone - the limb being targeted with damage (either a bodypart zone or an obj/item/bodypart)
 */
/datum/pain/proc/add_damage_pain(mob/living/carbon/source, damage, damagetype, def_zone)
	SIGNAL_HANDLER

	if(damage <= 0)
		return
	if(isbodypart(def_zone))
		var/obj/item/bodypart/targeted_part = def_zone
		def_zone = targeted_part.body_zone
	else
		def_zone = check_zone(def_zone)

	var/pain = damage
	switch(damagetype)
		// Brute pain is dealt to the target zone
		// pain = the damage divided by a random number
		if(BRUTE)
			pain = damage / rand(1.5, 3)

		// Burn pain is dealt to the target zone
		// pain = lower for weaker burns, but scales up for more damaging burns
		if(BURN)
			switch(damage)
				if(1 to 10)
					pain = damage / 4
				if(10 to 15)
					pain = damage / 3
				if(15 to 20)
					pain = damage / 2
				if(20 to INFINITY)
					pain = damage / 1.2

		// Toxins pain is dealt to the chest (stomach and liver)
		// pain = divided by the liver's tox tolerance, liver damage, stomach damage, and more for higher total toxloss
		if(TOX)
			def_zone = BODY_ZONE_CHEST
			var/obj/item/organ/liver/our_liver = source.getorganslot(ORGAN_SLOT_LIVER)
			var/obj/item/organ/stomach/our_stomach = source.getorganslot(ORGAN_SLOT_STOMACH)
			if(our_liver)
				pain = damage / our_liver.toxTolerance
				switch(our_liver.damage)
					if(20 to 50)
						pain += 1
					if(50 to 80)
						pain += 2
					if(80 to INFINITY)
						pain += 3
			else
				pain = damage * 2

			if(our_stomach)
				switch(our_stomach.damage)
					if(20 to 50)
						pain += 1
					if(50 to 80)
						pain += 2
					if(80 to INFINITY)
						pain += 3
			else
				pain += 3

			switch(source.toxloss)
				if(33 to 66)
					pain += 1
				if(66 to INFINITY)
					pain += 3

		// Oxy pain is dealt to the head and chest
		// pain = more for hurt lungs, more for higher total oxyloss
		if(OXY)
			def_zone = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST)
			var/obj/item/organ/lungs/our_lungs = source.getorganslot(ORGAN_SLOT_LUNGS)
			if(our_lungs)
				switch(our_lungs.damage)
					if(20 to 50)
						pain += 1
					if(50 to 80)
						pain += 2
					if(80 to INFINITY)
						pain += 3
			else
				pain += 5

			switch(parent.oxyloss)
				if(0 to 20)
					pain = 0
				if(20 to 50)
					pain += 1
				if(50 to INFINITY)
					pain += 3

		// Cellular pain is dealt to all bodyparts
		// pain = damage (very ouchy)
		if(CLONE)
			def_zone = BODY_ZONES_ALL

		// No pain from stamina loss
		if(STAMINA)
			return

		// Head pain causes brain damage, so brain damage causes no pain (to prevent death spirals)
		if(BRAIN)
			return

	if(!def_zone || !pain)
		return

	adjust_bodypart_pain(def_zone, pain, damagetype)

/*
 * Add pain in from a recieved wound based on severity.
 *
 * source - source of the signal / the mob being wounded / parent
 * applied_wound - the wound being applied
 * wounded_limb - the limb being wounded
 */
/datum/pain/proc/add_wound_pain(mob/living/carbon/source, datum/wound/applied_wound, obj/item/bodypart/wounded_limb)
	SIGNAL_HANDLER

	adjust_bodypart_min_pain(wounded_limb.body_zone, applied_wound.severity * 5)
	adjust_bodypart_pain(wounded_limb.body_zone, applied_wound.severity * 10)

/*
 * Remove pain from a healed wound.
 *
 * source - source of the signal / the mob being wounded / parent
 * removed_wound - the wound being healed
 * wounded_limb - the limb that was wounded
 */
/datum/pain/proc/remove_wound_pain(mob/living/carbon/source, datum/wound/removed_wound, obj/item/bodypart/wounded_limb)
	SIGNAL_HANDLER

	adjust_bodypart_min_pain(wounded_limb.body_zone, -removed_wound.severity * 5)
	adjust_bodypart_pain(wounded_limb.body_zone, -removed_wound.severity * 5)

/*
 * The process proc for pain.
 *
 * Applies and removes pain modifiers as they come and go.
 * Causes various side effects based on pain.
 *
 * Triggers once every 2 seconds.
 * Handles natural pain decay, which happens once every 5 processes (every 10 seconds)
 */
/datum/pain/process(delta_time)

	check_pain_modifiers(delta_time)

	var/list/shuffled_zones = shuffle(body_zones)
	for(var/part in shuffled_zones)
		var/obj/item/bodypart/checked_bodypart = body_zones[part]
		if(QDELETED(checked_bodypart))
			stack_trace("Null or invalid bodypart found in [parent]'s pain bodypart list! Bodypart: [checked_bodypart] Zone: [part]")
			body_zones -= part
			continue
		if(!checked_bodypart.pain)
			continue
		checked_bodypart.processed_pain_effects(delta_time)

		if(DT_PROB(checked_bodypart.get_modified_pain() / 8, delta_time) && COOLDOWN_FINISHED(src, time_since_last_pain_message))
			if(checked_bodypart.pain_feedback(delta_time, COOLDOWN_FINISHED(src, time_since_last_pain_loss)))
				COOLDOWN_START(src, time_since_last_pain_message, 4 SECONDS)

	// we check the average pain of all bodyparts, normalized to limb pain (max of 75)
	if(!parent.has_status_effect(STATUS_EFFECT_DETERMINED))
		switch(get_average_pain())
			if(10 to 40)
				low_pain_effects(delta_time)
			if(40 to 70)
				med_pain_effects(delta_time)
			if(70 to INFINITY)
				high_pain_effects(delta_time)

	decay_pain(delta_time)

/*
 * Check which additional pain modifiers should be applied.
 */
/datum/pain/proc/check_pain_modifiers(delta_time)
	if(parent.drunkenness)
		if(parent.drunkenness > 10)
			set_pain_modifier(PAIN_MOD_DRUNK, 0.9)
		else
			unset_pain_modifier(PAIN_MOD_DRUNK)

	if(parent.drowsyness)
		if(parent.drowsyness > 8)
			set_pain_modifier(PAIN_MOD_DROWSY, 0.95)
		else
			unset_pain_modifier(PAIN_MOD_DROWSY)

	if(HAS_TRAIT(parent, TRAIT_OFF_STATION_PAIN_RESISTANCE))
		if(is_station_level(parent.z))
			if(unset_pain_modifier(PAIN_MOD_OFF_STATION))
				to_chat(parent, span_notice("Returning to the station, you feel much more vulnerable to incoming pain."))
		else
			if(set_pain_modifier(PAIN_MOD_OFF_STATION, 0.6))
				to_chat(parent, span_notice("As you depart from the station, you feel more resilient to incoming pain."))

	if(parent.IsSleeping())
		var/sleeping_turf = get_turf(parent)
		var/sleeping_modifier = 0.8
		if(locate(/obj/structure/bed) in sleeping_turf)
			sleeping_modifier -= 0.2
		if(locate(/obj/item/bedsheet) in sleeping_turf)
			sleeping_modifier -= 0.2
		if(locate(/obj/structure/table/optable) in sleeping_turf)
			sleeping_modifier -= 0.1
		var/obj/item/organ/lungs/our_lungs = parent.getorganslot(ORGAN_SLOT_LUNGS)
		if(our_lungs?.on_anesthetic)
			sleeping_modifier -= 0.5

		sleeping_modifier = max(sleeping_modifier, 0.1)
		set_pain_modifier(PAIN_MOD_SLEEP, sleeping_modifier)
	else
		unset_pain_modifier(PAIN_MOD_SLEEP)

/*
 * Natural pain healing of all of our bodyparts per five process ticks / 10 seconds.
 *
 * Slowly increases overtime if the [parent] has not experienced pain in a minute.
 * Multiplied by the pain modifier, up to 3x decay.
 */
/datum/pain/proc/decay_pain(delta_time)
	natural_decay_counter++
	if(natural_decay_counter % 5 == 0) // every 10 seconds
		natural_decay_counter = 0
		if(COOLDOWN_FINISHED(src, time_since_last_pain_loss))
			natural_pain_decay = max(natural_pain_decay - 0.016, -1) // 0.16 per 10 seconds, ~0.1 per minute, 10 minutes for ~1 decay
		else
			natural_pain_decay = initial(natural_pain_decay)

		// modify our pain decay by our pain modifier (ex. 0.5 pain modifier = 2x natural pain decay, capped at ~3x)
		var/pain_modified_decay = round(natural_pain_decay * (1 / max(pain_modifier, 0.33)), 0.01)
		adjust_bodypart_pain(BODY_ZONES_ALL, pain_modified_decay)

/*
 * Effects caused by medium pain. (~250-400 pain)
 */
/datum/pain/proc/low_pain_effects(delta_time)
	if(DT_PROB(3, delta_time))
		to_chat(parent, span_danger(pick("Everything aches.", "Everything feels sore.")))
		if(parent.staminaloss < 5)
			parent.apply_damage(10, STAMINA)
	else if(DT_PROB(1, delta_time))
		parent.Jitter(5)
	else if(DT_PROB(1, delta_time))
		parent.Dizzy(2)

/*
 * Effects caused by medium pain. (~250-400 pain)
 */
/datum/pain/proc/med_pain_effects(delta_time)
	if(DT_PROB(0.05, delta_time))
		if(is_undergoing_shock())
			return
		parent.ForceContractDisease(new /datum/disease/shock(), FALSE, TRUE)
		to_chat(parent, span_userdanger("You feel your body start to shut down!"))
		parent.visible_message(span_danger("[parent] grabs at their chest and stares into the distance as they go into shock!"), ignored_mobs = parent)
	else if(DT_PROB(3, delta_time))
		to_chat(parent, span_bold(span_danger(pick("Everything hurts.", "Everything feels very sore.", "It hurts."))))
		do_pain_emote("scream", 5 SECONDS)
		if(parent.staminaloss < 30)
			parent.apply_damage(10, STAMINA)
	else if(DT_PROB(6, delta_time) && parent.staminaloss <= 60)
		parent.apply_damage(20 * pain_modifier, STAMINA)
		if(do_pain_emote("gasp"))
			parent.visible_message(span_warning("[parent] doubles over in pain!"))
	else if(DT_PROB(0.5, delta_time))
		parent.Knockdown(15 * pain_modifier)
		parent.visible_message(span_warning("[parent] collapses from pain!"))
	else if(DT_PROB(1, delta_time))
		parent.Jitter(10)
	else if(DT_PROB(1, delta_time))
		parent.Dizzy(5)
	else if(DT_PROB(3, delta_time))
		var/obj/item/held_item = parent.get_active_held_item()
		if(held_item && parent.dropItemToGround(held_item))
			to_chat(parent, span_danger("Your fumble though the pain and drop [held_item]!"))
			parent.visible_message(span_warning("[parent] fumbles around and drops [held_item]!"), ignored_mobs = parent)
			do_pain_emote("gasp")

/*
 * Effects caused by extremely high pain. (~400-500 pain)
 */
/datum/pain/proc/high_pain_effects(delta_time)
	if(DT_PROB(0.5, delta_time))
		if(is_undergoing_shock())
			return
		parent.ForceContractDisease(new /datum/disease/shock(), FALSE, TRUE)
		to_chat(parent, span_userdanger("You feel your body start to shut down!"))
		parent.visible_message(span_danger("[parent] grabs at their chest and stares into the distance as they go into shock!"), ignored_mobs = parent)
	else if(DT_PROB(3, delta_time))
		to_chat(parent, span_userdanger(pick("Stop the pain!", "Everything hurts!")))
		do_pain_emote("scream", 5 SECONDS)
		if(parent.staminaloss < 50)
			parent.apply_damage(10, STAMINA)
	else if(DT_PROB(2, delta_time))
		parent.Knockdown(15 * pain_modifier)
		parent.visible_message(span_warning("[parent] collapses from pain!"))
	else if(DT_PROB(1, delta_time))
		parent.vomit(50)
	else if(DT_PROB(1, delta_time))
		do_pain_emote("wince")
		parent.Jitter(15)
	else if(DT_PROB(1, delta_time))
		parent.set_confusion(min(parent.get_confusion() + 4, 12))
	else if(DT_PROB(4, delta_time))
		do_pain_emote("cry", 6 SECONDS)
	else if(DT_PROB(8, delta_time))
		var/obj/item/held_item = parent.get_active_held_item()
		if(held_item && parent.dropItemToGround(held_item))
			to_chat(parent, span_danger("Your fumble though the pain and drop [held_item]!"))
			parent.visible_message(span_warning("[parent] fumbles around and drops [held_item]!"), ignored_mobs = parent)
			parent.emote("gasp")
	else if(DT_PROB(12, delta_time) && parent.staminaloss <= 75)
		parent.apply_damage(30 * pain_modifier, STAMINA)
		if(do_pain_emote("gasp"))
			parent.visible_message(span_warning("[parent] doubles over in pain!"))

/*
 * Apply or remove pain various modifiers from pain (mood, action speed, movement speed) based on the [average_pain].
 */
/datum/pain/proc/apply_pain_attributes()
	switch(get_average_pain())
		if(0 to 20)
			parent.mob_surgery_speed_mod = initial(parent.mob_surgery_speed_mod)
			parent.remove_movespeed_modifier(MOVESPEED_ID_PAIN)
			parent.remove_actionspeed_modifier(ACTIONSPEED_ID_PAIN)
			SEND_SIGNAL(parent, COMSIG_CLEAR_MOOD_EVENT, "pain")
		if(20 to 40)
			parent.mob_surgery_speed_mod = 0.9
			parent.add_movespeed_modifier(/datum/movespeed_modifier/pain/light)
			parent.add_actionspeed_modifier(/datum/actionspeed_modifier/pain/light)
			SEND_SIGNAL(parent, COMSIG_ADD_MOOD_EVENT, "pain", /datum/mood_event/light_pain)
		if(40 to 60)
			parent.mob_surgery_speed_mod = 0.75
			parent.add_movespeed_modifier(/datum/movespeed_modifier/pain/medium)
			parent.add_actionspeed_modifier(/datum/actionspeed_modifier/pain/medium)
			SEND_SIGNAL(parent, COMSIG_ADD_MOOD_EVENT, "pain", /datum/mood_event/med_pain)
		if(60 to 80)
			parent.mob_surgery_speed_mod = 0.6
			parent.add_movespeed_modifier(/datum/movespeed_modifier/pain/heavy)
			parent.add_actionspeed_modifier(/datum/actionspeed_modifier/pain/heavy)
			SEND_SIGNAL(parent, COMSIG_ADD_MOOD_EVENT, "pain", /datum/mood_event/heavy_pain)
		if(80 to INFINITY)
			parent.mob_surgery_speed_mod = 0.5
			parent.add_movespeed_modifier(/datum/movespeed_modifier/pain/crippling)
			parent.add_actionspeed_modifier(/datum/actionspeed_modifier/pain/crippling)
			SEND_SIGNAL(parent, COMSIG_ADD_MOOD_EVENT, "pain", /datum/mood_event/crippling_pain)

/*
 * Run a pain related emote, if a few checks are successful.
 *
 * emote - string, what emote we're running
 * cooldown - what cooldown to set our emote cooldown to
 *
 * returns TRUE if successful.
 */
/datum/pain/proc/do_pain_emote(emote, cooldown = 3 SECONDS)
	if(!COOLDOWN_FINISHED(src, time_since_last_pain_message))
		return FALSE

	if(parent.stat == DEAD)
		return FALSE

	parent.emote(emote)
	COOLDOWN_START(src, time_since_last_pain_message, cooldown)
	return TRUE

/*
 * Get the average pain of all bodyparts as a percent of the total pain.
 */
/datum/pain/proc/get_average_pain()
	var/max_total_pain = 0
	var/total_pain = 0
	for(var/zone in body_zones)
		var/obj/item/bodypart/adjusted_bodypart = body_zones[zone]
		total_pain += adjusted_bodypart.pain
		max_total_pain += adjusted_bodypart.max_pain

	return 100 * total_pain / max_total_pain

/*
 * Returns TRUE if we are undergoing shock.
 */
/datum/pain/proc/is_undergoing_shock()
	return locate(/datum/disease/shock) in parent.diseases

/*
 * Remove all pain, pain paralysis, side effects, etc. from our mob after we're fully healed by something (like an adminheal)
 */
/datum/pain/proc/remove_all_pain(datum/source, adminheal)
	SIGNAL_HANDLER

	for(var/zone in body_zones)
		var/obj/item/bodypart/healed_bodypart = body_zones[zone]
		adjust_bodypart_min_pain(zone, -500)
		adjust_bodypart_pain(zone, -500)
		REMOVE_TRAIT(healed_bodypart, TRAIT_PARALYSIS, PAIN_LIMB_PARALYSIS)
	parent.remove_status_effect(STATUS_EFFECT_LIMP_PAIN)
	for(var/mod in pain_mods)
		if(mod == PAIN_MOD_QUIRK || mod == PAIN_MOD_SPECIES)
			continue
		unset_pain_modifier(mod)

/*
 * Start processing the pain datum.
 */
/datum/pain/proc/start_pain_processing(datum/source)
	SIGNAL_HANDLER

	START_PROCESSING(SSpain, src)

/*
 * Stop processing the pain datum.
 */
/datum/pain/proc/stop_pain_processing(datum/source)
	SIGNAL_HANDLER

	STOP_PROCESSING(SSpain, src)

/*
 * Sends text to health analyzers via signal. Reports how much pain [source] is sustaining to [user].
 * Only sends a vague description of how much pain, instead of a detailed report -
 * it's up to the patient to elaborate on which limbs hurt and how much they hurt.
 *
 * adds text to [analyzer_text] list in place
 */
/datum/pain/proc/on_analyzed(mob/living/carbon/source, mob/living/carbon/human/user, list/analyzer_text)
	SIGNAL_HANDLER

	var/amount = ""
	var/tip = ""
	if(is_undergoing_shock())
		tip += "Neurogenic shock has begun and should be treated urgently. "

	switch(get_average_pain())
		if(5 to 15)
			amount = "minor"
			tip += "Pain should subside in time."
		if(15 to 30)
			amount = "moderate"
			tip += "Pain should subside in time and can be quickened with rest or cryogenics, or painkilling medication."
		if(30 to 50)
			amount = "major"
			tip += "Treat wounds and abate pain with rest, cryogenics, or stasis and painkilling medication."
		if(50 to 80)
			amount = "severe"
			if(!tip)
				tip += span_bold("Alert: Potential of neurogenic shock. ")
			tip += "Treat wounds and abate pain with rest, anesthetic, cryogenics, or stasis, and painkilling medication."
		if(80 to 100)
			amount = "extreme"
			if(!tip)
				tip += span_bold("Alert: High potential of neurogenic shock. ")
			tip += "Treat wounds and abate pain with long rest, anesthetic, cryogenics, or stasis, and heavy painkilling medication."

	if(amount && tip)
		analyzer_text += "<span class='alert ml-1'>"
		analyzer_text += span_bold("Subject is experiencing [amount] pain. ")
		analyzer_text += tip
		analyzer_text += "</span>"

// ------ Pain debugging stuff. ------
/datum/pain/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("debug_pain", "Debug Pain")
	VV_DROPDOWN_OPTION("set_limb_pain", "Adjust Limb Pain")
	VV_DROPDOWN_OPTION("refresh_mod", "Refresh Pain Mod")

/datum/pain/vv_do_topic(href_list)
	. = ..()
	if(href_list["debug_pain"])
		debug_print_pain()
	if(href_list["set_limb_pain"])
		admin_adjust_bodypart_pain()
	if(href_list["refresh_mod"])
		update_pain_modifier()

/datum/pain/proc/debug_print_pain()
	debugging = !debugging
	if(debugging)
		message_admins("Debugging pain enabled. DEBUG PRINTOUT: [src]")
		message_admins("[parent] has an average pain of [get_average_pain()].")
		message_admins("[parent] has a pain modifier of [pain_modifier].")
		message_admins(" - - - - ")
		for(var/part in body_zones)
			var/obj/item/bodypart/checked_bodypart = body_zones[part]

			message_admins("[parent] has [checked_bodypart.pain] pain in [checked_bodypart.name].")
			message_admins(" * [checked_bodypart.name] has a max pain of [checked_bodypart.max_pain].")

		message_admins(" - - - - ")
		for(var/mod in pain_mods)
			message_admins("[parent] has pain mod [mod], value [pain_mods[mod]].")
	else
		message_admins("Debugging pain disabled.")

/datum/pain/proc/admin_adjust_bodypart_pain()
	var/zone = input(usr, "Which bodypart") as null|anything in BODY_ZONES_ALL + "All"
	var/amount = input(usr, "How much?") as null|num

	if(isnull(amount) || isnull(zone))
		return
	if(zone == "All")
		zone = BODY_ZONES_ALL

	amount = clamp(amount, -200, 200)
	adjust_bodypart_pain(zone, amount)
