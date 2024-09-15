/**
 * # Static Overmap Encounters
 *
 * These overmap objects can be docked with and will load a premapped "planet". Think of these like gateways.
 * When undocked with, it checks if there's anyone left on the planet, and if not, will delete themseles.
 */
/datum/overmap/static_object
	name = "energy signature"
	char_rep = "!"


	///if you dont want ships docking where they please, remove INTERACTION_OVERMAP_DOCK and leave the quick dock feature
	interaction_options = list(INTERACTION_OVERMAP_DOCK, INTERACTION_OVERMAP_QUICKDOCK)

	///The active turf reservation, if there is one
	var/datum/map_zone/mapzone
	///The border size to use. It's reccomended to set this to 0 if you  use up the entirety of the allocated space (eg. 255x255 map where theres no bordering map levels)
	var/border_size = QUADRANT_SIZE_BORDER
	///The preset map to load
	var/datum/map_template/map_to_load
	///The docking port in the reserve
	var/list/obj/docking_port/stationary/reserve_docks
	///If the level should be preserved. Useful for if you want to build a colony or something.
	var/preserve_level = FALSE
	///If we set this, we ditch the baseturfs to generate a planet first, the overlay the map on top of the planetgen. not reccomnended, but you have the option to
	var/datum/planet_type/mapgen
	///Object's flavor name, given on landing.
	var/planet_name
	/// Whether or not the level is currently loading.
	var/loading = FALSE

	/// The turf used as the backup baseturf for any reservations created by this datum. Should not be null.
	var/turf/default_baseturf = /turf/open/space

	///The default gravity the virtual z will have
	var/gravity = 0

	///The weather the virtual z will have. If null, the planet will have no weather.
	var/datum/weather_controller/weather_controller_type

	///If true, we will load a new z level instead of using reserve mapzone. DO THIS IF YOUR MAP IS OVER 255x255 LARGE
	var/load_seperate_z

	//controls what kind of sound we play when we land and the maptext comes up
	var/landing_sound

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


/datum/overmap/static_object/testmap
	name = "test"
	desc = "TESTMAP"
	token_icon_state = "zeta"
	preserve_level = TRUE
	map_to_load = /datum/map_template/test_punchcard

/datum/map_template/test_punchcard
	name = "test_punchcard"
	mappath = 'punchcard_test_map.dmm'
