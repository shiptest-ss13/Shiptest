/datum/crafting_recipe/food/burger
	name = "Burger"
	reqs = list(
		/obj/item/food/patty/plain = 1,
		/obj/item/food/bun = 1,
	)

	result = /obj/item/food/burger/plain
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/xenoburger
	name = "Xeno burger"
	reqs = list(
		/obj/item/food/patty/xeno = 1,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/xeno
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/bearger
	name = "Bearger"
	reqs = list(
		/obj/item/food/patty/bear = 1,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/bearger
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/fishburger
	name = "Fish burger"
	reqs = list(
		/obj/item/food/fishmeat = 1,
		/obj/item/food/cheese/wedge = 1,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/fish
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/tofuburger
	name = "Tofu burger"
	reqs = list(
		/obj/item/food/tofu = 1,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/tofu
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/bigbiteburger
	name = "Big bite burger"
	reqs = list(
		/obj/item/food/patty/plain = 3,
		/obj/item/food/cheese/wedge = 2,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/bigbite
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/superbiteburger
	name = "Super bite burger"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 5,
		/datum/reagent/consumable/blackpepper = 5,
		/obj/item/food/patty/plain = 5,
		/obj/item/food/grown/tomato = 4,
		/obj/item/food/cheese/wedge = 3,
		/obj/item/food/boiledegg = 1,
		/obj/item/food/meat/bacon = 1,
		/obj/item/food/bun = 1,

	)
	result = /obj/item/food/burger/superbite
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/slimeburger
	name = "Jelly burger"
	reqs = list(
		/datum/reagent/toxin/slimejelly = 5,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/jelly/slime
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/jellyburger
	name = "Jelly burger"
	reqs = list(
		/datum/reagent/consumable/cherryjelly = 5,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/jelly/cherry
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/fivealarmburger
	name = "Five alarm burger"
	reqs = list(
		/obj/item/food/meat/steak/plain = 1,
		/obj/item/food/grown/ghost_chili = 2,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/fivealarm
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/ratburger
	name = "Rat burger"
	reqs = list(
		/obj/item/food/deadmouse,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/rat
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/baseballburger
	name = "Home run baseball burger"
	reqs = list(
		/obj/item/melee/baseball_bat = 1,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/baseball
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/baconburger
	name = "Bacon Burger"
	reqs = list(
		/obj/item/food/meat/bacon = 3,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/baconburger
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/empoweredburger
	name = "Empowered Burger"
	reqs = list(
		/obj/item/stack/sheet/mineral/plasma = 2,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/empoweredburger
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/crabburger
	name = "Crab Burger"
	reqs = list(
		/obj/item/food/meat/crab = 2,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/crab
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/cheeseburger
	name = "Cheese Burger"
	reqs = list(
		/obj/item/food/patty/plain = 1,
		/obj/item/food/cheese/wedge = 1,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/cheese
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/soylentburger
	name = "Soylent Burger"
	reqs = list(
		/obj/item/food/soylentgreen = 1, //two full meats worth.
		/obj/item/food/cheese/wedge = 2,
		/obj/item/food/bun = 1,
	)
	result = /obj/item/food/burger/soylent
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/ribburger
	name = "McRib"
	reqs = list(
		/obj/item/food/bbqribs = 1, //The sauce is already included in the ribs
		/obj/item/food/onion_slice = 1, //feel free to remove if too burdensome.
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/rib
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/mcguffin
	name = "McGuffin"
	reqs = list(
		/obj/item/food/friedegg = 1,
		/obj/item/food/meat/bacon = 2,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/mcguffin
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/chickenburger
	name = "Chicken Sandwich"
	reqs = list(
		/obj/item/food/patty/chicken = 1,
		/datum/reagent/consumable/mayonnaise = 5,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/chicken
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/tiris_burger
	name = "Tiris Burger"
	reqs = list(
		/obj/item/food/meat/steak/tiris = 1,
		/obj/item/food/cheese/wedge = 1,
		/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/tiris
	subcategory = CAT_BURGER
