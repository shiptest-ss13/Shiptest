/datum/supply_pack/food
	group = "Food & Agricultural"

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
					/obj/item/storage/box/donkpockets/donkpocketberry,
					/obj/item/storage/box/donkpockets/donkpockethonk)
	crate_name = "donk pocket crate"
	crate_type = /obj/structure/closet/crate/freezer
	faction = FACTION_SYNDICATE

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

/datum/supply_pack/food/pizza/fill(obj/structure/closet/crate/C)
	. = ..()
	for(var/obj/item/pizzabox/P in C)
		if(prob(0.5)) //0.5% chance for each box
			var/obj/item/pizzabox/infinite/fourfiveeight = new(C)
			fourfiveeight.boxtag = P.boxtag
			qdel(P)

/datum/supply_pack/food/ration
	name = "Ration Crate"
	desc = "6 standerd issue rations."
	cost = 500
	contains = list(/obj/effect/spawner/lootdrop/ration,
					/obj/effect/spawner/lootdrop/ration,
					/obj/effect/spawner/lootdrop/ration,
					/obj/effect/spawner/lootdrop/ration,
					/obj/effect/spawner/lootdrop/ration,
					/obj/effect/spawner/lootdrop/ration)
	crate_name = "ration crate"
	crate_type = /obj/structure/closet/crate

/*
		Ingredients
*/

/datum/supply_pack/food/ingredients_basic
	name = "Basic Ingredients Crate"
	desc = "Get things cooking with this crate full of useful ingredients! Contains a dozen eggs, two slabs of meat, some flour, some rice, a bottle of milk, a bottle of soymilk, and a bag of sugar."
	cost = 300
	contains = list(/obj/item/reagent_containers/condiment/flour,
					/obj/item/reagent_containers/condiment/flour,
					/obj/item/reagent_containers/condiment/rice,
					/obj/item/reagent_containers/condiment/milk,
					/obj/item/reagent_containers/condiment/soymilk,
					/obj/item/reagent_containers/condiment/sugar,
					/obj/item/storage/fancy/egg_box,
					/obj/item/reagent_containers/food/snacks/meat/slab,
					/obj/item/reagent_containers/food/snacks/meat/slab
	)
	crate_name = "food crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/ingredients_condiments
	name = "Condiments Crate"
	desc = "A variety of garnishes for topping off your dish with a little extra pizzaz. Contains a bottle of enzyme, a salt shaker, a pepper mill, a bottle of ketchup, a bottle of hot sauce, a bottle of BBQ sauce, and a bottle of cream."
	cost = 250
	contains = list(/obj/item/reagent_containers/condiment/enzyme,
					/obj/item/reagent_containers/condiment/saltshaker,
					/obj/item/reagent_containers/condiment/peppermill,
					/obj/item/reagent_containers/condiment/ketchup,
					/obj/item/reagent_containers/condiment/hotsauce,
					/obj/item/reagent_containers/food/drinks/bottle/cream,
					/obj/item/reagent_containers/condiment/bbqsauce
	)
	crate_name = "condiments crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/ingredients_randomized
	name = "Exotic Meat Crate"
	desc = "The best cuts in the whole galaxy. Probably."
	cost = 500
	contains = list(/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/slime,
					/obj/item/reagent_containers/food/snacks/meat/slab/killertomato,
					/obj/item/reagent_containers/food/snacks/meat/slab/bear,
					/obj/item/reagent_containers/food/snacks/meat/slab/xeno,
					/obj/item/reagent_containers/food/snacks/meat/slab/spider,
					/obj/item/reagent_containers/food/snacks/meat/slab/penguin,
					/obj/item/reagent_containers/food/snacks/spiderleg,
					/obj/item/reagent_containers/food/snacks/fishmeat/carp,
					/obj/item/reagent_containers/food/snacks/meat/slab/human
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
	desc = "Less interesting cuts of meat, but filling nonetheless."
	cost = 300
	contains = list(/obj/item/reagent_containers/food/snacks/meat/slab,
					/obj/item/reagent_containers/food/snacks/meat/slab/chicken,
					/obj/item/reagent_containers/food/snacks/meat/slab/synthmeat,
					/obj/item/reagent_containers/food/snacks/meat/rawbacon,
					/obj/item/reagent_containers/food/snacks/meatball
	)
	crate_name = "meat crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/ingredients_randomized/vegetables
	name = "Vegetables Crate"
	desc = "Grown in vats."
	cost = 250
	contains = list(/obj/item/reagent_containers/food/snacks/grown/chili,
					/obj/item/reagent_containers/food/snacks/grown/corn,
					/obj/item/reagent_containers/food/snacks/grown/tomato,
					/obj/item/reagent_containers/food/snacks/grown/potato,
					/obj/item/reagent_containers/food/snacks/grown/carrot,
					/obj/item/reagent_containers/food/snacks/grown/mushroom/chanterelle,
					/obj/item/reagent_containers/food/snacks/grown/onion,
					/obj/item/reagent_containers/food/snacks/grown/pumpkin
	)
	crate_name = "food crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/ingredients_randomized/fruits
	name = "Fruit Crate"
	desc = "Rich of vitamins, may contain oranges."
	cost = 250
	contains = list(/obj/item/reagent_containers/food/snacks/grown/citrus/lime,
					/obj/item/reagent_containers/food/snacks/grown/citrus/orange,
					/obj/item/reagent_containers/food/snacks/grown/citrus/lemon,
					/obj/item/reagent_containers/food/snacks/grown/watermelon,
					/obj/item/reagent_containers/food/snacks/grown/apple,
					/obj/item/reagent_containers/food/snacks/grown/berries,
					/obj/item/reagent_containers/food/snacks/grown/banana
	)
	crate_name = "food crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/ingredients_randomized/grains
	name = "Grains Crate"
	desc = "A crate full of various grains. How interesting."
	cost = 250
	contains = list(/obj/item/reagent_containers/food/snacks/grown/wheat,
					/obj/item/reagent_containers/food/snacks/grown/wheat,
					/obj/item/reagent_containers/food/snacks/grown/wheat, //Weighted to be more common
					/obj/item/reagent_containers/food/snacks/grown/oat,
					/obj/item/reagent_containers/food/snacks/grown/rice,
					/obj/item/reagent_containers/food/snacks/grown/soybeans
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
					/obj/item/reagent_containers/food/snacks/bun,
					/obj/item/reagent_containers/food/snacks/tortilla,
					/obj/item/reagent_containers/food/snacks/pizzabread
	)
	crate_name = "food crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/food/sugar
	name = "Sugar Crate"
	desc = "A crate with a few bags of sugar. Good for cake shops and amateur chemists."
	cost = 500
	contains = list(/obj/item/reagent_containers/condiment/sugar,
					/obj/item/reagent_containers/condiment/sugar,
					/obj/item/reagent_containers/condiment/sugar
	)
	crate_name = "sugar crate"
	crate_type = /obj/structure/closet/crate

/*
		Cooking
*/

/datum/supply_pack/food/grill
	name = "Grilling Starter Kit"
	desc = "Sometimes the stresses of the world are too much to bear. Some times, for God's sake, you just want to grill. This crate is for those times."
	cost = 1000
	contains = list(/obj/item/stack/sheet/mineral/coal/five,
					/obj/machinery/grill/unwrenched)
	crate_name = "grilling starter kit crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/food/grillfuel
	name = "Grilling Fuel Kit"
	desc = "Contains propane and propane accessories. (Note: doesn't contain any actual propane.)"
	cost = 250
	contains = list(/obj/item/stack/sheet/mineral/coal/ten)
	crate_name = "grilling fuel kit crate"

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
	desc = "Five small bottles of ethanol for the aspiring botanist or amateur chemist."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/bottle/ethanol,
					/obj/item/reagent_containers/glass/bottle/ethanol,
					/obj/item/reagent_containers/glass/bottle/ethanol,
					/obj/item/reagent_containers/glass/bottle/ethanol,
					/obj/item/reagent_containers/glass/bottle/ethanol
					)
	crate_name = "gardening crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/food/weedcontrol
	name = "Weed Control Crate"
	desc = "Contains a scythe, gasmask, and two anti-weed defoliant grenades, for when your garden grows out of control."
	cost = 750
	contains = list(/obj/item/scythe,
					/obj/item/clothing/mask/gas,
					/obj/item/grenade/chem_grenade/antiweed,
					/obj/item/grenade/chem_grenade/antiweed)
	crate_name = "weed control crate"
	crate_type = /obj/structure/closet/crate/secure/hydroponics

/datum/supply_pack/food/seeds
	name = "Seeds Crate"
	desc = "Big things have small beginnings. Contains fourteen different seeds."
	cost = 750
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
	desc = "Bee business booming? Better be benevolent and boost botany by bestowing bi-Beekeeper-suits! Contains two beekeeper suits and matching headwear."
	cost = 1000
	contains = list(/obj/item/clothing/head/beekeeper_head,
					/obj/item/clothing/suit/beekeeper_suit,
					/obj/item/clothing/head/beekeeper_head,
					/obj/item/clothing/suit/beekeeper_suit)
	crate_name = "beekeeper suit crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/food/beekeeping_fullkit
	name = "Beekeeping Starter Crate"
	desc = "BEES BEES BEES. Contains three honey frames, a beekeeper suit and helmet, flyswatter, bee house, and, of course, a pure-bred Nanotrasen-Standardized Queen Bee!"
	cost = 2000
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
