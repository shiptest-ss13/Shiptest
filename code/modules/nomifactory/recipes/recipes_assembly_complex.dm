/datum/nomi_recipe/assembly
	abstract = /datum/nomi_recipe/assembly
	machine_needed = /obj/machinery/nomifactory/machinery/assembly_complex

// Components
/datum/nomi_recipe/assembly/transistor
	name = "Transistor Fabrication"
	inputs = list (
		/obj/item/nomi/ingot_iron = 1,
		/obj/item/nomi/ingot_gold = 1,
		/obj/item/nomi/coil = 2,
	)
	outputs = list (
		/obj/item/nomi/transistor = 4,
	)

/datum/nomi_recipe/assembly/microchip
	name = "Microchip Precision Assembly"
	inputs = list (
		/obj/item/nomi/ingot_iron = 1,
		/obj/item/nomi/transistor = 1,
		/obj/item/nomi/coil = 2,
	)
	outputs = list (
		/obj/item/nomi/microchip = 4,
	)

/datum/nomi_recipe/assembly/microchip/advanced
	name = "Advanced Microchip Precision Assembly"
	inputs = list (
		/obj/item/nomi/ingot_iron = 1,
		/obj/item/nomi/diamond = 1,
		/obj/item/nomi/transistor = 1,
		/obj/item/nomi/coil = 2,
	)
	outputs = list (
		/obj/item/nomi/microchip/advanced = 4,
	)

/datum/nomi_recipe/assembly/lens
	name = "Laser Lens Fabrication"
	inputs = list (
		/obj/item/nomi/ingot_glass = 1
	)
	outputs = list (
		/obj/item/nomi/lens = 4,
	)

// Capacitor
/datum/nomi_recipe/assembly/capacitor/basic
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

/datum/nomi_recipe/assembly/capacitor/advanced
	name = "Advanced Capacitor Fabrication"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/coil = 2,
		/obj/item/nomi/transistor = 2,
	)
	outputs = list(
		/obj/item/stock_parts/capacitor/adv = 2
	)

/datum/nomi_recipe/assembly/capacitor/super
	name = "Super Capacitor Fabrication"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/coil = 2,
		/obj/item/nomi/transistor = 2,
		/obj/item/nomi/ingot_gold = 1
	)
	outputs = list(
		/obj/item/stock_parts/capacitor/super = 2
	)

/datum/nomi_recipe/assembly/capacitor/quadratic
	name = "Quadratic Capacitor Fabrication"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/coil = 2,
		/obj/item/nomi/microchip/advanced = 2,
		/obj/item/nomi/ingot_gold = 1,
	)
	outputs = list(
		/obj/item/stock_parts/capacitor/quadratic = 2
	)

// Matter bin
/datum/nomi_recipe/assembly/matter_bin/basic
	name = "Matter Bin Stamping"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/piston = 2,
		/obj/item/nomi/gear = 2
	)
	outputs = list(
		/obj/item/stock_parts/matter_bin = 2
	)
/datum/nomi_recipe/assembly/matter_bin/advanced
	name = "Advanced Matter Bin Stamping"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/piston = 2,
		/obj/item/nomi/gear = 2,
		/obj/item/nomi/microchip = 1
	)
	outputs = list(
		/obj/item/stock_parts/matter_bin/adv = 2
	)
/datum/nomi_recipe/assembly/matter_bin/super
	name = "Super Matter Bin Stamping"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/piston = 4,
		/obj/item/nomi/gear = 4,
		/obj/item/nomi/microchip/advanced = 1
	)
	outputs = list(
		/obj/item/stock_parts/matter_bin/super = 2
	)
/datum/nomi_recipe/assembly/matter_bin/bluespace
	name = "Bluespace Matter Bin Stamping"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/piston = 6,
		/obj/item/nomi/gear = 6,
		/obj/item/nomi/microchip/advanced = 1
	)
	outputs = list(
		/obj/item/stock_parts/matter_bin/bluespace = 2
	)

// Laser
/datum/nomi_recipe/assembly/laser/basic
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
/datum/nomi_recipe/assembly/laser/high
	name = "High-Power Micro-Laser Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/microchip = 1,
		/obj/item/nomi/lens = 1,
	)
	outputs = list(
		/obj/item/stock_parts/micro_laser/high = 2
	)
/datum/nomi_recipe/assembly/laser/ultra
	name = "Ultra-High Micro-Laser Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/microchip = 1,
		/obj/item/nomi/lens = 2,
	)
	outputs = list(
		/obj/item/stock_parts/micro_laser/ultra = 2
	)
/datum/nomi_recipe/assembly/laser/quadultra
	name = "Quad-Ultra Micro-Laser Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/microchip/advanced = 1,
		/obj/item/nomi/lens = 3,
	)
	outputs = list(
		/obj/item/stock_parts/micro_laser/quadultra = 2
	)

// Manipulator
/datum/nomi_recipe/assembly/manipulator/basic
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

/datum/nomi_recipe/assembly/manipulator/nano
	name = "Nano-Manipulator Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/piston = 2,
		/obj/item/nomi/gear = 2,
		/obj/item/nomi/ingot_iron = 1,
		/obj/item/nomi/microchip = 1
	)
	outputs = list(
		/obj/item/stock_parts/manipulator/nano = 2
	)

/datum/nomi_recipe/assembly/manipulator/pico
	name = "Pico-Manipulator Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/piston = 3,
		/obj/item/nomi/gear = 3,
		/obj/item/nomi/ingot_iron = 1,
		/obj/item/nomi/microchip = 2
	)
	outputs = list(
		/obj/item/stock_parts/manipulator/pico = 2
	)

/datum/nomi_recipe/assembly/manipulator/femto
	name = "Femto-Manipulator Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/piston = 4,
		/obj/item/nomi/gear = 4,
		/obj/item/nomi/ingot_iron = 1,
		/obj/item/nomi/microchip/advanced = 1
	)
	outputs = list(
		/obj/item/stock_parts/manipulator/femto = 2
	)

// Scanning module

/datum/nomi_recipe/assembly/scanning_module/basic
	name = "Scanning Module Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/microchip = 2,
		/obj/item/nomi/ingot_glass = 1,
		/obj/item/nomi/coil = 2,
	)
	outputs = list(
		/obj/item/stock_parts/scanning_module = 2
	)
/datum/nomi_recipe/assembly/scanning_module/advanced
	name = "Advanced Scanning Module Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/microchip = 2,
		/obj/item/nomi/ingot_glass = 1,
		/obj/item/nomi/coil = 2,
	)
	outputs = list(
		/obj/item/stock_parts/scanning_module/adv = 2
	)
/datum/nomi_recipe/assembly/scanning_module/phasic
	name = "Phasic Scanning Module Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/microchip/advanced = 2,
		/obj/item/nomi/ingot_glass = 1,
		/obj/item/nomi/ingot_gold = 1,
		/obj/item/nomi/coil = 2,
	)
	outputs = list(
		/obj/item/stock_parts/scanning_module/phasic = 2
	)
/datum/nomi_recipe/assembly/scanning_module/triphasic
	name = "Triphasic Scanning Module Assembly"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/microchip/advanced = 2,
		/obj/item/nomi/ingot_gold = 1,
		/obj/item/nomi/coil = 2,
	)
	outputs = list(
		/obj/item/stock_parts/scanning_module/triphasic = 2
	)

// Powercell
/datum/nomi_recipe/assembly/powercell/basic
	name = "Powercell Fabrication"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stock_parts/capacitor = 2,
		/obj/item/nomi/coil = 2
	)
	outputs = list(
		/obj/item/stock_parts/cell/empty = 1
	)
/datum/nomi_recipe/assembly/powercell/high
	name = "High-Capacity Powercell Fabrication"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stock_parts/capacitor/adv = 2,
		/obj/item/nomi/microchip = 1,
		/obj/item/nomi/coil = 2
	)
	outputs = list(
		/obj/item/stock_parts/cell/high/empty = 1
	)
/datum/nomi_recipe/assembly/powercell/super
	name = "Super-Capacity Powercell Fabrication"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stock_parts/capacitor/super = 2,
		/obj/item/nomi/microchip = 1,
		/obj/item/nomi/coil = 2
	)
	outputs = list(
		/obj/item/stock_parts/cell/super/empty = 1
	)
/datum/nomi_recipe/assembly/powercell/hyper
	name = "Hyper-Capcity Powercell Fabrication"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stock_parts/capacitor/quadratic = 2,
		/obj/item/nomi/microchip/advanced = 1,
		/obj/item/nomi/coil = 2
	)
	outputs = list(
		/obj/item/stock_parts/cell/hyper/empty = 1
	)
/datum/nomi_recipe/assembly/powercell/bluespace
	name = "BluespacePowercell Fabrication"
	inputs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stock_parts/capacitor/quadratic = 2,
		/obj/item/nomi/microchip/advanced = 1,
		/obj/item/stack/sheet/bluespace_crystal = 2,
		/obj/item/nomi/coil = 2
	)
	outputs = list(
		/obj/item/stock_parts/cell/bluespace/empty = 1
	)
