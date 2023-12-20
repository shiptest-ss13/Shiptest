/datum/supply_pack/mech
	group = "Mech and Exosuit Construction"
	crate_type = /obj/structure/closet/crate/large


/*
Completed Suits
*/

/datum/supply_pack/mech/ripley
	name = "Surplus APLU MK-I"
	desc = "A worn cargo loader that has aged out of active use. Comes with an attachable drill."
	cost = 2000
	contains = list(
		/obj/mecha/working/ripley/cargo,
	)
	crate_name= "APLU MK-I crate"

/*
Build Your Own Suit
*/

/datum/supply_pack/mech/ripley_parts
	name = "APLU construction kit"
	desc = "All the chassis components you would need to make a Ripley MK-I Powerloader"
	cost = 3000
	contains = list(
		/obj/item/mecha_parts/chassis/ripley,
		/obj/item/mecha_parts/part/ripley_torso,
		/obj/item/mecha_parts/part/ripley_left_arm,
		/obj/item/mecha_parts/part/ripley_right_arm,
		/obj/item/mecha_parts/part/ripley_left_leg,
		/obj/item/mecha_parts/part/ripley_right_leg,
		/obj/item/circuitboard/mecha/ripley/peripherals,
		/obj/item/circuitboard/mecha/ripley/main
		)
	crate_name = "APLU construction kit"

/datum/supply_pack/mech/odysseus_parts
	name = "Odysseus construction kit"
	desc = "DeForest Medical's premier solution to on the go medical treatment. Some assembly required."
	cost = 5000
	contains = list(
		/obj/item/mecha_parts/chassis/odysseus,
		/obj/item/mecha_parts/part/odysseus_head,
		/obj/item/mecha_parts/part/odysseus_torso,
		/obj/item/mecha_parts/part/odysseus_left_arm,
		/obj/item/mecha_parts/part/odysseus_left_arm,
		/obj/item/mecha_parts/part/odysseus_right_arm,
		/obj/item/mecha_parts/part/odysseus_left_leg,
		/obj/item/mecha_parts/part/odysseus_right_leg,
		/obj/item/circuitboard/mecha/odysseus/peripherals,
		/obj/item/circuitboard/mecha/odysseus/main
		)
	crate_name = "Odysseus Construction Kit"

/datum/supply_pack/mech/gygax_parts
	name = "Gygax construction kit"
	desc = "An agile exosuit made famous by Nanotrasen security personnel during the ICW. Or at least the parts to it."
	cost = 12000
	contains = list(
		/obj/item/mecha_parts/chassis/gygax,
		/obj/item/mecha_parts/part/gygax_head,
		/obj/item/mecha_parts/part/gygax_torso,
		/obj/item/mecha_parts/part/gygax_left_arm,
		/obj/item/mecha_parts/part/gygax_right_arm,
		/obj/item/mecha_parts/part/gygax_left_leg,
		/obj/item/mecha_parts/part/gygax_right_leg,
		/obj/item/mecha_parts/part/gygax_armor,
		/obj/item/circuitboard/mecha/gygax/peripherals,
		/obj/item/circuitboard/mecha/gygax/main,
		/obj/item/circuitboard/mecha/gygax/targeting
	)
	crate_name = "Gygax Construction Kit"

/datum/supply_pack/mech/durand_parts
	name = "Durand construction kit"
	desc = "The kit to a bulky suit most frequently used by the Colonial Minutemen, older models tend to find themselves disassembled and sold off."
	cost = 15000
	contains = list(
		/obj/item/mecha_parts/chassis/durand,
		/obj/item/mecha_parts/part/durand_head,
		/obj/item/mecha_parts/part/durand_torso,
		/obj/item/mecha_parts/part/durand_left_arm,
		/obj/item/mecha_parts/part/durand_right_arm,
		/obj/item/mecha_parts/part/durand_left_leg,
		/obj/item/mecha_parts/part/durand_right_leg,
		/obj/item/mecha_parts/part/durand_armor,
		/obj/item/circuitboard/mecha/durand/peripherals,
		/obj/item/circuitboard/mecha/durand/main,
		/obj/item/circuitboard/mecha/durand/targeting
	)
	crate_name = "Durand Construction Kit"

/*
Mech Equipment
*/

/datum/supply_pack/mech/equipment
	name = "Mech equipment crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	crate_name = "mech equipment"

/datum/supply_pack/mech/equipment/drill
	name = "Mech drill kit"
	desc = "A trio of mechanized drills"
	cost = 1500
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/drill,
		/obj/item/mecha_parts/mecha_equipment/drill,
		/obj/item/mecha_parts/mecha_equipment/drill
	)

/datum/supply_pack/mech/equipment/scanners
	name = "Mech scanner kit"
	desc = "A trio of electronic mining scanners, graded to interface with a mech"
	cost = 1000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/mining_scanner,
		/obj/item/mecha_parts/mecha_equipment/mining_scanner,
		/obj/item/mecha_parts/mecha_equipment/mining_scanner
	)

/datum/supply_pack/mech/equipment/plasma_gen
	name = "Mech generator kit"
	desc = "A plasma-fueled generator for a mech, ideal for long operations."
	cost = 1000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/generator
	)

/datum/supply_pack/mech/equipment/clamp
	name = "Mech clamp kit"
	desc = "Two clamps designed for mechanized freight hauling."
	cost = 700
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp,
		/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp
	)

/datum/supply_pack/mech/equipment/rcs
	name = "Mech RCS kit"
	desc = "A gas fueled RCS pack, ideal for mechanized space operation."
	cost = 800
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/thrusters/gas
	)

/datum/supply_pack/mech/equipment/ripley_upgrade
	name = "APLU upgrade kit"
	desc = "The components needed to upgrade an APLU MK-I to be spaceworthy"
	cost = 1500
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/conversion_kit/ripley
	)

/*
weapons
*/

/datum/supply_pack/mech/equipment/pka
	name = "Proto-Kinetic Accelerator kit"
	desc = "A ranged mining attachment for any mech."
	cost = 1500
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun
	)

/datum/supply_pack/mech/equipment/laser
	name = "Immolator kit"
	desc = "A light laser cannon designed for combat usage."
	cost = 1000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser
	)

/datum/supply_pack/mech/equipment/laser
	name = "Solaris kit"
	desc = "A heavy laser cannon designed for combat usage."
	cost = 2000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy
	)
