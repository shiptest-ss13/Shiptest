// the ever continuing guncode growth. if only we had this passion for engineering.

/* Attachments */

/datum/supply_pack/attachment
	category = "Gun Attachments"
	crate_type = /obj/structure/closet/crate/secure/weapon
	faction_discount = 10

/datum/supply_pack/attachment/rail_light
	name = "Tactical Rail Light Crate"
	desc = "Contains a single rail light to be mounted on a firearm."
	cost = 75
	contains = list(/obj/item/attachment/rail_light)
	crate_name = "rail light crate"

/datum/supply_pack/attachment/laser_sight
	name = "Laser Sight Crate"
	desc = "Contains a single rail light to be mounted on a firearm."
	cost = 250
	contains = list(/obj/item/attachment/laser_sight)
	crate_name = "laser sight crate"

/datum/supply_pack/attachment/bayonet
	name = "Bayonet Crate"
	desc = "Contains a single bayonet to be mounted on a firearm."
	cost = 250
	contains = list(/obj/item/attachment/bayonet)
	crate_name = "bayonet crate"

/datum/supply_pack/attachment/ebayonet
	name = "Energy Bayonet Crate"
	desc = "Contains a single energy bayonet to be mounted on a firearm, exclusive for Scarborough Firearms."
	cost = 500
	contains = list(/obj/item/attachment/energy_bayonet)
	crate_name = "bayonet crate"
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/attachment/silencer
	name = "Suppressor Crate"
	desc = "Contains a single suppressor to be mounted on a firearm."
	cost = 250
	contains = list(/obj/item/attachment/silencer)
	crate_name = "suppressor crate"

/datum/supply_pack/attachment/counter
	name = "Ammo Counter Crate"
	desc = "Contains a single ammo counter to mount on a firearm."
	cost = 100
	contains = list(/obj/item/attachment/ammo_counter)
	crate_name = "ammo counter crate"

/datum/supply_pack/attachment/scope
	name = "Scope Crate"
	desc = "Contains a single scope to be mounted on a firearm."
	cost = 400
	contains = list(/obj/item/attachment/scope)
	crate_name = "scope crate"

/datum/supply_pack/attachment/long_scope
	name = "Long Scope Crate"
	desc = "Contains a single high powered scope to be mounted on a firearm."
	cost = 800
	contains = list(/obj/item/attachment/long_scope)
	crate_name = "scope crate"

/*
/datum/supply_pack/attachment/shotgun
	name = "Underbarrel Shotgun Crate"
	desc = "Contains a two shot underbarrel pump shotgun to be mounted on a firearm."
	cost = 1200
	contains = list(/obj/item/storage/guncase/underbarrel_shotgun)
	crate_name = "underbarrel shotgun crate"

/datum/supply_pack/attachment/hognose
	name = "Underbarrel Hognose Crate"
	desc = "Contains an eight shot underbarrel 22lr pistol to be mounted on a firearm."
	cost = 500
	contains = list(/obj/item/storage/guncase/underbarrel_hognose)
	crate_name = "underbarrel hognose crate"

/datum/supply_pack/attachment/flamethrower
	name = "Underbarrel Flamethrower Crate"
	desc = "Contains a compact underbarrel flamethrower to be mounted on a firearm."
	cost = 750
	contains = list(/obj/item/storage/guncase/underbarrel_flamethrower)
	crate_name = "underbarrel flamethrower crate"

/datum/supply_pack/attachment/e_gun
	name = "Underbarrel Energy Gun Crate"
	desc = "Contains an underbarrel energy gun to be mounted on a firearm."
	cost = 750
	contains = list(/obj/item/storage/guncase/energy/underbarrel_e_gun)
	crate_name = "underbarrel energy gun crate"

/datum/supply_pack/attachment/flare
	name = "Underbarrel Flare Gun Crate"
	desc = "Contains a single shot underbarrel flare gun to be mounted on a firearm. One box of flares included."
	cost = 200
	contains = list(/obj/item/attachment/gun/flare)
	crate_name = "underbarrel flare gun crate"
*/
