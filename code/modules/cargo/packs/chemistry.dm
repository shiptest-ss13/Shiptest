/datum/supply_pack/chemistry
	group = "Chemistry"
	crate_type = /obj/structure/closet/crate/chem

/*
		Tools
*/

/datum/supply_pack/chemistry/starter
	name = "Chemical Starter Kit Crate"
	desc = "Contains thirteen different chemicals, for all the fun experiments you can make."
	cost = 1250 // This is intentionally underpriced; the hope is that people will start using ghettochem, upon which time the price can be raised.
	contains = list(/obj/item/reagent_containers/glass/bottle/aluminium,
					/obj/item/reagent_containers/glass/bottle/bromine,
					/obj/item/reagent_containers/glass/bottle/carbon,
					/obj/item/reagent_containers/glass/bottle/chlorine,
					/obj/item/reagent_containers/glass/bottle/copper,
					/obj/item/reagent_containers/glass/bottle/ethanol,
					/obj/item/reagent_containers/glass/bottle/fluorine,
					/obj/item/reagent_containers/glass/bottle/hydrogen,
					/obj/item/reagent_containers/glass/bottle/iodine,
					/obj/item/reagent_containers/glass/bottle/lithium,
					/obj/item/reagent_containers/glass/bottle/mercury,
					/obj/item/reagent_containers/glass/bottle/nitrogen,
					/obj/item/reagent_containers/glass/bottle/oxygen,
					/obj/item/reagent_containers/glass/bottle/phosphorus,
					/obj/item/reagent_containers/glass/bottle/potassium,
					/obj/item/reagent_containers/glass/bottle/radium,
					/obj/item/reagent_containers/glass/bottle/sugar,
					/obj/item/reagent_containers/glass/bottle/sodium,
					/obj/item/reagent_containers/glass/bottle/sulfur,
					/obj/item/reagent_containers/glass/bottle/silicon,
					/obj/item/reagent_scanner,
					/obj/item/reagent_containers/dropper,
					/obj/item/storage/box/beakers)
	crate_name = "chemical starter crate"

/datum/supply_pack/chemistry/tools
	name = "Chemical Synthesis Crate"
	desc = "Contains all the tools you will need for drug making."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/filter,
					/obj/item/book/manual/wiki/chemistry,
					/obj/item/clothing/glasses/science,
					/obj/item/hand_labeler,
					/obj/item/stock_parts/capacitor,
					/obj/item/stock_parts/scanning_module,
					/obj/item/stock_parts/manipulator,
					/obj/item/stock_parts/micro_laser)
	crate_name = "chemistry tools crate"

/datum/supply_pack/chemistry/press
	name = "Pill Press Crate"
	desc = "Contains one standard press for making pills by hand."
	cost = 500
	contains = list(/obj/machinery/chem_press)
	crate_name = "pill press crate"

/*
		Bulk materials
*/

/datum/supply_pack/chemistry/aluminium
	name = "Bulk Aluminium Crate"
	desc = "Contains a jug filled with 150u of aluminium."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/aluminium)
	crate_name = "bulk aluminium crate"

/datum/supply_pack/chemistry/bromine
	name = "Bulk Bromine Crate"
	desc = "Contains a jug filled with 150u of bromine."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/bromine)
	crate_name = "bulk bromine crate"

/datum/supply_pack/chemistry/carbon
	name = "Bulk Carbon Crate"
	desc = "Contains a jug filled with 150u of carbon."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/carbon)
	crate_name = "bulk carbon crate"

/datum/supply_pack/chemistry/chlorine
	name = "Bulk Chlorine Crate"
	desc = "Contains a jug filled with 150u of chlorine."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/chlorine)
	crate_name = "bulk chlorine crate"

/datum/supply_pack/chemistry/copper
	name = "Bulk Copper Crate"
	desc = "Contains a jug filled with 150u of copper."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/copper)
	crate_name = "bulk copper crate"

/datum/supply_pack/chemistry/fluorine
	name = "Bulk Fluorine Crate"
	desc = "Contains a jug filled with 150u of fluorine."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/fluorine)
	crate_name = "bulk fluorine crate"

/datum/supply_pack/chemistry/hydrogen
	name = "Bulk Hydrogen Crate"
	desc = "Contains a jug filled with 150u of Hydrogen."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/hydrogen)
	crate_name = "bulk hydrogen crate"

/datum/supply_pack/chemistry/iodine
	name = "Bulk Iodine Crate"
	desc = "Contains a jug filled with 150u of iodine."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/iodine)
	crate_name = "bulk iodine crate"

/datum/supply_pack/chemistry/lithium
	name = "Bulk Lithium Crate"
	desc = "Contains a jug filled with 150u of lithium."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/lithium)
	crate_name = "bulk lithium crate"

/datum/supply_pack/chemistry/mercury
	name = "Bulk Mercury Crate"
	desc = "Contains a jug filled with 150u of mercury."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/mercury)
	crate_name = "bulk mercury crate"

/datum/supply_pack/chemistry/nitrogen
	name = "Bulk Nitrogen Crate"
	desc = "Contains a jug filled with 150u of nitrogen."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/nitrogen)
	crate_name = "bulk nitrogen crate"

/datum/supply_pack/chemistry/oxygen
	name = "Bulk Oxygen Crate"
	desc = "Contains a jug filled with 150u of oxygen."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/oxygen)
	crate_name = "bulk oxygen crate"

/datum/supply_pack/chemistry/phosphorus
	name = "Bulk Phosphorus Crate"
	desc = "Contains a jug filled with 150u of phosphorus."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/phosphorus)
	crate_name = "bulk phosphorus crate"

/datum/supply_pack/chemistry/potassium
	name = "Bulk Potassium Crate"
	desc = "Contains a jug filled with 150u of potassium."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/potassium)
	crate_name = "bulk potassium crate"

/datum/supply_pack/chemistry/radium
	name = "Bulk Radium Crate"
	desc = "Contains a jug filled with 150u of radium."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/radium)
	crate_name = "bulk radium crate"

/datum/supply_pack/chemistry/sodium
	name = "Bulk Sodium Crate"
	desc = "Contains a jug filled with 150u of sodium."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/sodium)
	crate_name = "bulk sodium crate"

/datum/supply_pack/chemistry/sulfur
	name = "Bulk Sulfur Crate"
	desc = "Contains a jug filled with 150u of sulfur."
	cost = 750
	contains = list(/obj/item/reagent_containers/glass/chem_jug/sulfur)
	crate_name = "bulk sulfur crate"
