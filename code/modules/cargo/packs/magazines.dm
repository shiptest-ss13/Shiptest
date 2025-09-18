/datum/supply_pack/magazine
	category = "Magazines"
	crate_type = /obj/structure/closet/crate/secure/gear
	crate_name = "magazine crate"
	faction_discount = 0


/* VI */

/datum/supply_pack/magazine/co9mm_mag
	name = "9x18mm Commander Magazine Crate"
	desc = "Contains a 9x18mm magazine for the standard-issue Commander pistol, with a capacity of twelve rounds."
	contains = list(/obj/item/ammo_box/magazine/co9mm/empty)
	cost = 150
	faction = /datum/faction/nt

/datum/supply_pack/magazine/smgm9mm_mag
	name = "9x18mm SMG Magazine Crate"
	desc = "Contains a 9x18mm magazine for the Vector and Saber SMGs, with a capacity of thirty rounds."
	contains = list(/obj/item/ammo_box/magazine/smgm9mm/empty)
	cost = 250
	faction = /datum/faction/nt

/* Hunter's Pride */

/datum/supply_pack/magazine/c38_mag
	name = ".38 Speedloader Crate"
	desc = "Contains a .38 speedloader for revolvers, containing six rounds."
	contains = list(/obj/item/ammo_box/c38/empty)
	cost = 100
	faction_discount = 20
	faction = /datum/faction/srm

/datum/supply_pack/magazine/m45_mag
	name = ".45 ACP Candor Magazine Crate"
	desc = "Contains a .45 ACP magazine for the Candor pistol, with a capacity of eight rounds."
	contains = list(/obj/item/ammo_box/magazine/m45/empty)
	cost = 100
	faction = /datum/faction/srm

/datum/supply_pack/magazine/a44roum_speedloader
	name = ".44 Roumain Speedloader Crate"
	desc = "Contains a .44 Roumain speedloader for the HP Montagne, with a capacity of six rounds."
	contains = list(/obj/item/ammo_box/a44roum_speedloader/empty)
	cost = 100
	faction = /datum/faction/srm

/datum/supply_pack/magazine/firestorm_mag

	name = "Firestorm Stick Magazine Crate"
	desc = "Contains a 24-round magazine for the Hunter's Pride Firestorm SMG."
	contains = list(/obj/item/ammo_box/magazine/c44_firestorm_mag/empty)

	cost = 300
	faction = /datum/faction/srm

/datum/supply_pack/magazine/firestorm_pan_mag
	name = "Firestorm Pan Magazine Crate"
	desc = "Contains a 40-round pan magazine for the Hunter's Pride Firestorm SMG."
	contains = list(/obj/item/ammo_box/magazine/c44_firestorm_mag/pan/empty)
	cost = 750
	faction = /datum/faction/srm

/datum/supply_pack/magazine/invictus_mag
	name = "Invictus Magazine Crate"
	desc = "Contains a 20-round magazine for the Hunter's Pride Invictus Automatic Rifle."
	contains = list(/obj/item/ammo_box/magazine/invictus_308_mag)
	cost = 300
	faction = /datum/faction/srm

/* Serene Sporting */

/datum/supply_pack/magazine/m17_mag
	name = "Micro Target Magazine Crate"
	desc = "Contains a .22lr magazine for the Micro Target pistol, with a capacity of ten rounds."
	contains = list(/obj/item/ammo_box/magazine/m17/empty)
	cost = 100

/datum/supply_pack/magazine/m12_mag
	name = "Sporter Magazine Crate"
	desc = "Contains a .22lr magazine for the Sporter Rifle, with a capacity of 25 rounds."
	contains = list(/obj/item/ammo_box/magazine/m12_sporter/empty)
	cost = 200

/datum/supply_pack/magazine/m15_mag
	name = "Super Sporter Magazine Crate"
	desc = "Contains a 5.56 CLIP magazine for the Super Sporter Rifle, with a capacity of 20 rounds."
	contains = list(/obj/item/ammo_box/magazine/m15/empty)
	cost = 300

/datum/supply_pack/magazine/woodsman_mag
	name = "Woodsman Magazine Crate"
	desc = "Contains an 8x50mmR magazine for the Woodsman Rifle, with a capacity of five rounds."
	contains = list(/obj/item/ammo_box/magazine/m23/empty)
	cost = 200

/datum/supply_pack/magazine/m20_auto_elite
	name = "Auto Elite Magazine Crate"
	desc = "Contains a .44 Roumain magazine for the Auto Elite pistol, with a capacity of nine rounds."
	contains = list(/obj/item/ammo_box/magazine/m20_auto_elite/empty)
	cost = 250

/* Scarbie */

/datum/supply_pack/magazine/himehabu_mag
	name = "Himehabu Magazine Crate"
	desc = "Contains a .22lr magazine for the Himehabu pistol, with a capacity of ten rounds."
	contains = list(/obj/item/ammo_box/magazine/m22lr_himehabu/empty)
	cost = 100
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/hognose_mag
	name = "Hognose Magazine Crate"
	desc = "Contains a .22lr magazine for the Hognose underbarrel pistol, with a capacity of eight rounds."
	contains = list(/obj/item/ammo_box/magazine/m22lr_himehabu/hognose/empty)
	cost = 100
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/asp_mag
	name = "Asp Magazine Crate"
	desc = "Contains a 5.7x39mm magazine for the Asp pistol, with a capacity of 12 rounds."
	contains = list(/obj/item/ammo_box/magazine/m57_39_asp/empty)
	cost = 250
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/m10mm_mag
	name = "Ringneck Magazine Crate"
	desc = "Contains a 10x22mm magazine for the Ringneck pistol, with a capacity of eight rounds."
	contains = list(/obj/item/ammo_box/magazine/m10mm_ringneck/empty)
	cost = 150
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/m9mm_rattlesnake
	name = "Rattlesnake Magazine Crate"
	desc = "Contains a 9x18mm magazine for the Rattlesnake machine pistol, with a capacity of 18 rounds."
	contains = list(/obj/item/ammo_box/magazine/m9mm_rattlesnake/empty)
	cost = 300
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/a357_mag
	name = ".357 Speedloader Crate"
	desc = "Contains a .357 speedloader for revolvers, with a capacity of six rounds."
	contains = list(/obj/item/ammo_box/a357/empty)
	cost = 250
	faction_discount = 20
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/sidewinder_mag
	name = "Sidewinder Magazine Crate"
	desc = "Contains a 30 round magazine for the Sidewinder SMG."
	contains = list(/obj/item/ammo_box/magazine/m57_39_sidewinder/empty)
	cost = 300
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/c45_cobra_mag
	name = "Cobra Magazine Crate"
	desc = "Contains a .45 magazine for the Cobra-20, with a capacity of 24 rounds."
	cost = 300
	contains = list(/obj/item/ammo_box/magazine/m45_cobra/empty)
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/short_hydra_mag
	name = "SBR-80 DMR Short Magazine Crate"
	desc = "Contains a 5.56x42mm CLIP made specially for the SBR-80 Designated Marksman Rifle, with a capacity of 20 rounds."
	contains = list(/obj/item/ammo_box/magazine/m556_42_hydra/small/empty)
	cost = 300
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/hydra_mag
	name = "SMR-80 Rifle Magazine Crate"
	desc = "Contains a 5.56x42mm CLIP for the SMR-80 assault rifle, with a capacity of 30 rounds."
	contains = list(/obj/item/ammo_box/magazine/m556_42_hydra/empty)
	cost = 400
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/saw_mag
	name = "SAW-80 Magazine Crate"
	desc = "Contains a 5.56x42mm CLIP magazine for the SAW-80 Squad Automatic Weapon, with a capacity of sixty rounds. Count your shots, they run out fast."
	contains = list(/obj/item/ammo_box/magazine/m556_42_hydra/extended/empty)
	cost = 750
	faction = /datum/faction/syndicate/scarborough
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/magazine/boomslang_mag
	name = "Boomslang-90 Magazine Crate"
	desc = "Contains a 6.5mm CLIP magazine for the Boomslang rifle platform, with a capacity of five rounds."
	contains = list(/obj/item/ammo_box/magazine/boomslang/short/empty)
	cost = 200
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/boomslang_mag_extended
	name = "MSR-90 'Boomslang' Magazine Crate"
	desc = "Contains a 6.5mm CLIP magazine for the Boomslang rifle platform, with a capacity of ten rounds."
	contains = list(/obj/item/ammo_box/magazine/boomslang/empty)
	cost = 750
	faction = /datum/faction/syndicate/scarborough


/* CM Lancaster */

/datum/supply_pack/magazine/cm23_mag
	name = "CM-23 Magazine Crate"
	desc = "Contains a 10x22mm magazine for the CM-23 handgun with a capacity of 10 rounds."
	contains = list(/obj/item/ammo_box/magazine/cm23/empty)
	cost = 150
	faction = /datum/faction/clip

/datum/supply_pack/magazine/cm70_mag
	name = "CM-70 Magazine Crate"
	desc = "Contains a 9x18mm magazine for the CM-70 machinepistol."
	contains = list(/obj/item/ammo_box/magazine/m9mm_cm70/empty)
	cost = 150
	faction = /datum/faction/clip
	faction_discount = 20

/datum/supply_pack/magazine/cm357_mag
	name = "CM-357 Magazine Crate"
	desc = "Contains a .357 magazine for the CM-357 automag pistol with a capacity of 7 rounds."
	contains = list(/obj/item/ammo_box/magazine/cm357/empty)
	cost = 150
	faction = /datum/faction/clip

/datum/supply_pack/magazine/cm5_mag
	name = "CM-5 Magazine Crate"
	desc = "Contains a 9x18mm magazine for the CM-5 SMG with a capacity of 30 rounds."
	contains = list(/obj/item/ammo_box/magazine/cm5_9mm/empty)
	cost = 300
	faction = /datum/faction/clip
	faction_discount = 20

/datum/supply_pack/magazine/cm82_mag
	name = "CM-82 Magazine Crate"
	desc = "Contains a 5.56mm magazine for the CM-82 rifle, with a capacity of thirty rounds."
	contains = list(/obj/item/ammo_box/magazine/p16/empty)
	cost = 300
	faction = /datum/faction/clip

/datum/supply_pack/magazine/skm_ammo
	name = "SKM Magazine Crate"
	desc = "Contains a 7.62x40mm magazine for the SKM rifles, with a capacity of twenty rounds."
	contains = list(/obj/item/ammo_box/magazine/skm_762_40/empty)
	cost = 300

/datum/supply_pack/magazine/skm_ammo_extended
	name = "SKM Extended Magazine Crate"
	desc = "Contains a 7.62x40mm magazine for the SKM rifles, with a capacity of fourty rounds."
	contains = list(/obj/item/ammo_box/magazine/skm_762_40/extended/empty)
	cost = 1250
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/magazine/f4_mag
	name = "F4 Magazine Crate"
	desc = "Contains a .308 magazine for SsG-04 and CM-F4 platform rifles, with a capacity of ten rounds."
	contains = list(/obj/item/ammo_box/magazine/f4_308/empty)
	cost = 300
	faction = /datum/faction/clip

/datum/supply_pack/magazine/f90
	name = "CM-F90 Magazine Crate"
	desc = "Contains a 5-round 6.5mm magazine for use with the CM-F90 sniper rifle."
	contains = list(/obj/item/ammo_box/magazine/f90/empty)
	cost = 200
	faction = /datum/faction/clip

/datum/supply_pack/magazine/cm15
	name = "CM-15 Magazine Crate"
	desc = "Contains an 8-round 12ga magazine for the CM-15 Automatic Shotgun."
	contains = list(/obj/item/ammo_box/magazine/cm15_12g/empty)
	cost = 400
	faction = /datum/faction/clip

/datum/supply_pack/magazine/cm40
	name = "CM-40 Magazine Crate"
	desc = "Contains an 80-round 7.62x40mm CLIP box for the CM-40 Squad Automatic Weapon. Consider designating an ammo bearer."
	contains = list(/obj/item/ammo_box/magazine/cm40_762_40_box/empty)
	cost = 1000
	faction = /datum/faction/clip

/* NT */

/datum/supply_pack/magazine/wt550_mag
	name = "WT-550 Auto Rifle Magazine Crate"
	desc = "Contains a 20-round magazine for the WT-550 Auto Rifle. Each magazine is designed to facilitate rapid tactical reloads."
	cost = 300
	contains = list(/obj/item/ammo_box/magazine/wt550m9/empty)
	faction = /datum/faction/nt

/* SolGov */

/datum/supply_pack/magazine/mag_556mm
	name = "5.56 Pistole C Magazine Crate"
	desc = "Contains a 5.56mm magazine for the Pistole C, with a capacity of twelve rounds."
	contains = list(/obj/item/ammo_box/magazine/pistol556mm/empty)
	cost = 150
	faction = /datum/faction/solgov

/datum/supply_pack/magazine/fms_mag
	name = "Ferromagnetic Slug Magazine Crate"
	desc = "Contains a ferromagnetic slug magazine for the Model H pistol, with a capacity of ten rounds."
	contains = list(/obj/item/ammo_box/magazine/modelh/empty)
	cost = 350
	faction = /datum/faction/solgov

/datum/supply_pack/magazine/gar_ammo
	name = "GAR Ferromagnetic Lance Magazine Crate"
	desc = "Contains a ferromagnetic lance magazine for the GAR rifle, with a capacity of thirty two rounds."
	contains = list(/obj/item/ammo_box/magazine/gar/empty)
	cost = 500
	faction = /datum/faction/solgov

/datum/supply_pack/magazine/claris_ammo
	name = "Claris Ferromagnetic Pellet Speedloader Crate"
	desc = "Contains a ferromagnetic pellet speedloader for the Claris rifle, with a capacity of twenty two rounds."
	contains = list(/obj/item/ammo_box/amagpellet_claris/empty)
	cost = 400
	faction = /datum/faction/solgov

/* Inteq */

/datum/supply_pack/magazine/mongrel_mag
	name = "Mongrel Magazine Crate"
	desc = "Contains a 10x22mm magazine for the SKM-44v 'Mongrel' SMG, with a capacity of twenty-four rounds."
	contains = list(/obj/item/ammo_box/magazine/smgm10mm/empty)
	cost = 200
	faction = /datum/faction/inteq

/datum/supply_pack/magazine/rottweiler_mag

	name = "Rottweiler Box Magazine Crate"
	desc = "Contains a .308 box magazine for the KM-05 'Rottweiler' LMG, with a capacity of fifty rounds."
	contains = list(/obj/item/ammo_box/magazine/rottweiler_308_box/empty)
	cost = 750
	faction = /datum/faction/inteq

/* Shotguns */

/datum/supply_pack/magazine/bulldog
	name = "Bulldog Box Magazine Crate"
	desc = "Contains an 8-round 12ga box magazine for the Bulldog weapons platform."
	contains = list(/obj/item/ammo_box/magazine/m12g_bulldog/empty)
	cost = 400
	faction = /datum/faction/syndicate/scarborough

/datum/supply_pack/magazine/bulldog_12
	name = "Bulldog Drum Magazine Crate"
	desc = "Contains a 12-round 12ga drum magazine for the Bulldog weapons platform."
	contains = list(/obj/item/ammo_box/magazine/m12g_bulldog/drum/empty)
	cost = 1200
	faction = /datum/faction/syndicate/scarborough

/* energy weapons */

/datum/supply_pack/magazine/guncell
	name = "Weapon Cell Crate"
	desc = "Contains a weapon cell, compatible with laser guns."
	contains = list(/obj/item/stock_parts/cell/gun)
	faction = /datum/faction/nt
	cost = 300

/datum/supply_pack/magazine/solgovcell
	name = "SolCon Weapon Cell Crate"
	desc = "Contains a Solarian weapon cell, compatible with Solarian gauss weaponry."
	contains = list(/obj/item/stock_parts/cell/gun/solgov)
	cost = 500
	faction = /datum/faction/solgov
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/magazine/upgradedguncell
	name = "Upgraded Weapon Cell Crate"
	desc = "Contains an upgraded weapon cell, compatible with laser guns. For NT use only."
	contains = list(/obj/item/stock_parts/cell/gun/upgraded)
	cost = 1000
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/* etherbor */

/datum/supply_pack/magazine/kalixcell
	name = "Etherbor Cell Crate"
	desc = "Contains an Etherbor weapon cell, compatible with Etherbor armaments with a slightly higher capacity."
	contains = list(/obj/item/stock_parts/cell/gun/kalix)
	cost = 600
	faction = /datum/faction/pgf

/datum/supply_pack/magazine/pgfcell
	name = "Military-Grade Etherbor Cell Crate"
	desc = "Contains a military-grade Etherbor weapon cell produced for the PGFMC, compatible with Etherbor armaments with a significantly higher capacity."
	contains = list(/obj/item/stock_parts/cell/gun/pgf)
	cost = 1000
	faction = /datum/faction/pgf
	faction_discount = 0
	faction_locked = TRUE

/* Expand once the energy weapons have been actually expanded upon */
