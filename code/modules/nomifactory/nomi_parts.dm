/obj/item/nomi
	var/part_quality = 1

/obj/item/nomi/ingot_iron
	name = "iron ingot"

/obj/item/nomi/ingot_copper
	name = "copper ingot"

/obj/item/nomi/ingot_glass
	name = "glass... ingot?"

/obj/item/nomi/ingot_gold
	name = "gold ingot"

/obj/item/nomi/gear
	name = "gear"

/obj/item/nomi/coil
	name = "coil of wire"

/obj/item/nomi/ferro_rod
	name = "ferromagnetic rod"

/obj/item/nomi/motor
	name = "motor"

/obj/item/nomi/frame_casing
	name = "frame casing"

/obj/item/nomi/circuit
	name = "mainboard"

/obj/item/nomi/piston
	name = "piston"

/datum/crafting_recipe/nomi_iron_ingot
	name = "Iron Ingot"
	result = /obj/item/nomi/ingot_iron
	reqs = list(
		/obj/item/stack/sheet/metal = 1
	)
	tools = list(TOOL_WELDER)
	category = CAT_NOMIFACTORY
	subcategory = CAT_BASIC_PARTS
	time = 2 SECONDS

/datum/crafting_recipe/nomi_gold_ingot
	name = "Iron Ingot"
	result = /obj/item/nomi/ingot_gold
	reqs = list(
		/obj/item/stack/sheet/mineral/gold = 1
	)
	tools = list(TOOL_WELDER)
	category = CAT_NOMIFACTORY
	subcategory = CAT_BASIC_PARTS
	time = 2 SECONDS

/datum/crafting_recipe/nomi_gear
	name = "Gear"
	result = /obj/item/nomi/gear
	reqs = list(
		/obj/item/stack/sheet/metal = 8
	)
	tools = list(
		TOOL_WELDER,
		TOOL_WRENCH
	)
	category = CAT_NOMIFACTORY
	subcategory = CAT_BASIC_PARTS
	time = 2 SECONDS

/datum/crafting_recipe/nomi_coil
	name = "Wire Coil"
	result = /obj/item/nomi/coil
	reqs = list(
		/obj/item/stack/rods = 2,
		/obj/item/stack/cable_coil = 20
	)
	tools = list(
		TOOL_WIRECUTTER
	)
	category = CAT_NOMIFACTORY
	subcategory = CAT_BASIC_PARTS
	time = 0.5 SECONDS

/datum/crafting_recipe/nomi_motor
	name = "Assemble Basic Motor"
	result = /obj/item/nomi/motor
	reqs = list(
		/obj/item/nomi/frame_casing = 1,
		/obj/item/nomi/gear = 4,
		/obj/item/nomi/ferro_rod = 2,
		/obj/item/nomi/coil = 8
	)
	tools = list(
		TOOL_WRENCH,
		TOOL_SCREWDRIVER,
		TOOL_MULTITOOL
	)
	category = CAT_NOMIFACTORY
	subcategory = CAT_BASIC_PARTS
	time = 2 SECONDS

/datum/crafting_recipe/nomi_circuit
	name = "Assemble Basic Mainboard"
	result = /obj/item/nomi/circuit
	reqs = list(
		/obj/item/stack/sheet/mineral/gold = 2,
		/obj/item/stack/sheet/metal = 4,
		/obj/item/stack/cable_coil = 8
	)
	tools = list(
		TOOL_WIRECUTTER,
		TOOL_SCREWDRIVER,
		TOOL_HEMOSTAT
	)
	category = CAT_NOMIFACTORY
	subcategory = CAT_BASIC_PARTS
	time = 1.5 SECONDS

/datum/crafting_recipe/nomi_piston
	name = "Assemble Basic Piston"
	result = /obj/item/nomi/piston
	reqs = list(
		/obj/item/nomi/motor = 1,
		/obj/item/nomi/frame_casing = 1,
		/obj/item/stack/sheet/metal = 5
	)
	tools = list(
		TOOL_WRENCH,
		TOOL_SCREWDRIVER,
		TOOL_MULTITOOL
	)
	category = CAT_NOMIFACTORY
	subcategory = CAT_BASIC_PARTS
	time = 2 SECONDS
