/datum/supply_pack/food
	category = "Food & Agricultural"

/*
		Ready-to-eat
*/

/datum/supply_pack/food/shoalpockets
	name = "Shoalwich Variety Crate"
	desc = "Featuring a collection of heavily-processed reheatable food packets, straight from the Shoal."
	cost = 500
	contains = list(/obj/item/storage/box/shoalpockets/shoalpocketspicy,
					/obj/item/storage/box/shoalpockets/shoalpocketteriyaki,
					/obj/item/storage/box/shoalpockets/shoalpocketpizza,
					/obj/item/storage/box/shoalpockets/shoalpocketberry)
	crate_name = "shoalwich crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/shoalpockets/fill(obj/structure/closet/crate/C)
	for(var/i in 1 to 3)
		var/item = pick(contains)
		new item(C)

/datum/supply_pack/food/pizza
	name = "Pizza Crate"
	desc = "Best prices on this side of the galaxy. All deliveries are guaranteed to be 99.5% anomaly-free!"
	cost = 750// Best prices this side of the galaxy.
	contains = list(/obj/item/pizzabox/margherita,
					/obj/item/pizzabox/mushroom,
					/obj/item/pizzabox/meat,
					/obj/item/pizzabox/vegetable,
					/obj/item/pizzabox/pineapple)
	crate_name = "pizza crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/ration
	name = "Ration Crate"
	desc = "One standard issue ration pack. For your inner jarhead."
	cost = 80
	contains = list(/obj/effect/spawner/random/food_or_drink/ration)
	crate_name = "ration crate"
	crate_type = /obj/structure/closet/crate

/*
		Ingredients
*/

/datum/supply_pack/food/ingredients_basic
	name = "Basic Ingredients Crate"
	desc = "Get things cooking with this crate full of useful ingredients! Contains a dozen eggs, some enzyme, two slabs of meat, some flour, some rice, a few bottles of milk, a bottle of soymilk, and a bag of sugar."
	cost = 350
	contains = list(/obj/item/reagent_containers/condiment/flour,
					/obj/item/reagent_containers/condiment/flour,
					/obj/item/reagent_containers/condiment/rice,
					/obj/item/reagent_containers/condiment/milk,
					/obj/item/reagent_containers/condiment/milk,
					/obj/item/reagent_containers/condiment/soymilk,
					/obj/item/reagent_containers/condiment/sugar,
					/obj/item/storage/fancy/egg_box,
					/obj/item/food/meat/slab,
					/obj/item/food/meat/slab,
					/obj/item/reagent_containers/condiment/enzyme,
	)
	crate_name = "food crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/ingredients_condiments
	name = "Condiments Crate"
	desc = "A variety of garnishes for topping off your dish with a little extra pizzaz. Contains a bottle of enzyme, a salt shaker, a pepper mill, a bottle of ketchup, a bottle of hot sauce, a bottle of BBQ sauce, and a bottle of cream."
	cost = 100
	contains = list(/obj/item/reagent_containers/condiment/saltshaker,
					/obj/item/reagent_containers/condiment/peppermill,
					/obj/item/reagent_containers/condiment/ketchup,
					/obj/item/reagent_containers/condiment/hotsauce,
					/obj/item/reagent_containers/food/drinks/bottle/cream,
					/obj/item/reagent_containers/condiment/mayonnaise,
					/obj/item/reagent_containers/condiment/bbqsauce,
					/obj/item/reagent_containers/condiment/soysauce
	)
	crate_name = "condiments crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/ingredients_basic/corn
	name = "Corn Crate"
	desc = "Crate containing five ears of corn."
	cost = 75
	contains = list(/obj/item/food/grown/corn,
					/obj/item/food/grown/corn,
					/obj/item/food/grown/corn,
					/obj/item/food/grown/corn,
					/obj/item/food/grown/corn,
	)

/datum/supply_pack/food/ingredients_basic/chili
	name = "Chili Pepper Crate"
	desc = "Crate containing five chili peppers."
	cost = 75
	contains = list(/obj/item/food/grown/chili,
					/obj/item/food/grown/chili,
					/obj/item/food/grown/chili,
					/obj/item/food/grown/chili,
					/obj/item/food/grown/chili,
	)

/datum/supply_pack/food/ingredients_basic/tomato
	name = "Tomato Crate"
	desc = "Crate containing five tomatoes."
	cost = 75
	contains = list(/obj/item/food/grown/tomato,
					/obj/item/food/grown/tomato,
					/obj/item/food/grown/tomato,
					/obj/item/food/grown/tomato,
					/obj/item/food/grown/tomato,
	)

/datum/supply_pack/food/ingredients_basic/potato
	name = "Potato Crate"
	desc = "Crate containing five potatoes."
	cost = 75
	contains = list(/obj/item/food/grown/potato,
					/obj/item/food/grown/potato,
					/obj/item/food/grown/potato,
					/obj/item/food/grown/potato,
					/obj/item/food/grown/potato,
	)

/datum/supply_pack/food/ingredients_basic/carrot
	name = "Carrot Crate"
	desc = "Crate containing five carrots."
	cost = 75
	contains = list(/obj/item/food/grown/carrot,
					/obj/item/food/grown/carrot,
					/obj/item/food/grown/carrot,
					/obj/item/food/grown/carrot,
					/obj/item/food/grown/carrot,
	)

/datum/supply_pack/food/ingredients_basic/cabbage
	name = "Cabbage Crate"
	desc = "Crate containing five cabbages."
	cost = 75
	contains = list(/obj/item/food/grown/cabbage,
					/obj/item/food/grown/cabbage,
					/obj/item/food/grown/cabbage,
					/obj/item/food/grown/cabbage,
					/obj/item/food/grown/cabbage,
	)

/datum/supply_pack/food/ingredients_basic/eggplant
	name = "Eggplant Crate"
	desc = "Crate containing five eggplants."
	cost = 75
	contains = list(/obj/item/food/grown/eggplant,
					/obj/item/food/grown/eggplant,
					/obj/item/food/grown/eggplant,
					/obj/item/food/grown/eggplant,
					/obj/item/food/grown/eggplant,
	)

/datum/supply_pack/food/ingredients_basic/whitebeet
	name = "White-beet Crate"
	desc = "Crate containing five white-beets."
	cost = 75
	contains = list(/obj/item/food/grown/whitebeet,
					/obj/item/food/grown/whitebeet,
					/obj/item/food/grown/whitebeet,
					/obj/item/food/grown/whitebeet,
					/obj/item/food/grown/whitebeet,
	)

/datum/supply_pack/food/ingredients_basic/redbeet
	name = "Redbeet Crate"
	desc = "Crate containing five redbeets."
	cost = 75
	contains = list(/obj/item/food/grown/redbeet,
					/obj/item/food/grown/redbeet,
					/obj/item/food/grown/redbeet,
					/obj/item/food/grown/redbeet,
					/obj/item/food/grown/redbeet,
	)

/datum/supply_pack/food/ingredients_basic/chanterelle
	name = "Chanterelle Crate"
	desc = "Crate containing five chanterelle mushrooms."
	cost = 75
	contains = list(/obj/item/food/grown/mushroom/chanterelle,
					/obj/item/food/grown/mushroom/chanterelle,
					/obj/item/food/grown/mushroom/chanterelle,
					/obj/item/food/grown/mushroom/chanterelle,
					/obj/item/food/grown/mushroom/chanterelle,
	)

/datum/supply_pack/food/ingredients_basic/onion
	name = "Onion Crate"
	desc = "Crate containing five onions."
	cost = 75
	contains = list(/obj/item/food/grown/onion,
					/obj/item/food/grown/onion,
					/obj/item/food/grown/onion,
					/obj/item/food/grown/onion,
					/obj/item/food/grown/onion,
	)

/datum/supply_pack/food/ingredients_basic/pumpkin
	name = "Pumpkin Crate"
	desc = "Crate containing five pumpkins."
	cost = 75
	contains = list(/obj/item/food/grown/pumpkin,
					/obj/item/food/grown/pumpkin,
					/obj/item/food/grown/pumpkin,
					/obj/item/food/grown/pumpkin,
					/obj/item/food/grown/pumpkin,
	)

/datum/supply_pack/food/ingredients_basic/peas
	name = "Peas Crate"
	desc = "Crate containing five peapods."
	cost = 75
	contains = list(/obj/item/food/grown/peas,
					/obj/item/food/grown/peas,
					/obj/item/food/grown/peas,
					/obj/item/food/grown/peas,
					/obj/item/food/grown/peas,
	)

/datum/supply_pack/food/ingredients_basic/sweet_potato
	name = "Sweet Potato Crate"
	desc = "Crate containing five sweet potatoes."
	cost = 75
	contains = list(/obj/item/food/grown/sweet_potato,
					/obj/item/food/grown/sweet_potato,
					/obj/item/food/grown/sweet_potato,
					/obj/item/food/grown/sweet_potato,
					/obj/item/food/grown/sweet_potato,
	)

/datum/supply_pack/food/ingredients_basic/apple
	name = "Apple Crate"
	desc = "Crate containing five apples."
	cost = 75
	contains = list(/obj/item/food/grown/apple,
					/obj/item/food/grown/apple,
					/obj/item/food/grown/apple,
					/obj/item/food/grown/apple,
					/obj/item/food/grown/apple,
	)

/datum/supply_pack/food/ingredients_basic/cherry
	name = "Cherry Crate"
	desc = "Crate containing five cherries."
	cost = 75
	contains = list(/obj/item/food/grown/cherries,
					/obj/item/food/grown/cherries,
					/obj/item/food/grown/cherries,
					/obj/item/food/grown/cherries,
					/obj/item/food/grown/cherries,
	)

/datum/supply_pack/food/ingredients_basic/lime
	name = "Lime Crate"
	desc = "Crate containing five limes."
	cost = 75
	contains = list(/obj/item/food/grown/citrus/lime,
					/obj/item/food/grown/citrus/lime,
					/obj/item/food/grown/citrus/lime,
					/obj/item/food/grown/citrus/lime,
					/obj/item/food/grown/citrus/lime,
	)

/datum/supply_pack/food/ingredients_basic/orange
	name = "Orange Crate"
	desc = "Crate containing five oranges."
	cost = 75
	contains = list(/obj/item/food/grown/citrus/orange,
					/obj/item/food/grown/citrus/orange,
					/obj/item/food/grown/citrus/orange,
					/obj/item/food/grown/citrus/orange,
					/obj/item/food/grown/citrus/orange,
	)

/datum/supply_pack/food/ingredients_basic/lemon
	name = "Lemon Crate"
	desc = "Crate containing five lemons."
	cost = 75
	contains = list(/obj/item/food/grown/citrus/lemon,
					/obj/item/food/grown/citrus/lemon,
					/obj/item/food/grown/citrus/lemon,
					/obj/item/food/grown/citrus/lemon,
					/obj/item/food/grown/citrus/lemon,
	)

/datum/supply_pack/food/ingredients_basic/watermelon
	name = "Watermelon Crate"
	desc = "Crate containing five watermelons."
	cost = 75
	contains = list(/obj/item/food/grown/watermelon,
					/obj/item/food/grown/watermelon,
					/obj/item/food/grown/watermelon,
					/obj/item/food/grown/watermelon,
					/obj/item/food/grown/watermelon,
	)

/datum/supply_pack/food/ingredients_basic/berries
	name = "Berries Crate"
	desc = "Crate containing five bunches of berries."
	cost = 75
	contains = list(/obj/item/food/grown/berries,
					/obj/item/food/grown/berries,
					/obj/item/food/grown/berries,
					/obj/item/food/grown/berries,
					/obj/item/food/grown/berries,
	)

/datum/supply_pack/food/ingredients_basic/banana
	name = "Banana Crate"
	desc = "Crate containing five bananas."
	cost = 75
	contains = list(/obj/item/food/grown/banana,
					/obj/item/food/grown/banana,
					/obj/item/food/grown/banana,
					/obj/item/food/grown/banana,
					/obj/item/food/grown/banana,
	)

/datum/supply_pack/food/ingredients_basic/grapes
	name = "Grapes Crate"
	desc = "Crate containing five bunches of grapes."
	cost = 75
	contains = list(/obj/item/food/grown/grapes,
					/obj/item/food/grown/grapes,
					/obj/item/food/grown/grapes,
					/obj/item/food/grown/grapes,
					/obj/item/food/grown/grapes,
	)

/datum/supply_pack/food/sugar
	name = "Sugar Crate"
	desc = "A crate containing one bag of refined white sugar, useful for practicing patissiers."
	cost = 50
	contains = list(/obj/item/reagent_containers/condiment/sugar)
	crate_name = "sugar crate"
	crate_type = /obj/structure/closet/crate

/datum/supply_pack/food/ingredients_basic/meat
	name = "Standard Meat Crate"
	desc = "A crate containing five cuts of natural raw meat."
	cost = 75
	contains = list(/obj/item/food/meat/slab,
					/obj/item/food/meat/slab,
					/obj/item/food/meat/slab,
					/obj/item/food/meat/slab,
					/obj/item/food/meat/slab,
	)

/datum/supply_pack/food/ingredients_basic/chicken_meat
	name = "Chicken Meat Crate"
	desc = "A crate containing five assorted cuts of chicken."
	cost = 75
	contains = list(/obj/item/food/meat/slab/chicken,
					/obj/item/food/meat/slab/chicken,
					/obj/item/food/meat/slab/chicken,
					/obj/item/food/meat/slab/chicken,
					/obj/item/food/meat/slab/chicken,
	)

/datum/supply_pack/food/ingredients_basic/rice
	name = "Rice Crate"
	desc = "A crate containing five packages of medium-grain rice, ready for cooking."
	cost = 75
	contains = list(/obj/item/reagent_containers/condiment/rice,
					/obj/item/reagent_containers/condiment/rice,
					/obj/item/reagent_containers/condiment/rice,
					/obj/item/reagent_containers/condiment/rice,
					/obj/item/reagent_containers/condiment/rice,
	)

/datum/supply_pack/food/ingredients_basic/flour
	name = "Flour Crate"
	desc = "A crate containing five packages of wheat flour, for all your baking needs and more."
	cost = 100
	contains = list(/obj/item/reagent_containers/condiment/flour,
					/obj/item/reagent_containers/condiment/flour,
					/obj/item/reagent_containers/condiment/flour,
					/obj/item/reagent_containers/condiment/flour,
					/obj/item/reagent_containers/condiment/flour,
	)

/datum/supply_pack/food/ingredients_basic/milk
	name = "Milk Crate"
	desc = "A crate containing five cartons of pasteurized milk."
	cost = 100
	contains = list(/obj/item/reagent_containers/condiment/milk,
					/obj/item/reagent_containers/condiment/milk,
					/obj/item/reagent_containers/condiment/milk,
					/obj/item/reagent_containers/condiment/milk,
					/obj/item/reagent_containers/condiment/milk,
	)

/datum/supply_pack/food/ingredients_basic/soymilk
	name = "Soy Milk Crate"
	desc = "A crate containing five cartons of soy milk."
	cost = 100
	contains = list(/obj/item/reagent_containers/condiment/soymilk,
					/obj/item/reagent_containers/condiment/soymilk,
					/obj/item/reagent_containers/condiment/soymilk,
					/obj/item/reagent_containers/condiment/soymilk,
					/obj/item/reagent_containers/condiment/soymilk,
	)
/datum/supply_pack/food/ingredients_basic/eggs
	name = "Eggs Crate"
	desc = "One carton of unfertilized chicken eggs, packaged and sealed to prevent any damages during transportation."
	cost = 50
	contains = list(/obj/item/storage/fancy/egg_box)

/datum/supply_pack/food/ingredients_basic/oats
	name = "Oats Crate"
	desc = "Crate containing five stalks of unprocessed oats."
	cost = 50
	contains = list(/obj/item/food/grown/oat,
					/obj/item/food/grown/oat,
					/obj/item/food/grown/oat,
					/obj/item/food/grown/oat,
					/obj/item/food/grown/oat,
	)
/datum/supply_pack/food/ingredients_basic/soybeans
	name = "Soybeans Crate"
	desc = "Crate containing five handfuls of soybeans."
	cost = 75
	contains = list(/obj/item/food/grown/soybeans,
					/obj/item/food/grown/soybeans,
					/obj/item/food/grown/soybeans,
					/obj/item/food/grown/soybeans,
					/obj/item/food/grown/soybeans,
	)
/datum/supply_pack/food/ingredients_basic/vanillapods
	name = "Vanilla Pods Crate"
	desc = "Crate containing five vanilla pods."
	cost = 75
	contains = list(/obj/item/food/grown/vanillapod,
					/obj/item/food/grown/vanillapod,
					/obj/item/food/grown/vanillapod,
					/obj/item/food/grown/vanillapod,
					/obj/item/food/grown/vanillapod,
	)
/datum/supply_pack/food/ingredients_basic/cocoapods
	name = "Cocoa Pods Crate"
	desc = "Crate containing five cocoa pods."
	cost = 75
	contains = list(/obj/item/food/grown/cocoapod,
					/obj/item/food/grown/cocoapod,
					/obj/item/food/grown/cocoapod,
					/obj/item/food/grown/cocoapod,
					/obj/item/food/grown/cocoapod,
	)
/datum/supply_pack/food/ingredients_basic/pineapple
	name = "Pineapple Crate"
	desc = "Crate containing five pineapples."
	cost = 75
	contains = list(/obj/item/food/grown/pineapple,
					/obj/item/food/grown/pineapple,
					/obj/item/food/grown/pineapple,
					/obj/item/food/grown/pineapple,
					/obj/item/food/grown/pineapple,
	)
/*
		Cooking
*/

/datum/supply_pack/food/grill
	name = "Griddle Construction Kit"
	desc = "DIY cooking has never been easier!"
	cost = 1000
	contains = list(/obj/item/circuitboard/machine/griddle)
	crate_name = "griddle circuit board crate"
	crate_type = /obj/structure/closet/crate
	no_bundle = TRUE

/datum/supply_pack/food/oven
	name = "Oven Construction Kit"
	desc = "DIY cooking has never been easier!"
	cost = 1500
	contains = list(/obj/item/circuitboard/machine/oven)
	crate_name = "griddle circuit board crate"
	crate_type = /obj/structure/closet/crate
	no_bundle = TRUE

/*
		Bees
*/

/datum/supply_pack/food/beekeeping_suits
	name = "Beekeeper Suit Crate"
	desc = "Bee business booming? Better be benevolent and boost botany by bestowing a bodacious-Beekeeper-suit! Contains one beekeeper suit and matching headwear."
	cost = 500
	contains = list(/obj/item/clothing/head/beekeeper_head,
					/obj/item/clothing/suit/beekeeper_suit)
	crate_name = "beekeeper suit crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/food/beekeeping_fullkit
	name = "Beekeeping Starter Crate"
	desc = "BEES BEES BEES. Contains three honey frames, a beekeeper suit and helmet, flyswatter, bee house, and, of course, a pure-bred Makosso-Warra-Standardized Queen Bee!"
	cost = 1000
	contains = list(/obj/structure/beebox/unwrenched,
					/obj/item/honey_frame,
					/obj/item/honey_frame,
					/obj/item/honey_frame,
					/obj/item/queen_bee/bought,
					/obj/item/clothing/head/beekeeper_head,
					/obj/item/clothing/suit/beekeeper_suit,
					/obj/item/melee/flyswatter)
	crate_name = "beekeeping starter crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/food/kitchen_knife
	name = "Kitchen Knife Crate"
	desc = "Need a new knife to cut something hard? Try out this stamped steel knife, straight from The New Gorlex Republic's factories."
	cost = 100
	contains = list(/obj/item/melee/knife/kitchen)
	crate_name = "kitchen knife crate"
	crate_type = /obj/structure/closet/crate/wooden


/* Probably write better descriptions*/

/datum/supply_pack/food/ingredients_basic/dote
	name = "Dote Berry Crate"
	desc = "A crate full of easily dried, flavorful tecetian berries. Given its hardiness these are probably not from Teceti itself."
	cost = 100
	contains = list(
		/obj/item/food/grown/dote_berries,
		/obj/item/food/grown/dote_berries,
		/obj/item/food/grown/dote_berries,
		/obj/item/food/grown/dote_berries,
		/obj/item/food/grown/dote_berries
	)

/datum/supply_pack/food/ingredients_basic/dotu
	name = "Dotu-Fime Crate"
	desc = "Small plump fruit from Teceti."
	cost = 100
	contains = list(
		/obj/item/food/grown/dotu_fime,
		/obj/item/food/grown/dotu_fime,
		/obj/item/food/grown/dotu_fime,
		/obj/item/food/grown/dotu_fime,
		/obj/item/food/grown/dotu_fime,
	)

/datum/supply_pack/food/ingredients_basic/fara
	name = "Fara-Li Crate"
	desc = "A small, mildly spicy fruit native to Teceti."
	cost = 100
	contains = list(
		/obj/item/food/grown/fara_li,
		/obj/item/food/grown/fara_li,
		/obj/item/food/grown/fara_li,
		/obj/item/food/grown/fara_li,
		/obj/item/food/grown/fara_li
	)

/datum/supply_pack/food/ingredients_basic/refa
	name = "Refa-Li Crate"
	desc = "A small spicy cave fruit native to Teceti."
	cost = 100
	contains = list(
		/obj/item/food/grown/refa_li,
		/obj/item/food/grown/refa_li,
		/obj/item/food/grown/refa_li,
		/obj/item/food/grown/refa_li,
		/obj/item/food/grown/refa_li
	)

/datum/supply_pack/food/ingredients_basic/sososi
	name = "Sososi Crate"
	desc = "A gel-filled leaf native to the Tecetian Arid."
	cost = 100
	contains = list(
		/obj/item/food/grown/sososi,
		/obj/item/food/grown/sososi,
		/obj/item/food/grown/sososi,
		/obj/item/food/grown/sososi,
		/obj/item/food/grown/sososi
	)

/datum/supply_pack/food/ingredients_basic/siti
	name = "Siti Crate"
	desc = "A small crunchy leaf native to Teceti."
	cost = 100
	contains = list(
		/obj/item/food/grown/siti,
		/obj/item/food/grown/siti,
		/obj/item/food/grown/siti,
		/obj/item/food/grown/siti,
		/obj/item/food/grown/siti
	)

/datum/supply_pack/food/ingredients_basic/miras
	name = "Miras Meat Crate"
	desc = "The meat of a small tecetian game animal."
	cost = 100
	contains = list(
		/obj/item/food/meat/slab/miras,
		/obj/item/food/meat/slab/miras,
		/obj/item/food/meat/slab/miras,
		/obj/item/food/meat/slab/miras,
		/obj/item/food/meat/slab/miras
	)

/datum/supply_pack/food/ingredients_basic/tiris
	name = "Tiris Meat Crate"
	desc = "The meat of a tecetian herd animal."
	cost = 100
	contains = list(
		/obj/item/food/meat/slab/tiris,
		/obj/item/food/meat/slab/tiris,
		/obj/item/food/meat/slab/tiris,
		/obj/item/food/meat/slab/tiris,
		/obj/item/food/meat/slab/tiris
	)

/datum/supply_pack/food/ingredients_basic/remes
	name = "Remes Meat Crate"
	desc = "Meat from a tecetian mollusk. Safe to eat raw!"
	cost = 100
	contains = list(
		/obj/item/food/meat/slab/remes,
		/obj/item/food/meat/slab/remes,
		/obj/item/food/meat/slab/remes,
		/obj/item/food/meat/slab/remes,
		/obj/item/food/meat/slab/remes
	)

/datum/supply_pack/food/ingredients_basic/dofi
	name = "Dofitis Meat Crate"
	desc = "The meat of a tecetian beast of burden."
	cost = 100
	contains = list(
		/obj/item/food/meat/slab/dofitis,
		/obj/item/food/meat/slab/dofitis,
		/obj/item/food/meat/slab/dofitis,
		/obj/item/food/meat/slab/dofitis,
		/obj/item/food/meat/slab/dofitis
	)

/datum/supply_pack/food/ingredients_basic/tiris_milk
	name = "Tiris Milk Crate"
	desc = "Milk from a Tiris. Made and packaged in CLIP space."
	cost = 100
	contains = list(
		/obj/item/reagent_containers/condiment/tiris_milk,
		/obj/item/reagent_containers/condiment/tiris_milk,
		/obj/item/reagent_containers/condiment/tiris_milk,
		/obj/item/reagent_containers/condiment/tiris_milk,
		/obj/item/reagent_containers/condiment/tiris_milk,
	)

/datum/supply_pack/food/ingredients_basic/tiris_sele
	name = "Tiris Sele Crate"
	desc = "A gentle blood sauce made from a Tiris."
	cost = 20
	contains = list(
		/obj/item/reagent_containers/condiment/tiris_sele
	)

/datum/supply_pack/food/ingredients_basic/tiris_sale
	name = "Tiris Sale Crate"
	desc = "A strong blood sauce made from a Tiris."
	cost = 20
	contains = list(
		/obj/item/reagent_containers/condiment/tiris_sale
	)

/datum/supply_pack/food/ingredients_basic/mead
	name = "Mead Six Pack Crate"
	desc = "Gezenan Dark Mead in a six-pack. Slightly better value than buying straight from a vendor."
	cost = 50
	contains = list(
		/obj/item/storage/cans/sixbeer
	)
