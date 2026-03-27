/obj/item/clothing/head/ribbon
	name = "ribbon"
	desc = "A small, decorative ribbon."
	icon = 'icons/obj/clothing/head/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/color.dmi'
	icon_state = "ribbonblack"
	item_state = "ribbonblack"
	alternate_worn_layer = BODY_FRONT_LAYER
	supports_variations = KEPORI_VARIATION | VOX_VARIATION
	unique_reskin = list(
		"white ribbon" = "ribbonwhite",
		"grey ribbon" = "ribbongrey",
		"black ribbon" = "ribbonblack",
		"maroon ribbon" = "ribbonmaroon",
		"red ribbon" = "ribbonred",
		"orange ribbon" = "ribbonorange",
		"yellow ribbon" = "ribbonyellow",
		"green ribbon" = "ribbongreen",
		"dark green ribbon" = "ribbondarkgreen",
		"teal ribbon" = "ribbonteal",
		"blue ribbon" = "ribbonblue",
		"dark blue ribbon" = "ribbondarkblue",
		"purple ribbon" = "ribbonpurple",
		"pink ribbon" = "ribbonpink",
		"brown ribbon" = "ribbonbrown",
		"light brown ribbon" = "ribbonlightbrown",
	)
	unique_reskin_changes_name = TRUE

/obj/item/clothing/head/ribbon/AltClick(mob/user)
	. = ..()
	if(slot_flags == ITEM_SLOT_HEAD)
		slot_flags = ITEM_SLOT_EARS
		to_chat(user, span_notice("You adjust [src] to fit on your ear"))
	else
		slot_flags = ITEM_SLOT_HEAD
		to_chat(user, span_notice("You adjust [src] to fit on your head"))

/obj/item/clothing/head/ribbon/white
	name = "white ribbon"
	icon_state = "ribbonwhite"
	current_skin = "white ribbon"

/obj/item/clothing/head/ribbon/grey
	name = "grey ribbon"
	icon_state = "ribbongrey"
	current_skin = "grey ribbon"

/obj/item/clothing/head/ribbon/black
	name = "black ribbon"
	icon_state = "ribbonblack"
	current_skin = "black ribbon"

/obj/item/clothing/head/ribbon/maroon
	name = "maroon ribbon"
	icon_state = "ribbonmaroon"
	current_skin = "maroon ribbon"

/obj/item/clothing/head/ribbon/red
	name = "red ribbon"
	icon_state = "ribbonred"
	current_skin = "red ribbon"

/obj/item/clothing/head/ribbon/orange
	name = "orange ribbon"
	icon_state = "ribbonorange"
	current_skin = "orange ribbon"

/obj/item/clothing/head/ribbon/yellow
	name = "yellow ribbon"
	icon_state = "ribbonyellow"
	current_skin = "yellow ribbon"

/obj/item/clothing/head/ribbon/green
	name = "green ribbon"
	icon_state = "ribbongreen"
	current_skin = "green ribbon"

/obj/item/clothing/head/ribbon/darkgreen
	name = "dark green ribbon"
	icon_state = "ribbondarkgreen"
	current_skin = "dark green ribbon"

/obj/item/clothing/head/ribbon/teal
	name = "teal ribbon"
	icon_state = "ribbonteal"
	current_skin = "teal ribbon"

/obj/item/clothing/head/ribbon/blue
	name = "blue ribbon"
	icon_state = "ribbonblue"
	current_skin = "blue ribbon"

/obj/item/clothing/head/ribbon/darkblue
	name = "dark blue ribbon"
	icon_state = "ribbondarkblue"
	current_skin = "dark blue ribbon"

/obj/item/clothing/head/ribbon/purple
	name = "purple ribbon"
	icon_state = "ribbonpurple"
	current_skin = "purple ribbon"

/obj/item/clothing/head/ribbon/pink
	name = "ribbon"
	icon_state = "ribbonpink"
	current_skin = "pink ribbon"

/obj/item/clothing/head/ribbon/brown
	name = "brown ribbon"
	icon_state = "ribbonbrown"
	current_skin = "brown ribbon"

/obj/item/clothing/head/ribbon/lightbrown
	name = "light brown ribbon"
	icon_state = "ribbonlightbrown"
	current_skin = "light brown ribbon"
