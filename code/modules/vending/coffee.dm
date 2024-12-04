/obj/machinery/vending/coffee
	name = "\improper Solar's Best Hot Drinks"
	desc = "A vending machine which dispenses hot drinks."
	product_ads = "Have a drink!;Drink up!;It's good for you!;Would you like a hot joe?;I'd kill for some coffee!;The best beans in the galaxy.;Only the finest brew for you.;Mmmm. Nothing like a coffee.;I like coffee, don't you?;Coffee helps you work!;Try some tea.;We hope you like the best!;Try our new chocolate!;Admin conspiracies"
	icon_state = "coffee"
	icon_vend = "coffee-vend"
	products = list(
		/obj/item/reagent_containers/food/drinks/coffee = 6,
		/obj/item/reagent_containers/food/drinks/mug/tea = 6,
		/obj/item/reagent_containers/food/drinks/mug/coco = 3,
		/obj/item/reagent_containers/food/drinks/ice = 6)
	premium = list(
	/obj/item/reagent_containers/food/drinks/cafelatte = 3,
	/obj/item/reagent_containers/food/drinks/soylatte = 3)
	refill_canister = /obj/item/vending_refill/coffee
	default_price = 5
	extra_price = 15
	light_mask = "coffee-light-mask"
	light_color = COLOR_DARK_MODERATE_ORANGE

/obj/item/vending_refill/coffee
	machine_name = "Solar's Best Hot Drinks"
	icon_state = "refill_joe"
