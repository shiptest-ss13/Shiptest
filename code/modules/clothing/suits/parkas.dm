/obj/item/clothing/suit/hooded/parka
	name = "parka"
	desc = "A thick parka made for the bleakest of temperatures."
	icon_state = "parka"
	item_state = "parka"
	icon = 'icons/obj/clothing/suits/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/color.dmi'
	hoodtype = /obj/item/clothing/head/hooded/parka
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
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
	supports_variations = DIGITIGRADE_VARIATION
	unique_reskin = list(
		"white parka" = "parkawhite",
		"black parka" = "parka",
		"red parka" = "parkared",
		"tan parka" = "parkatan",
		"green parka" = "parkagreen",
		"blue parka" = "parkablue",
		"pink parka" = "parkapink",
		"brown parka" = "parkabrown",
	)


/obj/item/clothing/suit/hooded/parka/update_appearance(updates)
	. = ..()
	if(isobj(hood))
		hood.icon_state = base_icon_state

/obj/item/clothing/head/hooded/parka
	name = "hood"
	desc = "A hood for your parka."
	icon_state = "parka"
	item_state = "parka"
	icon = 'icons/obj/clothing/head/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/color.dmi'
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/suit/hooded/parka/white
	name = "white parka"
	desc = "A parka that is white. It has a comfy pocket for keeping your hands warm."
	current_skin = "white parka"
	hoodtype = /obj/item/clothing/head/hooded/parka/white

/obj/item/clothing/head/hooded/parka/white
	name = "white hood"
	desc = "A white hood for your white parka."

/obj/item/clothing/suit/hooded/parka/black
	name = "black parka"
	desc = "A parka that is black. It has a comfy pocket for keeping your hands warm."
	current_skin = "black parka"
	hoodtype = /obj/item/clothing/head/hooded/parka

/obj/item/clothing/head/hooded/parka/black
	name = "black hood"
	desc = "A black hood for your black parka."

/obj/item/clothing/suit/hooded/parka/red
	name = "red parka"
	desc = "A parka that is red. It has a comfy pocket for keeping your hands warm."
	current_skin = "red parka"
	hoodtype = /obj/item/clothing/head/hooded/parka/red

/obj/item/clothing/head/hooded/parka/red
	name = "red hood"
	desc = "A red hood for your red parka."

/obj/item/clothing/suit/hooded/parka/tan
	name = "tan parka"
	desc = "A parka that is tan. It has a comfy pocket for keeping your hands warm."
	current_skin = "tan parka"
	hoodtype = /obj/item/clothing/head/hooded/parka/tan

/obj/item/clothing/head/hooded/parka/tan
	name = "tan hood"
	desc = "A tan hood for your tan parka."

/obj/item/clothing/suit/hooded/parka/green
	name = "green parka"
	desc = "A parka that is green. It has a comfy pocket for keeping your hands warm."
	current_skin = "green parka"
	hoodtype = /obj/item/clothing/head/hooded/parka/green

/obj/item/clothing/head/hooded/parka/green
	name = "green hood"
	desc = "A green hood for your green parka."

/obj/item/clothing/suit/hooded/parka/blue
	name = "blue parka"
	desc = "A parka that is blue. It has a comfy pocket for keeping your hands warm."
	current_skin = "blue parka"
	hoodtype = /obj/item/clothing/head/hooded/parka/blue

/obj/item/clothing/head/hooded/parka/blue
	name = "blue hood"
	desc = "A blue hood for your blue parka."

/obj/item/clothing/suit/hooded/parka/pink
	name = "pink parka"
	desc = "A parka that is pink. It has a comfy pocket for keeping your hands warm."
	current_skin = "pink parka"
	hoodtype = /obj/item/clothing/head/hooded/parka/pink

/obj/item/clothing/head/hooded/parka/pink
	name = "pink hood"
	desc = "A pink hood for your pink parka."

/obj/item/clothing/suit/hooded/parka/brown
	name = "brown parka"
	desc = "A parka that is brown. It has a comfy pocket for keeping your hands warm."
	current_skin = "brown parka"
	hoodtype = /obj/item/clothing/head/hooded/parka/brown

/obj/item/clothing/head/hooded/parka/brown
	name = "brown hood"
	desc = "A brown hood for your brown parka."


/obj/item/clothing/suit/hooded/parka/serene
	name = "serene sporting parka"
	desc = "A parka produced by serene sporting, in colonial league colors. Made from the thick fur of native serene fauna."
	icon_state = "parkaclip"
	item_state = "parkaclip"
	icon = 'icons/obj/clothing/suits/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/color.dmi'
	hoodtype = /obj/item/clothing/head/hooded/parka/serene
	unique_reskin = null

/obj/item/clothing/head/hooded/parka/serene
	name = "hood"
	desc = "A hood for your parka."
	icon = 'icons/obj/clothing/suits/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/color.dmi'
	icon_state = "parkaclip"
	item_state = "parkaclip"
