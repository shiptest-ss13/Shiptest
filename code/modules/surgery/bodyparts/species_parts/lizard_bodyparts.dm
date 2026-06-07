/obj/item/bodypart/head/lizard
	icon = 'icons/mob/species/lizard/bodyparts.dmi'
	icon_state = "sarathi_head"
	limb_id = SPECIES_SARATHI
	uses_mutcolor = TRUE
	is_dimorphic = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/lizard
	icon = 'icons/mob/species/lizard/bodyparts.dmi'
	icon_state = "sarathi_chest_m"
	uses_mutcolor = TRUE
	limb_id = SPECIES_SARATHI
	is_dimorphic = TRUE

/obj/item/bodypart/l_arm/lizard
	icon = 'icons/mob/species/lizard/bodyparts.dmi'
	icon_state = "sarathi_l_arm"
	uses_mutcolor = TRUE
	limb_id = SPECIES_SARATHI

/obj/item/bodypart/r_arm/lizard
	icon = 'icons/mob/species/lizard/bodyparts.dmi'
	icon_state = "sarathi_r_arm"
	uses_mutcolor = TRUE
	limb_id = SPECIES_SARATHI

/obj/item/bodypart/leg/left/lizard
	icon = 'icons/mob/species/lizard/bodyparts.dmi'
	icon_state = "sarathi_l_leg"
	uses_mutcolor = TRUE
	limb_id = SPECIES_SARATHI

/obj/item/bodypart/leg/right/lizard
	icon = 'icons/mob/species/lizard/bodyparts.dmi'
	icon_state = "sarathi_r_leg"
	uses_mutcolor = TRUE
	limb_id = SPECIES_SARATHI

/obj/item/bodypart/leg/left/lizard/digitigrade
	icon = 'icons/mob/species/lizard/bodyparts.dmi'
	icon_state = "sarathi_l_leg_digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/lizard/digitigrade
	icon = 'icons/mob/species/lizard/bodyparts.dmi'
	icon_state = "sarathi_r_leg_digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/tail/lizard
	name = "sarathi tail"
	desc = "A severed Sarathi's tail. Can't they regrow these...?"
	icon = 'icons/mob/species/lizard/bodyparts.dmi'
	icon_state = "sarathi_tail"
	examine_id = SPECIES_SARATHI
	limb_id = SPECIES_SARATHI
	uses_mutcolor = TRUE
	overlay_icon_state = TRUE
	max_damage = 30
	max_stamina_damage = 30
	body_damage_coeff = 0.6
	body_weight = 8
	can_thump = TRUE
	/// Keeps track of which spines should be displayed.
	var/spines

/obj/item/bodypart/tail/lizard/set_owner(new_owner)
	. = ..()
	if(. == FALSE)
		return
	if(owner)
		if(!spines)
			spines = owner.dna.features["spines"] || "None"
			owner.dna.species.mutant_bodyparts |= "spines"
		else
			owner.dna.features["spines"] = spines
	else if(.)
		var/mob/living/carbon/old_owner = .
		old_owner.dna.species.mutant_bodyparts -= "spines"

/obj/item/bodypart/tail/lizard/set_wag(new_state)
	if(!..())
		return FALSE
	if(owner.dna?.species)
		owner.dna.species.handle_mutant_bodyparts(owner)
	return TRUE

/obj/item/bodypart/tail/lizard/large
	name = "large sarathi tail"
	icon_state = "large_sarathi_tail"
	limb_id = "large_" + SPECIES_SARATHI
	max_damage = 50
	max_stamina_damage = 50
	body_damage_coeff = 0.75
	body_weight = 16 // big tail == big target

/obj/item/bodypart/tail/lizard/small
	name = "small sarathi tail"
	icon_state = "small_sarathi_tail"
	limb_id = "small_" + SPECIES_SARATHI
	max_damage = 20
	max_stamina_damage = 20
	body_weight = 4

/obj/item/bodypart/tail/lizard/synth
	name = "prosthetic sarathi tail"
	icon_state = "synth_sarathi_tail"
	examine_id = "prosthetic " + SPECIES_SARATHI
	limb_id = "synth_" + SPECIES_SARATHI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	biological_state = BIO_ROBOTIC

/obj/item/bodypart/tail/lizard/one_color
	name = "sarathi tail (one color)"
	icon_state = "onecolor_sarathi_tail"
	limb_id = "onecolor_" + SPECIES_SARATHI
	overlay_icon_state = FALSE

/obj/item/bodypart/tail/lizard/fake
	name = "fabricated sarathi tail"
	desc = "A fabricated severed sarathi tail. This one's made of synthflesh."
