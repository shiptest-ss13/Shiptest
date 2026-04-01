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
	///The border size to use. It's recommended to set this to 0 if you  use up the entirety of the allocated space (eg. 255x255 map where theres no bordering map levels)
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
		//if true, we say that we do in fact have free docks, just you cant fit in any of them for whatever reason. hopefully this is less vauge than "X Cannot be docked to."
		var/alt_message = FALSE
		if(!override_dock)
			for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
				//meant for quick dock, as such we check if we can actually dock here before checking all other docking ports.
				//This means you can name a docking port with a leading ! like '!Ship Starboard Stern Docking Port' to have priority over other docking ports
				if(!dock.docked)
					alt_message = TRUE
				if(!dock.docked && dock_requester.shuttle_port.check_dock(dock, TRUE, FALSE))
					dock_to_use = dock
					break

		if(!dock_to_use)
			if(alt_message)
				return new /datum/docking_ticket(_docking_error = "[src] has free docks, however vessel is unable to fit in any. Attempt manual docking for more information. Aborting docking.")
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

	SEND_SIGNAL(src, COMSIG_OVERMAP_LOADED)
	loading = FALSE
	return TRUE

/datum/overmap/static_object/admin_loaded
	name = "floating admin bus"
	desc = "Uh oh! Looks like an admin hasn't finished setting up yet! Better not dock until this description disapears!"
	token_icon_state = "bus"
	preserve_level = TRUE
	gravity = TRUE

/datum/overmap/static_object/tadpole_city
	name = "Tilted Tadpoles"
	desc = "<span class='userdanger'>Not only is this place super dangerous, by landing here you waiver the</span>"
	token_icon_state = "station_planet"
	map_to_load = /datum/map_template/outpost/tadpole_city
	var/datum/map_template/outpost/z2_template = /datum/map_template/outpost/tadpole_city_z2
	var/datum/map_template/outpost/z3_template = /datum/map_template/outpost/tadpole_city_z3
	var/elevator_template = /datum/map_template/outpost/elevator_clip
	weather_controller_type = /datum/weather_controller/toxic
	preserve_level = TRUE
	gravity = TRUE
	border_size = 1

	var/main_level_ztraits = list(
		ZTRAIT_STATION = TRUE,
		ZTRAIT_SUN_TYPE = AZIMUTH,
		ZTRAIT_GRAVITY = STANDARD_GRAVITY,
		ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid/battlefield_wasteland
	)
	var/list/other_level_ztraits = list(
		ZTRAIT_STATION = TRUE,
		ZTRAIT_SUN_TYPE = AZIMUTH,
		ZTRAIT_GRAVITY = STANDARD_GRAVITY,
		ZTRAIT_BASETURF = /turf/open/openspace
	)

/datum/overmap/static_object/tadpole_city/Initialize(position, datum/overmap_star_system/system_spawned_in, ...)
	map_to_load = SSmapping.outpost_templates[map_to_load]
	z2_template = SSmapping.outpost_templates[z2_template]
	z3_template = SSmapping.outpost_templates[z3_template]
	. = ..()

/datum/overmap/static_object/tadpole_city/load_level()
	if(SSlag_switch.measures[DISABLE_PLANETGEN] && !(HAS_TRAIT(usr, TRAIT_BYPASS_MEASURES)))
		return FALSE
	if(mapzone)
		return TRUE

	loading = TRUE
	log_shuttle("[src] [REF(src)] LEVEL_INIT")


	if(!map_to_load)
		CRASH("[src] ([src.type]) tried to load without a template!")

	mapzone = SSmapping.create_map_zone(name)
	var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(
		name,
		main_level_ztraits,
		mapzone,
		QUADRANT_MAP_SIZE,
		QUADRANT_MAP_SIZE,
		ALLOCATION_QUADRANT,
		QUADRANT_MAP_SIZE
	)
	vlevel.reserve_margin(QUADRANT_SIZE_BORDER)

	map_to_load.load(vlevel.get_unreserved_bottom_left_turf())


	//var/datum/virtual_level/vlevel1 = mapzone.virtual_levels[1]
	var/datum/virtual_level/vlevel2 = SSmapping.create_virtual_level(
		name + " - Skylines",
		other_level_ztraits,
		mapzone,
		QUADRANT_MAP_SIZE,
		QUADRANT_MAP_SIZE,
		ALLOCATION_QUADRANT,
		QUADRANT_MAP_SIZE
	)
	vlevel2.reserve_margin(QUADRANT_SIZE_BORDER)
	//we link the 2 levels
	vlevel.up_linkage = vlevel2
	vlevel2.down_linkage = vlevel

	z2_template.load(vlevel2.get_unreserved_bottom_left_turf())

	var/datum/virtual_level/vlevel3 = SSmapping.create_virtual_level(
		name + " - Skylines",
		other_level_ztraits,
		mapzone,
		QUADRANT_MAP_SIZE,
		QUADRANT_MAP_SIZE,
		ALLOCATION_QUADRANT,
		QUADRANT_MAP_SIZE
	)
	vlevel3.reserve_margin(QUADRANT_SIZE_BORDER)
	//we link the 2 levels
	vlevel2.up_linkage = vlevel3
	vlevel3.down_linkage = vlevel2

	z3_template.load(vlevel3.get_unreserved_bottom_left_turf())

	if(weather_controller_type)
		new weather_controller_type(mapzone)

	SEND_SIGNAL(src, COMSIG_OVERMAP_LOADED)

	reserve_docks = list()

	for(var/obj/docking_port/stationary/port as obj in SSshuttle.stationary)
		if((port.virtual_z() == (vlevel.id || vlevel2.id || vlevel3.id)))
			reserve_docks += port

	SEND_SIGNAL(src, COMSIG_OVERMAP_LOADED)
	loading = FALSE
	return TRUE

/datum/map_template/outpost/tadpole_city
	name = "tadpole_city"
	outpost_name = "Tadpole City"

/datum/map_template/outpost/tadpole_city_z2
	name = "tadpole_city_z2"
	outpost_name = "Tadpole City"

/datum/map_template/outpost/tadpole_city_z3
	name = "tadpole_city_z3"
	outpost_name = "Tadpole City"
