/datum/supply_pack/gun
	category = "Guns"
	crate_type = /obj/structure/closet/crate/secure/weapon
	faction_discount = 10

/*
		Pistols
*/

/datum/supply_pack/gun/disposable
	name = "Disposable Gun Crate"
	desc = "In some sectors, these disposable pistols are the only firearms that can be legally sold for less than 200cr. That price is still far too high."
	cost = 300
	contains = list(/obj/item/storage/guncase/pistol/disposable)
	crate_name = "disposable gun crate"

/datum/supply_pack/gun/derringer
	name = ".38 Derringer Crate"
	desc = "A cheap, concealable pistol manufactured by the reputable Hunter's Pride. At least it's better than a disposable pistol. Chambered in .38 rounds."
	cost = 350
	contains = list(/obj/item/storage/guncase/pistol/derringer)
	crate_name = "derringer crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/m17
	name = "M17 Micro Target Pistol Crate"
	desc = "A cheap target shooting pistol manufactured by Serene Outdoors. Chambered in .22 LR."
	cost = 400
	contains = list(/obj/item/storage/guncase/pistol/m17)
	crate_name = "pistol crate"

/datum/supply_pack/gun/m20_auto_elite
	name = "M20 Auto Elite Pistol Crate"
	desc = "Contains a heavy pistol manufactured by Serene Outdoors. Chambered in .44 Roumain."
	cost = 1250
	contains = list(/obj/item/storage/guncase/pistol/m20_auto_elite)
	crate_name = "pistol crate"

/datum/supply_pack/gun/commanders
	name = "PS9 Challenger Pistol Crate"
	desc = "Contains a double stacked Challenger pistol, produced by Nanotrasen Advantage. Chambered in 9x18mm."
	cost = 750
	contains = list(/obj/item/storage/guncase/pistol/commander)
	faction = /datum/faction/nt
	faction_discount = 20

/datum/supply_pack/gun/ringneck
	name = "Ringneck Pistol Crate"
	desc = "Contains a civilian variant of the Ringneck pistol, produced by Scarborough Arms and chambered in 10x22mm."
	cost = 1000
	contains = list(/obj/item/storage/guncase/pistol/ringneck)
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/gun/pc76
	name = "PC-76 'Ringneck' Pistol Crate"
	desc = "Contains a noticably smaller military variant of the Ringneck pistol, chambered in 10x22mm."
	cost = 1250
	contains = list(/obj/item/storage/guncase/pistol/pc76)
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cm23
	name = "CM-23 Pistol Crate"
	desc = "Contains a 10x22mm CM-23 Pistol, standard issue of the Confederated Minutemen."
	cost = 1000
	contains = list(/obj/item/storage/guncase/pistol/cm23)
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cm70
	name = "CM-70 Machinepistol Crate"
	desc = "Contains a 9x18mm machinepistol produced proudly within Lanchester City. Confederated Minuteman issue only."
	cost = 2500
	contains = list(/obj/item/storage/guncase/pistol/cm70)
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/commissioner
	name = "Commissioner Pistol Crate"
	desc = "Contains a modified Commander pistol, adjusted to fit the IRMG's standards and painted in the brown and gold of all IRMG firearms."
	cost = 750
	contains = list(/obj/item/storage/guncase/commissioner)
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/candors
	name = "Candor Pistol Crate"
	desc = "Contains a Candor pistol, the trusty sidearm of any spacer, produced by Hunter's Pride and chambered in .45 ACP."
	cost = 1000
	contains = list(/obj/item/storage/guncase/pistol/candor)
	faction = /datum/faction/srm

/datum/supply_pack/gun/asp
	name = "BC-81 'Asp' Crate"
	desc = "Contains a compact armor-piercing sidearm, chambered in 5.7mm"
	cost = 1250
	contains = list(/obj/item/storage/guncase/pistol/asp)
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/podium
	name = "Advantage PH46 Podium Crate"
	desc = "Contains a compact armor-piercing sidearm, chambered in 4.6mm. For NT employee use only."
	cost = 1250
	contains = list(/obj/item/storage/guncase/pistol/podium)
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/podium_inteq
	name = "P46 Schnauzer"
	desc = "Contains a compact armor-piercing sidearm, chambered in 4.6mm."
	cost = 1250
	contains = list(/obj/item/storage/guncase/pistol/podium_inteq)
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/pistolec
	name = "Pistole 'C' Crate"
	desc = "Contains a compact solarian-produced sidearm, chambered in 5.56mm HITP. Not to be confused with 5.56x42 CLIP."
	cost = 1000
	contains = list(/obj/item/storage/guncase/pistol/pistolec)
	faction = /datum/faction/solgov
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/modelh
	name = "Model 'H' Gauss Pistol Crate"
	desc = "Contains a compact solarian-produced gauss pistol, chambered in ferromagnetic slugs. Remember to sign your necessary forms upon arrival."
	cost = 2000
	contains = list(/obj/item/storage/guncase/pistol/modelh)
	faction = /datum/faction/solgov
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/pepperbox
	name = "HP Firebrand Pepperbox Revolver Crate"
	desc = "Contains a concealable pepperbox revolver manufactured by the Saint Roumain Militia, chambered in .357."
	cost = 700
	contains = list(/obj/item/storage/guncase/pistol/firebrand)
	faction = /datum/faction/srm

/datum/supply_pack/gun/detrevolver
	name = "Hunter's Pride Detective Revolver Crate"
	desc = "Contains a concealable revolver favored by police departments around the sector, chambered in .38."
	cost = 600
	contains = list(/obj/item/storage/guncase/pistol/detective)
	faction = /datum/faction/srm

/datum/supply_pack/gun/shadowrevolver
	name = "Shadow Revolver Crate"
	desc = "Contains a concealable Shadow revolver, chambered in .44 Roumain."
	cost = 1000
	contains = list(/obj/item/storage/guncase/pistol/shadow)
	faction = /datum/faction/srm

/datum/supply_pack/gun/viperrevolver
	name = "Viper-23 Revolver Crate"
	desc = "Contains a civilian variant of the Viper revolver, chambered in .357 magnum."
	cost = 1500
	contains = list(/obj/item/storage/guncase/pistol/viper)
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 5

/datum/supply_pack/gun/a357
	name = "R-23 'Viper' Revolver Crate"
	desc = "Contains a double-action military variant of the Viper revolver, chambered in .357 magnum."
	cost = 1750
	contains = list(/obj/item/storage/guncase/pistol/a357)
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/rhino
	name = "Rhino Revolver Crate"
	desc = "Contains a double-action Rhino Revolver, chambered in .357 magnum."
	cost = 1750
	contains = list(/obj/item/storage/guncase/pistol/rhino)
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/ashhand
	name = "Ashhand Hunting Revolver Crate"
	desc = "Contains a single-action .45-70 hunting revolver manufactured by Hunter's Pride for use against the biggest game."
	cost = 3500
	contains = list(/obj/item/storage/guncase/pistol/ashhand)
	faction = /datum/faction/srm
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cm357
	name = "CM-357 Automag Pistol Crate"
	desc = "Contains a magazine-fed .357 handgun, produced for the CLIP-BARD division and available for requisition in small numbers to the Minutemen."
	cost = 3000
	contains = list(/obj/item/storage/guncase/pistol/cm357)
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/*
		Energy
*/

/datum/supply_pack/gun/l201
	name = "L201 'Surge' Marksman Plasma Rifle"
	desc = "Contains a high-powered marksman laser. For NT employee use only."
	cost = 3500
	contains = list(/obj/item/storage/guncase/energy/l201)
	crate_name = "dmr crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/l204
	name = "L204 'Resistor' Plasma Rifle Crate"
	desc = "Contains a lethal, high-energy laser gun."
	cost = 2000
	contains = list(/obj/item/storage/guncase/energy/laser)
	crate_name = "laser crate"
	faction = /datum/faction/nt

/datum/supply_pack/gun/mini_energy
	name = "X26 'Ohm' Variable Energy Pistol Crate"
	desc = "Contains a small, versatile energy gun, capable of firing both nonlethal and lethal blasts."
	cost = 800
	contains = list(/obj/item/storage/guncase/pistol/miniegun)
	crate_name = "laser crate"
	faction_discount = 20
	faction = /datum/faction/nt

/datum/supply_pack/gun/energy
	name = "X12 'Volt' Variable Energy Carbine Crate"
	desc = "Contains a versatile energy gun, capable of firing both nonlethal and lethal blasts of light."
	cost = 1250
	contains = list(/obj/item/storage/guncase/energy/egun)
	crate_name = "energy gun crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	faction = /datum/faction/nt

/datum/supply_pack/gun/scatterlaser
	name = "Scatter Laser Crate"
	desc = "Contains a multi-function scatter energy gun, capable of firing armour penetrating slugs, and devastating scattered laser bolts."
	cost = 1250
	contains = list(/obj/item/gun/energy/laser/scatter)
	crate_name = "scatter laser crate"

/datum/supply_pack/gun/ion
	name = "Ion Rifle Crate"
	desc = "Contains a single Mk.I Ion Projector, a special anti-tank rifle designed to disable electronic threats at range."
	cost = 3500
	contains = list(/obj/item/storage/guncase/energy/iongun)
	crate_name = "ion rifle crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	faction = /datum/faction/nt

/datum/supply_pack/gun/laser/kalix/pistol
	name = "Etherbor SG-8 Beam Pistol Crate"
	desc = "Contains a single SG-8 Beam Pistol, a civilian-grade sidearm developed in the PGF, manufactured by Etherbor Industries."
	cost = 1000
	contains = list(/obj/item/storage/guncase/pistol/kalixpistol)
	crate_name = "beam pistol crate"
	faction = /datum/faction/pgf

/datum/supply_pack/gun/laser/kalix
	name = "Etherbor BG-12 Beam Gun Crate"
	desc = "Contains a single BG-12 Beam Gun, a civilian-grade semi-automatic developed in the PGF, manufactured by Etherbor Industries."
	cost = 3000
	contains = list(/obj/item/storage/guncase/energy/kalixrifle)
	crate_name = "beam gun crate"
	faction = /datum/faction/pgf

/datum/supply_pack/gun/laser/kalix/nock
	name = "Etherbor VG-F3 Beam Volleygun Crate"
	desc = "Contains a single VG-F3 Beam Volleygun, a civilian-grade volleygun developed in the PGF, manufactured by Etherbor Industries."
	cost = 3000
	contains = list(/obj/item/storage/guncase/energy/kalixnock)
	crate_name = "beam volleygun crate"
	faction = /datum/faction/pgf

/datum/supply_pack/gun/laser/vga5
	name = "Etherbor VG-A5 Beam Volleygun Crate"
	desc = "Contains a single VG-A5 Beam Volleygun, a military-grade volleygun developed in the PGF and manufactured by Etherbor Industries for use within the Marine Corps."
	cost = 4000
	contains = list(/obj/item/storage/guncase/energy/vga5)
	crate_name = "beam volleygun crate"
	faction = /datum/faction/pgf
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/laser/bg16
	name = "Etherbor BG-16 Beam Gun Crate"
	desc = "Contains a single BG-16 Beam Gun, a military-grade automatic developed in the PGF and manufactured by Etherbor Industries for use within the Marine Corps."
	cost = 3000
	contains = list(/obj/item/storage/guncase/energy/bg16)
	crate_name = "beam gun crate"
	faction = /datum/faction/pgf
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/laser/bgc10
	name = "Etherbor BGC-10 Beam Carbine Crate"
	desc = "Contains a single BGC-10 Beam Carbine, an intermediate military-grade automatic developed in the PGF and manufactured by Etherbor Industries for use within the Marine Corps."
	cost = 5000
	contains = list(/obj/item/storage/guncase/energy/bgc10)
	crate_name = "beam carbine crate"
	faction = /datum/faction/pgf
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/ecm6
	name = "ECM-6 Beam Gun Crate"
	desc = "Contains an ECM-6 Beam Gun, a modernization of the ECM-1 manufactured by Clover Photonics for Minutemen use."
	cost = 1500
	contains = list(/obj/item/storage/guncase/ecm6)
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/energy/disabler
	name = "Disabler Crate"
	desc = "One stamina-draining disabler weapon, for use in non-lethal pacification."
	cost = 1000
	contains = list(/obj/item/gun/energy/disabler)
	crate_name = "disabler crate"
	faction = /datum/faction/nt

/datum/supply_pack/gun/energy/taser
	name = "Hybrid Taser Crate"
	desc = "Contains one disabler-taser hybrid weapon."
	cost = 1250
	contains = list(/obj/item/gun/energy/e_gun/advtaser)
	crate_name = "hybrid taser crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/energy/cadejo
	name = "PP10 'Cadejo' Energy Carbine"
	desc = "Contains one refitted Sharplite X12 carbine, for IRMG use. Uses sharplite cells."
	cost = 1250
	contains = list(/obj/item/storage/guncase/cadejo)
	crate_name = "beam carbine crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/*
		Shotguns
*/

/datum/supply_pack/gun/doublebarrel_shotgun
	name = "Double Barrel Shotgun Crate"
	desc = "For when you need to deal with 2 drunkards the old-fashioned way. Contains a double-barreled shotgun, favored by Bartenders. Warranty voided if sawed off."
	cost = 1000
	contains = list(/obj/item/storage/guncase/doublebarrel)
	crate_name = "shotgun crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/conflagration
	name = "Conflagration Lever Action Shotgun Crate"
	desc = "For when you need to deal with 6 hooligans and look good doing it. Contains one lever-action shotgun, with a 6 round capacity."
	cost = 1500
	contains = list(/obj/item/storage/guncase/conflagration)
	crate_name = "shotgun crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/hellfire_shotgun
	name = "Hellfire Shotgun Crate"
	desc = "For when you need to deal with a riot's worth of hooligans. Contains a pump shotgun, with a 9-round capacity."
	cost = 2000
	contains = list(/obj/item/storage/guncase/hellfire)
	crate_name = "shotgun crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/brimstone_shotgun
	name = "Brimstone Shotgun Crate"
	desc = "For when you need to deal with 5 hooligans, and QUICKLY. Contains a slamfire shotgun, with a 5-round capacity. Warranty voided if sawed off."
	cost = 2000
	contains = list(/obj/item/storage/guncase/brimstone)
	crate_name = "shotgun crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/buckmaster
	name = "Buckmaster Shotgun Crate"
	desc = "For when you need to deal with 7 hooligans and can't be arsed to pump. Contains a semi-auto shotgun with a 7-round capacity."
	contains = list(/obj/item/storage/guncase/buckmaster)
	cost = 3000
	crate_name = "shotgun crate"

/datum/supply_pack/gun/slammer
	name = "Slammer Shotgun Crate"
	desc = "For when you need to deal with a 6-hooligan riot. Contains a mag-fed pump shotgun, with a 6-round capacity."
	cost = 3000
	contains = list(/obj/item/storage/guncase/slammer)
	crate_name = "shotgun crate"

/datum/supply_pack/gun/bulldog
	name = "Bulldog Shotgun Crate"
	desc = "An automatic shotgun chambered in 12ga produced by Scarborough Arms for exclusive use by licensed buyers. Comes with 8-round box magazines."
	contains = list(/obj/item/storage/guncase/bulldog)
	cost = 4000
	crate_name = "shotgun crate"
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/mastiff
	name = "Mastiff Shotgun Crate"
	desc = "An automatic shotgun modified for exclusive use by the IRMG and chambered in 12ga. Comes with 8-round box magazines."
	contains = list(/obj/item/storage/guncase/mastiff)
	cost = 4000
	crate_name = "shotgun crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cm15
	name = "CM-15 Shotgun Crate"
	desc = "A combat shotgun produced by Lanchester Arms Co. for the Confederated Minutemen and CLIP-BARD for use in CQC operations. Chambered in 12ga and equipped with 8-round box magazines."
	contains = list(/obj/item/storage/guncase/cm15)
	cost = 4000
	crate_name = "shotgun crate"
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/x46
	name = "X46 'Amperage' Variable Energy Blaster Crate"
	desc = "Contains an energy-based shotgun equipped with dual kill/disable modes, ideal for short range. For NT employee use only."
	cost = 3000
	contains = list(/obj/item/storage/guncase/energy/ultima)
	crate_name = "shotgun crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cycler
	name = "Advantage AST12 Negotiator"
	desc = "Contains an advanced shotgun with five round dual magazine tubes. For NT employee use only."
	cost = 3500
	contains = list(/obj/item/storage/guncase/cycler)
	crate_name = "shotgun crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/*
		SMGs
*/

/datum/supply_pack/gun/cobra20
	name = "Cobra-20 SMG Crate"
	desc = "Contains a civilian variant of the Cobra SMG, manufactured by Scaraborough Arms and chambered in .45"
	cost = 3000
	contains = list(/obj/item/storage/guncase/cobra)
	crate_name = "SMG crate"
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 10

/datum/supply_pack/gun/c20r
	name = "C-20r 'Cobra' SMG Crate"
	desc = "Contains a military variant of the Cobra SMG, chambered in .45 with an integrated suppressor."
	cost = 2800 // 100 more than the civ variant (counting it's discount), because they are literally the same right now.
	contains = list(/obj/item/storage/guncase/c20r)
	crate_name = "SMG crate"
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/expedition
	name = "SGL9 Expedition SMG Crate"
	desc = "Contains a Expidition SMG produced by Nanotrasen Advantage. Chambered in 9x18mm."
	cost = 3000
	contains = list(/obj/item/storage/guncase/vector)
	crate_name = "SMG crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/mongrel
	name = "SKM-44v Mongrel SMG Crate"
	desc = "Contains a shortened variant of the SKM rechambered to 10x22mm and painted in the brown-and-gold of Inteq."
	cost = 3000
	contains = list(/obj/item/storage/guncase/mongrel)
	crate_name = "SMG crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/resolution
	name = "PD46 Resolution PDW Crate"
	desc = "Contains a compact automatic personal defense weapon chambered in 4.6x30mm."
	cost = 3000
	contains = list(/obj/item/storage/guncase/wt550)
	crate_name = "PDW crate"
	faction_discount = 10
	faction = /datum/faction/nt

/datum/supply_pack/gun/bdm50
	name = "BDM-50 'Akita' PDW Crate"
	desc = "Contains a compact Automatic personal defense weapon chambered in 4.6x30mm, in use by the IRMG."
	cost = 3000
	contains = list(/obj/item/storage/guncase/bdm50)
	crate_name = "PDW crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/champion
	name = "PHB Champion Machinepistol Crate"
	desc = "Contains a compact 9x18mm burst fire machine pistol produced by Nanotrasen advantage. For NT employee use only."
	cost = 2500
	contains = list(/obj/item/storage/guncase/saber)
	crate_name = "Machinepistol crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/l305
	name = "L305 'Rush' Tactical Plasma Gun Crate"
	desc = "Contains a compact energy-based SMG. For NT employee use only."
	cost = 2000
	contains = list(/obj/item/storage/guncase/energy/etar)
	crate_name = "SMG crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/firestorm
	name = "Firestorm SMG Crate"
	desc = "Contains a Hunter's Pride SMG, intended for internal use by hunters and chambered in .44 Roumain."
	cost = 3000
	contains = list(/obj/item/storage/guncase/firestorm)
	crate_name = "SMG crate"
	faction = /datum/faction/srm
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/rattlesnake
	name = "Rattlesnake Machinepistol Crate"
	desc = "Contains an automatic machinepistol produced by Scarborough Arms, chambered in 9x18mm."
	cost = 2500
	contains = list(/obj/item/storage/guncase/rattlesnake)
	crate_name = "Machinepistol crate"
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/kingsnake
	name = "Kingsnake Machinepistol Crate"
	desc = "Contains an automatic machinepistol chambered in 9x18mm, painted in the brown-and-gold of Inteq."
	cost = 2500
	contains = list(/obj/item/storage/guncase/kingsnake)
	crate_name = "Machinepistol crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cm5
	name = "CM-5 SMG Crate"
	desc = "Contains a CM-5 automatic SMG, produced proudly within Lanchester City. Confederated Minutemen issue only."
	cost = 2500
	contains = list(/obj/item/storage/guncase/cm5)
	crate_name = "SMG crate"
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/sidewinder
	name = "Sidewinder SMG Crate"
	desc = "Contains a Sidewinder PDW produced by Scarborough Arms and chambered in 5.7mm for armor-piercing capabilities."
	cost = 3000
	contains = list(/obj/item/storage/guncase/sidewinder)
	crate_name = "SMG crate"
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/*
		Rifles
*/

/datum/supply_pack/gun/m12
	name = "Sporter Rifle Crate"
	desc = "Contains a recently manufactured Model 12 \"Sporter\", Serene Outdoors' premier small game rifle. Chambered in .22lr"
	contains = list(/obj/item/storage/guncase/m12)
	cost = 500
	crate_name = "rifle crate"

/datum/supply_pack/gun/m15
	name = "Super Sporter Rifle Crate"
	desc = "Contains a recently manufactured Model 15 \"Super Sporter\", Serene Outdoors' premier hunting rifle. Chambered in 5.56 CLIP"
	contains = list(/obj/item/storage/guncase/m15)
	cost = 2500
	crate_name = "rifle crate"

/datum/supply_pack/gun/winchester
	name = "Flaming Arrow Lever Action Rifle Crate"
	desc = "Contains an antiquated lever action rifle intended for hunting wildlife. Chambered in .38 rounds."
	cost = 750
	contains = list(/obj/item/storage/guncase/winchester)
	crate_name = "rifle crate"
	faction = /datum/faction/srm
	faction_discount = 20

/datum/supply_pack/gun/absolution
	name = "Absolution Lever Action Rifle Crate"
	desc = "Contains a powerful lever-action rifle for hunting larger wildlife. Chambered in .357."
	cost = 2000
	contains = list(/obj/item/storage/guncase/absolution)
	crate_name = "shotguns crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/illestren
	name = "Illestren Rifle Crate"
	desc = "Contains an expertly made bolt action rifle intended for hunting wildlife. Chambered in 8x50mmR rounds."
	cost = 1250
	contains = list(/obj/item/storage/guncase/illestren)
	crate_name = "rifle crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/beacon
	name = "Beacon Break Action Rifle Crate"
	desc = "Contains a single shot break action rifle to hunt wildlife that annoys you in particular. Chambered in devastating .45-70 rounds. Warranty voided if sawed off."
	cost = 1000
	contains = list(/obj/item/storage/guncase/beacon)
	crate_name = "rifle crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/skm
	name = "SKM-24 Rifle Crate"
	desc = "Contains a high-powered, automatic rifle chambered in 7.62x40mm CLIP."
	cost = 5000
	contains = list(/obj/item/storage/guncase/skm)
	crate_name = "auto rifle crate"

/datum/supply_pack/gun/inteq_skm
	name = "SKM-44 Rifle Crate"
	desc = "Contains a SKM painted in the brown-and-gold of Inteq, chambered in 7.62x40mm CLIP. "
	cost = 5000
	contains = list(/obj/item/storage/guncase/skm_inteq)
	crate_name = "auto rifle crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/gar
	name = "Solarian 'GAR' Automatic Rifle"
	desc = "A modern solarian military rifle, chambered in ferromagnetic lances. Not for export."
	cost = 5000
	contains = list(/obj/item/storage/guncase/gar)
	crate_name = "auto rifle crate"
	faction = /datum/faction/solgov
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/hades
	name = "AL655 Assault Plasma Rifle crate"
	desc = "Contains a high-energy, automatic laser rifle. For NT employee use only."
	cost = 5000
	contains = list(/obj/item/storage/guncase/hades)
	crate_name = "laser crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/barghest
	name = "PP20 'Barghest' APR Crate"
	desc = "Contains a high-energy, automatic laser rifle. Refitted for IRMG use."
	cost = 5000
	contains = list(/obj/item/storage/guncase/barghest)
	crate_name = "laser crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/hydra
	name = "SMR-80 'Hydra' Automatic Rifle Crate"
	desc = "Contains a high-powered automatic rifle produced by Scarborough Arms and chambered in 5.56 CLIP. This one is a standard variant."
	cost = 5000
	contains = list(/obj/item/storage/guncase/hydra)
	crate_name = "rifle crate"
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cm82
	name = "CM-82 Standard Issue Rifle"
	desc = "Contains a high-powered rifle chambered in 5.56 CLIP, standard issue of the Confederated Minutemen."
	cost = 5000
	contains = list(/obj/item/storage/guncase/cm82)
	crate_name = "rifle crate"
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cm24
	name = "CM-24 Surplus Stockpile Rifle"
	desc = "Contains a higher-powered rifle chambered in 7.62x40 CLIP based on the SKM-24 platform, formerly the main service rifle of the CMM. This one has been pulled from reservist stockpiles."
	cost = 5000
	contains = list(/obj/item/storage/guncase/cm24)
	crate_name = "rifle crate"
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/* Heavy */

/datum/supply_pack/gun/cm40
	name = "CM-40 Squad Automatic Weapon"
	desc = "Contains a CM-40 Squad Automatic Weapon, a CLIP-produced LMG for Minuteman usage in situations that require heavy firepower. For Minuteman use only."
	cost = 6000
	contains = list(/obj/item/storage/guncase/cm40)
	crate_name = "LMG crate"
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/saw80
	name = "SAW-80 Squad Automatic Weapon"
	desc = "Contains one of the rarely-produced SAW-80 Squad Automatic Weapon platforms, exclusively for licensed buyers. Remember, short controlled bursts!"
	cost = 7000
	contains = list(/obj/item/storage/guncase/saw80)
	crate_name = "LMG crate"
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/rottweiler
	name = "KM-05 Rottweiler Squad Automatic Weapon"
	desc = "Contains an extensively modified belt fed machine gun, built for special IRMG operations. Bulky and cumbersome, this weapon is chambered in the powerful .308 cartridge."
	cost = 6000
	contains = list(/obj/item/storage/guncase/rottweiler)
	crate_name = "LMG crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/* Marksman Rifles */

/datum/supply_pack/gun/cmf4
	name = "CM-F4 Designated Marksman Rifle"
	desc = "Contains a high-powered marksman rifle chambered in .308. For Confederated Minutemen issue only."
	cost = 3500
	contains = list(/obj/item/storage/guncase/cmf4)
	crate_name = "dmr crate"
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/ssg04
	name = "SsG-04 Designated Marksman Rifle"
	desc = "Contains a high-powered marksman rifle chambered in .308. Painted in the brown-and-gold of Inteq."
	cost = 3500
	contains = list(/obj/item/storage/guncase/ssg04)
	crate_name = "dmr crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/sbr80
	name = "SBR-80 'Hydra' Designated Marksman Rifle Crate"
	desc = "Contains a high-powered marksman rifle chambered in 5.56 CLIP and produced by Scarborough Arms. A modification of the ever-popular SMR-80 platform."
	cost = 4500
	contains = list(/obj/item/storage/guncase/sbr80)
	crate_name = "dmr crate"
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/woodsman
	name = "Model 23 'Woodsman' Hunting Rifle"
	desc = "Contains a semi-automatic hunting rifle chambered in 8x50mmR and produced by Serene Outdoors. Come with three magazines with a 5-round capacity."
	cost = 3500
	contains = list(/obj/item/storage/guncase/woodsman)
	crate_name = "hunting rifle crate"

/datum/supply_pack/gun/vickland
	name = "Vickland Battle Rifle"
	desc = "Contains a high-powered semi-automatic battle rifle chambered in 8x50mmR and produced by Hunter's Pride. Fed via stripper clips with a 10 round capacity."
	cost = 3500
	contains = list(/obj/item/storage/guncase/vickland)
	crate_name = "dmr crate"
	faction = /datum/faction/srm
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/invictus
	name = "Invictus Automatic Rifle"
	desc = "Contains a high-powered automattic rifle chambered in .308 and produced by Hunter's Pride. Comes with two magazines with a 20 round capacity."
	cost = 5500
	contains = list(/obj/item/storage/guncase/invictus)
	crate_name = "rifle crate"
	faction = /datum/faction/srm
	faction_discount = 0
	faction_locked = TRUE

//turn into l201
/*
/datum/supply_pack/gun/gauss
	name = "Prototype Gauss Rifle"
	desc = "Contains a high-powered prototype armor-piercing gauss rifle, operable with ferromagnetic pellets. For NT employee use only."
	cost = 3500
	contains = list(/obj/item/storage/guncase/gauss)
	crate_name = "dmr crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE
*/

/datum/supply_pack/gun/claris
	name = "Claris Gauss Rifle"
	desc = "Contains a high-powered armor-piercing gauss rifle, loaded directly via ferromagnetic pellet speedloaders."
	cost = 2500
	contains = list(/obj/item/storage/guncase/claris)
	crate_name = "dmr crate"
	faction = /datum/faction/solgov
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/boomslang90
	name = "Boomslang-90 Designated Marksman Rifle Crate"
	desc = "Contains a civilian variant of the Boomslang Sniper rifle- modified with a 2x scope, rather than a sniper scope. Chambered in the powerful 6.5mm CLIP cartridge."
	cost = 3500
	contains = list(/obj/item/storage/guncase/boomslang)
	crate_name = "dmr crate"
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/gun/boomslang10
	name = "MSR-90 'Boomslang' Sniper Rifle Crate"
	desc = "Contains a military variant of the Boomslang Sniper rifle equipped with an 8x sniper scope, for licenesed buyers only. Chambered in the powerful 6.5mm CLIP cartridge."
	cost = 4500
	contains = list(/obj/item/storage/guncase/boomslangmilitary)
	crate_name = "marksman rifle crate"
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/f90
	name = "CM-F90 Sniper Rifle Crate"
	desc = "Contains a military sniper rifle equipped with an 8x sniper scope, for Minuteman use only. Chambered in the powerful 6.5mm CLIP cartridge."
	cost = 4000
	contains = list(/obj/item/storage/guncase/cmf90)
	crate_name = "marksman rifle crate"
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/al607
	name = "AL607 'Sarissa' Plasma Accelerator"
	desc = "Contains a AL607 Laser Sniper. For NT employee use only."
	cost = 4500
	contains = list(/obj/item/storage/guncase/energy/al607)
	crate_name = "sniper rifle crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/saluki
	name = "SSG-08 Saluki Sniper Rifle Crate"
	desc = "Contains a military sniper rifle equipped with an 8x sniper scope, fitted by the Inteq Artificer Division. Chambered in the powerful 6.5mm CLIP cartridge."
	cost = 4000
	contains = list(/obj/item/storage/guncase/saluki)
	crate_name = "marksman rifle crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/scout
	name = "Scout Sniper Rifle Crate"
	desc = "Contains a traditional scoped rifle to hunt wildlife and big game from a respectful distance. Chambered in powerful .300 Magnum."
	cost = 4000
	contains = list(/obj/item/storage/guncase/scout)
	crate_name = "sniper rifle crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/ssg669
	name = "SSG-669C Sniper Rifle Crate"
	desc = "Contains a traditional solarian marksman rifle chambered in 8x58mm Caseless."
	cost = 4000
	contains = list(/obj/item/storage/guncase/ssg669)
	crate_name = "sniper rifle crate"
	faction = /datum/faction/solgov
	faction_discount = 0
	faction_locked = TRUE
