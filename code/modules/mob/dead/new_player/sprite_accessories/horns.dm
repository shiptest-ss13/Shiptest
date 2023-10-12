/datum/sprite_accessory/horns
	key = "horns"
	generic = "Horns"
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER, BODY_ADJ_LAYER)
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/horns.dmi'
	default_color = "555"

/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
		return TRUE
	return FALSE

/datum/sprite_accessory/horns/angler
	default_color = DEFAULT_SECONDARY

/datum/sprite_accessory/horns/ram
	name = "Ram"
	icon_state = "ram"

/datum/sprite_accessory/horns/guilmon
	name = "Guilmon"
	icon_state = "guilmon"

/datum/sprite_accessory/horns/drake
	name = "Drake"
	icon_state = "drake"

/datum/sprite_accessory/horns/knight
	name = "Knight"
	icon_state = "knight"

/datum/sprite_accessory/horns/uni
	name = "Uni"
	icon_state = "uni"

//elzu
/datum/sprite_accessory/horns/elzu
	icon = 'icons/mob/ethereal_parts.dmi'
	recommended_species = list(SPECIES_ETHEREAL)

/datum/sprite_accessory/horns/elzu/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/horns/elzu/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/horns/elzu/helm
	name = "Helm"
	icon_state = "helm"

/datum/sprite_accessory/horns/elzu/lunar
	name = "Lunar"
	icon_state = "lunar"

/datum/sprite_accessory/horns/elzu/inward
	name = "Inward"
	icon_state = "inward"

/datum/sprite_accessory/horns/elzu/majesty
	name = "Majesty"
	icon_state = "majesty"

/datum/sprite_accessory/horns/elzu/clipped
	name = "Clipped"
	icon_state = "clipped"

/datum/sprite_accessory/horns/elzu/sharp
	name = "Sharp"
	icon_state = "sharp"
