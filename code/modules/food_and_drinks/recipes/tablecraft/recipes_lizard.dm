	category = CAT_LIZARD

/datum/crafting_recipe/food/italic_flatbread
	name = "Italic flatbread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/root_flatbread = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 2,
		/datum/reagent/consumable/quality_oil = 3
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/italic
	category = CAT_LIZARD

/datum/crafting_recipe/food/imperial_flatbread
	name = "Imperial flatbread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/root_flatbread = 1,
		/obj/item/reagent_containers/food/snacks/liver_pate = 1,
		/obj/item/reagent_containers/food/snacks/sauerkraut = 1,
		/obj/item/reagent_containers/food/snacks/headcheese = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/imperial
	category = CAT_LIZARD

/datum/crafting_recipe/food/rawmeat_flatbread
	name = "Meatlovers flatbread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/root_flatbread = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/rawmeat
	category = CAT_LIZARD

/datum/crafting_recipe/food/stinging_flatbread
	name = "Stinging flatbread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/root_flatbread = 1,
		/obj/item/reagent_containers/food/snacks/canned/larvae = 1,
		/obj/item/reagent_containers/food/snacks/canned/jellyfish = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/stinging
	category = CAT_LIZARD

/datum/crafting_recipe/food/zmorgast_flatbread
	name = "Zmorgast flatbread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/root_flatbread = 1,
		/obj/item/reagent_containers/food/snacks/grown/cucumber = 2,
		/obj/item/reagent_containers/food/snacks/egg = 1,
		/obj/item/organ/liver = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/zmorgast
	category = CAT_LIZARD

//We don't have fishing and fish meat
/*datum/crafting_recipe/food/fish_flatbread
	name = "BBQ fish flatbread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/root_flatbread = 1,
		/obj/item/reagent_containers/food/snacks/fishmeat = 2,
		/datum/reagent/consumable/bbqsauce = 5
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/fish
	category = CAT_LIZARD*/

/datum/crafting_recipe/food/mushroom_flatbread
	name = "Mushroom and tomato flatbread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/root_flatbread = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom = 3,
		/datum/reagent/consumable/quality_oil = 3
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/mushroom
	category = CAT_LIZARD

/datum/crafting_recipe/food/nutty_flatbread
	name = "Nut paste flatbread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/root_flatbread = 1,
		/datum/reagent/consumable/korta_flour = 5,
		/datum/reagent/consumable/korta_milk = 5
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/nutty
	category = CAT_LIZARD

/datum/crafting_recipe/food/emperor_roll
	name = "Emperor roll"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rootroll = 1,
		/obj/item/reagent_containers/food/snacks/liver_pate = 1,
		/obj/item/reagent_containers/food/snacks/headcheese_slice = 2,
		/obj/item/reagent_containers/food/snacks/moonfish_caviar = 1
	)
	result = /obj/item/reagent_containers/food/snacks/emperor_roll
	category = CAT_LIZARD

/datum/crafting_recipe/food/honey_sweetroll
	name = "Honey sweetroll"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rootroll = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/reagent_containers/food/snacks/honey_roll
	category = CAT_LIZARD

/datum/crafting_recipe/food/atrakor_dumplings
	name = "Atrakor dumpling soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/lizard_dumplings = 1,
		/datum/reagent/consumable/soysauce = 5
	)
	result = /obj/item/reagent_containers/food/snacks/soup/atrakor_dumplings
	category = CAT_LIZARD

/datum/crafting_recipe/food/meatball_noodles
	name = "Meatball noodle soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/spaghetti/nizaya = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 2,
		/obj/item/reagent_containers/food/snacks/grown/peanut = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/meatball_noodles
	category = CAT_LIZARD

/datum/crafting_recipe/food/black_broth
	name = "Tiziran black broth"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/tiziran_sausage = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/datum/reagent/consumable/vinegar = 5,
		/datum/reagent/blood = 5,
		/datum/reagent/consumable/ice = 2
	)
	result = /obj/item/reagent_containers/food/snacks/soup/black_broth
	category = CAT_LIZARD

/datum/crafting_recipe/food/jellyfish_stew
	name = "Jellyfish stew"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/canned/jellyfish = 1,
		/obj/item/reagent_containers/food/snacks/grown/soybeans = 1,
		/obj/item/reagent_containers/food/snacks/grown/redbeet = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/jellyfish
	category = CAT_LIZARD

/datum/crafting_recipe/food/rootbread_soup
	name = "Rootbread soup"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/breadslice/root = 2,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/egg = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/rootbread_soup
	category = CAT_LIZARD

/datum/crafting_recipe/food/black_eggs
	name = "Black scrambled eggs"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/egg = 2,
		/datum/reagent/blood = 5,
		/datum/reagent/consumable/vinegar = 2
	)
	result = /obj/item/reagent_containers/food/snacks/black_eggs
	category = CAT_LIZARD

/datum/crafting_recipe/food/patzikula
	name = "Patzikula"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/tomato = 2,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/egg = 2
	)
	result = /obj/item/reagent_containers/food/snacks/patzikula
	category = CAT_LIZARD

/datum/crafting_recipe/food/korta_brittle
	name = "Korta brittle slab"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/korta_nut = 2,
		/obj/item/reagent_containers/food/snacks/butter = 1,
		/datum/reagent/consumable/korta_nectar = 5,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/sodiumchloride = 2
	)
	result = /obj/item/reagent_containers/food/snacks/cake/korta_brittle
	category = CAT_LIZARD

/datum/crafting_recipe/food/korta_ice
	name = "Korta ice"
	reqs = list(
		/obj/item/paper = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/korta_nectar = 5,
		/obj/item/reagent_containers/food/snacks/grown/berries = 1
	)
	result = /obj/item/reagent_containers/food/snacks/snowcones/korta_ice
	category = CAT_LIZARD

/datum/crafting_recipe/food/candied_mushrooms
	name = "Candied mushrooms"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/reagent_containers/food/snacks/steeped_mushrooms = 1,
		/datum/reagent/consumable/caramel = 5,
		/datum/reagent/consumable/sodiumchloride = 1
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/candied_mushrooms
	category = CAT_LIZARD

/datum/crafting_recipe/food/sauerkraut
	name = "Sauerkraut"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 2,
		/datum/reagent/consumable/sodiumchloride = 10
	)
	result = /obj/item/reagent_containers/food/snacks/sauerkraut
	category = CAT_LIZARD

/datum/crafting_recipe/food/lizard_dumplings
	name = "Tiziran dumplings"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/datum/reagent/consumable/korta_flour = 5
	)
	result = /obj/item/reagent_containers/food/snacks/lizard_dumplings
	category = CAT_LIZARD

/datum/crafting_recipe/food/steeped_mushrooms
	name = "Steeped mushrooms"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/seraka = 1,
		/datum/reagent/lye = 5
	)
	result = /obj/item/reagent_containers/food/snacks/steeped_mushrooms
	category = CAT_LIZARD
