// Pufferjackets

/obj/item/clothing/suit/toggle/pufferjacket
	name = "pufferjacket"
	desc = "A big, puffy vest. A great pick for the cold."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "pufferwhite"
	item_state = "pufferwhite"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	supports_variations = VOX_VARIATION
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
		"white pufferjacket" = "pufferwhite",
		"black pufferjacket" = "pufferblack",
		"pink pufferjacket" = "pufferpink",
		"teal pufferjacket" = "pufferteal",
		"orange pufferjacket" = "pufferorange",
	)
	unique_reskin_changes_inhand = TRUE

/obj/item/clothing/suit/toggle/pufferjacket/Initialize()
	. = ..()
	base_icon_state = icon_state

/obj/item/clothing/suit/toggle/pufferjacket/suit_toggle()
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

/obj/item/clothing/suit/toggle/pufferjacket/white
	current_skin = "white pufferjacket"

/obj/item/clothing/suit/toggle/pufferjacket/black
	current_skin = "black pufferjacket"

/obj/item/clothing/suit/toggle/pufferjacket/pink
	current_skin = "pink pufferjacket"

/obj/item/clothing/suit/toggle/pufferjacket/teal
	current_skin = "teal pufferjacket"

/obj/item/clothing/suit/toggle/pufferjacket/orange
	current_skin = "orange pufferjacket"

/obj/item/clothing/suit/toggle/puffervest
	name = "puffervest"
	desc = "A big, puffy vest. A great pick for fashion."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "pufvestwhite"
	item_state = "pufvestwhite"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
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
		"white puffervest" = "pufvestwhite",
		"black puffervest" = "pufvestblack",
		"pink puffervest" = "pufvestpink",
		"teal puffervest" = "pufvestteal",
		"orange puffervest" = "pufvestorange",
	)
	unique_reskin_changes_inhand = TRUE

/obj/item/clothing/suit/toggle/puffervest/Initialize()
	. = ..()
	base_icon_state = icon_state

/obj/item/clothing/suit/toggle/puffervest/suit_toggle()
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

/obj/item/clothing/suit/toggle/puffervest/white
	current_skin = "white puffervest"

/obj/item/clothing/suit/toggle/puffervest/black
	current_skin = "black puffervest"

/obj/item/clothing/suit/toggle/puffervest/pink
	current_skin = "pink puffervest"

/obj/item/clothing/suit/toggle/puffervest/teal
	current_skin = "teal puffervest"

/obj/item/clothing/suit/toggle/puffervest/orange
	current_skin = "orange puffervest"
