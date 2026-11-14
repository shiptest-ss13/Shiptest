/datum/supply_pack/gardening
	category = "Hydroponics & Gardening"
	crate_name = "gardening crate"
	crate_type = /obj/structure/closet/crate/hydroponics



/*
		Botanical
*/

/datum/supply_pack/gardening/starter
	name = "Starter Gardening Crate"
	desc = "Supplies for starting a great garden! Contains two bottles of ammonia, two Plant-B-Gone spray bottles, a hatchet, cultivator, plant analyzer, as well as a pair of leather gloves and a botanist's apron."
	cost = 500
	contains = list(
		/obj/item/reagent_containers/spray/plantbgone,
		/obj/item/reagent_containers/spray/plantbgone,
		/obj/item/reagent_containers/glass/bottle/ammonia,
		/obj/item/reagent_containers/glass/bottle/ammonia,
		/obj/item/hatchet,
		/obj/item/cultivator,
		/obj/item/plant_analyzer,
		/obj/item/clothing/gloves/botanic_leather,
		/obj/item/clothing/suit/apron,
	)

/datum/supply_pack/gardening/hydrotank
	name = "Hydroponics Backpack Crate"
	desc = "Bring on the flood with this high-capacity backpack crate. Contains 500 units of life-giving H2O."
	cost = 750
	contains = list(/obj/item/watertank)
	crate_name = "hydroponics backpack crate"
	crate_type = /obj/structure/closet/crate/hydroponics


/datum/supply_pack/gardening/seeds
	name = "Seeds Crate"
	desc = "Big things have small beginnings. Contains fourteen different seeds."
	cost = 150
	contains = list(
		/obj/item/seeds/chili,
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
		/obj/item/seeds/sugarcane
	)
	crate_name = "seeds crate"

/datum/supply_pack/gardening/teceti_seeds
	name = "Tecetian Seed Crate"
	desc = "A starter set of Frontier-friendly Tecetian flora. Contains 6 seeds."
	cost = 150
	contains = list(
		/obj/item/seeds/refa_li,
		/obj/item/seeds/siti,
		/obj/item/seeds/sososi,
		/obj/item/seeds/dote_berries,
		/obj/item/seeds/dotu_fime,
		/obj/item/seeds/fara_li,
	)
	crate_name = "seeds crate"

/* Gardening Chems */

/datum/supply_pack/gardening/bulkethanol
	name = "Bulk Ethanol Crate"
	desc = "Contains a jug filled with ethanol."
	cost = 200
	contains = list(/obj/item/reagent_containers/glass/chem_jug/ethanol)

/datum/supply_pack/gardening/eznutriment
	name = "Bulk E-Z-Nutriment Crate"
	desc = "Contains a jug filled with 150u of E-Z-Nutriment."
	cost = 300
	contains = list(/obj/item/reagent_containers/glass/chem_jug/eznutriment)
	crate_name = "bulk E-Z-Nutriment crate"

/datum/supply_pack/gardening/left4zednutriment
	name = "Bulk Left 4 Zed Crate"
	desc = "Contains a jug filled with 150u of Left 4 Zed."
	cost = 300
	contains = list(/obj/item/reagent_containers/glass/chem_jug/left4zednutriment)
	crate_name = "bulk Left 4 Zed crate"

/datum/supply_pack/gardening/robustharvestnutriment
	name = "Bulk Robust Harvest Crate"
	desc = "Contains a jug filled with 150u of Robust Harvest."
	cost = 300
	contains = list(/obj/item/reagent_containers/glass/chem_jug/robustharvestnutriment)
	crate_name = "bulk Robust Harvest crate"

/datum/supply_pack/gardening/endurogrownutrient
	name = "Bulk Enduro Grow Crate"
	desc = "Contains a jug filled with 150u of Enduro Grow."
	cost = 500
	contains = list(/obj/item/reagent_containers/glass/chem_jug/endurogrow)
	crate_name = "bulk Enduro Grow crate"

/datum/supply_pack/gardening/liquidearthquakenutrient
	name = "Bulk Liquid Earthquake Crate"
	desc = "Contains a jug filled with 150u of Liquid Earthquake."
	cost = 500
	contains = list(/obj/item/reagent_containers/glass/chem_jug/liquidearthquake)
	crate_name = "bulk Enduro Grow crate"

/datum/supply_pack/gardening/weedcontrol
	name = "Weed Control Crate"
	desc = "Contains two bottles of weed spray, for when your garden grows out of control."
	cost = 200
	contains = list(
		/obj/item/reagent_containers/spray/weedspray,
		/obj/item/reagent_containers/spray/weedspray
	)

/datum/supply_pack/gardening/pestcontrol
	name = "Pest Control Crate"
	desc = "Contains two bottles of pest spray, for when your garden grows out of control."
	cost = 200
	contains = list(
		/obj/item/reagent_containers/spray/pestspray,
		/obj/item/reagent_containers/spray/pestspray
	)

/* Machinery */

/datum/supply_pack/gardening/tray
	name = "Hydroponics Circuit Crate"
	desc = "One circuitboard for construction of a hydroponics tray. Perfect for busy spacers looking to grow something on their ship."
	cost = 1000
	contains = list(/obj/item/circuitboard/machine/hydroponics)

/datum/supply_pack/gardening/seed_extractor
	name = "Seed Extractor Crate"
	desc = "One circuitboard for construction of a stationary seed extractor. Allows storing and sorting the seeds from plants."
	cost = 1000
	contains = list(/obj/item/circuitboard/machine/seed_extractor)

/datum/supply_pack/gardening/biogenerator
	name = "Biogenerator Crate"
	desc = "One circuitboard for construction of a Biogenerator, an advanced fabricator designed to make biological compounds out of a bio-slurry."
	cost = 3000
	contains = list(/obj/item/circuitboard/machine/biogenerator)
