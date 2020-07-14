/obj/machinery/mineral/bluespace_miner
	name = "bluespace mining machine"
	desc = "A machine that uses the magic of Bluespace to slowly generate materials and add them to a linked ore silo."
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "stacker"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/bluespace_miner
	layer = BELOW_OBJ_LAYER

	var/mining_rate = 10 //Amount of material gained on a mining tick
	var/mining_chance = 30 //Chance a mining tick results in materials gained
	//Ores that can be mined (and their weight)
	var/list/minable_ores = list(/datum/material/iron = 6, /datum/material/glass = 6, /*/datum/material/copper = 0.4,*/)
	var/list/tier2_ores = list(/datum/material/plasma = 2, /datum/material/silver = 3, /datum/material/titanium = 2)
	var/list/tier3_ores = list(/datum/material/gold = 2, /datum/material/uranium = 1)
	var/list/tier4_ores = list(/datum/material/diamond = 1)
	var/datum/component/remote_materials/materials

/obj/machinery/mineral/bluespace_miner/Initialize(mapload)
	. = ..()
	materials = AddComponent(/datum/component/remote_materials, "bsm", mapload)

/obj/machinery/mineral/bluespace_miner/Destroy()
	materials = null
	return ..()

/obj/machinery/mineral/bluespace_miner/RefreshParts()
	for(var/obj/item/stock_parts/scanning_module/SM in component_parts)
		if (SM.rating > 1)
			minable_ores |= tier2_ores
		if (SM.rating > 2)
			minable_ores |= tier3_ores
		if(SM.rating > 3)
			minable_ores |= tier4_ores
	for(var/obj/item/stock_parts/micro_laser/ML in component_parts)
		mining_rate = 10 ** (ML.rating)
	var/P = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		P += sqrt(M.rating) * 16
	mining_chance = P

/obj/machinery/mineral/bluespace_miner/examine(mob/user)
	. = ..()
	if(!materials?.silo)
		. += "<span class='notice'>No ore silo connected. Use a multi-tool to link an ore silo to this machine.</span>"
	else if(materials?.on_hold())
		. += "<span class='warning'>Ore silo access is on hold, please contact the quartermaster.</span>"

/obj/machinery/mineral/bluespace_miner/process()
	if(!materials?.silo || materials?.on_hold())
		return
	if(!materials.mat_container || panel_open || !powered())
		return
	if(prob(mining_chance))
		mine()

/obj/machinery/mineral/bluespace_miner/proc/mine()
	var/datum/material/ore = pickweight(minable_ores)
	materials.mat_container.insert_amount_mat((mining_rate), ore)
