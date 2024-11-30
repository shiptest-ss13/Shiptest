/datum/supply_pack/armor
	group = "Armor"
	crate_type = /obj/structure/closet/crate/secure


/*
		Non-spaceworthy (armor)
*/

/datum/supply_pack/armor/basic_armor
	name = "Armor Crate"
	desc = "One set of well-rounded body armor. The set includes a helmet and vest."
	cost = 750
	contains = list(/obj/item/clothing/suit/armor/vest,
					/obj/item/clothing/head/helmet/sec)
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
	desc = "Contains one vest made of highly reflective material. The armor piece diffuses a laser's energy by over half, as well as offering a good chance to reflect the laser entirely."
	cost = 1500
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
					/obj/item/clothing/head/helmet/bulletproof/x11)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
