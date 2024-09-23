/datum/crafting_recipe/skateboard
	name = "Skateboard"
	result = /obj/vehicle/ridden/scooter/skateboard
	time = 60
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/rods = 10)
	category = CAT_MISC

/datum/crafting_recipe/scooter
	name = "Scooter"
	result = /obj/vehicle/ridden/scooter
	time = 65
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/rods = 12)
	category = CAT_MISC

/datum/crafting_recipe/wheelchair
	name = "Wheelchair"
	result = /obj/vehicle/ridden/wheelchair
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/rods = 6)
	time = 100
	category = CAT_MISC

/datum/crafting_recipe/motorized_wheelchair
	name = "Motorized Wheelchair"
	result = /obj/vehicle/ridden/wheelchair/motorized
	reqs = list(/obj/item/stack/sheet/metal = 10,
		/obj/item/stack/rods = 8,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/capacitor = 1)
	parts = list(/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/capacitor = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WRENCH)
	time = 200
	category = CAT_MISC

/datum/crafting_recipe/mousetrap
	name = "Mouse Trap"
	result = /obj/item/assembly/mousetrap
	time = 10
	reqs = list(/obj/item/stack/sheet/cardboard = 1,
				/obj/item/stack/rods = 1)
	category = CAT_MISC

/datum/crafting_recipe/papersack
	name = "Paper Sack"
	result = /obj/item/storage/box/papersack
	time = 10
	reqs = list(/obj/item/paper = 5)
	category = CAT_MISC

/datum/crafting_recipe/paperframes
	name = "Paper Frames"
	result = /obj/item/stack/sheet/paperframes/five
	time = 10
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5, /obj/item/paper = 20)
	category = CAT_MISC

/datum/crafting_recipe/naturalpaper
	name = "Hand-Pressed Paper"
	time = 30
	reqs = list(/datum/reagent/water = 50, /obj/item/stack/sheet/mineral/wood = 1)
	tools = list(/obj/item/hatchet)
	result = /obj/item/paper_bin/bundlenatural
	category = CAT_MISC

/datum/crafting_recipe/curtain
	name = "Curtains"
	reqs = 	list(/obj/item/stack/sheet/cotton/cloth = 4, /obj/item/stack/rods = 1)
	result = /obj/structure/curtain/cloth
	category = CAT_MISC

/datum/crafting_recipe/showercurtain
	name = "Shower Curtains"
	reqs = 	list(/obj/item/stack/sheet/cotton/cloth = 2, /obj/item/stack/sheet/plastic = 2, /obj/item/stack/rods = 1)
	result = /obj/structure/curtain
	category = CAT_MISC

/datum/crafting_recipe/pressureplate
	name = "Pressure Plate"
	result = /obj/item/pressure_plate
	time = 5
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/tile/plasteel = 1,
				/obj/item/stack/cable_coil = 2,
				/obj/item/assembly/igniter = 1)
	category = CAT_MISC

/datum/crafting_recipe/rcl
	name = "Makeshift Rapid Cable Layer"
	result = /obj/item/rcl/ghetto
	time = 40
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WRENCH)
	reqs = list(/obj/item/stack/sheet/metal = 15)
	category = CAT_MISC

/datum/crafting_recipe/ghettojetpack
	name = "Improvised Jetpack"
	result = /obj/item/tank/jetpack/improvised
	time = 30
	reqs = list(/obj/item/tank/internals/oxygen = 2, /obj/item/extinguisher = 1, /obj/item/pipe = 3, /obj/item/stack/cable_coil = MAXCOIL)
	category = CAT_MISC
	tools = list(TOOL_WRENCH, TOOL_WELDER, TOOL_WIRECUTTER)

/datum/crafting_recipe/multiduct
	name = "Multi-layer duct"
	result = /obj/machinery/duct/multilayered
	time = 5
	reqs = list(/obj/item/stack/ducts = 5)
	category = CAT_MISC
	tools = list(TOOL_WELDER)

/datum/crafting_recipe/ipickaxe
	name = "Improvised Pickaxe"
	reqs = list(
			/obj/item/crowbar = 1,
			/obj/item/melee/knife/kitchen = 1,
			/obj/item/stack/tape = 1)
	result = /obj/item/pickaxe/improvised
	category = CAT_MISC

/datum/crafting_recipe/chem_scanner
	name = "Reagent Scanner"
	time = 30
	tools = list(TOOL_WIRECUTTER, TOOL_SCREWDRIVER)
	reqs = list(
		/obj/item/healthanalyzer = 1,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/scanning_module = 1)
	result = /obj/item/reagent_scanner
	category = CAT_MISC

/datum/crafting_recipe/filter
	name = "Seperatory Funnel"
	time = 40
	tools = list(TOOL_WELDER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/stack/cable_coil = 1,
		/obj/item/reagent_containers/glass/beaker = 3)
	result = /obj/item/reagent_containers/glass/filter
	category = CAT_MISC

/datum/crafting_recipe/splint
	name = "Makeshift Splint"
	reqs = list(
			/obj/item/stack/rods = 2,
			/obj/item/stack/sheet/cotton/cloth = 4)
	result = /obj/item/stack/medical/splint/ghetto
	category = CAT_MISC

/datum/crafting_recipe/portableseedextractor
	name = "Portable seed extractor"
	reqs = list(
			/obj/item/storage/bag/plants = 1,
			/obj/item/plant_analyzer = 1,
			/obj/item/stock_parts/manipulator = 1,
			/obj/item/stack/cable_coil = 2)
	result = /obj/item/storage/bag/plants/portaseeder //this will probably mean that you can craft portable seed extractors into themselves, sending the other materials into the void, but we still don't have a solution for recipes involving radios stealing your headset, so this is officially not my problem. "no, Tills-The-Soil, adding more analyzers and micro-manipulators to your portable seed extractor does not make it make more seeds. in fact it does exactly nothing."
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_MISC

/datum/crafting_recipe/freezer
	name = "Freezer"
	result = /obj/structure/closet/crate/freezer
	time = 2 SECONDS
	reqs = list(/datum/reagent/consumable/ice = 25,
	/obj/item/stack/sheet/metal = 2)
	category = CAT_MISC

/datum/crafting_recipe/aquarium
	name = "Aquarium"
	result = /obj/structure/aquarium
	time = 10 SECONDS
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/stack/sheet/glass = 10,
				/obj/item/aquarium_kit = 1)
	category = CAT_MISC

/datum/crafting_recipe/candorupgrade
	name = "Candor Upgrade"
	result = /obj/item/gun/ballistic/automatic/pistol/candor/phenex
	reqs = list(/obj/item/stack/sheet/mineral/hidden = 4,
				/obj/item/gun/ballistic/automatic/pistol/candor = 1)
	category = CAT_MISC

/datum/crafting_recipe/bonfire
	name = "Bonfire"
	time = 60
	reqs = list(/obj/item/grown/log = 5)
	parts = list(/obj/item/grown/log = 5)
	blacklist = list(/obj/item/grown/log/steel)
	result = /obj/structure/bonfire
	category = CAT_MISC

/datum/crafting_recipe/distiller
	name = "Distiller"
	result = /obj/structure/fermenting_barrel/distiller
	reqs = list(/obj/item/stack/sheet/mineral/wood = 8, /obj/item/stack/sheet/metal = 5, /datum/reagent/srm_bacteria = 30)
	time = 50
	category = CAT_MISC

/datum/crafting_recipe/charcoal_stylus
	name = "Charcoal Stylus"
	result = /obj/item/pen/charcoal
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1, /datum/reagent/ash = 30)
	time = 30
	category = CAT_MISC

/datum/crafting_recipe/mushroom_bowl
	name = "Mushroom Bowl"
	result = /obj/item/reagent_containers/glass/bowl/mushroom_bowl
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings = 5)
	time = 30
	category = CAT_MISC

/datum/crafting_recipe/chainsaw
	name = "Chainsaw"
	result = /obj/item/chainsaw
	reqs = list(/obj/item/circular_saw = 1,
				/obj/item/stack/cable_coil = 3,
				/obj/item/stack/sheet/plasteel = 5)
	tools = list(TOOL_WELDER)
	time = 50
	category = CAT_MISC
