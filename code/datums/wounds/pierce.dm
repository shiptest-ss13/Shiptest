
/*
	Piercing wounds
*/

/datum/wound/pierce
	name = "Piercing Wound"
	sound_effect = 'sound/weapons/slice.ogg'
	processes = TRUE
	wound_type = WOUND_PIERCE
	treatable_by = list(/obj/item/stack/medical/gauze, /obj/item/gauze_injector)
	treatable_tool = TOOL_CAUTERY
	base_treat_time = 3 SECONDS
	wound_flags = (FLESH_WOUND)

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// Total blood flow without considering gauze
	var/actual_flow
	/// How fast our blood flow will naturally decrease per tick, not only do larger cuts bleed more faster, they clot slower
	var/clot_rate
	/// The amount of blood any inserted material will absorb
	var/absorption
	/// When hit on this bodypart, we have this chance of losing some blood + the incoming damage
	var/internal_bleeding_chance
	/// If we let off blood when hit, the max blood lost is this * the incoming damage
	var/internal_bleeding_coefficient

/datum/wound/pierce/wound_injury(datum/wound/old_wound)
	actual_flow = initial_flow

/datum/wound/pierce/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(victim.stat == DEAD || wounding_dmg < 5)
		return
	if(victim.blood_volume && prob(internal_bleeding_chance + wounding_dmg))
		if(limb.current_gauze && limb.current_gauze.splint_factor)
			wounding_dmg *= (1 - limb.current_gauze.splint_factor)
		var/blood_bled = rand(1, wounding_dmg * internal_bleeding_coefficient) // 12 brute toolbox can cause up to 15/18/21 bloodloss on mod/sev/crit
		switch(blood_bled)
			if(1 to 6)
				victim.bleed(blood_bled, TRUE)
			if(7 to 13)
				victim.visible_message("<span class='smalldanger'>Blood droplets fly from the hole in [victim]'s [limb.name].</span>", "<span class='danger'>You cough up a bit of blood from the blow to your [limb.name].</span>", vision_distance=COMBAT_MESSAGE_RANGE)
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
				victim.visible_message("<span class='smalldanger'>A small stream of blood spurts from the hole in [victim]'s [limb.name]!</span>", "<span class='danger'>You spit out a string of blood from the blow to your [limb.name]!</span>", vision_distance=COMBAT_MESSAGE_RANGE)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
				victim.visible_message("<span class='danger'>A spray of blood streams from the gash in [victim]'s [limb.name]!</span>", "<span class='danger'><b>You choke up on a spray of blood from the blow to your [limb.name]!</b></span>", vision_distance=COMBAT_MESSAGE_RANGE)
				victim.bleed(blood_bled)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/pierce/handle_process()
	actual_flow = min(actual_flow, WOUND_SLASH_MAX_BLOODFLOW)

	if(victim.reagents?.has_reagent(/datum/reagent/toxin/heparin))
		actual_flow += 0.3 // old herapin used to just add +2 bleed stacks per tick, this adds 0.3 bleed flow to all open cuts which is probably even stronger as long as you can cut them first
	
	if(limb.brute_dam <= 0)
		if(clot_rate > 0)
			actual_flow -= clot_rate

	blood_flow = actual_flow

	if(absorption > 0)
		blood_flow = 0
		absorption -= actual_flow

	if(actual_flow <= 0)
		qdel(src)

/datum/wound/pierce/on_stasis()
	. = ..()
	if(actual_flow <= 0)
		qdel(src)

/datum/wound/pierce/check_grab_treatments(obj/item/I, mob/user)
	if(I.get_temperature()) // if we're using something hot but not a cautery, we need to be aggro grabbing them first, so we don't try treating someone we're eswording
		return TRUE

/datum/wound/pierce/treat(obj/item/I, mob/user)
	if(I.tool_behaviour == TOOL_CAUTERY || I.get_temperature())
		tool_cauterize(I, user)
	else if(istype(I, /obj/item/stack/medical/gauze))
		gauze_stuff(I, user)
	else if(istype(I, /obj/item/gauze_injector))
		gauze_injection(I, user)

/datum/wound/pierce/on_xadone(power)
	. = ..()
	actual_flow -= 0.01 * power // i think it's like a minimum of 3 power, so .09 blood_flow reduction per tick is pretty good for 0 effort

/// If someone is using either a cautery tool or something with heat to cauterize this pierce
/datum/wound/pierce/proc/tool_cauterize(obj/item/I, mob/user)
	var/improv_penalty_mult = (I.tool_behaviour == TOOL_CAUTERY ? 1 : 1.25) // 25% longer and less effective if you don't use a real cautery
	var/self_penalty_mult = (user == victim ? 1.5 : 1) // 50% longer and less effective if you do it to yourself

	user.visible_message("<span class='danger'>[user] begins cauterizing [victim]'s [limb.name] with [I]...</span>", "<span class='warning'>You begin cauterizing [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]...</span>")
	if(!do_after(user, base_treat_time * self_penalty_mult * improv_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	user.visible_message("<span class='green'>[user] cauterizes some of the bleeding on [victim].</span>", "<span class='green'>You cauterize some of the bleeding on [victim].</span>")
	limb.receive_damage(burn = 2 + severity, wound_bonus = CANT_WOUND)
	if(prob(30))
		victim.emote("scream")
	var/blood_cauterized = (0.6 / (self_penalty_mult * improv_penalty_mult))
	actual_flow -= blood_cauterized

	if(actual_flow > 0)
		try_treating(I, user)

/datum/wound/pierce/proc/gauze_stuff(obj/item/stack/medical/gauze/I, mob/user)
	var/self_penalty_mult = (user == victim ? 1.5 : 1) // 50% longer and less effective if you do it to yourself
	var/skill_mod = user?.mind?.get_skill_modifier(/datum/skill/healing, SKILL_PROBS_MODIFIER)

	var/success_chance = 5 * skill_mod

	user.visible_message("<span class='danger'>[user] begins stuffing [victim]'s [limb.name] with [I]...</span>", "<span class='warning'>You begin stuffing [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]...</span>")
	if(!do_after(user, base_treat_time * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	limb.receive_damage(brute = 7, wound_bonus = CANT_WOUND)
	victim.emote("scream")

	if(prob(success_chance))
		user.visible_message("<span class='green'>[user] stops the bleeding on [victim].</span>", "<span class='green'>You stop the bleeding on [victim].</span>")

		absorption = I.blood_capacity
		I.use(1)
	else
		user.visible_message("<span class='danger'>[user] fails to stop the bleeding on [victim].</span>", "<span class='warning'>You fail to stop the bleeding on [victim].</span>")
		I.use(1)

/datum/wound/pierce/proc/gauze_injection(obj/item/gauze_injector/I, mob/user)
	if(I.blood_capacity > 0)
		user.visible_message("<span class='danger'>[user] begins stuffing [victim]'s [limb.name] with [I]...</span>", "<span class='warning'>You begin stuffing [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]...</span>")
		if(!do_after(user, base_treat_time, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
			return
	
		absorption = I.blood_capacity
		I.blood_capacity = 0
		I.update_icon_state()
	else
		to_chat(user, "<span class='warning'>[I] is used!</span>")
		return

/datum/wound/pierce/moderate
	name = "Minor Internal Bleeding"
	desc = "Patient's skin has been broken open, causing severe bruising and minor internal bleeding in affected area."
	treat_text = "Treat affected site with cautery or generic brute type healing methods. In dire cases, a gauze injector may be required." // space is cold in ss13, so it's like an ice pack!
	examine_desc = "has a small, circular hole, gently bleeding"
	occur_text = "spurts out a thin stream of blood"
	sound_effect = 'sound/effects/wounds/pierce1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 1
	clot_rate = 0.03
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 1.25
	threshold_minimum = 30
	threshold_penalty = 10
	status_effect_type = /datum/status_effect/wound/pierce/moderate
	scar_keyword = "piercemoderate"

/datum/wound/pierce/severe
	name = "Internal Bleeding"
	desc = "Patient's internal tissue is penetrated, causing sizeable internal bleeding and reduced limb stability."
	treat_text = "Repair damaged arteries with cautery ASAP. Use gauze injector if possible."
	examine_desc = "is pierced clear through, with bits of tissue obscuring the open hole"
	occur_text = "looses a violent spray of blood, revealing a pierced wound"
	sound_effect = 'sound/effects/wounds/pierce2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	initial_flow = 3
	clot_rate = 0
	internal_bleeding_chance = 60
	internal_bleeding_coefficient = 1.5
	threshold_minimum = 60
	threshold_penalty = 25
	status_effect_type = /datum/status_effect/wound/pierce/severe
	scar_keyword = "piercesevere"
