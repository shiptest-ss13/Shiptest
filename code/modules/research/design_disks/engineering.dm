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

/obj/item/disk/design_disk/engineering/Initialize() //wip- not sure what else to put here
	. = ..()
	blueprints[1] = new /datum/design/inducer

/obj/item/disk/design_disk/engineering/t1parts //these might not be in autolathes in the future by default. watch out!
	name = "design disk - Stock Parts"
	desc = "A design disk containing designs for basic stock parts."
	max_blueprints = 7

/obj/item/disk/design_disk/engineering/t1parts/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/RPED
	blueprints[2] = new /datum/design/high_cell
	blueprints[3] = new /datum/design/basic_capacitor
	blueprints[4] = new /datum/design/basic_scanning
	blueprints[5] = new /datum/design/micro_mani
	blueprints[6] = new /datum/design/basic_micro_laser
	blueprints[7] = new /datum/design/basic_matter_bin

/obj/item/disk/design_disk/engineering/t2parts
	name = "design disk - Upgraded Stock Parts"
	desc = "A design disk containing designs for upgraded stock parts."
	max_blueprints = 7

/obj/item/disk/design_disk/engineering/t2parts/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/RPED
	blueprints[2] = new /datum/design/super_cell
	blueprints[3] = new /datum/design/adv_capacitor
	blueprints[4] = new /datum/design/adv_scanning
	blueprints[5] = new /datum/design/nano_mani
	blueprints[6] = new /datum/design/high_micro_laser
	blueprints[7] = new /datum/design/adv_matter_bin

/obj/item/disk/design_disk/engineering/t3parts
	name = "design disk - Advanced Stock Parts"
	desc = "A design disk containing designs for advanced stock parts."
	max_blueprints = 7

/obj/item/disk/design_disk/engineering/t3parts/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/RPED
	blueprints[2] = new /datum/design/hyper_cell
	blueprints[3] = new /datum/design/super_capacitor
	blueprints[4] = new /datum/design/phasic_scanning
	blueprints[5] = new /datum/design/pico_mani
	blueprints[6] = new /datum/design/ultra_micro_laser
	blueprints[7] = new /datum/design/super_matter_bin

/obj/item/disk/design_disk/engineering/t4parts
	name = "design disk - Bluespace Stock Parts"
	desc = "A design disk containing designs for bluespace stock parts."
	max_blueprints = 7

/obj/item/disk/design_disk/engineering/t4parts/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/RPED
	blueprints[2] = new /datum/design/bluespace_cell
	blueprints[3] = new /datum/design/quadratic_capacitor
	blueprints[4] = new /datum/design/triphasic_scanning
	blueprints[5] = new /datum/design/femto_mani
	blueprints[6] = new /datum/design/quadultra_micro_laser
	blueprints[7] = new /datum/design/bluespace_matter_bin

// TELECOMMUNICATION PARTS

/obj/item/disk/design_disk/engineering/telecomms
	name = "design disk - Telecommunications Parts"
	desc = "A design disk containing designs for telecommunications parts."
	max_blueprints = 7

/obj/item/disk/design_disk/engineering/telecomms/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/hyperwave_filter
	blueprints[2] = new /datum/design/subspace_amplifier
	blueprints[3] = new /datum/design/subspace_treatment
	blueprints[4] = new /datum/design/subspace_analyzer
	blueprints[5] = new /datum/design/subspace_crystal
	blueprints[6] = new /datum/design/subspace_transmitter

/obj/item/disk/design_disk/engineering/telecommsboards
	name = "design disk - Telecommunications Circuits"
	desc = "A design disk containing designs for telecommunications circuit boards."
	max_blueprints = 7

/obj/item/disk/design_disk/engineering/telecomms/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/board/subspace_receiver
	blueprints[2] = new /datum/design/board/subspace_broadcaster
	blueprints[3] = new /datum/design/board/telecomms_bus
	blueprints[4] = new /datum/design/board/telecomms_relay
	blueprints[5] = new /datum/design/board/telecomms_processor
	blueprints[6] = new /datum/design/board/telecomms_server
	blueprints[7] = new /datum/design/board/telecomms_hub
	blueprints[8] = new /datum/design/board/subspace_broadcaster

// HIGH TECH / RARE ENGINEERING ITEMS

/obj/item/disk/design_disk/limited/advtools
	name = "design disk - Advanced Tools"
	desc = "A design disk containing Advanced Tools designs with limited prints."
	color = "#eece17"
	illustration = "hammer"
	max_blueprints = 3
	max_charges = 1 //Essentially to be used as loot - choose a tool.

/obj/item/disk/design_disk/engineering/t4parts/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/jawsoflife
	blueprints[2] = new /datum/design/exwelder
	blueprints[3] = new /datum/design/handdrill
