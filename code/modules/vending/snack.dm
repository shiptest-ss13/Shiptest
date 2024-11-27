/obj/machinery/vending/snack
	name = "\improper Getmore Chocolate Corp"
	desc = "A snack machine courtesy of the RobustMore DrinkFoods LLC."
	product_slogans = "Try our new nougat bar!;Twice the calories for half the price!"
	product_ads = "The healthiest!;Award-winning chocolate bars!;Mmm! So good!;Have a snack.;Snacks are good for you!;Have something better! Get RobustMore!;Best quality snacks!;We love chocolate!;Try our new jerky!"
	icon_state = "snack"
	light_mask = "snack-light-mask"
	products = list(
		/obj/item/reagent_containers/food/snacks/spacetwinkie = 6,
		/obj/item/reagent_containers/food/snacks/cheesiehonkers = 6,
		/obj/item/reagent_containers/food/snacks/candy = 6,
		/obj/item/reagent_containers/food/snacks/chips = 6,
		/obj/item/reagent_containers/food/snacks/sosjerky = 6,
		/obj/item/reagent_containers/food/snacks/no_raisin = 6,
		/obj/item/reagent_containers/food/drinks/dry_ramen = 3,
		/obj/item/storage/box/gum = 3,
		/obj/item/reagent_containers/food/snacks/energybar = 6,
		/obj/item/reagent_containers/food/snacks/syndicake = 6,
		)
	refill_canister = /obj/item/vending_refill/snack
	canload_access_list = list(ACCESS_KITCHEN)
	default_price = 5
	extra_price = 10
	input_display_header = "Chef's Food Selection"

/obj/item/vending_refill/snack
	machine_name = "RobustMore DrinkFoods LLC"

/obj/machinery/vending/snack/blue
	icon_state = "snackblue"

/obj/machinery/vending/snack/orange
	icon_state = "snackorange"

/obj/machinery/vending/snack/green
	icon_state = "snackgreen"

/obj/machinery/vending/snack/teal
	icon_state = "snackteal"
