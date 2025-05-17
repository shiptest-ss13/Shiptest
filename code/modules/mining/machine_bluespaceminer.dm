/obj/machinery/power/bluespace_miner
	name = "bluespace mining machine"
	desc = "A machine that uses the magic of Bluespace to slowly generate materials and add them to a linked ore silo."
	icon = 'icons/obj/machines/bsm.dmi'
	icon_state = "bsm_off"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/bluespace_miner
	layer = BELOW_OBJ_LAYER
	use_power = NO_POWER_USE
	idle_power_usage = ACTIVE_DRAW_EXTREME * 10

	var/powered = FALSE
	var/active = FALSE
	//Variables affected by parts
	var/power_coeff = 0 //% reduction in power use
	var/mining_rate = 0 //Amount of material gained on a mining tick
	var/mining_chance = 0 //Chance a mining tick results in materials gained
	//Ores that can be mined (and their weight)
	var/list/minable_ores = list(/datum/material/iron = 4, /datum/material/glass = 4)
	var/list/tier2_ores = list(/datum/material/plasma = 2, /datum/material/silver = 3, /datum/material/titanium = 3)
	var/list/tier3_ores = list(/datum/material/gold = 2, /datum/material/uranium = 1)
	var/list/tier4_ores = list(/datum/material/diamond = 1)
	var/datum/component/remote_materials/materials

/obj/machinery/power/bluespace_miner/Initialize(mapload)
	. = ..()
	RefreshParts()
	if(anchored)
		connect_to_network()
	materials = AddComponent(/datum/component/remote_materials, "bsm", mapload)

/obj/machinery/power/bluespace_miner/Destroy()
	materials = null
	return ..()

/obj/machinery/power/bluespace_miner/update_icon_state()
	if (panel_open)
		icon_state = "bsm_t"
		return
	if (powered)
		icon_state = (active) ? "bsm_on" : "bsm_idle"
	else
		icon_state = "bsm_off"
	return ..()

/obj/machinery/power/bluespace_miner/RefreshParts()
	var/M_C = 0 //mining_chance
	var/P_C = 1.3 //power_coeff
	for(var/obj/item/stock_parts/scanning_module/SM in component_parts)
		if (SM.rating > 1)
			minable_ores |= tier2_ores
		if (SM.rating > 2)
			minable_ores |= tier3_ores
		if(SM.rating > 3)
			minable_ores |= tier4_ores
	for(var/obj/item/stock_parts/micro_laser/ML in component_parts)
		mining_rate = 10 ** sqrt(ML.rating)
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		M_C += 12 * sqrt(M.rating) + 8
	mining_chance = M_C
	if(idle_power_usage)
		for(var/obj/item/stock_parts/matter_bin/MB in component_parts)
			P_C -= MB.rating*0.1
		power_coeff = P_C
/obj/machinery/power/bluespace_miner/examine(mob/user)
	. += ..()
	if(anchored)
		. += span_info("It's currently anchored to the floor, you can unsecure it with a <b>wrench</b>.")
	else
		. += span_info("It's not anchored to the floor. You can secure it in place with a <b>wrench</b>.")
	if(panel_open)
		. += span_info("It's maintenence panel is exposed. You can seal the cover with a <b>screwdriver</b>.")
	if(in_range(user, src) || isobserver(user))
		if(!materials?.silo)
			. += span_notice("No ore silo connected. Use a multi-tool to link an ore silo to this machine.")
		else if(materials?.on_hold())
			. += span_warning("Ore silo access is on hold, please contact the quartermaster.")
		if(!active)
			. += span_notice("Its status display is currently turned off.")
		else if(!powered)
			. += span_notice("Its status display is glowing faintly.")
		else
			. += span_notice("Its status display reads: Mining with [mining_chance]% efficiency.")
			. += span_notice("Power consumption at <b>[DisplayPower(idle_power_usage * power_coeff)]</b>.")

/obj/machinery/power/bluespace_miner/interact(mob/user)
	add_fingerprint(user)
	if(anchored)
		if(!powernet)
			to_chat(user, span_warning("\The [src] isn't connected to a wire!"))
			return TRUE
		if(panel_open)
			to_chat(user, span_warning("\The maintenence hatch for the [src] is exposed!"))
			return TRUE
		if(active)
			active = FALSE
			to_chat(user, span_notice("You turn off the [src]."))
		else
			if(!materials?.silo || materials?.on_hold())
				to_chat(user, span_warning("ERROR CONNECTING TO ORE SILO! Please check your connection, and try again."))
				return TRUE
			active = TRUE
			to_chat(user, span_notice("You turn on the [src]."))
		update_appearance()
	else
		to_chat(user, span_warning("[src] needs to be firmly secured to the floor first!"))
		return TRUE

/obj/machinery/power/bluespace_miner/process(seconds_per_tick)
	if(!materials?.silo || materials?.on_hold())
		active = FALSE
		return
	if(!materials.mat_container || panel_open)
		active = FALSE
		return
	if(!anchored || (!powernet && idle_power_usage))
		powered = FALSE
		active = FALSE
		update_appearance()
		return
	if(active)
		var/true_power_usage = idle_power_usage * power_coeff
		if(!idle_power_usage || surplus() >= true_power_usage)
			add_load(true_power_usage)
			if(!powered)
				powered = TRUE
				update_appearance()
			if(prob(mining_chance))
				mine()
		else
			if(powered)
				powered = FALSE
				update_appearance()
			return

/obj/machinery/power/bluespace_miner/can_be_unfasten_wrench(mob/user, silent)
	if(active)
		to_chat(user, span_warning("Turn \the [src] off first!"))
		return FAILED_UNFASTEN
	return ..()

/obj/machinery/power/bluespace_miner/wrench_act(mob/living/user, obj/item/I)
	..()
	default_unfasten_wrench(user, I)
	if(anchored)
		connect_to_network()
	else
		disconnect_from_network()
	return TRUE

/obj/machinery/power/bluespace_miner/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(active)
		to_chat(user, span_warning("Turn \the [src] off first!"))
		return TRUE
	default_deconstruction_screwdriver(user, "bsm_t", "bsm_off", I)
	update_icon_state()
	return TRUE

/obj/machinery/power/bluespace_miner/crowbar_act(mob/living/user, obj/item/I)
	default_deconstruction_crowbar(I)
	return TRUE

/obj/machinery/power/bluespace_miner/proc/mine()
	var/datum/material/ore = pick(minable_ores)
	materials.mat_container.insert_amount_mat((mining_rate * minable_ores[ore]), ore)
