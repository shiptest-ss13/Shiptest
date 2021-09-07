
/datum/crafting_recipe/splint
	name = "Makeshift Splint"
	reqs = list(
			/obj/item/stack/rods = 2,
			/obj/item/stack/sheet/cotton/cloth = 4)
	result = /obj/item/stack/medical/splint/ghetto
	category = CAT_MISC

/datum/crafting_recipe/cwzippo
	name = "Clockwork Zippo"
	reqs = list(
			/obj/item/lighter = 1,
			/obj/item/stack/tile/bronze = 5)
	result = /obj/item/lighter/clockwork
	category = CAT_MISC

/datum/crafting_recipe/pipebow
	name = "Pipe Bow"
	result = /obj/item/gun/ballistic/bow/pipe
	reqs = list(/obj/item/pipe = 5,
				/obj/item/stack/sheet/plastic = 15,
				/obj/item/weaponcrafting/silkstring = 10)
	time = 450
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/arrow
	name = "Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/wood
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/sheet/silk = 1,
				/obj/item/stack/rods = 1) //1 metal sheet = 2 rods= 2 arrows
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/bone_arrow
	name = "Bone Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 1,
				/obj/item/stack/sheet/sinew = 1,
				/obj/item/ammo_casing/caseless/arrow/ash = 1)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/ashen_arrow
	name = "Fire hardened arrow"
	result = /obj/item/ammo_casing/caseless/arrow/ash
	tools = list(TOOL_WELDER)
	time = 30
	reqs = list(/obj/item/ammo_casing/caseless/arrow/wood = 1)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/bronze_arrow
	name = "Bronze arrow"
	result = /obj/item/ammo_casing/caseless/arrow/bronze
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/tile/bronze = 1,
				/obj/item/stack/sheet/silk = 1)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/heavybonearmor
	name = "Heavy Bone Armor"
	result = /obj/item/clothing/suit/hooded/cloak/bone
	time = 60
	reqs = list(/obj/item/stack/sheet/bone = 8,
				/obj/item/stack/sheet/sinew = 3)
	category = CAT_PRIMAL

/datum/crafting_recipe/watcherbola
	name = "Watcher Bola"
	result = /obj/item/restraints/legcuffs/bola/watcher
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/goliath_hide = 2,
				/obj/item/restraints/handcuffs/cable/sinew = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/goliathshield
	name = "Goliath shield"
	result = /obj/item/shield/riot/goliath
	time = 60
	reqs = list(/obj/item/stack/sheet/bone = 4,
				/obj/item/stack/sheet/animalhide/goliath_hide = 3)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonesword
	name = "Bone Sword"
	result = /obj/item/claymore/bone
	time = 40
	reqs = list(/obj/item/stack/sheet/bone = 3,
				/obj/item/stack/sheet/sinew = 2)
	category = CAT_PRIMAL

/datum/crafting_recipe/hunterbelt
	name = "Hunters Belt"
	result = /obj/item/storage/belt/mining/primitive
	time = 20
	reqs = list(/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide = 2)
	category = CAT_PRIMAL

/datum/crafting_recipe/quiver
	name = "Quiver"
	result = /obj/item/storage/bag/quiver/empty
	time = 80
	reqs = list(/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/sinew = 4)
	category = CAT_PRIMAL

/datum/crafting_recipe/bone_bow
	name = "Bone Bow"
	result = /obj/item/gun/ballistic/bow/ashen
	time = 200
	reqs = list(/obj/item/stack/sheet/bone = 8,
				/obj/item/stack/sheet/sinew = 4)
	category = CAT_PRIMAL
/datum/crafting_recipe/boneclub
	name = "Bone Club"
	result = /obj/item/melee/baseball_bat/bone
	time = 40
	reqs = list(/obj/item/stack/sheet/bone = 6)
	category = CAT_PRIMAL
/datum/crafting_recipe/polarbearcloak
	name = "Polar Cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath/polar
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 2)
	blacklist = list(/obj/item/stack/sheet/animalhide/goliath_hide)
	category = CAT_PRIMAL
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
