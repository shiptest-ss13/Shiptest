/datum/supply_pack/spacesuit_armor
	group = "Spacesuits & Armor"
	crate_type = /obj/structure/closet/crate/secure

/*
		Spacesuits (two parts, helm and suit)
*/

/datum/supply_pack/spacesuit_armor/spacesuit
	name = "Space Suit Crate"
	desc = "Contains one basic space suit. Although the technology is centuries old, it should protect you from the vacuum of space."
	cost = 500
	contains = list(/obj/item/clothing/suit/space,
					/obj/item/clothing/head/helmet/space)
	crate_name = "space suit crate"

/datum/supply_pack/spacesuit_armor/pilot_spacesuit
	name = "Pilot Space Suit Crate"
	desc = "One pilot space suit, for improved mobility in exosuits."
	cost = 750
	contains = list(/obj/item/clothing/suit/space/pilot,
					/obj/item/clothing/head/helmet/space/pilot/random)
	crate_name = "pilot space suit crate"

/datum/supply_pack/spacesuit_armor/mining_hardsuits_indie
	name = "Mining Hardsuit Crate"
	desc = "One independent-manufactured mining hardsuit, for when explorer suits just dont cut it."
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/hardsuit/mining/independent)
	crate_name = "mining hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	faction = FACTION_INDEPENDENT

/datum/supply_pack/spacesuit_armor/med_hardsuit
	name = "Medical Hardsuit Crate"
	desc = "One medical hardsuit, resistant to diseases and useful for retrieving patients in space."
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/hardsuit/medical)
	crate_name = "medical hardsuit crate"
	crate_type = /obj/structure/closet/crate/medical
	faction = FACTION_NT

/datum/supply_pack/spacesuit_armor/mining_hardsuit_heavy
	name = "Heavy Mining Hardsuit Crate"
	desc = "One deluxe heavy mining hardsuit for dangerous frontier operations. Comes with a pair of EXOCOM jet boots."
	cost = 3500
	contains = list(/obj/item/clothing/suit/space/hardsuit/mining/heavy,
					/obj/item/clothing/shoes/bhop)
	crate_name = "heavy mining hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	faction = FACTION_NT

/datum/supply_pack/spacesuit_armor/sec_hardsuit_bundle
	name = "Security Hardsuit Crate"
	desc = "Contains one security hardsuit for light combat duty."
	cost = 2500
	contains = list(/obj/item/clothing/suit/space/hardsuit/security/independent)
	crate_name = "security hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = FACTION_NT

/datum/supply_pack/spacesuit_armor/sci_hardsuit
	name = "Science Hardsuit Crate"
	desc = "Contains one science hardsuit, designed to provide safety under advanced experimental conditions."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/rd)
	crate_name = "science hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/science
	faction = FACTION_NT

/datum/supply_pack/spacesuit_armor/engi_spacesuit_bundle
	name = "Engineering Space Suit Crate"
	desc = "Need to turn your ship into a safety hazard? Not a problem! This engineering space suit will help get the job done."
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/engineer,
					/obj/item/clothing/head/helmet/space/light/engineer)
	crate_name = "engineering space suit crate"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/spacesuit_armor/atmos_hardsuit
	name = "Atmospherics Hardsuit Crate"
	desc = "The iconic hardsuit of Nanotrasen's Atmosphere Corps, this hardsuit is known across space as a symbol of defiance in the face of sudden decompression. Smells faintly of plasma."
	cost = 2500
	contains = list(/obj/item/clothing/suit/space/hardsuit/engine/atmos)
	crate_name = "atmospherics hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	faction = FACTION_NT

/datum/supply_pack/spacesuit_armor/swat
	name = "SWAT Crate"
	desc = "Contains one fullbody set of tough, fireproof, pressurized suit designed in a joint effort by IS-ERI and Nanotrasen. The set contains a suit, helmet, and combat belt."
	cost = 3500
	contains = list(/obj/item/clothing/head/helmet/swat/nanotrasen,
					/obj/item/clothing/suit/space/swat,
					/obj/item/storage/belt/military/assault)
	crate_name = "swat crate"
	crate_type = /obj/structure/closet/crate/secure/gear

/*
		Non-spaceworthy (armor)
*/

/datum/supply_pack/spacesuit_armor/basic_armor
	name = "Armor Crate"
	desc = "One set of well-rounded body armor. The set includes a helmet and vest."
	cost = 750
	contains = list(/obj/item/clothing/suit/armor/vest,
					/obj/item/clothing/head/helmet/sec)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/spacesuit_armor/riot_armor
	name = "Riot Armor Crate"
	desc = "Contains one full set of riot armor. Although heavily padded to deal with close-quarters threats, they perform poorly against most firearms."
	cost = 1500
	contains = list(/obj/item/clothing/suit/armor/riot,
					/obj/item/clothing/head/helmet/riot)
	crate_name = "riot armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/spacesuit_armor/bullet_armor
	name = "Bulletproof Armor Crate"
	desc = "Contains one full set of bulletproof armor, guaranteed to reduce a bullet's stopping power by half but with limited protection against melee weaponry."
	cost = 1750
	contains = list(/obj/item/clothing/suit/armor/vest/bulletproof,
					/obj/item/clothing/head/helmet/bulletproof,
					/obj/item/clothing/glasses/sunglasses/ballistic)
	crate_name = "bulletproof armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/spacesuit_armor/laser_armor
	name = "Reflector Vest Crate"
	desc = "Contains one vest made of highly reflective material. The armor piece diffuses a laser's energy by over half, as well as offering a good chance to reflect the laser entirely."
	cost = 1500
	contains = list(/obj/item/clothing/suit/armor/laserproof)
	crate_name = "reflector vest crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/spacesuit_armor/marine_armor
	name = "Tactical Armor Crate"
	desc = "One set of well-rounded tactical armor. While it does not protect the limbs, the vest is fairly durable. The set includes a helmet and vest."
	cost = 1500
	contains = list(/obj/item/clothing/suit/armor/vest/marine,
					/obj/item/clothing/head/helmet/marine)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/spacesuit_armor/medium_marine_armor
	name = "Medium Tactical Armor Crate"
	desc = "One set of well-rounded medium tactical body armor. Plates are attached to the vest and cover the limbs. The set includes a helmet and chestpiece."
	cost = 3000
	contains = list(/obj/item/clothing/suit/armor/vest/marine/medium,
					/obj/item/clothing/head/helmet/marine)
	crate_name = "armor crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
