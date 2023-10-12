/datum/species/lizard/reptile
	name = "\improper Reptillian"
	id = SPECIES_REPTILE

	species_language_holder = /datum/language_holder/lizard
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	mutanteyes = /obj/item/organ/eyes/lizard
	sclera_color = "#fffec4"
	blush_color = COLOR_BLUSH_TEAL

	species_chest = /obj/item/bodypart/chest/reptile
	species_head = /obj/item/bodypart/head/reptile
	species_l_arm = /obj/item/bodypart/l_arm/reptile
	species_r_arm = /obj/item/bodypart/r_arm/reptile
	species_l_leg = /obj/item/bodypart/leg/left/reptile
	species_r_leg = /obj/item/bodypart/leg/right/reptile

	loreblurb = "Generic term for any cold blooded species outside the Orion Bubble."

/obj/item/bodypart/head/reptile
	icon = 'modular_zubbers/modules/species/reptile/icons/bodyparts.dmi'
	limb_id = SPECIES_REPTILE
	uses_mutcolor = TRUE
	is_dimorphic = FALSE

/obj/item/bodypart/chest/reptile
	icon = 'modular_zubbers/modules/species/reptile/icons/bodyparts.dmi'
	uses_mutcolor = TRUE
	limb_id = SPECIES_REPTILE
	is_dimorphic = FALSE

/obj/item/bodypart/l_arm/reptile
	icon = 'modular_zubbers/modules/species/reptile/icons/bodyparts.dmi'
	uses_mutcolor = TRUE
	limb_id = SPECIES_REPTILE

/obj/item/bodypart/r_arm/reptile
	icon = 'modular_zubbers/modules/species/reptile/icons/bodyparts.dmi'
	uses_mutcolor = TRUE
	limb_id = SPECIES_REPTILE

/obj/item/bodypart/leg/left/reptile
	icon = 'modular_zubbers/modules/species/reptile/icons/bodyparts.dmi'
	uses_mutcolor = TRUE
	limb_id = SPECIES_REPTILE

/obj/item/bodypart/leg/right/reptile
	icon = 'modular_zubbers/modules/species/reptile/icons/bodyparts.dmi'
	uses_mutcolor = TRUE
	limb_id = SPECIES_REPTILE

/obj/item/bodypart/leg/left/reptile/digitigrade
	icon = 'modular_zubbers/modules/species/reptile/icons/bodyparts.dmi'
	icon_state = "lizard_l_leg_digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/reptile/digitigrade
	icon = 'modular_zubbers/modules/species/reptile/icons/bodyparts.dmi'
	icon_state = "lizard_r_leg_digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_DIGITIGRADE
