/datum/supply_pack/ammo
	group = "Ammunition"
	crate_type = /obj/structure/closet/crate/secure/gear

/*
		Pistol ammo
*/

/datum/supply_pack/ammo/co9mm_mag
	name = "9mm Commander Magazine Crate"
	desc = "Contains three 9mm magazines for the standard-issue Commander pistol, each containing ten rounds."
	contains = list(/obj/item/ammo_box/magazine/co9mm,
					/obj/item/ammo_box/magazine/co9mm,
					/obj/item/ammo_box/magazine/co9mm)
	cost = 1500

/datum/supply_pack/ammo/m45_mag
	name = ".45 ACP Candor Magazine Crate"
	desc = "Contains three .45 ACP magazines for the Candor pistol, each containing eight rounds."
	contains = list(/obj/item/ammo_box/magazine/m45,
					/obj/item/ammo_box/magazine/m45,
					/obj/item/ammo_box/magazine/m45)
	cost = 1500

/datum/supply_pack/ammo/m45_speedloader
	name = ".45 ACP Speedloader Crate"
	desc = "Contains four .45 ACP speedloaders for revolvers, each containing six rounds."
	contains = list(/obj/item/ammo_box/c45_speedloader,
					/obj/item/ammo_box/c45_speedloader,
					/obj/item/ammo_box/c45_speedloader,
					/obj/item/ammo_box/c45_speedloader)
	cost = 1500

/datum/supply_pack/ammo/c38_mag
	name = ".38 Speedloader Crate"
	desc = "Contains four .38 speedloaders for revolvers, each containing six rounds."
	contains = list(/obj/item/ammo_box/c38,
					/obj/item/ammo_box/c38,
					/obj/item/ammo_box/c38,
					/obj/item/ammo_box/c38)
	cost = 1500

/datum/supply_pack/ammo/m10mm_mag
	name = "10mm Stechkin Magazine Crate"
	desc = "Contains three 10mm magazines for the stechkin pistol, each containing eight rounds."
	contains = list(/obj/item/ammo_box/magazine/m10mm,
					/obj/item/ammo_box/magazine/m10mm,
					/obj/item/ammo_box/magazine/m10mm)
	cost = 1500

/datum/supply_pack/ammo/a357_mag
	name = ".357 Speedloader Crate"
	desc = "Contains two .357 speedloaders for revolvers, each containing seven rounds."
	contains = list(/obj/item/ammo_box/a357,
					/obj/item/ammo_box/a357)
	cost = 1500

/datum/supply_pack/ammo/mag_556mm
	name = "5.56 Pistole C Magazine Crate"
	desc = "Contains two 5.56mm magazines for the Pistole C, each containing twelve rounds."
	contains = list(/obj/item/ammo_box/magazine/pistol556mm,
					/obj/item/ammo_box/magazine/pistol556mm)
	cost = 1500

/datum/supply_pack/ammo/fms_mag
	name = "Ferromagnetic Slug Magazine Crate"
	desc = "Contains two ferromagnetic slug magazines for the Model H pistol, each containing ten rounds."
	contains = list(/obj/item/ammo_box/magazine/modelh,
					/obj/item/ammo_box/magazine/modelh)
	cost = 1500

/*
		Shotgun ammo
*/

/datum/supply_pack/ammo/buckshot
	name = "Buckshot Crate"
	desc = "Contains a box of twenty-five buckshot shells for use in lethal persuasion."
	cost = 500
	contains = list(/obj/item/ammo_box/a12g)

/datum/supply_pack/ammo/slugs
	name = "Shotgun Slug Crate"
	desc = "Contains a box of twenty-five slug shells for use in lethal persuasion."
	cost = 500
	contains = list(/obj/item/ammo_box/a12g/slug)

/*
		.38 ammo
*/

/datum/supply_pack/ammo/winchester_ammo
	name = "Flaming Arrow and Detective Special .38 Ammo Boxes"
	desc = "Contains two 30 round ammo boxes for refilling .38 weapons."
	cost = 500
	contains = list(/obj/item/ammo_box/c38_box,
					/obj/item/ammo_box/c38_box)
	crate_name = "ammo crate"

/datum/supply_pack/ammo/match
	name = ".38 Match Grade Speedloader"
	desc = "Contains one speedloader of match grade .38 ammunition, perfect for showing off trickshots."
	cost = 200
	small_item = TRUE
	contains = list(/obj/item/ammo_box/c38/match)
	crate_name = ".38 match crate"

/datum/supply_pack/ammo/dumdum
	name = ".38 DumDum Speedloader"
	desc = "Contains one speedloader of .38 DumDum ammunition, good for embedding in soft targets."
	cost = 200
	small_item = TRUE
	contains = list(/obj/item/ammo_box/c38/dumdum)
	crate_name = ".38 match crate"

/*
		WT-550 ammo
*/

/datum/supply_pack/ammo/wt550_ammo
	name = "WT-550 Auto Rifle Ammo Crate"
	desc = "Contains three 20-round magazine for the WT-550 Auto Rifle. Each magazine is designed to facilitate rapid tactical reloads."
	cost = 2250
	contains = list(/obj/item/ammo_box/magazine/wt550m9,
					/obj/item/ammo_box/magazine/wt550m9,
					/obj/item/ammo_box/magazine/wt550m9)

/datum/supply_pack/ammo/cool_wt550_ammo
	name = "WT-550 Auto Rifle Exotic Ammo Crate"
	desc = "Contains one magazine of armor-piercing and one magazine of incendiary ammunition for the WT-550 Auto Rifle. Sadly, our manufacturer discontinued the uranium-tipped bullets."
	cost = 2500
	contains = list(/obj/item/ammo_box/magazine/wt550m9/ap,
					/obj/item/ammo_box/magazine/wt550m9/inc)

/datum/supply_pack/ammo/smgm45ammo
	name = ".45 Cobra Ammo Crate"
	desc = "Contains two .45 magazines for the Cobra-20, each containing 24 rounds."
	cost = 1500
	contains = list(/obj/item/ammo_box/magazine/smgm45,
					/obj/item/ammo_box/magazine/smgm45)

/*
		Rifle ammo
*/

/datum/supply_pack/ammo/gal308_ammo
	name = "CM-GAL .308 Magazine Crate"
	desc = "Contains two .308 CM-GAL magazines for the CM-GAL rifle, each containing ten rounds."
	contains = list(/obj/item/ammo_box/magazine/gal,
					/obj/item/ammo_box/magazine/gal)
	cost = 2000

/datum/supply_pack/ammo/gar_ammo
	name = "GAR Ferromagnetic Lance Magazine Crate"
	desc = "Contains two ferromagnetic lance magazines for the GAR rifle, each containing thirty two rounds."
	contains = list(/obj/item/ammo_box/magazine/gar,
					/obj/item/ammo_box/magazine/gar)
	cost = 2000

/datum/supply_pack/ammo/claris_ammo
	name = "Claris Ferromagnetic Pellet Speedloader Crate"
	desc = "Contains two ferromagnetic pellet speedloaders for the Claris rifle, each containing twenty two rounds."
	contains = list(/obj/item/ammo_box/amagpellet_claris,
					/obj/item/ammo_box/amagpellet_claris)
	cost = 2000

/datum/supply_pack/ammo/ebr_ammo
	name = "M514 EBR .308 Magazine Crate"
	desc = "Contains two .308 magazines for the M514 EBR rifle, each containing ten rounds."
	contains = list(/obj/item/ammo_box/magazine/ebr,
					/obj/item/ammo_box/magazine/ebr)
	cost = 2000

/datum/supply_pack/ammo/skm_ammo
	name = "SKM 7.62x40mm CLIP Magazine Crate"
	desc = "Contains two 7.62x40mm magazines for the SKM rifles, each containing twenty rounds."
	contains = list(/obj/item/ammo_box/magazine/skm_762_40,
					/obj/item/ammo_box/magazine/skm_762_40)
	cost = 2000

/datum/supply_pack/ammo/p16_ammo
	name = "P-16 5.56mm Magazine Crate"
	desc = "Contains two 5.56mm magazines for the P-16 rifle, each containing thirty rounds."
	contains = list(/obj/item/ammo_box/magazine/p16,
					/obj/item/ammo_box/magazine/p16)
	cost = 2000

/datum/supply_pack/ammo/a850r_ammo
	name = "8x50mmR En Bloc Clip Crate"
	desc = "Contains four 8x50mmR en bloc clips for rifles like the illestren rifle, each containing five rounds."
	contains = list(/obj/item/ammo_box/magazine/illestren_a850r,
					/obj/item/ammo_box/magazine/illestren_a850r,
					/obj/item/ammo_box/magazine/illestren_a850r,
					/obj/item/ammo_box/magazine/illestren_a850r)
	cost = 1000

/datum/supply_pack/ammo/a762_ammo_box
	name = "7.62x40mm CLIP Ammo Box Crate"
	desc = "Contains a eighty-round 7.62x40mm CLIP box for the SKM rifles."
	contains = list(/obj/item/ammo_box/a762_40)
	cost = 500

/datum/supply_pack/ammo/c556mmHITP_ammo_box
	name = "5.56 Caseless Ammo Box Crate"
	desc = "Contains two fifty-round 5.56mm caseless boxes for SolGov sidearms like the Pistole C, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c556mmHITP,
					/obj/item/ammo_box/c556mmHITP)
	cost = 500

/datum/supply_pack/ammo/c45_ammo_box
	name = ".45 Ammo Box Crate"
	desc = "Contains two fifty-round .45 boxes for pistols and SMGs like the M1911 or the C-20r, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c45,
					/obj/item/ammo_box/c45)
	cost = 500

/datum/supply_pack/ammo/c10mm_ammo_box
	name = "10mm Ammo Box Crate"
	desc = "Contains two fifty-round 10mm boxes for pistols and SMGs like the Stechkin or the SkM-44(k), for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c10mm,
					/obj/item/ammo_box/c10mm)
	cost = 500

/datum/supply_pack/ammo/c9mm_ammo_box
	name = "9mm Ammo Box Crate"
	desc = "Contains two fifty-round 9mm boxes for pistols and SMGs such as the Commander or Saber, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c9mm,
					/obj/item/ammo_box/c9mm)
	cost = 500

/datum/supply_pack/ammo/a308_ammo_box
	name = "308 Ammo Box Crate"
	desc = "Contains one thirty-round .308 box for DMRs such as the SsG-04 and CM-GAL-S."
	contains = list(/obj/item/ammo_box/a308)
	cost = 500

/datum/supply_pack/ammo/c9mmap_ammo_box
	name = "9mm AP Ammo Box Crate"
	desc = "Contains two fifty-round 9mm boxes loaded with armor piercing ammo, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c9mm/ap,
					/obj/item/ammo_box/c9mm/ap)
	cost = 1000

/datum/supply_pack/ammo/c556mmHITPap_ammo_box
	name = "5.56 caseless AP Ammo Box Crate"
	desc = "Contains two fifty-round 5.56mm caseless boxes loaded with armor piercing ammo, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c556mmHITP/ap,
					/obj/item/ammo_box/c556mmHITP/ap)
	cost = 1000

/datum/supply_pack/ammo/c45ap_ammo_box
	name = ".45 AP Ammo Box Crate"
	desc = "Contains two fifty-round .45 boxes loaded with armor piercing ammo, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c45/ap,
					/obj/item/ammo_box/c45/ap)
	cost = 1000

/datum/supply_pack/ammo/c10mmap_ammo_box
	name = "10mm AP Ammo Box Crate"
	desc = "Contains two fifty-round 10mm boxes loaded with armor piercing ammo, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c10mm/ap,
					/obj/item/ammo_box/c10mm/ap)
	cost = 1000

/datum/supply_pack/ammo/c9mmhp_ammo_box
	name = "9mm HP Ammo Box Crate"
	desc = "Contains two fifty-round 9mm boxes loaded with hollow point ammo, great against unarmored targets, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c9mm/hp,
					/obj/item/ammo_box/c9mm/hp)
	cost = 1000

/datum/supply_pack/ammo/c10mmhp_ammo_box
	name = "10mm HP Ammo Box Crate"
	desc = "Contains two fifty-round 10mm boxes loaded with hollow point ammo, great against unarmored targets, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c10mm/hp,
					/obj/item/ammo_box/c10mm/hp)
	cost = 1000
/datum/supply_pack/ammo/c45hp_ammo_box
	name = ".45 HP Ammo Box Crate"
	desc = "Contains two fifty-round 10mm boxes loaded with hollow point ammo, great against unarmored targets, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c45/hp,
					/obj/item/ammo_box/c45/hp)
	cost = 1000

/datum/supply_pack/ammo/c556mmhitphp_ammo_box
	name = "5.56 Caseless HP Ammo Box Crate"
	desc = "Contains two fifty-round 5.56mm caseless boxes loaded with hollow point ammo, great against unarmored targets, for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c556mmHITP/hp,
					/obj/item/ammo_box/c556mmHITP/hp)
	cost = 1000

/datum/supply_pack/ammo/c9mmrubber_ammo_box
	name = "9mm Rubber Ammo Box Crate"
	desc = "Contains two fifty-round 9mm boxes loaded with less-than-lethal rubber rounds for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c9mm/rubbershot,
					/obj/item/ammo_box/c9mm/rubbershot)
	cost = 500

/datum/supply_pack/ammo/c10mmrubber_ammo_box
	name = "10mm Rubber Ammo Box Crate"
	desc = "Contains two fifty-round 10mm boxes loaded with less-than-lethal rubber rounds for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c10mm/rubbershot,
					/obj/item/ammo_box/c10mm/rubbershot)
	cost = 500

/datum/supply_pack/ammo/c45mmrubber_ammo_box
	name = ".45 Rubber Ammo Box Crate"
	desc = "Contains two fifty-round .45 boxes loaded with less-than-lethal rubber rounds for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c45/rubbershot,
					/obj/item/ammo_box/c45/rubbershot)
	cost = 500


/datum/supply_pack/ammo/c556HITPrubber_ammo_box
	name = "5.56 Caseless Rubber Ammo Box Crate"
	desc = "Contains two fifty-round 5.56 caseless boxes loaded with less-than-lethal rubber rounds for a total of 100 rounds."
	contains = list(/obj/item/ammo_box/c556mmHITP/rubbershot,
					/obj/item/ammo_box/c556mmHITP/rubbershot)
	cost = 500

/datum/supply_pack/ammo/guncell
	name = "Weapon Cell Crate"
	desc = "Contains three weapon cells, compatible with laser guns."
	contains = list(/obj/item/stock_parts/cell/gun,
					/obj/item/stock_parts/cell/gun,
					/obj/item/stock_parts/cell/gun)
	cost = 1500
