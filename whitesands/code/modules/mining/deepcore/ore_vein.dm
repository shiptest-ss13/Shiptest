GLOBAL_LIST_EMPTY(ore_vein_landmarks)

/obj/effect/landmark/ore_vein
	name = "ore vein"
	var/datum/material/resource
	var/material_rate = 0

/obj/effect/landmark/ore_vein/Initialize(mapload, var/datum/material/mat)
	. = ..()
	GLOB.ore_vein_landmarks += src
	// Key = Material path; Value = Material Rate
	//! Ensure material datum has an ore_type set
	var/static/list/ores_list = list(
		/datum/material/iron = 600,
		/datum/material/glass = 500,
		/datum/material/silver = 400,
		/datum/material/gold = 350,
		/datum/material/diamond = 100,
		/datum/material/plasma = 450,
		/datum/material/uranium = 200,
		/datum/material/titanium = 300,
		/datum/material/bluespace = 50
	)
	var/datum/material/M = resource
	if(mat)
		M = mat
	else if (!M)
		M = pick(ores_list) //random is default
	resource = M
	if((!material_rate) && ores_list[M])
		material_rate = ores_list[M]

/obj/effect/landmark/ore_vein/proc/extract_ore() //Called by deepcore drills, returns a list of keyed ore stacks by amount
	var/list/ores = list()
	ores[resource] = material_rate
	return ores

//Common ore prefabs

/obj/effect/landmark/ore_vein/iron
	resource = /datum/material/iron

/obj/effect/landmark/ore_vein/plasma
	resource = /datum/material/plasma

/obj/effect/landmark/ore_vein/silver
	resource = /datum/material/silver

/obj/effect/landmark/ore_vein/gold
	resource = /datum/material/gold

/obj/effect/landmark/ore_vein/glass
	resource = /datum/material/glass

/obj/effect/landmark/ore_vein/diamond
	resource = /datum/material/diamond

/obj/effect/landmark/ore_vein/uranium
	resource = /datum/material/uranium

/obj/effect/landmark/ore_vein/titanium
	resource = /datum/material/titanium

/obj/effect/landmark/ore_vein/bluespace
	resource = /datum/material/bluespace

/obj/effect/landmark/ore_vein/bananium
	resource = /datum/material/bananium
	material_rate = 10 //HONK HONK
