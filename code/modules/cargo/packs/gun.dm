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
	desc = "Contains two modified M1911 'Commander' pistols, produced by Nanotrasen and chambered in 9mm."
	cost = 1500
	contains = list(/obj/item/gun/ballistic/automatic/pistol/commander,
					/obj/item/gun/ballistic/automatic/pistol/commander)

/datum/supply_pack/gun/makarovs
	name = "Stechkin pistol crate"
	desc = "Contains two concealable soviet-era stechkin pistols, produced by the Gorlex Marauders and chambered in 10mm."
	cost = 2000
	contains = list(/obj/item/gun/ballistic/automatic/pistol,
					/obj/item/gun/ballistic/automatic/pistol)

/*
		Energy
*/

/datum/supply_pack/gun/laser
	name = "Lasers Crate"
	desc = "Contains two lethal, high-energy laser guns."
	cost = 2000
	contains = list(/obj/item/gun/energy/laser,
					/obj/item/gun/energy/laser)
	crate_name = "laser crate"

/datum/supply_pack/gun/energy
	name = "Energy Guns Crate"
	desc = "Contains two versatile energy guns, capable of firing both nonlethal and lethal blasts of light."
	cost = 2500
	contains = list(/obj/item/gun/energy/e_gun,
					/obj/item/gun/energy/e_gun)
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

/datum/supply_pack/gun/riot_shotgun
	name = "Riot Shotguns Crate"
	desc = "For when the greytide gets out of hand. Contains 2 pump shotguns, each with a 4-round magazine."
	cost = 2500
	contains = list(/obj/item/gun/ballistic/shotgun/lethal,
					/obj/item/gun/ballistic/shotgun/lethal)
	crate_name = "shotguns crate"

/datum/supply_pack/gun/ballistic
	name = "Combat Shotguns Crate"
	desc = "For when the enemy absolutely needs to be replaced with lead. Contains two Aussec-designed combat shotguns."
	cost = 4500
	contains = list(/obj/item/gun/ballistic/shotgun/automatic/combat,
					/obj/item/gun/ballistic/shotgun/automatic/combat)
	crate_name = "combat shotguns crate"

/*
		Rifles
*/

/datum/supply_pack/gun/winchester
	name = "Winchester Lever Action Rifle Crate"
	desc = "Contains three antiquated lever action rifles intended for hunting wildlife. Chambered in .38 rounds."
	cost = 2000
	contains = list(/obj/item/gun/ballistic/shotgun/winchester,
					/obj/item/gun/ballistic/shotgun/winchester,
					/obj/item/gun/ballistic/shotgun/winchester)
	crate_name = "rifle crate"

/datum/supply_pack/gun/wt550
	name = "WT-550 Auto Rifle Crate"
	desc = "Contains two high-powered, semiautomatic rifles chambered in 4.6x30mm."
	cost = 6000
	contains = list(/obj/item/gun/ballistic/automatic/smg/wt550,
					/obj/item/gun/ballistic/automatic/smg/wt550)
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

/datum/supply_pack/gun/paywall_pins
	name = "Paywall Firing Pins Crate"
	desc = "Specialized firing pins with a built-in configurable paywall."
	cost = 1500
	contains = list(/obj/item/storage/box/firingpins/paywall,
					/obj/item/storage/box/firingpins/paywall)
	crate_name = "paywall firing pins crate"

/datum/supply_pack/gun/clown_pin
	name = "Hilarious Firing Pin Crate"
	desc = "I uh... I'm not really sure what this does. Wanna buy it?"
	cost = 1500
	contains = list(/obj/item/firing_pin/clown)
	crate_name = "toy crate" // It's /technically/ a toy. For the clown, at least.
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/gun/lasertag_pins
	name = "Laser Tag Firing Pins Crate"
	desc = "Three laser tag firing pins used in laser-tag units to ensure users are wearing their vests."
	cost = 1500
	contains = list(/obj/item/storage/box/lasertagpins)
	crate_name = "laser tag pin crate"
