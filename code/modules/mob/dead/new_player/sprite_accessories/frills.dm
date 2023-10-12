/datum/sprite_accessory/frills
	key = "frills"
	generic = "Frills"
	default_color = DEFAULT_SECONDARY
	relevent_layers = list(BODY_ADJ_LAYER)
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/frills.dmi'

/datum/sprite_accessory/frills/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.try_hide_mutant_parts || (H.head.flags_inv & HIDEEARS) || !HD || HD.bodytype == BODYPART_ROBOTIC))
		return TRUE
	return FALSE

/datum/sprite_accessory/frills/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/frills/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/frills/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/frills/aquatic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/frills/frillhawk
	name = "Frillhawk"
	icon_state = "frillhawk"

/datum/sprite_accessory/frills/droopy
	name = "Droopy"
	icon_state = "droopy"

/datum/sprite_accessory/frills/neck
	name = "Neck"
	icon_state = "neck"

/datum/sprite_accessory/frills/neckbig
	name = "Frilled Dragon"
	icon_state = "neckbig"

/datum/sprite_accessory/frills/divinity
	name = "Divinity"
	icon_state = "divinity"

/datum/sprite_accessory/frills/horns
	name = "Horns"
	icon_state = "horns"

/datum/sprite_accessory/frills/hornsdouble
	name = "Horns Double"
	icon_state = "hornsdouble"

/datum/sprite_accessory/frills/big
	name = "Big"
	icon_state = "big"

/datum/sprite_accessory/frills/cobrahood
	name = "Cobra Hood"
	icon_state = "cobrahood"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/frills/cobrahoodears
	name = "Cobra Hood (Ears)"
	icon_state = "cobraears"
	color_src = USE_MATRIXED_COLORS
