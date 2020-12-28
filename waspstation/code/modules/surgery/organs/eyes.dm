/obj/item/organ/eyes/compound
	name = "compound eyes"
	desc = "These eyes seem to have increased sensitivity to bright light, with some improvement to low light vision. It's like these eyes are looking everywhere at once!"
	icon = 'waspstation/icons/obj/surgery.dmi'
	icon_state = "compound_eyes"
	see_in_dark = 6
	flash_protect = FLASH_PROTECTION_SENSITIVE	//Obligatory flash sensitivity for balance
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT - 5	//This acts as *slightly* more powerful nightvision compared to the nightvision trait, if someone chooses NV as a trait it will be overwritten by this (highest wins).
	//This reason these eyes do not inherit from /night_vision/ is because the fullbright the night_vision subtype provides is too overpowered for a roundstart selectable race.
