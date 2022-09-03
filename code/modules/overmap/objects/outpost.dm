/datum/overmap/outpost
	name = "outpost"
	char_rep = "T"
	token_icon_state = "station"

	/// Controls whether the outpost has a central + persistent area connected by elevators in hangars that crews can meet up in.
	var/has_phys_level = TRUE
	var/



	var/datum/map_zone/mapzone
	var/list/obj/docking_port/stationary/reserve_docks = list()

	/// List of missions that can be accepted at this outpost.
	var/list/datum/mission/missions
	var/max_missions = 15

/datum/overmap/outpost/Initialize(...)
	. = ..()
	Rename(gen_outpost_name())
	fill_missions()
	addtimer(CALLBACK(src, .proc/fill_missions), 10 MINUTES, TIMER_STOPPABLE|TIMER_LOOP|TIMER_DELETE_ME)

/datum/overmap/outpost/Destroy()
	for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
		reserve_docks -= dock
		qdel(dock, TRUE)
	if(mapzone)
		mapzone.clear_reservation()
		QDEL_NULL(mapzone)
	return ..()

/datum/overmap/dynamic/get_jump_to_turf()
	if(reserve_docks)
		return get_turf(pick(reserve_docks))

/datum/overmap/outpost/pre_docked(datum/overmap/ship/controlled/dock_requester)
	if(!load_drydock(dock_requester.shuttle_port))
		return FALSE
	var/dock_to_use = null
	for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
		if(!dock.get_docked())
			dock_to_use = dock
			break

	if(!dock_to_use)
		return FALSE
	adjust_dock_to_shuttle(dock_to_use, dock_requester.shuttle_port)
	return new /datum/docking_ticket(dock_to_use, src, dock_requester)

/datum/overmap/outpost/post_docked(datum/overmap/ship/controlled/dock_requester)
	for(var/mob/M as anything in GLOB.player_list)
		if(dock_requester.shuttle_port.is_in_shuttle_bounds(M))
			M.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:center valign='top'><u>[name]</u></span><br>[station_time_timestamp_fancy("hh:mm")]")
	return

// this should be reworked sometime
/datum/overmap/outpost/proc/load_drydock(obj/docking_port/mobile/request_port)
	if(mapzone)
		return TRUE
	log_shuttle("[src] [REF(src)] OUTPOST LEVEL_INIT")
	// var/list/dynamic_encounter_values = SSovermap.spawn_dynamic_encounter(null, FALSE, null)
	var/list/dynamic_encounter_values = make_hangar(request_port)
	if(!length(dynamic_encounter_values))
		return FALSE
	mapzone = dynamic_encounter_values[1]
	reserve_docks += dynamic_encounter_values[2]
	return TRUE

/datum/overmap/outpost/proc/make_hangar(obj/docking_port/mobile/request_port)
	// DEBUG: move this up to /datum/overmap/outpost
	var/hangar_skin = "test"

	var/r_width = CEILING(request_port.width, 20)
	var/r_height = CEILING(request_port.height, 20)
	// pack the port bounds in descending order
	var/list/round_size = r_width > r_height ? list(r_width, r_height) : list(r_height, r_width)

	// caps the dimensions according to the reserve dock defines. each dimension rolls the nearest multiple of 20 into itself
	// so if the max long size is, say, 89, then the possible dock sizes go (20, 40, 60, 89), omitting the 80
	// this helps keep the # of hangar maps reasonable
	round_size[1] = round_size[1] < round(RESERVE_DOCK_MAX_SIZE_LONG, 20) ? round_size[1] : RESERVE_DOCK_MAX_SIZE_LONG
	round_size[2] = round_size[2] < round(RESERVE_DOCK_MAX_SIZE_SHORT, 20) ? round_size[2] : RESERVE_DOCK_MAX_SIZE_SHORT

	var/map_string = "hangar_[hangar_skin]_[round_size[1]]x[round_size[2]]"
	var/datum/map_template/hangar/hangar_template = SSmapping.hangar_templates[map_string]
	if(!hangar_template)
		CRASH("[src] ([src.type]) could not find the hangar [map_string] for [request_port]!")

	var/encounter_name = "Dynamic Overmap Encounter" // DEBUG: make this more descriptive?
	var/datum/map_zone/mapzone = SSmapping.create_map_zone(encounter_name)
	// DEBUG: decide on the ZTRAIT to use; consider teleportation exploits
	var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(encounter_name, list(ZTRAIT_STATION = TRUE), mapzone, hangar_template.width+2, hangar_template.height+2)
	vlevel.reserve_margin(1)

	hangar_template.load(vlevel.get_unreserved_bottom_left_turf())
	var/turf/dock_turf
	for(var/obj/dock_mark as anything in GLOB.hangar_dock_landmarks)
		if(vlevel.is_in_bounds(dock_mark))
			dock_turf = dock_mark.loc
			qdel(dock_mark, TRUE)
			break
	if(!dock_turf)
		CRASH("[src] ([src.type]) could not find a hangar docking port landmark for its spawned hangar [map_string]!")

	var/obj/docking_port/stationary/hangar_dock = new(dock_turf)
	hangar_dock.dir = NORTH
	hangar_dock.name = "\improper [src.name] Hangar #Whatever" // DEBUG: make this more informative
	hangar_dock.height = round_size[2] // hangar ports are wider than they are tall
	hangar_dock.width = round_size[1]
	return list(mapzone, hangar_dock)

// DEBUG: move out of here, maybe?
GLOBAL_LIST_EMPTY(hangar_dock_landmarks)
GLOBAL_LIST_EMPTY(hangar_elevator_landmarks)

/obj/effect/landmark/hangar_dock
	name = "hangar docking port landmark"

/obj/effect/landmark/hangar_dock/New(...)
	GLOB.hangar_dock_landmarks += src
	. = ..()

/obj/effect/landmark/hangar_dock/Destroy(...)
	GLOB.hangar_dock_landmarks -= src
	. = ..()

/obj/effect/landmark/hangar_elevator
	name = "hangar elevator landmark"

/obj/effect/landmark/hangar_elevator/New(...)
	GLOB.hangar_elevator_landmarks += src
	. = ..()

/obj/effect/landmark/hangar_elevator/Destroy(...)
	GLOB.hangar_elevator_landmarks -= src
	. = ..()

// DEBUG: move these out too
/datum/map_template/hangar
	var/skin
	var/port_width
	var/port_height

/datum/map_template/hangar/New()
	var/new_name = "hangar_[skin]_[port_width]x[port_height]"
	. = ..(path = "_maps/hangars/[new_name].dmm", rename = new_name)

/datum/map_template/hangar/test_40x20
	skin = "test"
	port_width = 40
	port_height = 20

// DEBUG: make this better. add a dedicated area sprite for mappers?
/area/hangar
	area_flags = UNIQUE_AREA | NOTELEPORT
	sound_environment = SOUND_ENVIRONMENT_HANGAR // convenient! // DEBUG: causes audio pop when transitioning off-ship. fuck me
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	has_gravity = STANDARD_GRAVITY

	requires_power = FALSE
	power_equip = FALSE // nice try, but you can't power your machines just by placing them outside the ship // DEBUG: does this break doors?
	power_light = TRUE
	power_environ = TRUE

// Shamelessly cribbed from how Elite: Dangerous does station names.
/datum/overmap/outpost/proc/gen_outpost_name()
	var/person_name
	if(prob(40))
		person_name = pick(GLOB.last_names)
	else
		switch(rand(1, 4))
			if(1)
				person_name = pick(GLOB.moth_last)
			if(2)
				person_name = pick(prob(50) ? GLOB.lizard_names_male : GLOB.lizard_names_female)
			if(3)
				person_name = pick(GLOB.spider_last)
			if(4)
				person_name = kepori_name()

	return "[person_name] [pick(GLOB.station_suffixes)]"

/datum/overmap/outpost/proc/fill_missions()
	while(LAZYLEN(missions) < max_missions)
		var/mission_type = get_weighted_mission_type()
		var/datum/mission/M = new mission_type(src)
		LAZYADD(missions, M)
