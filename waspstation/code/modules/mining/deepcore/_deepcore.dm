/*\
	Crude Material Container - Subcomponent to support the transfer of unrefined ores
	Assumes ores are the same material value as sheets, because at the time of writing they in fact are.
\*/
/datum/component/material_container/crude
	var/ore_type

//I know it still says sheets but bear with me here, it's ores now
/datum/component/material_container/crude/retrieve_sheets(sheet_amt, datum/material/M, target)
	if((!M.ore_type) || (sheet_amt <= 0))
		return 0
	if(!target)
		target = get_turf(parent)
	if(materials[M] < (sheet_amt * MINERAL_MATERIAL_AMOUNT))
		sheet_amt = round(materials[M] / MINERAL_MATERIAL_AMOUNT)
	var/count = 0
	while(sheet_amt > MAX_STACK_SIZE)
		new M.ore_type(target, MAX_STACK_SIZE)
		count += MAX_STACK_SIZE
		use_amount_mat(sheet_amt * MINERAL_MATERIAL_AMOUNT, M)
		sheet_amt -= MAX_STACK_SIZE
	if(sheet_amt >= 1)
		new M.ore_type(target, sheet_amt)
		count += sheet_amt
		use_amount_mat(sheet_amt * MINERAL_MATERIAL_AMOUNT, M)
	return count

/datum/component/material_container/crude/OnExamine(datum/source, mob/user)
	//See? Totally ores now.
	if(show_on_examine)
		for(var/I in materials)
			var/datum/material/M = I
			var/amt = materials[I]
			if(amt)
				to_chat(user, "<span class='notice'>It has [amt] units of unrefined [lowertext(M.name)] stored.</span>")

/datum/component/material_container/crude/OnAttackBy(datum/source, obj/item/I, mob/living/user)
	return //This container is specifically for ore, so no user filling.

/*\
	Deepcore machines:
		network - The DCMnet itself
		container - The material container component used for those sweet mats
\*/
/obj/machinery/deepcore
	icon = 'waspstation/icons/obj/machines/deepcore.dmi'
	var/datum/dcm_net/network
	var/datum/component/material_container/crude/container

/obj/machinery/deepcore/Initialize(mapload)
	. = ..()
	if(mapload && !network && GLOB.dcm_net_default)
		SetNetwork(GLOB.dcm_net_default)

/obj/machinery/deepcore/ComponentInitialize()
	. = ..()
	var/static/list/ores_list = list(
		/datum/material/iron,
		/datum/material/glass,
		/datum/material/silver,
		/datum/material/gold,
		/datum/material/diamond,
		/datum/material/plasma,
		/datum/material/uranium,
		/datum/material/bananium,
		/datum/material/titanium,
		/datum/material/bluespace
	)
	// container starts with 0 max amount
	container = AddComponent(/datum/component/material_container/crude, ores_list, 0, FALSE, null, null, null, TRUE)

/obj/machinery/deepcore/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if(!istype(I))
		return FALSE

	//Check if we would like to add a network
	if(istype(I.buffer, /datum/dcm_net))
		if(network)
			to_chat(user, "<span class='notice'>You move [src] onto the network saved in the multitool's buffer...</span>")
			ClearNetwork()
			SetNetwork(I.buffer)
			return TRUE
		else
			to_chat(user, "<span class='notice'>You load the saved network data into [src] and test the connection...</span>")
			SetNetwork(I.buffer)
			return TRUE

/obj/machinery/deepcore/examine(mob/user)
	. = ..()
	if(network)
		. += "<span class='info'>This device is registered with a network connected to [length(network.connected)] devices.</span>"

/obj/machinery/deepcore/proc/SetNetwork(var/datum/dcm_net/net)
	return net.AddMachine(src)

/obj/machinery/deepcore/proc/ClearNetwork()
	return network.RemoveMachine(src)

/obj/machinery/deepcore/proc/MergeNetwork(var/datum/dcm_net/net)
	network.MergeWith(net)
