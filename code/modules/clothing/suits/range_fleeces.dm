/obj/item/clothing/suit/toggle/fleece
	name = "range fleece"
	desc = "Made from a deceptively warm faux-wool blend and covered in zipper-pockets, range fleeces like this are popular items in surplus stores across the Frontier."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	vox_override_icon = 'icons/mob/species/vox/onmob_suit_vox.dmi'
	kepori_override_icon = 'icons/mob/species/kepori/onmob_suit_kepori.dmi'
	icon_state = "fleece-steppe"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	togglename = "zipper"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large
	allowed = list(
		/obj/item/flashlight,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/lighter,
		/obj/item/radio,
		/obj/item/storage/pill_bottle
	)
	unique_reskin = list(
		"steppe range fleece" = "fleece-steppe",
		"tundra range fleece" = "fleece-tundra",
		"coyote range fleece" = "fleece-coyote"
	)
	unique_reskin_changes_name = TRUE

/obj/item/clothing/suit/toggle/fleece/Initialize()
	. = ..()
	base_icon_state = icon_state

/obj/item/clothing/suit/toggle/fleece/steppe
	current_skin = "steppe range fleece"

/obj/item/clothing/suit/toggle/fleece/tundra
	current_skin = "tundra range fleece"

/obj/item/clothing/suit/toggle/fleece/coyote
	current_skin = "coyote range fleece"
