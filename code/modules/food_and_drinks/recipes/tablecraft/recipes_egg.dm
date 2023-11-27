
// see code/module/crafting/table.dm

////////////////////////////////////////////////EGG RECIPE's////////////////////////////////////////////////

/datum/crafting_recipe/food/friedegg
	name = "Fried egg"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 1,
		/datum/reagent/consumable/blackpepper = 1,
		/obj/item/reagent_containers/food/snacks/egg = 1
	)
	result = /obj/item/reagent_containers/food/snacks/friedegg
	subcategory = CAT_EGG

/datum/crafting_recipe/food/omelette
	name = "Omelette"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/egg = 2,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2
	)
	result = /obj/item/reagent_containers/food/snacks/omelette
	subcategory = CAT_EGG

/datum/crafting_recipe/food/chocolateegg
	name = "Chocolate egg"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/boiledegg = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1
	)
	result = /obj/item/reagent_containers/food/snacks/chocolateegg
	subcategory = CAT_EGG

/datum/crafting_recipe/food/eggsbenedict
	name = "Eggs benedict"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/friedegg = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak = 1,
		/obj/item/reagent_containers/food/snacks/breadslice/plain = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/benedict
	subcategory = CAT_EGG

/datum/crafting_recipe/food/eggbowl
	name = "Egg bowl"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/boiledegg = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/corn = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/eggbowl
	subcategory = CAT_EGG

/datum/crafting_recipe/food/eggrolls
	name = "Eggrolls"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/seaweed = 1,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/friedegg = 1
	)
	result = /obj/item/reagent_containers/food/snacks/eggrolls
	subcategory = CAT_EGG

/datum/crafting_recipe/food/black_eggs
	name = "Black scrambled eggs"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/egg = 2,
		/datum/reagent/blood = 5,
		/datum/reagent/consumable/vinegar = 2
	)
	result = /obj/item/reagent_containers/food/snacks/black_eggs
	subcategory = CAT_EGG

/datum/crafting_recipe/food/patzikula
	name = "Patzikula"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/tomato = 2,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/egg = 2
	)
	result = /obj/item/reagent_containers/food/snacks/patzikula
	subcategory = CAT_EGG
