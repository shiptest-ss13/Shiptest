
/datum/overmap/outpost
	name = "outpost"
	char_rep = "T"
	token_icon_state = "station"

	var/datum/map_zone/drydock
	var/obj/docking_port/stationary/dock_port

	/// List of missions that can be accepted at this outpost.
	var/list/datum/mission/missions
	var/max_missions = 10

	var/list/datum/mission/mission_types = list(
		/datum/mission/research,
		/datum/mission/acquire/goliath
	)

/datum/overmap/outpost/Initialize(...)
	. = ..()
	Rename(gen_outpost_name())
	fill_missions()

/datum/overmap/outpost/Destroy()
	if(dock_port)
		qdel(dock_port, TRUE)
		dock_port = null
	if(drydock)
		drydock.clear_reservation()
		QDEL_NULL(drydock)
	return ..()

/datum/overmap/outpost/get_jump_to_turf()
	if(dock_port)
		return get_turf(dock_port)
	return null

/datum/overmap/outpost/proc/gen_outpost_name()
	return "outpost"

/datum/overmap/outpost/proc/fill_missions()
	while(LAZYLEN(missions) < max_missions)
		var/datum/mission/M = gen_mission()
		LAZYADD(missions, M)
		M.source_outpost = src

/datum/overmap/outpost/proc/gen_mission()
	var/mission_type = pick(mission_types)
	return new mission_type()

/datum/overmap/outpost/pre_docked(datum/overmap/ship/controlled/dock_requester)
	if(!drydock)
		var/list/load_results = load_drydock()
		drydock = load_results[1]
		dock_port = load_results[2]
		if(!drydock)
			return FALSE

	adjust_dock_to_shuttle(dock_port, dock_requester.shuttle_port)
	return new /datum/docking_ticket(dock_port, src, dock_requester)

/datum/overmap/outpost/post_docked(datum/overmap/ship/controlled/dock_requester)
	for(var/mob/M as anything in GLOB.player_list)
		if(dock_requester.shuttle_port.is_in_shuttle_bounds(M))
			M.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:center valign='top'><u>[name]</u></span><br>[station_time_timestamp_fancy("hh:mm")]")
	return

// keep it around, it's not too big
/datum/overmap/outpost/post_undocked(datum/overmap/dock_requester)
	return

/datum/overmap/outpost/proc/load_drydock()
	var/zone_name = "Outpost Drydock"

	var/datum/map_zone/mapzone = SSmapping.create_map_zone(zone_name)
	var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(zone_name, list(), mapzone, 66, 66)
	vlevel.reserve_margin(QUADRANT_SIZE_BORDER)

	var/obj/docking_port/stationary/dock = new(vlevel.get_unreserved_bottom_left_turf())
	dock.dir = NORTH
	dock.name = "\improper [zone_name]"
	dock.height = vlevel.y_distance - (2*vlevel.reserved_margin)
	dock.width = vlevel.x_distance - (2*vlevel.reserved_margin)
	dock.dheight = 0
	dock.dwidth = 0

	return list(mapzone, dock)
