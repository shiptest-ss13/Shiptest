/*
	This file contains disks with engineering designs.
*/

// ENGINEERING EQUIPMENT / PARTS

/obj/item/disk/design_disk/engineering/ //Engineering parent type
	name = "design disk - Engineering"
	desc = "A design disk containing engineering equipment."
	color = "#eece17"
	illustration = "hammer"
	max_blueprints = 1
	starting_blueprints = list(//wip- not sure what else to put here
		/datum/design/inducer
	)

/obj/item/disk/design_disk/engineering/t1parts //these might not be in autolathes in the future by default. watch out!
	name = "design disk - Stock Parts"
	desc = "A design disk containing designs for basic stock parts."
	max_blueprints = 7
	starting_blueprints = list(
		/datum/design/RPED,
		/datum/design/high_cell,
		/datum/design/basic_capacitor,
		/datum/design/basic_scanning,
		/datum/design/micro_mani,
		/datum/design/basic_micro_laser,
		/datum/design/basic_matter_bin
	)

/obj/item/disk/design_disk/engineering/t2parts
	name = "design disk - Upgraded Stock Parts"
	desc = "A design disk containing designs for upgraded stock parts."
	max_blueprints = 7
	starting_blueprints = list(
		/datum/design/RPED,
		/datum/design/super_cell,
		/datum/design/adv_capacitor,
		/datum/design/adv_scanning,
		/datum/design/nano_mani,
		/datum/design/high_micro_laser,
		/datum/design/adv_matter_bin,
	)

/obj/item/disk/design_disk/engineering/t3parts
	name = "design disk - Advanced Stock Parts"
	desc = "A design disk containing designs for advanced stock parts."
	max_blueprints = 7
	starting_blueprints = list(
		/datum/design/RPED,
		/datum/design/hyper_cell,
		/datum/design/super_capacitor,
		/datum/design/phasic_scanning,
		/datum/design/pico_mani,
		/datum/design/ultra_micro_laser,
		/datum/design/super_matter_bin,
	)

/obj/item/disk/design_disk/engineering/t4parts
	name = "design disk - Bluespace Stock Parts"
	desc = "A design disk containing designs for bluespace stock parts."
	max_blueprints = 7
	starting_blueprints = list(
		/datum/design/RPED,
		/datum/design/bluespace_cell,
		/datum/design/quadratic_capacitor,
		/datum/design/triphasic_scanning,
		/datum/design/femto_mani,
		/datum/design/quadultra_micro_laser,
		/datum/design/bluespace_matter_bin,
	)

// TELECOMMUNICATION PARTS
/obj/item/disk/design_disk/engineering/telecomms
	name = "design disk - Telecommunications Parts"
	desc = "A design disk containing designs for telecommunications parts."
	max_blueprints = 7
	starting_blueprints = list(
		/datum/design/hyperwave_filter,
		/datum/design/subspace_amplifier,
		/datum/design/subspace_treatment,
		/datum/design/subspace_analyzer,
		/datum/design/subspace_crystal,
		/datum/design/subspace_transmitter,
	)

// LIMITED USE DISKS PAST HERE

// HIGH TECH / RARE ENGINEERING ITEMS

/obj/item/disk/design_disk/limited/advtools
	name = "design disk - Advanced Tools"
	desc = "A design disk containing Advanced Tools designs with limited prints."
	color = "#eece17"
	illustration = "hammer"
	max_blueprints = 3
	max_charges = 1 //Essentially to be used as loot - choose a tool.
	starting_blueprints = list(
		/datum/design/jawsoflife,
		/datum/design/handdrill,
	) //datum/design/exwelder
