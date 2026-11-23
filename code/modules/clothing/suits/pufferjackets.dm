// Pufferjackets

/obj/item/clothing/suit/toggle/pufferjacket
	name = "pufferjacket"
	desc = "A big, puffy vest. A great pick for the cold."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "pufferwhite"
	base_icon_state = "pufferwhite"
	item_state = "pufferwhite"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
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

/obj/item/clothing/suit/toggle/pufferjacket/white
	current_skin = "white pufferjacket"
	icon_state = "pufferwhite"

/obj/item/clothing/suit/toggle/pufferjacket/black
	current_skin = "black pufferjacket"
	icon_state = "pufferblack"

/obj/item/clothing/suit/toggle/pufferjacket/pink
	current_skin = "pink pufferjacket"
	icon_state = "pufferpink"

/obj/item/clothing/suit/toggle/pufferjacket/teal
	current_skin = "teal pufferjacket"
	icon_state = "pufferteal"

/obj/item/clothing/suit/toggle/pufferjacket/orange
	current_skin = "orange pufferjacket"
	icon_state = "pufferorange"

/obj/item/clothing/suit/toggle/puffervest
	name = "puffervest"
	desc = "A big, puffy vest. A great pick for fashion."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "pufvestwhite"
	base_icon_state = "pufvestwhite"
	item_state = "pufvestwhite"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
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

/obj/item/clothing/suit/toggle/puffervest/white
	icon_state = "pufvestwhite"
	current_skin = "white puffervest"

/obj/item/clothing/suit/toggle/puffervest/black
	icon_state = "pufvestblack"
	current_skin = "black puffervest"

/obj/item/clothing/suit/toggle/puffervest/pink
	icon_state = "pufvestpink"
	current_skin = "pink puffervest"

/obj/item/clothing/suit/toggle/puffervest/teal
	icon_state = "pufvestteal"
	current_skin = "teal puffervest"

/obj/item/clothing/suit/toggle/puffervest/orange
	icon_state = "pufvestorange"
	current_skin = "orange puffervest"
