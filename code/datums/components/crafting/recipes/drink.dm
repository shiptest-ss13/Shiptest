/datum/crafting_recipe/umbrellared
	name = "Red Drink Umbrella"
	result = /obj/item/garnish/umbrellared
	time = 1 SECONDS
	tools = list(/obj/item/toy/crayon/spraycan)
	reqs = list(
		/obj/item/paper = 1,
		/obj/item/stack/rods = 1)
	category = CAT_DRINK

/datum/crafting_recipe/umbrellablue
	name = "Blue Drink Umbrella"
	result = /obj/item/garnish/umbrellablue
	time = 1 SECONDS
	tools = list(/obj/item/toy/crayon/spraycan)
	reqs = list(
		/obj/item/paper = 1,
		/obj/item/stack/rods = 1)
	category = CAT_DRINK

/datum/crafting_recipe/umbrellagreen
	name = "Green Drink Umbrella"
	result = /obj/item/garnish/umbrellagreen
	time = 1 SECONDS
	tools = list(/obj/item/toy/crayon/spraycan)
	reqs = list(
		/obj/item/paper = 1,
		/obj/item/stack/rods = 1)
	category = CAT_DRINK

/datum/crafting_recipe/ash_garnish
	name = "Ash Garnish"
	result = /obj/item/garnish/ash
	reqs = list(/datum/reagent/ash = 10)
	time = 5
	category = CAT_DRINK

/datum/crafting_recipe/salt_garnish
	name = "Salt Garnish"
	result = /obj/item/garnish/salt
	reqs = list(/datum/reagent/consumable/sodiumchloride = 10)
	time = 5
	category = CAT_DRINK

/datum/crafting_recipe/breakawayflask
	name = "Breakaway Flask"
	result = /obj/item/reagent_containers/food/drinks/breakawayflask
	time = 5 SECONDS
	reqs = list(/obj/item/stack/sheet/glass = 5,
				/obj/item/stack/sheet/mineral/plasma = 1)
	tools = list(TOOL_WELDER)
	category = CAT_DRINK
