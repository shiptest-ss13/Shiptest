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
	name = ".45 ACP M1911 Magazine Crate"
	desc = "Contains three .45 ACP magazines for the M1911 pistol, each containing eight rounds."
	contains = list(/obj/item/ammo_box/magazine/m45,
					/obj/item/ammo_box/magazine/m45,
					/obj/item/ammo_box/magazine/m45)
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
	desc = "Contains two boxes of buckshot for use in lethal persuasion."
	cost = 2000
	contains = list(/obj/item/storage/box/lethalshot,
					/obj/item/storage/box/lethalshot)

/datum/supply_pack/ammo/slugs
	name = "Shotgun Slug Crate"
	desc = "Contains two boxes of slug shells for use in lethal persuasion."
	cost = 2000
	contains = list(/obj/item/storage/box/slugshot,
					/obj/item/storage/box/slugshot)

/*
		.38 ammo
*/

/datum/supply_pack/ammo/winchester_ammo
	name = "Winchester and Detective Special .38 Ammo Boxes"
	desc = "Contains two 30 round ammo boxes for refilling .38 weapons."
	cost = 1000
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
	contains = list(/obj/item/ammo_box/magazine/wt550m9/wtap,
					/obj/item/ammo_box/magazine/wt550m9/wtic)

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

/datum/supply_pack/ammo/ak47_ammo
	name = "AKM 7.62x39mm FMJ Magazine Crate"
	desc = "Contains two 7.62x39mm FMJ magazines for the AKM rifle, each containing twenty rounds."
	contains = list(/obj/item/ammo_box/magazine/ak47,
					/obj/item/ammo_box/magazine/ak47)
	cost = 2000

/datum/supply_pack/ammo/p16_ammo
	name = "P-16 5.56mm Magazine Crate"
	desc = "Contains two 5.56mm magazines for the P-16 rifle, each containing thirty rounds."
	contains = list(/obj/item/ammo_box/magazine/p16,
					/obj/item/ammo_box/magazine/p16)
	cost = 2000

/datum/supply_pack/ammo/a762_ammo
	name = "7.62x54mm Stripper Clip Crate"
	desc = "Contains four 7.62x54mm stripper clips for rifles like the illestren rifle, each containing five rounds."
	contains = list(/obj/item/ammo_box/a762,
					/obj/item/ammo_box/a762,
					/obj/item/ammo_box/a762,
					/obj/item/ammo_box/a762)
	cost = 1000
