/**
 * # Dynamic Overmap Encounters
 *
 * These overmap objects can be docked with and will create a dynamically generated area of many different types depending on the planet variable.
 * When undocked with, it checks if there's anyone left on the planet, and if not, will move to another random location and wait to create a new encounter.
 */
/datum/overmap/dynamic
	name = "weak energy signature"
	char_rep = "?"

	interaction_options = list(INTERACTION_OVERMAP_DOCK, INTERACTION_OVERMAP_QUICKDOCK)

	///The active turf reservation, if there is one
	var/datum/map_zone/mapzone
	///The preset ruin template to load, if/when it is loaded.
	var/datum/map_template/template
	///The docking port in the reserve
	var/list/obj/docking_port/stationary/reserve_docks
	///If the level should be preserved. Useful for if you want to build a colony or something.
	var/preserve_level = FALSE
	///If the level is able to be preserved. For example, by a planet_beacon
	var/can_preserve = TRUE
	///What kind of planet the level is, if it's a planet at all.
	var/datum/planet_type/planet
	///Planet's flavor name, if it is a planet.
	var/planet_name
	///List of probabilities for each type of planet.
	var/list/probabilities
	///The planet that will be forced to load
	var/force_encounter
	///Ruin types to generate
	var/ruin_type
	///Preditermined ruin made when the overmap is first created
	var/selected_ruin
	///Fetched before anything is loaded from the ruin datum
	var/dynamic_missions = list()
	///The list of mission pois once the planet has acctually loaded the ruin
	var/list/list/datum/weakref/spawned_mission_pois
	/// list of ruins and their target turf, indexed by name
	var/list/ruin_turfs
	/// list of ruin templates currently spawned on the planet.
	var/list/spawned_ruins
	/// Whether or not the level is currently loading.
	var/loading = FALSE

	/// Whether or not we populate turfs, primarly to save some time in the ruin unit test
	var/populate_turfs = TRUE

	/// The mapgenerator itself. SHOULD NOT BE NULL if the datum ever creates an encounter
	var/datum/map_generator/mapgen = /datum/map_generator/single_turf/space
	/// The turf used as the backup baseturf for any reservations created by this datum. Should not be null.
	var/turf/default_baseturf = /turf/open/space

	///The default gravity the virtual z will have
	var/gravity = 0

	///The weather the virtual z will have. If null, the planet will have no weather.
	var/datum/weather_controller/weather_controller_type

	///The Y bounds of the virtual z level
	var/vlevel_height = QUADRANT_MAP_SIZE
	///The X bounds of the virtual z level
	var/vlevel_width = QUADRANT_MAP_SIZE

	///Controls what kind of sound we play when we land and the maptext comes up
	var/landing_sound
	///Do we selfloop? If so the borders of the map connect to the other side of the planet. Not recommended.
	var/selfloop

/datum/overmap/dynamic/Initialize(position, datum/overmap_star_system/system_spawned_in, load_now=TRUE, ...)
	. = ..()
	SSovermap.dynamic_encounters += src
	current_overmap.dynamic_encounters += src

	vlevel_height = CONFIG_GET(number/overmap_encounter_size)
	vlevel_width = CONFIG_GET(number/overmap_encounter_size)
	if(load_now)
		choose_level_type(load_now)

/datum/overmap/dynamic/Destroy()
	for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
		reserve_docks -= dock
		qdel(dock)
	ruin_turfs = null
	SSovermap.dynamic_encounters -= src
	current_overmap.dynamic_encounters -= src
	. = ..()
	//This NEEDS to be last so any docked ships get deleted properly
	if(mapzone)
		mapzone.clear_reservation()
		QDEL_NULL(mapzone)

/datum/overmap/dynamic/get_jump_to_turf()
	if(reserve_docks)
		return get_turf(pick(reserve_docks))

/datum/overmap/dynamic/pre_docked(datum/overmap/ship/controlled/dock_requester, override_dock)
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

/datum/overmap/dynamic/get_dockable_locations(datum/overmap/requesting_interactor)
	var/list/docks = list()
	for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
		if(!dock.docked && !dock.current_docking_ticket)
			LAZYADD(docks, dock)
	return docks

/datum/overmap/dynamic/post_docked(datum/overmap/ship/controlled/dock_requester)
	if(planet_name)
		for(var/mob/Mob as anything in GLOB.player_list)
			if(dock_requester.shuttle_port.is_in_shuttle_bounds(Mob))
				Mob.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:center valign='top'><u>[planet_name]</u></span><br>[station_time_timestamp("hh:mm")]")
				playsound(Mob, landing_sound, 50)


/datum/overmap/dynamic/post_undocked(datum/overmap/dock_requester)
	start_countdown()

/datum/overmap/dynamic/proc/start_countdown(_lifespan = 60 SECONDS, _color = null)
	if(token.countdown) //We already have a countdown. dont start a new one.
		return
	if(!_color)
		_color = current_overmap.hazard_secondary_color
	if(_lifespan)
		lifespan = _lifespan
	if(!can_reset_dynamic())
		return
	death_time = world.time + lifespan
	token.countdown = new /obj/effect/countdown/overmap_event(token)
	token.countdown.color = _color

	token.countdown.start()
	START_PROCESSING(SSfastprocess, src)
	return TRUE

/datum/overmap/dynamic/process()
	if(death_time < world.time && lifespan)
		reset_dynamic()

/datum/overmap/dynamic/proc/can_reset_dynamic()
	if(preserve_level)
		return FALSE

	if(length(mapzone?.get_mind_mobs()) || SSlag_switch.measures[DISABLE_PLANETDEL])
		return FALSE //Dont fuck over stranded people

	for(var/datum/mission/ruin/dynamic_mission in dynamic_missions)
		if(dynamic_mission.active && !dynamic_mission.bound_left_location)
			return FALSE //Dont fuck over people trying to complete a mission.

	return TRUE

/datum/overmap/dynamic/proc/reset_dynamic()
	QDEL_NULL(token.countdown)
	STOP_PROCESSING(SSfastprocess, src)

	if(!can_reset_dynamic())
		return

	log_shuttle("[src] [REF(src)] UNLOAD")
	qdel(src)

/**
 * Chooses a type of level for the dynamic level to use.
 */
/datum/overmap/dynamic/proc/choose_level_type(load_now = TRUE)
	if(isnull(probabilities))
		probabilities = current_overmap.dynamic_probabilities
	if(!isnull(force_encounter))
		planet = force_encounter
	else
		planet = SSmapping.planet_types[force_encounter ? force_encounter : pick_weight_allow_zero(probabilities)]

	set_planet_type(planet)

	// use the ruin type in template if it exists, or pick from ruin list if IT exists; otherwise null
	selected_ruin = template || (ruin_type ? pick_weight_allow_zero(SSmapping.ruin_types_probabilities[ruin_type]) : null)
	var/datum/map_template/ruin/used_ruin = ispath(selected_ruin) ? (new selected_ruin()) : selected_ruin
	if(istype(used_ruin))
		for(var/mission_type in used_ruin.ruin_mission_types)
			dynamic_missions += new mission_type(src, 1 + length(dynamic_missions))



/datum/overmap/dynamic/proc/set_planet_type(datum/planet_type/planet)
	if(!is_type_in_list(planet, list(/datum/planet_type/asteroid, /datum/planet_type/spaceruin)))
		planet_name = "[gen_planet_name()]"
		name = "[planet_name] ([planet.name])"

	ruin_type = planet.ruin_type
	default_baseturf = planet.default_baseturf
	gravity = planet.gravity
	token_icon_state = planet.icon_state
	mapgen = planet.mapgen
	weather_controller_type = planet.weather_controller_type
	landing_sound = planet.landing_sound
	preserve_level = planet.preserve_level //it came to me while I was looking at chickens
	selfloop = planet.selfloop
	interference_power = planet.interference_power

	if(vlevel_height >= 255 && vlevel_width >= 255) //little easter egg
		planet_name = "LV-[pick(rand(11111,99999))]"
		token.icon_state = "sector"
		Rename(planet_name)

	alter_token_appearance()

/datum/overmap/dynamic/alter_token_appearance()
	if(!planet)
		return ..()
	token.name = name
	token_icon_state = planet.icon_state
	desc = planet.desc
	default_color = planet.color
	var/orestext
	if(planet.primary_ores)
		orestext += span_boldnotice("\nInitial scans show a high concentration of the following ores:\n")
		for(var/obj/ore as anything in planet.primary_ores)
			var/hex = ORES_TO_COLORS_LIST[ore]
			orestext += "<font color='[hex]'>	- [ore.name]\n</font>"
		desc += orestext

	if(!preserve_level)
		token.desc += span_notice("\nIt may not still be here if you leave it.")
	..()

	if(current_overmap.override_object_colors)
		token.color = current_overmap.primary_color
	current_overmap.post_edit_token_state(src)

///??? I dont think i ever finished this, and if i do, move to planet_types.dm
/datum/overmap/dynamic/proc/choose_random_asteroid()

/datum/overmap/dynamic/proc/gen_planet_name()
	. = ""
	switch(rand(1,12))
		if(1 to 3)
			for(var/i in 1 to rand(2,3))
				. += capitalize(pick(GLOB.alphabet))
			. += "-"
			. += "[pick(rand(1,999))]"
		if(3 to 5)
			. += "[pick(GLOB.planet_names)]"
		if(5 to 7)
			. += "[pick(GLOB.planet_names)] \Roman[rand(1,9)]"
		if(8 to 11)
			. += "[pick(GLOB.planet_prefixes)] [pick(GLOB.planet_names)]"
		if(12)
			. += "[capitalize(pick(GLOB.adjectives))] [pick(GLOB.planet_names)]"

/**
 * Load a level for a ship that's visiting the level.
 * * visiting shuttle - The docking port of the shuttle visiting the level.
 */
/datum/overmap/dynamic/proc/load_level()
	if(SSlag_switch.measures[DISABLE_PLANETGEN] && !(HAS_TRAIT(usr, TRAIT_BYPASS_MEASURES)))
		return FALSE
	if(mapzone)
		return TRUE

	loading = TRUE
	log_shuttle("[src] [REF(src)] LEVEL_INIT")

	var/list/dynamic_encounter_values = current_overmap.spawn_dynamic_encounter(src, selected_ruin)
	if(!length(dynamic_encounter_values))
		return FALSE

	mapzone = dynamic_encounter_values[1]
	reserve_docks = dynamic_encounter_values[2]
	ruin_turfs = dynamic_encounter_values[3]
	spawned_ruins = dynamic_encounter_values[4]
	spawned_mission_pois = dynamic_encounter_values[5]

	var/datum/virtual_level/our_likely_vlevel = mapzone.virtual_levels[1]
	if(istype(our_likely_vlevel) && selfloop)
		our_likely_vlevel.selfloop()

	for(var/obj/docking_port/stationary/port in reserve_docks)
		if(port.roundstart_template)
			port.name = "[name] auxillary docking location"
			port.load_roundstart()

	SEND_SIGNAL(src, COMSIG_OVERMAP_LOADED)
	loading = FALSE
	return TRUE

/datum/overmap/dynamic/admin_load()
	preserve_level = TRUE
	message_admins("Generating [src], this may take some time!")
	load_level()

	message_admins(span_big("Click here to jump to the overmap token: " + ADMIN_JMP(token)))
	message_admins(span_big("Click here to jump to the overmap dock: " + ADMIN_JMP(reserve_docks[1])))
	for(var/ruin in ruin_turfs)
		var/turf/ruin_turf = ruin_turfs[ruin]
		message_admins(span_big("Click here to jump to \"[ruin]\": " + ADMIN_JMP(ruin_turf)))

/datum/overmap/dynamic/ui_data(mob/user)
	. = ..()
	.["active_ruin_missions"] = list()
	.["inactive_ruin_missions"] = list()
	for(var/datum/mission/ruin/mission as anything in dynamic_missions)
		if(mission.active)
			.["active_ruin_missions"] += list(list(
				"ref" = REF(mission),
				"name" = mission.name,
			))
		else
			.["inactive_ruin_missions"] += list(list(
				"ref" = REF(mission),
				"name" = mission.name,
			))

/datum/overmap/dynamic/empty
	name = "Empty Space"
	token_icon_state = "signal_ship"
	interaction_options = list(INTERACTION_OVERMAP_DOCK, INTERACTION_OVERMAP_QUICKDOCK, INTERACTION_OVERMAP_SETSIGNALSPRITE)
	selfloop = TRUE
	var/static/list/available_icon_options = list(\
		"signal_none",
		"signal_ship",
		"signal_strange",
		"signal_info",
		"signal_distress",
		"signal_trade",
		"signal_wreckage",
		"signal_health",
		"signal_gun",
		"signal_sword",
		"signal_skull",
		"signal_love",
		"signal_diner",
		)

/datum/overmap/dynamic/empty/handle_interaction_on_target(mob/living/user, datum/overmap/interactor, choice)
	switch(choice)
		if(INTERACTION_OVERMAP_SETSIGNALSPRITE)
			choice = tgui_input_list(usr, "What appearance should this space take?", "Select Appearance", available_icon_options)
			if(!choice)
				return "WARNING: Interaction aborted."
			token_icon_state = choice
			alter_token_appearance()
			return INTERACTION_OVERMAP_SELECTED
	return ..()

/datum/overmap/dynamic/empty/choose_level_type()
	var/datum/overmap/event/current_event = locate(/datum/overmap/event) in get_nearby_overmap_objects()
	if(!current_event)
		return
	current_event.modify_emptyspace_mapgen(src)

/datum/overmap/dynamic/empty/post_undocked(datum/overmap/ship/controlled/dock_requester)
	if(length(mapzone?.get_mind_mobs()))
		return //Dont fuck over stranded people? tbh this shouldn't be called on this condition, instead of bandaiding it inside
	log_shuttle("[src] [REF(src)] UNLOAD")
	if(mapzone)
		mapzone.clear_reservation()
		QDEL_NULL(mapzone)
	qdel(src)


/datum/overmap/dynamic/proc/set_preservation(preserve)
	if(!can_preserve)
		return FALSE
	preserve_level = preserve
	alter_token_appearance()
	return TRUE

/datum/overmap/dynamic/spaceruin
	name = "wreckage"
	force_encounter = RUINTYPE_SPACE

/*
	OVERMAP ENCOUNTER AREAS
*/

/area/overmap_encounter
	name = "\improper Overmap Encounter"
	icon_state = "away"
	// DO NOT PUT UNIQUE_AREA IN THESE FLAGS FOR ANY SUBTYPE. IT CAUSES WEATHER PROBLEMS
	// THE ONLY REASON IT DIDN'T BEFORE IS BECAUSE THE CODE DIDN'T RESPECT THE FLAG
	area_flags = HIDDEN_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	flags_1 = CAN_BE_DIRTY_1
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	sound_environment = SOUND_ENVIRONMENT_STONEROOM
	ambience_index = AMBIENCE_RUINS
	outdoors = TRUE
	allow_weather = TRUE

/area/overmap_encounter/New(...)
	if(area_flags & UNIQUE_AREA)
		CRASH("Area [src.name] ([src.type], REF: [REF(src)]) created with flag UNIQUE_AREA! Don't do this! Weather will break!")
	. = ..()

/area/overmap_encounter/planetoid
	name = "\improper Unknown Planetoid"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	has_gravity = STANDARD_GRAVITY
	always_unpowered = TRUE
	//these vars are from atom but do nothing when on an area, should be okay to use
	light_range = 2
	light_power = 0.80
	light_color = "#FFFFFF"

/area/overmap_encounter/planetoid/update_light()
	for(var/turf/updating_turf as anything in contents)
		if(!istype(updating_turf))
			continue
		SEND_SIGNAL(updating_turf, COMSIG_OVERMAPTURF_UPDATE_LIGHT, light_range, light_power, light_color)

// Used for caves on multi-biome planetoids.
/area/overmap_encounter/planetoid/cave
	name = "\improper Planetoid Cavern"
	sound_environment = SOUND_ENVIRONMENT_CAVE
	ambience_index = AMBIENCE_SPOOKY
	allow_weather = FALSE
	light_range = 0
	light_power = 0

/area/overmap_encounter/planetoid/cave/explored
	area_flags = VALID_TERRITORY

//exploreds are for ruins

/area/overmap_encounter/planetoid/lava
	name = "\improper Volcanic Planetoid"
	ambience_index = AMBIENCE_MINING
	light_color = COLOR_LAVAPLANET_LIGHT
	light_range = 2
	light_power = 0.6

/area/overmap_encounter/planetoid/lava/explored
	area_flags = VALID_TERRITORY

/area/overmap_encounter/planetoid/ice
	name = "\improper Frozen Planetoid"
	sound_environment = SOUND_ENVIRONMENT_CAVE
	ambience_index = AMBIENCE_SPOOKY
	light_color = COLOR_ICEPLANET_LIGHT
	light_range = 2
	light_power = 1

/area/overmap_encounter/planetoid/ice/explored
	area_flags = VALID_TERRITORY

/area/overmap_encounter/planetoid/sand
	name = "\improper Sandy Planetoid"
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	ambience_index = AMBIENCE_MINING
	light_color = COLOR_SANDPLANET_LIGHT
	light_range = 2
	light_power = 0.6

/area/overmap_encounter/planetoid/sand/explored
	area_flags = VALID_TERRITORY

/area/overmap_encounter/planetoid/jungle
	name = "\improper Jungle Planetoid"
	sound_environment = SOUND_ENVIRONMENT_FOREST
	ambience_index = AMBIENCE_AWAY
	light_range = 2
	light_power = 1
	light_color = COLOR_VERY_LIGHT_GRAY

/area/overmap_encounter/planetoid/jungle/explored
	area_flags = VALID_TERRITORY

/area/overmap_encounter/planetoid/battlefield
	name = "\improper Battlefield Planetoid"
	sound_environment = SOUND_ENVIRONMENT_CITY
	ambience_index = AMBIENCE_SPOOKY
	light_color = COLOR_FOGGY_LIGHT
	light_range = 2
	light_power = 1

/area/overmap_encounter/planetoid/battlefield/explored
	area_flags = VALID_TERRITORY


/area/overmap_encounter/planetoid/rockplanet
	name = "\improper Rocky Planetoid"
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	ambience_index = AMBIENCE_AWAY
	light_color = COLOR_ROCKPLANET_LIGHT
	light_range = 2
	light_power = 0.6

/area/overmap_encounter/planetoid/rockplanet/explored
	area_flags = VALID_TERRITORY

/area/overmap_encounter/planetoid/beachplanet
	name = "\improper Beach Planetoid"
	sound_environment = SOUND_ENVIRONMENT_FOREST
	ambience_index = AMBIENCE_BEACH
	light_color = COLOR_BEACHPLANET_LIGHT
	light_range = 2
	light_power = 0.80

/area/overmap_encounter/planetoid/waterplanet
	name = "\improper Water Planetoid"
	sound_environment = SOUND_ENVIRONMENT_FOREST
	ambience_index = AMBIENCE_MINING
	light_color = "#09121a"
	light_range = 2
	light_power = 1

/area/overmap_encounter/planetoid/beachplanet/explored
	area_flags = VALID_TERRITORY

/area/overmap_encounter/planetoid/wasteplanet
	name = "\improper Waste Planetoid"
	sound_environment = SOUND_ENVIRONMENT_HANGAR
	ambience_index = AMBIENCE_MAINT
	light_color = COLOR_WASTEPLANET_LIGHT
	light_range = 2
	light_power = 0.2

/area/overmap_encounter/planetoid/wasteplanet/explored
	area_flags = VALID_TERRITORY

/area/overmap_encounter/planetoid/reebe
	name = "\improper Yellow Space"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	area_flags = HIDDEN_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED //allows jaunters to work
	ambience_index = AMBIENCE_REEBE
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/area/overmap_encounter/planetoid/desert
	name = "\improper Desert Planetoid"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	ambience_index = AMBIENCE_DESERT
	light_range = 2
	light_power = 0.6
	light_color = "#ffd2bd"

/area/overmap_encounter/planetoid/shrouded
	name = "\improper Shrouded Planetoid"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	ambience_index = AMBIENCE_DESERT
	light_range = 0
	light_power = 0

/area/overmap_encounter/planetoid/snowball
	name = "\improper Snowball Dwarf Planetoid"
	sound_environment = SOUND_ENVIRONMENT_STONE_CORRIDOR
	ambience_index = AMBIENCE_TUNDRA
	light_color = "#67769e"
	light_range = 2
	light_power = 1

/area/overmap_encounter/planetoid/dustball
	name = "\improper Dustball Dwarf Planetoid"
	sound_environment = SOUND_ENVIRONMENT_PLAIN
	ambience_index = AMBIENCE_DESERT
	light_color = "#bf9b9b"
	light_range = 2
	light_power = 1

/area/overmap_encounter/planetoid/duneball
	name = "\improper Duneball Dwarf Planetoid"
	sound_environment = SOUND_ENVIRONMENT_PLAIN
	ambience_index = AMBIENCE_DESERT
	light_color = "#be956b"
	light_range = 2
	light_power = 1

/area/overmap_encounter/planetoid/waterball
	name = "\improper Waterball Dwarf Planetoid"
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	ambience_index = AMBIENCE_MINING
	lighting_colour_tube = "#8affe2"
	lighting_colour_bulb = "#8affe2"
	light_color = "#09121a"
	light_range = 2
	light_power = 1

/area/overmap_encounter/planetoid/moon
	name = "\improper Planetoid Moon"
	ambience_index = AMBIENCE_SPACE
	sound_environment = SOUND_AREA_SPACE
	light_range = 2
	light_power = 1
	light_color = "#FFFFFF" // should look liminal, due to moons lighting

/area/overmap_encounter/planetoid/moon/explored
	area_flags = VALID_TERRITORY

/area/overmap_encounter/planetoid/asteroid
	name = "\improper Asteroid Field"
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	ambience_index = AMBIENCE_SPACE
	light_range = 0
	light_power = 0

/area/overmap_encounter/planetoid/asteroid/explored
	area_flags = VALID_TERRITORY

/area/overmap_encounter/planetoid/gas_giant
	name = "\improper Gas Giant"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	ambience_index = AMBIENCE_REEBE
	has_gravity = GAS_GIANT_GRAVITY
	light_range = 2
	light_power = 0.6
	light_color = COLOR_DARK_MODERATE_ORANGE
