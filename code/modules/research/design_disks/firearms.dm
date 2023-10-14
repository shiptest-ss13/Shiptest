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
	name = "design disk - 1911 magazine"
	desc = "A design disk containing the pattern for the classic 1911's seven round .45ACP magazine."
	illustration = "ammo"

/obj/item/disk/design_disk/ammunition/mag_1911/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/colt_1911_magazine

// ROUNDS

/obj/item/disk/design_disk/ammunition/n762
	name = "design disk - n762 rounds"
	desc = "A design disk containing specifications for n762 ammunition."

/obj/item/disk/design_disk/ammunition/n762/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/n762

// LIMITED USE DISKS PAST HERE - Firearm disks should almost never be unlimited.

// GUNS

/obj/item/disk/design_disk/limited/firearm/ // Do not modify this subtype.
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

/obj/item/disk/design_disk/limited/firearm/disposable_gun/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/disposable_gun/
