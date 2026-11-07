/*
	Burn wounds
*/

// TODO: well, a lot really, but specifically I want to add potential fusing of clothing/equipment on the affected area, and limb infections, though those may go in body part code
/datum/wound/burn
	name = "Burn Wound"
	a_or_from = "from"
	sound_effect = 'sound/effects/wounds/sizzle1.ogg'

/datum/wound/burn/flesh
	name = "Burn (Flesh) Wound"
	a_or_from = "from"
	processes = TRUE

	treatable_by = list(/obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh) // sterilizer and alcohol will require reagent treatments, coming soon

	/// How much damage to our flesh we currently have. Once this reaches 0, the wound is considered healed
	var/flesh_damage = 5
	/// Our current counter for how much flesh regeneration we have stacked from regenerative mesh/synthflesh/whatever, decrements each tick and lowers flesh_damage
	var/flesh_healing = 0

/datum/wound_pregen_data/flesh_burn
	abstract = TRUE

	required_wounding_types = list(WOUND_BURN)
	required_limb_biostate = BIO_FLESH

	wound_series = WOUND_SERIES_FLESH_BURN_BASIC

/datum/wound/burn/flesh/handle_process(seconds_per_tick, times_fired)
	if (!victim || IS_IN_STASIS(victim))
		return

	. = ..()

	if(victim.reagents)
		if(victim.reagents.has_reagent(/datum/reagent/medicine/antibiotic))
			flesh_healing += 0.5
		if(victim.reagents.has_reagent(/datum/reagent/space_cleaner/sterilizine))
			to_chat(world, "sterilizine")
			flesh_healing += 0.5
		if(victim.reagents.has_reagent(/datum/reagent/space_cleaner/sterilizine/purifadine))
			to_chat(world, "purifadine")
			flesh_healing += 0.9
		if(victim.reagents.has_reagent(/datum/reagent/medicine/mine_salve))
			flesh_healing += 0.5

	var/bandage_factor = 1
	if(limb.current_gauze)
		bandage_factor = limb.current_gauze.flesh_heal

	if(flesh_healing > 0) // good bandages multiply the length of flesh healing
		flesh_damage = max(0, flesh_damage - (0.5 * seconds_per_tick))
		flesh_healing = max(0, flesh_healing - (bandage_factor * seconds_per_tick))

	// if the limb doesn't have much burn damage, and our nutrition is good, heal some flesh
	if(limb.burn_dam < 5 && victim.nutrition >= NUTRITION_LEVEL_FED)
		flesh_healing += 0.1 * seconds_per_tick

	// here's the check to see if we're cleared up
	if(flesh_damage <= 0)
		to_chat(victim, span_green("The burns on your [limb.name] have cleared up!"))
		qdel(src)
		return

/datum/wound/burn/flesh/get_examine_description(mob/user)
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

		condition += " underneath a dressing of [bandage_condition] [limb.current_gauze.name]."

	return "<B>[condition.Join()]</B>"

/datum/wound/burn/flesh/get_scanner_description(mob/user)
	. = ..()
	. += "<div class='ml-3'>"

	if(flesh_damage <= flesh_healing)
		. += "No further treatment required: Burns will heal shortly."
	else
		if(flesh_damage > 0)
			. += "Flesh damage detected: Application of ointment, regenerative mesh, Synthflesh, or ingestion of \"Miner's Salve\" will repair damaged flesh. Good nutrition, rest, and keeping the wound clean can also slowly repair flesh.\n"
	. += "</div>"

/*
	new burn common procs
*/

/// if someone is using ointment or mesh on our burns
/datum/wound/burn/flesh/proc/ointmentmesh(obj/item/stack/medical/I, mob/user)
	user.visible_message(
		span_notice("[user] begins applying [I] to [victim]'s [limb.name]..."),
		span_notice("You begin applying [I] to [user == victim ? "your" : "[victim]'s"] [limb.name]..."),
	)
	if (I.amount <= 0)
		return TRUE
	if(!do_after(user, (user == victim ? I.self_delay : I.other_delay), extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	limb.heal_damage(I.heal_brute, I.heal_burn)
	user.visible_message(
		span_green("[user] applies [I] to [victim]."),
		span_green("You apply [I] to [user == victim ? "your" : "[victim]'s"] [limb.name]."),
	)
	I.use(1)
	flesh_healing += I.flesh_regeneration

	// i kinda wish that other wounds worked like this, it's way more interesting to treat something and have it slowly get better
	// in this fashion rather than have the cut immediately clear up. maybe bleed wounds could downgrade into muscle wounds...?
	if((flesh_damage <= 0 || flesh_healing > flesh_damage))
		to_chat(user, span_notice("You've done all you can with [I], [victim]'s [limb.name] can't be treated further."))
		return TRUE
	else
		return try_treating(I, user)

/datum/wound/burn/flesh/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/medical/ointment))
		return ointmentmesh(I, user)

	else if(istype(I, /obj/item/stack/medical/mesh))
		var/obj/item/stack/medical/mesh/mesh_check = I
		if(!mesh_check.is_open)
			to_chat(user, span_warning("You need to open [mesh_check] first."))
			return
		return ointmentmesh(mesh_check, user)


// burn wounds slowly heal in stasis
/datum/wound/burn/flesh/on_stasis(seconds_per_tick, times_fired)
	. = ..()
	if(flesh_healing > 0)
		flesh_damage = max(flesh_damage - (0.1 * seconds_per_tick), 0)
	if(flesh_damage <= 0)
		to_chat(victim, "<span class='green'>The burns on your [limb.name] have cleared up!</span>")
		qdel(src)
		return

/datum/wound/burn/flesh/on_synthflesh(amount)
	flesh_healing += amount * 0.5 // 20u patch will heal 10 flesh standard

/// When a -tane chem is applied to the victim, we call this.
/datum/wound/burn/flesh/on_tane(amount)
	if(amount > 10 && severity <= WOUND_SEVERITY_SEVERE)
		qdel(src)
		return

	flesh_healing += amount * 0.25
	return

// we don't even care about first degree burns, straight to second
/datum/wound/burn/flesh/moderate
	name = "Second Degree Burns"
	desc = "Patient is suffering considerable burns with mild skin penetration, weakening limb integrity and increased burning sensations."
	treat_text = "Application of ointment, regenerative mesh, and bandages."
	examine_desc = "is badly burned"
	occur_text = "breaks out with violent red burns"
	severity = WOUND_SEVERITY_MODERATE
	damage_mulitplier_penalty = 1.05
	threshold_penalty = 20
	status_effect_type = /datum/status_effect/wound/burn/flesh/moderate
	flesh_damage = 5

/datum/wound_pregen_data/flesh_burn/second_degree
	abstract = FALSE

	wound_path_to_generate = /datum/wound/burn/flesh/moderate
	threshold_minimum = 40

/datum/wound/burn/flesh/severe
	name = "Third Degree Burns"
	desc = "Patient is suffering extreme burns with full skin penetration, causing greatly reduced limb integrity."
	treat_text = "Application of ointment, regenerative mesh, and bandages."
	examine_desc = "appears seriously charred, with aggressive red splotches"
	occur_text = "chars rapidly, spreading angry red burns"
	severity = WOUND_SEVERITY_SEVERE
	wound_flags = ACCEPTS_GAUZE | NUMBS_BODYPART
	damage_mulitplier_penalty = 1.1
	threshold_penalty = 30
	status_effect_type = /datum/status_effect/wound/burn/flesh/severe
	treatable_by = list(/obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh)
	flesh_damage = 12.5

/datum/wound_pregen_data/flesh_burn/third_degree
	abstract = FALSE

	wound_path_to_generate = /datum/wound/burn/flesh/severe
	threshold_minimum = 80

/datum/wound/burn/flesh/critical
	name = "Catastrophic Burns"
	desc = "Patient is suffering near complete loss of tissue and significantly charred muscle and bone, causing negligible limb integrity."
	treat_text = "Application of ointment, regenerative mesh, and bandages."
	examine_desc = "is a mess of bone and charred flesh"
	occur_text = "vaporizes as the flesh melts"
	severity = WOUND_SEVERITY_CRITICAL
	damage_mulitplier_penalty = 1.15
	sound_effect = 'sound/effects/wounds/sizzle2.ogg'
	threshold_penalty = 80
	status_effect_type = /datum/status_effect/wound/burn/flesh/critical
	treatable_by = list(/obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh)
	flesh_damage = 20
	wound_flags = ACCEPTS_GAUZE | MANGLES_EXTERIOR | NUMBS_BODYPART

/datum/wound_pregen_data/flesh_burn/fourth_degree
	abstract = FALSE

	wound_path_to_generate = /datum/wound/burn/flesh/critical
	threshold_minimum = 140
