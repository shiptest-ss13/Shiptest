/datum/supply_pack/tools
	category = "Tools & Tanks"
	crate_type = /obj/structure/closet/crate/engineering

/*
		Actual tools
*/

/datum/supply_pack/tools/toolbox
	name = "Tool Crate"
	desc = "Get some work done. Contains an electrical toolbox, a mechanical toolbox, and a welding helmet."
	contains = list(/obj/item/storage/toolbox/electrical,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/clothing/head/welding)
	cost = 200
	crate_name = "toolbox crate"

/datum/supply_pack/tools/engigear
	name = "Engineering Gear Crate"
	desc = "Contains one toolbelt and a set of meson goggles."
	cost = 250
	contains = list(/obj/item/storage/belt/utility,
					/obj/item/clothing/glasses/meson/engine)
	crate_name = "engineering gear crate"

/datum/supply_pack/tools/bodycamera
	name = "Body Camera Crate"
	desc = "Contains one portable camera, designed to help keep track of a working group at all times."
	cost = 100
	contains = list(/obj/item/bodycamera)
	crate_name = "bodycamera crate"

/datum/supply_pack/tools/assbelt
	name = "Assault Belt Crate"
	desc = "Contains an assault belt, with not one, not two, but six pockets."
	cost = 300
	contains = list(/obj/item/storage/belt/military/assault)
	crate_name = "assault belt crate"

/datum/supply_pack/tools/chestrig
	name = "Chest Rig Crate"
	desc = "Contains a chest rig, with seven places to store small items."
	cost = 500
	contains = list(/obj/item/storage/belt/military)
	crate_name = "chest rig crate"

/datum/supply_pack/tools/cellcharger
	name = "Cell Charger Crate"
	desc = "Contains a cell charger, able to charge all sorts of power cells."
	cost = 1000
	contains = list(/obj/machinery/cell_charger)

/datum/supply_pack/tools/rped
	name = "RPED crate"
	desc = "Tired of deconstructing all of your machines just to replace the power cells? This device has you covered. Actual parts not included."
	cost = 750
	contains = list(/obj/item/storage/part_replacer)
	crate_name = "\improper RPED crate"

/datum/supply_pack/tools/mining
	name = "Basic Mining Crate"
	desc = "Contains one miniature pickaxe, an ore bag, and a manual mining scanner."
	cost = 250 //cheaper to send your legions to war (mining) (also you can just print all this asides the scanners so what's the point anyway)
	contains = list(
		/obj/item/pickaxe/mini,
		/obj/item/storage/bag/ore,
		/obj/item/mining_scanner)
	crate_name = "basic mining crate"
	faction = /datum/faction/nt/ns_logi

/datum/supply_pack/tools/entrenching
	name = "Entrenching Tool Crate"
	desc = "Contains one dual-purpose mining tool, useful as a pickaxe, shovel, and weapon. Fits in your bag."
	cost = 500
	contains = list(/obj/item/trench_tool)
	crate_name = "mining crate"
	faction = /datum/faction/syndicate/ngr
	faction_discount = 20

/datum/supply_pack/tools/entrenching_gezena
	name = "PGF Entrenching Tool Crate"
	desc = "Contains one dual-purpose mining tool, useful as a pickaxe, shovel, and weapon. Fits in your bag, and personally manufactured for PGF use."
	cost = 500
	contains = list(/obj/item/trench_tool/gezena)
	crate_name = "mining crate"
	faction = /datum/faction/pgf
	faction_locked = TRUE
	faction_discount = 20

/datum/supply_pack/tools/jackhammer
	name = "Jackhammer Crate"
	desc = "Contains a jackhammer, ideal for breaking rocks."
	cost = 1750
	contains = list(/obj/item/pickaxe/drill/jackhammer)
	crate_name = "jackhammer crate"

/datum/supply_pack/tools/metalfoam
	name = "Metal Foam Grenade Crate"
	desc = "Seal up those pesky hull breaches with 7 metal foam grenades."
	cost = 1000
	contains = list(/obj/item/storage/box/metalfoam)
	crate_name = "metal foam grenade crate"

/datum/supply_pack/tools/insulated_gloves
	name = "Insulated Gloves Crate"
	desc = "The backbone of modern society. Contains a pair of insulated gloves."
	cost = 750
	contains = list(/obj/item/clothing/gloves/color/yellow)
	crate_name = "insulated gloves crate"

/datum/supply_pack/tools/inducer
	name = "Inducer Crate"
	desc = "An electromagnetic induction charging device, used for both field engineering/recharging and reactivation of Positronics. Not suitable for cooking."
	cost = 750
	contains = list(/obj/item/inducer)
	crate_name = "inducer crate"
	faction = /datum/faction/nt

/datum/supply_pack/tools/jetpack
	name = "Jetpack Crate"
	desc = "For when you need to go fast in space."
	cost = 750
	contains = list(/obj/item/tank/jetpack/carbondioxide)
	crate_name = "jetpack crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/tools/jetpack/harness
	name = "Jetpack Harness Crate"
	desc = "A compact jetpack harness for those who don't wish to be weighed down by larger traditional jetpacks."
	cost = 1500
	contains = list(/obj/item/tank/jetpack/oxygen/harness)

/datum/supply_pack/tools/jetpack/suit
	name = "Hardsuit Jetpack Upgrade Crate"
	desc = "A standardized jetpack attachment designed for direct integration with hardsuits. For when every gram matters."
	cost = 2000
	contains = list(/obj/item/tank/jetpack/suit)

/datum/supply_pack/tools/anglegrinder
	name = "Angle Grinder"
	desc = "Contains one angle grinder pack, a tool used for quick structure deconstruction and salvaging"
	cost = 1500
	contains = list(
		/obj/item/gear_pack/anglegrinder,
		/obj/item/radio/headset/alt
		)
	crate_name = "angle grinder crate"

/datum/supply_pack/tools/electric_welder
	name = "Electric Welder"
	desc = "Contains a single electric welder, useful for many applications. No fuel required!"
	cost = 850
	contains = list(/obj/item/weldingtool/electric)
	crate_name = "electric welder crate"

/datum/supply_pack/tools/welding_goggles
	name = "Welding Goggles"
	desc = "Contains a single pair of welding goggles for protecting your eyes."
	cost = 150
	contains = list(/obj/item/clothing/glasses/welding)
	crate_name = "welding goggles crate"

/datum/supply_pack/tools/plasmacutter
	name = "Plasmacutter Crate"
	desc = "Contains a plasmacutter, capable of rapidly breaking down hull."
	cost = 2500
	contains = list(/obj/item/plasmacutter)
	crate_name = "plasmacutter crate"

/datum/supply_pack/tools/sledgehammer
	name = "Sledgehammer Crate"
	desc = "Contains a freshly fabricated Breaching Sledgehammer, capable of wrecking hull and flesh with ease."
	cost = 1500
	contains = list(/obj/item/melee/sledgehammer/gorlex)
	crate_name = "sledgehammer crate"
	faction = /datum/faction/syndicate/ngr
	faction_locked = TRUE
	faction_discount = 0

/*
		Liquid tanks
*/

/datum/supply_pack/tools/fueltank
	name = "Fuel Tank Crate"
	desc = "Contains a welding fuel tank, for when your lust for welding is insatiable. Highly flammable."
	cost = 800
	contains = list(/obj/structure/reagent_dispensers/fueltank)
	crate_name = "fuel tank crate"
	crate_type = /obj/structure/closet/crate/large
	no_bundle = TRUE

/datum/supply_pack/tools/watertank
	name = "Fresh Water Supply Crate"
	desc = "Contains a tank of dihydrogen monoxide. Sounds dangerous."
	cost = 500
	contains = list(/obj/structure/reagent_dispensers/watertank)
	crate_name = "water tank crate"
	crate_type = /obj/structure/closet/crate/large
	no_bundle = TRUE

/datum/supply_pack/tools/hightank
	name = "Large Fresh Water Supply Crate"
	desc = "Contains a high-capacity water tank. Useful for botany or other service jobs."
	cost = 1500
	contains = list(/obj/structure/reagent_dispensers/watertank/high)
	crate_name = "high-capacity water tank crate"
	crate_type = /obj/structure/closet/crate/large
	no_bundle = TRUE

/datum/supply_pack/tools/foamtank
	name = "Firefighting Foam Tank Crate"
	desc = "Contains a tank of firefighting foam. Also known as \"Phorid's Bane\"."
	cost = 1500
	contains = list(/obj/structure/reagent_dispensers/foamtank)
	crate_name = "foam tank crate"
	crate_type = /obj/structure/closet/crate/large
	no_bundle = TRUE

/datum/supply_pack/tools/radfoamtank
	name = "Radiation Foam Tank Crate"
	desc = "Contains a tank of anti-radiation foam. Pressurized sprayer included!"
	cost = 1500
	contains = list(
		/obj/item/watertank/anti_rad,
		/obj/structure/reagent_dispensers/foamtank/antirad
	)
	crate_name = "foam tank crate"
	crate_type = /obj/structure/closet/crate/large
	no_bundle = TRUE
