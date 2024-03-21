/obj/item/part
	icon ='icons/obj/crafts.dmi'

/obj/item/part/gun
	name = "gun part"
	desc = "Spare part of gun."
	icon_state = "gun_part_1"
	var/gun_part_type = NONE
	var/material_cost = list()

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
	material_cost = list(/obj/item/stack/sheet/mineral/wood = 3)


/obj/item/part/gun/modular/grip/black
	name = "plastic grip"
	desc = "A black plastic firearm grip, unattached from a firearm. For sleekness and decorum."
	icon_state = "grip_black"
	material_cost = list(/obj/item/stack/sheet/metal = 2)

/obj/item/part/gun/modular/mechanism
	name = "generic mechanism"
	desc = "All the bits that makes the bullet go bang."
	icon_state = "mechanism_pistol"
	gun_part_type = GUN_PART_MECHANISM

/obj/item/part/gun/modular/mechanism/revolver
	name = "generic revolver mechanism"
	material_cost = list(/obj/item/stack/sheet/metal = 3)

/obj/item/part/gun/modular/mechanism/pistol
	name = "generic pistol mechanism"
	material_cost = list(/obj/item/stack/sheet/metal = 3)

/obj/item/part/gun/modular/barrel
	name = "generic barrel"
	desc = "A gun barrel, which keeps the bullet going in the right direction."
	icon_state = "barrel_35"
	gun_part_type = GUN_PART_BARREL

/obj/item/part/gun/modular/barrel/revolver
	name = "generic revolver barrel"
	material_cost = list(/obj/item/stack/sheet/metal = 2)

/obj/item/part/gun/modular/barrel/pistol
	name = "generic pistol barrel"
	material_cost = list(/obj/item/stack/sheet/metal = 2)
