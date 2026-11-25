// overcoats

/obj/item/clothing/suit/toggle/overcoat
	name = "overcoat"
	desc = "A long, comfy, knee-length coat for both warmth and style."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "overcoatselago"
	base_icon_state = "overcoatselago"
	item_state = "overcoatselago"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	togglename = "buttons"
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
		"selago overcoat" = "overcoatselago",
		"charcoal overcoat" = "overcoatcharcoal",
		"burgundy overcoat" = "overcoatburgundy",
		"navy overcoat" = "overcoatnavy",
		"tan overcoat" = "overcoattan",
		"light brown overcoat" = "overcoatlightbrown",
		"pink overcoat" = "overcoatpink",
	)

/obj/item/clothing/suit/toggle/overcoat/selago
	icon_state = "overcoatselago"
	current_skin = "selago overcoat"

/obj/item/clothing/suit/toggle/overcoat/charcoal
	icon_state = "overcoatcharcoal"
	current_skin = "charcoal overcoat"

/obj/item/clothing/suit/toggle/overcoat/burgundy
	icon_state = "overcoatburgundy"
	current_skin = "burgundy overcoat"

/obj/item/clothing/suit/toggle/overcoat/navy
	icon_state = "overcoatnavy"
	current_skin = "navy overcoat"

/obj/item/clothing/suit/toggle/overcoat/tan
	icon_state = "overcoattan"
	current_skin = "tan overcoat"

/obj/item/clothing/suit/toggle/overcoat/lightbrown
	icon_state = "overcoatlightbrown"
	current_skin = "light brown overcoat"

/obj/item/clothing/suit/toggle/overcoat/pink
	icon_state = "overcoatpink"
	current_skin = "pink overcoat"
