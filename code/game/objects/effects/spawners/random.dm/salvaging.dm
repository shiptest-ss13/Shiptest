//GENERIC
/obj/effect/spawner/random/salvage_capacitor
	loot = list(
			/obj/item/stock_parts/capacitor = 120,
			/obj/item/stock_parts/capacitor/adv = 20,
			/obj/item/stock_parts/capacitor/super = 5,
		)

/obj/effect/spawner/random/salvage_scanning
	loot = list(
			/obj/item/stock_parts/scanning_module = 120,
			/obj/item/stock_parts/scanning_module/adv = 20,
			/obj/item/stock_parts/scanning_module/phasic = 5,
		)

/obj/effect/spawner/random/salvage_manipulator
	loot = list(
			/obj/item/stock_parts/manipulator = 120,
			/obj/item/stock_parts/manipulator/nano = 20,
			/obj/item/stock_parts/manipulator/pico = 5,
		)

/obj/effect/spawner/random/salvage_matter_bin
	loot = list(
			/obj/item/stock_parts/matter_bin = 120,
			/obj/item/stock_parts/matter_bin/adv = 20,
			/obj/item/stock_parts/matter_bin/super = 5,
		)

/obj/effect/spawner/random/salvage_laser
	loot = list(
			/obj/item/stock_parts/micro_laser = 120,
			/obj/item/stock_parts/micro_laser/high = 20,
			/obj/item/stock_parts/micro_laser/ultra = 5,
		)

//PROTOLATHE
/obj/effect/spawner/random/tool_engie_proto
	loot = list(
			/obj/effect/spawner/random/tool_engie_common = 120,
			/obj/effect/spawner/random/tool_engie_sydnie = 20,
			/obj/effect/spawner/random/tool_engie_adv = 5,
		)

/obj/effect/spawner/random/tool_engie_common
	loot = list(
			/obj/item/wrench/crescent = 1,
			/obj/item/screwdriver = 1,
			/obj/item/weldingtool = 1,
			/obj/item/crowbar = 1,
			/obj/item/wirecutters = 1,
			/obj/item/multitool = 1,
		)

/obj/effect/spawner/random/tool_engie_sydnie
	loot = list(
			/obj/item/wrench/syndie = 1,
			/obj/item/screwdriver/nuke = 1,
			/obj/item/weldingtool/largetank = 1,
			/obj/item/crowbar/syndie = 1,
			/obj/item/wirecutters/syndie = 1,
			/obj/item/multitool/syndie = 1,
		)

/obj/effect/spawner/random/tool_engie_adv
	loot = list(
			/obj/item/screwdriver/power = 1,
			/obj/item/weldingtool/experimental = 1,
			/obj/item/crowbar/power = 1,
		)

/obj/effect/spawner/random/tool_surgery_proto
	loot = list(
			/obj/effect/spawner/random/tool_surgery_common = 120,
			/obj/effect/spawner/random/tool_surgery_adv = 10,
		)

/obj/effect/spawner/random/tool_surgery_common
	loot = list(
			/obj/item/scalpel = 1,
			/obj/item/hemostat = 1,
			/obj/item/cautery = 1,
			/obj/item/retractor = 1,
			/obj/item/circular_saw = 1,
			/obj/item/surgicaldrill = 1,
		)

/obj/effect/spawner/random/tool_surgery_adv
	loot = list(
			/obj/item/scalpel/advanced = 1,
			/obj/item/retractor/advanced = 1,
			/obj/item/surgicaldrill/advanced = 1,
		)

/obj/effect/spawner/random/beaker_loot_spawner
	loot = list(
			/obj/item/reagent_containers/glass/beaker = 300,
			/obj/item/reagent_containers/glass/beaker/large = 200,
			/obj/item/reagent_containers/glass/beaker/plastic = 50,
			/obj/item/reagent_containers/glass/beaker/meta = 10,
			/obj/item/reagent_containers/glass/beaker/noreact = 5,
			/obj/item/reagent_containers/glass/beaker/bluespace = 1,
		)
/obj/effect/spawner/random/random_prosthetic
	loot = list(
			/obj/item/bodypart/l_arm/robot/surplus = 1,
			/obj/item/bodypart/r_arm/robot/surplus = 1,
			/obj/item/bodypart/leg/left/robot/surplus = 1,
			/obj/item/bodypart/leg/right/robot/surplus = 1,
		)
/obj/effect/spawner/random/random_gun_protolathe_lootdrop
	loot = list(
			/obj/item/gun/energy/lasercannon = 1,
			/obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq/proto = 1,
			/obj/item/gun/energy/temperature/security = 1,
		)
/obj/effect/spawner/random/random_ammo_protolathe_lootdrop
	loot = list(
			/obj/item/stock_parts/cell/gun/upgraded = 5,
			/obj/item/ammo_box/magazine/smgm9mm = 7,
		)

//CIRCUIT IMPRINTER
/obj/effect/spawner/random/random_machine_circuit_common
	loot = list(
			/obj/item/circuitboard/machine/autolathe = 5,
			/obj/item/circuitboard/machine/biogenerator = 5,
			/obj/item/circuitboard/machine/cell_charger = 5,
			/obj/item/circuitboard/machine/chem_heater = 5,
			/obj/item/circuitboard/machine/chem_master = 5,
			/obj/item/circuitboard/machine/clonescanner = 5,
			/obj/item/circuitboard/machine/cryo_tube = 5,
			/obj/item/circuitboard/machine/cyborgrecharger = 5,
			/obj/item/circuitboard/machine/deep_fryer = 5,
			/obj/item/circuitboard/machine/experimentor = 5,
			/obj/item/circuitboard/machine/holopad = 5,
			/obj/item/circuitboard/machine/hydroponics = 5,
			/obj/item/circuitboard/machine/limbgrower = 5,
			/obj/item/circuitboard/machine/ltsrbt = 5,
			/obj/item/circuitboard/machine/mech_recharger = 5,
			/obj/item/circuitboard/machine/mechfab = 5,
			/obj/item/circuitboard/machine/medical_kiosk = 5,
			/obj/item/circuitboard/machine/medipen_refiller = 5,
			/obj/item/circuitboard/machine/microwave = 5,
			/obj/item/circuitboard/machine/monkey_recycler = 5,
			/obj/item/circuitboard/machine/ore_redemption = 5,
			/obj/item/circuitboard/machine/ore_silo = 5,
			/obj/item/circuitboard/machine/reagentgrinder = 5,
			/obj/item/circuitboard/machine/recharger = 5,
			/obj/item/circuitboard/machine/seed_extractor = 5,
			/obj/item/circuitboard/machine/selling_pad = 5,
			/obj/item/circuitboard/machine/emitter = 5,
		)

/obj/effect/spawner/random/random_machine_circuit_rare
	loot = list(
			/obj/item/circuitboard/aicore = 5,
			/obj/item/circuitboard/machine/chem_dispenser = 5,
			/obj/item/circuitboard/machine/circuit_imprinter = 5,
			/obj/item/circuitboard/machine/protolathe = 5,
			/obj/item/circuitboard/machine/clonepod/experimental = 5,
			/obj/item/circuitboard/machine/rad_collector = 5,
			/obj/item/circuitboard/machine/launchpad = 5,
		)

/obj/effect/spawner/random/random_machine_circuit_mech
	loot = list(
			/obj/item/circuitboard/mecha/ripley/main = 100,
			/obj/item/circuitboard/mecha/ripley/peripherals = 100,
			/obj/item/circuitboard/mecha/honker/main = 5,
			/obj/item/circuitboard/mecha/honker/peripherals = 5,
			/obj/item/circuitboard/mecha/odysseus/main = 5,
			/obj/item/circuitboard/mecha/odysseus/peripherals = 5,
			/obj/item/circuitboard/mecha/gygax/main = 1,
			/obj/item/circuitboard/mecha/gygax/peripherals = 1,
			/obj/item/circuitboard/mecha/gygax/targeting = 1,
			/obj/item/circuitboard/mecha/durand/main = 1,
			/obj/item/circuitboard/mecha/durand/peripherals = 1,
			/obj/item/circuitboard/mecha/durand/targeting = 1,
		)

//COMPUTER
/obj/effect/spawner/random/random_computer_circuit_common
	loot = list(
			/obj/item/circuitboard/computer/aifixer = 5,
			/obj/item/circuitboard/computer/arcade/amputation = 5,
			/obj/item/circuitboard/computer/arcade/battle = 5,
			/obj/item/circuitboard/computer/arcade/orion_trail = 5,
			/obj/item/circuitboard/computer/atmos_alert = 5,
			/obj/item/circuitboard/computer/card = 5,
			/obj/item/circuitboard/computer/cloning = 5,
			/obj/item/circuitboard/computer/communications = 5,
			/obj/item/circuitboard/computer/launchpad_console = 5,
			/obj/item/circuitboard/computer/mech_bay_power_console = 5,
			/obj/item/circuitboard/computer/pandemic = 5,
			/obj/item/circuitboard/computer/powermonitor/secret = 5,
			/obj/item/circuitboard/computer/prototype_cloning = 5,
			/obj/item/circuitboard/computer/stationalert = 5,
			/obj/item/circuitboard/computer/xenobiology = 5,
			/obj/item/circuitboard/computer/teleporter = 5,
			/obj/item/circuitboard/computer/operating = 5,
			/obj/item/circuitboard/computer/crew = 5,
			/obj/item/circuitboard/computer/scan_consolenew = 5,
		)

/obj/effect/spawner/random/random_computer_circuit_rare
	loot = list(
			/obj/item/circuitboard/computer/cargo = 5,
			/obj/item/circuitboard/computer/communications = 5,
			/obj/item/circuitboard/computer/shuttle/helm = 5,
			/obj/item/circuitboard/computer/med_data = 5,
		)

//DESTRUCTIVE ANAL //i'm killing you
/obj/effect/spawner/random/destructive_anal_loot //what do people usually put in these things anayways
	loot = list(
			/obj/item/storage/toolbox/syndicate/empty = 650,
			/obj/item/gun/ballistic/automatic/pistol/ringneck = 500,
			/obj/item/camera_bug = 500,
			/obj/item/clothing/gloves/combat = 200,
			/obj/item/clothing/head/chameleon = 200,
			/obj/item/pen/sleepy = 200,
			/obj/item/reagent_containers/hypospray/medipen/stimpack/traitor = 100,

			/obj/item/grenade/c4 = 100,

			/obj/item/wrench/syndie = 30,
			/obj/item/screwdriver/nuke = 30,
			/obj/item/crowbar/syndie = 30,
			/obj/item/wirecutters/syndie = 30,
			/obj/item/multitool/syndie = 30,
		)
