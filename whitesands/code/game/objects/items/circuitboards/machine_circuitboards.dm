/obj/item/circuitboard/machine/clonepod
	name = "Clone Pod (Machine Board)"
	icon_state = "medical"
	build_path = /obj/machinery/clonepod
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/stock_parts/scanning_module = 2,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/reagent_containers/glass/beaker = 2)

/obj/item/circuitboard/machine/clonepod/experimental
	name = "Experimental Clone Pod (Machine Board)"
	icon_state = "medical"
	build_path = /obj/machinery/clonepod/experimental

/obj/item/circuitboard/machine/clonescanner
	name = "Cloning Scanner (Machine Board)"
	icon_state = "medical"
	build_path = /obj/machinery/dna_scannernew
	req_components = list(
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/machine/bluespace_miner
	name = "Bluespace Miner (Machine Board)"
	build_path = /obj/machinery/power/bluespace_miner
	req_components = list(
		/obj/item/stock_parts/matter_bin = 3,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/manipulator = 3,
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stack/ore/bluespace_crystal = 5)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/sleeper
	name = "Sleeper (Machine Board)"
	icon_state = "medical"
	build_path = /obj/machinery/sleeper
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 2)

/obj/item/circuitboard/machine/autodoc
	name = "Autodoc (Machine Board)"
	build_path = /obj/machinery/autodoc
	req_components = list(/obj/item/scalpel/advanced = 1,
		/obj/item/retractor/advanced = 1,
		/obj/item/surgicaldrill/advanced = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/micro_laser = 3,
		/obj/item/stock_parts/matter_bin = 1)

/obj/item/circuitboard/machine/shuttle/engine/plasma
	name = "Plasma Thruster (Machine Board)"
	build_path = /obj/machinery/power/shuttle/engine/fueled/plasma
	req_components = list(/obj/item/stock_parts/capacitor = 2,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/micro_laser = 1)

/obj/item/circuitboard/machine/shuttle/engine/electric
	name = "Ion Thruster (Machine Board)"
	build_path = /obj/machinery/power/shuttle/engine/electric
	req_components = list(/obj/item/stock_parts/capacitor = 3,
		/obj/item/stock_parts/micro_laser = 3)

/obj/item/circuitboard/machine/shuttle/engine/expulsion
	name = "Expulsion Thruster (Machine Board)"
	build_path = /obj/machinery/power/shuttle/engine/fueled/expulsion
	req_components = list(/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/matter_bin = 2)

/obj/item/circuitboard/machine/shuttle/engine/oil
	name = "Oil Thruster (Machine Board)"
	build_path = /obj/machinery/power/shuttle/engine/liquid/oil
	req_components = list(/obj/item/reagent_containers/glass/beaker = 4,
		/obj/item/stock_parts/micro_laser = 2)

/obj/item/circuitboard/machine/shuttle/engine/void
	name = "Void Thruster (Machine Board)"
	build_path = /obj/machinery/power/shuttle/engine/void
	req_components = list(/obj/item/stock_parts/capacitor/quadratic = 2,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/micro_laser/quadultra = 1)

/obj/item/circuitboard/machine/shuttle/heater
	name = "Fueled Engine Heater (Machine Board)"
	build_path = /obj/machinery/atmospherics/components/unary/shuttle/heater
	req_components = list(/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/matter_bin = 1)

/obj/item/circuitboard/machine/shuttle/smes
	name = "Electric Engine Precharger (Machine Board)"
	build_path = /obj/machinery/power/smes/shuttle
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/cell = 3,
		/obj/item/stock_parts/capacitor = 1
	)
