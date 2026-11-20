// Track Jackets

/obj/item/clothing/suit/toggle/track
	name = "track jacket"
	desc = "A striped, baggy jacket built for running, loitering, and keeping you comfortable."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "tcoat"
	base_icon_state = "tcoat"
	item_state = "tcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	togglename = "zipper"
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
		"white track jacket" = "tcoatwhite",
		"black track jacket" = "tcoat",
		"red track jacket" = "tcoatred",
		"teal track jacket" = "tcoatteal",
		"blue track jacket" = "tcoatblue",
		"purple track jacket" = "tcoatpurple",
		"pink track jacket" = "tcoatpink"
	)

/obj/item/clothing/suit/toggle/track/white
	icon_state = "tcoatwhite"
	current_skin = "white track jacket"

/obj/item/clothing/suit/toggle/track/black
	icon_state = "tcoat"
	current_skin = "black track jacket"

/obj/item/clothing/suit/toggle/track/red
	icon_state = "tcoatred"
	current_skin = "red track jacket"

/obj/item/clothing/suit/toggle/track/teal
	icon_state = "tcoatteal"
	current_skin = "teal track jacket"

/obj/item/clothing/suit/toggle/track/blue
	icon_state = "tcoatblue"
	current_skin = "blue track jacket"

/obj/item/clothing/suit/toggle/track/purple
	icon_state = "tcoatpurple"
	current_skin = "purple track jacket"

/obj/item/clothing/suit/toggle/track/pink
	icon_state = "tcoatpink"
	current_skin = "pink track jacket"
