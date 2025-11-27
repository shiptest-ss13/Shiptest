/datum/supply_pack/food
	category = "Food & Agricultural"

/*
		Ready-to-eat
*/

/datum/supply_pack/food/donkpockets
	name = "Donk Pocket Variety Crate"
	desc = "Featuring a line up of Donk Co.'s most popular pastry!"
	cost = 500
	contains = list(/obj/item/storage/box/donkpockets/donkpocketspicy,
					/obj/item/storage/box/donkpockets/donkpocketteriyaki,
					/obj/item/storage/box/donkpockets/donkpocketpizza,
					/obj/item/storage/box/donkpockets/donkpocketberry)
	crate_name = "donk pocket crate"
	crate_type = /obj/structure/closet/crate/freezer
	faction = /datum/faction/syndicate

/datum/supply_pack/food/donkpockets/fill(obj/structure/closet/crate/C)
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

/datum/supply_pack/food/ingredients_randomized
	name = "Exotic Meat Crate"
	desc = "The best cuts in the whole sector. Probably."
	cost = 500
	contains = list(/obj/item/food/meat/slab/killertomato,
					/obj/item/food/meat/slab/bear,
					/obj/item/food/meat/slab/xeno,
					/obj/item/food/meat/slab/spider,
					/obj/item/food/meat/slab/penguin,
					/obj/item/food/spiderleg,
					/obj/item/food/fishmeat/carp,
					/obj/item/food/meat/slab,
	)
	crate_name = "meat crate"
	crate_type = /obj/structure/closet/crate/freezer
	var/items = 7

/datum/supply_pack/food/ingredients_randomized/fill(obj/structure/closet/crate/C)
	for(var/i in 1 to items)
		var/item = pick(contains)
		new item(C)

/datum/supply_pack/food/ingredients_randomized/meat
	name = "Standard Meat Crate"
	desc = "Less interesting, yet filling cuts of meat."
	cost = 300
	contains = list(/obj/item/food/meat/slab,
					/obj/item/food/meat/slab/chicken,
					/obj/item/food/meat/slab/synthmeat,
					/obj/item/food/meat/rawbacon,
					/obj/item/food/meatball
	)
	crate_name = "meat crate"
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

/datum/supply_pack/food/ingredients_randomized/grains
	name = "Grains Crate"
	desc = "A crate full of various grains. How interesting."
	cost = 100
	contains = list(/obj/item/food/grown/wheat,
					/obj/item/food/grown/wheat,
					/obj/item/food/grown/wheat, //Weighted to be more common
					/obj/item/food/grown/oat,
					/obj/item/food/grown/rice,
					/obj/item/food/grown/soybeans
	)
	crate_name = "food crate"
	crate_type = /obj/structure/closet/crate/freezer
	items = 10

/datum/supply_pack/food/ingredients_randomized/bread
	name = "Bread Crate"
	desc = "A crate full of various breads. Bready to either be eaten or made into delicious meals."
	cost = 300
	contains = list(/obj/item/food/bread/plain,
					/obj/item/food/breadslice/plain,
					/obj/item/food/breadslice/plain,
					/obj/item/food/breadslice/plain, //Weighted to be more common
					/obj/item/food/bun,
					/obj/item/food/tortilla,
					/obj/item/food/pizzabread
	)
	crate_name = "food crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/sugar
	name = "Sugar Crate"
	desc = "A crate with a few bags of sugar. Good for cake shops and amateur chemists."
	cost = 50
	contains = list(/obj/item/reagent_containers/condiment/sugar)
	crate_name = "sugar crate"
	crate_type = /obj/structure/closet/crate

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
		Botanical
*/

/datum/supply_pack/food/hydrotank
	name = "Hydroponics Backpack Crate"
	desc = "Bring on the flood with this high-capacity backpack crate. Contains 500 units of life-giving H2O."
	cost = 750
	contains = list(/obj/item/watertank)
	crate_name = "hydroponics backpack crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/food/gardening
	name = "Gardening Crate"
	desc = "Supplies for growing a great garden! Contains two bottles of ammonia, two Plant-B-Gone spray bottles, a hatchet, cultivator, plant analyzer, as well as a pair of leather gloves and a botanist's apron."
	cost = 500
	contains = list(/obj/item/reagent_containers/spray/plantbgone,
					/obj/item/reagent_containers/spray/plantbgone,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/hatchet,
					/obj/item/cultivator,
					/obj/item/plant_analyzer,
					/obj/item/clothing/gloves/botanic_leather,
					/obj/item/clothing/suit/apron,
					/obj/item/storage/box/disks_plantgene)
	crate_name = "gardening crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/food/ethanol
	name = "Ethanol Crate"
	desc = "Contains one small bottle of ethanol for the aspiring botanist or amateur chemist."
	cost = 100
	contains = list(/obj/item/reagent_containers/glass/bottle/ethanol)
	crate_name = "gardening crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/food/weedcontrol
	name = "Weed Control Crate"
	desc = "Contains a scythe, gasmask, and two anti-weed defoliant grenades, for when your garden grows out of control."
	cost = 200
	contains = list(/obj/item/scythe,
					/obj/item/clothing/mask/gas,
					/obj/item/grenade/chem_grenade/antiweed,
					/obj/item/grenade/chem_grenade/antiweed)
	crate_name = "weed control crate"
	crate_type = /obj/structure/closet/crate/secure/hydroponics

/datum/supply_pack/food/seeds
	name = "Seeds Crate"
	desc = "Big things have small beginnings. Contains fourteen different seeds."
	cost = 150
	contains = list(/obj/item/seeds/chili,
					/obj/item/seeds/cotton,
					/obj/item/seeds/berry,
					/obj/item/seeds/corn,
					/obj/item/seeds/eggplant,
					/obj/item/seeds/tomato,
					/obj/item/seeds/soya,
					/obj/item/seeds/wheat,
					/obj/item/seeds/wheat/rice,
					/obj/item/seeds/carrot,
					/obj/item/seeds/sunflower,
					/obj/item/seeds/chanter,
					/obj/item/seeds/potato,
					/obj/item/seeds/sugarcane)
	crate_name = "seeds crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/food/exoticseeds
	name = "Exotic Seeds Crate"
	desc = "Any entrepreneuring botanist's dream. Contains eleven different seeds, including two mystery seeds!"
	cost = 1000
	contains = list(/obj/item/seeds/nettle,
					/obj/item/seeds/plump,
					/obj/item/seeds/liberty,
					/obj/item/seeds/amanita,
					/obj/item/seeds/reishi,
					/obj/item/seeds/bamboo,
					/obj/item/seeds/eggplant/eggy,
					/obj/item/seeds/rainbow_bunch,
					/obj/item/seeds/rainbow_bunch,
					/obj/item/seeds/random,
					/obj/item/seeds/random)
	crate_name = "exotic seeds crate"
	crate_type = /obj/structure/closet/crate/hydroponics

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
	desc = "BEES BEES BEES. Contains three honey frames, a beekeeper suit and helmet, flyswatter, bee house, and, of course, a pure-bred Nanotrasen-Standardized Queen Bee!"
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
