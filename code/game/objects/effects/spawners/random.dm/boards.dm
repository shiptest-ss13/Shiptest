// Tech storage circuit board spawners

/obj/effect/spawner/random/techstorage
	name = "generic circuit board spawner"
	icon_state = "circuit"
	spawn_loot_split = TRUE
	spawn_all_loot = TRUE

/obj/effect/spawner/random/techstorage/service
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

/obj/effect/spawner/random/techstorage/rnd
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

/obj/effect/spawner/random/techstorage/security
	name = "security circuit board spawner"
	loot = list(
		/obj/item/circuitboard/computer/secure_data,
		/obj/item/circuitboard/computer/security,
		/obj/item/circuitboard/computer/prisoner
	)

/obj/effect/spawner/random/techstorage/engineering
	name = "engineering circuit board spawner"
	loot = list(
		/obj/item/circuitboard/computer/atmos_alert,
		/obj/item/circuitboard/computer/stationalert,
		/obj/item/circuitboard/computer/powermonitor
	)

/obj/effect/spawner/random/techstorage/tcomms
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

/obj/effect/spawner/random/techstorage/medical
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

/obj/effect/spawner/random/techstorage/ai_all
	name = "secure AI circuit board spawner"
	loot = list(
		/obj/item/circuitboard/computer/aiupload,
		/obj/item/circuitboard/computer/borgupload,
		/obj/item/circuitboard/aicore
	)

/obj/effect/spawner/random/techstorage/command
	name = "secure command circuit board spawner"
	loot = list(
		/obj/item/circuitboard/computer/crew,
		/obj/item/circuitboard/computer/communications,
		/obj/item/circuitboard/computer/card
	)

/obj/effect/spawner/random/techstorage/rnd_secure
	name = "secure RnD circuit board spawner"
	loot = list(
		/obj/item/circuitboard/computer/mecha_control,
		/obj/item/circuitboard/computer/apc_control,
		/obj/item/circuitboard/computer/robotics
	)

//random RND imprinter/protolathe board spawners. Do not use on maps without a good reason
/obj/effect/spawner/random/circuit/protolathe
	name = "random departmental protolathe"
	icon_state = "circuit"
	loot = list(
		/obj/item/circuitboard/machine/protolathe/department/cargo,
		/obj/item/circuitboard/machine/protolathe/department/engineering,
		/obj/item/circuitboard/machine/protolathe/department/service,
		/obj/item/circuitboard/machine/protolathe/department/medical,
		/obj/item/circuitboard/machine/protolathe/department/science,
		/obj/item/circuitboard/machine/protolathe/department/security
	)

/obj/effect/spawner/random/circuit/imprinter
	name = "random departmental circuit imprinter"
	icon_state = "circuit"
	loot = list(
		/obj/item/circuitboard/machine/circuit_imprinter/department/cargo,
		/obj/item/circuitboard/machine/circuit_imprinter/department/engi,
		/obj/item/circuitboard/machine/circuit_imprinter/department/civ,
		/obj/item/circuitboard/machine/circuit_imprinter/department/med,
		/obj/item/circuitboard/machine/circuit_imprinter/department/science,
		/obj/item/circuitboard/machine/circuit_imprinter/department/sec
	)

/obj/effect/spawner/random/circuit/techfab
	name = "random departmental techfab"
	icon_state = "circuit"
	loot = list(
		/obj/item/circuitboard/machine/techfab/department/service,
		/obj/item/circuitboard/machine/techfab/department/cargo,
		/obj/item/circuitboard/machine/techfab/department/engineering,
		/obj/item/circuitboard/machine/techfab/department/service,
		/obj/item/circuitboard/machine/techfab/department/medical,
		/obj/item/circuitboard/machine/techfab/department/science,
		/obj/item/circuitboard/machine/techfab/department/security
	)

/obj/effect/spawner/random/rnd
	name = "random RND spawner"
	icon_state = "circuit"
	loot = list(
		/obj/item/storage/box/rndmining,
		/obj/item/storage/box/rndengi,
		/obj/item/storage/box/rndsec,
		/obj/item/storage/box/rndciv,
		/obj/item/storage/box/rndmed
	)

/obj/effect/spawner/random/circuit/machine/common
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
			/obj/item/circuitboard/machine/ore_redemption = 5,
			/obj/item/circuitboard/machine/ore_silo = 5,
			/obj/item/circuitboard/machine/reagentgrinder = 5,
			/obj/item/circuitboard/machine/recharger = 5,
			/obj/item/circuitboard/machine/seed_extractor = 5,
			/obj/item/circuitboard/machine/selling_pad = 5,
			/obj/item/circuitboard/machine/emitter = 5,
		)

/obj/effect/spawner/random/circuit
	icon_state = "circuit"

/obj/effect/spawner/random/circuit/machine/rare
	loot = list(
			/obj/item/circuitboard/aicore = 5,
			/obj/item/circuitboard/machine/chem_dispenser = 5,
			/obj/item/circuitboard/machine/circuit_imprinter = 5,
			/obj/item/circuitboard/machine/protolathe = 5,
			/obj/item/circuitboard/machine/clonepod/experimental = 5,
			/obj/item/circuitboard/machine/rad_collector = 5,
			/obj/item/circuitboard/machine/launchpad = 5,
		)

/obj/effect/spawner/random/circuit/machine/mech
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
/obj/effect/spawner/random/circuit/computer/common
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
			/obj/item/circuitboard/computer/teleporter = 5,
			/obj/item/circuitboard/computer/operating = 5,
			/obj/item/circuitboard/computer/crew = 5,
			/obj/item/circuitboard/computer/scan_consolenew = 5,
		)

/obj/effect/spawner/random/circuit/computer/rare
	loot = list(
			/obj/item/circuitboard/computer/cargo = 5,
			/obj/item/circuitboard/computer/communications = 5,
			/obj/item/circuitboard/computer/shuttle/helm = 5,
			/obj/item/circuitboard/computer/med_data = 5,
		)
