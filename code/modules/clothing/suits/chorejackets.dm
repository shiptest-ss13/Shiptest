// chorejackets

/obj/item/clothing/suit/toggle/chorejacket
	name = "chore jacket"
	desc = "A loose fitting jacket designed for labourers, featuring deep pockets and large buttons to enable easy access in work conditions."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "chorejacketwhite"
	base_icon_state = "chorejacketwhite"
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

/obj/item/clothing/suit/toggle/chorejacket/white
	icon_state = "chorejacketwhite"
	current_skin = "white chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/grey
	icon_state = "chorejacketgrey"
	current_skin = "grey chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/black
	icon_state = "chorejacketblack"
	current_skin = "black chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/red
	icon_state = "chorejacketred"
	current_skin = "red chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/maroon
	icon_state = "chorejacketmaroon"
	current_skin = "maroon chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/orange
	icon_state = "chorejacketorange"
	current_skin = "orange chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/yellow
	icon_state = "chorejacketyellow"
	current_skin = "yellow chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/green
	icon_state = "chorejacketgreen"
	current_skin = "green chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/darkgreen
	icon_state = "chorejacketdarkgreen"
	current_skin = "dark green chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/teal
	icon_state = "chorejacketteal"
	current_skin = "teal chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/blue
	icon_state = "chorejacketblue"
	current_skin = "blue chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/darkblue
	icon_state = "chorejacketdarkblue"
	current_skin = "dark blue chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/purple
	icon_state = "chorejacketpurple"
	current_skin = "purple chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/pink
	icon_state = "chorejacketpink"
	current_skin = "pink chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/brown
	icon_state = "chorejacketbrown"
	current_skin = "brown chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/lightbrown
	icon_state = "chorejacketlightbrown"
	current_skin = "light brown chorejacket"

/obj/item/clothing/suit/toggle/chorejacket/teceti
	name = "Riso-Teceian chore jacket"
	desc = "A loose fitting jacket of Riso-Teceian origin, featuring deep pockets and large buttons for easy access in work conditions. This one commemorates the Northern Teceti Coalition flag in it's design, where it proves extremely popular among agricultural workers."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	base_icon_state = "chorejacketteceti"
	icon_state = "chorejacketteceti"
	item_state = "chorejacketteceti"
	unique_reskin = null

/obj/item/clothing/suit/toggle/chorejacket/miski
	name = "Miskilamao Spacefaring chore jacket"
	desc = "A loose fitting jacket branded in Miskilamao Spacefaring's iconography. Deep pockets and large buttons ensure that the contents of the coat are accessible during work. Typically issued to line workers and sold in gift shops at Miski facilities. "
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	base_icon_state = "chorejacket_miski"
	icon_state = "chorejacket_miski"
	item_state = "chorejacket_miski"
	unique_reskin = null
