/datum/supply_pack/spacesuits
	category = "Spacesuits"
	crate_type = /obj/structure/closet/crate/secure

/*
		Spacesuits (two parts, helm and suit)
*/

/datum/supply_pack/spacesuits/spacesuit
	name = "Space Suit Crate"
	desc = "Contains one basic space suit. Although the technology is centuries old, it should protect you from the vacuum of space."
	cost = 250 //changed the suit type to be the one without pockets, making it more consistent with the rest of the EVA suits available
	contains = list(/obj/item/clothing/suit/space/eva,
					/obj/item/clothing/head/helmet/space/eva)

/datum/supply_pack/spacesuits/pilot_spacesuit
	name = "Pilot Space Suit Crate"
	desc = "One pilot space suit, for improved mobility in exosuits."
	cost = 500
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

/datum/supply_pack/spacesuits/armored_spacesuit
	name = "Armored Space Suit Crate"
	desc = "Contains one lightly armored softsuit, able to protect against the smaller day-to-day hazards."
	cost = 1000
	contains = list(/obj/item/clothing/suit/space/syndicate/generic,
					/obj/item/clothing/head/helmet/space/syndicate/generic)
	crate_name = "armored softsuit crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
//syndicate

/datum/supply_pack/spacesuits/armored_spacesuit
	name = "Surplus Coalition Space Suit Crate"
	desc = "Contains one spacesuit. Generic enough to be manufactured and distributed by most ex-Coalition groups."
	cost = 500
	contains = list(/obj/item/clothing/suit/space/syndicate/surplus,
					/obj/item/clothing/head/helmet/space/syndicate/surplus)
	faction = /datum/faction/syndicate
	faction_discount = 30

/datum/supply_pack/spacesuits/armored_engi_spacesuit
	name = "Coalition Engineering Space Suit Crate"
	desc = "Contains one lightly armored engineering spacesuit. Generic enough to be manufactured by most ex-Coalition groups."
	cost = 1000
	contains = list(/obj/item/clothing/suit/space/syndicate/engie,
					/obj/item/clothing/head/helmet/space/syndicate/engie)
	faction = /datum/faction/syndicate
	faction_locked = TRUE
	faction_discount = 0

/datum/supply_pack/spacesuits/armored_hardliner
	name = "White-Red Space Suit Crate"
	desc = "WIP"
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/syndicate/white_red,
					/obj/item/clothing/head/helmet/space/syndicate/white_red)
	faction = /datum/faction/syndicate/hardliners
	faction_locked = TRUE
	faction_discount = 0

/datum/supply_pack/spacesuits/armored_ngr
	name = "Beige-Red Space Suit Crate"
	desc = "WIP"
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/syndicate/ngr,
					/obj/item/clothing/head/helmet/space/syndicate/ngr)
	faction = /datum/faction/syndicate/ngr
	faction_locked = TRUE
	faction_discount = 0

//inteq

/datum/supply_pack/spacesuits/spacesuit/inteq
	name = "Inteq Space Suit Crate"
	desc = "Contains one IRMG Space Suit, manufactured aboard the Mothership and widely distributed among Inteq. Most of the cost is logistical in nature."
	cost = 500
	contains = list(/obj/item/clothing/suit/space/inteq,
					/obj/item/clothing/head/helmet/space/inteq)
	crate_name = "space suit crate"
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/spacesuit/inteq/pilot
	name = "Inteq Pilot Space Suit Crate"
	desc = "Contains one lightweight suit designed for exosuit and shuttle pilots of the IRMG. While highly mobile, it offers poor protection against prolonged exposure to extreme temperatures of either end."
	cost = 500
	contains = list(/obj/item/clothing/suit/space/inteq/pilot,
					/obj/item/clothing/head/helmet/space/inteq/pilot)
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

//fucking gezena

/datum/supply_pack/spacesuits/spacesuit/pgf
	name = "Rakalla Navy Utility Suit Crate"
	desc = "Contains one Rakalla Utility Suit. The aging but beloved workhorse of Navy space operations."
	cost = 600
	contains = list(/obj/item/clothing/suit/space/gezena,
					/obj/item/clothing/head/helmet/space/gezena)
	crate_name = "rakalla suit crate"
	faction = /datum/faction/pgf
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/spacesuit/pgf/marine
	name = "Lataka Composite Combat Suit Crate"
	desc = "Contains one Lataka Combat Suit. The backbone of any Marine Corps space assault."
	cost = 1000
	contains = list(/obj/item/clothing/suit/space/gezena/marine,
					/obj/item/clothing/head/helmet/space/gezena/marine)
	crate_name = "lataka suit crate"
	faction = /datum/faction/pgf
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

/datum/supply_pack/spacesuits/eod_hardsuit
	name = "EOD Hardsuit Crate"
	desc = "Contains one EOD hardsuit, to provide safety with explosives."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/bomb)
	crate_name = "EOD hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/science

//nt hardsuit breaker

/datum/supply_pack/spacesuits/med_hardsuit
	name = "Medical Hardsuit Crate"
	desc = "One medical hardsuit, resistant to diseases and useful for retrieving patients in space."
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/hardsuit/medical)
	crate_name = "medical hardsuit crate"
	crate_type = /obj/structure/closet/crate/medical
	faction = /datum/faction/nt

/datum/supply_pack/spacesuits/engineering_hardsuit
	name = "Engineering Hardsuit Crate"
	desc = "One engineering hardsuit, resistant to fire, radiation, and other engineering hazards. Nanotrasen reminds you that Resistant does not mean Immune."
	cost = 1500
	contains = list(/obj/item/clothing/suit/space/hardsuit/engine)
	crate_name = "engineering hardsuit crate"
	crate_type = /obj/structure/closet/crate/medical
	faction = /datum/faction/nt

/datum/supply_pack/spacesuits/mining_hardsuit_heavy
	name = "Heavy Mining Hardsuit Crate"
	desc = "One heavy-duty mining hardsuit for dangerous frontier operations. Comes with a pair of EXOCOM jet boots."
	cost = 2500
	contains = list(/obj/item/clothing/suit/space/hardsuit/mining/heavy,
					/obj/item/clothing/shoes/bhop)
	crate_name = "heavy mining hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	faction = /datum/faction/nt

/datum/supply_pack/spacesuits/NS_hardsuit
	name = "N+S Hardsuit Crate"
	desc = "A N+S brand heavy operations mining hardsuit. Rated for extreme blunt force trauma, not bullets."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/mining/heavy/ns)
	crate_name = "N+S hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	faction = /datum/faction/nt
	faction_locked = TRUE

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

/datum/supply_pack/spacesuits/heavy_sec_hardsuit
	name = "Heavy Security Hardsuit Crate"
	desc = "Nanotrasen's premier solution to security hazards in low pressure environments, a well armored, highly mobile combat suit. The wearer is advised to have their zero-g training completed before utilizing the jetpack module."
	cost = 5000
	contains = list(/obj/item/clothing/suit/space/hardsuit/security/hos)
	crate_name = "advanced hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
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
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/cmt_hardsuit
	name = "CMT Hardsuit Crate"
	desc = "A reconfiguring of the Neutron Star hardsuit resulted in the CMT, or Cybersun Medical Technician hardsuit. The CMT protects against biological hazards, light weaponsfire, and the usual hazards of space."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/syndi/cybersun/paramed)
	crate_name = "neutron star hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/syndicate/cybersun
	faction_discount = 0
	faction_locked = TRUE

//inteq hardsuits

/datum/supply_pack/spacesuits/pointman_hardsuit
	name = "Pointman Hardsuit Crate"
	desc = "The heaviest armor fielded by Inteq, the Pointman is a modification of surplus Blood-Red hardsuits retrofitted to fit the IRMG's mission profile."
	cost = 5000
	contains = list(/obj/item/clothing/suit/space/hardsuit/syndi/inteq)
	crate_name = "pointman hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/inteq
	faction_locked = TRUE

/datum/supply_pack/spacesuits/inteq_hardsuit
	name = "Inteq Hardsuit Crate"
	desc = "A bulky Mothership-native design with a monocular viewport. The Inteq Hardsuit provides decent protection and combat manueverability for members of IRMG."
	cost = 3000
	contains = list(/obj/item/clothing/suit/space/hardsuit/security/inteq)
	crate_name = "inteq hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/eod_inteq
	name = "IRMG EOD Hardsuit Crate"
	desc = "Contains one EOD hardsuit, to provide safety with explosives."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/bomb/inteq)
	crate_name = "EOD hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/science
	faction = /datum/faction/inteq
	faction_discount = 0
	faction_locked = TRUE

//solarian hardsuit

/datum/supply_pack/spacesuits/solar_hardsuit
	name = "Solarian Hardsuit Crate"
	desc = "A heavy duty hardsuit manufactured for the Solarian Confederation. It provides decent protection while making use of an exoskeleton to stay mobile."
	cost = 5000
	contains = list(/obj/item/clothing/suit/space/hardsuit/solgov)
	crate_name = "solarian hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/solgov
	faction_discount = 0
	faction_locked = TRUE

//clip jardsuits

/datum/supply_pack/spacesuits/patroller_hardsuit
	name = "Patroller Hardsuit Crate"
	desc = "A lightly armored but highly manueverable suit utilized by the Confederated League. It allows the user to maintain a near full range of motion during usage."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/clip_patroller)
	crate_name = "patroller hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/spotter_hardsuit
	name = "Spotter Hardsuit Crate"
	desc = "A well armored hardsuit used as the counterpart to the Patroller, the Spotter lacks in mobility and makes up for it with bulky armor capable of protecting the user."
	cost = 4000
	contains = list(/obj/item/clothing/suit/space/hardsuit/clip_spotter)
	crate_name = "patroller hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/clip
	name = "CLIP softsuit crate"
	desc = "Contains one civilian-grade CLIP softsuit."
	cost = 500
	contains = list(/obj/item/clothing/suit/space/clip,
					/obj/item/clothing/head/helmet/space/clip)
	crate_name = "CLIP softsuit crate"
	crate_type = /obj/structure/closet/crate/secure/science
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/clip_armored
	name = "CLIP armored softsuit crate"
	desc = "Contains one civilian-grade CLIP armored softsuit."
	cost = 1000
	contains = list(/obj/item/clothing/suit/space/clip/armored,
					/obj/item/clothing/head/helmet/space/clip/armored)
	crate_name = "CLIP armored softsuit crate"
	crate_type = /obj/structure/closet/crate/secure/science
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/eod_clip
	name = "CMM EOD Hardsuit Crate"
	desc = "Contains one EOD hardsuit, to provide safety with explosives."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/bomb/clip)
	crate_name = "EOD hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/science
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

//jardline

/datum/supply_pack/spacesuits/white_red_hardsuit
	name = "White-Red Hardsuit Crate"
	desc = "Cybersun Biodynamics's proudly manufactured modification to the original production of Blood Red Hardsuits. Excellent protect, excellent mobility, and only a questionable sense in coloration."
	cost = 5000
	contains = list(/obj/item/clothing/suit/space/hardsuit/syndi/hl)
	crate_name = "white-red hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/syndicate/hardliners
	faction_discount = 0
	faction_locked = TRUE

//ngr

/datum/supply_pack/spacesuits/beige_red_hardsuit
	name = "Beige-Red Hardsuit Crate"
	desc = "A widely producted variation on the classic Blood-Red hardsuit produced by factories with in the New Gorlex Republic. This suit protects the wearer with thick plates and stylish colors."
	cost = 5000
	contains = list(/obj/item/clothing/suit/space/hardsuit/syndi/ngr)
	crate_name = "beige-red hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/syndicate/ngr
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/eod_ngr
	name = "NGR EOD Hardsuit Crate"
	desc = "Contains one EOD hardsuit, to provide safety with explosives."
	cost = 2000
	contains = list(/obj/item/clothing/suit/space/hardsuit/bomb/ngr)
	crate_name = "EOD hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/science
	faction = /datum/faction/syndicate/ngr
	faction_discount = 0
	faction_locked = TRUE

//srm

/datum/supply_pack/spacesuits/roumain_miningsuit
	name = "Roumain Hunter's Hardsuit Crate"
	desc = "A hardsuit manufactured by Hunter's Pride, widely used by a variety of hunters in the Saint-Roumain Militia."
	cost = 2500
	contains = list(/obj/item/clothing/suit/space/hardsuit/solgov/roumain)
	crate_name = "roumain hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/srm
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/spacesuits/roumain_hardsuit
	name = "Roumain Hardsuit Crate"
	desc = "A hardsuit hand-crafted to resemble plate armor of yore, the Roumain Hardsuit allows the wearer to swiftly move whilst on the hunt, while protecting them from the beasts around them."
	cost = 5000
	contains = list(/obj/item/clothing/suit/space/hardsuit/solgov/roumain)
	crate_name = "roumain hardsuit crate"
	crate_type = /obj/structure/closet/crate/secure/gear
	faction = /datum/faction/srm
	faction_discount = 0
	faction_locked = TRUE
