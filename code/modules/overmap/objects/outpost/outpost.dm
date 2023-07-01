// DEBUG: make this a hackmd document for outpost creation
// specify skin X in code/__DEFINES/overmap.dm, make it's included in the list
// multiple outposts to a skin is allowed
// map datums should be in code/modules/overmap/objects/outpost/map_template/skin_X.dm
// map files themselves in _maps/outpost/outpost_X.dmm, _maps/outpost/elevators/elevator_X.dmm, _maps/outpost/hangars/hangar_X_YxZ.dmm

// hangars must have one and only one elevator shaft w/ landmark
// outpost map should be 121x121 exactly -- technically (QUADRANT_MAP_SIZE - 2 * QUADRANT_SIZE_BORDER)^2

// elevator landmark should be placed where bottom-left of elevator template should be placed, on hangars AND outposts. this is crucial to correct anchor alignment
// elevator template MUST contain an /obj/machinery/elevator_floor_button, on the same turf as a platform, to be functional
// elevator template MAY contain an /obj/machinery/status_display/elevator, on the same turf as a platform. this plays the sound effects

// elevator SHAFTS on outpost+hangar maps MUST have a /obj/machinery/elevator_floor_button, accessible from outside, to be functional -- marked with landmark?
// elevator SHAFTS on outpost+hangar maps MAY contain one or more /obj/machinery/door on the outside marked with door landmarks, with CORRECT var/shaft

// in elevator SHAFT, can place decals on tiles that elevator appears under? not sure. test

// if outpost has tcomms, docking messages will be posted. modularize? (what did i mean by modularize?)

// specify that landmarks mark TURFS, and from there get their contents, not mark objs directly

// specify that ships can add space_spawn to their JSON to spawn in space instead of at outposts. add an example to the example json. test that this works


// DEBUG: documentation
/datum/overmap/outpost
	name = "outpost"
	char_rep = "T"
	token_icon_state = "station"

	// The map template used for the outpost. If null, there will be no central area loaded.
	// Set to an instance of the singleton for its type in New.
	var/datum/map_template/outpost/main_template = null

	var/datum/map_template/outpost/elevator_template = null
	// DEBUG: document, move into test outposts?
	// some notes:
	// It is STRONGLY RECOMMENDED that templates are listed here in ascending order of size.
	// Hangar templates are found by iterating through the list and taking the first that is large enough;
	// if the list is not sorted, then docking ships may request hangars that are larger than necessary.
	// The dimension lists control the width and height (IN THAT ORDER) of the docking port that is instanced when
	// the hangar is loaded. The map should be built to handle a docking port of this size without undesired behavior.
	var/list/datum/map_template/outpost/hangar_templates = list(
		/datum/map_template/outpost/hangar_test_20x20 = list(20, 20),
		/datum/map_template/outpost/hangar_test_40x20 = list(40, 20),
		/datum/map_template/outpost/hangar_test_40x40 = list(40, 40),
		/datum/map_template/outpost/hangar_test_56x20 = list(56, 20),
		/datum/map_template/outpost/hangar_test_56x40 = list(56, 40)
	)
	// NOTE: "planetary" outposts should use baseturf specification and possibly different ztrait sun type, for both hangars and main level.
	var/list/mainlevel_ztraits = list(
		ZTRAIT_STATION = TRUE,
		ZTRAIT_SUN_TYPE = AZIMUTH
	)
	var/list/hangar_ztraits = list(
		ZTRAIT_SUN_TYPE = AZIMUTH
	)
	var/max_missions = 15

	/// The mapzone used by the outpost level and hangars. Using a single mapzone means networked radio messages.
	var/datum/map_zone/mapzone
	var/list/datum/hangar_shaft/shaft_datums = list()
	// A list keeping track of the docks that're currently being landed at. Helps to prevent SGTs,
	// as at time of writing there's no protection against a ship docking with a port that's already being docked to.
	var/list/landing_in_progress_docks = list() // TODO: generalize this approach to prevent simultaneous-dock ship-overlap SGTs

	/// List of missions that can be accepted at this outpost.
	var/list/datum/mission/missions

/datum/overmap/outpost/Initialize(position, ...)
	. = ..()
	// init our template vars with the correct singletons
	main_template = SSmapping.outpost_templates[main_template]
	elevator_template = SSmapping.outpost_templates[elevator_template]

	var/list/old_template_list = hangar_templates
	hangar_templates = list()
	for(var/h_template_type in old_template_list)
		var/h_template = SSmapping.outpost_templates[h_template_type]
		hangar_templates[h_template] = old_template_list[h_template_type]

	SSovermap.outposts += src
	mapzone = SSmapping.create_map_zone("[name]")

	if(main_template)
		load_main_level()
	else
		shaft_datums += new("A", null)

	// doing this after the main level is loaded means that the outpost areas are all renamed for us
	Rename(gen_outpost_name())

	fill_missions()
	addtimer(CALLBACK(src, .proc/fill_missions), 10 MINUTES, TIMER_STOPPABLE|TIMER_LOOP|TIMER_DELETE_ME)

// DEBUG: consider more detailed cleanup behavior. cleanup hangars (and their datums)? delete main level? lots of weird questions
/datum/overmap/outpost/Destroy(...)
	// cleanup our data structures
	for(var/list/datum/hangar_shaft/h_shaft as anything in shaft_datums)
		qdel(h_shaft)
		shaft_datums -= h_shaft

	SSovermap.outposts -= src

	. = ..()

/datum/overmap/outpost/get_jump_to_turf()
	if(main_template)
		// the main level is (hopefully) going to be the first in the mapzone's virtual levels
		var/datum/virtual_level/vlevel = mapzone.virtual_levels[1]
		return locate(round((vlevel.low_x + vlevel.high_x) / 2), round((vlevel.low_y + vlevel.high_y) / 2), vlevel.z_value)
	else
		var/datum/hangar_shaft/rand_shaft = pick(shaft_datums)
		if(!length(rand_shaft.hangar_docks))
			return null
		return get_turf(pick(rand_shaft.hangar_docks))

/datum/overmap/outpost/Rename(new_name, force)
	. = ..()
	if(!.)
		return
	var/list/hangar_vlevels = mapzone.virtual_levels
	mapzone.name = name

	if(main_template)
		var/datum/virtual_level/vlevel = mapzone.virtual_levels[1]
		hangar_vlevels -= vlevel

		vlevel.name = name
		for(var/area/outpost/outpost_area in SSmapping.areas_in_z["[vlevel.z_value]"])
			if(vlevel.is_in_bounds(outpost_area))
				outpost_area.name = "[name] [initial(outpost_area.name)]"

	for(var/datum/hangar_shaft/shaft in shaft_datums)
		for(var/i in 1 to shaft.hangar_docks.len)
			// assumes that order in shaft = order in hangar list
			var/hangar_name = "[name] Hangar [shaft.name]-[i]"
			var/obj/docking_port/stationary/h_dock = shaft.hangar_docks[i]
			h_dock.name = hangar_name
			for(var/datum/virtual_level/h_vlevel in hangar_vlevels)
				if(h_vlevel.is_in_bounds(h_dock))
					h_vlevel.name = hangar_name
					hangar_vlevels -= h_vlevel
					break

// Shamelessly cribbed from how Elite: Dangerous does station names.
/datum/overmap/outpost/proc/gen_outpost_name()
	var/person_name
	if(prob(40))
		// fun fact: "Hutton" is in last_names
		person_name = pick(GLOB.last_names)
	else
		switch(rand(1, 5))
			if(1)
				person_name = pick(GLOB.moth_last)
			if(2)
				person_name = pick(prob(50) ? GLOB.lizard_names_male : GLOB.lizard_names_female)
			if(3)
				person_name = pick(GLOB.spider_last)
			if(4)
				person_name = kepori_name()
			if(5)
				person_name = vox_name()

	return "[person_name] [pick(GLOB.station_suffixes)]"

/datum/overmap/outpost/proc/fill_missions()
	while(LAZYLEN(missions) < max_missions)
		var/mission_type = get_weighted_mission_type()
		var/datum/mission/M = new mission_type(src)
		LAZYADD(missions, M)

/datum/overmap/outpost/proc/load_main_level()
	if(!main_template)
		CRASH("[src] ([src.type]) tried to load without a template!")

	log_game("[src] [REF(src)] OUTPOST MAP LEVEL INIT")
	log_shuttle("[src] [REF(src)] OUTPOST MAP LEVEL INIT")

	var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(
		name,
		mainlevel_ztraits,
		mapzone,
		QUADRANT_MAP_SIZE,
		QUADRANT_MAP_SIZE,
		ALLOCATION_QUADRANT,
		QUADRANT_MAP_SIZE
	)
	vlevel.reserve_margin(QUADRANT_SIZE_BORDER)

	main_template.load(vlevel.get_unreserved_bottom_left_turf())

	// assoc list of lists of landmarks in a shaft, starting with the main landmark
	var/list/list/shaft_lists = list()
	for(var/obj/effect/landmark/outpost/elevator/ele_mark in GLOB.outpost_landmarks)
		if(!vlevel.is_in_bounds(ele_mark))
			continue
		if(!istext(ele_mark.shaft))
			stack_trace("Invalid shaft var [ele_mark.shaft] on [ele_mark] found when loading [main_template]!")
			qdel(ele_mark)
		else
			shaft_lists[ele_mark.shaft] = list(ele_mark)

	if(!shaft_lists.len)
		stack_trace("No elevator shafts found while loading [main_template]! The map will be inaccessible!")

	// now we get the machine landmarks (button, doors) and add them to the shaft list
	for(var/obj/effect/landmark/outpost/elevator_machine/mach_mark in GLOB.outpost_landmarks)
		if(!vlevel.is_in_bounds(mach_mark))
			continue
		if(!(mach_mark.shaft in shaft_lists))
			stack_trace("Invalid shaft var [mach_mark.shaft] on [mach_mark] found when loading [main_template]!")
			qdel(mach_mark)
		else
			shaft_lists[mach_mark.shaft] += mach_mark

	for(var/shaft_name in shaft_lists)
		var/list/obj/shaft_li = shaft_lists[shaft_name]
		var/obj/effect/landmark/outpost/elevator/anchor_landmark = shaft_li[1]
		var/obj/structure/elevator_platform/plat

		// load the template
		elevator_template.load(anchor_landmark.loc)
		plat = locate() in anchor_landmark.loc
		// create the shaft datum
		shaft_datums += new /datum/hangar_shaft(shaft_name, plat.master_datum)
		// give the elevator a first floor
		plat.master_datum.add_floor_landmarks(anchor_landmark, shaft_li - anchor_landmark)


/datum/overmap/outpost/pre_docked(datum/overmap/ship/controlled/dock_requester)
	var/obj/docking_port/stationary/h_dock
	var/datum/map_template/outpost/h_template = get_hangar_template(dock_requester.shuttle_port)
	// DEBUG: correctly propagate docking ticket errors upwards to inform user what the fuck is going on, instead of just returning false
	if(!h_template || !shaft_datums)
		return FALSE

	h_dock = ensure_hangar(h_template)

	if(!h_dock)
		stack_trace(
			"Outpost [src] ([src.type]) [REF(src)] unable to create hangar [h_template] " +\
			"for ship [dock_requester] (template [dock_requester.source_template])!"
		)
		return FALSE

	landing_in_progress_docks += h_dock
	adjust_dock_to_shuttle(h_dock, dock_requester.shuttle_port)
	return new /datum/docking_ticket(h_dock, src, dock_requester)

/datum/overmap/outpost/post_docked(datum/overmap/ship/controlled/dock_requester)
	// removes the stationary dock from the list, so that we don't have to worry about it causing merge SGTs
	landing_in_progress_docks -= dock_requester.shuttle_port.docked

	for(var/mob/M as anything in GLOB.player_list)
		if(dock_requester.shuttle_port.is_in_shuttle_bounds(M))
			M.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:center valign='top'><u>[name]</u></span><br>[station_time_timestamp_fancy("hh:mm")]")

	// Instance the virtual speaker for use in radio messages. It needs an atom to trace things back to; we use the token.
	// You might think "but wait, can't we just keep one speaker around instead of instancing it for each fucking radio message?"
	// You'd think so, but you can't. It gets deleted after sending the radio message. Because GOD FORBID you send a message over radio
	// without creating a fucking ATOM first to give it a rubber fucking stamp.
	var/atom/movable/virtualspeaker/v_speaker = new(null, token, null)
	var/datum/signal/subspace/vocal/signal = new(
		dock_requester.shuttle_port.docked,
		FREQ_COMMON, // frequency: Common
		v_speaker, // speaker: a weird dummy atom not used for much of import but which will cause runtimes if omitted or improperly initialized.
		/datum/language/common, // language: Common
		"[dock_requester.name] confirmed touchdown at [dock_requester.shuttle_port.docked].", // the message itself
		list(SPAN_ROBOT), // message font
		list(MODE_CUSTOM_SAY_EMOTE = "coldly states") // custom say verb
	)
	signal.send_to_receivers()

	return

/datum/overmap/outpost/proc/get_hangar_template(obj/docking_port/mobile/request_port)
	RETURN_TYPE(/datum/map_template/outpost)
	var/list/request_size = list(request_port.width, request_port.height)

	for(var/datum/map_template/outpost/hangar_template as anything in hangar_templates)
		var/list/hangar_size = hangar_templates[hangar_template]
		if( \
			(request_size[1] <= hangar_size[1] && request_size[2] <= hangar_size[2]) || \
			(request_size[1] <= hangar_size[2] && request_size[2] <= hangar_size[1]) \
		)
			return hangar_template
	return null // this is implicit, but i want to be clear that intended behavior here is to return null. it's not necessarily an error

/datum/overmap/outpost/proc/ensure_hangar(datum/map_template/outpost/h_template)
	RETURN_TYPE(/obj/docking_port/stationary)
	for(var/datum/hangar_shaft/h_shaft as anything in shaft_datums)
		for(var/obj/docking_port/stationary/h_dock as anything in h_shaft.hangar_docks)
			var/list/h_template_size = hangar_templates[h_template]
			// a dock/undock cycle may leave the stationary port w/ flipped width and height,
			// due to adjust_dock_to_shuttle(). so we need to check both orderings of the list.
			if( \
				!(h_dock in landing_in_progress_docks) && !h_dock.docked && \
				( \
					(h_dock.width == h_template_size[1] && h_dock.height == h_template_size[2]) || \
					(h_dock.height == h_template_size[1] && h_dock.width == h_template_size[2]) \
				) \
			)
				return h_dock

	// we didn't find a valid hangar, so we have to make one
	var/datum/hangar_shaft/chosen_shaft = pick(shaft_datums)

	return make_hangar(h_template, chosen_shaft)

/datum/overmap/outpost/proc/make_hangar(datum/map_template/outpost/h_template, datum/hangar_shaft/shaft)
	RETURN_TYPE(/obj/docking_port/stationary)

	if(!(h_template in hangar_templates))
		CRASH("[src] ([src.type]) was told to instance hangar [h_template], which is not in its hangar_templates list!")

	log_game("[src] ([src.type]) [REF(src)] OUTPOST HANGAR INIT")
	log_shuttle("[src] ([src.type]) [REF(src)] OUTPOST HANGAR INIT")

	var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(
		"[src.name] Loading Hangar", // we actually need to change this later; we can't number the hangar if we CHECK_TICK before we add the hangar to the list
		hangar_ztraits,
		mapzone,
		h_template.width+2,
		h_template.height+2,
		ALLOCATION_FREE
	)
	vlevel.reserve_margin(1)

	h_template.load(vlevel.get_unreserved_bottom_left_turf())

	var/turf/dock_turf
	for(var/obj/effect/landmark/outpost/hangar_dock/dock_mark in GLOB.outpost_landmarks)
		if(vlevel.is_in_bounds(dock_mark))
			dock_turf = dock_mark.loc
			qdel(dock_mark, TRUE)
			break
	if(!dock_turf)
		CRASH("[src] ([src.type]) could not find a hangar docking port landmark for its spawned hangar [h_template]!")

	var/obj/docking_port/stationary/h_dock = new(dock_turf)
	h_dock.dir = NORTH
	h_dock.width = hangar_templates[h_template][1]
	h_dock.height = hangar_templates[h_template][2]
	shaft.hangar_docks += h_dock

	// important not to CHECK_TICK after this point, so that the number is guaranteed to be correct
	var/hangar_num = length(shaft.hangar_docks)
	var/hangar_name = "[src.name] Hangar [shaft.name]-[hangar_num]"
	h_dock.name = hangar_name
	vlevel.name = hangar_name
	// hangar area has UNIQUE_AREA, so do not rename it (annoying)

	// now that we have the hangar num, we can add decals where necessary
	for(var/obj/effect/landmark/outpost/hangar_numbers/num_mark in GLOB.outpost_landmarks)
		if(!vlevel.is_in_bounds(num_mark))
			continue
		num_mark.write_number(hangar_num) // deletes the mark

	if(!shaft.shaft_elevator)
		// if there's no elevator in this shaft, then delete the landmarks
		for(var/obj/effect/landmark/outpost/mark as anything in GLOB.outpost_landmarks)
			if(vlevel.is_in_bounds(mark))
				qdel(mark)
	else
		var/obj/effect/landmark/outpost/elevator/anchor_mark
		var/list/obj/effect/landmark/outpost/elevator_machine/mach_marks = list()

		for(var/obj/effect/landmark/outpost/mark as anything in GLOB.outpost_landmarks)
			if(!vlevel.is_in_bounds(ele_mark))
				continue

			if(!anchor_mark && istype(mark, /obj/effect/landmark/outpost/elevator))
				anchor_mark = ele_mark
			else if(istype(mark, /obj/effect/landmark/outpost/elevator_machine))
				mach_marks += mach_mark

		shaft.shaft_elevator.add_floor_landmarks(anchor_mark, mach_marks)
	return h_dock

/// Rudimentary data structure used by outposts to sort their hangars.
/datum/hangar_shaft
	var/name

	var/datum/elevator_master/shaft_elevator
	var/list/obj/docking_port/stationary/hangar_docks = list()

/datum/hangar_shaft/New(_name, _elevator)
	if(_name)
		name = _name
	if(_elevator)
		shaft_elevator = _elevator
