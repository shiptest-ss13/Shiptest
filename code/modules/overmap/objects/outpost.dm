/datum/overmap/outpost
	name = "outpost"
	char_rep = "T"
	token_icon_state = "station"

	var/datum/map_zone/mapzone
	var/list/obj/docking_port/stationary/reserve_docks

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
	if(!load_drydock())
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
/datum/overmap/outpost/proc/load_drydock()
	if(mapzone)
		return TRUE
	log_shuttle("[src] [REF(src)] OUTPOST LEVEL_INIT")
	var/list/dynamic_encounter_values = SSovermap.spawn_dynamic_encounter(null, FALSE, null)
	if(!length(dynamic_encounter_values))
		return FALSE
	mapzone = dynamic_encounter_values[1]
	reserve_docks = dynamic_encounter_values[2]
	return TRUE

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
