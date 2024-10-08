/**
 * # Jump points
 *
 * These overmap objects can be interacted with and will send you to another sector.
 * These will then dump you onto another jump point post jump. Useful for events!s
 */
/datum/overmap/jump_point
	name = "jump point"
	char_rep = "~"
	token_icon_state = "jump_point"


	///if you dont want ships docking where they please, remove INTERACTION_OVERMAP_DOCK and leave the quick dock feature
	interaction_options = null

	///The currently linked jump point
	var/datum/overmap/jump_point/destination

/datum/overmap/jump_point/Initialize(position, _other_wormhole, ...)
	. = ..()
	alter_token_appearance()

/datum/overmap/jump_point/alter_token_appearance()
	..()
	if(current_overmap.override_object_colors)
		token.color = secondary_structure_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/wormhole/proc/handle_jump(datum/overmap/ship/controlled/jumper)
	if(!destination)
		qdel(src)
		return

	jumper.move_overmaps(destination.current_system, destination.x, destination.y)
	jumper.overmap_step(S.get_heading())

/datum/overmap/static_object/Destroy()
	for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
		reserve_docks -= dock
		qdel(dock, TRUE)
	. = ..()
	//This NEEDS to be last so any docked ships get deleted properly
	if(mapzone)
		mapzone.clear_reservation()
		QDEL_NULL(mapzone)

/datum/overmap/static_object/get_jump_to_turf()
	if(reserve_docks && reserve_docks.len)
		return get_turf(pick(reserve_docks))
	if(mapzone)
		var/datum/virtual_level/vlevel = pick(mapzone.virtual_levels)
		var/turf/goto_turf = locate(vlevel.low_x,vlevel.low_y,vlevel.z_value)
		return goto_turf

/datum/overmap/static_object/pre_docked(datum/overmap/ship/controlled/dock_requester, override_dock)
	if(loading)
		return new /datum/docking_ticket(_docking_error = "[src] is currently being scanned for suitable docking locations by another ship. Please wait.")
	if(!load_level())
		return new /datum/docking_ticket(_docking_error = "[src] cannot be docked to.")
	else
		var/dock_to_use = override_dock
		if(!override_dock)
			for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
				if(!dock.docked)
					dock_to_use = dock
					break

		if(!dock_to_use)
			return new /datum/docking_ticket(_docking_error = "[src] does not have any free docks. Aborting docking.")
		return new /datum/docking_ticket(dock_to_use, src, dock_requester)

/datum/overmap/static_object/get_dockable_locations(datum/overmap/requesting_interactor)
	var/list/docks = list()
	for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
		if(!dock.docked && !dock.current_docking_ticket)
			LAZYADD(docks, dock)
	return docks

/datum/overmap/static_object/post_docked(datum/overmap/ship/controlled/dock_requester)
	if(planet_name)
		for(var/mob/Mob as anything in GLOB.player_list)
			if(dock_requester.shuttle_port.is_in_shuttle_bounds(Mob))
				Mob.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:center valign='top'><u>[planet_name]</u></span><br>[station_time_timestamp("hh:mm")]")
				playsound(Mob, landing_sound, 50)


/datum/overmap/static_object/post_undocked(datum/overmap/dock_requester)
	if(preserve_level)
		return

	if(length(mapzone?.get_mind_mobs()))
		return //Dont fuck over stranded people? tbh this shouldn't be called on this condition, instead of bandaiding it inside
	log_shuttle("[src] [REF(src)] UNLOAD")

	for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
		reserve_docks -= dock
		qdel(dock, TRUE)
	reserve_docks = null
	if(mapzone)
		mapzone.clear_reservation()
		QDEL_NULL(mapzone)
	qdel(src)

/datum/overmap/dynastatic_objectic/alter_token_appearance()
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/static_object/proc/load_level()
	if(SSlag_switch.measures[DISABLE_PLANETGEN] && !(HAS_TRAIT(usr, TRAIT_BYPASS_MEASURES)))
		return FALSE
	if(mapzone)
		return TRUE

	loading = TRUE
	log_shuttle("[src] [REF(src)] LEVEL_INIT")

	// use the ruin type in template if it exists, or pick from ruin list if IT exists; otherwise null
	var/list/static_encounter_values = current_overmap.spawn_static_encounter(src, map_to_load)
	if(!length(static_encounter_values))
		return FALSE

	mapzone = static_encounter_values[1]
	reserve_docks = static_encounter_values[2]

	loading = FALSE
	return TRUE

/datum/overmap/static_object/admin_loaded
	name = "floating admin bus"
	desc = "Uh oh! Looks like an admin hasn't finished setting up yet! Better not dock until this description disapears!"
	token_icon_state = "bus"
	preserve_level = TRUE
	gravity = TRUE


/datum/overmap/static_object/testmap
	name = "test"
	desc = "TESTMAP"
	token_icon_state = "zeta"
	preserve_level = TRUE
	map_to_load = /datum/map_template/test_punchcard

/datum/map_template/test_punchcard
	name = "test_punchcard"
	mappath = 'punchcard_test_map.dmm'
