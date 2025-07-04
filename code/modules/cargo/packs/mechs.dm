/datum/supply_pack/mech
	category = "Exosuit Construction"
	crate_type = /obj/structure/closet/crate/large
	no_bundle = TRUE


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
	name = "202r construction kit"
	desc = "Cybersun Biodynamics' premier solution to on-the-go medical treatment. Some assembly required."
	cost = 5000
	contains = list(
		/obj/item/mecha_parts/chassis/odysseus,
		/obj/item/mecha_parts/part/odysseus_head,
		/obj/item/mecha_parts/part/odysseus_torso,
		/obj/item/mecha_parts/part/odysseus_left_arm,
		/obj/item/mecha_parts/part/odysseus_right_arm,
		/obj/item/mecha_parts/part/odysseus_left_leg,
		/obj/item/mecha_parts/part/odysseus_right_leg,
		/obj/item/circuitboard/mecha/odysseus/peripherals,
		/obj/item/circuitboard/mecha/odysseus/main
		)
	crate_name = "202r Construction Kit"
	faction = /datum/faction/syndicate/cybersun
	faction_discount = 40

/*
Mech Equipment
*/

/datum/supply_pack/mech/equipment
	name = "Exosuit equipment crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	crate_name = "exosuit equipment"

/datum/supply_pack/mech/equipment/drill
	name = "Exosuit drill kit"
	desc = "Contains one mechanized drill for heavy duty digging."
	cost = 500
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/drill
	)

/datum/supply_pack/mech/equipment/diamond_drill
	name = "Exosuit diamond drill kit"
	desc = "Contains mechanized diamond drill, for the enterprising prospector!"
	cost = 750
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill
	)

/datum/supply_pack/mech/equipment/salvage_saw
	name = "Exosuit Salvage Saw"
	desc = "Contains an upsized angle grinder for an Exosuit, for all your larger salvage problems."
	cost = 2000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/salvage_saw
	)

/datum/supply_pack/mech/equipment/scanner
	name = "Exosuit scanner kit"
	desc = "An electronic mining scanner, graded to interface with an exosuit."
	cost = 350
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/mining_scanner
	)

/datum/supply_pack/mech/equipment/plasma_gen
	name = "Exosuit generator kit"
	desc = "A plasma-fueled generator for an exosuit, ideal for long operations."
	cost = 1000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/generator
	)

/datum/supply_pack/mech/equipment/nuclear_gen
	name = "Exosuit nuclear generator kit"
	desc = "Contains a uranium-fueled generator for an exosuit, ideal for polluting the environment."
	cost = 1250
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/generator/nuclear
	)

/datum/supply_pack/mech/equipment/tesla_energy_relay
	name = "Exosuit tesla relay kit"
	desc = "Contains an advanced exosuit module which draws power from nearby APCs."
	cost = 1750
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/tesla_energy_relay
	)

/datum/supply_pack/mech/equipment/clamp
	name = "Exosuit clamp kit"
	desc = "Contains a clamp designed for mechanized freight hauling."
	cost = 350
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp
	)

/datum/supply_pack/mech/equipment/extinguisher
	name = "Exosuit extinguisher kit"
	desc = "Contains a heavy duty fire extinguisher, for heavy duty firefighting."
	cost = 250
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/extinguisher
	)

/datum/supply_pack/mech/equipment/cable_layer
	name = "Exosuit RCL Kit"
	desc = "Contains a \"rapid cable layer\" for laying down long lengths of wire."
	cost = 250
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/cable_layer
	)

/datum/supply_pack/mech/equipment/mech_sleeper
	name = "Exosuit Mounted Sleeper Kit"
	desc = "Contains a mounted sleeper device, used for retrieving and stabilizing patients."
	cost = 1000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/medical/sleeper
	)

/datum/supply_pack/mech/equipment/beam_gun
	name = "Exosuit Beam Gun Kit"
	desc = "Contains an advanced mounted medical beamgun, capable of alleviating wounds to targets."
	cost = 7000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam
	)
/datum/supply_pack/mech/equipment/rcs
	name = "Exosuit RCS kit"
	desc = "A gas fueled RCS pack, ideal for mechanized space operation."
	cost = 800
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/thrusters/gas
	)

/datum/supply_pack/mech/equipment/ionthrust
	name = "Exosuit Ion thruster kit"
	desc = "An electrical powered thruster pack, perfect for exosuits without a functional way to refill more tradional RCS thrusters."
	cost = 2000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/thrusters/ion
	)

/datum/supply_pack/mech/equipment/ripley_upgrade
	name = "APLU upgrade kit"
	desc = "Contains an APLU MK II upgrade kit. The upgrade will replace the cockpit with a spaceworthy canopy, but the added weight makes it slower."
	cost = 500
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/conversion_kit/ripley
	)

/datum/supply_pack/mech/equipment/ripley_upgrade/clip
	name = "CLIP Ripley MK-IV upgrade kit"
	desc = "Contains a CLIP-custom APLU MK-IV upgrade kit. The upgrade will replace the cockpit with a lightweight spaceworthy canopy, and parts to overclock the leg servos. Maintains the speed of the MK-1, but consumes more power."
	cost = 500
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/conversion_kit/ripley/clip
	)
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/mech/equipment/paladin_upgrade
	name = "CLIP Durand Paladin upgrade kit"
	desc = "Contains a CLIP-custom conversion kit for a Durand combat exosuit, to convert it to the specialized Paladin anti-xenofauna exosuit. Features an electrical replusion field that repels any melee attacks, but loses the ability to defend against ranged projectiles."
	cost = 500
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/conversion_kit/paladin
	)
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/mech/equipment/basenji_upgrade
	name = "IRMG Basenji upgrade kit"
	desc = "Contains an IRMG-custom conversion kit for a 501p combat exosuit, to convert it to the specialized Basenji breaching exosuit. The upgrade will overclock the Gygax's leg actuators, allowing for short ranged charges capable of smashing through most obstacles."
	cost = 500
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/conversion_kit/inteq_gygax
	)
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/mech/equipment/charger_upgrade
	name = "501p overclock kit"
	desc = "Contains a kit to overclock the 501p, allowing it to leap forward instead of its enhanced speed."
	cost = 1000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/conversion_kit/leaper
	)

/datum/supply_pack/mech/equipment/dark_upgrade
	name = "515 EX upgrade kit"
	desc = "Contains a military grade conversion kit for a 501p combat exosuit, to convert it to the fearsome 515 EX models. Features a much stronger set of leg actuators."
	cost = 500
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/conversion_kit/dark_gygax
	)
	faction = /datum/faction/syndicate
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/mech/equipment/melee_armor_booster
	name = "Exosuit CCW armor kit"
	desc = "A \"close combat weaponry\" module designed to deflect melee attacks."
	cost = 750
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/anticcw_armor_booster
	)

/datum/supply_pack/mech/equipment/projectile_armor_booster
	name = "Exosuit projectile armor kit"
	desc = "A protective exosuit module designed to deflect ranged attacks."
	cost = 1000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster
	)

/datum/supply_pack/mech/equipment/recharger
	name = "Exosuit Recharger kit"
	desc = "Two boards for an exosuit recharger and recharger console. For the stylish exosuit bay."
	cost = 400
	contains = list(
		/obj/item/circuitboard/computer/mech_bay_power_console,
		/obj/item/circuitboard/machine/mech_recharger
	)

/*
weapons
*/

/datum/supply_pack/mech/weapon
	name = "Exosuit weapons crate"
	crate_type = /obj/structure/closet/crate/secure/weapon
	crate_name = "exosuit weapon crate"

/datum/supply_pack/mech/weapon/pka
	name = "Exosuit-Mounted Proto-Kinetic Accelerator kit"
	desc = "A ranged mining attachment for any exosuit."
	cost = 750
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/mecha_kineticgun
	)

/*/datum/supply_pack/mech/weapon/carbine
	name = "Downpour kit"
	desc = "A rapid fire energy carbine designed for combat usage."
	cost = 1000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/carbine
	)

/datum/supply_pack/mech/weapon/biglaser
	name = "Solaris kit"
	desc = "A heavy beam sniper cannon designed for combat usage."
	cost = 2000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser
	)*/

/datum/supply_pack/mech/weapon/ion_cannon
	name = "MK4 ion cannon kit"
	desc = "Contains a heavy ion cannon for disabling technology in large blasts."
	cost = 3000
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/energy/ion
	)

/datum/supply_pack/mech/weapon/scattershot
	name = "LBX-10 kit"
	desc = "Contains a \"Scattershot\" gun to mount on combat exosuits."
	cost = 1750
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot
	)

/datum/supply_pack/mech/weapon/lmg
	name = "UMG-2 kit"
	desc = "Contains a fully automatic mounted machine gun for combat exosuits."
	cost = 2250
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg
	)

/datum/supply_pack/mech/weapon/railgun
	name = "PR-05 kit"
	desc = "Contains a plasma railgun to mount on combat exosuits. Be sure to not overcharge it."
	cost = 2700
	contains = list(
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/railgun
	)
	faction = /datum/faction/nt
	faction_discount = 20

/*
ammo
*/

/datum/supply_pack/mech/ammo
	name = "Exosuit ammo crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	crate_name = "exosuit ammo crate"

/datum/supply_pack/mech/ammo/scattershot_ammo
	name = "LBX-10 ammo box"
	desc = "Contains a twenty four round box of upscaled buckshot, to be loaded directly in a mounted LBX-10."
	cost = 750 //24*8*24 = 1536 total damage assuming all rounds connect
	contains = list(
		/obj/item/mecha_ammo/scattershot
	)

/datum/supply_pack/mech/ammo/lmg_ammo
	name = "UMG-2 ammo box"
	desc = "Contains a two hundred-round box of heavy ammunition for the UMG-2."
	cost = 2500 //200*25 = 5000 damage if all rounds connect
	contains = list(
		/obj/item/mecha_ammo/lmg
	)

/datum/supply_pack/mech/ammo/railgun_ammo
	name = "Railgun ammo box"
	desc = "A box containing thirty iron-tungsten rods for the PR-05 Plasma Railgun."
	cost = 900 //60 * 30 = 1800 damage if all rounds connect
	contains = list(
		/obj/item/mecha_ammo/railgun_ammo
	)
	faction = /datum/faction/nt
	faction_discount = 20

