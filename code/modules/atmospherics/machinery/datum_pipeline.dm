/datum/pipeline
	var/datum/gas_mixture/air
	var/list/datum/gas_mixture/other_airs

	var/list/obj/machinery/atmospherics/pipe/members
	var/list/obj/machinery/atmospherics/components/other_atmosmch

	var/update = TRUE

	///Is this pipeline being reconstructed?
	var/building = FALSE

/datum/pipeline/New()
	other_airs = list()
	members = list()
	other_atmosmch = list()
	SSair.networks += src

/datum/pipeline/Destroy()
	SSair.networks -= src
	if(building)
		SSair.remove_from_expansion(src)
	if(air?.return_volume())
		temporarily_store_air()
	for(var/obj/machinery/atmospherics/pipe/P in members)
		P.parent = null
		if(QDELETED(P))
			continue
		SSair.add_to_rebuild_queue(P)
	members.Cut()
	for(var/obj/machinery/atmospherics/components/C in other_atmosmch)
		C.nullifyPipenet(src)
	other_atmosmch.Cut()
	return ..()

/datum/pipeline/process()
	if(!update || building)
		return
	reconcile_air()
	update = air.react(src)

/datum/pipeline/proc/build_pipeline(obj/machinery/atmospherics/base)
	if(QDELETED(base))
		return
	building = TRUE
	var/volume = 0
	if(istype(base, /obj/machinery/atmospherics/pipe))
		var/obj/machinery/atmospherics/pipe/considered_pipe = base
		volume = considered_pipe.volume
		members += considered_pipe
		if(considered_pipe.air_temporary)
			air = considered_pipe.air_temporary
			considered_pipe.air_temporary = null
	else
		addMachineryMember(base)
	if(!air)
		air = new
	air.set_volume(volume)
	SSair.add_to_expansion(src, base)

///Has the same effect as build_pipeline(), but this doesn't queue its work, so overrun abounds. It's useful for the pregame
/datum/pipeline/proc/build_pipeline_blocking(obj/machinery/atmospherics/base)
	var/volume = 0
	if(istype(base, /obj/machinery/atmospherics/pipe))
		var/obj/machinery/atmospherics/pipe/E = base
		volume = E.volume
		members += E
		if(E.air_temporary)
			air = E.air_temporary
			E.air_temporary = null
	else
		addMachineryMember(base)
	if(!air)
		air = new
	var/list/possible_expansions = list(base)
	while(length(possible_expansions))
		for(var/obj/machinery/atmospherics/borderline in possible_expansions)
			var/list/result = borderline.pipeline_expansion(src)
			if(!length(result))
				continue
			for(var/obj/machinery/atmospherics/considered_device in result)
				if(!istype(considered_device, /obj/machinery/atmospherics/pipe))
					considered_device.setPipenet(src, borderline)
					addMachineryMember(considered_device)
					continue

				var/obj/machinery/atmospherics/pipe/item = considered_device
				if(item in members)
					continue

				if(item.parent)
					log_mapping("Possible doubled atmosmachine found at [AREACOORD(item)] with other contents: [json_encode(item.loc.contents)]")
					item.stack_trace("Possible doubled atmosmachine found")
					continue

				members += item
				possible_expansions += item

				volume += item.volume
				item.parent = src

				if(item.air_temporary)
					air.merge(item.air_temporary)
					item.air_temporary = null

			possible_expansions -= borderline

	air.set_volume(volume)

/datum/pipeline/proc/addMachineryMember(obj/machinery/atmospherics/components/C)
	other_atmosmch |= C
	var/list/returned_airs = C.returnPipenetAirs(src)
	if (!length(returned_airs) || (null in returned_airs))
		stack_trace("addMachineryMember: Nonexistent (empty list) or null machinery gasmix added to pipeline datum from [C] \
		which is of type [C.type]. QDELETED: [QDELETED(C) ? "true" : "false"].")
	other_airs |= returned_airs

/datum/pipeline/proc/addMember(obj/machinery/atmospherics/A, obj/machinery/atmospherics/N)
	if(istype(A, /obj/machinery/atmospherics/pipe))
		var/obj/machinery/atmospherics/pipe/P = A
		if(P.parent)
			merge(P.parent)
		P.parent = src
		var/list/adjacent = P.pipeline_expansion()
		for(var/obj/machinery/atmospherics/pipe/I in adjacent)
			if(I.parent == src)
				continue
			var/datum/pipeline/E = I.parent
			merge(E)
		if(!(P in members))
			members += P
			air.set_volume(air.return_volume() + P.volume)
	else
		A.setPipenet(src, N)
		addMachineryMember(A)

/datum/pipeline/proc/merge(datum/pipeline/E)
	if(E == src)
		return
	air.set_volume(air.return_volume() + E.air.return_volume())
	members.Add(E.members)
	for(var/obj/machinery/atmospherics/pipe/S in E.members)
		S.parent = src
	air.merge(E.air)
	for(var/obj/machinery/atmospherics/components/C in E.other_atmosmch)
		C.replacePipenet(E, src)
	other_atmosmch |= E.other_atmosmch
	other_airs |= E.other_airs
	E.members.Cut()
	E.other_atmosmch.Cut()
	update = TRUE
	qdel(E)

/obj/machinery/atmospherics/proc/addMember(obj/machinery/atmospherics/A)
	return

/obj/machinery/atmospherics/pipe/addMember(obj/machinery/atmospherics/A)
	parent.addMember(A, src)

/obj/machinery/atmospherics/components/addMember(obj/machinery/atmospherics/A)
	var/datum/pipeline/P = returnPipenet(A)
	if(!P)
		CRASH("null.addMember() called by [type] on [COORD(src)]")
	P.addMember(A, src)


/datum/pipeline/proc/temporarily_store_air()
	//Update individual gas_mixtures by volume ratio

	for(var/obj/machinery/atmospherics/pipe/member in members)
		member.air_temporary = new
		member.air_temporary.set_volume(member.volume)
		member.air_temporary.copy_from(air)

		member.air_temporary.multiply(member.volume/air.return_volume())

		member.air_temporary.set_temperature(air.return_temperature())

/datum/pipeline/proc/temperature_interact(turf/target, share_volume, thermal_conductivity)
	var/total_heat_capacity = air.heat_capacity()
	var/partial_heat_capacity = total_heat_capacity*(share_volume/air.return_volume())
	var/target_temperature
	var/target_heat_capacity

	if(isopenturf(target))

		var/turf/open/modeled_location = target
		target_temperature = modeled_location.GetTemperature()
		target_heat_capacity = modeled_location.GetHeatCapacity()

		if(modeled_location.blocks_air)

			if((modeled_location.heat_capacity>0) && (partial_heat_capacity>0))
				var/delta_temperature = air.return_temperature() - target_temperature

				var/heat = thermal_conductivity*delta_temperature* \
					(partial_heat_capacity*target_heat_capacity/(partial_heat_capacity+target_heat_capacity))

				air.set_temperature(air.return_temperature() - heat/total_heat_capacity)
				modeled_location.TakeTemperature(heat/target_heat_capacity)

		else
			var/delta_temperature = 0
			var/sharer_heat_capacity = 0

			delta_temperature = (air.return_temperature() - target_temperature)
			sharer_heat_capacity = target_heat_capacity

			var/self_temperature_delta = 0
			var/sharer_temperature_delta = 0

			if((sharer_heat_capacity>0) && (partial_heat_capacity>0))
				var/heat = thermal_conductivity*delta_temperature* \
					(partial_heat_capacity*sharer_heat_capacity/(partial_heat_capacity+sharer_heat_capacity))

				self_temperature_delta = -heat/total_heat_capacity
				sharer_temperature_delta = heat/sharer_heat_capacity
			else
				return 1

			air.set_temperature(air.return_temperature() + self_temperature_delta)
			modeled_location.TakeTemperature(sharer_temperature_delta)


	else
		if((target.heat_capacity>0) && (partial_heat_capacity>0))
			var/delta_temperature = air.return_temperature() - target.return_temperature()

			var/heat = thermal_conductivity*delta_temperature* \
				(partial_heat_capacity*target.heat_capacity/(partial_heat_capacity+target.heat_capacity))

			air.set_temperature(air.return_temperature() - heat/total_heat_capacity)
	update = TRUE

/datum/pipeline/proc/return_air()
	. = other_airs + air
	if(null in .)
		stack_trace("[src]([REF(src)]) has one or more null gas mixtures, which may cause bugs. Null mixtures will not be considered in reconcile_air().")
		return listclearnulls(.)

/datum/pipeline/proc/empty()
	for(var/datum/gas_mixture/GM in get_all_connected_airs())
		GM.clear()

/datum/pipeline/proc/get_all_connected_airs()
	var/list/datum/gas_mixture/GL = list()
	var/list/datum/pipeline/PL = list()
	PL += src

	for(var/i = 1; i <= PL.len; i++) //can't do a for-each here because we may add to the list within the loop
		var/datum/pipeline/P = PL[i]
		if(!P)
			continue
		GL += P.return_air()
		for(var/atmosmch in P.other_atmosmch)
			if (istype(atmosmch, /obj/machinery/atmospherics/components/binary/valve))
				var/obj/machinery/atmospherics/components/binary/valve/V = atmosmch
				if(V.on)
					PL |= V.parents[1]
					PL |= V.parents[2]
			else if (istype(atmosmch,/obj/machinery/atmospherics/components/binary/relief_valve))
				var/obj/machinery/atmospherics/components/binary/relief_valve/V = atmosmch
				if(V.opened)
					PL |= V.parents[1]
					PL |= V.parents[2]
			else if (istype(atmosmch, /obj/machinery/atmospherics/components/unary/portables_connector))
				var/obj/machinery/atmospherics/components/unary/portables_connector/C = atmosmch
				if(C.connected_device)
					GL += C.connected_device.return_air()
	return GL

/datum/pipeline/proc/reconcile_air()
	var/list/datum/gas_mixture/GL = get_all_connected_airs()
	equalize_all_gases_in_list(GL)
