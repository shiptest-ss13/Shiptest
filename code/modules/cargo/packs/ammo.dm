/datum/supply_pack/ammo
	group = "Bulk Ammunition"
	crate_type = /obj/structure/closet/crate/secure/gear
	crate_name = "ammo crate"

/* Misc */

/datum/supply_pack/ammo/blank_ammo_disk
	name = "Blank Ammo Design Disk Crate"
	desc = "Run your own training drills!"
	cost = 1000
	contains = list(/obj/item/disk/design_disk/blanks)

/* .22lr */

/datum/supply_pack/ammo/c22lr
	name = ".22 LR Ammo Box Crate"
	desc = "Contains a 100-round ammo box for refilling .22 LR weapons."
	contains = list(/obj/item/storage/box/ammo/c22lr)
	cost = 250

/* 9mm */

/datum/supply_pack/ammo/c9mm_ammo_box
	name = "9mm Ammo Box Crate"
	desc = "Contains a 48-round 9mm box for pistols and SMGs such as the Commander or Saber."
	contains = list(/obj/item/storage/box/ammo/c9mm)
	cost = 200

/datum/supply_pack/ammo/c9mmap_ammo_box
	name = "9mm AP Ammo Box Crate"
	desc = "Contains a 48-round 9mm box loaded with armor piercing ammo."
	contains = list(/obj/item/storage/box/ammo/c9mm/ap)
	cost = 400

/datum/supply_pack/ammo/c9mmhp_ammo_box
	name = "9mm HP Ammo Box Crate"
	desc = "Contains a 48-round 9mm box loaded with hollow point ammo, great against unarmored targets."
	contains = list(/obj/item/storage/box/ammo/c9mm_hp)
	cost = 400

/datum/supply_pack/ammo/c9mmrubber_ammo_box
	name = "9mm Rubber Ammo Box Crate"
	desc = "Contains a 48-round 9mm box loaded with less-than-lethal rubber rounds."
	contains = list(/obj/item/storage/box/ammo/c9mm_rubber)
	cost = 200

/* .38 */

/datum/supply_pack/ammo/c38
	name = ".38 Ammo Boxes Crate"
	desc = "Contains two 50 round ammo boxes for refilling .38 weapons."
	cost = 250
	contains = list(/obj/item/storage/box/ammo/c38,
					/obj/item/storage/box/ammo/c38)
	crate_name = "ammo crate"

/* 10mm */

/datum/supply_pack/ammo/c10mm_ammo_box
	name = "10mm Ammo Box Crate"
	desc = "Contains a 48-round 10mm box for pistols and SMGs like the Ringneck or the SkM-44(k)."
	contains = list(/obj/item/storage/box/ammo/c10mm)
	cost = 250

/datum/supply_pack/ammo/c10mmap_ammo_box
	name = "10mm AP Ammo Box Crate"
	desc = "Contains a 48-round 10mm box loaded with armor piercing ammo."
	contains = list(/obj/item/storage/box/ammo/c10mm_ap)
	cost = 500

/datum/supply_pack/ammo/c10mmhp_ammo_box
	name = "10mm HP Ammo Box Crate"
	desc = "Contains a 48-round 10mm box loaded with hollow point ammo, great against unarmored targets."
	contains = list(/obj/item/storage/box/ammo/c10mm_hp)
	cost = 500

/datum/supply_pack/ammo/c10mmrubber_ammo_box
	name = "10mm Rubber Ammo Box Crate"
	desc = "Contains a 48-round 10mm box loaded with less-than-lethal rubber rounds."
	contains = list(/obj/item/storage/box/ammo/c10mm_rubber)
	cost = 250

/* .45 */

/datum/supply_pack/ammo/c45_ammo_box
	name = ".45 Ammo Box Crate"
	desc = "Contains a 48-round .45 box for pistols and SMGs like the Candor or the C-20r."
	contains = list(/obj/item/storage/box/ammo/c45)
	cost = 250

/datum/supply_pack/ammo/c45ap_ammo_box
	name = ".45 AP Ammo Box Crate"
	desc = "Contains a 48-round .45 box loaded with armor piercing ammo."
	contains = list(/obj/item/storage/box/ammo/c45_ap)
	cost = 500

/datum/supply_pack/ammo/c45hp_ammo_box
	name = ".45 HP Ammo Box Crate"
	desc = "Contains a 48-round 10mm box loaded with hollow point ammo, great against unarmored targets."
	contains = list(/obj/item/storage/box/ammo/c45_hp)
	cost = 500

/datum/supply_pack/ammo/c45mmrubber_ammo_box
	name = ".45 Rubber Ammo Box Crate"
	desc = "Contains a 48-round .45 box loaded with less-than-lethal rubber rounds."
	contains = list(/obj/item/storage/box/ammo/c45_rubber)
	cost = 250

/* .357 */

/datum/supply_pack/ammo/a357_ammo_box
	name = ".357 Ammo Box Crate"
	desc = "Contains a 48-round .357 box for revolvers such as the Scarborough Revolver and the HP Firebrand."
	contains = list(/obj/item/storage/box/ammo/a357)
	cost = 250

/datum/supply_pack/ammo/a357hp_ammo_box
	name = ".357 HP Ammo Box Crate"
	desc = "Contains a 48-round .357 box loaded with hollow point ammo, great against unarmored targets."
	contains = list(/obj/item/storage/box/ammo/a357_hp)
	cost = 500

/datum/supply_pack/ammo/a357match_ammo_box
	name = ".357 Match Ammo Box Crate"
	desc = "Contains a 48-round .357 match box for better performance against armor."
	contains = list(/obj/item/storage/box/ammo/a357_match)
	cost = 500

/* .44 */

/datum/supply_pack/ammo/a44roum
	name = ".44 Roumain Ammo Box Crate"
	desc = "Contains a 48-round box of .44 roumain ammo for revolvers such as the Shadow and Montagne."
	contains = list(/obj/item/storage/box/ammo/a44roum)
	cost = 250

/datum/supply_pack/ammo/a44roum_rubber
	name = ".44 Roumain Rubber Ammo Box Crate"
	desc = "Contains a 48-round box of .44 roumain ammo loaded with less-than-lethal rubber rounds."
	contains = list(/obj/item/storage/box/ammo/a44roum_rubber)
	cost = 250

/datum/supply_pack/ammo/a44roum_hp
	name = ".44 Roumain Hollow Point Ammo Box Crate"
	desc = "Contains a 48-round box of .44 roumain hollow point ammo, great against unarmored targets."
	contains = list(/obj/item/storage/box/ammo/a44roum_hp)
	cost = 500

/* 4.6x30 */

/datum/supply_pack/ammo/c46x30mm_boxcrate
	name = "4.6x30mm Ammo Box Crate"
	desc = "Contains a 60-round 4.6x30mm box for PDWs such as the WT-550."
	contains = list(/obj/item/storage/box/ammo/c46x30mm)
	cost = 250

/* 5.7x39 */

/datum/supply_pack/ammo/c57x39mm_boxcrate
	name = "5.7x39mm Ammo Box Crate"
	desc = "Contains a 48-round 5.7x39mm box for PDWs such as the Sidewinder."
	contains = list(/obj/item/storage/box/ammo/c57x39)
	cost = 250


/* 12 Gauge */

/datum/supply_pack/ammo/buckshot
	name = "Buckshot Crate"
	desc = "Contains a box of 32 buckshot shells for use in lethal persuasion."
	cost = 500
	contains = list(/obj/item/storage/box/ammo/a12g_buckshot)

/datum/supply_pack/ammo/slugs
	name = "Shotgun Slug Crate"
	desc = "Contains a box of 32 slug shells for use in lethal persuasion."
	cost = 500
	contains = list(/obj/item/storage/box/ammo/a12g_slug)

/datum/supply_pack/ammo/blank_shells
	name = "Blank Shell Crate"
	desc = "Contains a box of blank shells."
	cost = 500
	contains = list(/obj/item/storage/box/ammo/a12g_blank)

/datum/supply_pack/ammo/rubbershot
	name = "Rubbershot Crate"
	desc = "Contains a box of 32 12 gauge rubbershot shells. Perfect for crowd control and training."
	cost = 500
	contains = list(/obj/item/storage/box/ammo/a12g_rubbershot)

/datum/supply_pack/ammo/techshells
	name = "Unloaded Shotgun Technological Shells Crate"
	desc = "Contains a box of 7 versatile tech shells, capable of producing a variety of deadly effects for any situation. Some assembly required."
	cost = 210
	contains = list(/obj/item/storage/box/techshot)

/* .45-70 */

/datum/supply_pack/ammo/a4570_box
	name = ".45-70 Ammo Box Crate"
	desc = "Contains a 20-round box containing devastatingly powerful .45-70 caliber ammunition."
	contains = list(/obj/item/storage/box/ammo/a4570)
	cost = 500

/datum/supply_pack/ammo/a4570_box/match
	name = ".45-70 Match Crate"
	desc = "Contains a 20-round box containing devastatingly powerful .45-70 caliber ammunition, that travels faster, pierces armour better, and ricochets off targets."
	contains = list(/obj/item/storage/box/ammo/a4570_match)
	cost = 1000

/* 7.62 */

/datum/supply_pack/ammo/a762_ammo_box
	name = "7.62x40mm CLIP Ammo Box Crate"
	desc = "Contains two 60-round 7.62x40mm CLIP boxes for the SKM rifles."
	contains = list(/obj/item/storage/box/ammo/a762_40,
					/obj/item/storage/box/ammo/a762_40)
	cost = 500

/* 5.56 */

/datum/supply_pack/ammo/a556_ammo_box
	name = "5.56x42mm CLIP Ammo Box Crate"
	desc = "Contains two 60-round 5.56x42mm CLIP boxes for most newer rifles."
	contains = list(/obj/item/storage/box/ammo/a556_42,
					/obj/item/storage/box/ammo/a556_42)
	cost = 450

/* 5.56 caseless */

/datum/supply_pack/ammo/c556mmHITP_ammo_box
	name = "5.56 Caseless Ammo Box Crate"
	desc = "Contains a 48-round 5.56mm caseless box for SolGov sidearms like the Pistole C."
	contains = list(/obj/item/storage/box/ammo/c556mm)
	cost = 250

/datum/supply_pack/ammo/c556mmHITPap_ammo_box
	name = "5.56 caseless AP Ammo Box Crate"
	desc = "Contains a 48-round 5.56mm caseless boxloaded with armor piercing ammo."
	contains = list(/obj/item/storage/box/ammo/c556mm_ap)
	cost = 500

/datum/supply_pack/ammo/c556mmhitphp_ammo_box
	name = "5.56 Caseless HP Ammo Box Crate"
	desc = "Contains a 48-round 5.56mm caseless box loaded with hollow point ammo, great against unarmored targets."
	contains = list(/obj/item/storage/box/ammo/c556mm_hp)
	cost = 500

/datum/supply_pack/ammo/c556HITPrubber_ammo_box
	name = "5.56 Caseless Rubber Ammo Box Crate"
	desc = "Contains a 48-round 5.56 caseless box loaded with less-than-lethal rubber rounds."
	contains = list(/obj/item/storage/box/ammo/c556mm_rubber)
	cost = 250

/* .299 */

/datum/supply_pack/ammo/c299
	name = ".299 Eoehoma Caseless Ammo Box Crate"
	desc = "Contains two 60-round boxes of .299 Caseless ammo from the defunct Eoehoma. Used for the E-40 Hybrid Rifle."
	contains = list(/obj/item/storage/box/ammo/c299,
					/obj/item/storage/box/ammo/c299)
	cost = 400

/* 8x50 */

/datum/supply_pack/ammo/c8x50mm_boxcrate
	name = "8x50mm Ammo Box Crate"
	desc = "Contains a 30-round 8x50mm ammo box for rifles such as the Illestren."
	contains = list(/obj/item/storage/box/ammo/a8_50r)
	cost = 250

/datum/supply_pack/ammo/c8x50mm_boxhp_boxcrate
	name = "8x50mm Hollow Point Crate"
	desc = "Contains a 30-round 8x50mm ammo box loaded with hollow point ammo, great against unarmored targets."
	contains = list(/obj/item/storage/box/ammo/a8_50r_hp)
	cost = 500

/* .300 */

/datum/supply_pack/ammo/a300_box
	name = ".300 Ammo Box Crate"
	desc = "Contains a twenty-round .300 Magnum ammo box for sniper rifles such as the HP Scout."
	contains = list(/obj/item/storage/box/ammo/a300)
	cost = 400

/* .308 */

/datum/supply_pack/ammo/a308_ammo_box
	name = "308 Ammo Box Crate"
	desc = "Contains a thirty-round .308 box for DMRs such as the SsG-04 and CM-GAL-S."
	contains = list(/obj/item/storage/box/ammo/a308)
	cost = 500

/* 6.5 */

/datum/supply_pack/ammo/a65clip_box
	name = "6.5x57mm CLIP Ammo Box Crate"
	desc = "Contains a twenty-round 6.5x57mm CLIP ammo box for various sniper rifles such as the CM-F90 and the Boomslang series."
	contains = list(/obj/item/storage/box/ammo/a65clip)
	cost = 400

/* ferro pellets */

/datum/supply_pack/ammo/ferropelletboxcrate
	name = "Ferromagnetic Pellet Box Crate"
	desc = "Contains a 48-round ferromagnetic pellet ammo box for gauss guns such as the Claris."
	contains = list(/obj/item/storage/box/ammo/ferropellet)
	cost = 250

/* ferroslugs */

/datum/supply_pack/ammo/ferroslugboxcrate
	name = "Ferromagnetic Slug Box Crate"
	desc = "Contains a twenty-round ferromagnetic slug for gauss guns such as the Model-H."
	contains = list(/obj/item/storage/box/ammo/ferroslug)
	cost = 250

/* ferro lances */

/datum/supply_pack/ammo/ferrolanceboxcrate
	name = "Ferromagnetic Lance Box Crate"
	desc = "Contains a 48-round box for high-powered gauss guns such as the GAR assault rifle."
	contains = list(/obj/item/storage/box/ammo/ferrolance)
	cost = 250
