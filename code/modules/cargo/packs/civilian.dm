/datum/supply_pack/civilian
	category = "Civilian & Decoration"
	crate_name = "civilian supply crate"
	crate_type = /obj/structure/closet/crate/wooden

/*
		Janitorial
*/

/datum/supply_pack/civilian/janitor
	name = "Janitorial Supplies Crate"
	desc = "Contains a cleaning cart and enough supplies to stock it. Contains a janitorial cart, galoshes, a mop, a pushbroom, a few wet-floor signs, a trash bag, a cloth, and a spray bottle."
	cost = 200
	crate_type = /obj/structure/closet/crate/large
	no_bundle = TRUE
	contains = list(/obj/item/reagent_containers/glass/bucket,
					/obj/item/mop,
					/obj/item/pushbroom,
					/obj/item/clothing/suit/caution,
					/obj/item/clothing/suit/caution,
					/obj/item/clothing/suit/caution,
					/obj/item/storage/bag/trash,
					/obj/item/reagent_containers/spray/cleaner,
					/obj/structure/janitorialcart,
					/obj/item/clothing/shoes/galoshes,
					/obj/item/reagent_containers/glass/rag)
	crate_name = "janitorial supplies crate"

/datum/supply_pack/civilian/janitank
	name = "Janitor Backpack Crate"
	desc = "Call forth divine judgement upon dirt and grime with this high capacity janitor backpack. Contains 500 units of filth-cleansing space cleaner."
	cost = 500
	contains = list(/obj/item/watertank/janitor)
	crate_name = "janitor backpack crate"

/*
		Bundles
*/

/datum/supply_pack/civilian/sauna_starter
	name = "DIY Sauna Crate"
	desc = "A Kalixcian staple. Comes with a set of five freshly cleaned towels, and enough wood to make your very own Sauna. Water not included."
	cost = 500
	contains = list(/obj/item/stack/sheet/mineral/wood/twentyfive,
					/obj/item/reagent_containers/glass/bucket/wooden,
					/obj/item/towel,
					/obj/item/towel,
					/obj/item/towel,
					/obj/item/towel,
					/obj/item/towel,)
	crate_name = "sauna starter crate"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/civilian/fountainpens
	name = "Fountain Pen Crate"
	desc = "Contains a box of seven high-quality fountain pens."
	cost = 250
	contains = list(/obj/item/storage/box/fountainpens)
	crate_name = "calligraphy crate"
	crate_type = /obj/structure/closet/crate/wooden
	faction = /datum/faction/solgov

/datum/supply_pack/civilian/wrapping_paper
	name = "Festive Wrapping Paper Crate"
	desc = "Want to mail your loved ones gift-wrapped chocolates, stuffed animals, flattened flowers? You can do all that, with this crate full of wrapping paper."
	cost = 100
	contains = list(/obj/item/stack/wrapping_paper)
	crate_name = "festive wrapping paper crate"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/civilian/paper
	name = "Bureaucracy Crate"
	desc = "High stacks of papers on your desk are a big problem - make it Pea-sized with these bureaucratic supplies! Contains six pens, some camera film, hand labeler supplies, a paper bin, a carbon paper bin, three folders, a laser pointer, two clipboards and two stamps."//that was too forced
	cost = 250
	contains = list(/obj/structure/filingcabinet/chestdrawer/wheeled,
					/obj/item/camera_film,
					/obj/item/hand_labeler,
					/obj/item/hand_labeler_refill,
					/obj/item/hand_labeler_refill,
					/obj/item/paper_bin,
					/obj/item/paper_bin/carbon,
					/obj/item/pen/fourcolor,
					/obj/item/pen/fourcolor,
					/obj/item/pen,
					/obj/item/pen/fountain,
					/obj/item/pen/blue,
					/obj/item/pen/red,
					/obj/item/folder/blue,
					/obj/item/folder/red,
					/obj/item/folder/yellow,
					/obj/item/clipboard,
					/obj/item/clipboard,
					/obj/item/stamp,
					/obj/item/stamp/denied,
					/obj/item/laser_pointer/purple)
	crate_name = "bureaucracy crate"

/datum/supply_pack/civilian/coffee_starter
	name = "Personal Coffee Starter Kit"
	desc = "If you're looking to get some coffee supply for your caffeine-starved bridge crew, this is the place to start. Contains three mugs, a coffee pot, and two coffee cartridges. Coffee machine not included."
	cost = 100
	contains = list(/obj/item/reagent_containers/food/drinks/mug,
					/obj/item/reagent_containers/food/drinks/mug,
					/obj/item/reagent_containers/food/drinks/mug,
					/obj/item/reagent_containers/glass/coffeepot,
					/obj/item/coffee_cartridge,
					/obj/item/coffee_cartridge)
	crate_name = "Basic Coffee Supply Crate"

/datum/supply_pack/civilian/coffee_cartridge
	name = "Solar's Best Coffee Cartridge Resupply"
	desc = "Contains five coffee cartridges for your coffee machine, imported from Sol."
	cost = 200
	contains = list(/obj/item/coffee_cartridge,
					/obj/item/coffee_cartridge,
					/obj/item/coffee_cartridge,
					/obj/item/coffee_cartridge,
					/obj/item/coffee_cartridge)
	crate_name = "Coffee Cartridge Supply Crate"

/datum/supply_pack/civilian/coffee_cartridge_fancy
	name = "Premium Coffee Cartridge Resupply"
	desc = "Contains an assortment of five high-quality coffee cartridges."
	cost = 300
	contains = list(/obj/item/coffee_cartridge/fancy,
					/obj/item/coffee_cartridge/fancy,
					/obj/item/coffee_cartridge/fancy,
					/obj/item/coffee_cartridge/fancy,
					/obj/item/coffee_cartridge/fancy)
	crate_name = "Premium Coffee Supply Crate"

/datum/supply_pack/civilian/coffeekit
	name = "Coffee Shop Starter Crate"
	desc = "All the basic equipment needed for enterprising coffee-selling spacefarers. Coffeemaker not included."
	cost = 200
	contains = list(/obj/item/storage/box/coffeepack/robusta,
					/obj/item/storage/box/coffeepack/arabica,
					/obj/item/reagent_containers/glass/coffeepot,
					/obj/item/storage/fancy/coffee_condi_display,
					/obj/item/reagent_containers/food/drinks/bottle/cream,
					/obj/item/reagent_containers/condiment/milk,
					/obj/item/reagent_containers/condiment/soymilk,
					/obj/item/reagent_containers/condiment/sugar,
					/obj/item/reagent_containers/glass/bottle/syrup_bottle/caramel)
	crate_name = "coffee equpment crate"

/datum/supply_pack/civilian/coffeemaker
	name = "Coffeemaker Crate"
	desc = "Contains one pre-assembled Attention model coffeemaker."
	cost = 750
	contains = list(/obj/machinery/coffeemaker)
	crate_name = "coffeemaker crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/civilian/coffeemaker_premium
	name = "Premium Coffeemaker Crate"
	desc = "Contains one pre-assembled professional-grade Sirere model coffeemaker."
	cost = 1000
	contains = list(/obj/machinery/coffeemaker/premium)
	crate_name = "premium coffeemaker crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/civilian/syrup
	name = "Coffee Syrups Box"
	desc = "A packaged box of various syrups, perfect to make your delicious coffee even more diabetic."
	cost = 100
	contains = list(/obj/item/reagent_containers/glass/bottle/syrup_bottle/caramel,
					/obj/item/reagent_containers/glass/bottle/syrup_bottle/liqueur,
					/obj/item/reagent_containers/glass/bottle/syrup_bottle/honey,
					/obj/item/reagent_containers/glass/bottle/syrup_bottle/vanilla,
					/obj/item/reagent_containers/glass/bottle/syrup_bottle/tea,
					/obj/item/reagent_containers/glass/bottle/syrup_bottle/creme_de_cacao,
					/obj/item/reagent_containers/glass/bottle/syrup_bottle/creme_de_menthe)
	crate_name = "coffee syrups box"
	crate_type = /obj/structure/closet/cardboard

/*
		Decoration / flooring
*/

/datum/supply_pack/civilian/potted_plants
	name = "Potted Plants Crate"
	desc = "Spruce up the ship with these lovely plants! Contains a random assortment of five potted plants from Makosso-Warra's potted plant research division. Warranty void if thrown."
	cost = 350
	contains = list(/obj/item/kirbyplants/random,
					/obj/item/kirbyplants/random,
					/obj/item/kirbyplants/random,
					/obj/item/kirbyplants/random,
					/obj/item/kirbyplants/random)
	crate_name = "potted plants crate"

/datum/supply_pack/civilian/artsupply
	name = "Art Supplies"
	desc = "Make some happy little accidents with an easel, and unlimited imagination! Imagination not included." //removed the rcl, shiptest doesn't have the space for wireart (literally)
	cost = 400
	contains = list(/obj/structure/easel,
					/obj/item/canvas,
					/obj/item/canvas,
					/obj/item/canvas/twentythreeXtwentythree,
					/obj/item/canvas/twentythreeXtwentythree,
					/obj/item/canvas/nineteenXnineteen,
					/obj/item/canvas/nineteenXnineteen,
					/obj/item/canvas/twentythreeXnineteen,
					/obj/item/canvas/twentythreeXnineteen,
					/obj/item/storage/crayons,
					/obj/item/toy/crayon/spraycan,)
	crate_name = "art supply crate"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/civilian/carpet
	name = "Standard Carpet Crate"
	desc = "Plasteel floor tiles getting on your nerves? These stacks of extra soft carpet will tie any room together."
	cost = 350
	contains = list(/obj/item/stack/tile/carpet/fifty,
					/obj/item/stack/tile/carpet/black/fifty)
	crate_name = "premium carpet crate"

/datum/supply_pack/civilian/carpet_exotic
	name = "Exotic Carpet Crate"
	desc = "Exotic carpets for all your decorating needs. Contains 50 tiles each of 8 different flooring patterns."
	cost = 750
	contains = list(/obj/item/stack/tile/carpet/blue/fifty,
					/obj/item/stack/tile/carpet/cyan/fifty,
					/obj/item/stack/tile/carpet/green/fifty,
					/obj/item/stack/tile/carpet/orange/fifty,
					/obj/item/stack/tile/carpet/purple/fifty,
					/obj/item/stack/tile/carpet/red/fifty,
					/obj/item/stack/tile/carpet/royalblue/fifty,
					/obj/item/stack/tile/carpet/royalblack/fifty)
	crate_name = "exotic carpet crate"

/datum/supply_pack/civilian/noslipfloor
	name = "High-traction Floor Tiles"
	desc = "Make slipping a thing of the past with thirty industrial-grade anti-slip floortiles!"
	cost = 500
	contains = list(/obj/item/stack/tile/noslip/thirty)
	crate_name = "high-traction floor tiles crate"

/datum/supply_pack/civilian/pianocrate
	name = "Piano crate"
	desc = "Contains a single piano for the somberly tempered."
	cost = 500
	contains = list(/obj/structure/musician/piano/unanchored)
	crate_name = "piano crate"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/civilian/jukebox
	name = "Jukebox"
	desc = "Things a bit dull in the workplace? How about jamming out to some tunes!"
	cost = 1000
	contains = list(/obj/machinery/jukebox)
	crate_name = "Jukebox"

/datum/supply_pack/civilian/roulette
	name = "Roulette Table"
	desc = "Go all in with this premium, computerized roulette table! Requires a valid cash card to play."
	cost = 1000
	contains = list(/obj/machinery/roulette)
	crate_name = "roulette table crate"

/datum/supply_pack/civilian/icecreamsupplies
	name = "Ice Cream Supplies"
	desc = "Contains a portable ice cream dispenser, fit with waffle cones and a rainbow of flavors to choose from."
	cost = 1000
	contains = list(/obj/machinery/icecream_vat)
	crate_name = "ice cream vat crate"

/datum/supply_pack/civilian/id_crate
	name = "Box of Spare IDs"
	desc = "A box of spare IDs for replacing a lost ID."
	cost = 100
	contains = list(/obj/item/storage/box/ids)

/datum/supply_pack/civilian/bank_card_crate
	name = "Box of Spare Bank Cards"
	desc = "A box of spare IDs for replacing a lost bankcard."
	cost = 100
	contains = list(/obj/item/storage/box/bankcard)

/datum/supply_pack/civilian/spare_clothes
	name = "Spare Jumpsuits Crate"
	desc = "Contains a spare set of utility jumpsuits and shoes for those unfortunate accidents." //how did we not have this before
	cost = 150
	contains = list(/obj/item/clothing/under/utility,
					/obj/item/clothing/under/utility/skirt,
					/obj/item/clothing/shoes/sneakers/black,
					/obj/item/clothing/shoes/sneakers/black)
	crate_name = "spare jumpsuits crate"

/datum/supply_pack/civilian/satchel
	name = "Spare Satchel Crate"
	desc = "Contains a spare backpack, for the intrepid traveller who managed to lose the last one."
	cost = 50
	contains = list(/obj/item/storage/backpack/satchel)
	crate_name = "spare satchel crate"

/datum/supply_pack/civilian/backpack
	name = "Spare Backpack Crate"
	desc = "Contains a spare backpack, for the starfarers who just can't keep track of where they took it off."
	cost = 50
	contains = list(/obj/item/storage/backpack)
	crate_name = "spare backpack crate"

/datum/supply_pack/civilian/duffels
	name = "Spare Duffelbag Crate"
	desc = "Contains a spare duffelbag. Ideal for carrying items across long distances."
	cost = 50
	contains = list(/obj/item/storage/backpack/duffelbag)
	crate_name = "spare duffelbag crate"

/datum/supply_pack/civilian/broadcast_camera
	name = "Broadcast Camera Crate"
	desc = "Lights, Camera, Action! This consumer-grade broadcasting camera automatically streams to entertainment monitors across the sector. Not rated for use in actual combat."
	cost = 500
	contains = list(/obj/item/bodycamera/broadcast_camera)
	crate_name = "broadcast camera crate"
	crate_type = /obj/structure/closet/crate
