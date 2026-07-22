/obj/item/bodypart/head/kepori
	icon = 'icons/mob/species/kepori/bodyparts.dmi'
	icon_state = "kepori_head"
	limb_id = SPECIES_KEPORI
	uses_mutcolor = TRUE
	is_dimorphic = FALSE
	bodytype = BODYTYPE_KEPORI | BODYTYPE_ORGANIC

/obj/item/bodypart/chest/kepori
	icon = 'icons/mob/species/kepori/bodyparts.dmi'
	icon_state = "kepori_chest"
	uses_mutcolor = TRUE
	limb_id = SPECIES_KEPORI
	is_dimorphic = FALSE
	bodytype = BODYTYPE_KEPORI | BODYTYPE_ORGANIC
	acceptable_bodytype = BODYTYPE_KEPORI

/obj/item/bodypart/l_arm/kepori
	icon = 'icons/mob/species/kepori/bodyparts.dmi'
	icon_state = "kepori_l_arm"
	uses_mutcolor = TRUE
	limb_id = SPECIES_KEPORI
	bodytype = BODYTYPE_KEPORI | BODYTYPE_ORGANIC

/obj/item/bodypart/r_arm/kepori
	icon = 'icons/mob/species/kepori/bodyparts.dmi'
	icon_state = "kepori_r_arm"
	uses_mutcolor = TRUE
	limb_id = SPECIES_KEPORI
	bodytype = BODYTYPE_KEPORI | BODYTYPE_ORGANIC

/obj/item/bodypart/leg/left/kepori
	icon = 'icons/mob/species/kepori/bodyparts.dmi'
	icon_state = "kepori_l_leg"
	uses_mutcolor = TRUE
	limb_id = SPECIES_KEPORI
	bodytype = BODYTYPE_KEPORI | BODYTYPE_ORGANIC

/obj/item/bodypart/leg/right/kepori
	icon = 'icons/mob/species/kepori/bodyparts.dmi'
	icon_state = "kepori_r_leg"
	uses_mutcolor = TRUE
	limb_id = SPECIES_KEPORI
	bodytype = BODYTYPE_KEPORI | BODYTYPE_ORGANIC

/obj/item/bodypart/tail/kepori
	name = "kepori tail"
	desc = "A severed tail from a Kepori. Mostly just feathers."
	icon = 'icons/mob/species/kepori/bodyparts.dmi'
	icon_state = "kepori_tail"
	uses_mutcolor = TRUE
	limb_id = SPECIES_KEPORI
	bodytype = BODYTYPE_KEPORI | BODYTYPE_ORGANIC
	biological_state = BIO_FLESH | BIO_BLOODED // boneless
	can_wag = FALSE
	var/feathers

/obj/item/bodypart/tail/kepori/set_owner(new_owner)
	. = ..()
	if(. == FALSE)
		return
	if(owner)
		if(!feathers)
			feathers = owner.dna.features["kepori_tail_feathers"]
		else
			owner.dna.features["kepori_tail_feathers"] = feathers
		owner.dna.species.mutant_bodyparts |= "kepori_tail_feathers"
	else if(.)
		var/mob/living/carbon/old_owner = .
		old_owner.dna.species.mutant_bodyparts -= "kepori_tail_feathers"
		feathers = owner.dna.features["kepori_tail_feathers"]
