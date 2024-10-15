/obj/item/organ/moth_wings
	name = "moth wings"
	desc = "A severed pair of moth wings. A moth somewhere is now slightly more useless."
	icon_state = "severedwings"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_WINGS

	linked_features = list(
		/datum/sprite_accessory/mutant_part/moth_wings::mutant_string = /datum/sprite_accessory/mutant_part/moth_wings/plain::name
	)
	variable_feature_data = TRUE

/obj/item/organ/moth_wings/examine(mob/user)
	. = ..()
	. += "They appear to be of the [linked_features[/datum/sprite_accessory/mutant_part/moth_wings::mutant_string]] variety."
