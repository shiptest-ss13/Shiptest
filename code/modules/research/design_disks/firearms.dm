/*
	This file contains disks with various firearms,
	as well as ammunition.
*/

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

// AMMUNITION

/obj/item/disk/design_disk/limited/ammunition // Do not modify this subtype.
	name = "Limited Ammunition Design Disk"
	desc = "A firearm disk with limited charges"
	illustration = "target"
	max_blueprints = 1 //Default for firearms disks is 1.
	max_charges = 5 //Default for limited firearms disk is 5.
