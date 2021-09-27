
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

		// Flesh damage vars
	/// How much damage to our flesh we currently have. Once both this and infestation reach 0, the wound is considered healed
	var/nerve_damage = 5
	/// Our current counter for how much flesh regeneration we have stacked from regenerative mesh/synthflesh/whatever, decrements each tick and lowers nerve_damage
	var/nerve_healing = 0

/datum/wound/burn/handle_process()
	. = ..()

	if(limb.burn_dam <= 0 && severity == WOUND_SEVERITY_MODERATE)
		nerve_healing += 0.1

	if(victim.reagents)
		if(victim.reagents.has_reagent(/datum/reagent/medicine/mannitol))
			nerve_healing += 0.1
		if(victim.reagents.has_reagent(/datum/reagent/medicine/neurine))
			nerve_healing += 1
		if(victim.reagents.has_reagent(/datum/reagent/medicine/oxandrolone))
			nerve_healing += 0.5

	if(limb.current_gauze)
		limb.seep_gauze(WOUND_BURN_SANITIZATION_RATE)

	if(nerve_healing >= 1)
		var/bandage_factor = (limb.current_gauze ? limb.current_gauze.splint_factor : 1)
		nerve_damage = max(0, nerve_damage - 1)
		nerve_healing = max(0, nerve_healing - bandage_factor) // good bandages multiply the length of flesh healing
	
	// here's the check to see if we're cleared up
	if((nerve_damage <= 0))
		to_chat(victim, "<span class='green'>The burns on your [limb.name] have cleared up!</span>")
		qdel(src)
		return

/datum/wound/burn/get_examine_description(mob/user)
	var/list/condition = list("[victim.p_their(TRUE)] [limb.name] [examine_desc]")
	if(limb.current_gauze)
		var/bandage_condition
		switch(limb.current_gauze.blood_capacity)
			if(0 to 20)
				bandage_condition = "nearly ruined"
			if(20 to 40)
				bandage_condition = "badly worn"
			if(40 to 60)
				bandage_condition = "slightly pus-stained"
			if(60 to INFINITY)
				bandage_condition = "clean"

		condition += " underneath a dressing of [bandage_condition] [limb.current_gauze.name]"

	return "<B>[condition.Join()]</B>"

/datum/wound/burn/get_scanner_description(mob/user)
	. = ..()
	. += "<div class='ml-3'>"

	if(nerve_damage > 0)
		. += "Nerve damage detected: Please administer neural repair agents to allow recovery.\n"
	. += "</div>"

// people complained about burns not healing on stasis beds, so in addition to checking if it's cured, they also get the special ability to very slowly heal on stasis beds if they have the healing effects stored
/datum/wound/burn/on_stasis()
	. = ..()
	if(nerve_healing > 0)
		nerve_damage = max(0, nerve_damage - 0.2)
	if((nerve_damage <= 0))
		to_chat(victim, "<span class='green'>The burns on your [limb.name] have cleared up!</span>")
		qdel(src)
		return

/datum/wound/burn/on_synthflesh(amount)
	nerve_healing += amount * 0.1 // 20u patch will heal 2 flesh standard

// we don't even care about first degree burns, straight to second
/datum/wound/burn/moderate
	name = "Second Degree Burns"
	desc = "Patient is suffering considerable burns with mild skin penetration, weakening limb integrity and increased burning sensations."
	treat_text = "Recommended application of topical ointment or regenerative mesh to affected region."
	examine_desc = "is badly burned and breaking out in blisters"
	occur_text = "breaks out with violent red burns"
	severity = WOUND_SEVERITY_MODERATE
	damage_mulitplier_penalty = 1.1
	threshold_minimum = 30
	threshold_penalty = 20
	status_effect_type = /datum/status_effect/wound/burn/moderate
	nerve_damage = 5
	scar_keyword = "burnmoderate"

/datum/wound/burn/severe
	name = "Third Degree Burns"
	desc = "Patient is suffering extreme burns with full skin penetration, creating serious risk of infection and greatly reduced limb integrity."
	treat_text = "Recommended immediate disinfection and excision of any infected skin, followed by bandaging and ointment."
	examine_desc = "appears seriously charred, with aggressive red splotches"
	occur_text = "chars rapidly, exposing ruined tissue and spreading angry red burns"
	severity = WOUND_SEVERITY_SEVERE
	damage_mulitplier_penalty = 1.2
	threshold_minimum = 60
	threshold_penalty = 40
	status_effect_type = /datum/status_effect/wound/burn/severe
	nerve_damage = 15
	scar_keyword = "burnsevere"
