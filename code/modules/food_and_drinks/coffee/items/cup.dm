//the hell is it with the drinks subtype and using hacky workarounds for reagent fillings...
/obj/item/reagent_containers/food/drinks/coffee
	name = "coffee cup"
	desc = "A plastic coffee cup. Can theoretically be used for other hot drinks, if you're feeling adventurous."
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "coffee_cup"
	possible_transfer_amounts = list(10)
	volume = 30
	spillable = TRUE
	fill_icon_thresholds = list(30, 90)
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	spillable = TRUE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	foodtype = BREAKFAST

/obj/item/reagent_containers/food/drinks/coffee/empty
	list_reagents = null
	desc = "A plastic coffee cup. It's empty."

/obj/item/reagent_containers/food/drinks/coffee/large
	name = "paper coffee cup"
	desc = "A larger paper cup for coffee, usually found in cafes. Comes with a lid!"
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "paper_coffee"
	volume = 50
	can_have_cap = TRUE
	cap_icon_state = "paper_coffee_cap"
	list_reagents = list(/datum/reagent/consumable/coffee = 50)
	can_have_cap = TRUE
	fill_icon_thresholds = list(20,30,35,45)
	fill_icon_thresholds = list(30, 50, 70, 90)
	spillable = TRUE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	foodtype = BREAKFAST

/obj/item/reagent_containers/food/drinks/coffee/large/empty
	list_reagents = null
