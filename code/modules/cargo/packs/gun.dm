/datum/supply_pack/gun
	group = "Guns"
	crate_type = /obj/structure/closet/crate/secure/weapon

/*
		Pistols
*/

/datum/supply_pack/gun/disposable
	name = "Disposable Gun Crate"
	desc = "In some sectors, these disposable pistols are the only firearms that can be legally sold for less than 200cr. That price is still far too high."
	cost = 300
	contains = list(/obj/item/storage/pistolcase/disposable)
	crate_name = "disposable gun crate"
	faction = FACTION_FRONTIER

/datum/supply_pack/gun/derringer
	name = ".38 Derringer Crate"
	desc = "A cheap, concealable pistol manufactured by the reputable Hunter's Pride. At least it's better than a disposable pistol. Chambered in .38 rounds."
	cost = 350
	contains = list(/obj/item/storage/pistolcase/derringer)
	crate_name = "derringer crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/commanders
	name = "Commander Pistol Crate"
	desc = "Contains a modified Candor 'Commander' pistol, produced by Nanotrasen and chambered in 9mm."
	cost = 1000
	contains = list(/obj/item/storage/pistolcase/commander)
	faction = FACTION_NT

/datum/supply_pack/gun/makarovs
	name = "Stechkin Pistol Crate"
	desc = "Contains a concealable stechkin pistol, produced by Scarborough Arms and chambered in 10mm."
	cost = 1250
	contains = list(/obj/item/storage/pistolcase/stechkin)
	faction = FACTION_SYNDICATE

/datum/supply_pack/gun/candors
	name = "Candor Pistol Crate"
	desc = "Contains a Candor pistol, the trusty sidearm of any spacer, produced by Hunter's Pride and chambered in .45 ACP."
	cost = 1250
	contains = list(/obj/item/storage/pistolcase/candor)
	faction = FACTION_SRM

/datum/supply_pack/gun/pepperbox
	name = "HP Firebrand Pepperbox Revolver Crate"
	desc = "Contains a concealable pepperbox revolver manufactured by the Saint Roumain Militia, chambered in .357."
	cost = 1250
	contains = list(/obj/item/storage/pistolcase/firebrand)
	faction = FACTION_SRM

/datum/supply_pack/gun/detrevolver
	name = "Hunter's Pride Detective Revolver Crate"
	desc = "Contains a concealable revolver favored by police departments around the sector, chambered in .38."
	cost = 600
	contains = list(/obj/item/storage/pistolcase/detective)
	faction = FACTION_SRM

/datum/supply_pack/gun/shadowrevolver
	name = "Shadow Revolver Crate"
	desc = "Contains a concealable Shadow revolver, chambered in .44 Roumain."
	cost = 1000
	contains = list(/obj/item/storage/pistolcase/shadow)
	faction = FACTION_SRM


/*
		Energy
*/

/datum/supply_pack/gun/laser
	name = "Laser Gun Crate"
	desc = "Contains a lethal, high-energy laser gun."
	cost = 1000
	contains = list(/obj/item/storage/pistolcase/laser)
	crate_name = "laser crate"

/datum/supply_pack/gun/mini_energy
	name = "Mini Energy Gun Crate"
	desc = "Contains a small, versatile energy gun, capable of firing both nonlethal and lethal blasts, but with a limited power cell."
	cost = 500
	contains = list(/obj/item/storage/pistolcase/miniegun)
	crate_name = "laser crate"

/datum/supply_pack/gun/energy
	name = "Energy Gun Crate"
	desc = "Contains a versatile energy gun, capable of firing both nonlethal and lethal blasts of light."
	cost = 1250
	contains = list(/obj/item/storage/pistolcase/egun)
	crate_name = "energy gun crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/gun/ion
	name = "Ion Rifle Crate"
	desc = "Contains a single Mk.I Ion Projector, a special anti-tank rifle designed to disable electronic threats at range."
	cost = 10000
	contains = list(/obj/item/storage/pistolcase/iongun)
	crate_name = "ion rifle crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/gun/laser/kalix/pistol
	name = "Etherbor SG-8 Beam Pistol Crate"
	desc = "Contains a single SG-8 Beam Pistol, a civilian-grade sidearm developed in the PGF, manufactured by Etherbor Industries."
	cost = 1000
	contains = list(/obj/item/storage/pistolcase/kalixpistol)
	crate_name = "beam pistol crate"

/datum/supply_pack/gun/laser/kalix
	name = "Etherbor BG-12 Beam Rifle Crate"
	desc = "Contains a single BG-12 Beam Rifle, a civilian-grade semi-automatic developed in the PGF, manufactured by Etherbor Industries."
	cost = 3000
	contains = list(/obj/item/storage/guncase/kalixrifle)
	crate_name = "beam rifle crate"

/*
		Shotguns
*/

/datum/supply_pack/gun/doublebarrel_shotgun
	name = "Double Barrel Shotgun Crate"
	desc = "For when you need to deal with 2 drunkards the old-fashioned way. Contains a double-barreled shotgun, favored by Bartenders. Warranty voided if sawed off."
	cost = 1000
	contains = list(/obj/item/storage/guncase/doublebarrel)
	crate_name = "shotguns crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/hellfire_shotgun
	name = "Hellfire Shotgun Crate"
	desc = "For when you need to deal with 8 hooligans. Contains a pump shotgun, with a 8-round capacity."
	cost = 2000
	contains = list(/obj/item/storage/guncase/hellfire)
	crate_name = "shotgun crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/brimstone_shotgun
	name = "Brimstone Shotgun Crate"
	desc = "For when you need to deal with 5 hooligans, and QUICKLY. Contains a slamfire shotgun, with a 5-round capacity. Warranty voided if sawed off."
	cost = 2000
	contains = list(/obj/item/storage/guncase/brimstone)
	crate_name = "shotgun crate"
	faction = FACTION_SRM

/*
		Rifles
*/

/datum/supply_pack/gun/winchester
	name = "Flaming Arrow Lever Action Rifle Crate"
	desc = "Contains an antiquated lever action rifle intended for hunting wildlife. Chambered in .38 rounds."
	cost = 750
	contains = list(/obj/item/storage/guncase/winchester)
	crate_name = "rifle crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/illestren
	name = "Illestren Rifle Crate"
	desc = "Contains an expertly made bolt action rifle intended for hunting wildlife. Chambered in 8x50mmR rounds."
	cost = 1250
	contains = list(/obj/item/storage/guncase/illestren)
	crate_name = "rifle crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/beacon
	name = "Contender Break Action Rifle Crate"
	desc = "Contains a single shot break action rifle to hunt wildlife that annoys you in particular. Chambered in devastating .45-70 rounds. Warranty voided if sawed off."
	cost = 2250
	contains = list(/obj/item/storage/guncase/beacon)
	crate_name = "rifle crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/scout
	name = "Scout Sniper Rifle Crate"
	desc = "Contains a traditional scoped rifle to hunt wildlife and big game from a respectful distance. Chambered in powerful .300 Magnum."
	cost = 5500
	contains = list(/obj/item/storage/guncase/scout)
	crate_name = "rifle crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/cobra20
	name = "Cobra-20 SMG Crate"
	desc = "Contains a .45 submachine gun, manufactured by Scaraborough Arms and chambered in .45"
	cost = 6000
	contains = list(/obj/item/storage/guncase/cobra)
	crate_name = "SMG crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/wt550
	name = "WT-550 Auto Rifle Crate"
	desc = "Contains a high-powered, automatic personal defense weapon chambered in 4.6x30mm."
	cost = 6000
	contains = list(/obj/item/storage/guncase/wt550)
	crate_name = "auto rifle crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/p16
	name = "P16 Assault Rifle Crate"
	desc = "Contains a high-powered, automatic rifle chambered in 5.56mm."
	cost = 9000
	contains = list(/obj/item/storage/guncase/p16)
	crate_name = "auto rifle crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/skm
	name = "SKM-24 Rifle Crate"
	desc = "Contains a high-powered, automatic rifle chambered in 7.62x40mm CLIP."
	cost = 9000
	contains = list(/obj/item/storage/guncase/skm)
	crate_name = "auto rifle crate"
	faction = FACTION_SRM

/datum/supply_pack/gun/attachment/rail_light
	name = "Tactical Rail Light Crate"
	desc = "Contains a single rail light to be mounted on a firearm."
	cost = 250
	contains = list(/obj/item/attachment/rail_light)
	crate_name = "rail light crate"

/datum/supply_pack/gun/attachment/laser_sight
	name = "Laser Sight Crate"
	desc = "Contains a single rail light to be mounted on a firearm."
	cost = 250
	contains = list(/obj/item/attachment/laser_sight)
	crate_name = "laser sight crate"

/datum/supply_pack/gun/attachment/bayonet
	name = "Bayonet Crate"
	desc = "Contains a single bayonet to be mounted on a firearm."
	cost = 250
	contains = list(/obj/item/attachment/bayonet)
	crate_name = "bayonet crate"

/datum/supply_pack/gun/attachment/silencer
	name = "Suppressor Crate"
	desc = "Contains a single suppressor to be mounted on a firearm."
	cost = 250
	contains = list(/obj/item/attachment/silencer)
	crate_name = "silencer crate"
