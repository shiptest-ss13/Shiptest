/datum/supply_pack/silicon
	category = "Silicon Modules"
	crate_type = /obj/structure/closet/crate/science

/*
		Cyborg Kit
*/

/datum/supply_pack/silicon/borg
	name = "Silicon Construction Kit"
	desc = "Contains disassembled Silicon chassis within, with nearly all parts included! Cables not included."
	cost = 1250
	contains = list(/obj/item/robot_suit,
					/obj/item/bodypart/head/robot,
					/obj/item/bodypart/chest/robot,
					/obj/item/bodypart/l_arm/robot,
					/obj/item/bodypart/leg/left/robot,
					/obj/item/bodypart/r_arm/robot,
					/obj/item/bodypart/leg/right/robot,
					/obj/item/assembly/flash/handheld,
					/obj/item/assembly/flash/handheld,
					/obj/item/stock_parts/cell/super)
	crate_name = "Cyborg Construction Kit"

/datum/supply_pack/silicon/mmi
	name = "Man-Machine Interface"
	desc = "For those dabbling into the prospects of immortality."
	cost = 500
	contains = list(/obj/item/mmi)

/datum/supply_pack/silicon/boris
	name = "B.O.R.I.S. Module"
	desc = "Perfect for use by Silicon intelligence who desire a \"On-hands\" experience."
	cost = 250
	contains = list(/obj/item/borg/upgrade/ai)

/*
		Cyborg Upgrades
*/

datum/supply_pack/silicon/cirapp
	name = "Circuit Manipulation Apparatus"
	desc = "Contains a CMA, commonly used to not babysit your Silicon Intelligence Engineer borgs."
	cost = 500
	contains = list(/obj/item/borg/upgrade/circuit_app)

datum/supply_pack/silicon/rped
	name = "Cyborg RPED"
	desc = "An upgrade chip for Engineer borgs that allows for rapid installation of machine parts to machines!"
	cost = 750
	contains = list(/obj/item/borg/upgrade/rped)

datum/supply_pack/silicon/beaker
	name = "Beaker Storage Apparatus"
	desc = "A apparatus for Medical borgs that allows them to store beakers within an internal storage."
	cost = 350
	contains = list(/obj/item/borg/upgrade/beaker_app)

datum/supply_pack/silicon/pierce
	name = "Piercing Hypospray Chip"
	desc = "An upgrade chip for Medical borgs allowing their onboard hyposprays to pierce the thick plating of hardsuits."
	cost = 500
	contains = list(/obj/item/borg/upgrade/piercing_hypospray)

datum/supply_pack/silicon/pinpoint
	name = "Cyborg Pinpointer"
	desc = "A onboard pinpointer, built for use in Medical borgs in locating deceased."
	cost = 250
	contains = list(/obj/item/borg/upgrade/pinpointer)

datum/supply_pack/silicon/ddrill
	name = "Cyborg Diamond Drill"
	desc = "A upgrade for the typical borg drill, plating it with diamonds allowing it to handle much tougher rocks."
	cost = 500
	contains = list(/obj/item/borg/upgrade/ddrill)

datum/supply_pack/silicon/lavaproof
	name = "Lavaproof Cyborg Treads"
	desc = "Brand new lavaproof treads, allowing for the traverse of desginated Mining borgs access across vast pools of lava."
	cost = 850
	contains = list(/obj/item/borg/upgrade/lavaproof)

datum/supply_pack/silicon/selfrep
	name = "Self-Repair Cyborg Module"
	desc = "Whilst heavily energy inefficient, you can rest easy knowing your borgs are able to return safely, even with a few new dents."
	cost = 500
	contains = list(/obj/item/borg/upgrade/selfrepair)

datum/supply_pack/silicon/ionthrust
	name = "Cyborg Ion Thrusters"
	desc = "Improvements made to the borg chassis with the installation of this chip, will allow 360 degree movement into gravity deficient areas."
	cost = 850
	contains = list(/obj/item/borg/upgrade/thrusters)
