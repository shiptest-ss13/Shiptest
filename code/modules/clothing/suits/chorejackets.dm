// chorejackets

/obj/item/clothing/suit/toggle/chorejacket
	name = "chore jacket"
	desc = "A loose fitting jacket designed for labourers, featuring deep pockets and large buttons to enable easy access in work conditions."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "chorejacketwhite"
	item_state = "chorejacketwhite"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	supports_variations = KEPORI_VARIATION
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	togglename = "buttons"
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
		"white chorejacket" = "chorejacketwhite",
		"grey chorejacket" = "chorejacketgrey",
		"black chorejacket" = "chorejacketblack",
		"red chorejacket" = "chorejacketred",
		"maroon chorejacket" = "chorejacketmaroon",
		"orange chorejacket" = "chorejacketorange",
		"yellow chorejacket" = "chorejacketyellow",
		"green chorejacket" = "chorejacketgreen",
		"dark green chorejacket" = "chorejacketdarkgreen",
		"teal chorejacket" = "chorejacketteal",
		"blue chorejacket" = "chorejacketblue",
		"dark blue chorejacket" = "chorejacketdarkblue",
		"purple chorejacket" = "chorejacketpurple",
		"pink chorejacket" = "chorejacketpink",
		"brown chorejacket" = "chorejacketbrown",
		"light brown chorejacket" = "chorejacketlightbrown"
	)
	unique_reskin_changes_inhand = TRUE

/obj/item/clothing/suit/toggle/chorejacket/Initialize()
	. = ..()
	base_icon_state = icon_state

/obj/item/clothing/suit/toggle/chorejacket/suit_toggle()
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

/obj/item/clothing/suit/toggle/chorejacket/white
	current_skin = "white chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/grey
	current_skin = "grey chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/black
	current_skin = "black chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/red
	current_skin = "red chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/maroon
	current_skin = "maroon chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/orange
	current_skin = "orange chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/yellow
	current_skin = "yellow chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/green
	current_skin = "green chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/darkgreen
	current_skin = "dark green chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/teal
	current_skin = "teal chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/blue
	current_skin = "blue chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/darkblue
	current_skin = "dark blue chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/purple
	current_skin = "purple chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/pink
	current_skin = "pink chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/brown
	current_skin = "brown chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/lightbrown
	current_skin = "light brown chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/teceti
	name = "Riso-Teceian chore jacket"
	desc = "A loose fitting jacket of Riso-Teceian origin, featuring deep pockets and large buttons for easy access in work conditions. This one commemorates the Northern Teceti Coalition flag in it's design, where it proves extremely popular among agricultural workers."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "chorejacketteceti"
	item_state = "chorejacketteceti"
	unique_reskin = null
