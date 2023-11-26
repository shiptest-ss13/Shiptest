
// see code/module/crafting/table.dm

////////////////////////////////////////////////PIZZA!!!////////////////////////////////////////////////

/datum/crafting_recipe/food/margheritapizza
	name = "Margherita pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 4,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/margherita
	subcategory = CAT_PIZZA

/datum/crafting_recipe/food/meatpizza
	name = "Meat pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 4,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/meat
	subcategory = CAT_PIZZA

/datum/crafting_recipe/food/arnold
	name = "Arnold pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 3,
		/obj/item/ammo_casing/c9mm = 8,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/arnold
	subcategory = CAT_PIZZA

/datum/crafting_recipe/food/mushroompizza
	name = "Mushroom pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom = 5
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/mushroom
	subcategory = CAT_PIZZA

/datum/crafting_recipe/food/vegetablepizza
	name = "Vegetable pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/corn = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/vegetable
	subcategory = CAT_PIZZA

/datum/crafting_recipe/food/donkpocketpizza
	name = "Donkpocket pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/donkpocket/warm = 3,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/donkpocket
	subcategory = CAT_PIZZA

/datum/crafting_recipe/food/dankpizza
	name = "Dank pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/vulgaris = 3,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/dank
	subcategory = CAT_PIZZA

/datum/crafting_recipe/food/sassysagepizza
	name = "Sassysage pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 3,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/sassysage
	subcategory = CAT_PIZZA

/datum/crafting_recipe/food/pineapplepizza
	name = "Hawaiian pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/obj/item/reagent_containers/food/snacks/pineappleslice = 3,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/pineapple
	subcategory = CAT_PIZZA

/datum/crafting_recipe/food/raw_mothic_margherita
	name = "Mothic margherita pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/mothic_pizza_dough = 1,
		/obj/item/reagent_containers/food/snacks/tomato_sauce = 1,
		/obj/item/reagent_containers/food/snacks/mozzarella = 1,
		/obj/item/reagent_containers/food/snacks/firm_cheese = 1,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raw_mothic_margherita
	subcategory = CAT_MOTH

/datum/crafting_recipe/food/raw_mothic_firecracker
	name = "Mothic firecracker pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/mothic_pizza_dough = 1,
		/datum/reagent/consumable/bbqsauce = 10,
		/obj/item/reagent_containers/food/snacks/firm_cheese = 1,
		/obj/item/reagent_containers/food/snacks/oven_baked_corn = 1,
		/obj/item/reagent_containers/food/snacks/grown/ghost_chili = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raw_mothic_firecracker
	subcategory = CAT_MOTH

/datum/crafting_recipe/food/raw_mothic_five_cheese
	name = "Mothic five cheese pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/mothic_pizza_dough = 1,
		/obj/item/reagent_containers/food/snacks/tomato_sauce = 1,
		/obj/item/reagent_containers/food/snacks/firm_cheese = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/mozzarella = 1,
		/obj/item/reagent_containers/food/snacks/herby_cheese = 1,
		/obj/item/reagent_containers/food/snacks/cheese_curds = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raw_mothic_five_cheese
	subcategory = CAT_MOTH

/datum/crafting_recipe/food/raw_mothic_white_pie
	name = "Mothic white pie pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/mothic_pizza_dough = 1,
		/obj/item/reagent_containers/food/snacks/bechamel_sauce = 1,
		/obj/item/reagent_containers/food/snacks/firm_cheese = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/obj/item/reagent_containers/food/snacks/mozzarella = 1,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raw_mothic_white_pie
	subcategory = CAT_MOTH

/datum/crafting_recipe/food/raw_mothic_pesto
	name = "Mothic pesto pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/mothic_pizza_dough = 1,
		/obj/item/reagent_containers/food/snacks/pesto = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/mozzarella = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raw_mothic_pesto
	subcategory = CAT_MOTH

/datum/crafting_recipe/food/raw_mothic_garlic
	name = "Mothic garlic pizzabread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/mothic_pizza_dough = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raw_mothic_garlic
	subcategory = CAT_MOTH
