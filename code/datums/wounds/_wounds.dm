/*
	Wounds are datums that operate like a mix of diseases, brain traumas, and components, and are
	applied to a /obj/item/bodypart (preferably attached to a carbon) when they take large spikes of damage
	or under other certain conditions (thrown hard against a wall, sustained exposure to plasma fire, etc).

	Wounds are categorized by the three following criteria:
		1. Severity: Either MODERATE, SEVERE, or CRITICAL.
		2. Viable zones: What body parts the wound is applicable to. Generic wounds like broken bones and severe burns can apply to every zone, but you may want to add special wounds for certain limbs
			like a twisted ankle for legs only, or open air exposure of the organs for particularly gruesome chest wounds. Wounds should be able to function for every zone they are marked viable for.
		3. Damage type: Currently either BRUTE or BURN. Again, see the hackmd for a breakdown of my plans for each type.

	When a body part suffers enough damage to get a wound, the severity (determined by a roll or something, worse damage leading to worse wounds), affected limb, and damage type sustained are factored into
	deciding what specific wound will be applied. I'd like to have a few different types of wounds for at least some of the choices, but I'm just doing rough generals for now. Expect polishing
*/

#define WOUND_CRITICAL_BLUNT_DISMEMBER_BONUS 15

// Applied into wounds when they're scanned with the wound analyzer, halves time to treat them manually.
#define TRAIT_WOUND_SCANNED "wound_scanned"
// I dunno lol
#define ANALYZER_TRAIT "analyzer_trait"

/datum/wound
	/// What it's named
	var/name = "Wound"
	/// The description shown on the scanners
	var/desc = ""
	/// The basic treatment suggested by health analyzers
	var/treat_text = ""
	/// What the limb looks like on a cursory examine
	var/examine_desc = "is badly hurt"

	/// needed for "your arm has a compound fracture" vs "your arm has some third degree burns"
	var/a_or_from = "a"
	/// The visible message when this happens
	var/occur_text = ""
	/// This sound will be played upon the wound being applied
	var/sound_effect
	/// The volume of [sound_effect]
	var/sound_volume = 70

	/// Either WOUND_SEVERITY_TRIVIAL, WOUND_SEVERITY_MODERATE, WOUND_SEVERITY_SEVERE, WOUND_SEVERITY_CRITICAL, WOUND_SEVERITY_LOSS. FALSE prevents it from rolling.
	var/severity = FALSE

	/// What body zones can we NOT affect
	var/list/excluded_zones = list()
	/// Who owns the body part that we're wounding
	var/mob/living/carbon/victim = null
	/// The bodypart we're parented to. Not guaranteed to be non-null, especially after/during removal or if we haven't been applied
	var/obj/item/bodypart/limb = null

	/// Specific items such as bandages or sutures that can try directly treating this wound
	var/list/treatable_by
	/// Specific items such as bandages or sutures that can try directly treating this wound only if the user has the victim in an aggressive grab or higher
	var/list/treatable_by_grabbed
	/// Any tools with any of the flags in this list will be usable to try directly treating this wound
	var/list/treatable_tools
	/// How long it will take to treat this wound with a standard effective tool, assuming it doesn't need surgery
	var/base_treat_time = 3 SECONDS

	/// Using this limb in a do_after interaction will multiply the length by this duration (arms)
	var/interaction_efficiency_penalty = 1
	/// Incoming damage on this limb will be multiplied by this, to simulate tenderness and vulnerability (mostly burns).
	var/damage_mulitplier_penalty = 1
	/// The proportion of damage on this limb that cannot be healed until this wound is removed (0-1).
	var/limb_integrity_penalty = 0
	/// If set and this wound is applied to a leg, we take this many deciseconds extra per step on this leg
	var/limp_slowdown
	/// If this wound has a limp_slowdown and is applied to a leg, it has this chance to limp each step
	var/limp_chance
	/// How much we're contributing to this limb's bleed_rate
	var/blood_flow

	/// How much having this wound will add to all future check_wounding() rolls on this limb, to allow progression to worse injuries with repeated damage
	var/threshold_penalty
	/// How much having this wound will add to all future check_wounding() rolls on this limb, but only for wounds of its own series
	var/series_threshold_penalty = 0
	/// If we need to process each life tick
	var/processes = FALSE

	/// If having this wound makes currently makes the parent bodypart unusable
	var/disabling

	/// What status effect we assign on application
	var/status_effect_type
	/// The status effect we're linked to
	var/datum/status_effect/linked_status_effect
	/// If we're operating on this wound and it gets healed, we'll nix the surgery too
	var/datum/surgery/attached_surgery
	/// if you're a lazy git and just throw them in cryo, the wound will go away after accumulating severity * [base_regen_progress_to_qdel] power
	var/regen_progress

	/// The base amount of [regen_progress] required to have ourselves fully healed by cryo. Multiplied against severity.
	var/base_regen_progress_to_qdel = 33

	/// If we forced this wound through badmin smite, we won't count it towards the round totals
	var/from_smite

	/// The biological state required for this wound to be applied
	var/bio_state_required = BIO_BONE | BIO_FLESH
	/// What flags apply to this wound
	var/wound_flags = ACCEPTS_GAUZE

/datum/wound/Destroy()
	QDEL_NULL(attached_surgery)
	// destroy can call remove_wound() and remove_wound() calls qdel, so we check to make sure there's anything to remove first
	if(limb)
		remove_wound()
	return ..()

/**
 * apply_wound() is used once a wound type is instantiated to assign it to a bodypart, and actually come into play.
 *
 *
 * Arguments:
 * * L: The bodypart we're wounding, we don't care about the person, we can get them through the limb
 * * silent: Not actually necessary I don't think, was originally used for demoting wounds so they wouldn't make new messages, but I believe old_wound took over that, I may remove this shortly
 * * old_wound: If our new wound is a replacement for one of the same time (promotion or demotion), we can reference the old one just before it's removed to copy over necessary vars
 * * smited- If this is a smite, we don't care about this wound for stat tracking purposes (not yet implemented)
 * * attack_direction: For bloodsplatters, if relevant
 */
/datum/wound/proc/apply_wound(obj/item/bodypart/L, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, attack_direction = null)
	if(!can_be_applied_to(L, old_wound))
		qdel(src)
		return FALSE

	set_victim(L.owner)
	set_limb(L)
	LAZYADD(victim.all_wounds, src)
	LAZYADD(limb.wounds, src)
	limb.update_wounds()

	if(status_effect_type)
		linked_status_effect = victim.apply_status_effect(status_effect_type, src)
		RegisterSignal(linked_status_effect, COMSIG_QDELETING, PROC_REF(on_status_effect_remove))
	SEND_SIGNAL(victim, COMSIG_CARBON_GAIN_WOUND, src, limb)

	if(!victim.alerts["wound"]) // only one alert is shared between all of the wounds
		victim.throw_alert("wound", /atom/movable/screen/alert/status_effect/wound)

	var/demoted
	if(old_wound)
		demoted = (severity <= old_wound.severity)

	if(severity == WOUND_SEVERITY_TRIVIAL)
		return

	if(!silent && !demoted)
		var/msg = span_danger("[victim]'s [limb.name] [occur_text]!")
		var/vis_dist = COMBAT_MESSAGE_RANGE

		if(severity > WOUND_SEVERITY_MODERATE)
			msg = "<b>[msg]</b>"
			vis_dist = DEFAULT_MESSAGE_RANGE

		victim.visible_message(
			msg,
			span_userdanger("Your [limb.name] [occur_text]!"),
			vision_distance = vis_dist,
		)
		if(sound_effect)
			playsound(L.owner, sound_effect, sound_volume + (20 * severity), TRUE)

	wound_injury(old_wound, attack_direction = attack_direction)

	if(!demoted)
		second_wind()

	return TRUE

/// Returns TRUE if we can be applied to the limb.
/datum/wound/proc/can_be_applied_to(obj/item/bodypart/limb, datum/wound/old_wound)
	var/datum/wound_pregen_data/pregen_data = SSwounds.pregen_data[type]

	// We assume we aren't being randomly applied - we have no reason to believe we are
	// And, besides, if we were, you could just as easily check our pregen data rather than run this proc
	// Generally speaking this proc is called in apply_wound, which is called when the caller is already confidant in its ability to be applied
	return pregen_data.can_be_applied_to(limb, old_wound = old_wound)

/// Returns the zones we can be applied to.
/datum/wound/proc/get_excluded_zones()
	var/datum/wound_pregen_data/pregen_data = SSwounds.pregen_data[type]

	return pregen_data.excluded_zones

/// Returns the biostate we require to be applied.
/datum/wound/proc/get_required_biostate()
	var/datum/wound_pregen_data/pregen_data = SSwounds.pregen_data[type]

	return pregen_data.required_limb_biostate

/datum/wound/proc/null_victim()
	SIGNAL_HANDLER
	set_victim(null)

/// Setter for [victim]. Should completely transfer signals, attributes, etc. To the new victim - if there is any, as it can be null.
/datum/wound/proc/set_victim(new_victim)
	if(victim)
		UnregisterSignal(victim, COMSIG_QDELETING)

	remove_wound_from_victim()
	victim = new_victim
	if(victim)
		RegisterSignal(victim, COMSIG_QDELETING, PROC_REF(null_victim))

/// Proc called to change the variable `limb` and react to the event.
/datum/wound/proc/set_limb(obj/item/bodypart/new_value, replaced = FALSE)
	if(limb == new_value)
		return FALSE //Limb can either be a reference to something or `null`. Returning the number variable makes it clear no change was made.
	. = limb
	if(limb) // if we're nulling limb, we're basically detaching from it, so we should remove ourselves in that case
		UnregisterSignal(limb, COMSIG_QDELETING)
		if(wound_flags & ACCEPTS_GAUZE)
			UnregisterSignal(limb, list(COMSIG_BODYPART_GAUZED, COMSIG_BODYPART_GAUZE_DESTROYED))
		if(wound_flags & ACCEPTS_SPLINT)
			UnregisterSignal(limb, list(COMSIG_BODYPART_SPLINTED, COMSIG_BODYPART_SPLINT_DESTROYED))
		LAZYREMOVE(limb.wounds, src)
		limb.update_wounds(replaced)
		if (disabling)
			limb.remove_traits(list(TRAIT_PARALYSIS, TRAIT_DISABLED_BY_WOUND), REF(src))

	limb = new_value

	// POST-CHANGE

	if (limb)
		RegisterSignal(limb, COMSIG_QDELETING, PROC_REF(source_died))
		if(wound_flags & ACCEPTS_GAUZE)
			RegisterSignals(limb, list(COMSIG_BODYPART_GAUZED, COMSIG_BODYPART_GAUZE_DESTROYED), PROC_REF(gauze_state_changed))
		if(wound_flags & ACCEPTS_SPLINT)
			RegisterSignals(limb, list(COMSIG_BODYPART_SPLINTED, COMSIG_BODYPART_SPLINT_DESTROYED), PROC_REF(splint_state_changed))
		if (disabling)
			limb.add_traits(list(TRAIT_PARALYSIS, TRAIT_DISABLED_BY_WOUND), REF(src))

		if (victim)
			start_limping_if_we_should() // the status effect already handles removing itself

		update_inefficiencies()

/datum/wound/proc/start_limping_if_we_should()
	if ((limb.body_zone == BODY_ZONE_L_LEG || limb.body_zone == BODY_ZONE_R_LEG) && limp_slowdown > 0 && limp_chance > 0)
		victim.apply_status_effect(/datum/status_effect/limp)

/// Deletes the wound if its attached limb is deleted.
/datum/wound/proc/source_died()
	SIGNAL_HANDLER
	qdel(src)

/// Remove the wound from whatever it's afflicting, and cleans up whateverstatus effects it had or modifiers it had on interaction times. ignore_limb is used for detachments where we only want to forget the victim
/datum/wound/proc/remove_wound(ignore_limb, replaced = FALSE)
	//TODO: have better way to tell if we're getting removed without replacement (full heal)
	var/old_victim = victim
	var/old_limb = limb

	set_disabling(FALSE)

	if(victim)
		remove_wound_from_victim()

	if(limb && !ignore_limb)
		set_limb(null, replaced) // since we're removing limb's ref to us, we should do the same
		// if you want to keep the ref, do it externally, theres no reason for us to remember it

	if (ismob(old_victim))
		var/mob/mob_victim = old_victim
		SEND_SIGNAL(mob_victim, COMSIG_CARBON_POST_LOSE_WOUND, src, old_limb, ignore_limb, replaced)

/datum/wound/proc/remove_wound_from_victim()
	if(!victim)
		return
	LAZYREMOVE(victim.all_wounds, src)
	if(!victim.all_wounds)
		victim.clear_alert("wound")
	SEND_SIGNAL(victim, COMSIG_CARBON_LOSE_WOUND, src, limb)

/**
 * replace_wound() is used when you want to replace the current wound with a new wound, presumably of the same category, just of a different severity (either up or down counts)
 *
 * This proc actually instantiates the new wound based off the specific type path passed, then returns the new instantiated wound datum.
 *
 * Arguments:
 * * new_wound - The wound instance you want to replace this
 * * smited - If this is a smite, we don't care about this wound for stat tracking purposes (not yet implemented)
 */
/datum/wound/proc/replace_wound(datum/wound/new_wound, smited = FALSE, attack_direction = attack_direction)
	var/obj/item/bodypart/cached_limb = limb // remove_wound() nulls limb so we have to track it locally
	remove_wound(replaced = new_wound)
	new_wound.apply_wound(cached_limb, old_wound = src, smited = smited, attack_direction = attack_direction)
	. = new_wound
	qdel(src)

/// The immediate negative effects faced as a result of the wound
/datum/wound/proc/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	return

/// Proc called to change the variable `disabling` and react to the event.
/datum/wound/proc/set_disabling(new_value)
	if(disabling == new_value)
		return
	. = disabling
	disabling = new_value
	if(disabling)
		if(!. && limb) //Gained disabling.
			ADD_TRAIT(limb, TRAIT_PARALYSIS, REF(src))
			ADD_TRAIT(limb, TRAIT_DISABLED_BY_WOUND, REF(src))
	else if(. && limb) //Lost disabling.
		REMOVE_TRAIT(limb, TRAIT_PARALYSIS, REF(src))
		REMOVE_TRAIT(limb, TRAIT_DISABLED_BY_WOUND, REF(src))
	if(limb?.can_be_disabled)
		limb.update_disabled()

/// Setter for [interaction_efficiency_penalty]. Updates the actionspeed of our actionspeed mod.
/datum/wound/proc/set_interaction_efficiency_penalty(new_value)
	//var/should_update = (new_value != interaction_efficiency_penalty)

	interaction_efficiency_penalty = new_value

	/*if (should_update)
		update_actionspeed_modifier()*/

/// Returns a "adjusted" interaction_efficiency_penalty that will be used for the actionspeed mod.
/datum/wound/proc/get_effective_actionspeed_modifier()
	return interaction_efficiency_penalty - 1

/// Returns the decisecond multiplier of any click interactions, assuming our limb is being used.
/datum/wound/proc/get_action_delay_mult()
	SHOULD_BE_PURE(TRUE)

	return interaction_efficiency_penalty

/// Returns the decisecond increment of any click interactions, assuming our limb is being used.
/datum/wound/proc/get_action_delay_increment()
	SHOULD_BE_PURE(TRUE)

	return 0

/// Signal proc for if gauze has been applied or removed from our limb.
/datum/wound/proc/gauze_state_changed()
	SIGNAL_HANDLER

/// Signal proc for if a splint has been applied or removed from our limb.
/datum/wound/proc/splint_state_changed()
	SIGNAL_HANDLER

	if (wound_flags & ACCEPTS_SPLINT)
		update_inefficiencies()

/// Updates our limping and interaction penalties in accordance with our gauze.
/datum/wound/proc/update_inefficiencies()
	if (wound_flags & ACCEPTS_SPLINT)
		if(limb.body_zone in list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
			if(limb.current_splint?.splint_factor)
				limp_slowdown = initial(limp_slowdown) * limb.current_splint.splint_factor
				limp_chance = initial(limp_chance) * limb.current_splint.splint_factor
			else
				limp_slowdown = initial(limp_slowdown)
				limp_chance = initial(limp_chance)
		else if(limb.body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
			if(limb.current_splint?.splint_factor)
				set_interaction_efficiency_penalty(1 + ((get_effective_actionspeed_modifier()) * limb.current_splint.splint_factor))
			else
				set_interaction_efficiency_penalty(initial(interaction_efficiency_penalty))

		if(initial(disabling))
			set_disabling(!limb.current_splint)

	limb.update_wounds()

	start_limping_if_we_should()

/// Additional beneficial effects when the wound is gained, in case you want to give a temporary boost to allow the victim to try an escape or last stand
/datum/wound/proc/second_wind()
	switch(severity)
		if(WOUND_SEVERITY_MODERATE)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_MODERATE)
		if(WOUND_SEVERITY_SEVERE)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_SEVERE)
		if(WOUND_SEVERITY_CRITICAL)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_CRITICAL)
		if(WOUND_SEVERITY_LOSS)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_LOSS)

/// Handles unlinking the linked status effect on deletion.
/datum/wound/proc/on_status_effect_remove()
	SIGNAL_HANDLER
	UnregisterSignal(linked_status_effect, COMSIG_QDELETING)
	linked_status_effect = null

/**
 * try_treating() is an intercept run from [/mob/living/carbon/proc/attackby] right after surgeries but before anything else. Return TRUE here if the item is something that is relevant to treatment to take over the interaction.
 *
 * This proc leads into [/datum/wound/proc/treat] and probably shouldn't be added onto in children types. You can specify what items or tools you want to be intercepted
 * with var/list/treatable_by and var/treatable_tool, then if an item fulfills one of those requirements and our wound claims it first, it goes over to treat() and treat_self().
 *
 * Arguments:
 * * I: The item we're trying to use
 * * user: The mob trying to use it on us
 */
/datum/wound/proc/try_treating(obj/item/I, mob/user)
	// first we weed out if we're not dealing with our wound's bodypart, or if it might be an attack
	if(QDELETED(I) || limb.body_zone != user.zone_selected || (I.force && user.a_intent != INTENT_HELP))
		return FALSE

	if(!item_can_treat(I, user))
		return FALSE

	// now that we've determined we have a valid attempt at treating, we can stomp on their dreams if we're already interacting with the patient or if their part is obscured
	if(DOING_INTERACTION_WITH_TARGET(user, victim))
		to_chat(user, span_warning("You're already interacting with [victim]!"))
		return TRUE

	// next we check if the bodypart in actually accessible (not under thick clothing). We skip the species trait check since skellies
	// & such may need to use bone gel but may be wearing a space suit for..... whatever reason a skeleton would wear a space suit for
	if(ishuman(victim))
		var/mob/living/carbon/human/victim_human = victim
		if(!victim_human.try_inject(user, injection_flags = INJECT_CHECK_IGNORE_SPECIES | INJECT_TRY_SHOW_ERROR_MESSAGE))
			return TRUE

	// lastly, treat them
	return treat(I, user) // we allow treat to return a value so it can control if the item does its normal interaction or not

/// Returns TRUE if the item can be used to treat our wounds. Hooks into treat() - only things that return TRUE here may be used there.
/datum/wound/proc/item_can_treat(obj/item/potential_treater, mob/user)
	// check if we have a valid treatable tool
	if(potential_treater.tool_behaviour in treatable_tools)
		return TRUE
	if((TOOL_CAUTERY in treatable_tools) && potential_treater.get_temperature() && user == victim) // allow improvised cauterization on yourself without an aggro grab
		return TRUE
	// failing that, see if we're aggro grabbing them and if we have an item that works for aggro grabs only
	if(user.pulling == victim && user.grab_state >= GRAB_AGGRESSIVE && check_grab_treatments(potential_treater, user))
		return TRUE
	// failing THAT, we check if we have a generally allowed item
	for(var/allowed_type in treatable_by)
		if(istype(potential_treater, allowed_type))
			return TRUE
	return FALSE

/// Return TRUE if we have an item that can only be used while aggro grabbed (unhanded aggro grab treatments go in [/datum/wound/proc/try_handling]). Treatment is still is handled in [/datum/wound/proc/treat]
/datum/wound/proc/check_grab_treatments(obj/item/I, mob/user)
	return FALSE

/// Like try_treating() but for unhanded interactions from humans, used by joint dislocations for manual bodypart chiropractice for example. Ignores thick material checks since you can pop an arm into place through a thick suit unlike using sutures
/datum/wound/proc/try_handling(mob/living/carbon/human/user, list/modifiers)
	return FALSE

/// Someone is using something that might be used for treating the wound on this limb
/datum/wound/proc/treat(obj/item/I, mob/user)
	return

/// If var/processing is TRUE, this is run on each life tick
/datum/wound/proc/handle_process()
	return

/// For use in do_after callback checks
/datum/wound/proc/still_exists()
	return (!QDELETED(src) && limb)

/// When our parent bodypart is hurt
/datum/wound/proc/receive_damage(list/wounding_types, total_wound_dmg, wound_bonus, attack_direction, damage_source)
	return

/// Called from cryoxadone and pyroxadone when they're proc'ing. Wounds will slowly be fixed separately from other methods when these are in effect. crappy name but eh
/datum/wound/proc/on_xadone(power)
	regen_progress += power
	return handle_regen_progress()

/// Does various actions based on [regen_progress]. By default, qdeletes the wound past a certain threshold.
/datum/wound/proc/handle_regen_progress()
	if(regen_progress > get_regen_progress_to_qdel())
		qdel(src)

/// Returns the amount of [regen_progress] we need to be qdeleted.
/datum/wound/proc/get_regen_progress_to_qdel()
	SHOULD_BE_PURE(TRUE)

	return base_regen_progress_to_qdel * severity

/// When synthflesh is applied to the victim, we call this. No sense in setting up an entire chem reaction system for wounds when we only care for a few chems. Probably will change in the future
/datum/wound/proc/on_synthflesh(power)
	return

/// When silfrine is applied to the victim, we call this.
/datum/wound/proc/on_silfrine(power)
	return

/// When ysiltane/alvitane/quardextane is applied to the victim, we call this.
/datum/wound/proc/on_tane(power)
	return

/// Applied on crystal reagent application
/datum/wound/proc/on_crystal(power)
	return

/// Applied on rezadone application
/datum/wound/proc/on_rezadone(power)
	return

/// Called when the patient is undergoing stasis, so that having fully treated a wound doesn't make you sit there helplessly until you think to unbuckle them
/datum/wound/proc/on_stasis()
	return

/// Used when we're being dragged while bleeding, the value we return is how much bloodloss this wound causes from being dragged. Since it's a proc, you can let bandages soak some of the blood
/datum/wound/proc/drag_bleed_amount()
	return

/**
 * get_bleed_rate_of_change() is used in [/mob/living/carbon/proc/bleed_warn] to gauge whether this wound (if bleeding) is becoming worse, better, or staying the same over time
 *
 * Returns BLOOD_FLOW_STEADY if we're not bleeding or there's no change (like piercing), BLOOD_FLOW_DECREASING if we're clotting (non-critical slashes, gauzed, coagulant, etc), BLOOD_FLOW_INCREASING if we're opening up (crit slashes/heparin)
 */
/datum/wound/proc/get_bleed_rate_of_change()
	if(blood_flow && HAS_TRAIT(victim, TRAIT_BLOODY_MESS))
		return BLOOD_FLOW_INCREASING
	return BLOOD_FLOW_STEADY

/**
 * get_examine_description() is used in carbon/examine and human/examine to show the status of this wound. Useful if you need to show some status like the wound being splinted or bandaged.
 *
 * Return the full string line you want to show, note that we're already dealing with the 'warning' span at this point, and that \n is already appended for you in the place this is called from
 *
 * Arguments:
 * * mob/user: The user examining the wound's owner, if that matters
 */
/datum/wound/proc/get_examine_description(mob/user)
	var/desc

	if((wound_flags & ACCEPTS_SPLINT) && limb.current_splint)
		desc = "[victim.p_their()] [limb.name] is [get_sling_condition()] fastened with a [limb.current_splint.name]"
	else if ((wound_flags & ACCEPTS_GAUZE) && limb.current_gauze)
		desc = "[victim.p_their()] [limb.name] is [get_gauze_condition()] fastened in a sling of [limb.current_gauze.name]"
	else
		desc = "[victim.p_their()] [limb.name] [examine_desc]"

	desc = modify_desc_before_span(desc, user)

	return get_desc_intensity(desc)

/// A hook proc used to modify desc before it is spanned via [get_desc_intensity]. Useful for inserting spans yourself.
/datum/wound/proc/modify_desc_before_span(desc, mob/user)
	return desc

/datum/wound/proc/get_gauze_condition()
	SHOULD_BE_PURE(TRUE)
	if (!limb.current_gauze)
		return null

	switch(limb.current_gauze.absorption_capacity)
		if(0 to 1.25)
			return "just barely"
		if(1.25 to 2.75)
			return "loosely"
		if(2.75 to 4)
			return "mostly"
		if(4 to INFINITY)
			return "tightly"

/datum/wound/proc/get_sling_condition()
	SHOULD_BE_PURE(TRUE)
	if (!limb.current_splint)
		return null

	switch(limb.current_splint.sling_condition)
		if(0 to 1.25)
			return "just barely"
		if(1.25 to 2.75)
			return "loosely"
		if(2.75 to 4)
			return "mostly"
		if(4 to INFINITY)
			return "tightly"

/// Spans [desc] based on our severity.
/datum/wound/proc/get_desc_intensity(desc)
	SHOULD_BE_PURE(TRUE)
	if (severity > WOUND_SEVERITY_MODERATE)
		return span_bold("[desc]!")
	return "[desc]."

/datum/wound/proc/get_scanner_description(mob/user)
	return "Type: [name]\nSeverity: [severity_text()]\nDescription: [desc]\nRecommended Treatment: [treat_text]"

/datum/wound/proc/severity_text()
	switch(severity)
		if(WOUND_SEVERITY_TRIVIAL)
			return "Trivial"
		if(WOUND_SEVERITY_MODERATE)
			return "Moderate"
		if(WOUND_SEVERITY_SEVERE)
			return "Severe"
		if(WOUND_SEVERITY_CRITICAL)
			return "Critical"

/// Returns TRUE if our limb is the head or chest, FALSE otherwise.
/// Essential in the sense of "we cannot live without it".
/datum/wound/proc/limb_essential()
	var/obj/item/organ/brain/victim_brain = victim?.getorganslot(ORGAN_SLOT_BRAIN)
	if(victim_brain && limb.body_zone == victim_brain.zone) // IPCs don't need their head to live
		return TRUE
	return (limb.body_zone == BODY_ZONE_CHEST)

/// Whether we should show an interactable topic in examines of the wound. href_list["wound_topic"]
/datum/wound/proc/show_wound_topic(mob/user)
	return FALSE

/// Gets the name of the wound with any interactable topic if possible
/datum/wound/proc/get_topic_name(mob/user)
	return show_wound_topic(user) ? "<a href='?src=[REF(src)];wound_topic=1'>[lowertext(name)]</a>" : lowertext(name)

/// Gets the flat percentage chance increment of a dismember occuring, if a dismember is attempted (requires mangled flesh and bone). returning 15 = +15%.
/datum/wound/proc/get_dismember_chance_bonus(existing_chance)
	SHOULD_BE_PURE(TRUE)

	var/datum/wound_pregen_data/pregen_data = get_pregen_data()
	if((WOUND_BLUNT in pregen_data.required_wounding_types) && severity >= WOUND_SEVERITY_CRITICAL)
		return WOUND_CRITICAL_BLUNT_DISMEMBER_BONUS // we only require mangled bone (T2 blunt), but if there's a critical blunt, we'll add 15% more

/// Returns our pregen data, which is practically guaranteed to exist, so this proc can safely be used raw.
/// In fact, since it's RETURN_TYPEd to wound_pregen_data, you can even directly access the variables without having to store the value of this proc in a typed variable.
/// Ex. get_pregen_data().wound_series
/datum/wound/proc/get_pregen_data()
	RETURN_TYPE(/datum/wound_pregen_data)

	return SSwounds.pregen_data[type]

#undef WOUND_CRITICAL_BLUNT_DISMEMBER_BONUS
