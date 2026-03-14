// overcoats

/obj/item/clothing/suit/toggle/overcoat
	name = "overcoat"
	desc = "A long, comfy, knee-length coat for both warmth and style."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "overcoatselago"
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
	unique_reskin_changes_inhand = TRUE

/obj/item/clothing/suit/toggle/overcoat/Initialize()
	. = ..()
	base_icon_state = icon_state

/obj/item/clothing/suit/toggle/overcoat/suit_toggle()
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

/obj/item/clothing/suit/toggle/overcoat/selago
	current_skin = "selago overcoat"

/obj/item/clothing/suit/toggle/overcoat/charcoal
	current_skin = "charcoal overcoat"

/obj/item/clothing/suit/toggle/overcoat/burgundy
	current_skin = "burgundy overcoat"

/obj/item/clothing/suit/toggle/overcoat/navy
	current_skin = "navy overcoat"

/obj/item/clothing/suit/toggle/overcoat/tan
	current_skin = "tan overcoat"

/obj/item/clothing/suit/toggle/overcoat/lightbrown
	current_skin = "light brown overcoat"

/obj/item/clothing/suit/toggle/overcoat/pink
	current_skin = "pink overcoat"
