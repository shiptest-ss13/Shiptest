/datum/crafting_recipe/food/tiziran_sausage
	name = "Raw Tiziran blood sausage"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawbacon = 1,
		/datum/reagent/blood = 5,
		/datum/reagent/consumable/sodiumchloride = 2
	)
	result = /obj/item/reagent_containers/food/snacks/raw_tiziran_sausage
	category = CAT_LIZARD

/datum/crafting_recipe/food/headcheese
	name = "Raw headcheese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/slab = 1,
		/datum/reagent/consumable/sodiumchloride = 10,
		/datum/reagent/consumable/blackpepper = 5
	)
	result = /obj/item/reagent_containers/food/snacks/raw_headcheese
	category = CAT_LIZARD

/datum/crafting_recipe/food/shredded_lungs
	name = "Crispy shredded lung stirfry"
	reqs = list(
		/obj/item/organ/lungs = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1
	)
	result = /obj/item/reagent_containers/food/snacks/shredded_lungs
	category = CAT_LIZARD

/datum/crafting_recipe/food/tsatsikh
	name = "Tsatsikh"
	reqs = list(
		/obj/item/organ/heart = 1,
		/obj/item/organ/liver = 1,
		/obj/item/organ/lungs = 1,
		/obj/item/organ/stomach = 1,
		/datum/reagent/consumable/sodiumchloride = 2,
		/datum/reagent/consumable/blackpepper = 2
	)
	result = /obj/item/reagent_containers/food/snacks/tsatsikh
	category = CAT_LIZARD

/datum/crafting_recipe/food/liver_pate
	name = "Liver pate"
	reqs = list(
		/obj/item/organ/liver = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1
	)
	result = /obj/item/reagent_containers/food/snacks/liver_pate
	category = CAT_LIZARD

/datum/crafting_recipe/food/moonfish_caviar
	name = "Moonfish caviar paste"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/moonfish_eggs = 1,
		/datum/reagent/consumable/sodiumchloride = 2
	)
	result = /obj/item/reagent_containers/food/snacks/moonfish_caviar
	category = CAT_LIZARD

/datum/crafting_recipe/food/lizard_escargot
	name = "Desert snail cocleas"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/canned/desert_snails = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/datum/reagent/consumable/lemonjuice = 3,
		/datum/reagent/consumable/blackpepper = 2,
		/datum/reagent/consumable/quality_oil = 3
	)
	result = /obj/item/reagent_containers/food/snacks/lizard_escargot
	category = CAT_LIZARD

/datum/crafting_recipe/food/fried_blood_sausage
	name = "Fried blood sausage"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/raw_tiziran_sausage = 1,
		/datum/reagent/consumable/korta_flour = 5,
		/datum/reagent/water = 5
	)
	result = /obj/item/reagent_containers/food/snacks/fried_blood_sausage
	category = CAT_LIZARD

/datum/crafting_recipe/food/lizard_fries
	name = "Loaded poms-franzisks"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fries = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/datum/reagent/consumable/bbqsauce = 5
	)
	result = /obj/item/reagent_containers/food/snacks/lizard_fries
	category = CAT_LIZARD

/datum/crafting_recipe/food/brain_pate
	name = "Eyeball-and-brain pate"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/organ/eyes = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/datum/reagent/consumable/sodiumchloride = 3
	)
	result = /obj/item/reagent_containers/food/snacks/brain_pate
	category = CAT_LIZARD

/datum/crafting_recipe/food/crispy_headcheese
	name = "Crispy breaded headcheese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/headcheese_slice = 1,
		/obj/item/reagent_containers/food/snacks/breadslice/root = 1
	)
	result = /obj/item/reagent_containers/food/snacks/crispy_headcheese
	category = CAT_LIZARD

/datum/crafting_recipe/food/picoss_skewers
	name = "Picoss skewers"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fishmeat = 2,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/stack/rods = 1,
		/datum/reagent/consumable/vinegar = 5
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/picoss_skewers
	category = CAT_LIZARD

/datum/crafting_recipe/food/nectar_larvae
	name = "Nectar larvae"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/canned/larvae = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/datum/reagent/consumable/korta_nectar = 5
	)
	result = /obj/item/reagent_containers/food/snacks/nectar_larvae
	category = CAT_LIZARD

/datum/crafting_recipe/food/mushroomy_stirfry
	name = "Mushroomy Stirfry"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/steeped_mushrooms = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/plumphelmet = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/chanterelle = 1,
		/datum/reagent/consumable/quality_oil = 5
	)
	result = /obj/item/reagent_containers/food/snacks/mushroomy_stirfry
	category = CAT_LIZARD

/datum/crafting_recipe/food/moonfish_demiglace
	name = "Moonfish demiglace"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grilled_moonfish = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/datum/reagent/consumable/korta_milk = 5,
		/datum/reagent/consumable/ethanol/wine = 5
	)
	result = /obj/item/reagent_containers/food/snacks/moonfish_demiglace
	category = CAT_LIZARD

/datum/crafting_recipe/food/lizard_surf_n_turf
	name = "Zagosk surf n turf smorgasbord"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grilled_moonfish = 1,
		/obj/item/reagent_containers/food/snacks/kebab/picoss_skewers = 2,
		/obj/item/reagent_containers/food/snacks/meat/steak = 1,
		/obj/item/reagent_containers/food/snacks/bbqribs = 1
	)
	result = /obj/item/reagent_containers/food/snacks/lizard_surf_n_turf
	category = CAT_LIZARD

/datum/crafting_recipe/food/rootdough
	name = "Rootdough"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/potato = 2,
		/obj/item/reagent_containers/food/snacks/egg = 1,
		/datum/reagent/consumable/korta_flour = 5,
		/datum/reagent/water = 10
	)
	result = /obj/item/reagent_containers/food/snacks/rootdough
	category = CAT_LIZARD

/datum/crafting_recipe/food/snail_nizaya
	name = "Desert snail nizaya"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/canned/desert_snails = 1,
		/obj/item/reagent_containers/food/snacks/spaghetti/nizaya = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/datum/reagent/consumable/ethanol/wine = 5
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/snail_nizaya
	category = CAT_LIZARD

/datum/crafting_recipe/food/garlic_nizaya
	name = "Garlic nizaya"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/spaghetti/nizaya = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/datum/reagent/consumable/quality_oil = 5
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/garlic_nizaya
	category = CAT_LIZARD

/datum/crafting_recipe/food/demit_nizaya
	name = "Demit nizaya"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/spaghetti/nizaya = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/datum/reagent/consumable/korta_milk = 5,
		/datum/reagent/consumable/korta_nectar = 5
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/demit_nizaya
	category = CAT_LIZARD

/datum/crafting_recipe/food/mushroom_nizaya
	name = "Mushroom nizaya"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/spaghetti/nizaya = 1,
		/obj/item/reagent_containers/food/snacks/steeped_mushrooms = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/datum/reagent/consumable/quality_oil = 5
	)
	result = /obj/item/reagent_containers/food/snacks/spaghetti/mushroom_nizaya
	category = CAT_LIZARD

/datum/crafting_recipe/food/rustic_flatbread
	name = "Rustic flatbread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/root_flatbread = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/datum/reagent/consumable/lemonjuice = 2,
		/datum/reagent/consumable/quality_oil = 3
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/rustic
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
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 2,
		/obj/item/reagent_containers/food/snacks/egg = 1,
		/obj/item/organ/liver = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/zmorgast
	category = CAT_LIZARD

/datum/crafting_recipe/food/fish_flatbread
	name = "BBQ fish flatbread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/root_flatbread = 1,
		/obj/item/reagent_containers/food/snacks/fishmeat = 2,
		/datum/reagent/consumable/bbqsauce = 5
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/flatbread/fish
	category = CAT_LIZARD

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
		/obj/item/reagent_containers/food/snacks/grown/korta_nut = 1
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
