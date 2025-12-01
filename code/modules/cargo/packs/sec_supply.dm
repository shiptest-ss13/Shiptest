/datum/supply_pack/sec_supply
	category = "Security Supplies"
	crate_type = /obj/structure/closet/crate/secure/gear

/*
		Standard supplies
*/
/datum/supply_pack/sec_supply/holster
	name = "Shoulder Holster Crate"
	desc = "Contains a shoulder holster, capable of holding a single pistol or revolver and your ammo."
	cost = 600
	contains = list(/obj/item/clothing/accessory/holster)
	crate_name = "holster crate"

/datum/supply_pack/sec_supply/seclite
	name = "Seclite Crate"
	desc = "Contains a single high power flashlight, complete with the hardware for attachment to standard helmet mounting brackets"
	contains = list(/obj/item/flashlight/seclite)
	cost = 100
	crate_name = "seclite crate"

/datum/supply_pack/sec_supply/securitybarriers
	name = "Security Barrier Grenade"
	desc = "Halt the opposition with one Security Barrier grenade."
	contains = list(/obj/item/grenade/barrier)
	cost = 125
	crate_name = "security barriers crate"

/datum/supply_pack/sec_supply/empty_sandbags
	name = "Empty Sandbags"
	desc = "Contains one box of seven empty sandbags for deployable cover in the field. Sand not included."
	contains = list(/obj/item/storage/box/emptysandbags)
	cost = 150
	crate_name = "sandbag crate"

/datum/supply_pack/sec_supply/maintenance_kit
	name = "Firearm Maintenance Kit"
	desc = "Contains a five-use firearm maintenance kit, useful for cleaning blood, sand, and mud out of guns."
	contains = list(/obj/item/gun_maint_kit)
	cost = 100 //Price check this later. It's probably fine but it might be okay if it's a little more expensive
	crate_name = "maintenance kit crate"

/datum/supply_pack/sec_supply/flashbangs
	name = "Flashbang Crate"
	desc = "Contains one flashbang for use in door breaching and riot control."
	cost = 200
	contains = list(/obj/item/grenade/flashbang)
	crate_name = "flashbangs crate"

/datum/supply_pack/sec_supply/smokebombs
	name = "Smoke Grenade Crate"
	desc = "Contains one smoke grenade for screening unit movements and signaling."
	cost = 70
	contains = list(/obj/item/grenade/smokebomb)
	crate_name = "smoke grenades crate"

/datum/supply_pack/sec_supply/teargas
	name = "Teargas Grenade Crate"
	desc = "Contains one teargas grenade for use in crowd dispersion and riot control."
	cost = 200
	contains = list(/obj/item/grenade/chem_grenade/teargas)
	crate_name = "teargas grenades crate"

/datum/supply_pack/sec_supply/camera_console
	name = "Camera Console Crate"
	desc = "Contains a camera console circuit board, for a comprehensive surveillance system and peace of mind."
	cost = 500
	contains = list(/obj/item/circuitboard/computer/security)
	crate_name = "camera console crate"

/*
		Pouches
*/

/datum/supply_pack/sec_supply/pouch
	name = "Utility Pouch Crate"
	desc = "Contains a small basic pouch for holding two small items of your choice."
	cost = 150
	contains = list(/obj/item/storage/pouch)
	crate_name = "pouch crate"

/datum/supply_pack/sec_supply/pouch_medical
	name = "Medical Pouch Crate"
	desc = "Contains a small IFAK for issuing to your crew for field triage. Comes pre-stocked with basic medical gear."
	cost = 250
	contains = list(/obj/item/storage/pouch/medical)
	crate_name = "pouch crate"

/datum/supply_pack/sec_supply/pouch_engi
	name = "Engineering Pouch Crate"
	desc = "Contains a small engineering pouch for holding various tools of your choice. Comes pre-stocked with emergency tools."
	cost = 250
	contains = list(/obj/item/storage/pouch/engi)
	crate_name = "pouch crate"

/datum/supply_pack/sec_supply/pouch_ammo
	name = "Ammo Pouch Crate"
	desc = "Contains a small pouch for holding either magazines or loose ammunition on the field. Remember, make them count!"
	cost = 150
	contains = list(/obj/item/storage/pouch/ammo)
	crate_name = "pouch crate"

/datum/supply_pack/sec_supply/pouch_grenade
	name = "Explosives Pouch Crate"
	desc = "Contains a pouch designed to hold frag grenades and C4 for use by demolitions experts across armed services."
	cost = 150
	contains = list(/obj/item/storage/pouch/grenade)
	crate_name = "pouch crate"

/datum/supply_pack/sec_supply/pouch_squad
	name = "Communications & Command Pouch Crate"
	desc = "Contains a medium command pouch for holding various items often used by commanders everywhere."
	cost = 150
	contains = list(/obj/item/storage/pouch/squad)
	crate_name = "pouch crate"

/*
		Misc. weapons / protection
*/

/datum/supply_pack/sec_supply/riotshields
	name = "Ballistic Shield Crate"
	desc = "Contains a ballistic shield, effective at holding back hostile fauna, xenofauna, or large crowds."
	cost = 1000
	contains = list(/obj/item/shield/riot)
	crate_name = "riot shield crate"

/datum/supply_pack/sec_supply/teleriotshields
	name = "Telescopic Riot Shield Crate"
	desc = "Contains a telescopic riot shield, effective at holding back hostile fauna, xenofauna, or large crowds in tight spaces."
	cost = 750
	contains = list(/obj/item/shield/riot/tele)
	crate_name = "riot shield crate"

/datum/supply_pack/sec_supply/survknives
	name = "Survival Knife Crate"
	desc = "Contains one sharpened survival knife. Guaranteed to fit snugly inside any galactic-standard boot."
	cost = 120
	contains = list(/obj/item/melee/knife/survival)
	crate_name = "survival knife crate"

/datum/supply_pack/sec_supply/machete
	name = "Stamped Steel Machete Crate"
	desc = "Contains one mass produced machete. A perfect choice for crews on a budget."
	cost = 250
	contains = list(/obj/item/melee/sword/mass)
	crate_name = "machete crate"

/datum/supply_pack/sec_supply/solarian_sabre
	name = "Solarian Ceremonial Sabre Crate"
	desc = "Contains one ceremonial Solarian sabre. To keep tradition alive. Still quite sharp."
	cost = 750
	contains = list(/obj/item/storage/belt/sabre/solgov)
	crate_name = "solarian ceremonial sabre crate"
	faction = /datum/faction/solgov
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/sec_supply/suns_sabre
	name = "SUNS Dueling Sabre Crate"
	desc = "Contains a single dueling sabre, intended for resolving conflicts among students."
	cost = 750
	contains = list(/obj/item/storage/belt/sabre/suns)
	crate_name = "student's sabre crate"
	faction = /datum/faction/syndicate/suns
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/sec_supply/suns_cmo_sabre
	name = "SUNS Cane Sabre Crate"
	desc = "Contains a blade sheathed in a cane. "
	cost = 800
	contains = list(/obj/item/storage/belt/sabre/suns/cmo)
	crate_name = "student's sabre crate"
	faction = /datum/faction/syndicate/suns
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/sec_supply/suns_telescopic_sabre
	name = "SUNS Telescopic Sabre Crate"
	desc = "Contains a finely crafted telescopic sabre, ideal for those with discerning tastes"
	cost = 600
	contains = list(/obj/item/melee/sword/sabre/suns/telescopic)
	crate_name = "telescopic sabre crate"
	faction = /datum/faction/syndicate/suns
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/sec_supply/pgf_boarding_cutlass
	name = "PGF Boarding Cutlass Crate"
	desc = "Contains a finely crafted cutlass, issued to boarding parties of the Pan-Gezenan Federation."
	cost = 750
	contains = list(/obj/item/storage/belt/sabre/pgf)
	crate_name = "boarding cutlass crate"
	faction = /datum/faction/pgf
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/sec_supply/combatknives
	name = "Combat Knife Crate"
	desc = "Contains one high quality combat knife. For the sharper, and meaner, crew."
	cost = 350
	contains = list(/obj/item/melee/knife/combat)
	crate_name = "combat knife crate"

/datum/supply_pack/sec_supply/clip_kukri
	name = "Kukri Sword Crate"
	desc = "Contains a well-made titanium kukri manufactured on Serene. Intended for Minuteman use."
	cost = 750
	contains = list(/obj/item/storage/belt/sabre/kukri)
	crate_name = "kukri crate"
	faction = /datum/faction/clip
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/sec_supply/cybersun_flyssa
	name = "Energy Flyssa Crate"
	desc = "Contains a lathed, verified, and readied Energy Flyssa. Corporate recommends owning a recharger to accompany."
	cost = 1500
	contains = list(/obj/item/melee/energy/flyssa)
	crate_name = "energy flyssa crate"
	faction = /datum/faction/syndicate/cybersun
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/sec_supply/hardliner_flyssa
	name = "Energy Flyssa Crate"
	desc = "Contains a lathed, verified, and readied Energy Flyssa. This is one of the assets you need to be careful to not lose."
	cost = 1500
	contains = list(/obj/item/melee/energy/flyssa)
	crate_name = "energy flyssa crate"
	faction = /datum/faction/syndicate/hardliners
	faction_discount = -50
	faction_locked = TRUE

/datum/supply_pack/sec_supply/flamethrower
	name = "Flamethrower Crate"
	desc = "Contains one flamethrower. Point the nozzle away from anything important."
	cost = 1250
	contains = list(/obj/item/flamethrower/full)
	crate_name = "flamethrower crate"
	crate_type = /obj/structure/closet/crate/secure/weapon
	faction = /datum/faction/syndicate/ngr
	faction_discount = 20

/datum/supply_pack/sec_supply/frag_grenade
	name = "Frag Grenade Crate"
	desc = "Contains one fragmentation grenade. Better not let it go off in your hands."
	cost = 500
	contains = list(/obj/item/grenade/frag)
	crate_name = "frag grenade crate"
	crate_type = /obj/structure/closet/crate/secure/weapon

/datum/supply_pack/sec_supply/c4duffel
	name = "C-4 Demolitions Charge Crate"
	desc = "Contains a duffel of C-4 demolitions charges, for use in scrapping and demolitions of large-scale structures."
	cost = 1000
	contains = list(/obj/item/storage/backpack/duffelbag/syndie/c4)
	crate_name = "demolitions charge crate"
	crate_type = /obj/structure/closet/crate/secure/weapon
	faction = /datum/faction/syndicate/ngr
	faction_discount = 10

/datum/supply_pack/sec_supply/halberd
	name = "Energy Halberd Crate"
	desc = "Contains one Solarian Energy Halberd, for issue to your local Sonnensoldner battalion."
	cost = 1500
	contains = list(/obj/item/melee/duelenergy/halberd)
	crate_name = "energy halberd crate"
	faction = /datum/faction/solgov
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/sec_supply/pepper_spray
	name = "Pepper Spray Crate"
	desc = "Contains one pepper spray can, for self defense on a budget."
	cost = 60
	contains = list(/obj/item/reagent_containers/spray/pepper)
	crate_name = "pepper spray crate"

/*
		Stamina / PVP weapons (intentionally overpriced due to odd balance position of stamina weapons)
*/

/datum/supply_pack/sec_supply/stingpack
	name = "Stingbang Grenade"
	desc = "Contains one \"stingbang\" grenade, perfect for stopping riots and playing morally unthinkable pranks."
	cost = 150
	contains = list(/obj/item/grenade/stingbang)
	crate_name = "stingbang grenade pack crate"

/datum/supply_pack/sec_supply/baton
	name = "Stun Baton Crate"
	desc = "Arm your vessel security with a stun baton. Batteries included."
	cost = 2500
	contains = list(/obj/item/melee/baton/loaded)
	crate_name = "stun baton crate"
/*
		Factional
*/

//gezena

/datum/supply_pack/tools/pgfwebbing
	name = "Gezenan Combat Webbing"
	desc = "Contains a lightweight harness covered in pouches for use in carrying ammunition and tools."
	cost = 500
	contains = list(/obj/item/storage/belt/military/gezena)
	crate_name = "webbing crate"
	faction = /datum/faction/pgf
	faction_discount = 0
	faction_locked = TRUE

