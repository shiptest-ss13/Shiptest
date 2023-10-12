/* //is this nessary??
/datum/sprite_accessory/head_accessory
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/head_accessory.dmi'
	key = "head_acc"
	generic = "Head Accessory"
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE

/datum/sprite_accessory/head_accessory/none
	name = "None"
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/head_accessory/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)))
		return TRUE
	return FALSE

/datum/sprite_accessory/head_accessory/sylveon_bow
	name = "Sylveon Head Bow"
	icon_state = "sylveon_bow"
	recommended_species = list(SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTHHUMAN, SPECIES_HUMANOID)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	color_src = USE_MATRIXED_COLORS
	ckey_whitelist = list("whirlsam" = TRUE) // oh thats why
*/
