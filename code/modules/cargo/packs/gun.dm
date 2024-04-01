/datum/supply_pack/gun
	group = "Guns"
	crate_type = /obj/structure/closet/crate/secure/weapon

/*
		Pistols
*/

/datum/supply_pack/gun/disposable
	name = "Disposable Guns Crate"
	desc = "In some sectors, these disposable pistols are the only firearms that can be legally sold for less than 400cr. That price is still far too high; this pack contains five."
	cost = 500
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

/datum/supply_pack/gun/commanders
	name = "Commissioner pistol crate"
	desc = "Contains a modified Commander that's just painted inteq. Chambered in 9mm."
	cost = 750
	contains = list(/obj/item/gun/ballistic/automatic/pistol/commander/inteq)

/datum/supply_pack/gun/cm23
	name = "CM-23 pistol crate"
	desc = "Contains a CM-23 pistol. Chambered in 10mm."
	cost = 750
	contains = list(/obj/item/gun/ballistic/automatic/pistol/cm23)

/datum/supply_pack/ammo/cm23
	name = "10mm CM-23 Magazine Crate"
	desc = "Contains a 10mm magazine for the standard-issue CM-23, containing ten rounds."
	contains = list(/obj/item/ammo_box/magazine/cm23)
	cost = 500

/datum/supply_pack/gun/candor
	name = "Candor pistol crate"
	desc = "Contains a Candor pistol. Chambered in .45 ACP."
	cost = 600
	contains = list(/obj/item/gun/ballistic/automatic/pistol/candor)

/datum/supply_pack/gun/makarovs
	name = "Stechkin pistol crate"
	desc = "Contains a concealable stechkin pistol, produced by Scarborough Arms and chambered in 10mm."
	cost = 600
	contains = list(/obj/item/gun/ballistic/automatic/pistol)

/datum/supply_pack/gun/solgov
	name = "Pistole C pistol crate"
	desc = "Contains a Pistole C pistol. Chambered in Chambered in 5.56mm caseless."
	cost = 1000
	contains = list(/obj/item/gun/ballistic/automatic/pistol/solgov)

/datum/supply_pack/gun/deagle
	name = "Deagle pistol crate"
	desc = "Contains a Deagle pistol. Chambered in Chambered in .50 AE. Perfect for the flaunting officer who never shoots their gun and thus does not have to spend money on reloads. Ha. Ha."
	cost = 3500
	contains = list(/obj/item/gun/ballistic/automatic/pistol/deagle)

/datum/supply_pack/ammo/deagle
	name = "Deagle Magazine Crate"
	desc = "Contains a 50ae magazine for the deagle, containing 7 rounds."
	contains = list(/obj/item/ammo_box/magazine/m50)
	cost = 1000

/datum/supply_pack/gun/deagle_gold
	name = "Gold Deagle pistol crate"
	desc = "Contains a Deagle pistol painted Gold. Chambered in Chambered in .50 AE."
	cost = 4000
	contains = list(/obj/item/gun/ballistic/automatic/pistol/deagle/gold)

/datum/supply_pack/gun/commander_2
	name = "Commander 2 machine pistol crate"
	desc = "Contains a Commander 2 machine pistol. Chambered in 9mm."
	cost = 2000
	contains = list(/obj/item/gun/ballistic/automatic/pistol/APS)
/datum/supply_pack/ammo/commander_2
	name = "Commander 2 Magazine Crate"
	desc = "Contains a 9mm magazine for the Commander 2."
	contains = list(/obj/item/ammo_box/magazine/m50)
	cost = 600


/datum/supply_pack/gun/cm70
	name = "CM-70 machine pistol crate"
	desc = "Contains a CM-70 machine pistol. Chambered in 9mm."
	cost = 2200
	contains = list(/obj/item/gun/ballistic/automatic/pistol/cm70)

/datum/supply_pack/ammo/commander_2
	name = "c Magazine Crate"
	desc = "Contains a 9mm magazine for the CM-70."
	contains = list(/obj/item/ammo_box/magazine/m9mm_cm70)
	cost = 650

/datum/supply_pack/gun/mauler
	name = "Mauler machine pistol crate"
	desc = "Contains a Mauler machine pistol. Chambered in 9mm."
	cost = 1800
	contains = list(/obj/item/gun/ballistic/automatic/pistol/mauler)

/datum/supply_pack/ammo/mauler
	name = "Mauler Magazine Crate"
	desc = "Contains a 9mm magazine for the Mauler."
	contains = list(/obj/item/ammo_box/magazine/m9mm_mauler)
	cost = 600

/datum/supply_pack/gun/conflagration
	name = "Conflagration pistol crate"
	desc = "Contains a Conflagration pistol. Chambered in 9mm."
	cost = 600
	contains = list(/obj/item/gun/ballistic/automatic/pistol/conflagration)

/datum/supply_pack/ammo/mauler
	name = "Conflagration stripper clip Magazine Crate"
	desc = "Contains a 9mm stripper for the Conflagration."
	contains = list(/obj/item/ammo_box/stripper_9mm)
	cost = 200

/datum/supply_pack/gun/himehabu
	name = "Himehabu pistol crate"
	desc = "Contains a Himehabu pistol. Chambered in .22 LR"
	cost = 400
	contains = list(/obj/item/gun/ballistic/automatic/pistol/himehabu)

/datum/supply_pack/ammo/himehabu
	name = "Himehabu Magazine Crate"
	desc = "Contains a 22lr magazine for the Himehabu."
	contains = list(/obj/item/ammo_box/magazine/m22lr)
	cost = 100

/datum/supply_pack/ammo/m22lr
	name = "22 LR Ammo Boxes"
	desc = "Contains a 75 round ammo box for refilling 22lr weapons."
	cost = 350
	contains = list(/obj/item/ammo_box/c22lr_box)
	crate_name = "ammo crate"

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

/datum/supply_pack/gun/montagne
	name = "Montagne crate"
	desc = "Contains a Montagne revolver, chambered in .45 ACP."
	cost = 1600
	contains = list(/obj/item/gun/ballistic/revolver/montagne)

/datum/supply_pack/gun/shadowrevolver
	name = "Unica 6 Revolver crate"
	desc = "Contains a Unica 6, chambered in chambered in .357."
	cost = 2450
	contains = list(/obj/item/gun/ballistic/revolver/mateba)


/datum/supply_pack/gun/ashhand
	name = "Ashhand revolver crate"
	desc = "Contains a Ashhand Revo- jesus christ how is this on the market? painted Gold. Chambered in Chambered in .45-70."
	cost = 4500
	contains = list(/obj/item/gun/ballistic/revolver/ashhand)


/datum/supply_pack/gun/firebrand
	name = "Firebrand pistol crate"
	desc = "Contains a concealable and extremely outdated Firebrand pistol, chambered in .38."
	cost = 500
	contains = list(/obj/item/gun/ballistic/revolver/firebrand)



/*
		Energy
*/

/datum/supply_pack/gun/laser
	name = "SL L-204 Crate"
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

/datum/supply_pack/gun/captain
	name = "SL X-00 Crate"
	desc = "Contains a lethal, high-energy and recharging antique laser gun."
	cost = 10000
	contains = list(/obj/item/gun/energy/laser/captain)
	crate_name = "laser crate"

/datum/supply_pack/gun/captain
	name = "SL X-01 Crate"
	desc = "Contains a versatile energy gun, capable of firing a bunch of fucking differnt modes."
	cost = 20000
	contains = list(/obj/item/gun/energy/e_gun/hos)
	crate_name = "laser crate"

/datum/supply_pack/gun/laser
	name = "Accelerator laser canon Crate"
	desc = "Contains a laser gun that grows in strength the more ground it covers. Less practical than it sounds"
	cost = 4500
	contains = list(/obj/item/gun/energy/lasercannon/unrestricted)
	crate_name = "laser crate"

/datum/supply_pack/gun/e10
	name = "E-10 Crate"
	desc = "Contains a antique, high-energy laser gun."
	cost = 1200
	contains = list(/obj/item/gun/energy/laser/e10)
	crate_name = "laser crate"

/datum/supply_pack/gun/e50
	name = "E-50 Crate"
	desc = "Contains a antique, extremely high-energy and energy-usage laser gun. You might be looking for emitters in the 'Tools' section."
	cost = 5000
	contains = list(/obj/item/gun/energy/laser/e50)
	crate_name = "laser crate"

/datum/supply_pack/gun/asr
	name = "Advanced Stopping Revolver (Energy Gun) Crate"
	desc = "Contains a forgotten energy gun... I don't even remember what this does. Use at own risk."
	cost = 1650
	contains = list(/obj/item/gun/energy/e_gun/adv_stopping)
	crate_name = "energy gun crate"

/datum/supply_pack/gun/esg500
	name = "E-SG 500 Energy Shotgun Crate"
	desc = "Contains a lethal, high-energy laser shotgun."
	cost = 2000
	contains = list(/obj/item/gun/energy/e_gun/iot)
	crate_name = "laser crate"

/datum/supply_pack/gun/laser
	name = "E-TAR Energy SMG Crate"
	desc = "Contains a lethal, high-energy laser smg."
	cost = 2500
	contains = list(/obj/item/gun/energy/e_gun/smg)
	crate_name = "laser crate"

/datum/supply_pack/gun/e10
	name = "E-11 Clearance Box"
	desc = "Theres an extremely dusty box in the corner of the trading center labeled 'CLEARANCE'. The clearance label is literally turning into dust and the cardboard is all rotting away... despite being marked down about 10 times before giving up, it still hasn't been sold... Are you sure you want to buy this?"
	cost = 850
	contains = list(/obj/item/gun/energy/e_gun/e11,/obj/item/gun/energy/e_gun/e11,/obj/item/gun/energy/e_gun/e11)
	crate_name = "laser crate"

/datum/supply_pack/gun/hades
	name = "SL AL-655 'Hades' Energy Rifle Crate"
	desc = "Contains a high-powered, automatic laser rifle."
	cost = 5000
	contains = list(/obj/item/gun/energy/e_gun/hades)
	crate_name = "laser crate"

/datum/supply_pack/gun/e40
	name = "E-40 Hybrid Rifle Crate"
	desc = "Contains a high-powered, automatic laser rifle. For the aspiring antique firearm collector"
	cost = 7000
	contains = list(/obj/item/gun/ballistic/automatic/assault/e40)
	crate_name = "laser crate"

/datum/supply_pack/ammo/e40
	name = "E40 magaine"
	desc = "Contains a 30 round magazine in .299 eoehoma."
	cost = 1000
	contains = list(/obj/item/ammo_box/magazine/e40)
	crate_name = "ammo crate"

/datum/supply_pack/gun/bg16
	name = "Etherbor BG-16 Crate"
	desc = "Contains a laser smg."
	cost = 3000
	contains = list(/obj/item/gun/energy/kalix/pgf)
	crate_name = "laser crate"

/datum/supply_pack/gun/hb7
	name = "Etherbor HBG-7 Crate"
	desc = "Contains a high-powered, automatic laser rifle. Somehow you get this."
	cost = 7000
	contains = list(/obj/item/gun/energy/kalix/pgf/heavy)
	crate_name = "laser crate"
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

/datum/supply_pack/gun/dbsg
	name = "Double barreled Shotgun Crate"
	desc = "Ahguahu."
	cost = 1250
	contains = list(/obj/item/gun/ballistic/shotgun/doublebarrel)
	crate_name = "shotguns crate"

/datum/supply_pack/gun/traubccco
	name = "six-barreled TRABUCO Shotgun Crate"
	desc = "you know what? fuck it. its fucking 2am, my wrist hurts, let the world fucking burn. This gun is a meme gun anwyays, who cares"
	cost = 3500
	contains = list(/obj/item/gun/ballistic/shotgun/doublebarrel/brazil)
	crate_name = "shotguns crate"

/datum/supply_pack/gun/bulldog_sg
	name = "Bulldog Shotgun Crate"
	desc = "Ahguahu."
	cost = 5000
	contains = list(/obj/item/gun/ballistic/shotgun/bulldog)
	crate_name = "shotguns crate"

/datum/supply_pack/gun/cm15
	name = "CM-15 Shotgun Crate"
	desc = "Ahguahu."
	cost = 5000
	contains = list(/obj/item/gun/ballistic/shotgun/bulldog/minutemen)
	crate_name = "shotguns crate"

/datum/supply_pack/gun/combat_sg
	name = "Combat Shotgun Crate"
	desc = "Ahguahu."
	cost = 4000
	contains = list(/obj/item/gun/ballistic/shotgun/automatic/combat)
	crate_name = "shotguns crate"

/datum/supply_pack/gun/huntsman
	name = "Huntsman Crate"
	desc = "Contains a fucking elephant gun."
	cost = 8000
	contains = list(/obj/item/gun/ballistic/shotgun/doublebarrel/twobore)
	crate_name = "shotguns crate"

/datum/supply_pack/gun/beacon
	name = "Beacon Crate"
	desc = "Contains a 45-70 hunting rifle."
	cost = 3000
	contains = list(/obj/item/gun/ballistic/shotgun/doublebarrel/beacon)
	crate_name = "shotguns crate"

/datum/supply_pack/ammo/box_4570
	name = "45-70 ammo box"
	desc = "Contains a 12 round ammo box for 45-70."
	cost = 1500
	contains = list(/obj/item/ammo_box/a4570)
	crate_name = "ammo crate"
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

/datum/supply_pack/gun/spiterr
	name = "Spitter SMG Crate"
	desc = "Contains a 9mm submachine gun, deigned by the Frontiersmen, bizzarely enough."
	cost = 3500
	contains = list(/obj/item/gun/ballistic/automatic/smg/mini_uzi)
	crate_name = "SMG crate"

/datum/supply_pack/gun/vector
	name = "Vector SMG Crate"
	desc = "Contains a 9mm submachine gun."
	cost = 3100
	contains = list(/obj/item/gun/ballistic/automatic/smg/vector)
	crate_name = "SMG crate"

/datum/supply_pack/gun/illestren
	name = "Illestren Rifle Crate"
	desc = "Contains a expertly made bolt action rifle intended for hunting wildlife. Chambered in 8x50mmR rounds."
	cost = 1250
	contains = list(/obj/item/gun/ballistic/rifle/illestren)
	crate_name = "rifle crate"

/datum/supply_pack/gun/illestren_scoped
	name = "Scoped Illestren Rifle Crate"
	desc = "Contains a expertly made bolt action rifle intended for hunting wildlife. Its scoped. Chambered in 8x50mmR rounds."
	cost = 5500
	contains = list(/obj/item/gun/ballistic/rifle/illestren/scoped)
	crate_name = "rifle crate"

/datum/supply_pack/gun/wt550
	name = "WT-550 Auto Rifle Crate"
	desc = "Contains a high-powered, automatic personal defense weapon chambered in 4.6x30mm."
	cost = 4000
	contains = list(/obj/item/gun/ballistic/automatic/smg/wt550)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/m90
	name = "M90 Auto Rifle Crate"
	desc = "Contains a gun."
	cost = 4000
	contains = list(/obj/item/gun/ballistic/automatic/smg/m90/unrestricted)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/firestrom
	name = "Firestorm SMG Crate"
	desc = "Contains a gun."
	cost = 3000
	contains = list(/obj/item/gun/ballistic/automatic/smg/firestorm)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/cm5
	name = "CM-5 SMG Crate"
	desc = "Contains a gun."
	cost = 3100
	contains = list(/obj/item/gun/ballistic/automatic/smg/cm5)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/inteq_smg
	name = "SKM-44v Mongrel Crate"
	desc = "Contains a gun."
	cost = 3000
	contains = list(/obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq)
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

/datum/supply_pack/gun/swiss
	name = "Swiss Cheese Crate"
	desc = "Contains a high-powered, automatic rifle chambered in 5.56mm."
	cost = 5000
	contains = list(/obj/item/gun/ballistic/automatic/assault/swiss_cheese)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/skm_lmg
	name = "SKM-24u SAW Crate"
	desc = "Contains a high-powered, light machine gun conversion of the SKM rifle chambered in 7.62x40mm CLIP. The two are priced similarly but are meant for very different roles, choose carefully."
	cost = 6500
	contains = list(/obj/item/gun/ballistic/automatic/hmg/skm_lmg)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/l6_saw
	name = "L6 SAW LMG Crate"
	desc = "Contains a high-powered, light machine gun."
	cost = 9500
	contains = list(/obj/item/gun/ballistic/automatic/hmg/l6_saw)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/cm40
	name = "CM-40 LMG Crate"
	desc = "Contains a high-powered, light machine gun chambered in 7.62x40mm CLIP."
	cost = 8000
	contains = list(/obj/item/gun/ballistic/automatic/hmg/cm40)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/shredder
	name = "Shredder LMG Crate"
	desc = "Contains a frontiersmen made light machine gun chambered in 12g bizzarely enough."
	cost = 7500
	contains = list(/obj/item/gun/ballistic/automatic/hmg/shredder)
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
