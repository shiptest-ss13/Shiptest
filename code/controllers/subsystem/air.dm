SUBSYSTEM_DEF(air)
	name = "Atmospherics"
	init_order = INIT_ORDER_AIR
	priority = FIRE_PRIORITY_AIR
	wait = 5
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/cost_turfs = 0
	var/cost_groups = 0
	var/cost_highpressure = 0
	var/cost_hotspots = 0
	var/cost_post_process = 0
	var/cost_superconductivity = 0
	var/cost_pipenets = 0
	var/cost_rebuilds = 0
	var/cost_atmos_machinery = 0
	var/cost_atmos_machinery_air = 0
	var/cost_equalize = 0
	var/thread_wait_ticks = 0
	var/cur_thread_wait_ticks = 0

	var/low_pressure_turfs = 0
	var/high_pressure_turfs = 0

	var/num_group_turfs_processed = 0
	var/num_equalize_processed = 0

	var/list/hotspots = list()
	var/list/networks = list()
	var/list/rebuild_queue = list()
	//Subservient to rebuild queue
	var/list/expansion_queue = list()

	///List of all currently processing atmos machinery that doesn't interact with the air around it
	var/list/obj/machinery/atmos_machinery = list()
	///List of all currently processing atmos machinery that interacts with its loc's air
	var/list/obj/machinery/atmos_air_machinery = list()

	///Atmos machinery that will be added to atmos_machinery once maploading is finished
	var/list/obj/machinery/deferred_atmos_machinery = list()
	///Air atmos machinery that will be added to atmos_air_machinery once maploading is finished
	var/list/obj/machinery/deferred_atmos_air_machinery = list()

	var/list/pipe_init_dirs_cache = list()

	//atmos singletons
	var/list/gas_reactions = list()
	var/list/string_mixes

	//Special functions lists
	var/list/turf/open/high_pressure_delta = list()


	var/list/currentrun = list()
	var/currentpart = SSAIR_PIPENETS

	var/map_loading = TRUE

	var/planet_equalize_enabled = TRUE
	/// Max number of turfs equalization will grab.
	var/equalize_turf_limit = 30
	/// Max number of turfs to look for a space turf, and max number of turfs that will be decompressed.
	var/equalize_hard_turf_limit = 2000
	/// Whether equalization should be enabled at all.
	var/equalize_enabled = TRUE
	/// The ratio of gas "shared" from the immutable planetary atmos mix to planetary tiles
	var/planet_share_ratio = 0.25
	/// Whether turf-to-turf heat exchanging should be enabled.
	var/heat_enabled = FALSE
	/// Max number of times process_turfs will share in a tick.
	var/share_max_steps = 3
	/// Excited group processing will try to equalize groups with total pressure difference less than this amount.
	var/excited_group_pressure_goal = 1
	/// Whether the subsystem has finished the current run. If not, then the current run variable holds the data needed to continue the run.
	/// Replaces "resumed" in fire() due to needing to keep the background subsystem synched.
	var/incomplete = FALSE

//This exists to hoover up all the spare processing time in a tick for use in the air subsystem, if there is any.
BACKGROUND_SUBSYSTEM_DEF(air)
	name = "Atmospherics (Background)"

/datum/controller/subsystem/air/background/fire()
	//Don't begin a new run, let the main subsystem handle that to ensure we don't double-process machinery
	if(SSair.currentpart == SSAIR_ACTIVETURFS)
		return
	return ..()

/datum/controller/subsystem/air/stat_entry(msg)
	msg += "C:{"
	msg += "HP:[round(cost_highpressure,1)]|"
	msg += "HS:[round(cost_hotspots,1)]|"
	msg += "SC:[round(cost_superconductivity,1)]|"
	msg += "PN:[round(cost_pipenets,1)]|"
	msg += "AM:[round(cost_atmos_machinery,1)]|"
	msg += "AA:[round(cost_atmos_machinery_air,1)]"
	msg += "} "
	msg += "TC:{"
	msg += "AT:[round(cost_turfs,1)]|"
	msg += "EG:[round(cost_groups,1)]|"
	msg += "EQ:[round(cost_equalize,1)]|"
	msg += "PO:[round(cost_post_process,1)]"
	msg += "}"
	msg += "TH:[round(thread_wait_ticks,1)]|"
	msg += "HS:[length(SSair.hotspots)]|"
	msg += "PN:[length(SSair.networks)]|"
	msg += "HP:[length(SSair.high_pressure_delta)]|"
	msg += "HT:[SSair.high_pressure_turfs]|"
	msg += "LT:[SSair.low_pressure_turfs]|"
	msg += "ET:[SSair.num_equalize_processed]|"
	msg += "GT:[SSair.num_group_turfs_processed]|"
	msg += "GA:[SSair.get_amt_gas_mixes()]|"
	msg += "MG:[get_max_gas_mixes()]"
	return ..()

/datum/controller/subsystem/air/Initialize(timeofday)
	map_loading = FALSE
	setup_allturfs()
	setup_atmos_machinery()
	setup_pipenets()
	gas_reactions = init_gas_reactions()
	auxtools_update_reactions()
	return ..()

/proc/reset_all_air()
	SSair.can_fire = FALSE
	message_admins("Air reset begun.")
	for(var/turf/open/T in world)
		T.Initalize_Atmos(0)
		CHECK_TICK
	message_admins("Air reset done.")
	SSair.can_fire = TRUE

/datum/controller/subsystem/air/fire(resumed = 0)
	var/timer

	if(length(SSair.rebuild_queue) || length(SSair.expansion_queue))
		timer = TICK_USAGE_REAL
		MC_PAUSE_IF_TRUE(SSair.process_rebuilds())
		cost_rebuilds = MC_AVERAGE_SLOW(cost_rebuilds, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))
		if(state != SS_RUNNING)
			return

	if(SSair.currentpart == SSAIR_ACTIVETURFS)
		timer = TICK_USAGE_REAL
		MC_PAUSE_IF_TRUE(SSair.process_turfs_auxtools(MC_TICK_REMAINING_MS))
		cost_turfs = MC_AVERAGE(cost_turfs, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))
		if(state != SS_RUNNING)
			return

		SSair.currentpart = SSAIR_EXCITEDGROUPS

	if(SSair.currentpart == SSAIR_EXCITEDGROUPS)
		timer = TICK_USAGE_REAL
		MC_PAUSE_IF_TRUE(SSair.process_excited_groups_auxtools(MC_TICK_REMAINING_MS))
		cost_groups = MC_AVERAGE(cost_groups, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))
		if(state != SS_RUNNING)
			return
		SSair.currentpart = SSAIR_EQUALIZE

	if(SSair.currentpart == SSAIR_EQUALIZE)
		timer = TICK_USAGE_REAL
		MC_PAUSE_IF_TRUE(SSair.process_turf_equalize_auxtools(MC_TICK_REMAINING_MS))
		cost_equalize = MC_AVERAGE(cost_equalize, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))
		if(state != SS_RUNNING)
			return
		SSair.currentpart = SSAIR_FINALIZE_TURFS

	if(SSair.currentpart == SSAIR_FINALIZE_TURFS)
		if(SSair.finish_turf_processing_auxtools(MC_TICK_REMAINING_MS))
			pause()
			cur_thread_wait_ticks++
			return
		thread_wait_ticks = MC_AVERAGE(thread_wait_ticks, cur_thread_wait_ticks)
		cur_thread_wait_ticks = 0
		SSair.currentpart = SSAIR_PIPENETS

	if(SSair.currentpart == SSAIR_PIPENETS)
		timer = TICK_USAGE_REAL
		MC_PAUSE_IF_TRUE(SSair.process_pipenets())
		cost_pipenets = MC_AVERAGE(cost_pipenets, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))
		if(state != SS_RUNNING)
			return
		SSair.currentpart = SSAIR_ATMOSMACHINERY

	// This is only machinery like filters, mixers that don't interact with air
	if(SSair.currentpart == SSAIR_ATMOSMACHINERY)
		timer = TICK_USAGE_REAL
		MC_PAUSE_IF_TRUE(SSair.process_atmos_machinery())
		cost_atmos_machinery = MC_AVERAGE(cost_atmos_machinery, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))
		if(state != SS_RUNNING)
			return
		SSair.currentpart = SSAIR_HIGHPRESSURE

	if(SSair.currentpart == SSAIR_HIGHPRESSURE)
		timer = TICK_USAGE_REAL
		MC_PAUSE_IF_TRUE(SSair.process_high_pressure_delta())
		cost_highpressure = MC_AVERAGE(cost_highpressure, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))
		if(state != SS_RUNNING)
			return
		SSair.currentpart = SSAIR_ATMOSMACHINERY_AIR

	if(SSair.currentpart == SSAIR_ATMOSMACHINERY_AIR)
		timer = TICK_USAGE_REAL
		MC_PAUSE_IF_TRUE(SSair.process_atmos_air_machinery())
		cost_atmos_machinery_air = MC_AVERAGE(cost_atmos_machinery_air, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))
		if(state != SS_RUNNING)
			return
		SSair.currentpart = SSAIR_HOTSPOTS

	if(SSair.currentpart == SSAIR_HOTSPOTS)
		timer = TICK_USAGE_REAL
		MC_PAUSE_IF_TRUE(SSair.process_hotspots())
		cost_hotspots = MC_AVERAGE(cost_hotspots, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))
		if(state != SS_RUNNING)
			return
		SSair.currentpart = heat_enabled ? SSAIR_TURF_CONDUCTION : SSAIR_ACTIVETURFS

	// Heat -- slow and of questionable usefulness. Off by default for this reason. Pretty cool, though.
	if(SSair.currentpart == SSAIR_TURF_CONDUCTION)
		timer = TICK_USAGE_REAL
		MC_PAUSE_IF_TRUE(process_turf_heat(MC_TICK_REMAINING_MS))
		cost_superconductivity = MC_AVERAGE(cost_superconductivity, TICK_DELTA_TO_MS(TICK_USAGE_REAL - timer))
		if(state != SS_RUNNING)
			return
		SSair.currentpart = SSAIR_ACTIVETURFS

/datum/controller/subsystem/air/Recover()
	hotspots = SSair.hotspots
	networks = SSair.networks
	rebuild_queue = SSair.rebuild_queue
	expansion_queue = SSair.expansion_queue
	atmos_machinery = SSair.atmos_machinery
	atmos_air_machinery = SSair.atmos_air_machinery
	pipe_init_dirs_cache = SSair.pipe_init_dirs_cache
	gas_reactions = SSair.gas_reactions
	high_pressure_delta = SSair.high_pressure_delta
	currentrun = SSair.currentrun
	incomplete = SSair.incomplete
	string_mixes = SSair.string_mixes

/**
 * Adds a given machine to the processing system for SSAIR_ATMOSMACHINERY processing.
 *
 * Arguments:
 * * machine - The machine to start processing. Can be any /obj/machinery.
 */
/datum/controller/subsystem/air/proc/start_processing_machine(obj/machinery/machine, mapload)
	if(machine.atmos_processing)
		return
	machine.atmos_processing = TRUE
	if(machine.interacts_with_air)
		if(mapload)
			deferred_atmos_air_machinery += machine
		else
			atmos_air_machinery += machine
	else
		if(mapload)
			deferred_atmos_machinery += machine
		else
			atmos_machinery += machine

/**
 * Removes a given machine to the processing system for SSAIR_ATMOSMACHINERY processing.
 *
 * Arguments:
 * * machine - The machine to stop processing.
 */
/datum/controller/subsystem/air/proc/stop_processing_machine(obj/machinery/machine)
	if(!machine.atmos_processing)
		return
	machine.atmos_processing = FALSE
	if(machine.interacts_with_air)
		atmos_air_machinery -= machine
		deferred_atmos_air_machinery -= machine
	else
		atmos_machinery -= machine
		deferred_atmos_machinery -= machine

	// If we're currently processing atmos machines, there's a chance this machine is in
	// the currentrun list, which is a cache of atmos_machinery. Remove it from that list
	// as well to prevent processing qdeleted objects in the cache.
	if(currentpart == SSAIR_ATMOSMACHINERY)
		currentrun -= machine
	if(machine.interacts_with_air && currentpart == SSAIR_ATMOSMACHINERY_AIR)
		currentrun -= machine


/datum/controller/subsystem/air/proc/process_pipenets()
	if (!incomplete)
		src.currentrun = networks.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	while(currentrun.len)
		var/datum/thing = currentrun[currentrun.len]
		currentrun.len--
		if(thing)
			thing.process()
		else
			networks.Remove(thing)
		if(TICK_CHECK)
			incomplete = TRUE
			return TRUE

/datum/controller/subsystem/air/proc/add_to_rebuild_queue(obj/machinery/atmospherics/atmos_machine)
	if(istype(atmos_machine, /obj/machinery/atmospherics) && !atmos_machine.rebuilding)
		rebuild_queue += atmos_machine
		atmos_machine.rebuilding = TRUE

/datum/controller/subsystem/air/proc/add_to_expansion(datum/pipeline/line, starting_point)
	var/list/new_packet = new(SSAIR_REBUILD_QUEUE)
	new_packet[SSAIR_REBUILD_PIPELINE] = line
	new_packet[SSAIR_REBUILD_QUEUE] = list(starting_point)
	expansion_queue += list(new_packet)

/datum/controller/subsystem/air/proc/remove_from_expansion(datum/pipeline/line)
	for(var/list/packet in expansion_queue)
		if(packet[SSAIR_REBUILD_PIPELINE] == line)
			expansion_queue -= packet
			return


/datum/controller/subsystem/air/proc/process_rebuilds()
	//Yes this does mean rebuilding pipenets can freeze up the subsystem forever, but if we're in that situation something else is very wrong
	var/list/currentrun = rebuild_queue
	while(currentrun.len || length(expansion_queue))
		while(currentrun.len && !length(expansion_queue)) //If we found anything, process that first
			var/obj/machinery/atmospherics/remake = currentrun[currentrun.len]
			currentrun.len--
			if (!remake)
				continue
			remake.rebuild_pipes()
			if (TICK_CHECK)
				return TRUE

		var/list/queue = expansion_queue
		while(queue.len)
			var/list/pack = queue[queue.len]
			//We operate directly with the pipeline like this because we can trust any rebuilds to remake it properly
			var/datum/pipeline/linepipe = pack[SSAIR_REBUILD_PIPELINE]
			var/list/border = pack[SSAIR_REBUILD_QUEUE]
			if(expand_pipeline(linepipe, border)) //expand_pipeline can fail a tick check, we shouldn't let things get too fucky here
				return

			linepipe.building = FALSE
			queue.len--
			if (TICK_CHECK)
				return TRUE

///Rebuilds a pipeline by expanding outwards, while yielding when sane
/datum/controller/subsystem/air/proc/expand_pipeline(datum/pipeline/net, list/border)
	while(border.len)
		var/obj/machinery/atmospherics/borderline = border[border.len]
		border.len--

		var/list/result = borderline.pipeline_expansion(net)
		if(!length(result))
			continue
		for(var/obj/machinery/atmospherics/considered_device in result)
			if(!istype(considered_device, /obj/machinery/atmospherics/pipe))
				considered_device.setPipenet(net, borderline)
				net.addMachineryMember(considered_device)
				continue
			var/obj/machinery/atmospherics/pipe/item = considered_device
			if(item.parent == net)
				continue
			if(item.parent)
				border += item.parent.members
				net.merge(item.parent)
				continue

			net.members += item
			border += item

			net.air.set_volume(net.air.return_volume() + item.volume)
			item.parent = net

			if(item.air_temporary)
				net.air.merge(item.air_temporary)
				item.air_temporary = null

		if (TICK_CHECK)
			return TRUE

/datum/controller/subsystem/air/proc/process_atmos_machinery()
	var/seconds = wait * 0.1
	if (!incomplete)
		src.currentrun = atmos_machinery.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	while(length(currentrun))
		var/obj/machinery/M = currentrun[length(currentrun)]
		currentrun.len--
		if(!M)
			atmos_machinery -= M
		if(M.process_atmos(seconds) == PROCESS_KILL)
			stop_processing_machine(M)
		if(TICK_CHECK)
			incomplete = TRUE
			return TRUE

/datum/controller/subsystem/air/proc/process_atmos_air_machinery()
	var/seconds = wait * 0.1
	if (!incomplete)
		src.currentrun = atmos_air_machinery.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	while(currentrun.len)
		var/obj/machinery/M = currentrun[currentrun.len]
		currentrun.len--
		if(!M)
			atmos_air_machinery -= M
		if(M.process_atmos(seconds) == PROCESS_KILL)
			stop_processing_machine(M)
		if(TICK_CHECK)
			incomplete = TRUE
			return TRUE

/datum/controller/subsystem/air/proc/process_turf_heat()

/datum/controller/subsystem/air/proc/process_hotspots()
	if (!incomplete)
		src.currentrun = hotspots.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	while(currentrun.len)
		var/obj/effect/hotspot/H = currentrun[currentrun.len]
		currentrun.len--
		if (H)
			H.process()
		else
			hotspots -= H
		if(TICK_CHECK)
			incomplete = TRUE
			return TRUE


/datum/controller/subsystem/air/proc/process_high_pressure_delta(resumed = 0)
	while (high_pressure_delta.len)
		var/turf/open/T = high_pressure_delta[high_pressure_delta.len]
		high_pressure_delta.len--
		if(istype(T))
			T.high_pressure_movements()
			T.pressure_difference = 0
			T.pressure_direction = 0
			T.pressure_specific_target = null
		if(TICK_CHECK)
			return TRUE

/datum/controller/subsystem/air/StartLoadingMap()
	map_loading = TRUE

/datum/controller/subsystem/air/StopLoadingMap()
	map_loading = FALSE

	if(length(deferred_atmos_machinery))
		atmos_machinery += deferred_atmos_machinery
		deferred_atmos_machinery.Cut()

	if(length(deferred_atmos_air_machinery))
		atmos_air_machinery += deferred_atmos_air_machinery
		deferred_atmos_air_machinery.Cut()

/datum/controller/subsystem/air/proc/setup_allturfs()
	var/list/turfs_to_init = block(locate(1, 1, 1), locate(world.maxx, world.maxy, world.maxz))
	var/times_fired = ++src.times_fired

	// Clear active turfs - faster than removing every single turf in the world
	// one-by-one, and Initalize_Atmos only ever adds `src` back in.

	for(var/thing in turfs_to_init)
		var/turf/T = thing
		if (T.blocks_air)
			continue
		T.Initalize_Atmos(times_fired)
		CHECK_TICK

/datum/controller/subsystem/air/proc/setup_atmos_machinery()
	for (var/obj/machinery/atmospherics/AM in atmos_machinery + atmos_air_machinery)
		AM.atmosinit()
		CHECK_TICK

//this can't be done with setup_atmos_machinery() because
//all atmos machinery has to initalize before the first
//pipenet can be built.
/datum/controller/subsystem/air/proc/setup_pipenets()
	for (var/obj/machinery/atmospherics/AM in atmos_machinery)
		var/list/targets = AM.get_rebuild_targets()
		for(var/datum/pipeline/build_off as anything in targets)
			build_off.build_pipeline_blocking(AM)
		CHECK_TICK

/datum/controller/subsystem/air/proc/setup_template_machinery(list/atmos_machines)
	if(!initialized)
		return
	for(var/A in atmos_machines)
		var/obj/machinery/atmospherics/AM = A
		AM.atmosinit()
		CHECK_TICK

	for(var/A in atmos_machines)
		var/obj/machinery/atmospherics/AM = A
		var/list/targets = AM.get_rebuild_targets()
		for(var/datum/pipeline/build_off as anything in targets)
			build_off.build_pipeline_blocking(AM)
		CHECK_TICK

/datum/controller/subsystem/air/proc/get_init_dirs(type, dir)
	if(!pipe_init_dirs_cache[type])
		pipe_init_dirs_cache[type] = list()

	if(!pipe_init_dirs_cache[type]["[dir]"])
		var/obj/machinery/atmospherics/temp = new type(null, FALSE, dir)
		pipe_init_dirs_cache[type]["[dir]"] = temp.GetInitDirections()
		qdel(temp)

	return pipe_init_dirs_cache[type]["[dir]"]

/datum/controller/subsystem/air/proc/preprocess_gas_string(gas_string)
	if(!string_mixes)
		generate_atmos()
	if(!string_mixes[gas_string])
		return gas_string
	var/datum/atmosphere/mix = string_mixes[gas_string]
	return mix.gas_string

/datum/controller/subsystem/air/proc/generate_atmos()
	string_mixes = list()
	for(var/T in subtypesof(/datum/atmosphere))
		var/datum/atmosphere/atmostype = T
		string_mixes[initial(atmostype.id)] = new atmostype


#undef SSAIR_EXCITEDGROUPS
#undef SSAIR_HIGHPRESSURE
#undef SSAIR_HOTSPOTS
#undef SSAIR_TURF_CONDUCTION
#undef SSAIR_EQUALIZE
#undef SSAIR_ACTIVETURFS
#undef SSAIR_TURF_POST_PROCESS
#undef SSAIR_FINALIZE_TURFS
