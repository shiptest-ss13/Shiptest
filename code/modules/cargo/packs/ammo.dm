/datum/supply_pack/ammo
	group = "Ammunition"
	crate_type = /obj/structure/closet/crate/secure/gear

/*
		Pistol ammo
*/

/datum/supply_pack/ammo/co9mm_ammo
	name = "9mm Commander Ammo Crate"
	desc = "Contains three 9mm magazines for the standard-issue Commander pistol, each containing ten rounds."
	contains = list(/obj/item/ammo_box/magazine/co9mm,
					/obj/item/ammo_box/magazine/co9mm,
					/obj/item/ammo_box/magazine/co9mm)
	cost = 1500

/datum/supply_pack/ammo/m10mm_ammo
	name = "10mm Stechkin Ammo Crate"
	desc = "Contains three 10mm magazines for the stechkin pistol, each containing eight rounds."
	contains = list(/obj/item/ammo_box/magazine/m10mm,
					/obj/item/ammo_box/magazine/m10mm,
					/obj/item/ammo_box/magazine/m10mm)
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
	cost = 2500
	contains = list(/obj/item/ammo_box/c38_box,
					/obj/item/ammo_box/c38_box)
	crate_name = "ammo crate"

/datum/supply_pack/ammo/winchester_hunting_ammo
	name = "Winchester and Detective Special .38 Hunting Ammo Boxes"
	desc = "Contains two 30 round .38 ammo boxes which deal extra damage to wildlife."
	cost = 2000
	contains = list(/obj/item/ammo_box/c38_box/hunting,
					/obj/item/ammo_box/c38_box/hunting)
	crate_name = "ammo crate"

/datum/supply_pack/ammo/match
	name = ".38 Match Grade Speedloader"
	desc = "Contains one speedloader of match grade .38 ammunition, perfect for showing off trickshots."
	cost = 1200
	small_item = TRUE
	contains = list(/obj/item/ammo_box/c38/match)
	crate_name = ".38 match crate"

/datum/supply_pack/ammo/dumdum
	name = ".38 DumDum Speedloader"
	desc = "Contains one speedloader of .38 DumDum ammunition, good for embedding in soft targets."
	cost = 1200
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
