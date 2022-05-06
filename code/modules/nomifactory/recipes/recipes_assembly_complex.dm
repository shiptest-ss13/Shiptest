/datum/nomi_recipe/assembly
	abstract = /datum/nomi_recipe/assembly
	machine_needed = /obj/structure/nomifactory/machinery/assembly_complex

/datum/nomi_recipe/assembly/capacitor
	name = "Capacitor Fabrication"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/coil = 2,
		/obj/item/nomi/ingot_copper = 2,
		/obj/item/nomi/ingot_gold = 1
	)
	outputs = list(
		/obj/item/stock_parts/capacitor = 2
	)

/datum/nomi_recipe/assembly/matter_bin
	name = "Matter Bin Stamping"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/piston = 2,
		/obj/item/nomi/gear = 2
	)
	outputs = list(
		/obj/item/stock_parts/matter_bin = 2
	)

/datum/nomi_recipe/assembly/laser
	name = "Micro-Laser Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/ingot_glass = 2,
		/obj/item/nomi/ingot_gold = 1,
		/obj/item/nomi/ingot_copper = 1
	)
	outputs = list(
		/obj/item/stock_parts/micro_laser = 2
	)

/datum/nomi_recipe/assembly/manipulator
	name = "Micro-Manipulator Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/piston = 2,
		/obj/item/nomi/gear = 1,
		/obj/item/nomi/ingot_iron = 1
	)
	outputs = list(
		/obj/item/stock_parts/manipulator = 2
	)

/datum/nomi_recipe/assembly/powercell
	name = "Powercell Fabrication"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/ingot_copper = 2,
		/obj/item/nomi/ingot_gold = 2,
		/obj/item/nomi/coil = 2
	)
	outputs = list(
		/obj/item/stock_parts/cell/empty = 2
	)
