/datum/supply_pack/machinery
	category = "Industrial Machines & Parts"
	crate_type = /obj/structure/closet/crate/engineering

/*
		Parts
*/

/datum/supply_pack/machinery/lightbulbs
	name = "Replacement Lights"
	desc = "May the light of Aether shine upon this sector! Or at least, the light of fourteen light tubes and seven light bulbs."
	cost = 100
	contains = list(/obj/item/storage/box/lights/mixed)
	crate_name = "replacement lights"
	crate_type = /obj/structure/closet/crate

/datum/supply_pack/machinery/t1
	name = "T1 parts crate"
	desc = "A bundle of basic machine parts, containing 3 of each common part type for when you're too lazy to print them yourself."
	cost = 100
	contains = list(/obj/item/storage/box/stockparts/basic)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate

/datum/supply_pack/machinery/t2
	name = "T2 parts crate"
	desc = "A bundle of advanced machine parts, containing 2 of each common part type."
	cost = 750
	contains = list(/obj/item/storage/box/stockparts/t2)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/science

/datum/supply_pack/machinery/t2_laser
	name = "T2 lasers crate"
	desc = "A bundle of advanced machine lasers, containing 10 parts."
	cost = 750
	contains = list(/obj/item/storage/box/stockparts/t2/laser)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/science

/datum/supply_pack/machinery/t2_matter
	name = "T2 matter bins crate"
	desc = "A bundle of advanced machine parts, containing 10 parts."
	cost = 750
	contains = list(/obj/item/storage/box/stockparts/t2/matter)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/science

/datum/supply_pack/machinery/t2_manipulator
	name = "T2 manipulators crate"
	desc = "A bundle of advanced machine parts, containing 10 parts."
	cost = 750
	contains = list(/obj/item/storage/box/stockparts/t2/manipulator)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/science

/datum/supply_pack/machinery/t2_scan
	name = "T2 scanning modules crate"
	desc = "A bundle of advanced machine parts, containing 10 parts."
	cost = 750
	contains = list(/obj/item/storage/box/stockparts/t2/scan)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/science

/datum/supply_pack/machinery/t2_capacitor
	name = "T2 capacitors crate"
	desc = "A bundle of advanced machine parts, containing 10 parts."
	cost = 750
	contains = list(/obj/item/storage/box/stockparts/t2/capacitor)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/science

/datum/supply_pack/machinery/t3
	name = "T3 parts crate"
	desc = "A bundle of high-tech machine parts, containing 2 of each common part type."
	cost = 1500
	contains = list(/obj/item/storage/box/stockparts/t3)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/machinery/t3_capacitor
	name = "T3 capacitors crate"
	desc = "A bundle of high-tech machine parts, containing 10 parts."
	cost = 1500
	contains = list(/obj/item/storage/box/stockparts/t3/capacitor)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/machinery/t3_scan
	name = "T3 scanning module crate"
	desc = "A bundle of high-tech machine parts, containing 10 parts"
	cost = 1500
	contains = list(/obj/item/storage/box/stockparts/t3/scan)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/machinery/t3_manipulator
	name = "T3 manipulators crate"
	desc = "A bundle of high-tech machine parts, containing 10 parts."
	cost = 1500
	contains = list(/obj/item/storage/box/stockparts/t3/manipulator)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/machinery/t3_laser
	name = "T3 lasers crate"
	desc = "A bundle of high-tech machine parts, containing 10."
	cost = 1500
	contains = list(/obj/item/storage/box/stockparts/t3/laser)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/machinery/t3_matter
	name = "T3 matter bins crate"
	desc = "A bundle of high-tech machine parts, containing 10 parts."
	cost = 1500
	contains = list(/obj/item/storage/box/stockparts/t3/matter)
	crate_name = "\improper stock parts crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/machinery/power
	name = "Power Cell Crate"
	desc = "Looking for power overwhelming? Look no further. Contains one high-voltage power cell."
	cost = 300 //it should be a bit more expensive for a full ship recharge
	contains = list(/obj/item/stock_parts/cell/high)
	crate_name = "power cell crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/*
		Atmospherics
*/

/datum/supply_pack/machinery/space_heater
	name = "Space Heater Crate"
	desc = "Contains a single space heater-cooler, for when things get too cold / hot to handle."
	cost = 500
	contains = list(/obj/machinery/space_heater)
	crate_name = "space heater crate"
	no_bundle = TRUE

/datum/supply_pack/machinery/thermomachine
	name = "Thermomachine Crate"
	desc = "Freeze or heat your air."
	cost = 1000
	contains = list(/obj/item/circuitboard/machine/thermomachine)
	crate_name = "thermomachine crate"
	no_bundle = TRUE

/datum/supply_pack/machinery/portapump
	name = "Portable Air Pump Crate"
	desc = "Want to drain a room of air without losing a drop? We've got you covered. Contains a portable air pump."
	cost = 750
	contains = list(/obj/machinery/portable_atmospherics/pump)
	crate_name = "portable air pump crate"
	no_bundle = TRUE

/datum/supply_pack/machinery/portascrubber
	name = "Portable Scrubber Crate"
	desc = "Clean up that pesky plasma leak with your very own portable scrubber."
	cost = 750
	contains = list(/obj/machinery/portable_atmospherics/scrubber)
	crate_name = "portable scrubber crate"
	no_bundle = TRUE

/datum/supply_pack/machinery/hugescrubber
	name = "Huge Portable Scrubber Crate"
	desc = "A huge portable scrubber for huge atmospherics mistakes."
	cost = 2000
	contains = list(/obj/machinery/portable_atmospherics/scrubber/huge/movable/cargo)
	crate_name = "huge portable scrubber crate"
	crate_type = /obj/structure/closet/crate/large
	no_bundle = TRUE

/*
		Bots
*/

/datum/supply_pack/machinery/mule
	name = "MULEbot Crate"
	desc = "A dilligent MULEbot from the N+S Factories, happy to carry everything you could possibly need, if it's a crate that is." //this description screamed TG. It has been changed.
	cost = 2000
	contains = list(/mob/living/simple_animal/bot/mulebot)
	crate_name = "\improper MULEbot Crate"
	crate_type = /obj/structure/closet/crate/large
	no_bundle = TRUE

/datum/supply_pack/machinery/robotics
	name = "Robotics Assembly Crate"
	desc = "The tools you need to replace those finicky humans with a loyal robot army! Contains four proximity sensors, four robotic arms, two empty first aid kits, two health analyzers, two red hardhats, two mechanical toolboxes, and two cleanbot assemblies!"
	cost = 2500 // maybe underpriced ? unsure
	contains = list(/obj/item/assembly/prox_sensor,
					/obj/item/assembly/prox_sensor,
					/obj/item/assembly/prox_sensor,
					/obj/item/assembly/prox_sensor,
					/obj/item/bodypart/r_arm/robot/surplus,
					/obj/item/bodypart/r_arm/robot/surplus,
					/obj/item/bodypart/r_arm/robot/surplus,
					/obj/item/bodypart/r_arm/robot/surplus,
					/obj/item/storage/firstaid,
					/obj/item/storage/firstaid,
					/obj/item/healthanalyzer,
					/obj/item/healthanalyzer,
					/obj/item/clothing/head/hardhat/red,
					/obj/item/clothing/head/hardhat/red,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/bot_assembly/cleanbot,
					/obj/item/bot_assembly/cleanbot)
	crate_name = "robotics assembly crate"
	crate_type = /obj/structure/closet/crate/science
	no_bundle = TRUE

/*
		Miscellaneous machines
*/

/datum/supply_pack/ship_hardware/wall_shield_gen
	name = "Shield Generator Crate"
	desc = "These two shield wall generators are guaranteed to keep any unwanted lifeforms on the outside, where they belong! Not rated for containing singularities or tesla balls."
	cost = 1000
	contains = list(/obj/machinery/power/shieldwallgen,
					/obj/machinery/power/shieldwallgen)
	crate_name = "shield generators crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	no_bundle = TRUE

/datum/supply_pack/machinery/drill_crate
	name = "Heavy duty laser mining drill"
	desc = "An experimental laser-based mining drill that Nanotrasen is kindly allowing YOU, the customer, to opt into testing of."
	cost = 1000 //Only while TMed, jack up the price before merging
	contains = list(
		/obj/machinery/drill,
		/obj/item/pinpointer/mineral,
		/obj/item/paper/guides/drill
	)
	crate_name = "laser mining drill crate"
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/machinery/ehf_beacon
	name = "EHF point beacon"
	desc = "A crate containing an EHF point beacon, used to mark points of interest and semi-permanent constructions."
	cost = 1000 // This sounds reasonable? You'll still need everything else if you want to make an outpost (Apparently it wasn't, and is cheaper now)
	contains = list(
		/obj/machinery/power/planet_beacon
	)
	crate_name = "point beacon crate"
	crate_type = /obj/structure/closet/crate/engineering

/*
		Power generation machines
*/

/datum/supply_pack/machinery/pacman
	name = "P.A.C.M.A.N Generator Crate"
	desc = "Engineers can't set up the engine? Not an issue for you, once you get your hands on this P.A.C.M.A.N. Generator! Takes in plasma and spits out sweet sweet energy."
	cost = 2500
	contains = list(/obj/machinery/power/port_gen/pacman)
	crate_name = "PACMAN generator crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/machinery/solar
	name = "Solar Panel Crate"
	desc = "Go green with this DIY advanced solar array. Contains twenty one solar assemblies, a solar-control circuit board, and tracker. If you have any questions, please check out the enclosed instruction book."
	cost = 2500
	contains  = list(/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/circuitboard/computer/solar_control,
					/obj/item/electronics/tracker,
					/obj/item/paper/guides/jobs/engi/solars)
	crate_name = "solar panel crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical
	no_bundle = TRUE

/datum/supply_pack/machinery/teg
	name = "Thermoelectric Generator Crate"
	desc = "Turn heat into electricity! Warranty void if sneezed upon."
	cost = 5000
	contains = list(/obj/item/circuitboard/machine/generator,
					/obj/item/circuitboard/machine/circulator,
					/obj/item/circuitboard/machine/circulator)
	crate_name = "thermoelectric generator crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/machinery/turbine
	name = "Turbine Crate"
	desc = "Contains the electronics needed for a turbine generator! Plasma gas not included."
	cost = 4000
	contains = list(/obj/item/circuitboard/machine/power_turbine,
					/obj/item/circuitboard/machine/power_compressor,
					/obj/item/circuitboard/computer/turbine_computer)
	crate_name = "turbine crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/machinery/collector
	name = "Radiation Collector Crate"
	desc = "Contains one radiation collector. Put that radiation to work on something other than your DNA!"
	cost = 1000
	contains = list(/obj/machinery/power/rad_collector)
	crate_name = "collector crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/machinery/tesla_coils
	name = "Tesla Coil Crate"
	desc = "Whether it's high-voltage executions, creating research points, or just plain old power generation, this Tesla coil can do it all!"
	cost = 625
	contains = list(/obj/machinery/power/tesla_coil)
	crate_name = "tesla coil crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/*
		Additional engine machines
*/

/datum/supply_pack/machinery/emitter
	name = "Emitter Crate"
	desc = "Useful for powering forcefield generators while destroying locked crates and intruders alike. Contains one high-powered energy emitter."
	cost = 1500
	contains = list(/obj/machinery/power/emitter)
	crate_name = "emitter crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/machinery/field_gen
	name = "Field Generator Crate"
	desc = "Contains two high-powered field generators, crucial for containing singularities and tesla balls. Must be powered by emitters."
	cost = 2000
	contains = list(/obj/machinery/field/generator,
					/obj/machinery/field/generator)
	crate_name = "field generator crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/machinery/grounding_rods
	name = "Grounding Rod Crate"
	desc = "Contains one grounding rod guaranteed to keep any uppity tesla's lightning under control."
	cost = 450
	contains = list(/obj/machinery/power/grounding_rod)
	crate_name = "grounding rod crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/*
		Engine cores
*/

/datum/supply_pack/machinery/supermatter_shard
	name = "Supermatter Shard Crate"
	desc = "The power of the heavens condensed into a single crystal."
	cost = 10000
	contains = list(/obj/machinery/power/supermatter_crystal/shard)
	crate_name = "supermatter shard crate"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/machinery/smartfridge_board
	name = "Smart Fridge Board"
	desc = "A spacious alternative to the run-of-the-mill fridges that most vessels come pre-equipped with."
	cost = 500
	contains = list(/obj/item/circuitboard/machine/smartfridge)
	crate_name = "smart fridge crate"

/datum/supply_pack/machinery/grinder_board
	name = "All-In-One Grinder Board"
	desc = "Now YOU can find out: Will! It! Blend?!"
	cost = 500
	contains = list(/obj/item/circuitboard/machine/reagentgrinder)
