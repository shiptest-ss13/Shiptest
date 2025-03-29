/*
	This file contains disks with various firearms,
	as well as ammunition.
*/

// AMMUNITION

/obj/item/disk/design_disk/ammunition // Do not modify this subtype.
	name = "Ammunition Design Disk"
	desc = "An ammunition disk"
	illustration = "target"
	max_blueprints = 1 //Default for firearms disks is 1.
	max_charges = 5 //Default for limited firearms disk is 5.

// MAGAZINES

/obj/item/disk/design_disk/ammunition/mag_1911
	name = "design disk - Candor magazine"
	desc = "A design disk containing the pattern for the classic Candor's 8 round .45ACP magazine."
	illustration = "ammo"
	starting_blueprints = list(/datum/design/candor_magazine)

// ROUNDS

/obj/item/disk/design_disk/ammunition/ammo_c9mm
	design_name = "9mm Ammo"
	desc = "A design disk containing the pattern for a refill box of standard 9mm ammo, used in Commander pistols."
	starting_blueprints = list(/datum/design/c9mmautolathe)

// LIMITED USE DISKS PAST HERE - Firearm disks should almost never be unlimited.

// GUNS

/obj/item/disk/design_disk/limited/firearm // Do not modify this subtype.
	name = "Limited Firearm Design Disk"
	desc = "A firearm disk with limited charges"
	max_blueprints = 1 //Default for firearms disks is 1.
	max_charges = 5 //Default for limited firearms disk is 5.

/obj/item/disk/design_disk/limited/firearm/disposable_gun
	name = "design disk - disposable guns"
	desc = "A design disk containing designs for a cheap and disposable gun."
	illustration = "gun"
	max_blueprints = 1
	max_charges = 20
	starting_blueprints = list(/datum/design/disposable_gun)

/obj/item/disk/design_disk/blanks
	design_name = "Blank Ammo"
	starting_blueprints = list(/datum/design/blank_shell)

//KA modkit design discs
/obj/item/disk/design_disk/modkit_disc
	design_name = "KA Mod"
	desc = "A design disc containing the design for a unique kinetic accelerator modkit. It's compatible with a research console."
	illustration = "accel"
	color = "#6F6F6F"
	starting_blueprints = list(/datum/design/unique_modkit)

/obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe
	design_name = "Offensive Mining Explosion Mod"
	starting_blueprints = list(/datum/design/unique_modkit/offensive_turf_aoe)

/obj/item/disk/design_disk/modkit_disc/rapid_repeater
	design_name = "Rapid Repeater Mod"
	starting_blueprints = list(/datum/design/unique_modkit/rapid_repeater)

/obj/item/disk/design_disk/modkit_disc/resonator_blast
	design_name = "Resonator Blast Mod"
	starting_blueprints = list(/datum/design/unique_modkit/resonator_blast)

/obj/item/disk/design_disk/modkit_disc/bounty
	design_name = "Death Syphon Mod"
	starting_blueprints = list(/datum/design/unique_modkit/bounty)
