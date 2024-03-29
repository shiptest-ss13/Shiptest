/datum/supply_pack/gun
	group = "Guns"
	crate_type = /obj/structure/closet/crate/secure/weapon

/*
		Pistols
*/

/datum/supply_pack/gun/disposable
	name = "Disposable Guns Crate"
	desc = "In some sectors, these disposable pistols are the only firearms that can be legally sold for less than 400cr. That price is still far too high; this pack contains five."
	cost = 750
	contains = list(/obj/item/gun/ballistic/automatic/pistol/disposable,
					/obj/item/gun/ballistic/automatic/pistol/disposable,
					/obj/item/gun/ballistic/automatic/pistol/disposable,
					/obj/item/gun/ballistic/automatic/pistol/disposable,
					/obj/item/gun/ballistic/automatic/pistol/disposable)
	crate_name = "disposable gun crate"

/datum/supply_pack/gun/commanders
	name = "Commander pistol crate"
	desc = "Contains a modified Candor 'Commander' pistol, produced by Nanotrasen and chambered in 9mm."
	cost = 750
	contains = list(/obj/item/gun/ballistic/automatic/pistol/commander)

/datum/supply_pack/gun/makarovs
	name = "Stechkin pistol crate"
	desc = "Contains a concealable stechkin pistol, produced by Scarborough Arms and chambered in 10mm."
	cost = 1000
	contains = list(/obj/item/gun/ballistic/automatic/pistol,
					/obj/item/gun/ballistic/automatic/pistol)

/datum/supply_pack/gun/revolver
	name = "Scarbourgh Revolver crate"
	desc = "Contains a concealable Scarbourgh revolver, chambered in .357."
	cost = 1250
	contains = list(/obj/item/gun/ballistic/revolver)

/datum/supply_pack/gun/detrevolver
	name = "Hunter's Pride Detective Revolver crate"
	desc = "Contains a concealable Solarian revolver, chambered in .38."
	cost = 1000
	contains = list(/obj/item/gun/ballistic/revolver/detective)

/datum/supply_pack/gun/shadowrevolver
	name = "Shadow Revolver crate"
	desc = "Contains a concealable Shadow revolver, chambered in .45 ACP."
	cost = 1000
	contains = list(/obj/item/gun/ballistic/revolver/shadow)


/*
		Energy
*/

/datum/supply_pack/gun/laser
	name = "Laser Gun Crate"
	desc = "Contains a lethal, high-energy laser gun."
	cost = 1000
	contains = list(/obj/item/gun/energy/laser)
	crate_name = "laser crate"

/datum/supply_pack/gun/laser
	name = "Mini Energy Gun Crate"
	desc = "Contains a small, versatile energy gun, capable of firing both nonlethal and lethal blasts, but with a limited power cell."
	cost = 500
	contains = list(/obj/item/gun/energy/e_gun/mini)
	crate_name = "laser crate"

/datum/supply_pack/gun/energy
	name = "Energy Gun Crate"
	desc = "Contains a versatile energy gun, capable of firing both nonlethal and lethal blasts of light."
	cost = 1250
	contains = list(/obj/item/gun/energy/e_gun)
	crate_name = "energy gun crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/gun/ion
	name = "Ion Rifle Crate"
	desc = "Contains a single Mk.I Ion Projector, a special anti-tank rifle designed to disable electronic threats at range."
	cost = 10000
	contains = list(/obj/item/gun/energy/ionrifle)
	crate_name = "ion rifle crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/*
		Shotguns
*/

/datum/supply_pack/gun/hellfire_shotgun
	name = "Hellfire Shotgun Crate"
	desc = "For when you need to deal with 7 hooligans. Contains a pump shotgun, with a 8-round capacity."
	cost = 2000
	contains = list(/obj/item/gun/ballistic/shotgun/hellfire)
	crate_name = "shotguns crate"

/datum/supply_pack/gun/brimstone_shotgun
	name = "Brimstone Shotgun Crate"
	desc = "For when you need to deal with 5 hooligans, and QUICKLY. Contains a slamfire shotgun, with a 5-round capacity. Warranty voided if sawed off."
	cost = 2000
	contains = list(/obj/item/gun/ballistic/shotgun/brimstone)
	crate_name = "shotguns crate"

/*
		Rifles
*/

/datum/supply_pack/gun/winchester
	name = "Flaming Arrow Lever Action Rifle Crate"
	desc = "Contains a antiquated lever action rifle intended for hunting wildlife. Chambered in .38 rounds."
	cost = 750
	contains = list(/obj/item/gun/ballistic/shotgun/flamingarrow)
	crate_name = "rifle crate"

/datum/supply_pack/gun/cobra20
	name = "Cobra-20 SMG Crate"
	desc = "Contains a .45 submachine gun, manufactured by Scaraborough Arms and chambered in .45"
	cost = 3000
	contains = list(/obj/item/gun/ballistic/automatic/smg/c20r/cobra)
	crate_name = "SMG crate"

/datum/supply_pack/gun/illestren
	name = "Illestren Rifle Crate"
	desc = "Contains a expertly made bolt action rifle intended for hunting wildlife. Chambered in 8x50mmR rounds."
	cost = 1250
	contains = list(/obj/item/gun/ballistic/rifle/illestren)
	crate_name = "rifle crate"

/datum/supply_pack/gun/wt550
	name = "WT-550 Auto Rifle Crate"
	desc = "Contains a high-powered, automatic personal defense weapon chambered in 4.6x30mm."
	cost = 4000
	contains = list(/obj/item/gun/ballistic/automatic/smg/wt550)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/p16
	name = "P16 Assault Rifle Crate"
	desc = "Contains a high-powered, automatic rifle chambered in 5.56mm."
	cost = 5000
	contains = list(/obj/item/gun/ballistic/automatic/assault/p16)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/skm
	name = "SKM-24 Rifle Crate"
	desc = "Contains a high-powered, automatic rifle chambered in 7.62x40mm CLIP."
	cost = 5000
	contains = list(/obj/item/gun/ballistic/automatic/assault/skm)
	crate_name = "auto rifle crate"

/*
		Firing pins
*/

/datum/supply_pack/gun/firingpins
	name = "Standard Firing Pins Crate"
	desc = "Upgrade your arsenal with 10 standard firing pins."
	cost = 2000
	contains = list(/obj/item/storage/box/firingpins,
					/obj/item/storage/box/firingpins)
	crate_name = "firing pins crate"

/datum/supply_pack/gun/lasertag_pins
	name = "Laser Tag Firing Pins Crate"
	desc = "Three laser tag firing pins used in laser-tag units to ensure users are wearing their vests."
	cost = 1500
	contains = list(/obj/item/storage/box/lasertagpins)
	crate_name = "laser tag pin crate"
