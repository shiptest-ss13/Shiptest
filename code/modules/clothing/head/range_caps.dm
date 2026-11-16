/obj/item/clothing/head/range
	name = "steppe range cap"
	desc = "An all-conditions headcover commonly found in surplus stores across the Frontier. The design features a neck-covering flap and chin strap which can be used to tie the hat up or down, depending on the weather."
	icon_state = "range-steppe_up"
	icon = 'icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head.dmi'
	vox_override_icon = 'icons/mob/species/vox/onmob_head_vox.dmi'
	kepori_override_icon = 'icons/mob/species/kepori/onmob_head_kepori.dmi'
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	cuttable = TRUE
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	clothamnt = 2
	obj_flags = INFINITE_RESKIN
	unique_reskin = list(
		"Tied up" = "range-steppe_up",
		"Tied down" = "range-steppe_down"
	)

/obj/item/clothing/head/range/tundra
	name = "tundra range cap"
	obj_flags = INFINITE_RESKIN
	icon_state = "range-tundra_up"
	unique_reskin = list(
		"Tied up" = "range-tundra_up",
		"Tied down" = "range-tundra_down"
	)

/obj/item/clothing/head/range/coyote
	name = "coyote range cap"
	obj_flags = INFINITE_RESKIN
	icon_state = "range-coyote_up"
	unique_reskin = list(
		"Tied up" = "range-coyote_up",
		"Tied down" = "range-coyote_down"
	)
