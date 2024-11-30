/datum/supply_pack/spacesuits
	group = "Spacesuits"
	crate_type = /obj/structure/closet/crate/secure

/*
		Spacesuits (two parts, helm and suit)
*/

/datum/supply_pack/spacesuits/spacesuit
	name = "Space Suit Crate"
	desc = "Contains one basic space suit. Although the technology is centuries old, it should protect you from the vacuum of space."
	cost = 500
	contains = list(/obj/item/clothing/suit/space,
					/obj/item/clothing/head/helmet/space)
	crate_name = "space suit crate"

/datum/supply_pack/spacesuits/pilot_spacesuit
	name = "Pilot Space Suit Crate"
	desc = "One pilot space suit, for improved mobility in exosuits."
	cost = 750
	contains = list(/obj/item/clothing/suit/space/pilot,
					/obj/item/clothing/head/helmet/space/pilot/random)
	crate_name = "pilot space suit crate"

/datum/supply_pack/spacesuits/engi_spacesuit
	name = "Engineering Space Suit Crate"
	desc = "Need to turn your ship into a safety hazard? Not a problem! This engineering space suit will help get the job done."
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/engineer,
					/obj/item/clothing/head/helmet/space/light/engineer)
	crate_name = "engineering space suit crate"
	crate_type = /obj/structure/closet/crate/secure/engineering

//syndicate

/datum/supply_pack/spacesuits/armored_spacesuit
	name = "Armored Space Suit Crate"
	desc = "Contains one armored spacesuit. Generic enough to be manufactured by most ex-Coalition groups."
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/syndicate/black,
					/obj/item/clothing/head/helmet/space/syndicate/black)
	faction = /datum/faction/syndicate
	faction_discount = 30

/datum/supply_pack/spacesuits/armored_engi_spacesuit
	name = "Coalition Engineering Space Suit Crate"
	desc = "Contains one lightly armored engineering spacesuit. Generic enough to be manufactured by most ex-Coalition groups."
	cost = 1000
	contains = list(/obj/item/clothing/suit/space/syndicate/black/engie,
					/obj/item/clothing/head/helmet/space/syndicate/black/engie)
	faction = /datum/faction/syndicate
	faction_locked = TRUE

//inteq

/datum/supply_pack/spacesuits/spacesuit/binteq
	name = "Inteq Space Suit Crate"
	desc = "Contains one IRMG Space Suit, manufactured aboard the Mothership and widely distributed among Inteq. Most of the cost is logistical in nature."
	cost = 500
	contains = list(/obj/item/clothing/suit/space/inteq,
					/obj/item/clothing/head/helmet/space/inteq)
	crate_name = "space suit crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

//solgov

/datum/supply_pack/spacesuits/spacesuit/solgov
	name = "Solarian Vacsuit Crate"
	desc = "Contains one Tortoise Microlite Armored Suit, the pride and joy of many Solarian explorers."
	cost = 600
	contains = list(/obj/item/clothing/suit/space/solgov,
					/obj/item/clothing/head/helmet/space/solgov)
	crate_name = "space suit crate"
	faction = /datum/faction/solgov
	faction_discount = 0
	faction_locked = TRUE

/*
		Hardsuits
*/

/datum/supply_pack/spacesuits/mining_hardsuits_indie
	name = "Mining Hardsuit Crate"
	desc = "One independent-manufactured mining hardsuit, for when explorer suits just dont cut it."
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/hardsuit/mining/independent)
	crate_name = "mining hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/spacesuits/sec_hardsuit_bundle
	name = "Security Hardsuit Crate"
	desc = "Contains one security hardsuit for light combat duty."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/security/independent)
	crate_name = "security hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear


//nt hardsuit breaker

/datum/supply_pack/spacesuits/med_hardsuit
	name = "Medical Hardsuit Crate"
	desc = "One medical hardsuit, resistant to diseases and useful for retrieving patients in space."
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/hardsuit/medical)
	crate_name = "medical hardsuit crate"
	crate_type = /obj/structure/closet/crate/medical
	faction = /datum/faction/nt

/datum/supply_pack/spacesuits/mining_hardsuit_heavy
	name = "Heavy Mining Hardsuit Crate"
	desc = "One heavy-duty mining hardsuit for dangerous frontier operations. Comes with a pair of EXOCOM jet boots."
	cost = 3500
	contains = list(/obj/item/clothing/suit/space/hardsuit/mining/heavy,
					/obj/item/clothing/shoes/bhop)
	crate_name = "heavy mining hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	faction = /datum/faction/nt

/datum/supply_pack/spacesuits/sci_hardsuit
	name = "Scientific Hardsuit Crate"
	desc = "Contains one science hardsuit, designed to provide safety under advanced experimental conditions."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/rd)
	crate_name = "scientific hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/science
	faction = /datum/faction/nt

/datum/supply_pack/spacesuits/atmos_hardsuit
	name = "Atmospherics Hardsuit Crate"
	desc = "The iconic hardsuit of Nanotrasen's Atmosphere Corps, this hardsuit is known across space as a symbol of defiance in the face of sudden decompression. Smells faintly of plasma."
	cost = 2500
	contains = list(/obj/item/clothing/suit/space/hardsuit/engine/atmos)
	crate_name = "atmospherics hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/advanced_hardsuit
	name = "Advanced Hardsuit Crate"
	desc = "The culimination of research into robust engineering equipment. This hardsuit makes the wearer near immune to the natural hazards the Frontier can throw."
	cost = 4000
	contains = list(/obj/item/clothing/suit/space/hardsuit/engine/elite)
	crate_name = "advanced hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

//cybersun breaker

/datum/supply_pack/spacesuits/neutron_hardsuit
	name = "Neutron Star Hardsuit Crate"
	desc = "Cybersuns premier offering in the field of combat hardsuits, the Neutron Star is incredibly effective against lasers, but lacks against ballistic weaponry. "
	cost = 3000
	contains = list(/obj/item/clothing/suit/space/hardsuit/syndi/cybersun)
	crate_name = "neutron star hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/syndicate/cybersun
	faction_locked = TRUE

/datum/supply_pack/spacesuits/neutron_hardsuit
	name = "CMT Hardsuit Crate"
	desc = "A reconfiguring of the Neutron Star hardsuit resulted in the CMT, or Cybersun Medical Technician hardsuit. The CMT protects against biological hazards, light weaponsfire, and the usual hazards of space."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/syndi/cybersun/paramed)
	crate_name = "neutron star hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/syndicate/cybersun
	faction_locked = TRUE

//inteq hardsuits
