// Windbreakers

/obj/item/clothing/suit/toggle/windbreaker
	name = "windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you."
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	icon_state = "jacketwhite"
	item_state = "jacketwhite"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	togglename = "zipper"
	allowed = list(	/obj/item/flashlight,
					/obj/item/tank/internals/emergency_oxygen,
					/obj/item/tank/internals/plasmaman,
					/obj/item/toy,
					/obj/item/storage/fancy/cigarettes,
					/obj/item/lighter,
					/obj/item/radio,
					/obj/item/storage/pill_bottle
					)
	unique_reskin = list("white windbreaker" = "jacketwhite",
						"grey windbreaker" = "jacketgrey",
						"black windbreaker" = "jacketblack",
						"red windbreaker" = "jacketred",
						"maroon windbreaker" = "jacketmaroon",
						"orange windbreaker" = "jacketorange",
						"yellow windbreaker" = "jacketyellow",
						"green windbreaker" = "jacketgreen",
						"dark green windbreaker" = "jacketdarkgreen",
						"teal windbreaker" = "jacketteal",
						"blue windbreaker" = "jacketblue",
						"dark blue windbreaker" = "jacketdarkblue",
						"purple windbreaker" = "jacketpurple",
						"pink windbreaker" = "jacketpink",
						"brown windbreaker" = "jacketbrown",
						"light brown windbreaker" = "jacketlightbrown"
						)
	var/jacket_icon

/obj/item/clothing/suit/toggle/windbreaker/Initialize()
	. = ..()
	jacket_icon = icon_state

/obj/item/clothing/suit/toggle/windbreaker/examine(mob/user)
	. = ..()
	if(unique_reskin && !current_skin)
		. += "You can <b>Alt-Click</b> [src] to apply a new skin to it."

/obj/item/clothing/suit/toggle/windbreaker/reskin_obj(mob/M, change_name)
	. = ..()
	item_state = icon_state
	jacket_icon = icon_state
	return

/obj/item/clothing/suit/toggle/windbreaker/suit_toggle()
	set src in usr

	if(!can_use(usr))
		return 0

	to_chat(usr, span_notice("You toggle [src]'s [togglename]."))
	if(src.suittoggled)
		src.icon_state = "[jacket_icon]"
		src.suittoggled = FALSE
	else if(!src.suittoggled)
		src.icon_state = "[jacket_icon]_t"
		src.suittoggled = TRUE
	usr.update_inv_wear_suit()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/suit/toggle/windbreaker/white
	name = "white windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is white."
	icon_state = "jacketwhite"
	current_skin = "jacketwhite"

/obj/item/clothing/suit/toggle/windbreaker/grey
	name = "grey windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is grey."
	icon_state = "jacketgrey"
	current_skin = "jacketgrey"

/obj/item/clothing/suit/toggle/windbreaker/black
	name = "black windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is black."
	icon_state = "jacketblack"
	current_skin = "jacketblack"

/obj/item/clothing/suit/toggle/windbreaker/red
	name = "red windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is red."
	icon_state = "jacketred"
	current_skin = "jacketred"

/obj/item/clothing/suit/toggle/windbreaker/maroon
	name = "maroon windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is maroon."
	icon_state = "jacketmaroon"
	current_skin = "jacketmaroon"

/obj/item/clothing/suit/toggle/windbreaker/orange
	name = "orange windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is orange."
	icon_state = "jacketorange"
	current_skin = "jacketorange"

/obj/item/clothing/suit/toggle/windbreaker/yellow
	name = "yellow windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is yellow."
	icon_state = "jacketyellow"
	current_skin = "jacketyellow"

/obj/item/clothing/suit/toggle/windbreaker/green
	name = "green windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is green."
	icon_state = "jacketgreen"
	current_skin = "jacketgreen"

/obj/item/clothing/suit/toggle/windbreaker/darkgreen
	name = "dark green windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is dark green."
	icon_state = "jacketdarkgreen"
	current_skin = "jacketdarkgreen"

/obj/item/clothing/suit/toggle/windbreaker/teal
	name = "teal windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is teal."
	icon_state = "jacketteal"
	current_skin = "jacketteal"

/obj/item/clothing/suit/toggle/windbreaker/blue
	name = "blue windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is blue."
	icon_state = "jacketblue"
	current_skin = "jacketblue"

/obj/item/clothing/suit/toggle/windbreaker/darkblue
	name = "dark blue windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is dark blue."
	icon_state = "jacketdarkblue"
	current_skin = "jacketdarkblue"

/obj/item/clothing/suit/toggle/windbreaker/purple
	name = "purple windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is purple."
	icon_state = "jacketpurple"
	current_skin = "jacketpurple"

/obj/item/clothing/suit/toggle/windbreaker/pink
	name = "pink windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is pink."
	icon_state = "jacketpink"
	current_skin = "jacketpink"

/obj/item/clothing/suit/toggle/windbreaker/brown
	name = "brown windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is brown."
	icon_state = "jacketbrown"
	current_skin = "jacketbrown"

/obj/item/clothing/suit/toggle/windbreaker/lightbrown
	name = "light brown windbreaker"
	desc = "Sometimes called a windcheater, this is a simple jacket made of synthetic materials. Good for keeping the chilly wind off of you. This one is light brown."
	icon_state = "jacketlightbrown"
	current_skin = "jacketlightbrown"
