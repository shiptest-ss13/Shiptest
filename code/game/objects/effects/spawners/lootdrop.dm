/obj/effect/spawner/lootdrop
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "random_loot"
	layer = OBJ_LAYER
	var/lootcount = 1		//how many items will be spawned
	var/lootdoubles = TRUE	//if the same item can be spawned twice
	var/list/loot			//a list of possible items to spawn e.g. list(/obj/item, /obj/structure, /obj/effect)
	var/fan_out_items = FALSE //Whether the items should be distributed to offsets 0,1,-1,2,-2,3,-3.. This overrides pixel_x/y on the spawner itself

/obj/effect/spawner/lootdrop/Initialize(mapload)
	..()
	if(loot && loot.len)
		var/loot_spawned = 0
		while((lootcount-loot_spawned) && loot.len)
			var/lootspawn = pickweight_float(loot) // WS edit - Fix various startup runtimes
			while(islist(lootspawn))
				lootspawn = pickweight_float(lootspawn) // WS edit - Fix various startup runtimes
			if(!lootdoubles)
				loot.Remove(lootspawn)

			if(lootspawn)
				var/atom/movable/spawned_loot = new lootspawn(loc)
				if (!fan_out_items)
					if (pixel_x != 0)
						spawned_loot.pixel_x = pixel_x
					if (pixel_y != 0)
						spawned_loot.pixel_y = pixel_y
				else
					if (loot_spawned)
						spawned_loot.pixel_x = spawned_loot.pixel_y = ((!(loot_spawned%2)*loot_spawned/2)*-1)+((loot_spawned%2)*(loot_spawned+1)/2*1)
			else
				break // WS edit - Support spawn weights of 0 in loot tables and ruins
			loot_spawned++
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/lootdrop/donkpockets
	name = "donk pocket box spawner"
	lootdoubles = FALSE

	loot = list(
			/obj/item/storage/box/donkpockets/donkpocketspicy = 1,
			/obj/item/storage/box/donkpockets/donkpocketteriyaki = 1,
			/obj/item/storage/box/donkpockets/donkpocketpizza = 1,
			/obj/item/storage/box/donkpockets/donkpocketberry = 1,
			/obj/item/storage/box/donkpockets/donkpockethonk = 1,
		)


/obj/effect/spawner/lootdrop/armory_contraband
	name = "armory contraband gun spawner"
	lootdoubles = FALSE

	loot = list(
				/obj/item/gun/ballistic/automatic/pistol = 8,
				/obj/item/gun/ballistic/shotgun/automatic/combat = 5,
				/obj/item/gun/ballistic/automatic/pistol/deagle,
				/obj/item/gun/ballistic/revolver/mateba
				)

/obj/effect/spawner/lootdrop/armory_contraband/metastation
	loot = list(/obj/item/gun/ballistic/automatic/pistol = 5,
				/obj/item/gun/ballistic/shotgun/automatic/combat = 5,
				/obj/item/gun/ballistic/automatic/pistol/deagle,
				/obj/item/storage/box/syndie_kit/throwing_weapons = 3,
				/obj/item/gun/ballistic/revolver/mateba)

/obj/effect/spawner/lootdrop/armory_contraband/donutstation
	loot = list(/obj/item/grenade/clusterbuster/teargas = 5,
				/obj/item/gun/ballistic/shotgun/automatic/combat = 5,
				/obj/item/bikehorn/golden,
				/obj/item/grenade/clusterbuster,
				/obj/item/storage/box/syndie_kit/throwing_weapons = 3,
				/obj/item/gun/ballistic/revolver/mateba)

/obj/effect/spawner/lootdrop/prison_contraband
	name = "prison contraband loot spawner"
	loot = list(/obj/item/clothing/mask/cigarette/space_cigarette = 4,
				/obj/item/clothing/mask/cigarette/robust = 2,
				/obj/item/clothing/mask/cigarette/carp = 3,
				/obj/item/clothing/mask/cigarette/uplift = 2,
				/obj/item/clothing/mask/cigarette/dromedary = 3,
				/obj/item/clothing/mask/cigarette/robustgold = 1,
				/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
				/obj/item/storage/fancy/cigarettes = 3,
				/obj/item/clothing/mask/cigarette/rollie/cannabis = 4,
				/obj/item/toy/crayon/spraycan = 2,
				/obj/item/crowbar = 1,
				/obj/item/assembly/flash/handheld = 1,
				/obj/item/restraints/handcuffs/cable/zipties = 1,
				/obj/item/restraints/handcuffs = 1,
				/obj/item/radio/off = 1,
				/obj/item/lighter = 3,
				/obj/item/storage/box/matches = 3,
				/obj/item/reagent_containers/syringe/contraband/space_drugs = 1,
				/obj/item/reagent_containers/syringe/contraband/krokodil = 1,
				/obj/item/reagent_containers/syringe/contraband/crank = 1,
				/obj/item/reagent_containers/syringe/contraband/methamphetamine = 1,
				/obj/item/reagent_containers/syringe/contraband/bath_salts = 1,
				/obj/item/reagent_containers/syringe/contraband/fentanyl = 1,
				/obj/item/reagent_containers/syringe/contraband/morphine = 1,
				/obj/item/storage/pill_bottle/happy = 1,
				/obj/item/storage/pill_bottle/lsd = 1,
				/obj/item/storage/pill_bottle/psicodine = 1,
				/obj/item/reagent_containers/food/drinks/beer = 4,
				/obj/item/reagent_containers/food/drinks/bottle/whiskey = 1,
				/obj/item/paper/fluff/jobs/prisoner/letter = 1,
				/obj/item/grenade/smokebomb = 1,
				/obj/item/flashlight/seclite = 1,
				/obj/item/tailclub = 1, //want to buy makeshift wooden club sprite
				/obj/item/kitchen/knife/shiv = 4,
				/obj/item/kitchen/knife/shiv/carrot = 1,
				/obj/item/kitchen/knife = 1,
				/obj/item/storage/wallet/random = 1,
				/obj/item/pda = 1
				)

/obj/effect/spawner/lootdrop/gambling
	name = "gambling valuables spawner"
	loot = list(
				/obj/item/gun/ballistic/revolver/russian = 5,
				/obj/item/clothing/head/trapper = 3,
				/obj/item/storage/box/syndie_kit/throwing_weapons,
				/obj/item/coin/gold,
				/obj/item/reagent_containers/food/drinks/bottle/vodka/badminka,
				)

/obj/effect/spawner/lootdrop/grille_or_trash
	name = "maint grille or trash spawner"
	loot = list(/obj/structure/grille = 5,
			/obj/item/cigbutt = 1,
			/obj/item/trash/cheesie = 1,
			/obj/item/trash/candy = 1,
			/obj/item/trash/chips = 1,
			/obj/item/reagent_containers/food/snacks/deadmouse = 1,
			/obj/item/trash/pistachios = 1,
			/obj/item/trash/plate = 1,
			/obj/item/trash/popcorn = 1,
			/obj/item/trash/raisins = 1,
			/obj/item/trash/sosjerky = 1,
			/obj/item/trash/syndi_cakes = 1)

/obj/effect/spawner/lootdrop/three_course_meal
	name = "three course meal spawner"
	lootcount = 3
	lootdoubles = FALSE
	var/soups = list(
			/obj/item/reagent_containers/food/snacks/soup/beet,
			/obj/item/reagent_containers/food/snacks/soup/sweetpotato,
			/obj/item/reagent_containers/food/snacks/soup/stew,
			/obj/item/reagent_containers/food/snacks/soup/hotchili,
			/obj/item/reagent_containers/food/snacks/soup/nettle,
			/obj/item/reagent_containers/food/snacks/soup/meatball)
	var/salads = list(
			/obj/item/reagent_containers/food/snacks/salad/herbsalad,
			/obj/item/reagent_containers/food/snacks/salad/validsalad,
			/obj/item/reagent_containers/food/snacks/salad/fruit,
			/obj/item/reagent_containers/food/snacks/salad/jungle,
			/obj/item/reagent_containers/food/snacks/salad/aesirsalad)
	var/mains = list(
			/obj/item/reagent_containers/food/snacks/bearsteak,
			/obj/item/reagent_containers/food/snacks/enchiladas,
			/obj/item/reagent_containers/food/snacks/stewedsoymeat,
			/obj/item/reagent_containers/food/snacks/burger/bigbite,
			/obj/item/reagent_containers/food/snacks/burger/superbite,
			/obj/item/reagent_containers/food/snacks/burger/fivealarm)

/obj/effect/spawner/lootdrop/three_course_meal/Initialize(mapload)
	loot = list(pick(soups) = 1,pick(salads) = 1,pick(mains) = 1)
	. = ..()

/obj/effect/spawner/lootdrop/maintenance
	name = "maintenance loot spawner"
	// see code/_globalvars/lists/maintenance_loot.dm for loot table

/obj/effect/spawner/lootdrop/maintenance/Initialize(mapload)
	loot = GLOB.maintenance_loot
	. = ..()

/obj/effect/spawner/lootdrop/maintenance/two
	name = "2 x maintenance loot spawner"
	lootcount = 2

/obj/effect/spawner/lootdrop/maintenance/three
	name = "3 x maintenance loot spawner"
	lootcount = 3

/obj/effect/spawner/lootdrop/maintenance/four
	name = "4 x maintenance loot spawner"
	lootcount = 4

/obj/effect/spawner/lootdrop/maintenance/five
	name = "5 x maintenance loot spawner"
	lootcount = 5

/obj/effect/spawner/lootdrop/maintenance/six
	name = "6 x maintenance loot spawner"
	lootcount = 6

/obj/effect/spawner/lootdrop/maintenance/seven
	name = "7 x maintenance loot spawner"
	lootcount = 7

/obj/effect/spawner/lootdrop/maintenance/eight
	name = "8 x maintenance loot spawner"
	lootcount = 8

/obj/effect/spawner/lootdrop/crate_spawner
	name = "lootcrate spawner" //USE PROMO CODE "SELLOUT" FOR 20% OFF!
	lootdoubles = FALSE

	loot = list(
				/obj/structure/closet/crate/secure/loot = 20,
				"" = 80
				)

/obj/effect/spawner/lootdrop/organ_spawner
	name = "ayylien organ spawner"
	loot = list(
		/obj/item/organ/heart/gland/electric = 3,
		/obj/item/organ/heart/gland/trauma = 4,
		/obj/item/organ/heart/gland/egg = 7,
		/obj/item/organ/heart/gland/chem = 5,
		/obj/item/organ/heart/gland/mindshock = 5,
		/obj/item/organ/heart/gland/plasma = 7,
		/obj/item/organ/heart/gland/transform = 5,
		/obj/item/organ/heart/gland/slime = 4,
		/obj/item/organ/heart/gland/spiderman = 5,
		/obj/item/organ/heart/gland/ventcrawling = 1,
		/obj/item/organ/body_egg/alien_embryo = 1,
		/obj/item/organ/regenerative_core = 2)
	lootcount = 3

/obj/effect/spawner/lootdrop/memeorgans
	name = "meme organ spawner"
	loot = list(
		/obj/item/organ/ears/penguin,
		/obj/item/organ/ears/cat,
		/obj/item/organ/eyes/compound,
		/obj/item/organ/eyes/snail,
		/obj/item/organ/tongue/bone,
		/obj/item/organ/tongue/fly,
		/obj/item/organ/tongue/snail,
		/obj/item/organ/tongue/lizard,
		/obj/item/organ/tongue/alien,
		/obj/item/organ/tongue/ethereal,
		/obj/item/organ/tongue/robot,
		/obj/item/organ/tongue/zombie,
		/obj/item/organ/appendix,
		/obj/item/organ/liver/fly,
		/obj/item/organ/lungs/plasmaman,
		/obj/item/organ/tail/cat,
		/obj/item/organ/tail/lizard)
	lootcount = 5

/obj/effect/spawner/lootdrop/rnd
	name = "random RND spawner"
	loot = list(
		/obj/item/storage/box/rndmining,
		/obj/item/storage/box/rndengi,
		/obj/item/storage/box/rndsec,
		/obj/item/storage/box/rndciv,
		/obj/item/storage/box/rndmed)
	lootcount = 1

/obj/effect/spawner/lootdrop/two_percent_xeno_egg_spawner
	name = "2% chance xeno egg spawner"
	loot = list(
		/obj/effect/decal/remains/xeno = 49,
		/obj/effect/spawner/xeno_egg_delivery = 1)

/obj/effect/spawner/lootdrop/costume
	name = "random costume spawner"

/obj/effect/spawner/lootdrop/costume/Initialize()
	loot = list()
	for(var/path in subtypesof(/obj/effect/spawner/bundle/costume))
		loot[path] = TRUE
	. = ..()

// Minor lootdrops follow

/obj/effect/spawner/lootdrop/minor/beret_or_rabbitears
	name = "beret or rabbit ears spawner"
	loot = list(
		/obj/item/clothing/head/beret = 1,
		/obj/item/clothing/head/rabbitears = 1)

/obj/effect/spawner/lootdrop/minor/bowler_or_that
	name = "bowler or top hat spawner"
	loot = list(
		/obj/item/clothing/head/bowler = 1,
		/obj/item/clothing/head/that = 1)

/obj/effect/spawner/lootdrop/minor/kittyears_or_rabbitears
	name = "kitty ears or rabbit ears spawner"
	loot = list(
		/obj/item/clothing/head/kitty = 1,
		/obj/item/clothing/head/rabbitears = 1)

/obj/effect/spawner/lootdrop/minor/pirate_or_bandana
	name = "pirate hat or bandana spawner"
	loot = list(
		/obj/item/clothing/head/pirate = 1,
		/obj/item/clothing/head/bandana = 1)

/obj/effect/spawner/lootdrop/minor/twentyfive_percent_cyborg_mask
	name = "25% cyborg mask spawner"
	loot = list(
		/obj/item/clothing/mask/gas/cyborg = 25,
		"" = 75)

/obj/effect/spawner/lootdrop/aimodule_harmless // These shouldn't allow the AI to start butchering people
	name = "harmless AI module spawner"
	loot = list(
				/obj/item/aiModule/core/full/asimov,
				/obj/item/aiModule/core/full/asimovpp,
				/obj/item/aiModule/core/full/hippocratic,
				/obj/item/aiModule/core/full/paladin_devotion,
				/obj/item/aiModule/core/full/paladin
				)

/obj/effect/spawner/lootdrop/aimodule_neutral // These shouldn't allow the AI to start butchering people without reason
	name = "neutral AI module spawner"
	loot = list(
				/obj/item/aiModule/core/full/corp,
				/obj/item/aiModule/core/full/maintain,
				/obj/item/aiModule/core/full/drone,
				/obj/item/aiModule/core/full/peacekeeper,
				/obj/item/aiModule/core/full/reporter,
				/obj/item/aiModule/core/full/robocop,
				/obj/item/aiModule/core/full/liveandletlive,
				/obj/item/aiModule/core/full/hulkamania
				)

/obj/effect/spawner/lootdrop/aimodule_harmful // These will get the shuttle called
	name = "harmful AI module spawner"
	loot = list(
				/obj/item/aiModule/core/full/antimov,
				/obj/item/aiModule/core/full/balance,
				/obj/item/aiModule/core/full/tyrant,
				/obj/item/aiModule/core/full/thermurderdynamic,
				/obj/item/aiModule/core/full/damaged,
				/obj/item/aiModule/reset/purge
				)

// Tech storage circuit board spawners

/obj/effect/spawner/lootdrop/techstorage
	name = "generic circuit board spawner"
	lootdoubles = FALSE
	fan_out_items = TRUE
	lootcount = INFINITY

/obj/effect/spawner/lootdrop/techstorage/service
	name = "service circuit board spawner"
	loot = list(
				/obj/item/circuitboard/computer/arcade/battle,
				/obj/item/circuitboard/computer/arcade/orion_trail,
				/obj/item/circuitboard/machine/autolathe,
				/obj/item/circuitboard/computer/mining,
				/obj/item/circuitboard/machine/ore_redemption,
				/obj/item/circuitboard/machine/vending/mining_equipment,
				/obj/item/circuitboard/machine/microwave,
				/obj/item/circuitboard/machine/chem_dispenser/drinks,
				/obj/item/circuitboard/machine/chem_dispenser/drinks/beer,
				/obj/item/circuitboard/computer/slot_machine
				)

/obj/effect/spawner/lootdrop/techstorage/rnd
	name = "RnD circuit board spawner"
	loot = list(
				/obj/item/circuitboard/computer/aifixer,
				/obj/item/circuitboard/machine/rdserver,
				/obj/item/circuitboard/machine/mechfab,
				/obj/item/circuitboard/machine/circuit_imprinter/department,
				/obj/item/circuitboard/computer/teleporter,
				/obj/item/circuitboard/machine/destructive_analyzer,
				/obj/item/circuitboard/computer/rdconsole,
				/obj/item/circuitboard/computer/nanite_chamber_control,
				/obj/item/circuitboard/computer/nanite_cloud_controller,
				/obj/item/circuitboard/machine/nanite_chamber,
				/obj/item/circuitboard/machine/nanite_programmer,
				/obj/item/circuitboard/machine/nanite_program_hub
				)

/obj/effect/spawner/lootdrop/techstorage/security
	name = "security circuit board spawner"
	loot = list(
				/obj/item/circuitboard/computer/secure_data,
				/obj/item/circuitboard/computer/security,
				/obj/item/circuitboard/computer/prisoner
				)

/obj/effect/spawner/lootdrop/techstorage/engineering
	name = "engineering circuit board spawner"
	loot = list(
				/obj/item/circuitboard/computer/atmos_alert,
				/obj/item/circuitboard/computer/stationalert,
				/obj/item/circuitboard/computer/powermonitor
				)

/obj/effect/spawner/lootdrop/techstorage/tcomms
	name = "tcomms circuit board spawner"
	loot = list(
				/obj/item/circuitboard/computer/message_monitor,
				/obj/item/circuitboard/machine/telecomms/broadcaster,
				/obj/item/circuitboard/machine/telecomms/bus,
				/obj/item/circuitboard/machine/telecomms/server,
				/obj/item/circuitboard/machine/telecomms/receiver,
				/obj/item/circuitboard/machine/telecomms/processor,
				/obj/item/circuitboard/machine/announcement_system,
				/obj/item/circuitboard/computer/comm_server,
				/obj/item/circuitboard/computer/comm_monitor
				)

/obj/effect/spawner/lootdrop/techstorage/medical
	name = "medical circuit board spawner"
	loot = list(
				/obj/item/circuitboard/machine/chem_dispenser,
				/obj/item/circuitboard/computer/scan_consolenew,
				/obj/item/circuitboard/computer/med_data,
				/obj/item/circuitboard/machine/smoke_machine,
				/obj/item/circuitboard/machine/chem_master,
				/obj/item/circuitboard/machine/dnascanner,
				/obj/item/circuitboard/computer/pandemic
				)

/obj/effect/spawner/lootdrop/techstorage/AI
	name = "secure AI circuit board spawner"
	loot = list(
				/obj/item/circuitboard/computer/aiupload,
				/obj/item/circuitboard/computer/borgupload,
				/obj/item/circuitboard/aicore
				)

/obj/effect/spawner/lootdrop/techstorage/command
	name = "secure command circuit board spawner"
	loot = list(
				/obj/item/circuitboard/computer/crew,
				/obj/item/circuitboard/computer/communications,
				/obj/item/circuitboard/computer/card
				)

/obj/effect/spawner/lootdrop/techstorage/RnD_secure
	name = "secure RnD circuit board spawner"
	loot = list(
				/obj/item/circuitboard/computer/mecha_control,
				/obj/item/circuitboard/computer/apc_control,
				/obj/item/circuitboard/computer/robotics
				)

/obj/effect/spawner/lootdrop/mafia_outfit
	name = "mafia outfit spawner"
	loot = list(
				/obj/effect/spawner/bundle/costume/mafia = 20,
				/obj/effect/spawner/bundle/costume/mafia/white = 5,
				/obj/effect/spawner/bundle/costume/mafia/checkered = 2,
				/obj/effect/spawner/bundle/costume/mafia/beige = 5
				)

/obj/effect/spawner/lootdrop/salvage_machine
	name = "salvageable machine spawner"
	loot = list(
				/obj/structure/salvageable/protolathe,
				/obj/structure/salvageable/circuit_imprinter,
				/obj/structure/salvageable/server,
				/obj/structure/salvageable/machine,
				/obj/structure/salvageable/autolathe,
				/obj/structure/salvageable/computer,
				/obj/structure/salvageable/destructive_analyzer
				)

/obj/effect/spawner/lootdrop/salvage_50
	name = "50% salvage spawner"
	loot = list(
				/obj/effect/spawner/lootdrop/maintenance = 13,
				/obj/effect/spawner/lootdrop/salvage_machine = 12,
				/obj/effect/spawner/lootdrop/whiteship_cere_ripley = 12,
				/obj/structure/closet/crate/secure/loot = 13,
				"" = 50
				)

//finds the probabilities of items spawning from a loot spawner's loot pool
/obj/item/loot_table_maker
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "random_loot"
	var/spawner_to_test = /obj/effect/spawner/lootdrop/maintenance //what lootdrop spawner to use the loot pool of
	var/loot_count = 180 //180 is about how much maint loot spawns per map as of 11/14/2019
	//result outputs
	var/list/spawned_table //list of all items "spawned" and how many
	var/list/stat_table //list of all items "spawned" and their occurrance probability

/obj/item/loot_table_maker/Initialize()
	. = ..()
	make_table()

/obj/item/loot_table_maker/attack_self(mob/user)
	to_chat(user, "Loot pool re-rolled.")
	make_table()

/obj/item/loot_table_maker/proc/make_table()
	spawned_table = list()
	stat_table = list()
	var/obj/effect/spawner/lootdrop/spawner_to_table = new spawner_to_test
	var/lootpool = spawner_to_table.loot
	qdel(spawner_to_table)
	for(var/i in 1 to loot_count)
		var/loot_spawn = pick_loot(lootpool)
		if(!loot_spawn) // WS edit - Support spawn weights of 0 in loot tables and ruins
			continue
		if(!(loot_spawn in spawned_table))
			spawned_table[loot_spawn] = 1
		else
			spawned_table[loot_spawn] += 1
	stat_table += spawned_table
	for(var/item in stat_table)
		stat_table[item] /= loot_count

/obj/item/loot_table_maker/proc/pick_loot(lootpool) //selects path from loot table and returns it
	var/lootspawn = pickweight_float(lootpool) // WS edit - Fix various startup runtimes
	while(islist(lootspawn))
		lootspawn = pickweight_float(lootspawn) // WS edit - Fix various startup runtimes
	return lootspawn

/obj/effect/spawner/lootdrop/stockparts
	name = "random good stock parts"
	lootcount = 6
	loot = list(
				/obj/item/stock_parts/capacitor/adv,
				/obj/item/stock_parts/capacitor/quadratic,
				/obj/item/stock_parts/capacitor/super,
				/obj/item/stock_parts/cell/hyper,
				/obj/item/stock_parts/cell/super,
				/obj/item/stock_parts/cell/bluespace,
				/obj/item/stock_parts/matter_bin/bluespace,
				/obj/item/stock_parts/matter_bin/super,
				/obj/item/stock_parts/matter_bin/adv,
				/obj/item/stock_parts/micro_laser/ultra,
				/obj/item/stock_parts/micro_laser/quadultra,
				/obj/item/stock_parts/micro_laser/high,
				/obj/item/stock_parts/scanning_module/triphasic,
				/obj/item/stock_parts/scanning_module/phasic,
				/obj/item/stock_parts/scanning_module/adv,
				/obj/item/reagent_containers/glass/beaker/bluespace,
				/obj/item/reagent_containers/glass/beaker/plastic,
				/obj/item/reagent_containers/glass/beaker/large,
				/obj/item/stock_parts/manipulator/nano,
				/obj/item/stock_parts/manipulator/pico,
				/obj/item/stock_parts/manipulator/femto
				)

/obj/effect/spawner/lootdrop/materials
	name = "random bulk materials"
	lootcount = 2
	loot = list(
				/obj/item/stack/sheet/plastic/fifty,
				/obj/item/stack/sheet/bluespace_crystal/twenty,
				/obj/item/stack/sheet/cardboard/fifty,
				/obj/item/stack/sheet/glass/fifty,
				/obj/item/stack/sheet/metal/fifty,
				/obj/item/stack/sheet/plasteel/twenty,
				/obj/item/stack/sheet/mineral/plasma/fifty,
				/obj/item/stack/sheet/mineral/silver/fifty,
				/obj/item/stack/sheet/mineral/titanium/fifty,
				/obj/item/stack/sheet/mineral/uranium/fifty,
				/obj/item/stack/sheet/mineral/wood/fifty,
				/obj/item/stack/sheet/mineral/diamond/twenty,
				/obj/item/stack/sheet/mineral/gold/fifty,
				/obj/item/stack/sheet/mineral/adamantine/ten,
				/obj/item/stack/cable_coil/red,
				/obj/item/stack/rods/fifty
				)

/obj/effect/spawner/lootdrop/spacegym
	name = "spacegym loot spawner"
	lootdoubles = FALSE

	loot = list(
			/obj/item/dnainjector/hulkmut = 1,
			/obj/item/dnainjector/dwarf = 1,
			/obj/item/dnainjector/gigantism = 1,
			/obj/item/reagent_containers/food/snacks/meat/cutlet/chicken = 1,
			/obj/item/clothing/under/shorts/black = 1,
			/obj/item/clothing/under/shorts/blue = 1,
			/obj/item/clothing/under/shorts/red = 1,
			/obj/item/restraints/handcuffs = 1,
			/obj/item/storage/pill_bottle/stimulant = 1,
			/obj/item/storage/firstaid/regular = 1,
			/obj/item/storage/box/handcuffs = 1,
		)

/obj/effect/spawner/lootdrop/singularitygen
	name = "Tesla or Singulo spawner"
	lootdoubles = FALSE

	loot = list(
		/obj/machinery/the_singularitygen/tesla = 1,
		/obj/machinery/the_singularitygen = 1,
	)

/obj/effect/spawner/lootdrop/stockparts
	name = "random good stock parts"
	lootcount = 5
	loot = list(
				/obj/item/stock_parts/capacitor/adv,
				/obj/item/stock_parts/capacitor/quadratic,
				/obj/item/stock_parts/capacitor/super,
				/obj/item/stock_parts/cell/hyper,
				/obj/item/stock_parts/cell/super,
				/obj/item/stock_parts/cell/bluespace,
				/obj/item/stock_parts/matter_bin/bluespace,
				/obj/item/stock_parts/matter_bin/super,
				/obj/item/stock_parts/matter_bin/adv,
				/obj/item/stock_parts/micro_laser/ultra,
				/obj/item/stock_parts/micro_laser/quadultra,
				/obj/item/stock_parts/micro_laser/high,
				/obj/item/stock_parts/scanning_module/triphasic,
				/obj/item/stock_parts/scanning_module/phasic,
				/obj/item/stock_parts/scanning_module/adv,
				/obj/item/reagent_containers/glass/beaker/bluespace,
				/obj/item/reagent_containers/glass/beaker/plastic,
				/obj/item/reagent_containers/glass/beaker/large,
				/obj/item/stock_parts/manipulator/nano,
				/obj/item/stock_parts/manipulator/pico,
				/obj/item/stock_parts/manipulator/femto
				)

/obj/effect/spawner/lootdrop/materials
	name = "random materials"
	lootcount = 3
	loot = list(
				/obj/item/stack/sheet/plastic/fifty,
				/obj/item/stack/sheet/plastic/five,
				/obj/item/stack/sheet/bluespace_crystal/twenty,
				/obj/item/stack/sheet/bluespace_crystal/five,
				/obj/item/stack/sheet/cardboard/fifty,
				/obj/item/stack/sheet/glass/fifty,
				/obj/item/stack/sheet/metal/fifty,
				/obj/item/stack/sheet/metal/twenty,
				/obj/item/stack/sheet/plasteel/twenty,
				/obj/item/stack/sheet/mineral/plasma/fifty,
				/obj/item/stack/sheet/mineral/plasma/twenty,
				/obj/item/stack/sheet/mineral/silver/fifty,
				/obj/item/stack/sheet/mineral/titanium/twenty,
				/obj/item/stack/sheet/mineral/uranium/twenty,
				/obj/item/stack/sheet/mineral/wood/fifty,
				/obj/item/stack/sheet/mineral/diamond/twenty,
				/obj/item/stack/sheet/mineral/gold/fifty,
				/obj/item/stack/sheet/mineral/adamantine/ten,
				/obj/item/stack/cable_coil/red,
				/obj/item/stack/rods/fifty
				)

/obj/effect/spawner/lootdrop/donut
	name = "random donut" //donut :)
	lootcount = 1
	loot = list(
				/obj/item/reagent_containers/food/snacks/donut/apple = 1,
				/obj/item/reagent_containers/food/snacks/donut/berry = 1,
				/obj/item/reagent_containers/food/snacks/donut/caramel = 1,
				/obj/item/reagent_containers/food/snacks/donut/choco = 1,
				/obj/item/reagent_containers/food/snacks/donut/laugh = 1,
				/obj/item/reagent_containers/food/snacks/donut/matcha = 1,
				/obj/item/reagent_containers/food/snacks/donut/meat = 1,
				/obj/item/reagent_containers/food/snacks/donut/plain = 1,
				/obj/item/reagent_containers/food/snacks/donut/trumpet = 1,
				/obj/item/reagent_containers/food/snacks/donut/blumpkin = 1,
				/obj/item/reagent_containers/food/snacks/donut/bungo = 1,
				/obj/item/reagent_containers/food/snacks/donut/chaos = 1,
	)

/obj/effect/spawner/lootdrop/donut/jelly
	name = "random jelly donut"
	lootcount = 1
	loot = list(
				/obj/item/reagent_containers/food/snacks/donut/jelly/berry = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/apple = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/blumpkin = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/bungo = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/caramel = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/choco = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/laugh = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/matcha = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/trumpet = 1,
	)

/obj/effect/spawner/lootdrop/donut/slimejelly
	name = "random slimejelly donut"
	lootcount = 1
	loot = list(
				/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/apple = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/berry = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/blumpkin = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/bungo = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/caramel = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/choco = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/laugh = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/matcha = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain = 1,
				/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/trumpet = 1,
	)

/obj/effect/spawner/lootdrop/seeded
	name = "GO FORTH AND CULTIVATE"
	icon = 'icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed"//sneed
	loot = list(
		/obj/item/seeds/aloe,
		/obj/item/seeds/ambrosia,
		/obj/item/seeds/apple,
		/obj/item/seeds/cotton,
		/obj/item/seeds/banana,
		/obj/item/seeds/berry,
		/obj/item/seeds/cabbage,
		/obj/item/seeds/carrot,
		/obj/item/seeds/cherry,
		/obj/item/seeds/chanter,
		/obj/item/seeds/chili,
		/obj/item/seeds/cocoapod,
		/obj/item/seeds/coffee,
		/obj/item/seeds/corn,
		/obj/item/seeds/eggplant,
		/obj/item/seeds/garlic,
		/obj/item/seeds/grape,
		/obj/item/seeds/grass,
		/obj/item/seeds/lemon,
		/obj/item/seeds/lime,
		/obj/item/seeds/onion,
		/obj/item/seeds/orange,
		/obj/item/seeds/peas,
		/obj/item/seeds/pineapple,
		/obj/item/seeds/potato,
		/obj/item/seeds/poppy,
		/obj/item/seeds/pumpkin,
		/obj/item/seeds/wheat/rice,
		/obj/item/seeds/soya,
		/obj/item/seeds/sugarcane,
		/obj/item/seeds/sunflower,
		/obj/item/seeds/tea,
		/obj/item/seeds/tobacco,
		/obj/item/seeds/tomato,
		/obj/item/seeds/tower,
		/obj/item/seeds/watermelon,
		/obj/item/seeds/wheat,
		/obj/item/seeds/whitebeet,
		/obj/item/seeds/amanita,
		/obj/item/seeds/glowshroom,
		/obj/item/seeds/liberty,
		/obj/item/seeds/nettle,
		/obj/item/seeds/plump,
		/obj/item/seeds/reishi,
		/obj/item/seeds/cannabis,
		/obj/item/seeds/starthistle,
		/obj/item/seeds/cherry/bomb,
		/obj/item/seeds/berry/glow,
		/obj/item/seeds/sunflower/moonflower
		)

/obj/effect/spawner/lootdrop/flora
	name = "random flora spawner"
	loot = list(
		/obj/structure/flora/tree/chapel,
		/obj/structure/flora/tree/pine,
		/obj/structure/flora/tree/jungle/small,
		/obj/structure/flora/tree/jungle,
		/obj/structure/flora/ash/puce,
		/obj/structure/flora/ash/fireblossom,
		/obj/structure/flora/ash/fern,
		/obj/structure/flora/ash/tall_shroom,
		/obj/structure/flora/ash/stem_shroom,
		/obj/structure/flora/ash/space/voidmelon,
		/obj/structure/flora/ash/leaf_shroom,
		/obj/structure/flora/junglebush/large,
		/obj/structure/flora/junglebush/b,
		/obj/structure/flora/junglebush/c,
		/obj/structure/flora/ausbushes/fernybush,
		/obj/structure/flora/ausbushes/genericbush,
		/obj/structure/flora/ausbushes/grassybush,
		/obj/structure/flora/ausbushes/leafybush,
		/obj/structure/flora/ausbushes/palebush,
		/obj/structure/flora/ausbushes/pointybush,
		/obj/structure/flora/ausbushes/reedbush,
		/obj/structure/flora/ausbushes/stalkybush,
		/obj/structure/flora/ausbushes/sunnybush,
		/obj/structure/flora/bush,
		/obj/structure/flora/grass/jungle,
		/obj/structure/flora/junglebush,
		/obj/structure/flora/junglebush/b,
		/obj/structure/flora/junglebush/c,
		/obj/structure/flora/ash,
		/obj/structure/flora/ash/cacti,
		/obj/structure/flora/ash/cap_shroom,
		/obj/structure/flora/ash/chilly,
		/obj/structure/flora/tree/palm
		)
	lootcount = 1

/obj/effect/spawner/lootdrop/flower
	name = "random flower spawner"
	loot = list(
		/obj/structure/flora/ausbushes/brflowers,
		/obj/structure/flora/ausbushes/ywflowers,
		/obj/structure/flora/ausbushes/ppflowers,
		/obj/structure/flora/ausbushes/fullgrass,
		/obj/structure/flora/ausbushes/sparsegrass
		)
	lootcount = 1

/obj/effect/spawner/lootdrop/anomaly
	name = "random anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/grav/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/grav/high/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/safe
	name = "relatively safe anomaly spawner"
	loot = list(
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/dangerous
	name = "relatively dangerous anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/grav/planetary,
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/grav/high/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/big
	name = "random big anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/big/planetary,
		/obj/effect/anomaly/flux/big/planetary,
		/obj/effect/anomaly/grav/high/big/planetary,
		/obj/effect/anomaly/pyro/big/planetary

	)

//handpicked lists relevant to the planets they're on
// /cave lists are made for spawning in cave biomes. Not every anomaly goes well there. We don't have enough anomalies to really populate them all though

/obj/effect/spawner/lootdrop/anomaly/jungle
	name = "Jungle Anomaly Spawner"
	loot = list(
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/jungle/cave
	loot = list(
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

//beaches don't currently have anomalies, but I don't see a reason why they couldn't have *some*

/obj/effect/spawner/lootdrop/anomaly/beach
	name = "Beach anomaly spawner"
	loot = list(
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/beach/cave
	loot = list(
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/sand
	name = "Sand anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/sand/cave
	loot = list(
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/rock
	name = "Rock anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/grav/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/grav/high/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/tvstatic/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/rock/cave
	loot = list(
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/sparkler/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/phantom/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/lava
	name = "Lava anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/grav/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/lava/cave
	loot = list(
		/obj/effect/anomaly/flux/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/pyro/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/ice
	name = "Ice anomaly spawner"
	loot = list(
		/obj/effect/anomaly/bluespace/planetary,
		/obj/effect/anomaly/grav/planetary,
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/grav/high/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/ice/cave
	loot = list(
		/obj/effect/anomaly/hallucination/planetary,
		/obj/effect/anomaly/grav/high/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/phantom/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/waste
	name = "Waste anomaly spawner"
	loot = list(
		/obj/effect/anomaly/vortex/planetary,
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/waste/cave
	loot = list(
		/obj/effect/anomaly/heartbeat/planetary,
		/obj/effect/anomaly/veins/planetary,
		/obj/effect/anomaly/plasmasoul/planetary,
		/obj/effect/anomaly/melter/planetary,
	)

/obj/effect/spawner/lootdrop/anomaly/storm
	loot = list(
		/obj/effect/anomaly/flux,
		/obj/effect/anomaly/pyro,
		/obj/effect/anomaly/sparkler,
		/obj/effect/anomaly/veins,
		/obj/effect/anomaly/phantom,
		/obj/effect/anomaly/melter,
	)

//wasteplanet things

/obj/effect/spawner/lootdrop/waste/grille_or_trash
	name = "wasteplanet loot spawner"
	loot = list(
		/obj/structure/grille/broken = 5,
		/obj/structure/grille = 5,
		/obj/item/cigbutt = 1,
		/obj/item/trash/cheesie = 1,
		/obj/item/trash/candy = 1,
		/obj/item/trash/chips = 1,
		/obj/item/reagent_containers/food/snacks/deadmouse = 1,
		/obj/item/trash/pistachios = 1,
		/obj/item/trash/plate = 1,
		/obj/item/trash/popcorn = 1,
		/obj/item/trash/raisins = 1,
		/obj/item/trash/sosjerky = 1,
		/obj/item/trash/syndi_cakes = 1
	)

/obj/effect/spawner/lootdrop/waste/mechwreck
	name = "wasteplanet mech wreckage"
	loot = list(
		/obj/structure/mecha_wreckage/ripley = 15,
		/obj/structure/mecha_wreckage/ripley/firefighter = 9,
		/obj/structure/mecha_wreckage/ripley/mkii = 9,
		/obj/structure/mecha_wreckage/ripley/cmm = 9
		)

/obj/effect/spawner/lootdrop/waste/mechwreck/rare
	loot = list(
		/obj/structure/mecha_wreckage/durand = 12.5,
		/obj/structure/mecha_wreckage/durand/cmm = 12.5,
		/obj/structure/mecha_wreckage/odysseus = 25,
		/obj/structure/mecha_wreckage/gygax = 25
		)

/obj/effect/spawner/lootdrop/waste/trash //debatable if this is actually loot
	loot = list(
		/obj/effect/decal/cleanable/greenglow/filled = 30,
		/obj/effect/decal/cleanable/greenglow/ecto = 1,
		/obj/effect/decal/cleanable/glass = 30,
		/obj/effect/decal/cleanable/glass/plasma = 30,
		/obj/effect/decal/cleanable/glass/strange = 30,
		/obj/effect/decal/cleanable/molten_object = 30,
		/obj/effect/decal/cleanable/molten_object/large = 30,
		/obj/effect/decal/cleanable/oil = 30,
		/obj/effect/decal/cleanable/oil/slippery = 1, // :)
		/obj/effect/decal/cleanable/plastic = 30,
		/obj/effect/decal/cleanable/ash = 30,
		/obj/effect/decal/cleanable/ash/large = 30,
	)

/obj/effect/spawner/lootdrop/waste/radiation
	loot = list(
		/obj/structure/radioactive = 6,
		/obj/structure/radioactive/stack = 6,
		/obj/structure/radioactive/waste = 6
	)

/obj/effect/spawner/lootdrop/waste/radiation/more_rads
	loot = list(
		/obj/structure/radioactive = 3,
		/obj/structure/radioactive/stack = 12,
		/obj/structure/radioactive/waste = 12
	)

/obj/effect/spawner/lootdrop/waste/atmos_can
	loot = list(
		/obj/machinery/portable_atmospherics/canister/toxins = 3,
		/obj/machinery/portable_atmospherics/canister/carbon_dioxide = 3,
		/obj/machinery/portable_atmospherics/canister/nitrogen = 3,
		/obj/machinery/portable_atmospherics/canister/oxygen = 3,
		/obj/machinery/portable_atmospherics/canister/nitrous_oxide = 1,
		/obj/machinery/portable_atmospherics/canister/water_vapor = 1
	)

/obj/effect/spawner/lootdrop/waste/atmos_can/rare
	loot = list(
		/obj/machinery/portable_atmospherics/canister/tritium = 3,
		/obj/machinery/portable_atmospherics/canister/pluoxium = 3
	)

/obj/effect/spawner/lootdrop/waste/salvageable
	loot = list(
		/obj/structure/salvageable/machine = 20,
		/obj/structure/salvageable/autolathe = 15,
		/obj/structure/salvageable/computer = 10,
		/obj/structure/salvageable/protolathe = 10,
		/obj/structure/salvageable/circuit_imprinter = 8,
		/obj/structure/salvageable/destructive_analyzer = 8,
		/obj/structure/salvageable/server = 8
	)

/obj/effect/spawner/lootdrop/waste/girder
	loot = list(
		/obj/structure/girder,
		/obj/structure/girder/displaced,
		/obj/structure/girder/reinforced
	)
/obj/effect/spawner/lootdrop/waste/hivebot
	loot = list(
	/obj/effect/spawner/lootdrop/salvage/metal,
	/obj/effect/spawner/lootdrop/salvage/metal,
	/obj/effect/spawner/lootdrop/salvage/metal,
	/obj/effect/spawner/lootdrop/salvage/gold,
	/obj/effect/spawner/lootdrop/salvage/plasma,
	/obj/effect/spawner/lootdrop/salvage/silver,
	/obj/effect/spawner/lootdrop/salvage/titanium,
	/obj/item/stack/ore/salvage/scrapbluespace,
	/obj/item/stack/ore/salvage/scrapbluespace,
	/obj/item/stack/ore/salvage/scrapuranium
	)
	lootcount = 2

/obj/effect/spawner/lootdrop/waste/hivebot/beacon
	lootcount = 6

/obj/effect/spawner/lootdrop/salvage
	name = "salvage mats spawner"
	loot = list(
		/obj/item/stack/ore/salvage/scrapmetal,
		/obj/item/stack/ore/salvage/scrapgold,
		/obj/item/stack/ore/salvage/scrapplasma,
		/obj/item/stack/ore/salvage/scrapsilver,
		/obj/item/stack/ore/salvage/scraptitanium,
		/obj/item/stack/ore/salvage/scrapbluespace,
		/obj/item/stack/ore/salvage/scrapuranium
	)

/obj/effect/spawner/lootdrop/salvage/metal
	loot = list(
		/obj/item/stack/ore/salvage/scrapmetal
	)

/obj/effect/spawner/lootdrop/salvage/metal/Initialize()
	lootcount = pick(list(
		1,
		2,
		3,
		4
	))
	return ..()

/obj/effect/spawner/lootdrop/salvage/gold
	loot = list(
		/obj/item/stack/ore/salvage/scrapgold
	)

/obj/effect/spawner/lootdrop/salvage/gold/Initialize()
	lootcount = pick(list(
		1,
		2,
		3,
		4
	))
	return ..()

/obj/effect/spawner/lootdrop/salvage/plasma
	loot = list(
		/obj/item/stack/ore/salvage/scrapplasma
	)
/obj/effect/spawner/lootdrop/salvage/plasma/Initialize()
	lootcount = pick(list(
		1,
		2,
		3,
		4
	))
	return ..()


/obj/effect/spawner/lootdrop/salvage/silver
	loot = list(
		/obj/item/stack/ore/salvage/scrapsilver
	)
/obj/effect/spawner/lootdrop/salvage/silver/Initialize()
	lootcount = pick(list(
		1,
		2,
		3,
		4
	))
	return ..()


/obj/effect/spawner/lootdrop/salvage/titanium
	loot = list(
		/obj/item/stack/ore/salvage/scraptitanium
	)
/obj/effect/spawner/lootdrop/salvage/titanium/Initialize()
	lootcount = pick(list(
		1,
		2,
		3,
		4
	))
	return ..()

/obj/effect/spawner/lootdrop/salvage/bluespace
	loot = list(
		/obj/item/stack/ore/salvage/scrapbluespace
	)
/obj/effect/spawner/lootdrop/salvage/bluespace/Initialize()
	lootcount = pick(list(
		1,
		2,
		3,
		4
	))
	return ..()

/obj/effect/spawner/lootdrop/salvage/uranium
	loot = list(
		/obj/item/stack/ore/salvage/scrapuranium
	)
/obj/effect/spawner/lootdrop/salvage/uranium/Initialize()
	lootcount = pick(list(
		1,
		2,
		3,
		4
	))
	return ..()
