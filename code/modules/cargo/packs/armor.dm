/datum/supply_pack/armor
	category = "Armor"
	crate_type = /obj/structure/closet/crate/secure


/*
		Non-spaceworthy (armor)
*/

/datum/supply_pack/armor/basic_armor
	name = "Armor Crate"
	desc = "One set of well-rounded body armor. The set includes a helmet and vest."
	cost = 750
	contains = list(/obj/item/clothing/suit/armor/vest,
					/obj/item/clothing/head/helmet/m10)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/armor/riot_armor
	name = "Riot Armor Crate"
	desc = "Contains one full set of riot armor. Although heavily padded to deal with close-quarters threats, they perform poorly against most firearms."
	cost = 1500
	contains = list(/obj/item/clothing/suit/armor/riot,
					/obj/item/clothing/head/helmet/riot)
	crate_name = "riot armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/armor/bullet_armor
	name = "Bulletproof Armor Crate"
	desc = "Contains one full set of bulletproof armor, guaranteed to reduce a bullet's stopping power by half but with limited protection against melee weaponry."
	cost = 1750
	contains = list(/obj/item/clothing/suit/armor/vest/bulletproof,
					/obj/item/clothing/head/helmet/bulletproof,
					/obj/item/clothing/glasses/sunglasses/ballistic)
	crate_name = "bulletproof armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/armor/laser_armor
	name = "Reflector Vest Crate"
	desc = "Contains one vest made of highly reflective material. The armor piece diffuses a laser's energy by over half, but with limited protection against melee and ballistic weaponry."
	cost = 1250
	contains = list(/obj/item/clothing/suit/armor/laserproof)
	crate_name = "reflector vest crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/armor/marine_armor
	name = "Tactical Armor Crate"
	desc = "One set of well-rounded tactical armor. While it does not protect the limbs, the vest is fairly durable. The set includes a helmet and vest."
	cost = 1500
	contains = list(/obj/item/clothing/suit/armor/vest/marine,
					/obj/item/clothing/head/helmet/bulletproof/x11)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/armor/medium_marine_armor
	name = "Medium Tactical Armor Crate"
	desc = "One set of well-rounded medium tactical body armor. Plates are attached to the vest and cover the limbs. The set includes a helmet and chestpiece."
	cost = 3000
	contains = list(/obj/item/clothing/suit/armor/vest/marine/medium,
					/obj/item/clothing/head/helmet/riot)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

//clip

/datum/supply_pack/armor/clip_armor
	name = "X-11 Armor Crate"
	desc = "One set of Lanchester Manufacturing-manufactured X-11 armor, sold at a discount to the Confederated League due to a recent contract."
	cost = 1250
	contains = list(/obj/item/clothing/suit/armor/vest/bulletproof,
					/obj/item/clothing/head/helmet/bulletproof/x11/clip,
					/obj/item/clothing/mask/gas/clip)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/armor/clip_riot
	name = "CLIP Riot Armor Crate"
	desc = "One set of Clover Corp-manufactured Riot armor, traditionally issued to BARD for xenofauna removal, but available to League vessels deployed in the Frontier due to high Xenofauna density."
	cost = 1000
	contains = list(/obj/item/clothing/suit/armor/riot/clip,
					/obj/item/clothing/head/helmet/riot/clip,
					/obj/item/clothing/mask/gas/clip)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

//gezena
/datum/supply_pack/armor/pgf_marine_armor
	name = "Gezenan Composite Armor Crate"
	desc = "One set of standard issue AR-98 body armor, highly protective and quite mobile. Comes with a matching L-98 respirator."
	cost = 1500
	contains = list(/obj/item/clothing/suit/armor/gezena/marine,
					/obj/item/clothing/head/helmet/gezena,
					/obj/item/clothing/glasses/sunglasses/pgf,
					/obj/item/clothing/mask/breath/pgfmask)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/pgf
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/armor/pgf_armor
	name = "Navywear Coat Crate"
	desc = "One replacement navywear coat. The pricing is unfortunately high to discourage distribution to marines, and encourage servicemen to keep track of their jacket."
	cost = 1000
	contains = list(/obj/item/clothing/suit/armor/gezena)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/pgf
	faction_discount = 0
	faction_locked = TRUE

//jardliner

/datum/supply_pack/armor/hardliner_armor
	name = "Hardliner Armor Crate"
	desc = "One set of well-rounded hardliner body armor. Well. Rounded aside from the painfully obvious white. Subsidized by Cybersun Biodynamics."
	cost = 500
	contains = list(/obj/item/clothing/suit/armor/hardliners,
					/obj/item/clothing/head/helmet/hardliners)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/syndicate/hardliners
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/armor/hardliner_mecha_armor
	name = "Hardliner Pilot Armor Crate"
	desc = "One set of armor manufactured for Hardliner exosuit pilots. The jacket is often sought out by those outside of it as a keepsake."
	cost = 1500
	contains = list(/obj/item/clothing/suit/armor/hardliners/jacket,
					/obj/item/clothing/head/helmet/hardliners/swat)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/syndicate/hardliners
	faction_discount = 0
	faction_locked = TRUE

//ngr
/datum/supply_pack/armor/ngr_armor
	name = "NGR Armor Crate"
	desc = "One fairly durable, well manufactured type-1 armor vest and associated helmet, painted in the proud reds of the New Gorlex Republic."
	cost = 1000
	contains = list(/obj/item/clothing/suit/armor/ngr,
					/obj/item/clothing/head/helmet/ngr)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/syndicate/ngr
	faction_discount = 0
	faction_locked = TRUE

//srm

/datum/supply_pack/armor/srm_duster
	name = "SRM Duster Crate"
	desc = "One hand-stitched duster for a proud Roumainian to wear into the Hunt."
	cost = 500
	contains = list(/obj/item/clothing/suit/armor/roumain)
	crate_name = "duster crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/srm
	faction_discount = 0
	faction_locked = TRUE
