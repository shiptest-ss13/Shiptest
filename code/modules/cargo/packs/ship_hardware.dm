/datum/supply_pack/ship_hardware
	category = "Ship Hardware"
	crate_type = /obj/structure/closet/crate/engineering

/*
		Miscellaneous
*/

/datum/supply_pack/ship_hardware/gravgen
	name = "Ship-Portable Gravity Generator Crate"
	desc = "For those tired of their tools floating away from them. Contains a single gravity generator."
	cost = 2000
	contains = list(/obj/machinery/power/ship_gravity/unanchored)
	crate_name = "gravity generator crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical
	no_bundle = TRUE

/datum/supply_pack/ship_hardware/breach_shield_gen
	name = "Anti-breach Shield Projector Crate"
	desc = "Hull breaches again? Say no more with the Nanotrasen Anti-Breach Shield Projector! Uses forcefield technology to keep the air in, and the space out. Contains one shield projector."
	cost = 1250
	contains = list(/obj/machinery/shieldgen)
	crate_name = "anti-breach shield projector crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	no_bundle = TRUE

/datum/supply_pack/ship_hardware/holofield_generator
	name = "Holofield Generator Crate"
	desc = "Contains the electronics you need to set up a new (or replacement) holofield! Buttons not included."
	cost = 1000
	contains = list(/obj/item/circuitboard/machine/shieldwallgen/atmos,
					/obj/item/circuitboard/machine/shieldwallgen/atmos)
	crate_name = "holofield generator crate"
	crate_type = /obj/structure/closet/crate/engineering

/*
		Thrusters
*/

/datum/supply_pack/ship_hardware/ion_thruster
	name = "Ion Thruster Crate"
	desc = "A crate containing an ion thruster and its precharger's electronics. For when you need a little extra thrust."
	cost = 1500
	contains = list(/obj/item/circuitboard/machine/shuttle/smes,
					/obj/item/circuitboard/machine/shuttle/engine/electric)
	crate_name = "ion thruster crate"
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/ship_hardware/plasma_thruster
	name = "Plasma Thruster Crate"
	desc = "A crate containing a plasma thruster and its heater's electronics. For when you need a lot of extra thrust."
	cost = 1500
	contains = list(/obj/item/circuitboard/machine/shuttle/heater,
					/obj/item/circuitboard/machine/shuttle/engine/plasma)
	crate_name = "plasma thruster crate"
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/ship_hardware/combustion_thruster
	name = "Combustion Thruster Crate"
	desc = "A crate containing a combustion thruster and its heater's electronics. For when you need complicated thrust."
	cost = 2000
	contains = list(/obj/item/circuitboard/machine/shuttle/fire_heater,
					/obj/item/circuitboard/machine/shuttle/engine/fire)
	crate_name = "combustion thruster crate"
	crate_type = /obj/structure/closet/crate/engineering

/*
		Military hardware
*/

/datum/supply_pack/ship_hardware/cloaking_device
	name = "Ship Cloaking System"
	desc = "A crate containing a cloaking system for hiding a ship from long-range scanners. Very high power consumption."
	cost = 10000
	contains = list(/obj/item/circuitboard/machine/cloak)
	crate_name = "cloaking system crate"
	crate_type = /obj/structure/closet/crate/engineering
	faction = /datum/faction/syndicate/hardliners
	faction_discount = 0.3

/datum/supply_pack/ship_hardware/advanced_cloaking_device
	name = "BFRD-3A Advanced Cloaking System"
	desc = "A crate containing an advanced cloaking system capable of partially shifting an entire ship into bluespace."
	cost = 6000
	contains = list(/obj/item/circuitboard/machine/cloak)
	crate_name = "advanced cloaking system crate"
	crate_type = /obj/structure/closet/crate/engineering
	// currently unobtainable until someone adds a ship for zohil
	faction = /datum/faction/zohil
	faction_locked = TRUE
