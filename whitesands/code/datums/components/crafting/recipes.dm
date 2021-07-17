
/datum/crafting_recipe/splint
	name = "Makeshift Splint"
	reqs = list(
			/obj/item/stack/rods = 2,
			/obj/item/stack/sheet/cloth = 4)
	result = /obj/item/stack/medical/splint/ghetto
	category = CAT_MISC

/datum/crafting_recipe/cwzippo
	name = "Clockwork Zippo"
	reqs = list(
			/obj/item/lighter = 1,
			/obj/item/stack/tile/bronze = 5)
	result = /obj/item/lighter/clockwork
	category = CAT_MISC

/datum/crafting_recipe/portableseedextractor
	name = "Portable seed extractor"
	reqs = list(
			/obj/item/storage/bag/plants,
			/obj/item/plant_analyzer,
			/obj/item/stock_parts/manipulator,
			/obj/item/stack/cable_coil = 2)
	result = /obj/item/storage/bag/plants/portaseeder //this will probably mean that you can craft portable seed extractors into themselves, sending the other materials into the void, but we still don't have a solution for recipes involving radios stealing your headset, so this is officially not my problem. "no, Tills-The-Soil, adding more analyzers and micro-manipulators to your portable seed extractor does not make it make more seeds. in fact it does exactly nothing."
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_MISC
