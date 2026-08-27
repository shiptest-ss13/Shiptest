// STOCK PARTS //

// for the normal parts these all follow the same pattern of:
// t1: 80%
// t2: 15%
// t3: 4.5%
// t4: 0.5%

/obj/effect/spawner/random/salvage/part
	icon_state = "matter_bin"

/obj/effect/spawner/random/salvage/part/capacitor
	loot = list(
		/obj/item/stock_parts/capacitor = 800,
		/obj/item/stock_parts/capacitor/adv = 150,
		/obj/item/stock_parts/capacitor/super = 45,
		/obj/item/stock_parts/capacitor/quadratic = 5)

/obj/effect/spawner/random/salvage/part/scanning
	loot = list(
		/obj/item/stock_parts/scanning_module = 800,
		/obj/item/stock_parts/scanning_module/adv = 150,
		/obj/item/stock_parts/scanning_module/phasic = 45,
		/obj/item/stock_parts/scanning_module/triphasic = 5)

/obj/effect/spawner/random/salvage/part/manipulator
	loot = list(
		/obj/item/stock_parts/manipulator = 800,
		/obj/item/stock_parts/manipulator/nano = 150,
		/obj/item/stock_parts/manipulator/pico = 45,
		/obj/item/stock_parts/manipulator/femto = 5)

/obj/effect/spawner/random/salvage/part/matter_bin
	loot = list(
		/obj/item/stock_parts/matter_bin = 800,
		/obj/item/stock_parts/matter_bin/adv = 150,
		/obj/item/stock_parts/matter_bin/super = 45,
		/obj/item/stock_parts/matter_bin/bluespace = 5)

/obj/effect/spawner/random/salvage/part/laser
	loot = list(
		/obj/item/stock_parts/micro_laser = 800,
		/obj/item/stock_parts/micro_laser/high = 150,
		/obj/item/stock_parts/micro_laser/ultra = 45,
		/obj/item/stock_parts/micro_laser/quadultra = 5)

// parts for building telecomms machinery
/obj/effect/spawner/random/salvage/part/tcomms
	loot = list(
		/obj/item/stock_parts/subspace/ansible = 10,
		/obj/item/stock_parts/subspace/filter = 10,
		/obj/item/stock_parts/subspace/amplifier = 10,
		/obj/item/stock_parts/subspace/treatment = 10,
		/obj/item/stock_parts/subspace/analyzer = 10,
		/obj/item/stock_parts/subspace/crystal = 10,
		/obj/item/stock_parts/subspace/transmitter = 10)

/obj/effect/spawner/random/salvage/part/tcomms/two
	spawn_loot_count = 2

// modular computers parts
/obj/effect/spawner/random/salvage/part/modcomp
	loot = list(
		// basic parts
		/obj/item/computer_hardware/battery = 10,
		/obj/item/computer_hardware/printer = 10,
		/obj/item/computer_hardware/network_card = 10,
		/obj/item/computer_hardware/processor_unit = 10,
		/obj/item/computer_hardware/card_slot = 10,
		// advanced parts
		/obj/item/computer_hardware/network_card/advanced = 5)

/obj/effect/spawner/random/salvage/part/modcomp/three
	spawn_loot_count = 3

// BROKEN AUTOLATHE //
// consists of stuff you print out of an autolathe. mostly.

// low value lathe trash
/obj/effect/spawner/random/salvage/autolathe_common
	loot = list(
		// garbage
		/obj/item/shard = 20,

		// tools
		/obj/item/multitool = 10,
		/obj/item/crowbar = 10,
		/obj/item/screwdriver = 10,
		/obj/item/wirecutters = 10,
		/obj/item/weldingtool = 10,
		/obj/item/wrench = 10,
		/obj/item/stack/tape/industrial = 10,
		/obj/item/hand_labeler = 10,
		/obj/item/toy/crayon/spraycan = 10,
		/obj/item/geiger_counter = 10,
		/obj/item/door_seal = 10,
		/obj/item/reagent_containers/glass/bucket = 10,
		/obj/item/mop = 10,
		/obj/item/pushbroom = 10,

		// kitchenware
		/obj/item/melee/knife/kitchen = 10,
		/obj/item/melee/knife/butcher = 10,
		/obj/item/plate = 10,
		/obj/item/plate/small = 10,
		/obj/item/plate/large = 10,
		/obj/item/kitchen/fork = 10,
		/obj/item/reagent_containers/glass/bowl = 10,
		/obj/item/reagent_containers/food/drinks/drinkingglass = 10,
		/obj/item/reagent_containers/food/drinks/bottle/small = 10,
		/obj/item/reagent_containers/food/drinks/bottle = 10,

		// medical items
		/obj/item/reagent_containers/glass/beaker = 10,
		/obj/item/reagent_containers/glass/beaker/large = 10,
		/obj/item/reagent_containers/syringe = 10,
		/obj/item/bonesetter = 10,
		/obj/item/bodybag = 10,
		)

// higher-ish value but still lathe trash
/obj/effect/spawner/random/salvage/autolathe_rare
	loot = list(
		// gun stuff
		/obj/item/gun/ballistic/automatic/zip_pistol = 10,
		/obj/item/weaponcrafting/receiver = 10,
		/obj/item/storage/box/ammo/c38_surplus = 2,
		/obj/item/storage/box/ammo/c22lr/surplus = 2,
		/obj/item/storage/box/ammo/c10mm_surplus = 2,
		/obj/item/storage/box/ammo/c9mm_surplus = 2,
		/obj/item/storage/box/ammo/c45_surplus = 2,

		// big tools
		/obj/item/hatchet = 10,
		/obj/item/pickaxe = 10,

		// silly stuff
		/obj/item/kirbyplants/fullysynthetic = 10,
		/obj/item/toy/minimeteor = 10,
		)

// rare environmental storytelling elements
/obj/effect/spawner/random/salvage/autolathe_weird
	loot = list(
		/obj/item/organ/tail/lizard = 15, // waaa
		/obj/item/bodypart/l_arm = 1,
		/obj/item/bodypart/r_arm = 1,
		/obj/item/bodypart/l_arm/lizard = 1,
		/obj/item/bodypart/r_arm/lizard = 1,
		/obj/item/bodypart/l_arm/ethereal = 1,
		/obj/item/bodypart/r_arm/ethereal = 1,
		/obj/item/bodypart/l_arm/kepori = 1,
		/obj/item/bodypart/r_arm/kepori = 1,
		/obj/item/bodypart/l_arm/moth = 1,
		/obj/item/bodypart/r_arm/moth = 1,
		/obj/item/bodypart/l_arm/vox = 1,
		/obj/item/bodypart/r_arm/vox = 1,
		/obj/item/bodypart/l_arm/rachnid = 1,
		/obj/item/bodypart/r_arm/rachnid = 1,
		/obj/item/bodypart/l_arm/ipc = 1,
		/obj/item/bodypart/r_arm/ipc = 1,
		/obj/effect/gibspawner/human = 15)

// all together now!
/obj/effect/spawner/random/salvage/autolathe_junk
	loot = list(
		/obj/effect/spawner/random/salvage/autolathe_common = 190,
		/obj/effect/spawner/random/salvage/autolathe_rare = 10,
		/obj/effect/spawner/random/salvage/autolathe_weird = 1)

// BROKEN PROTOLATHE //
// the gun pool here is mostly geared towards sidearms/smgs
/obj/effect/spawner/random/salvage/prolathe/gun
	icon_state = "laser_gun"
	loot = list(
		/obj/item/gun/energy/lasercannon = 1,
		/obj/item/gun/ballistic/automatic/smg/skm_carbine/saber = 1,
		/obj/item/gun/energy/temperature/security = 1)

/obj/effect/spawner/random/salvage/prolathe/ammo
	icon_state = "rubbershot"
	loot = list(
		/obj/item/stock_parts/cell/gun/upgraded = 5,
		/obj/item/ammo_box/magazine/m9mm_expedition = 7)

// DESTRUCTIVE ANALYZER
/obj/effect/spawner/random/salvage/destructive_analyzer
	loot = list(
			/obj/item/storage/toolbox/syndicate/empty = 650,
			/obj/item/gun/ballistic/automatic/pistol/ringneck = 500,
			/obj/item/camera_bug = 500,
			/obj/item/clothing/gloves/combat = 200,
			/obj/item/clothing/head/chameleon = 200,
			/obj/item/pen/sleepy = 200,
			/obj/item/reagent_containers/hypospray/medipen/stimpack/crisis = 100,
			/obj/item/grenade/c4 = 100,

			/obj/item/wrench/syndie = 30,
			/obj/item/screwdriver/nuke = 30,
			/obj/item/crowbar/syndie = 30,
			/obj/item/wirecutters/syndie = 30,
			/obj/item/multitool/syndie = 30,
		)

/obj/effect/spawner/random/salvage/machine
	name = "salvageable machine spawner"
	icon_state = "arcade"
	loot = list(
		/obj/structure/salvageable/protolathe,
		/obj/structure/salvageable/circuit_imprinter,
		/obj/structure/salvageable/server,
		/obj/structure/salvageable/machine,
		/obj/structure/salvageable/autolathe,
		/obj/structure/salvageable/computer,
		/obj/structure/salvageable/destructive_analyzer
	)

// MATERIALS
/obj/effect/spawner/random/salvage
	name = "salvage mats spawner"
	icon_state = "rods"
	spawn_random_offset = TRUE
	loot = list(
		/obj/item/stack/ore/salvage/scrapmetal,
		/obj/item/stack/ore/salvage/scrapgold,
		/obj/item/stack/ore/salvage/scrapplasma,
		/obj/item/stack/ore/salvage/scrapsilver,
		/obj/item/stack/ore/salvage/scraptitanium,
		/obj/item/stack/ore/salvage/scrapbluespace,
		/obj/item/stack/ore/salvage/scrapuranium
	)

/obj/effect/spawner/random/salvage/half
	name = "50% salvage spawner"
	spawn_loot_chance = 50
	loot = list(
		/obj/effect/spawner/random/maintenance,
		/obj/effect/spawner/random/salvage/machine,
		/obj/effect/spawner/random/exotic/ripley,
		/obj/structure/closet/crate/secure/loot,
	)

/obj/effect/spawner/random/salvage/ore/Initialize()
	spawn_loot_count = pick(list(
		1,
		2,
		3,
		4
	))
	return ..()

/obj/effect/spawner/random/salvage/ore/metal
	loot = list(
		/obj/item/stack/ore/salvage/scrapmetal
	)

/obj/effect/spawner/random/salvage/ore/gold
	loot = list(
		/obj/item/stack/ore/salvage/scrapgold
	)

/obj/effect/spawner/random/salvage/ore/plasma
	loot = list(
		/obj/item/stack/ore/salvage/scrapplasma
	)

/obj/effect/spawner/random/salvage/ore/silver
	loot = list(
		/obj/item/stack/ore/salvage/scrapsilver
	)

/obj/effect/spawner/random/salvage/ore/titanium
	loot = list(
		/obj/item/stack/ore/salvage/scraptitanium
	)

/obj/effect/spawner/random/salvage/ore/bluespace
	loot = list(
		/obj/item/stack/ore/salvage/scrapbluespace
	)

/obj/effect/spawner/random/salvage/ore/uranium
	loot = list(
		/obj/item/stack/ore/salvage/scrapuranium
	)
