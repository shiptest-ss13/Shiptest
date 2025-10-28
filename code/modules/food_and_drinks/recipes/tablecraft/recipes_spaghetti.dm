//Spaghetti
/datum/crafting_recipe/food/tomatopasta
	name = "Tomato pasta"
	reqs = list(
		/obj/item/food/spaghetti/boiledspaghetti = 1,
		/obj/item/food/grown/tomato = 2
	)
	result = /obj/item/food/spaghetti/pastatomato
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/spaghettimeatball
	name = "Spaghetti meatball"
	reqs = list(
		/obj/item/food/spaghetti/boiledspaghetti = 1,
		/obj/item/food/meatball = 2
	)
	result = /obj/item/food/spaghetti/meatballspaghetti
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/beefnoodle
	name = "Beef noodle"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/food/spaghetti/boiledspaghetti = 1,
		/obj/item/food/meat/cutlet = 2,
		/obj/item/food/grown/cabbage = 1
	)
	result = /obj/item/food/spaghetti/beefnoodle
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/chowmein
	name = "Chowmein"
	reqs = list(
		/obj/item/food/spaghetti/boiledspaghetti = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/cabbage = 2,
		/obj/item/food/grown/carrot = 1
	)
	result = /obj/item/food/spaghetti/chowmein
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/butternoodles
	name = "Butter Noodles"
	reqs = list(
		/obj/item/food/spaghetti/boiledspaghetti = 1,
		/obj/item/food/butter = 1
	)
	result = /obj/item/food/spaghetti/butternoodles
	subcategory = CAT_SPAGHETTI
