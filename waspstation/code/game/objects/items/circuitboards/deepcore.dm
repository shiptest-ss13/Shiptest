/obj/item/circuitboard/machine/deepcore/drill
	name = "Deep Core Bluespace Drill (Machine Board)"
	icon_state = "supply"
	build_path = /obj/machinery/deepcore/drill
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/matter_bin = 1)

/obj/item/circuitboard/machine/deepcore/hopper
	name = "Bluespace Material Hopper (Machine Board)"
	icon_state = "supply"
	build_path = /obj/machinery/deepcore/hopper
	req_components = list(
		/obj/item/stack/ore/bluespace_crystal = 2,
		/obj/item/stock_parts/capacitor = 2,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/matter_bin = 2)
	def_components = list(/obj/item/stack/ore/bluespace_crystal = /obj/item/stack/ore/bluespace_crystal/artificial)

/obj/item/circuitboard/machine/deepcore/hub
	name = "Deepcore Mining Control Hub (Machine Board)"
	icon_state = "supply"
	build_path = /obj/machinery/deepcore/hub
	req_components = list(
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/matter_bin = 3,
		/obj/item/stock_parts/manipulator = 2)
