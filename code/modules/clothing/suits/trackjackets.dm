// Track Jackets

/obj/item/clothing/suit/toggle/track
	name = "track jacket"
	desc = "A striped, baggy jacket built for running, loitering, and keeping you comfortable."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "tcoat"
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
	unique_reskin_changes_inhand = TRUE

/obj/item/clothing/suit/toggle/track/Initialize()
	. = ..()
	base_icon_state = icon_state

/obj/item/clothing/suit/toggle/track/suit_toggle()
	set src in usr

	if(!can_use(usr))
		return 0

	to_chat(usr, span_notice("You toggle [src]'s [togglename]."))
	if(src.suittoggled)
		src.icon_state = "[base_icon_state]"
		src.suittoggled = FALSE
	else if(!src.suittoggled)
		src.icon_state = "[base_icon_state]_t"
		src.suittoggled = TRUE
	usr.update_inv_wear_suit()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/suit/toggle/track/white
	current_skin = "white track jacket"

/obj/item/clothing/suit/toggle/track/black
	current_skin = "black track jacket"

/obj/item/clothing/suit/toggle/track/teal
	current_skin = "teal track jacket"

/obj/item/clothing/suit/toggle/track/red
	current_skin = "red track jacket"

/obj/item/clothing/suit/toggle/track/blue
	current_skin = "blue track jacket"

/obj/item/clothing/suit/toggle/track/purple
	current_skin = "purple track jacket"

/obj/item/clothing/suit/toggle/track/pink
	current_skin = "pink track jacket"


