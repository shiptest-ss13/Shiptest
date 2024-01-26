/obj/item/part
	icon ='icons/obj/crafts.dmi'

/obj/item/part/gun
	name = "gun part"
	desc = "Spare part of gun."
	icon_state = "gun_part_1"
	var/gun_part_type = NONE

/obj/item/part/gun/modular
	name = "modular gun part"
	desc = "You dont think this should exist."

/obj/item/part/gun/modular/grip
	name = "generic grip"
	desc = "A firearm grip, unattached from a firearm."
	icon_state = "grip_wood"
	gun_part_type = GUN_PART_GRIP

/obj/item/part/gun/modular/grip/wood
	name = "wood grip"
	desc = "A wood firearm grip, unattached from a firearm."
	icon_state = "grip_wood"

/obj/item/part/gun/modular/grip/black
	name = "plastic grip"
	desc = "A black plastic firearm grip, unattached from a firearm. For sleekness and decorum."
	icon_state = "grip_black"

/obj/item/part/gun/modular/mechanism
	name = "generic mechanism"
	desc = "All the bits that makes the bullet go bang."
	icon_state = "mechanism_pistol"
	gun_part_type = GUN_PART_MECHANISM

/obj/item/part/gun/modular/mechanism/shotgun
	name = "generic shotgun mechanism"
	desc = "All the bits that makes the bullet go bang."
	icon_state = "mechanism_shotgun"

/obj/item/part/gun/modular/barrel
	name = "generic barrel"
	desc = "A gun barrel, which keeps the bullet going in the right direction."
	icon_state = "barrel_35"
	gun_part_type = GUN_PART_BARREL

/obj/item/part/gun/modular/barrel/shotgun
	name = "generic shotgun barrel"
	desc = "A gun barrel, which keeps the bullet going in the right direction."
	icon_state = "barrel_30"
