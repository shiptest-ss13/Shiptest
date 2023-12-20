/datum/supply_pack/sec_supply
	group = "Security Supplies"
	crate_type = /obj/structure/closet/crate/secure/gear

/*
		Standard supplies
*/

/datum/supply_pack/sec_supply/chemimp
	name = "Chemical Implants Crate"
	desc = "Contains five remote chemical implants."
	cost = 1000
	contains = list(/obj/item/storage/box/chemimp)
	crate_name = "chemical implant crate"

/datum/supply_pack/sec_supply/trackingimp
	name = "Tracking Implants Crate"
	desc = "Contains four tracking implants."
	cost = 2000
	contains = list(/obj/item/storage/box/trackimp)
	crate_name = "tracking implant crate"

/datum/supply_pack/sec_supply/securitybarriers
	name = "Security Barrier Grenades"
	desc = "Stem the tide with four Security Barrier grenades."
	contains = list(/obj/item/grenade/barrier,
					/obj/item/grenade/barrier,
					/obj/item/grenade/barrier,
					/obj/item/grenade/barrier)
	cost = 2000
	crate_name = "security barriers crate"

/datum/supply_pack/sec_supply/wall_flash
	name = "Wall-Mounted Flash Crate"
	desc = "Contains four wall-mounted flashes."
	cost = 3000
	contains = list(/obj/item/storage/box/wall_flash,
					/obj/item/storage/box/wall_flash,
					/obj/item/storage/box/wall_flash,
					/obj/item/storage/box/wall_flash)
	crate_name = "wall-mounted flash crate"

/datum/supply_pack/sec_supply/supplies
	name = "Security Supplies Crate"
	desc = "Contains seven flashbangs, seven teargas grenades, six flashes, and seven handcuffs."
	cost = 5000
	contains = list(/obj/item/storage/box/flashbangs,
					/obj/item/storage/box/teargas,
					/obj/item/storage/box/flashes,
					/obj/item/storage/box/handcuffs)
	crate_name = "security supply crate"

/*
		Misc. weapons / protection
*/

/datum/supply_pack/sec_supply/riotshields
	name = "Riot Shields Crate"
	desc = "For when the greytide gets really uppity. Contains three riot shields."
	cost = 2000
	contains = list(/obj/item/shield/riot,
					/obj/item/shield/riot,
					/obj/item/shield/riot)
	crate_name = "riot shields crate"

/datum/supply_pack/sec_supply/combatknives
	name = "Combat Knives Crate"
	desc = "Contains three sharpened combat knives. Each knife guaranteed to fit snugly inside any galactic-standard boot."
	cost = 2500
	contains = list(/obj/item/kitchen/knife/combat,
					/obj/item/kitchen/knife/combat,
					/obj/item/kitchen/knife/combat)
	crate_name = "combat knife crate"

/datum/supply_pack/sec_supply/fire
	name = "Incendiary Weapons Crate"
	desc = "Burn, baby burn. Contains three incendiary grenades and three prebuilt flamethrowers."
	cost = 5000
	contains = list(
		/obj/item/flamethrower/full,
		/obj/item/flamethrower/full,
		/obj/item/flamethrower/full,
		/obj/item/grenade/chem_grenade/incendiary,
		/obj/item/grenade/chem_grenade/incendiary,
		/obj/item/grenade/chem_grenade/incendiary,
	)
	crate_name = "incendiary weapons crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/*
		Stamina / PVP weapons (intentionally overpriced due to odd balance position of stamina weapons)
*/

/datum/supply_pack/sec_supply/stingpack
	name = "Stingbang Grenade Pack"
	desc = "Contains five \"stingbang\" grenades, perfect for stopping riots and playing morally unthinkable pranks."
	cost = 7500
	contains = list(/obj/item/storage/box/stingbangs)
	crate_name = "stingbang grenade pack crate"

/datum/supply_pack/sec_supply/syringegun
	name = "Syringe Gun Crate"
	desc = "Contains a single syringe gun."
	cost = 8000
	contains = list(/obj/item/gun/syringe)
	crate_name = "syringe gun crate"

/datum/supply_pack/sec_supply/baton
	name = "Stun Batons Crate"
	desc = "Arm the Civil Protection Forces with three stun batons. Batteries included."
	cost = 9000
	contains = list(/obj/item/melee/baton/loaded,
					/obj/item/melee/baton/loaded,
					/obj/item/melee/baton/loaded)
	crate_name = "stun baton crate"

/datum/supply_pack/sec_supply/disabler
	name = "Disabler Crate"
	desc = "Three stamina-draining disabler weapons."
	cost = 9000
	contains = list(/obj/item/gun/energy/disabler,
					/obj/item/gun/energy/disabler,
					/obj/item/gun/energy/disabler)
	crate_name = "disabler crate"

/datum/supply_pack/sec_supply/dragnet
	name = "DRAGnet Crate"
	desc = "Contains three \"Dynamic Rapid-Apprehension of the Guilty\" netting devices, a recent breakthrough in law enforcement prisoner management technology."
	cost = 10000
	contains = list(/obj/item/gun/energy/e_gun/dragnet,
					/obj/item/gun/energy/e_gun/dragnet,
					/obj/item/gun/energy/e_gun/dragnet)
	crate_name = "\improper DRAGnet crate"

/datum/supply_pack/sec_supply/taser
	name = "Hybrid Taser Crate"
	desc = "Two disabler-taser hybrid weapons."
	cost = 12000
	contains = list(/obj/item/gun/energy/e_gun/advtaser,
					/obj/item/gun/energy/e_gun/advtaser)
	crate_name = "hybrid taser crate"
