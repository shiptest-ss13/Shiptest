/obj/item/reagent_containers/glass/coffee_cup
	name = "coffee cup"
	desc = "A heat-formed plastic coffee cup. Can theoretically be used for other hot drinks, if you're feeling adventurous."
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "coffee_cup_e"
	possible_transfer_amounts = list(10)
	volume = 30
	spillable = TRUE
	fill_icon_state = "coffee_cup"
	fill_icon_thresholds = list(0, 1)

/obj/item/reagent_containers/food/drinks/coffee/empty
	name = "empty paper coffee cup"
	desc = "A cup for coffee. Comes with a free lid!"
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "coffee_empty"
	list_reagents = null
	var/lid_open = 0
	spillable = TRUE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	foodtype = BREAKFAST

/obj/item/reagent_containers/food/drinks/coffee/empty/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to toggle cup lid.</span>"
	return

/obj/item/reagent_containers/food/drinks/coffee/empty/AltClick(mob/user)
	lid_open = lid_open ? 0 : 1
	update_icon_state()
	return ..()

/obj/item/reagent_containers/food/drinks/coffee/empty/update_icon_state()
	if(lid_open)
		icon_state = reagents.total_volume ? "coffee_full" : "coffee_empty"
	else
		icon_state = "coffee"
	return ..()
