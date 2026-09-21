//the hell is it with the drinks subtype and using hacky workarounds for reagent fillings...
/obj/item/reagent_containers/food/drinks/coffee
	name = "paper cup"
	desc = "A paper cup, often filled with coffee."
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
	desc = "A paper cup. It's empty."

//subtype that uses the vending machine's text
/obj/item/reagent_containers/food/drinks/coffee/vendingmachine
	name = "Solar's Best black coffee"
	desc = "A cup of piping hot black coffee. Made from beans grown across the solar cantons for the caffeine that every spacer needs."

/obj/item/reagent_containers/food/drinks/coffee/vendingmachine/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/coffee/large
	name = "large paper coffee cup"
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
