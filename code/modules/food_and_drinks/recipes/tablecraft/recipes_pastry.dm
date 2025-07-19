//Waffles and Pancakes
/datum/crafting_recipe/food/waffles
	time = 15
	name = "Waffles"
	reqs = list(
		/obj/item/food/pastrybase = 2
	)
	result = /obj/item/food/waffles
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/soylenviridians
	name = "Soylent viridians"
	reqs = list(
		/obj/item/food/pastrybase = 2,
		/obj/item/food/grown/soybeans = 1
	)
	result = /obj/item/food/soylenviridians
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/soylentgreen
	name = "Soylent green"
	reqs = list(
		/obj/item/food/pastrybase = 2,
		/obj/item/food/meat/slab = 2
	)
	result = /obj/item/food/soylentgreen
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/rofflewaffles
	name = "Roffle waffles"
	reqs = list(
		/datum/reagent/drug/mushroomhallucinogen = 5,
		/obj/item/food/pastrybase = 2
	)
	result = /obj/item/food/rofflewaffles
	subcategory = CAT_PASTRY

//Donkpockets

/datum/crafting_recipe/food/donkpocket
	time = 15
	name = "Donk-pocket"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/meatball = 1
	)
	result = /obj/item/food/donkpocket
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/dankpocket
	time = 15
	name = "Dank-pocket"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/cannabis = 1
	)
	result = /obj/item/food/dankpocket
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/donkpocket/spicy
	time = 15
	name = "Spicy-pocket"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/meatball = 1,
		/obj/item/food/grown/chili
	)
	result = /obj/item/food/donkpocket/spicy
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/donkpocket/teriyaki
	time = 15
	name = "Teriyaki-pocket"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/meatball = 1,
		/datum/reagent/consumable/soysauce = 3
	)
	result = /obj/item/food/donkpocket/teriyaki
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/donkpocket/pizza
	time = 15
	name = "Pizza-pocket"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/meatball = 1,
		/obj/item/food/grown/tomato = 1
	)
	result = /obj/item/food/donkpocket/pizza
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/donkpocket/berry
	time = 15
	name = "Berry-pocket"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/berries = 1
	)
	result = /obj/item/food/donkpocket/berry
	subcategory = CAT_PASTRY

//Muffins

/datum/crafting_recipe/food/muffin
	time = 15
	name = "Muffin"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/food/pastrybase = 1
	)
	result = /obj/item/food/muffin
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/berrymuffin
	name = "Berry muffin"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/berries = 1
	)
	result = /obj/item/food/muffin/berry
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/booberrymuffin
	name = "Booberry muffin"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/berries = 1,
		/obj/item/ectoplasm = 1
	)
	result = /obj/item/food/muffin/booberry
	subcategory = CAT_PASTRY

//Misc

/datum/crafting_recipe/food/khachapuri
	name = "Khachapuri"
	reqs = list(
		/datum/reagent/consumable/eggyolk = 2,
		/datum/reagent/consumable/eggwhite = 4,
		/obj/item/food/cheese/wedge = 1,
		/obj/item/food/bread/plain = 1,
	)
	result = /obj/item/food/khachapuri
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/sugarcookie
	time = 15
	name = "Sugar cookie"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/food/pastrybase = 1
	)
	result = /obj/item/food/cookie/sugar
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/fortunecookie
	time = 15
	name = "Fortune cookie"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/paper = 1
	)
	parts =	list(
		/obj/item/paper = 1
	)
	result = /obj/item/food/fortunecookie
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/poppypretzel
	time = 15
	name = "Poppy pretzel"
	reqs = list(
		/obj/item/seeds/poppy = 1,
		/obj/item/food/pastrybase = 1
	)
	result = /obj/item/food/poppypretzel
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/plumphelmetbiscuit
	time = 15
	name = "Plumphelmet biscuit"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/mushroom/plumphelmet = 1
	)
	result = /obj/item/food/plumphelmetbiscuit
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/cracker
	time = 15
	name = "Cracker"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 1,
		/obj/item/food/pastrybase = 1,
	)
	result = /obj/item/food/cracker
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/chococornet
	name = "Choco cornet"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 1,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/chocolatebar = 1
	)
	result = /obj/item/food/chococornet
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/oatmealcookie
	name = "Oatmeal cookie"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/oat = 1
	)
	result = /obj/item/food/cookie/oatmeal
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/raisincookie
	name = "Raisin cookie"
	reqs = list(
		/obj/item/food/no_raisin = 1,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/oat = 1
	)
	result = /obj/item/food/cookie/raisin
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/cherrycupcake
	name = "Cherry cupcake"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/cherries = 1
	)
	result = /obj/item/food/cherrycupcake
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/bluecherrycupcake
	name = "Blue cherry cupcake"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/bluecherries = 1
	)
	result = /obj/item/food/cherrycupcake/blue
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/honeybun
	name = "Honey bun"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/food/honeybun
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/honeybun
	name = "Honey bun"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/food/honeybun
	subcategory = CAT_PASTRY
