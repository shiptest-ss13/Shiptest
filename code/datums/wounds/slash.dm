/*
	Slashing wounds
*/

/datum/wound/slash
	name = "Slashing (Cut) Wound"
	sound_effect = 'sound/weapons/slice.ogg'

/datum/wound_pregen_data/flesh_slash
	abstract = TRUE

	required_wounding_types = list(WOUND_SLASH)
	required_limb_biostate = BIO_FLESH

	wound_series = WOUND_SERIES_FLESH_SLASH_BLEED

/datum/wound/slash/flesh
	name = "Slashing (Cut) Flesh Wound"
	sound_effect = 'sound/weapons/slice.ogg'
	processes = TRUE
	treatable_by = list(/obj/item/stack/medical/suture)
	treatable_by_grabbed = list(/obj/item/gun/energy/laser)
	treatable_tools = list(TOOL_CAUTERY)
	base_treat_time = 3 SECONDS
	wound_flags = ACCEPTS_GAUZE | CAN_BE_GRASPED

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// When we have less than this amount of flow, either from treatment or clotting, we demote to a lower cut or are healed of the wound
	var/minimum_flow
	/// How much our blood_flow will naturally decrease per second, not only do larger cuts bleed more blood faster, they clot slower (higher number = clot quicker, negative = opening up)
	var/clot_rate
	/// Once the blood flow drops below minimum_flow, we demote it to this type of wound. If there's none, we're all better
	var/demotes_to
	/// The maximum flow we've had so far
	var/highest_flow

/datum/wound/slash/flesh/show_wound_topic(mob/user)
	return (user == victim && blood_flow)

/datum/wound/slash/flesh/Topic(href, href_list)
	. = ..()
	if(href_list["wound_topic"])
		if(!usr == victim)
			return
		victim.self_grasp_bleeding_limb(limb)

/datum/wound/slash/flesh/wound_injury(datum/wound/slash/flesh/old_wound = null, attack_direction = null)
	blood_flow = initial_flow

	if(old_wound)
		blood_flow = max(old_wound.blood_flow, initial_flow)

	else if(limb.can_bleed() && attack_direction && victim.blood_volume > BLOOD_VOLUME_OKAY)
		victim.spray_blood(attack_direction, severity)

/datum/wound/slash/flesh/get_examine_description(mob/user)
	if(!limb.current_gauze)
		return ..()

	var/list/msg = list("The cuts on [victim.p_their()] [limb.name] are wrapped with ")
	// how much life we have left in these bandages
	switch(limb.current_gauze.absorption_capacity)
		if(0 to 2)
			desc = "nearly ruined"
		if(2 to 4)
			desc = "badly worn"
		if(4 to 6)
			desc = "slightly used"
		if(6 to INFINITY)
			desc = "clean"
	msg += " [limb.current_gauze.name]!"

	return "<B>[msg.Join()]</B>"

/datum/wound/slash/flesh/receive_damage(list/wounding_types, total_wound_dmg, wound_bonus)
	if(!victim) // if we are dismembered, we can still take damage, its fine to check here
		return

	if(victim.stat != DEAD && wound_bonus != CANT_WOUND && wounding_types[WOUND_SLASH] < WOUND_MINIMUM_DAMAGE) // can't stab dead bodies to make it bleed faster this way
		blood_flow += 0.05 * wounding_types[WOUND_SLASH]

/datum/wound/slash/flesh/drag_bleed_amount()
	// say we have 3 severe cuts with 3 blood flow each, pretty reasonable
	// compare with being at 100 brute damage before, where you bled (brute/100 * 2), = 2 blood per tile
	// 3 * 3 * 0.1 = 0.9 blood total, less than before! the share here is .3 blood of course.
	var/bleed_amt = min(blood_flow * 0.1, 1)

	// gauze stops all bleeding from dragging on this limb, but wears the gauze out quicker
	if(limb.current_gauze && limb.current_gauze.seep_gauze(bleed_amt * 0.15, GAUZE_STAIN_BLOOD))
		return

	return bleed_amt

/datum/wound/slash/flesh/get_bleed_rate_of_change()
	if(!limb.can_bleed())
		return BLOOD_FLOW_STEADY
	if(HAS_TRAIT(victim, TRAIT_BLOODY_MESS))
		return BLOOD_FLOW_INCREASING
	if(limb.current_gauze || clot_rate > 0)
		return BLOOD_FLOW_DECREASING
	if(clot_rate < 0)
		return BLOOD_FLOW_INCREASING
	return BLOOD_FLOW_STEADY

/datum/wound/slash/flesh/handle_process()
	if(!victim || IS_IN_STASIS(victim))
		return

	if(victim.stat == DEAD)
		blood_flow -= max(clot_rate, WOUND_SLASH_DEAD_CLOT_MIN)
		if(blood_flow < minimum_flow)
			if(demotes_to)
				replace_wound(demotes_to)
				return
			qdel(src)
			return

	blood_flow = min(blood_flow, WOUND_SLASH_MAX_BLOODFLOW)

	if(HAS_TRAIT(victim, TRAIT_BLOODY_MESS))
		blood_flow += 0.5 // adds 0.5 bleed flow to ALL open cuts

	if(limb.current_gauze)
		if(clot_rate > 0)
			blood_flow -= clot_rate
		if(limb.current_gauze && limb.current_gauze.seep_gauze(limb.current_gauze.absorption_rate, GAUZE_STAIN_BLOOD))
			blood_flow -= limb.current_gauze.absorption_rate
	else
		blood_flow -= clot_rate

	if(blood_flow > highest_flow)
		highest_flow = blood_flow

	if(blood_flow < minimum_flow)
		if(demotes_to)
			replace_wound(new demotes_to)
		else
			to_chat(victim, span_green("The cut on your [limb.name] has stopped bleeding!"))
			qdel(src)

/datum/wound/slash/flesh/on_stasis()
	if(blood_flow >= minimum_flow)
		return
	if(demotes_to)
		replace_wound(demotes_to)
		return
	qdel(src)

/* BEWARE, THE BELOW NONSENSE IS MADNESS. bones.dm looks more like what I have in mind and is sufficiently clean, don't pay attention to this messiness */
// what do you mean dont pay attention. what??
/datum/wound/slash/flesh/check_grab_treatments(obj/item/I, mob/user)
	if(istype(I, /obj/item/gun/energy/laser))
		return TRUE
	if(I.get_temperature()) // if we're using something hot but not a cautery, we need to be aggro grabbing them first, so we don't try treating someone we're eswording
		return TRUE

/datum/wound/slash/flesh/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/gun/energy/laser))
		return las_cauterize(I, user)
	else if(I.tool_behaviour == TOOL_CAUTERY || I.get_temperature())
		return tool_cauterize(I, user)
	else if(istype(I, /obj/item/stack/medical/suture))
		return suture(I, user)

/datum/wound/slash/flesh/on_xadone(power) //this is for cryo, check and maybe remove later
	. = ..()
	blood_flow -= 0.03 * power // i think it's like a minimum of 3 power, so .09 blood_flow reduction per tick

/datum/wound/slash/flesh/on_synthflesh(power)
	. = ..()
	blood_flow -= 0.075 * power // 20u * 0.075 = -1.5 blood flow

/datum/wound/slash/flesh/on_silfrine(power)
	switch(power)
		if(0 to 5)
			EMPTY_BLOCK_GUARD
		if(6 to 11)
			if(severity < WOUND_SEVERITY_MODERATE)
				qdel(src)
		if(12 to 30)
			if(severity < WOUND_SEVERITY_SEVERE)
				qdel(src)
	blood_flow -= 0.05 * power

/// If someone's putting a laser gun up to our cut to cauterize it
/datum/wound/slash/flesh/proc/las_cauterize(obj/item/gun/energy/laser/lasgun, mob/user)
	var/self_penalty_mult = (user == victim ? 1.25 : 1)
	user.visible_message(
		span_warning("[user] begins aiming [lasgun] directly at [victim]'s [limb.name]..."),
		span_userdanger("You begin aiming [lasgun] directly at [user == victim ? "your" : "[victim]'s"] [limb.name]..."),
	)

	if(!do_after(user, base_treat_time  * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	var/damage = lasgun.chambered.BB.damage
	lasgun.chambered.BB.wound_bonus -= 30
	lasgun.chambered.BB.damage *= self_penalty_mult
	if(!lasgun.process_fire(victim, victim, TRUE, null, limb.body_zone))
		return TRUE

	victim.force_scream()
	blood_flow -= damage / (5 * self_penalty_mult) // 20 / 5 = 4 bloodflow removed, p good
	victim.visible_message(span_warning("The cuts on [victim]'s [limb.name] scar over!"))
	return TRUE

/// If someone is using either a cautery tool or something with heat to cauterize this cut
/datum/wound/slash/flesh/proc/tool_cauterize(obj/item/I, mob/user)
	var/improv_penalty_mult = (I.tool_behaviour == TOOL_CAUTERY ? 1 : 1.25) // 25% longer and less effective if you don't use a real cautery
	var/self_penalty_mult = (user == victim ? 1.2 : 1)
	user.visible_message(
		span_danger("[user] begins cauterizing [victim]'s [limb.name] with [I]..."),
		span_warning("You begin cauterizing [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]..."),
	)
	if(!do_after(user, base_treat_time * self_penalty_mult * improv_penalty_mult, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	playsound(user, 'sound/surgery/cautery2.ogg', 20)
	user.visible_message(
		span_green("[user] cauterizes some of the bleeding on [victim]."),
		span_green("You cauterize some of the bleeding on [victim]."),
	)
	limb.receive_damage(burn = 2 + severity)

	var/blood_cauterized = (0.6 / (self_penalty_mult * improv_penalty_mult))
	blood_flow -= blood_cauterized

	if(blood_flow > minimum_flow)
		return try_treating(I, user)
	else if(demotes_to)
		to_chat(user, span_green("You successfully lower the severity of [user == victim ? "your" : "[victim]'s"] cuts."))
		return TRUE

/// If someone is using a suture to close this cut
/datum/wound/slash/flesh/proc/suture(obj/item/stack/medical/suture/I, mob/user)
	var/self_penalty_mult = (user == victim ? 1 : 1)
	user.visible_message(
		span_notice("[user] begins stitching [victim]'s [limb.name] with [I]..."),
		span_notice("You begin stitching [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]..."),
	)

	if(!do_after(user, base_treat_time * self_penalty_mult, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE
	user.visible_message(
		span_green("[user] stitches up some of the bleeding on [victim]."),
		span_green("You stitch up some of the bleeding on [user == victim ? "yourself" : "[victim]"]."),
	)
	var/blood_sutured = I.stop_bleeding / self_penalty_mult
	blood_flow -= blood_sutured
	limb.heal_damage(I.heal_brute, I.heal_burn)
	I.use(1)

	if(blood_flow > minimum_flow)
		return try_treating(I, user)
	else if(demotes_to)
		to_chat(user, span_green("You successfully lower the severity of [user == victim ? "your" : "[victim]'s"] cuts."))
		return TRUE
	return FALSE

/datum/wound/slash/flesh/moderate
	name = "Rough Abrasion"
	desc = "Patient's flesh has been badly scraped, generating moderate blood loss."
	treat_text = "Application of clean bandages and sutures."
	examine_desc = "has an open cut"
	occur_text = "is cut open, slowly leaking blood"
	sound_effect = 'sound/effects/wounds/blood1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 1.5
	minimum_flow = 0.1
	clot_rate = 0.015
	threshold_penalty = 10
	status_effect_type = /datum/status_effect/wound/slash/flesh/moderate

/datum/wound_pregen_data/flesh_slash/abrasion
	abstract = FALSE

	wound_path_to_generate = /datum/wound/slash/flesh/moderate
	threshold_minimum = 30

/datum/wound/slash/flesh/severe
	name = "Open Laceration"
	desc = "Patient's flesh is ripped clean open, allowing significant blood loss."
	treat_text = "Application of clean bandages and sutures or cauterization."
	examine_desc = "has a severe cut"
	occur_text = "is ripped open, veins spurting blood"
	sound_effect = 'sound/effects/wounds/blood2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	initial_flow = 2
	minimum_flow = 1.5
	clot_rate = 0.025
	threshold_penalty = 20
	demotes_to = /datum/wound/slash/flesh/moderate
	status_effect_type = /datum/status_effect/wound/slash/flesh/severe

/datum/wound_pregen_data/flesh_slash/laceration
	abstract = FALSE

	wound_path_to_generate = /datum/wound/slash/flesh/severe
	threshold_minimum = 50

/datum/wound/slash/flesh/critical
	name = "Weeping Avulsion"
	desc = "Patient's flesh is completely torn open, along with significant loss of tissue. Extreme blood loss will lead to quick death without intervention."
	treat_text = "Bandage immediately and apply pressure, then apply sutures or cauterization."
	examine_desc = "is slashed open, spraying blood wildly"
	occur_text = "is torn open, spraying blood wildly"
	sound_effect = 'sound/effects/wounds/blood3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	initial_flow = 3
	minimum_flow = 2
	clot_rate = -0.005 // critical cuts actively get worse instead of better
	threshold_penalty = 50
	demotes_to = /datum/wound/slash/flesh/severe
	status_effect_type = /datum/status_effect/wound/slash/flesh/critical
	wound_flags = ACCEPTS_GAUZE | MANGLES_EXTERIOR | CAN_BE_GRASPED

/datum/wound_pregen_data/flesh_slash/avulsion
	abstract = FALSE

	wound_path_to_generate = /datum/wound/slash/flesh/critical
	threshold_minimum = 100

/datum/wound/slash/flesh/critical/receive_damage(list/wounding_types, total_wound_dmg, wound_bonus)
	. = ..()
	if(victim && wounding_types[WOUND_BLUNT])
		playsound(victim, "sound/effects/wounds/crackandbleed.ogg", 100)
