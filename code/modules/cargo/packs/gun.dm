/datum/supply_pack/gun
	group = "Guns"
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
	name = "M17 pistol Crate"
	desc = "A cheap target shooting pistol manufactured by Serene Outdoors. Chambered in .22lr"
	cost = 400
	contains = list(/obj/item/storage/guncase/pistol/m17)
	crate_name = "pistol crate"

/datum/supply_pack/gun/commanders
	name = "Commander Pistol Crate"
	desc = "Contains a modified Candor 'Commander' pistol, produced by Nanotrasen and chambered in 9mm."
	cost = 750
	contains = list(/obj/item/storage/guncase/pistol/commander)
	faction = /datum/faction/nt

/datum/supply_pack/gun/ringneck
	name = "Ringneck Pistol Crate"
	desc = "Contains a civilian variant of the Ringneck pistol, produced by Scarborough Arms and chambered in 10mm."
	cost = 1000
	contains = list(/obj/item/storage/guncase/pistol/ringneck)
	faction = /datum/faction/scarborough_arms

/datum/supply_pack/gun/cm23
	name = "CM-23 Pistol Crate"
	desc = "Contains a 10mm CM-23 Pistol, standard issue of the Colonial Minutemen."
	cost = 1000
	contains = list(/obj/item/storage/guncase/pistol/cm23)
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cm70
	name = "CM-70 Machinepistol Crate"
	desc = "Contains a 9mm machinepistol produced proudly within Lanchester City. Colonial Minuteman issue only."
	cost = 2500
	contains = list(/obj/item/storage/guncase/pistol/cm70)
	faction = /datum/faction/clip
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
	cost = 3000
	contains = list(/obj/item/storage/guncase/pistol/asp)
	faction = /datum/faction/scarborough_arms
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/pepperbox
	name = "HP Firebrand Pepperbox Revolver Crate"
	desc = "Contains a concealable pepperbox revolver manufactured by the Saint Roumain Militia, chambered in .357."
	cost = 1250
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
	cost = 2500
	contains = list(/obj/item/storage/guncase/pistol/viper)
	faction = /datum/faction/scarborough_arms
	faction_discount = 5

/datum/supply_pack/gun/a357
	name = "R-23 'Viper' Revolver Crate"
	desc = "Contains a double-action military variant of the Viper revolver, chambered in .357 magnum."
	cost = 3000
	contains = list(/obj/item/storage/guncase/pistol/a357)
	faction = /datum/faction/scarborough_arms
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

/*
		Energy
*/

/datum/supply_pack/gun/laser
	name = "Laser Gun Crate"
	desc = "Contains a lethal, high-energy laser gun."
	cost = 1000
	contains = list(/obj/item/storage/guncase/energy/laser)
	crate_name = "laser crate"

/datum/supply_pack/gun/mini_energy
	name = "Mini Energy Gun Crate"
	desc = "Contains a small, versatile energy gun, capable of firing both nonlethal and lethal blasts, but with a limited power cell."
	cost = 500
	contains = list(/obj/item/storage/guncase/pistol/miniegun)
	crate_name = "laser crate"

/datum/supply_pack/gun/energy
	name = "Energy Gun Crate"
	desc = "Contains a versatile energy gun, capable of firing both nonlethal and lethal blasts of light."
	cost = 1250
	contains = list(/obj/item/storage/guncase/energy/egun)
	crate_name = "energy gun crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/gun/ion
	name = "Ion Rifle Crate"
	desc = "Contains a single Mk.I Ion Projector, a special anti-tank rifle designed to disable electronic threats at range."
	cost = 10000
	contains = list(/obj/item/storage/guncase/energy/iongun)
	crate_name = "ion rifle crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/gun/laser/kalix/pistol
	name = "Etherbor SG-8 Beam Pistol Crate"
	desc = "Contains a single SG-8 Beam Pistol, a civilian-grade sidearm developed in the PGF, manufactured by Etherbor Industries."
	cost = 1000
	contains = list(/obj/item/storage/guncase/pistol/kalixpistol)
	crate_name = "beam pistol crate"

/datum/supply_pack/gun/laser/kalix
	name = "Etherbor BG-12 Beam Rifle Crate"
	desc = "Contains a single BG-12 Beam Rifle, a civilian-grade semi-automatic developed in the PGF, manufactured by Etherbor Industries."
	cost = 3000
	contains = list(/obj/item/storage/guncase/energy/kalixrifle)
	crate_name = "beam rifle crate"

/datum/supply_pack/gun/laser/bg16
	name = "Etherbor BG-16 Beam Rifle Crate"
	desc = "Contains a single BG-16 Beam Rifle, a military-grade automatic developed in the PGF and manufactured by Etherbor Industries for use within the Marine Corps."
	cost = 3000
	contains = list(/obj/item/storage/guncase/energy/bg16)
	crate_name = "beam rifle crate"
	faction = /datum/faction/pgf
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
	crate_name = "shotguns crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/conflagration
	name = "Conflagration Lever Action Shotgun Crate"
	desc = "For when you need to deal with 6 hooligans and look good doing it. Contains one lever-action shotgun, with a 6 round capacity."
	cost = 1500
	contains = list(/obj/item/storage/guncase/conflagration)
	crate_name = "shotguns crate"

/datum/supply_pack/gun/hellfire_shotgun
	name = "Hellfire Shotgun Crate"
	desc = "For when you need to deal with 8 hooligans. Contains a pump shotgun, with a 8-round capacity."
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
	desc = "For when you need to deal with 8 hooligans and can't be arsed to pump. Contains a semi-auto shotgun with an 8 round tube."
	contains = list(/obj/item/storage/guncase/buckmaster)
	cost = 3000
	crate_name = "shotgun crate"

/datum/supply_pack/gun/bulldog
	name = "Bulldog Shotgun Crate"
	desc = "An automatic shotgun chambered in 12ga produced by Scarborough Arms for exclusive use by licensed buyers. Comes with 8-round box magazines."
	contains = list(/obj/item/storage/guncase/bulldog)
	cost = 4000
	crate_name = "shotgun crate"
	faction = /datum/faction/scarborough_arms
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
	desc = "A combat shotgun produced by Lanchester Arms Co. for the Colonial Minuteman and CMM-BARD for use in CQC operations. Chambered in 12ga and equipped with 8-round box magazines."
	contains = list(/obj/item/storage/guncase/cm15)
	cost = 4000
	crate_name = "shotgun crate"
	faction = /datum/faction/clip
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
	faction = /datum/faction/scarborough_arms
	faction_discount = 10

/datum/supply_pack/gun/mongrel
	name = "SKM-44v Mongrel SMG Crate"
	desc = "Contains a shortened variant of the SKM rechambered to 10mm and painted in the brown-and-gold of Inteq."
	cost = 3000
	contains = list(/obj/item/storage/guncase/mongrel)
	crate_name = "SMG crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/wt550
	name = "WT-550 Auto Rifle Crate"
	desc = "Contains a high-powered, automatic personal defense weapon chambered in 4.6x30mm."
	cost = 4000
	contains = list(/obj/item/storage/guncase/wt550)
	crate_name = "auto rifle crate"
	faction_discount = 10
	faction = /datum/faction/nt

/datum/supply_pack/gun/saber
	name = "SABR Prototype SMG Crate"
	desc = "Contains a compact 9mm automatic SMG produced by NT Ballistics. For NT employee use only."
	cost = 2500
	contains = list(/obj/item/storage/guncase/saber)
	crate_name = "SMG crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/firestorm
	name = "Firestorm SMG Crate"
	desc = "Contains a Hunter's Pride SMG, intended for internal use by hunters and chambered in .45"
	cost = 3000
	contains = list(/obj/item/storage/guncase/firestorm)
	crate_name = "SMG crate"
	faction = /datum/faction/srm
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/rattlesnake
	name = "Rattlesnake Machinepistol Crate"
	desc = "Contains an automatic machinepistol produced by Scarborough Arms, chambered in 9mm."
	cost = 2500
	contains = list(/obj/item/storage/guncase/rattlesnake)
	crate_name = "Machinepistol crate"
	faction = /datum/faction/scarborough_arms
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/kingsnake
	name = "Kingsnake Machinepistol Crate"
	desc = "Contains an automatic machinepistol chambered in 9mm, painted in the brown-and-gold of Inteq."
	cost = 2500
	contains = list(/obj/item/storage/guncase/kingsnake)
	crate_name = "Machinepistol crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cm5
	name = "CM-5 SMG Crate"
	desc = "Contains a CM-5 automatic SMG, produced proudly within Lanchester City. Colonial Minuteman issue only."
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
	faction = /datum/faction/scarborough_arms
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

/datum/supply_pack/gun/absolution
	name = "Absolution Lever Action Rifle Crate"
	desc = "Contains a powerful lever-action rifle for hunting larger wildlife. Chambered in .357."
	cost = 2000
	contains = list(/obj/item/storage/guncase/absolution)
	crate_name = "shotguns crate"

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
	cost = 2250
	contains = list(/obj/item/storage/guncase/beacon)
	crate_name = "rifle crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/scout
	name = "Scout Sniper Rifle Crate"
	desc = "Contains a traditional scoped rifle to hunt wildlife and big game from a respectful distance. Chambered in powerful .300 Magnum."
	cost = 4000
	contains = list(/obj/item/storage/guncase/scout)
	crate_name = "rifle crate"
	faction = /datum/faction/srm

/datum/supply_pack/gun/gauss
	name = "Prototype Gauss Rifle"
	desc = "Contains a high-powered prototype armor-piercing gauss rifle. For NT employee use only."
	cost = 3500
	contains = list(/obj/item/storage/guncase/gauss)
	crate_name = "rifle crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/boomslang90
	name = "Boomslang-90 Rifle Crate"
	desc = "Contains a civilian variant of the Boomslang Sniper rifle- modified with a 2x scope, rather than a sniper scope. Chambered in the powerful 6.5x57mm CLIP."
	cost = 5000
	contains = list(/obj/item/storage/guncase/boomslang)
	crate_name = "rifle crate"

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

/datum/supply_pack/gun/hades
	name = "SL AL-655 'Hades' energy rifle"
	desc = "Contains a high-energy, automatic laser rifle. For NT employee use only."
	cost = 5000
	contains = list(/obj/item/storage/guncase/hades)
	crate_name = "laser crate"
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/hydra
	name = "SMR-80 'Hydra' Automatic Rifle Crate"
	desc = "Contains a high-powered automatic rifle produced by Scarborough Arms and chambered in 5.56 CLIP. This one is a standard variant."
	cost = 5000
	contains = list(/obj/item/storage/guncase/hydra)
	crate_name = "rifle crate"
	faction = /datum/faction/scarborough_arms
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cm82
	name = "CM-82 Standard Issue Rifle"
	desc = "Contains a high-powered rifle chambered in 5.56 CLIP, standard issue of the Colonial Minutemen."
	cost = 5000
	contains = list(/obj/item/storage/guncase/cm82)
	crate_name = "rifle crate"
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/cmf4
	name = "CM-F4 Designated Marksman Rifle"
	desc = "Contains a high-powered marksman rifle chambered in .308. For Colonial Minuteman issue only."
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
	cost = 3500
	contains = list(/obj/item/storage/guncase/sbr80)
	crate_name = "dmr crate"
	faction = /datum/faction/scarborough_arms
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/gun/vickland
	name = "Vickland Battle Rifle"
	desc = "Contains a high-powered semi-automatic battle rifle chambered in .308 and produced by Hunter's Pride. Fed via stripper clips with a 10 round capacity."
	cost = 3500
	contains = list(/obj/item/storage/guncase/vickland)
	crate_name = "dmr crate"
	faction = /datum/faction/srm
	faction_discount = 0
	faction_locked = TRUE

/* Attachments */

/datum/supply_pack/gun/attachment/rail_light
	name = "Tactical Rail Light Crate"
	desc = "Contains a single rail light to be mounted on a firearm."
	cost = 100
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
	crate_name = "suppressor crate"
