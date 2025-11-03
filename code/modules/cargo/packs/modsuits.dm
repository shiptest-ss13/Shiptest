
/// commented out until we figure out what we're doing with modsuits
/*
/datum/supply_pack/modsuits
	category = "MODsuits"
	crate_type = /obj/structure/closet/crate/secure/gear

/*
	MODsuits
*/

/datum/supply_pack/modsuits/civilian
	name = "Civilian MODsuit"
	desc = "Contains a baseline civilian modsuit with integrated flashlights and welding protection."
	cost = 750
	contains = list(/obj/item/mod/control/pre_equipped/standard)

/datum/supply_pack/modsuits/engie
	name = "Engineering MODsuit"
	desc = "Contains a protective Engineering modsuit fitted for industrial work."
	cost = 2500
	contains = list(/obj/item/mod/control/pre_equipped/engineering)

/datum/supply_pack/modsuits/atmos
	name = "Atmospheric MODsuit"
	desc = "Contains an insulated atmospheric modsuit, capable of enduring absurd temperatures."
	cost = 2500
	contains = list(/obj/item/mod/control/pre_equipped/atmospheric)

/datum/supply_pack/modsuits/advanced
	name = "Advanced Engineering MODsuit"
	desc = "Contains an advanced engineering modsuit. We've put it through just about every industrial accident our engineering team could concoct, and the white finish is still untouched."
	cost = 4000
	contains = list(/obj/item/mod/control/pre_equipped/advanced)
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/modsuits/loader
	name = "Loader MODsuit"
	desc = "Contains a cargo loader modsuit. Features ample carrying space, though not atmospherically sealed."
	cost = 1500 // ripley at home
	contains = list(/obj/item/mod/control/pre_equipped/loader)

/datum/supply_pack/modsuits/mining
	name = "Mining MODsuit"
	desc = "Contains an armored mining modsuit. Features integrated mining tools for convienent carrying in the field."
	cost = 2500
	contains = list(/obj/item/mod/control/pre_equipped/mining)

/datum/supply_pack/modsuits/medical
	name = "Medical MODsuit"
	desc = "Contains a lightweight medical modsuit for paramedic work on the ground, or in EVA."
	cost = 2000
	contains = list(/obj/item/mod/control/pre_equipped/medical)

/datum/supply_pack/modsuits/rescue
	name = "Rescue Medical MODsuit"
	desc = "Contains an advanced medical modsuit with next-gen integrated medical systems."
	cost = 3500
	contains = list(/obj/item/mod/control/pre_equipped/rescue)
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/modsuits/research
	name = "Research MODsuit"
	desc = "Contains a high tech Research modsuit with onboard scanning systems and protective padding for fieldwork and handling hazardous materials."
	cost = 2500
	contains = list(/obj/item/mod/control/pre_equipped/research)

/datum/supply_pack/modsuits/security
	name = "Security MODsuit"
	desc = "Contains a protective security modsuit with integrated holsters."
	cost = 2500
	contains = list(/obj/item/mod/control/pre_equipped/security)

/datum/supply_pack/modsuits/safeguard
	name = "Safeguard MODsuit"
	desc = "Contains a well armored Safeguard modsuit, the premier of protection solutions."
	cost = 5500
	contains = list(/obj/item/mod/control/pre_equipped/safeguard)
	faction = /datum/faction/nt
	faction_discount = 0
	faction_locked = TRUE

/datum/supply_pack/modsuits/syndicate
	name = "Blood-Red MODsuit"
	desc = "Contains an experimental Blood-Red modsuit with integrated armor assist. Originally meant to replace the hardsuit model, the ICW ended before anything came of these things."
	cost = 5500
	contains = list(/obj/item/mod/control/pre_equipped/syndicate)
	faction = /datum/faction/syndicate
	faction_locked = TRUE

/*
	Modsuit Mods
*/

/datum/supply_pack/modsuits/welding
	name = "MOD Welding Protection Module"
	desc = "Contains a welding protection module to protect your eyes."
	cost = 500
	contains = list(/obj/item/mod/module/welding)

/datum/supply_pack/modsuits/magboot
	name = "MOD Magboot Module"
	desc = "Contains a magboot module for stability in zero-g."
	cost = 750
	contains = list(/obj/item/mod/module/magboot)

/datum/supply_pack/modsuits/tether
	name = "MOD Tether Module"
	desc = "Contains a grappling tether module for emergency movement in zero-g."
	cost = 250
	contains = list(/obj/item/mod/module/tether)

/datum/supply_pack/modsuits/toolset
	name = "MOD Toolset Module"
	desc = "Contains an integrated toolset module for engineering on the go."
	cost = 1000
	contains = list(/obj/item/mod/module/toolset)

/datum/supply_pack/modsuits/jetpack
	name = "MOD Ion Jetpack Module"
	desc = "Contains an integrated ion jetpack for self propulsion in zero-g."
	cost = 1250
	contains = list(/obj/item/mod/module/jetpack)

/datum/supply_pack/modsuits/mouthhole
	name = "MOD Eating Apparatus Module"
	desc = "Want to grab a bite in the field, but the air is full of toxic CO2? This handy eating apparatus creates a semi-permeable layer for food to pass through."
	cost = 100
	contains = list(/obj/item/mod/module/mouthhole)

/datum/supply_pack/modsuits/flashlight
	name = "MOD Flashlight Module"
	desc = "Contains an integrated flashlight to light up your way."
	cost = 100
	contains = list(/obj/item/mod/module/flashlight)

/datum/supply_pack/modsuits/thermal_regulator
	name = "MOD Thermal Regulator Module"
	desc = "Too hot? Too cold? This thermal regular will make sure you modsuit feels just right."
	cost = 250
	contains = list(/obj/item/mod/module/thermal_regulator)

/datum/supply_pack/modsuits/dna_lock
	name = "MOD DNA Lock Module"
	desc = "Afraid of someone jacking your MODsuit? This DNA lock will key your suit to your unique DNA."
	cost = 500
	contains = list(/obj/item/mod/module/dna_lock)

/datum/supply_pack/modsuits/plasma
	name = "MOD Plasma Stabalizer Module"
	desc = "This module creates a stable oxygen-free environment inside the suit for phorrid usage."
	cost = 100
	contains = list(/obj/item/mod/module/plasma_stabilizer)

/datum/supply_pack/modsuits/health_analyzer
	name = "MOD Health Analyzer Module"
	desc = "An integrated health analyzer that will provide health readouts at the flick of a wrist."
	cost = 500
	contains = list(/obj/item/mod/module/health_analyzer)

/datum/supply_pack/modsuits/injector
	name = "MOD Injector Module"
	desc = "Contains a highly precise needle capable of injecting through most clothing. Mostly painless."
	cost = 600
	contains = list(/obj/item/mod/module/injector)

/datum/supply_pack/modsuits/
	name = "MOD Surgical Toolset Module"
	desc = "Contains an integrated surgical toolset for operating on the go."
	cost = 2500
	contains = list(/obj/item/mod/module/opset)

/datum/supply_pack/modsuits/mag_harness
	name = "MOD Magnetic Harness Module"
	desc = "Drop your gun? This handy magnetic harness will pick it up for you."
	cost = 500
	contains = list(/obj/item/mod/module/magnetic_harness)

/datum/supply_pack/modsuits/holster
	name = "MOD Holster Module"
	desc = "Contains a holster module for secure carrying of your firearms."
	cost = 500
	contains = list(/obj/item/mod/module/holster)

/datum/supply_pack/modsuits/megaphone
	name = "MOD Megaphone Module"
	desc = "Contains a megaphone module, for getting people's attention."
	cost = 250
	contains = list(/obj/item/mod/module/megaphone)

/datum/supply_pack/modsuits/gps
	name = "MOD GPS Module"
	desc = "Contains a integrated GPS to help find your way."
	cost = 250
	contains = list(/obj/item/mod/module/gps)

/datum/supply_pack/modsuits/med_hud
	name = "MOD Medical Visor Module"
	desc = "Contains an integrated medical visor for accurate health readouts."
	cost = 500
	contains = list(/obj/item/mod/module/visor/medhud)

/datum/supply_pack/modsuits/diag_hud
	name = "MOD Diagnostic Visor Module"
	desc = "Contains an integrated diagnostic visor assessing mechanical issues."
	cost = 500
	contains = list(/obj/item/mod/module/visor/diaghud)

/datum/supply_pack/modsuits/sec_hud
	name = "MOD Security Visor Module"
	desc = "Contains an integrated security visor for accurate target assessement."
	cost = 500
	contains = list(/obj/item/mod/module/visor/sechud)

/datum/supply_pack/modsuits/meson
	name = "MOD Meson Visor Module"
	desc = "Contains an integrated meson visor for structural assessment."
	cost = 500
	contains = list(/obj/item/mod/module/visor/meson)

/datum/supply_pack/modsuits/reagent_hud
	name = "MOD reagent Scanner Module"
	desc = "Contains an integrated reagent scanner for sample analysis."
	cost = 500
	contains = list(/obj/item/mod/module/reagent_scanner)

*/





