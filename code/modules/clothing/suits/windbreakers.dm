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
		"white windbreaker" = "jacketwhite",
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
	unique_reskin_changes_inhand = TRUE

/obj/item/clothing/suit/toggle/windbreaker/Initialize()
	. = ..()
	base_icon_state = icon_state

/obj/item/clothing/suit/toggle/windbreaker/suit_toggle()
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

/obj/item/clothing/suit/toggle/windbreaker/white
	current_skin = "white windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/grey
	current_skin = "grey windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/black
	current_skin = "black windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/red
	current_skin = "red windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/maroon
	current_skin = "maroon windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/orange
	current_skin = "orange windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/yellow
	current_skin = "yellow windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/green
	current_skin = "green windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/darkgreen
	current_skin = "dark green windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/teal
	current_skin = "teal windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/blue
	current_skin = "blue windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/darkblue
	current_skin = "dark blue windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/purple
	current_skin = "purple windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/pink
	current_skin = "pink windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/brown
	current_skin = "brown windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/lightbrown
	current_skin = "light brown windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped
	name = "cropped windbreaker"
	desc = "A cropped windbreaker, made out of synthetic material. Good for keeping the chilly wind off only half the time."
	icon_state = "cropjacketwhite"
	item_state = "cropjacketwhite"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	unique_reskin = list(
		"white cropped windbreaker" = "cropjacketwhite",
		"grey cropped windbreaker" = "cropjacketgrey",
		"black cropped windbreaker" = "cropjacketblack",
		"red cropped windbreaker" = "cropjacketred",
		"maroon cropped windbreaker" = "cropjacketmaroon",
		"orange cropped windbreaker" = "cropjacketorange",
		"yellow cropped windbreaker" = "cropjacketyellow",
		"green cropped windbreaker" = "cropjacketgreen",
		"dark green cropped windbreaker" = "cropjacketdarkgreen",
		"teal cropped windbreaker" = "cropjacketteal",
		"blue cropped windbreaker" = "cropjacketblue",
		"dark blue cropped windbreaker" = "cropjacketdarkblue",
		"purple cropped windbreaker" = "cropjacketpurple",
		"pink cropped windbreaker" = "cropjacketpink",
		"brown cropped windbreaker" = "cropjacketbrown",
		"light brown cropped windbreaker" = "cropjacketlightbrown"
	)
	unique_reskin_changes_inhand = TRUE

/obj/item/clothing/suit/toggle/windbreaker/cropped/white
	current_skin = "white cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/grey
	current_skin = "grey cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/black
	current_skin = "black cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/red
	current_skin = "red cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/maroon
	current_skin = "maroon cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/orange
	current_skin = "orange cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/yellow
	current_skin = "yellow cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/green
	current_skin = "green cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/darkgreen
	current_skin = "dark green cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/teal
	current_skin = "teal cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/blue
	current_skin = "blue cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/darkblue
	current_skin = "dark blue cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/purple
	current_skin = "purple cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/pink
	current_skin = "pink cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/brown
	current_skin = "brown cropped windbreaker"

/obj/item/clothing/suit/toggle/windbreaker/cropped/lightbrown
	current_skin = "light brown cropped windbreaker"
