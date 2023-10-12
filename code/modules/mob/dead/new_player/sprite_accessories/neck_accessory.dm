/* god DAMNIT whirlsam you dont need this manny customization options just for you
/datum/sprite_accessory/neck_accessory
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/neck_accessory.dmi'
	key = "neck_acc"
	generic = "Neck Accessory"
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE

/datum/sprite_accessory/neck_accessory/none
	name = "None"
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/neck_accessory/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.wear_suit && (H.try_hide_mutant_parts || H.wear_suit.flags_inv & HIDEJUMPSUIT))
		return TRUE
	return FALSE

/datum/sprite_accessory/neck_accessory/sylveon_bow
	name = "Sylveon Neck Bow"
	icon_state = "sylveon_bow"
	recommended_species = list(SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTHHUMAN, SPECIES_HUMANOID)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	color_src = USE_MATRIXED_COLORS
	ckey_whitelist = list("whirlsam" = TRUE)
*/
