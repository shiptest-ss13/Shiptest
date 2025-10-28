/*
	Piercing wounds
*/

/datum/wound/pierce
	name = "Piercing Wound"
	sound_effect = 'sound/weapons/slice.ogg'
	processes = TRUE
	wound_type = WOUND_PIERCE
	treatable_by = list(/obj/item/stack/medical/suture)
	treatable_tool = TOOL_CAUTERY
	base_treat_time = 3 SECONDS
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE | ACCEPTS_SPLINT)

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// If gauzed, what percent of the internal bleeding actually clots of the total absorption rate
	var/gauzed_clot_rate

	/// When hit on this bodypart, we have this chance of losing some blood + the incoming damage
	var/internal_bleeding_chance
	/// If we let off blood when hit, the max blood lost is this * the incoming damage
	var/internal_bleeding_coefficient

/datum/wound/pierce/show_wound_topic(mob/user)
	return (user == victim && blood_flow)

/datum/wound/pierce/Topic(href, href_list)
	. = ..()
	if(href_list["wound_topic"])
		if(!usr == victim)
			return
		victim.self_grasp_bleeding_limb(limb)

/datum/wound/pierce/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	blood_flow = initial_flow
	if(attack_direction && victim.blood_volume > BLOOD_VOLUME_BAD)
		victim.spray_blood(attack_direction, severity)

/datum/wound/pierce/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(isnull(victim) || victim.stat == DEAD || wounding_dmg < WOUND_MINIMUM_DAMAGE)
		return

	if(victim.blood_volume && prob(internal_bleeding_chance + wounding_dmg))
		if(limb.current_splint?.splint_factor)
			wounding_dmg *= (1 - limb.current_splint.splint_factor)

		var/blood_bled = rand(1, wounding_dmg * internal_bleeding_coefficient)
		switch(blood_bled)
			if(1 to 6)
				victim.bleed(blood_bled, TRUE)
			if(7 to 13)
				victim.visible_message(
					span_danger("Blood droplets fly from the hole in [victim]'s [limb.name]."),
					span_danger("You cough up a bit of blood from the blow to your [limb.name]."),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
				victim.visible_message(
					span_danger("A small stream of blood spurts from the hole in [victim]'s [limb.name]!"),
					span_userdanger("You spit out a string of blood from the blow to your [limb.name]!"),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
				victim.visible_message(
					span_danger("A spray of blood streams from the gash in [victim]'s [limb.name]!"),
					span_userdanger("You choke up on a spray of blood from the blow to your [limb.name]!"),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				victim.bleed(blood_bled)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/pierce/get_bleed_rate_of_change()
	if(HAS_TRAIT(victim, TRAIT_BLOODY_MESS))
		return BLOOD_FLOW_INCREASING
	if(limb.current_gauze && limb.current_gauze.seep_gauze(limb.current_gauze.absorption_rate, GAUZE_STAIN_BLOOD))
		return BLOOD_FLOW_DECREASING
	return BLOOD_FLOW_STEADY

/datum/wound/pierce/handle_process()
	blood_flow = min(blood_flow, WOUND_SLASH_MAX_BLOODFLOW)

	if(HAS_TRAIT(victim, TRAIT_BLOODY_MESS))
		blood_flow += 0.3

	if(limb.current_gauze)
		blood_flow -= limb.current_gauze.absorption_rate * gauzed_clot_rate

	if(blood_flow <= 0)
		qdel(src)

/datum/wound/pierce/on_stasis()
	. = ..()
	if(blood_flow <= 0)
		qdel(src)

/datum/wound/pierce/check_grab_treatments(obj/item/I, mob/user)
	if(I.get_temperature()) // if we're using something hot but not a cautery, we need to be aggro grabbing them first, so we don't try treating someone we're eswording
		return TRUE

/datum/wound/pierce/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/medical/suture))
		suture(I, user)
	else if(I.tool_behaviour == TOOL_CAUTERY || I.get_temperature())
		tool_cauterize(I, user)

/datum/wound/pierce/on_xadone(power)
	. = ..()
	blood_flow -= 0.03 * power // i think it's like a minimum of 3 power, so .09 blood_flow reduction per tick is pretty good for 0 effort

/datum/wound/pierce/on_synthflesh(power)
	. = ..()
	blood_flow -= 0.05 * power // 20u * 0.05 = -1 blood flow, less than with slashes but still good considering smaller bleed rates

/datum/wound/pierce/on_silfrine(power)
	switch(power)
		if(0 to 3)
			EMPTY_BLOCK_GUARD
		if(4 to 8)
			if(severity < WOUND_SEVERITY_MODERATE)
				qdel(src)
		if(8 to 30)
			if(severity < WOUND_SEVERITY_SEVERE)
				qdel(src)
	blood_flow -= 0.05 * power

/// If someone is using a suture to close this puncture
/datum/wound/pierce/proc/suture(obj/item/stack/medical/suture/I, mob/user)
	var/self_penalty_mult = (user == victim ? 1 : 1)
	user.visible_message(
		span_notice("[user] begins stitching [victim]'s [limb.name] with [I]..."),
		span_notice("You begin stitching [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]..."),
	)
	if(!do_after(user, base_treat_time * self_penalty_mult, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return
	user.visible_message(
		span_green("[user] stitches up some of the bleeding on [victim]."),
		span_green("You stitch up some of the bleeding on [user == victim ? "yourself" : "[victim]"]."),
	)
	var/blood_sutured = I.stop_bleeding / self_penalty_mult
	blood_flow -= blood_sutured
	limb.heal_damage(I.heal_brute, I.heal_burn)
	I.use(1)

	if(blood_flow > 0)
		try_treating(I, user)
	else
		to_chat(user, span_green("You successfully close the hole in [user == victim ? "your" : "[victim]'s"] [limb.name]."))

/// If someone is using either a cautery tool or something with heat to cauterize this pierce
/datum/wound/pierce/proc/tool_cauterize(obj/item/I, mob/user)
	var/improv_penalty_mult = (I.tool_behaviour == TOOL_CAUTERY ? 1 : 1.25) // 25% longer and less effective if you don't use a real cautery
	var/self_penalty_mult = (user == victim ? 1.1 : 1)

	user.visible_message(
		span_danger("[user] begins cauterizing [victim]'s [limb.name] with [I]..."),
		span_warning("You begin cauterizing [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]..."),
	)
	if(!do_after(user, base_treat_time * self_penalty_mult * improv_penalty_mult, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	playsound(user, 'sound/surgery/cautery2.ogg', 20)
	user.visible_message(
		span_green("[user] cauterizes some of the bleeding on [victim]."),
		span_green("You cauterize some of the bleeding on [victim]."),
	)
	limb.receive_damage(burn = 2 + severity, wound_bonus = CANT_WOUND)
	if(prob(15))
		victim.force_pain_noise(50)
	var/blood_cauterized = (0.6 / (self_penalty_mult * improv_penalty_mult))
	blood_flow -= blood_cauterized

	if(blood_flow > 0)
		try_treating(I, user)

/datum/wound/pierce/moderate
	name = "Minor Breakage"
	desc = "Patient's skin has been broken open, causing severe bruising and minor internal bleeding in affected area."
	treat_text = "Application of clean bandages and sutures or cauterization."
	examine_desc = "has a small gently bleeding hole"
	occur_text = "spurts out a thin stream of blood"
	sound_effect = 'sound/effects/wounds/pierce1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 1
	gauzed_clot_rate = 0.8
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 1.25
	threshold_minimum = 40
	threshold_penalty = 20
	status_effect_type = /datum/status_effect/wound/pierce/moderate

/datum/wound/pierce/severe
	name = "Open Puncture"
	desc = "Patient's internal tissue is penetrated, causing sizeable internal bleeding and reduced limb stability."
	treat_text = "Application of clean bandages and sutures or cauterization."
	examine_desc = "is pierced clear through, with bits of tissue obscuring the open hole"
	occur_text = "looses a violent spray of blood"
	sound_effect = 'sound/effects/wounds/pierce2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	initial_flow = 2
	gauzed_clot_rate = 0.6
	internal_bleeding_chance = 60
	internal_bleeding_coefficient = 1.5
	threshold_minimum = 60
	threshold_penalty = 35
	status_effect_type = /datum/status_effect/wound/pierce/severe

/datum/wound/pierce/critical
	name = "Ruptured Cavity"
	desc = "Patient's internal tissue and circulatory system is shredded, causing significant internal bleeding and damage to internal organs."
	treat_text = "Bandaging, cauterization, or surgical repair followed by potential transfusion."
	examine_desc = "has a deep bleeding puncture"
	occur_text = "blasts apart, sending blood flying"
	sound_effect = 'sound/effects/wounds/pierce3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	initial_flow = 3
	gauzed_clot_rate = 0.5
	internal_bleeding_chance = 80
	internal_bleeding_coefficient = 1.75
	threshold_minimum = 115
	threshold_penalty = 50
	status_effect_type = /datum/status_effect/wound/pierce/critical
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE | ACCEPTS_SPLINT | MANGLES_FLESH)
