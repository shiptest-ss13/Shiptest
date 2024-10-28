
/obj/machinery/vending/cola
	name = "\improper RobustMore Softdrinks"
	desc = "A softdrink vendor provided by RobustMore DrinkFoods Industries, LLC."
	icon_state = "Cola_Machine"
	product_slogans = "RobustMore Softdrinks: More robust than a toolbox to the head!"
	product_ads = "Refreshing!;Hope you're thirsty!;Over 10 trillion drinks sold!;Thirsty? Why not cola?;Please, have a drink!;Drink up!;The best drinks this side of the galaxy."
	products = list(
		/obj/item/reagent_containers/food/drinks/soda_cans/cola = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/comet_trail = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/tadrixx = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/lunapunch = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/space_up = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/pacfuel = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/orange_soda = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/sol_dry = 10,
		/obj/item/reagent_containers/food/drinks/waterbottle = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/xeno_energy = 5,
		/obj/item/reagent_containers/food/drinks/soda_cans/vimukti = 6,
		/obj/item/reagent_containers/food/drinks/soda_cans/shoal_punch = 6)
	premium = list(
		/obj/item/reagent_containers/food/drinks/soda_cans/air = 1,
		/obj/item/reagent_containers/food/drinks/soda_cans/xeno_energy = 1,
		/obj/item/reagent_containers/food/drinks/soda_cans/crosstalk = 1)
	refill_canister = /obj/item/vending_refill/cola
	default_price = 45
	extra_price = 200


/obj/item/vending_refill/cola
	machine_name = "RobustMore Softdrinks"
	icon_state = "refill_cola"

/obj/machinery/vending/cola/blue
	icon_state = "Cola_Machine"
	light_mask = "cola-light-mask"
	light_color = COLOR_MODERATE_BLUE

/obj/machinery/vending/cola/black
	icon_state = "cola_black"
	light_mask = "cola-light-mask"

/obj/machinery/vending/cola/red
	icon_state = "red_cola"
	name = "\improper Master Cola Vendor"
	desc = "This vending machine offers Master Cola. Master Cola - have a drink from the past!"
	product_slogans = "Master Cola - have a drink from the past!"
	light_mask = "red_cola-light-mask"
	light_color = COLOR_DARK_RED

/obj/machinery/vending/cola/space_up
	icon_state = "space_up"
	name = "\improper Space-up! Vendor"
	desc = "Indulge in an explosion of flavor."
	product_slogans = "Space-up! Like a hull breach in your mouth."
	light_mask = "space_up-light-mask"
	light_color = COLOR_DARK_MODERATE_LIME_GREEN

/obj/machinery/vending/cola/starkist
	icon_state = "starkist"
	name = "\improper Lunapunch Vendor"
	desc = "What keeps the colonies running - Lunapunch."
	product_slogans = "The Colonies run on Lunapunch!"
	light_mask = "starkist-light-mask"
	light_color = COLOR_LIGHT_ORANGE

/obj/machinery/vending/cola/sodie
	icon_state = "soda"
	light_mask = "soda-light-mask"
	light_color = COLOR_WHITE

/obj/machinery/vending/cola/pwr_game
	icon_state = "pwr_game"
	name = "\improper PAC-Fuel Vendor"
	desc = "PAC-Fuel: stay flying straight. Enter the code on every can for a chance to win gamer merch or industrial equipment!"
	product_slogans = "Keep flying steady with PAC-Fuel!"
	light_mask = "pwr_game-light-mask"
	light_color = COLOR_STRONG_VIOLET

/obj/machinery/vending/cola/shamblers
	name = "\improper Shoal Punch Vendor"
	desc = "Every fruit you could want, at your beak! Shoal Punch!"
	icon_state = "shamblers_juice"
	products = list(
		/obj/item/reagent_containers/food/drinks/soda_cans/cola = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/comet_trail = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/tadrixx = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/lunapunch = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/space_up = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/pacfuel = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/orange_soda = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/sol_dry = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/shoal_punch = 10)
	product_slogans = "Every fruit you could want, at your beak! Shoal Punch!"
	product_ads = "Every fruit you could want, at your beak!;Don't go flying dry!;Over two trillion served!;Thirsty? Get punched!;Skrikira trikxti skrmikr rakti!;Don't go dry, get Shoal Punch."
	light_mask = "shamblers-light-mask"
	light_color = COLOR_MOSTLY_PURE_PINK
