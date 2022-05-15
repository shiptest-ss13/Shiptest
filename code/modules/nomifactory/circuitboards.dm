/obj/item/circuitboard/machine/nomifactory
	name = "nomifactory circuitboard"
	icon_state = "nomifactory"
	build_path = /obj/machinery/nomifactory
	needs_anchored = TRUE

/obj/item/circuitboard/machine/nomifactory/metal_press
	name = "Metal Press (Machine Board)"
	build_path = /obj/machinery/nomifactory/machinery/metal_press
	req_components = list(
		/obj/item/nomi/motor = 2,
		/obj/item/nomi/piston = 2,
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/matter_bin = 2,
	)

/obj/item/circuitboard/machine/nomifactory/blast_furnace
	name = "Blast Furnace (Machine Board)"
	build_path = /obj/machinery/nomifactory/machinery/blast_furnace
	req_components = list(
		/obj/item/nomi/coil = 4,
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stock_parts/capacitor = 1,
	)

/obj/item/circuitboard/machine/nomifactory/assembly_complex
	name = "Assembly Complex (Machine Board)"
	build_path = /obj/machinery/nomifactory/machinery/assembly_complex
	req_components = list(
		/obj/item/nomi/motor = 2,
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/matter_bin = 2,
	)

/obj/item/circuitboard/machine/nomifactory/digital_printer
	name = "Digital Printer (Machine Board)"
	build_path = /obj/machinery/nomifactory/machinery/digital_printer
	req_components = list(
		/obj/item/nomi/motor = 2,
		/obj/item/nomi/ferro_rod = 1,
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/matter_bin = 2,
	)

/obj/item/circuitboard/machine/nomifactory/deep_miner
	name = "Deep Miner (Machine Board)"
	build_path = /obj/machinery/nomifactory/machinery/deep_miner
	req_components = list(
		/obj/item/nomi/motor = 4,
		/obj/item/nomi/ferro_rod = 2,
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stock_parts/micro_laser = 4,
		/obj/item/stock_parts/matter_bin = 4,
	)

/obj/item/circuitboard/machine/nomifactory/conveyor
	name = "Basic Conveyor (Machine Board)"
	build_path = /obj/machinery/nomifactory/conveyor
	req_components = list(
		/obj/item/nomi/motor = 4,
		/obj/item/nomi/ferro_rod = 2,
	)
