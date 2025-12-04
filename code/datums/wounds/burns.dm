/*
	Burn wounds
*/

// TODO: well, a lot really, but specifically I want to add potential fusing of clothing/equipment on the affected area, and limb infections, though those may go in body part code
/datum/wound/burn
	name = "Burn Wound"
	a_or_from = "from"
	wound_type = WOUND_BURN
	processes = TRUE
	sound_effect = 'sound/effects/wounds/sizzle1.ogg'
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE)

	treatable_by = list(
		/obj/item/stack/medical/ointment,
		/obj/item/stack/medical/mesh,
	)

		// Flesh damage vars
	/// How much damage to our flesh we currently have. Once both this reaches 0, the wound is considered healed
	var/flesh_damage = 5
	/// Our current counter for how much flesh regeneration we have stacked from regenerative mesh/synthflesh/whatever, decrements each tick and lowers flesh_damage
	var/flesh_healing = 0

/datum/wound/burn/handle_process()
	. = ..()

	if(victim.reagents)
		if(victim.reagents.has_reagent(/datum/reagent/medicine/spaceacillin))
			flesh_healing += 0.5
		if(victim.reagents.has_reagent(/datum/reagent/space_cleaner/sterilizine))
			flesh_healing += 0.5
		if(victim.reagents.has_reagent(/datum/reagent/medicine/mine_salve))
			flesh_healing += 0.5

	var/bandage_factor = limb.current_gauze.sanitisation_factor
	if(flesh_healing > 0) // good bandages multiply the length of flesh healing
		flesh_damage = max(0, flesh_damage - 1)
		flesh_healing = max(0, flesh_healing - bandage_factor)

	// if we have little/no infection, the limb doesn't have much burn damage, and our nutrition is good, heal some flesh
	if((limb.burn_dam < 5) && (victim.nutrition >= NUTRITION_LEVEL_FED))
		flesh_healing += 0.2

	// here's the check to see if we're cleared up
	if((flesh_damage <= 0))
		to_chat(victim, span_green("The burns on your [limb.name] have cleared up!"))
		qdel(src)
		return

/datum/wound/burn/get_examine_description(mob/user)
	var/list/condition = list("[victim.p_their(TRUE)] [limb.name] [examine_desc]")
	if(limb.current_gauze)
		var/bandage_condition
		switch(limb.current_gauze.absorption_capacity)
			if(0 to 1.25)
				bandage_condition = "nearly ruined"
			if(1.25 to 2.75)
				bandage_condition = "badly worn"
			if(2.75 to 4)
				bandage_condition = "slightly stained"
			if(4 to INFINITY)
				bandage_condition = "clean"

		condition += " underneath a dressing of [bandage_condition] [limb.current_gauze.name]"

	return "<B>[condition.Join()]</B>"

/datum/wound/burn/get_scanner_description(mob/user)
	. = ..()
	. += "<div class='ml-3'>"

	if(flesh_damage <= flesh_healing)
		. += "No further treatment required: Burns will heal shortly."
		if(flesh_damage > 0)
			. += "Flesh damage detected: Application of ointment, regenerative mesh, Synthflesh, or ingestion of \"Miner's Salve\" will repair damaged flesh. Good nutrition, rest, and keeping the wound clean can also slowly repair flesh.\n"
	. += "</div>"

/*
	new burn common procs
*/

/// if someone is using ointment or mesh on our burns
/datum/wound/burn/proc/ointmentmesh(obj/item/stack/medical/I, mob/user)
	user.visible_message(
		span_notice("[user] begins applying [I] to [victim]'s [limb.name]..."),
		span_notice("You begin applying [I] to [user == victim ? "your" : "[victim]'s"] [limb.name]..."),
	)
	if (I.amount <= 0)
		return
	if(!do_after(user, (user == victim ? I.self_delay : I.other_delay), extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	limb.heal_damage(I.heal_brute, I.heal_burn)
	user.visible_message(
		span_green("[user] applies [I] to [victim]."),
		span_green("You apply [I] to [user == victim ? "your" : "[victim]'s"] [limb.name]."),
	)
	I.use(1)
	flesh_healing += I.flesh_regeneration

	if((flesh_damage <= 0 || flesh_healing > flesh_damage))
		to_chat(user, span_notice("You've done all you can with [I], [victim]'s [limb.name] can't be treated further."))
	else
		try_treating(I, user)

/datum/wound/burn/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/medical/ointment))
		ointmentmesh(I, user)

	else if(istype(I, /obj/item/stack/medical/mesh))
		var/obj/item/stack/medical/mesh/mesh_check = I
		if(!mesh_check.is_open)
			to_chat(user, span_warning("You need to open [mesh_check] first."))
			return
		ointmentmesh(mesh_check, user)

/datum/wound/burn/on_synthflesh(amount)
	flesh_healing += amount * 0.5 // 20u patch will heal 10 flesh standard

/// When a -tane chem is applied to the victim, we call this.
/datum/wound/burn/on_tane(amount)
	if(amount > 10 && severity <= WOUND_SEVERITY_SEVERE)
		qdel(src)
		return

	flesh_healing += amount * 0.25
	return

// we don't even care about first degree burns, straight to second
/datum/wound/burn/moderate
	name = "Second Degree Burns"
	desc = "Patient is suffering considerable burns with mild skin penetration, weakening limb integrity and increased burning sensations."
	treat_text = "Application of ointment or regenerative mesh, and bandages."
	examine_desc = "is badly burned"
	occur_text = "breaks out with violent red burns"
	severity = WOUND_SEVERITY_MODERATE
	damage_mulitplier_penalty = 1.05
	threshold_minimum = 40
	threshold_penalty = 20
	status_effect_type = /datum/status_effect/wound/burn/moderate
	flesh_damage = 5

/datum/wound/burn/severe
	name = "Third Degree Burns"
	desc = "Patient is suffering extreme burns with full skin penetration, leading to greatly reduced limb integrity."
	treat_text = "Application of ointment or regenerative mesh, and bandages."
	examine_desc = "appears seriously charred, with aggressive red splotches"
	occur_text = "chars rapidly, spreading angry red burns"
	severity = WOUND_SEVERITY_SEVERE
	damage_mulitplier_penalty = 1.1
	threshold_minimum = 80
	threshold_penalty = 30
	status_effect_type = /datum/status_effect/wound/burn/severe
	treatable_by = list(/obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh)
	flesh_damage = 12.5

/datum/wound/burn/critical
	name = "Catastrophic Burns"
	desc = "Patient is suffering near complete loss of tissue and significantly charred muscle and bone, and negligible limb integrity."
	treat_text = "Application of ointment or regenerative mesh, and bandages."
	examine_desc = "is a mess of bone and charred flesh"
	occur_text = "vaporizes as the flesh melts"
	severity = WOUND_SEVERITY_CRITICAL
	damage_mulitplier_penalty = 1.15
	sound_effect = 'sound/effects/wounds/sizzle2.ogg'
	threshold_minimum = 140
	threshold_penalty = 80
	status_effect_type = /datum/status_effect/wound/burn/critical
	treatable_by = list(/obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh)
	flesh_damage = 20
