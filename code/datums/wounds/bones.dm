/*
	Blunt/Bone wounds
*/

/datum/wound/blunt
	name = "Blunt (Bone) Wound"
	sound_effect = 'sound/effects/wounds/crack1.ogg'
	wound_type = WOUND_BLUNT
	wound_flags = (BONE_WOUND | ACCEPTS_SPLINT)

	///Have we been bone gel'd?
	var/gelled
	///Have we been taped?
	var/taped
	///If we did the gel + surgical tape healing method for fractures, how many ticks does it take to heal by default
	var/regen_ticks_needed
	///Our current counter for gel + surgical tape regeneration
	var/regen_ticks_current
	///If we suffer severe head booboos, we can get brain traumas tied to them
	var/datum/brain_trauma/active_trauma
	///What brain trauma group, if any, we can draw from for head wounds
	var/brain_trauma_group
	///If we deal brain traumas, when is the next one due?
	var/next_trauma_cycle
	///How long do we wait +/- 20% for the next trauma?
	var/trauma_cycle_cooldown
	///If this is a chest wound and this is set, we have this chance to cough up blood when hit in the chest
	var/internal_bleeding_chance = 0

/*
	Overwriting of base procs
*/
/datum/wound/blunt/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	// hook into gaining/losing gauze so crit bone wounds can re-enable/disable depending if they're slung or not
	RegisterSignals(limb, list(COMSIG_BODYPART_SPLINTED, COMSIG_BODYPART_SPLINT_DESTROYED), PROC_REF(update_inefficiencies))

	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group)
		processes = TRUE
		active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100 - WOUND_BONE_HEAD_TIME_VARIANCE, 100 + WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	RegisterSignal(victim, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, PROC_REF(attack_with_hurt_hand))
	if(limb.held_index && victim.get_item_for_held_index(limb.held_index) && (disabling || prob(30 * severity)))
		var/obj/item/I = victim.get_item_for_held_index(limb.held_index)
		if(istype(I, /obj/item/offhand))
			I = victim.get_inactive_held_item()

		if(I && victim.dropItemToGround(I))
			victim.visible_message(
				span_danger("[victim] drops [I] in shock!"),
				span_userdanger("The force on your [limb.name] causes you to drop [I]!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)

	update_inefficiencies()

/datum/wound/blunt/remove_wound(ignore_limb, replaced)
	limp_slowdown = 0
	limp_chance = 0
	QDEL_NULL(active_trauma)
	if(limb)
		UnregisterSignal(limb, list(COMSIG_BODYPART_GAUZED, COMSIG_BODYPART_GAUZE_DESTROYED))
	if(victim)
		UnregisterSignal(victim, COMSIG_HUMAN_EARLY_UNARMED_ATTACK)
	return ..()

/datum/wound/blunt/handle_process(delta_time, times_fired)
	. = ..()
	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group && world.time > next_trauma_cycle)
		if(active_trauma)
			QDEL_NULL(active_trauma)
		else
			active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	var/is_bone_creature = victim.get_biological_state() == BIO_JUST_BONE
	if(!gelled || (!taped && !is_bone_creature))
		return

	regen_ticks_current++
	if(victim.body_position == LYING_DOWN)
		if(prob(30))
			regen_ticks_current += 1
		if(victim.IsSleeping() && prob(30))
			regen_ticks_current += 1

	if(regen_ticks_current > regen_ticks_needed)
		if(!victim || !limb)
			qdel(src)
			return
		to_chat(victim, span_green("Your [limb.name] has recovered from its [name]!"))
		remove_wound()

/// If we're a human who's punching something with a broken arm, we might hurt ourselves doing so
/datum/wound/blunt/proc/attack_with_hurt_hand(mob/M, atom/target, proximity)
	SIGNAL_HANDLER

	if(victim.get_active_hand() != limb || victim.a_intent == INTENT_HELP || !ismob(target) || severity <= WOUND_SEVERITY_MODERATE)
		return

	// With a severe or critical wound, you have a 15% or 30% chance to proc pain on hit
	if(prob((severity - 1) * 15))
		// And you have a 70% or 50% chance to actually land the blow, respectively
		if(prob(70 - 20 * (severity - 1)))
			if(!HAS_TRAIT(M, TRAIT_ANALGESIA))
				to_chat(victim, span_userdanger("The fracture in your [limb.name] shoots with pain as you strike [target]!"))
			limb.receive_damage(brute = rand(1,2))
		else
			victim.visible_message(
				span_danger("[victim] weakly strikes [target] with [victim.p_their()] broken [limb.name], recoiling from pain!"),
				span_userdanger("You fail to strike [target] as the fracture in your [limb.name] lights up in unbearable pain!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)
			INVOKE_ASYNC(victim, TYPE_PROC_REF(/mob, emote), "scream")
			victim.Stun(0.5 SECONDS)
			limb.receive_damage(brute = rand(1,2))
			return COMPONENT_NO_ATTACK_HAND


/datum/wound/blunt/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(!victim || wounding_dmg < WOUND_MINIMUM_DAMAGE)
		return
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(NOBLOOD in human_victim.dna?.species.species_traits)
			return

	if(limb.body_zone == BODY_ZONE_CHEST && victim.blood_volume && prob(internal_bleeding_chance + wounding_dmg))
		var/blood_bled = rand(1, wounding_dmg * (severity == WOUND_SEVERITY_CRITICAL ? 2 : 1.5)) // 12 brute toolbox can cause up to 18/24 bleeding with a severe/critical chest wound
		switch(blood_bled)
			if(1 to 6)
				victim.bleed(blood_bled, TRUE)
			if(7 to 13)
				victim.visible_message(
					span_danger("[victim] coughs up a bit of blood from the blow to [victim.p_their()] chest."),
					span_userdanger("You cough up a bit of blood from the blow to your chest."),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
				victim.visible_message(
					span_danger("[victim] spits out a string of blood from the blow to [victim.p_their()] chest!"),
					span_userdanger("You spit out a string of blood from the blow to your chest!"),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
				victim.visible_message(
					span_danger("[victim] chokes up a spray of blood from the blow to [victim.p_their()] chest!"),
					span_userdanger("You choke up on a spray of blood from the blow to your chest!"),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				victim.bleed(blood_bled)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.add_splatter_floor(get_step(victim.loc, victim.dir))


/datum/wound/blunt/get_examine_description(mob/user)
	if(!limb.current_splint && !gelled && !taped)
		return ..()

	var/list/msg = list()
	if(!limb.current_splint)
		msg += "[victim.p_their(TRUE)] [limb.name] [examine_desc]"
	else
		var/sling_condition = ""
		// how much life we have left in these bandages
		switch(limb.current_splint.sling_condition)
			if(0 to 1.25)
				sling_condition = "just barely"
			if(1.25 to 2.75)
				sling_condition = "loosely"
			if(2.75 to 4)
				sling_condition = "mostly"
			if(4 to INFINITY)
				sling_condition = "tightly"

		msg += "[victim.p_their(TRUE)] [limb.name] is [sling_condition] fastened with a [limb.current_splint.name]"

	if(taped)
		msg += ", <span class='notice'>and appears to be reforming itself under some surgical tape!</span>"
	else if(gelled)
		msg += ", <span class='notice'>with fizzing flecks of blue bone gel sparking off the bone!</span>"
	else
		msg +=  "!"
	return "<B>[msg.Join()]</B>"

/*
	New common procs for /datum/wound/blunt/
*/

/datum/wound/blunt/proc/update_inefficiencies()
	SIGNAL_HANDLER

	if(limb.body_zone in list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(limb.current_splint?.splint_factor)
			limp_slowdown = initial(limp_slowdown) * limb.current_splint.splint_factor
			limp_chance = initial(limp_chance) * limb.current_splint.splint_factor
		else
			limp_slowdown = initial(limp_slowdown)
			limp_chance = initial(limp_chance)
		victim.apply_status_effect(STATUS_EFFECT_LIMP)

	else if(limb.body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		if(limb.current_splint?.splint_factor)
			interaction_efficiency_penalty = 1 + ((interaction_efficiency_penalty - 1) * limb.current_splint.splint_factor)
		else
			interaction_efficiency_penalty = interaction_efficiency_penalty
			interaction_efficiency_penalty = initial(interaction_efficiency_penalty)

	if(initial(disabling))
		if(limb.current_splint && limb.current_splint.helps_disabled)
			set_disabling(FALSE)
		else
			set_disabling(TRUE)

	limb.update_wounds()

/// Joint Dislocation (Moderate Blunt)
/datum/wound/blunt/moderate
	name = "Joint Dislocation"
	desc = "Patient's bone has been unset from socket, causing pain and reduced motor function."
	treat_text = "Recommended application of bonesetter to affected limb, though manual relocation by applying an aggressive grab to the patient and helpfully interacting with afflicted limb may suffice."
	examine_desc = "is awkwardly janked out of place"
	occur_text = "janks violently and becomes unseated"
	severity = WOUND_SEVERITY_MODERATE
	viable_zones = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	interaction_efficiency_penalty = 1.2
	limp_slowdown = 2.25
	limp_chance = 50
	threshold_minimum = 35
	threshold_penalty = 15
	treatable_tool = TOOL_BONESET
	wound_flags = (BONE_WOUND)
	status_effect_type = /datum/status_effect/wound/blunt/moderate

/datum/wound/blunt/moderate/Destroy()
	if(victim)
		UnregisterSignal(victim, COMSIG_LIVING_DOORCRUSHED)
	return ..()

/datum/wound/blunt/moderate/wound_injury(datum/wound/old_wound, attack_direction = null)
	. = ..()
	RegisterSignal(victim, COMSIG_LIVING_DOORCRUSHED, PROC_REF(door_crush))

/// Getting smushed in an airlock/firelock is a last-ditch attempt to try relocating your limb
/datum/wound/blunt/moderate/proc/door_crush()
	if(prob(40))
		victim.visible_message(
			span_danger("[victim]'s dislocated [limb.name] pops back into place!"),
			span_userdanger("Your dislocated [limb.name] pops back into place!"),
		)
		remove_wound()

/datum/wound/blunt/moderate/try_handling(mob/living/carbon/human/user)
	if(user.pulling != victim || user.zone_selected != limb.body_zone || user.a_intent == INTENT_GRAB)
		return FALSE

	if(user.grab_state == GRAB_PASSIVE)
		to_chat(user, span_warning("You must have [victim] in an aggressive grab to manipulate [victim.p_their()] [lowertext(name)]!"))
		return TRUE

	if(user.grab_state >= GRAB_AGGRESSIVE)
		user.visible_message(
			span_danger("[user] begins twisting and straining [victim]'s dislocated [limb.name]!"),
			span_notice("You begin twisting and straining [victim]'s dislocated [limb.name]..."),
			ignored_mobs = victim,
		)
		to_chat(victim, span_userdanger("[user] begins twisting and straining your dislocated [limb.name]!"))

		if(user.a_intent == INTENT_HELP)
			chiropractice(user)
		else
			malpractice(user)
		return TRUE

/// If someone is snapping our dislocated joint back into place by hand with an aggro grab and help intent
/datum/wound/blunt/moderate/proc/chiropractice(mob/living/carbon/human/user)
	var/time = base_treat_time
	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	if(prob(65))
		user.visible_message(
			span_danger("[user] snaps [victim]'s dislocated [limb.name] back into place!"),
			span_notice("You snap [victim]'s dislocated [limb.name] back into place!"),
			ignored_mobs = victim,
		)
		to_chat(victim, span_userdanger("[user] snaps your dislocated [limb.name] back into place!"))
		victim.force_pain_noise(80)
		limb.receive_damage(brute = 5, wound_bonus = CANT_WOUND)
		qdel(src)
	else
		user.visible_message(
			span_danger("[user] wrenches [victim]'s dislocated [limb.name] around painfully!"),
			span_danger("You wrench [victim]'s dislocated [limb.name] around painfully!"),
			ignored_mobs = victim,
		)
		to_chat(victim, span_userdanger("[user] wrenches your dislocated [limb.name] around painfully!"))
		limb.receive_damage(brute = 10, wound_bonus = CANT_WOUND)
		chiropractice(user)

/// If someone is snapping our dislocated joint into a fracture by hand with an aggro grab and harm or disarm intent
/datum/wound/blunt/moderate/proc/malpractice(mob/living/carbon/human/user)
	var/time = base_treat_time

	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	if(prob(65))
		user.visible_message(
			span_danger("[user] snaps [victim]'s dislocated [limb.name] with a sickening crack!"),
			span_danger("You snap [victim]'s dislocated [limb.name] with a sickening crack!"),
			ignored_mobs = victim,
		)
		to_chat(victim, span_userdanger("[user] snaps your dislocated [limb.name] with a sickening crack!"))
		victim.force_pain_noise(100)
		limb.receive_damage(brute = 20, wound_bonus = 40)
	else
		user.visible_message(
			span_danger("[user] wrenches [victim]'s dislocated [limb.name] around painfully!"),
			span_danger("You wrench [victim]'s dislocated [limb.name] around painfully!"),
			ignored_mobs = victim,
		)
		to_chat(victim, span_userdanger("[user] wrenches your dislocated [limb.name] around painfully!"))
		limb.receive_damage(brute = 10, wound_bonus = 10)
		malpractice(user)

/datum/wound/blunt/moderate/treat(obj/item/I, mob/user)
	if(victim == user)
		victim.visible_message(
			span_danger("[user] begins resetting [victim.p_their()] [limb.name] with [I]."),
			span_warning("You begin resetting your [limb.name] with [I]..."),
		)
	else
		user.visible_message(
			span_danger("[user] begins resetting [victim]'s [limb.name] with [I]."),
			span_notice("You begin resetting [victim]'s [limb.name] with [I]..."),
		)

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	if(victim == user)
		limb.receive_damage(brute = 5, wound_bonus = CANT_WOUND)
		victim.visible_message(
			span_danger("[user] finishes resetting [victim.p_their()] [limb.name]!"),
			span_userdanger("You reset your [limb.name]!"),
		)
	else
		limb.receive_damage(brute = 5, wound_bonus = CANT_WOUND)
		user.visible_message(
			span_danger("[user] finishes resetting [victim]'s [limb.name]!"),
			span_nicegreen("You finish resetting [victim]'s [limb.name]!"),
			ignored_mobs = victim,
		)
		to_chat(victim, span_userdanger("[user] resets your [limb.name]!"))

	qdel(src)

/*
	Severe (Hairline Fracture)
*/
/datum/wound/blunt/severe
	name = "Hairline Fracture"
	desc = "Patient's bone has suffered a crack in the foundation, causing serious pain and reduced limb functionality."
	treat_text = "Recommended light surgical application of bone gel, though a sling of medical gauze will prevent worsening situation."
	examine_desc = "appears grotesquely swollen, jagged bumps hinting at chips in the bone"
	occur_text = "sprays chips of bone and develops a nasty looking bruise"

	severity = WOUND_SEVERITY_SEVERE
	interaction_efficiency_penalty = 2
	limp_slowdown = 6
	limp_chance = 60
	threshold_minimum = 70
	threshold_penalty = 30
	treatable_by = list(/obj/item/stack/sticky_tape/surgical, /obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/severe
	brain_trauma_group = BRAIN_TRAUMA_MILD
	trauma_cycle_cooldown = 5 MINUTES
	internal_bleeding_chance = 40
	wound_flags = (BONE_WOUND | ACCEPTS_SPLINT | MANGLES_BONE)
	regen_ticks_needed = 120 // ticks every 2 seconds, 240 seconds, so roughly 4 minutes default

/// Compound Fracture (Critical Blunt)
/datum/wound/blunt/critical
	name = "Compound Fracture"
	desc = "Patient's bones have suffered multiple gruesome fractures, causing significant pain and near uselessness of limb."
	treat_text = "Immediate binding of affected limb, followed by surgical intervention ASAP."
	examine_desc = "is thoroughly pulped and cracked, exposing shards of bone to open air"
	occur_text = "cracks apart, exposing broken bones to open air"

	severity = WOUND_SEVERITY_CRITICAL
	interaction_efficiency_penalty = 2.5
	limp_slowdown = 7
	limp_chance = 70
	limp_slowdown = 9
	sound_effect = 'sound/effects/wounds/crack2.ogg'
	threshold_minimum = 115
	threshold_penalty = 50
	disabling = TRUE
	treatable_by = list(/obj/item/stack/sticky_tape/surgical, /obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/critical
	brain_trauma_group = BRAIN_TRAUMA_SEVERE
	trauma_cycle_cooldown = 5 MINUTES
	internal_bleeding_chance = 60
	wound_flags = (BONE_WOUND | ACCEPTS_SPLINT | MANGLES_BONE)
	regen_ticks_needed = 240 // ticks every 2 seconds, 480 seconds, so roughly 8 minutes default

// doesn't make much sense for "a" bone to stick out of your head
/datum/wound/blunt/critical/apply_wound(obj/item/bodypart/L, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, attack_direction = null)
	if(L.body_zone == BODY_ZONE_HEAD)
		occur_text = "splits open, exposing a bare, cracked skull through the flesh and blood"
		examine_desc = "has an unsettling indent, with bits of skull poking out"
	. = ..()

/// if someone is using bone gel on our wound
/datum/wound/blunt/proc/gel(obj/item/stack/medical/bone_gel/I, mob/user)
	// skellies get treated nicer with bone gel since their "reattach dismembered limbs by hand" ability sucks when it's still critically wounded
	// i hate you
	if(gelled)
		to_chat(user, span_warning("[user == victim ? "Your" : "[victim]'s"] [limb.name] is already coated with bone gel!"))
		return

	user.visible_message(
		span_danger("[user] begins hastily applying [I] to [victim]'s' [limb.name]..."),
		span_warning("You begin hastily applying [I] to [user == victim ? "your" : "[victim]'s"] [limb.name]."),
	)

	if(!do_after(user, base_treat_time * 1.5 * (user == victim ? 1.5 : 1), target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	I.use(1)
	victim.force_pain_noise(60)
	if(user != victim)
		user.visible_message(
			span_notice("[user] finishes applying [I] to [victim]'s [limb.name], giving off a wet fizzle."),
			span_notice("You finish applying [I] to [victim]'s [limb.name]!"),
			span_notice("You hear a wet fizzling sound."),
			ignored_mobs = victim,
		)
		to_chat(victim, span_userdanger("[user] finishes applying [I] to your [limb.name], your bones coursing with pain!"))
	else
		var/painkiller_bonus = 0
		if(victim.get_drunk_amount() > 10)
			painkiller_bonus += 10
		if(victim.reagents.has_reagent(/datum/reagent/medicine/morphine))
			painkiller_bonus += 20
		if(victim.reagents.has_reagent(/datum/reagent/determination))
			painkiller_bonus += 10
		if(victim.reagents.has_reagent(/datum/reagent/consumable/ethanol/painkiller))
			painkiller_bonus += 15
		if(victim.reagents.has_reagent(/datum/reagent/medicine/mine_salve))
			painkiller_bonus += 20

		if(prob(15 + (10 * (severity - 2)) - painkiller_bonus))
			victim.visible_message(
				span_danger("[victim] fails to finish applying [I] to [victim.p_their()] [limb.name], passing out from the pain!"),
				span_notice("You pass out from the pain of applying [I] to your [limb.name] before you can finish!"),
			)
			victim.AdjustUnconscious(5 SECONDS)
			return
		victim.visible_message(
			span_notice("[victim] finishes applying [I] to [victim.p_their()] [limb.name], grimacing from the pain!"),
			span_notice("You finish applying [I] to your [limb.name], and your bones explode in pain!"),
		)

	limb.receive_damage(25, stamina = 100, wound_bonus = CANT_WOUND)
	gelled = TRUE
	processes = TRUE

/// if someone is using surgical tape on our wound
/datum/wound/blunt/proc/tape(obj/item/stack/sticky_tape/surgical/I, mob/user)
	if(!gelled)
		to_chat(user, span_warning("[user == victim ? "Your" : "[victim]'s"] [limb.name] must be coated with bone gel to perform this emergency operation!"))
		return
	if(taped)
		to_chat(user, span_warning("[user == victim ? "Your" : "[victim]'s"] [limb.name] is already wrapped in [I.name]."))
		return

	user.visible_message(
		span_danger("[user] begins applying [I] to [victim]'s' [limb.name]..."),
		span_warning("You begin applying [I] to [user == victim ? "your" : "[victim]'s"] [limb.name]..."),
	)

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	if(victim == user)
		regen_ticks_needed *= 1.5

	I.use(1)
	if(user != victim)
		user.visible_message(
			span_notice("[user] finishes applying [I] to [victim]'s [limb.name]."),
			span_notice("You finish applying [I] to [victim]'s [limb.name]."),
			ignored_mobs = victim,
		)
		to_chat(victim, span_green("[user] finishes applying [I] to your [limb.name]."))
	else
		victim.visible_message(
			span_notice("[victim] finishes applying [I] to [victim.p_their()] [limb.name]."),
			span_green("You finish applying [I] to your [limb.name]."),
		)

	taped = TRUE
	processes = TRUE

/datum/wound/blunt/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/medical/bone_gel))
		gel(I, user)
	else if(istype(I, /obj/item/stack/sticky_tape/surgical))
		tape(I, user)

/datum/wound/blunt/get_scanner_description(mob/user)
	. = ..()

	. += "<div class='ml-3'>"

	if(severity > WOUND_SEVERITY_MODERATE)
		if(victim.get_biological_state() == BIO_JUST_BONE)
			if(!gelled)
				. += "Recommended Treatment: Apply bone gel directly to injured limb. Creatures of pure bone don't seem to mind bone gel application nearly as much as fleshed individuals. Surgical tape will also be unnecessary.\n"
			else
				. += "<span class='notice'>Note: Bone regeneration in effect. Bone is [round(regen_ticks_current*100/regen_ticks_needed)]% regenerated.</span>\n"
		else
			if(!gelled)
				. += "Alternative Treatment: Apply bone gel directly to injured limb, then apply surgical tape to begin bone regeneration. This is both excruciatingly painful and slow, and only recommended in dire circumstances.\n"
			else if(!taped)
				. += "<span class='notice'>Continue Alternative Treatment: Apply surgical tape directly to injured limb to begin bone regeneration. Note, this is both excruciatingly painful and slow, though sleep or laying down will speed recovery.</span>\n"
			else
				. += "<span class='notice'>Note: Bone regeneration in effect. Bone is [round(regen_ticks_current*100/regen_ticks_needed)]% regenerated.</span>\n"

	if(limb.body_zone == BODY_ZONE_HEAD)
		. += "Cranial Trauma Detected: Patient will suffer random bouts of [severity == WOUND_SEVERITY_SEVERE ? "mild" : "severe"] brain traumas until bone is repaired."
	else if(limb.body_zone == BODY_ZONE_CHEST && victim.blood_volume)
		. += "Ribcage Trauma Detected: Further trauma to chest is likely to worsen internal bleeding until bone is repaired."
	. += "</div>"
