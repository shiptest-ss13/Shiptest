
// see code/module/crafting/table.dm

////////////////////////////////////////////////BURGERS////////////////////////////////////////////////


/datum/crafting_recipe/food/burger
	name = "Burger"
	reqs = list(
			/obj/item/reagent_containers/food/snacks/meat/steak/plain = 1,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)

	result = /obj/item/reagent_containers/food/snacks/burger/plain
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/xenoburger
	name = "Xeno burger"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/xeno = 1,
		/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/xeno
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/fishburger
	name = "Fish burger"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fishmeat = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/fish
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/tofuburger
	name = "Tofu burger"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/tofu = 1,
		/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/tofu
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/bigbiteburger
	name = "Big bite burger"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/plain = 3,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/bigbite
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/superbiteburger
	name = "Super bite burger"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 5,
		/datum/reagent/consumable/blackpepper = 5,
		/obj/item/reagent_containers/food/snacks/meat/steak/plain = 5,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 4,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 3,
		/obj/item/reagent_containers/food/snacks/boiledegg = 1,
		/obj/item/reagent_containers/food/snacks/meat/bacon = 1,
		/obj/item/reagent_containers/food/snacks/bun = 1

	)
	result = /obj/item/reagent_containers/food/snacks/burger/superbite
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/slimeburger
	name = "Jelly burger"
	reqs = list(
		/datum/reagent/toxin/slimejelly = 5,
		/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/jelly/slime
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/jellyburger
	name = "Jelly burger"
	reqs = list(
			/datum/reagent/consumable/cherryjelly = 5,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/jelly/cherry
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/fivealarmburger
	name = "Five alarm burger"
	reqs = list(
			/obj/item/reagent_containers/food/snacks/meat/steak/plain = 1,
			/obj/item/reagent_containers/food/snacks/grown/ghost_chili = 2,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/fivealarm
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/ratburger
	name = "Rat burger"
	reqs = list(
			/obj/item/food/deadmouse = 1,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/rat
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/baconburger
	name = "Bacon burger"
	reqs = list(
			/obj/item/reagent_containers/food/snacks/meat/bacon = 3,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)

	result = /obj/item/reagent_containers/food/snacks/burger/baconburger
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/empoweredburger
	name = "Empowered burger"
	reqs = list(
			/obj/item/stack/sheet/mineral/plasma = 2,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)

	result = /obj/item/reagent_containers/food/snacks/burger/empoweredburger
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/crabburger
	name = "Crab burger"
	reqs = list(
			/obj/item/reagent_containers/food/snacks/meat/crab = 2,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)

	result = /obj/item/reagent_containers/food/snacks/burger/crab
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/cheeseburger
	name = "Cheese burger"
	reqs = list(
			/obj/item/reagent_containers/food/snacks/meat/steak/plain = 1,
			/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/cheese
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/soylentburger
	name = "Soylent burger"
	reqs = list(
			/obj/item/reagent_containers/food/snacks/soylentgreen = 1, //two full meats worth.
			/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/soylent
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/ribburger
	name = "Rib sandwich"
	reqs = list(
			/obj/item/reagent_containers/food/snacks/bbqribs = 1,     //The sauce is already included in the ribs
			/obj/item/reagent_containers/food/snacks/onion_slice = 1, //feel free to remove if too burdensome.
			/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/rib
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/mcguffin
	name = "Breakfast sandwich"
	reqs = list(
			/obj/item/reagent_containers/food/snacks/friedegg = 1,
			/obj/item/reagent_containers/food/snacks/meat/bacon = 2,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/mcguffin
	subcategory = CAT_BURGER

/datum/crafting_recipe/food/chickenburger
	name = "Chicken Sandwich"
	reqs = list(
			/obj/item/reagent_containers/food/snacks/meat/steak/chicken = 1,
			/datum/reagent/consumable/mayonnaise = 5,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/chicken
	subcategory = CAT_BURGER
