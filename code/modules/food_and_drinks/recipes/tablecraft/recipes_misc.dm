
// see code/module/crafting/table.dm

// MISC

/datum/crafting_recipe/food/candiedapple
	name = "Candied apple"
	reqs = list(
		/datum/reagent/consumable/caramel = 5,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1
	)
	result = /obj/item/reagent_containers/food/snacks/candiedapple
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/spiderlollipop
	name = "Spider Lollipop"
	reqs = list(/obj/item/stack/rods = 1,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/water = 5,
		/obj/item/reagent_containers/food/snacks/spiderling = 1
	)
	result = /obj/item/reagent_containers/food/snacks/spiderlollipop
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/chococoin
	name = "Choco coin"
	reqs = list(
		/obj/item/coin = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/chococoin
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/fudgedice
	name = "Fudge dice"
	reqs = list(
		/obj/item/dice = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/fudgedice
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/chocoorange
	name = "Choco orange"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/citrus/orange = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/chocoorange
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/loadedbakedpotato
	name = "Loaded baked potato"
	time = 40
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/loadedbakedpotato
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/cheesyfries
	name = "Cheesy fries"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fries = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/cheesyfries
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/wrap
	name = "Wrap"
	reqs = list(/datum/reagent/consumable/soysauce = 10,
		/obj/item/reagent_containers/food/snacks/friedegg = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/eggwrap
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/beans
	name = "Beans"
	time = 40
	reqs = list(/datum/reagent/consumable/ketchup = 5,
		/obj/item/reagent_containers/food/snacks/grown/soybeans = 2
	)
	result = /obj/item/reagent_containers/food/snacks/canned/beans
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/eggplantparm
	name ="Eggplant parmigiana"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1
	)
	result = /obj/item/reagent_containers/food/snacks/eggplantparm
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/baguette
	name = "Baguette"
	time = 40
	reqs = list(/datum/reagent/consumable/sodiumchloride = 1,
				/datum/reagent/consumable/blackpepper = 1,
				/obj/item/reagent_containers/food/snacks/pastrybase = 2
	)
	result = /obj/item/reagent_containers/food/snacks/baguette
	subcategory = CAT_MISCFOOD

////////////////////////////////////////////////TOAST////////////////////////////////////////////////

/datum/crafting_recipe/food/slimetoast
	name = "Slime toast"
	reqs = list(
		/datum/reagent/toxin/slimejelly = 5,
		/obj/item/reagent_containers/food/snacks/breadslice/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/jelliedtoast/slime
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/jelliedyoast
	name = "Jellied toast"
	reqs = list(
		/datum/reagent/consumable/cherryjelly = 5,
		/obj/item/reagent_containers/food/snacks/breadslice/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/jelliedtoast/cherry
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/butteredtoast
	name = "Buttered Toast"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/breadslice/plain = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/butteredtoast
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/twobread
	name = "Two bread"
	reqs = list(
		/datum/reagent/consumable/ethanol/wine = 5,
		/obj/item/reagent_containers/food/snacks/breadslice/plain = 2
	)
	result = /obj/item/reagent_containers/food/snacks/twobread
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/burrito
	name ="Burrito"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/tortilla = 1,
		/obj/item/reagent_containers/food/snacks/grown/soybeans = 2
	)
	result = /obj/item/reagent_containers/food/snacks/burrito
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/cheesyburrito
	name ="Cheesy burrito"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/tortilla = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/grown/soybeans = 1
	)
	result = /obj/item/reagent_containers/food/snacks/cheesyburrito
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/carneburrito
	name ="Carne de asada burrito"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/tortilla = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/soybeans = 1
	)
	result = /obj/item/reagent_containers/food/snacks/carneburrito
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/fuegoburrito
	name ="Fuego plasma burrito"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/tortilla = 1,
		/obj/item/reagent_containers/food/snacks/grown/ghost_chili = 2,
		/obj/item/reagent_containers/food/snacks/grown/soybeans = 1
	)
	result = /obj/item/reagent_containers/food/snacks/fuegoburrito
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/melonfruitbowl
	name ="Melon fruit bowl"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/watermelon = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/orange = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/lemon = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia = 1
	)
	result = /obj/item/reagent_containers/food/snacks/melonfruitbowl
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/nachos
	name ="Nachos"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 1,
		/obj/item/reagent_containers/food/snacks/tortilla = 1
	)
	result = /obj/item/reagent_containers/food/snacks/nachos
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/cheesynachos
	name ="Cheesy nachos"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/tortilla = 1
	)
	result = /obj/item/reagent_containers/food/snacks/cheesynachos
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/cubannachos
	name ="Cuban nachos"
	reqs = list(
		/datum/reagent/consumable/ketchup = 5,
		/obj/item/reagent_containers/food/snacks/grown/chili = 2,
		/obj/item/reagent_containers/food/snacks/tortilla = 1
	)
	result = /obj/item/reagent_containers/food/snacks/cubannachos
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/melonkeg
	name ="Melon keg"
	reqs = list(
		/datum/reagent/consumable/ethanol/vodka = 25,
		/obj/item/reagent_containers/food/snacks/grown/holymelon = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka = 1
	)
	parts = list(/obj/item/reagent_containers/food/drinks/bottle/vodka = 1)
	result = /obj/item/reagent_containers/food/snacks/melonkeg
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/honeybar
	name = "Honey nut bar"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/oat = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/reagent_containers/food/snacks/honeybar
	subcategory = CAT_MISCFOOD


/datum/crafting_recipe/food/stuffedlegion
	name = "Stuffed legion"
	time = 40
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/goliath = 1,
		/obj/item/organ/regenerative_core/legion = 1,
		/datum/reagent/consumable/ketchup = 2,
		/datum/reagent/consumable/capsaicin = 2
	)
	result = /obj/item/reagent_containers/food/snacks/stuffedlegion
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/powercrepe
	name = "Powercrepe"
	time = 40
	reqs = list(
		/obj/item/reagent_containers/food/snacks/flatdough = 1,
		/datum/reagent/consumable/milk = 1,
		/datum/reagent/consumable/cherryjelly = 5,
		/obj/item/stock_parts/cell/super =1,
		/obj/item/melee/sabre = 1
	)
	result = /obj/item/reagent_containers/food/snacks/powercrepe
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/taco
	name ="Classic Taco"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/tortilla = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/taco
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/tacoplain
	name ="Plain Taco"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/tortilla = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/taco/plain
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/branrequests
	name = "Bran Requests Cereal"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/wheat = 1,
		/obj/item/reagent_containers/food/snacks/no_raisin = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/branrequests
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/ricepudding
	name = "Rice pudding"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/ricepudding
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/butterbear //ITS ALIVEEEEEE!
	name = "Living bear/butter hybrid"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/organ/heart = 1,
		/obj/item/reagent_containers/food/snacks/butter = 10,
		/obj/item/reagent_containers/food/snacks/meat/slab = 5,
		/datum/reagent/blood = 50,
		/datum/reagent/teslium = 1 //To shock the whole thing into life
	)
	result = /mob/living/simple_animal/hostile/bear/butter
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/crab_rangoon
	name = "Crab Rangoon"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/doughslice = 1,
		/datum/reagent/consumable/cream = 5,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawcrab = 1
	)
	result = /obj/item/reagent_containers/food/snacks/crab_rangoon
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/poutine
	name = "Poutine"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fries = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/datum/reagent/consumable/gravy = 1
	)
	result = /obj/item/reagent_containers/food/snacks/customizable/poutine
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/royalcheese
	name = "Royal Cheese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cheesewheel = 1,
		/obj/item/clothing/head/crown = 1,
		/datum/reagent/medicine/strange_reagent = 5,
		/datum/reagent/toxin/mutagen = 5
	)
	result = /obj/item/reagent_containers/food/snacks/royalcheese
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/pesto
	name = "Pesto"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/firm_cheese_slice = 1,
		/datum/reagent/consumable/sodiumchloride = 5,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 2,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/datum/reagent/consumable/quality_oil = 5,
		/obj/item/reagent_containers/food/snacks/canned/pine_nuts = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pesto
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/tomato_sauce
	name = "Tomato sauce"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/canned/tomatoes = 1,
		/datum/reagent/consumable/sodiumchloride = 2,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 1,
		/datum/reagent/consumable/quality_oil = 5
	)
	result = /obj/item/reagent_containers/food/snacks/tomato_sauce
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/bechamel_sauce
	name = "Bechamel sauce"
	reqs = list(
		/datum/reagent/consumable/milk = 10,
		/datum/reagent/consumable/flour = 5,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/bechamel_sauce
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/vegetariansushiroll
	name = "Vegetarian sushi roll"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/seaweed = 1,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/vegetariansushiroll
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/onigiri
	name = "Onigiri"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/seaweed = 1,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1
	)
	result = /obj/item/reagent_containers/food/snacks/onigiri
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/herby_cheese
	name = "Herby cheese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/curd_cheese = 1,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 4
	)
	result = /obj/item/reagent_containers/food/snacks/herby_cheese
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/mothic_salad
	name = "Mothic salad"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
		/obj/item/reagent_containers/food/snacks/onion_slice/red = 2,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/mothic_salad
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/toasted_seeds
	name = "Toasted seeds"
	reqs = list(
		/obj/item/seeds/sunflower = 1,
		/obj/item/seeds/pumpkin = 1,
		/obj/item/seeds/poppy = 1,
		/datum/reagent/consumable/quality_oil = 2
	)
	result = /obj/item/reagent_containers/food/snacks/toasted_seeds
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/engine_fodder
	name = "Engine fodder"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/toasted_seeds = 1,
		/obj/item/reagent_containers/food/snacks/cnds = 1,
		/obj/item/reagent_containers/food/snacks/popcorn = 1,
		/obj/item/reagent_containers/food/snacks/peanuts = 1,
		/obj/item/reagent_containers/food/snacks/chips = 1
	)
	result = /obj/item/reagent_containers/food/snacks/engine_fodder
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/squeaking_stir_fry
	name = "Skeklitmischtpoppl (Squeaking stir fry)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/cheese_curds = 1,
		/obj/item/reagent_containers/food/snacks/tofu = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/onion_slice = 1
	)
	result = /obj/item/reagent_containers/food/snacks/squeaking_stir_fry
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/sweet_chili_cabbage_wrap
	name = "Sweet chili cabbage wrap"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grilled_cheese = 1,
		/obj/item/reagent_containers/food/snacks/mothic_salad = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/reagent_containers/food/snacks/sweet_chili_cabbage_wrap
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/loaded_curds
	name = "Ozlsettitæloskekllön ede pommes (Loaded curds and fries)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/cheese_curds = 1,
		/obj/item/reagent_containers/food/snacks/soup/vegetarian_chili = 1,
		/obj/item/reagent_containers/food/snacks/onion_slice = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/fries = 1
	)
	result = /obj/item/reagent_containers/food/snacks/loaded_curds
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/baked_cheese_platter
	name = "Stanntkraktælo (Baked cheese platter)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/baked_cheese = 1,
		/obj/item/reagent_containers/food/snacks/griddle_toast = 3
	)
	result = /obj/item/reagent_containers/food/snacks/baked_cheese_platter
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/raw_green_lasagne
	name = "Green lasagne al forno"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pesto = 1,
		/obj/item/reagent_containers/food/snacks/spaghetti = 2,
		/obj/item/reagent_containers/food/snacks/bechamel_sauce = 1,
		/obj/item/reagent_containers/food/snacks/firm_cheese = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raw_green_lasagne
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/raw_baked_rice
	name = "Big baked rice"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 2,
		/obj/item/reagent_containers/food/snacks/soup/vegetable = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 2,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raw_baked_rice
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/buttered_baked_corn
	name = "Buttered baked corn"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/oven_baked_corn = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/buttered_baked_corn
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/fiesta_corn_skillet
	name = "Fiesta corn skillet"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/oven_baked_corn = 1,
		/obj/item/reagent_containers/food/snacks/cornchips = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 2,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/onion_slice = 2,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/fiesta_corn_skillet
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/ratatouille
	name = "Ratatouille"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion/red = 1,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/roasted_bell_pepper = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raw_ratatouille
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/mozzarella_sticks
	name = "Mozzarella sticks"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/mozzarella = 1,
		/obj/item/reagent_containers/food/snacks/breadslice = 2,
		/obj/item/reagent_containers/food/snacks/tomato_sauce = 1
	)
	result = /obj/item/reagent_containers/food/snacks/mozzarella_sticks
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/raw_stuffed_peppers
	name = "Voltölpapriken (Stuffed peppers)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/bell_pepper = 1,
		/obj/item/reagent_containers/food/snacks/herby_cheese = 1,
		/obj/item/reagent_containers/food/snacks/onion_slice = 2
	)
	result = /obj/item/reagent_containers/food/snacks/raw_stuffed_peppers
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/fueljacks_lunch
	name = "Fueljack's lunch"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/onion_slice = 2,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/firm_cheese_slice = 1
	)
	result = /obj/item/reagent_containers/food/snacks/fueljacks_lunch
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/mac_balls
	name = "Macheronirölen (Mac balls)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/ready_donk/warm/mac_n_cheese = 1,
		/obj/item/reagent_containers/food/snacks/tomato_sauce = 1,
		/datum/reagent/consumable/cornmeal_batter = 5
	)
	result = /obj/item/reagent_containers/food/snacks/mac_balls
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/moth_cheese_cakes
	name = "Ælorölen (Cheesecake balls)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/curd_cheese = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/reagent_containers/food/snacks/moth_cheese_cakes
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/kalixcian_sausage
	name = "Raw Kalixcian blood sausage"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawbacon = 1,
		/datum/reagent/blood = 5,
		/datum/reagent/consumable/sodiumchloride = 2
	)
	result = /obj/item/reagent_containers/food/snacks/raw_kalixcian_sausage
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/headcheese
	name = "Raw headcheese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/slab = 1,
		/datum/reagent/consumable/sodiumchloride = 10,
		/datum/reagent/consumable/blackpepper = 5
	)
	result = /obj/item/reagent_containers/food/snacks/raw_headcheese
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/shredded_lungs
	name = "Crispy shredded lung stirfry"
	reqs = list(
		/obj/item/organ/lungs = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1
	)
	result = /obj/item/reagent_containers/food/snacks/shredded_lungs
	subcategory = CAT_MISCFOOD

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
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/liver_pate
	name = "Liver pate"
	reqs = list(
		/obj/item/organ/liver = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1
	)
	result = /obj/item/reagent_containers/food/snacks/liver_pate
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/moonfish_caviar
	name = "Moonfish caviar paste"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/moonfish_eggs = 1,
		/datum/reagent/consumable/sodiumchloride = 2
	)
	result = /obj/item/reagent_containers/food/snacks/moonfish_caviar
	subcategory = CAT_MISCFOOD

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
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/fried_blood_sausage
	name = "Fried blood sausage"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/raw_kalixcian_sausage = 1,
		/datum/reagent/consumable/korta_flour = 5,
		/datum/reagent/water = 5
	)
	result = /obj/item/reagent_containers/food/snacks/fried_blood_sausage
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/lizard_fries
	name = "Loaded poms-franzisks"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fries = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/datum/reagent/consumable/bbqsauce = 5
	)
	result = /obj/item/reagent_containers/food/snacks/lizard_fries
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/brain_pate
	name = "Eyeball-and-brain pate"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/organ/eyes = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/datum/reagent/consumable/sodiumchloride = 3
	)
	result = /obj/item/reagent_containers/food/snacks/brain_pate
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/crispy_headcheese
	name = "Crispy breaded headcheese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/headcheese_slice = 1,
		/obj/item/reagent_containers/food/snacks/breadslice/root = 1
	)
	result = /obj/item/reagent_containers/food/snacks/crispy_headcheese
	subcategory = CAT_MISCFOOD

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
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/nectar_larvae
	name = "Nectar larvae"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/canned/larvae = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/datum/reagent/consumable/korta_nectar = 5
	)
	result = /obj/item/reagent_containers/food/snacks/nectar_larvae
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/mushroomy_stirfry
	name = "Mushroomy Stirfry"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/steeped_mushrooms = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/plumphelmet = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/chanterelle = 1,
		/datum/reagent/consumable/quality_oil = 5
	)
	result = /obj/item/reagent_containers/food/snacks/mushroomy_stirfry
	subcategory = CAT_MISCFOOD

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
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/lizard_surf_n_turf
	name = "Zagosk surf n turf smorgasbord"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grilled_moonfish = 1,
		/obj/item/reagent_containers/food/snacks/kebab/picoss_skewers = 2,
		/obj/item/reagent_containers/food/snacks/meat/steak = 1,
		/obj/item/reagent_containers/food/snacks/bbqribs = 1
	)
	result = /obj/item/reagent_containers/food/snacks/lizard_surf_n_turf
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/rootdough
	name = "Rootdough"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/potato = 2,
		/obj/item/reagent_containers/food/snacks/egg = 1,
		/datum/reagent/consumable/korta_flour = 5,
		/datum/reagent/water = 10
	)
	result = /obj/item/reagent_containers/food/snacks/rootdough
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/emperor_roll
	name = "Emperor roll"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rootroll = 1,
		/obj/item/reagent_containers/food/snacks/liver_pate = 1,
		/obj/item/reagent_containers/food/snacks/headcheese_slice = 2,
		/obj/item/reagent_containers/food/snacks/moonfish_caviar = 1
	)
	result = /obj/item/reagent_containers/food/snacks/emperor_roll
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/honey_sweetroll
	name = "Honey sweetroll"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rootroll = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/reagent_containers/food/snacks/honey_roll
	subcategory = CAT_MISCFOOD

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
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/candied_mushrooms
	name = "Candied mushrooms"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/reagent_containers/food/snacks/steeped_mushrooms = 1,
		/datum/reagent/consumable/caramel = 5,
		/datum/reagent/consumable/sodiumchloride = 1
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/candied_mushrooms
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/sauerkraut
	name = "Sauerkraut"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 2,
		/datum/reagent/consumable/sodiumchloride = 10
	)
	result = /obj/item/reagent_containers/food/snacks/sauerkraut
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/lizard_dumplings
	name = "Kalixcian dumplings"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/datum/reagent/consumable/korta_flour = 5
	)
	result = /obj/item/reagent_containers/food/snacks/lizard_dumplings
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/steeped_mushrooms
	name = "Steeped mushrooms"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/seraka = 1,
		/datum/reagent/lye = 5
	)
	result = /obj/item/reagent_containers/food/snacks/steeped_mushrooms
	subcategory = CAT_MISCFOOD
