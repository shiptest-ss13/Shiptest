/**
 * # Dynamic Overmap Encounters
 *
 * These overmap objects can be docked with and will create a dynamically generated area of many different types depending on the planet variable.
 * When undocked with, it checks if there's anyone left on the planet, and if not, will move to another random location and wait to create a new encounter.
 */
/datum/overmap/dynamic
	name = "weak energy signature"
	char_rep = "?"
	///The active turf reservation, if there is one
	var/datum/map_zone/mapzone
	///The preset ruin template to load, if/when it is loaded.
	var/datum/map_template/template
	///The docking port in the reserve
	var/list/obj/docking_port/stationary/reserve_docks
	///If the level should be preserved. Useful for if you want to build a colony or something.
	var/preserve_level = FALSE
	///What kind of planet the level is, if it's a planet at all.
	var/datum/planet_type/planet
	///Planet's flavor name, if it is a planet.
	var/planet_name
	///List of probabilities for each type of planet.
	var/static/list/probabilities
	///The planet that will be forced to load
	var/force_encounter
	///Ruin types to generate
	var/ruin_type
	/// list of ruins and their target turf, indexed by name
	var/list/ruin_turfs

	/// The mapgenerator itself. SHOULD NOT BE NULL if the datum ever creates an encounter
	var/datum/map_generator/mapgen = /datum/map_generator/single_turf/space
	/// The turf used as the backup baseturf for any reservations created by this datum. Should not be null.
	var/turf/default_baseturf = /turf/open/space

	///The weather the virtual z will have. If null, the planet will have no weather.
	var/datum/weather_controller/weather_controller_type

	///The Y bounds of the virtual z level
	var/vlevel_height = QUADRANT_MAP_SIZE
	///The X bounds of the virtual z level
	var/vlevel_width = QUADRANT_MAP_SIZE

	//controls what kind of sound we play when we land and the maptext comes up
	var/landing_sound

/datum/overmap/dynamic/Initialize(position, load_now=TRUE, ...)
	. = ..()

	vlevel_height = CONFIG_GET(number/overmap_encounter_size)
	vlevel_width = CONFIG_GET(number/overmap_encounter_size)
	if(load_now)
		choose_level_type(load_now)

/datum/overmap/dynamic/Destroy()
	for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
		reserve_docks -= dock
		qdel(dock, TRUE)
	if(mapzone)
		mapzone.clear_reservation()
		QDEL_NULL(mapzone)
	ruin_turfs = null
	return ..()

/datum/overmap/dynamic/get_jump_to_turf()
	if(reserve_docks)
		return get_turf(pick(reserve_docks))

/datum/overmap/dynamic/pre_docked(datum/overmap/ship/controlled/dock_requester)
	if(!load_level())
		return new /datum/docking_ticket(_docking_error = "[src] cannot be docked to.")
	else
		var/dock_to_use = null
		for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
			if(!dock.docked)
				dock_to_use = dock
				break

		if(!dock_to_use)
			return new /datum/docking_ticket(_docking_error = "[src] does not have any free docks. Aborting docking.")
		adjust_dock_to_shuttle(dock_to_use, dock_requester.shuttle_port)
		return new /datum/docking_ticket(dock_to_use, src, dock_requester)

/datum/overmap/dynamic/post_docked(datum/overmap/ship/controlled/dock_requester)
	if(planet_name)
		for(var/mob/Mob as anything in GLOB.player_list)
			if(dock_requester.shuttle_port.is_in_shuttle_bounds(Mob))
				Mob.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:center valign='top'><u>[planet_name]</u></span><br>[station_time_timestamp_fancy("hh:mm")]")
				playsound(Mob, landing_sound, 50)


/datum/overmap/dynamic/post_undocked(datum/overmap/dock_requester)
	if(preserve_level)
		return

	if(length(mapzone?.get_mind_mobs()))
		return //Dont fuck over stranded people? tbh this shouldn't be called on this condition, instead of bandaiding it inside

	log_shuttle("[src] [REF(src)] UNLOAD")
	var/list/results = SSovermap.get_unused_overmap_square()
	overmap_move(results["x"], results["y"])

	for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
		reserve_docks -= dock
		qdel(dock, TRUE)
	reserve_docks = null
	if(mapzone)
		mapzone.clear_reservation()
		QDEL_NULL(mapzone)

	choose_level_type()

/**
 * Chooses a type of level for the dynamic level to use.
 */
/datum/overmap/dynamic/proc/choose_level_type(load_now = TRUE) //TODO: This is a awful way of hanlding random planets. If maybe it picked from a list of datums that then would be applied on the dynamic datum, it would be a LOT better.
	if(!probabilities)
		probabilities = list()
		for(var/datum/planet_type/planet_type as anything in subtypesof(/datum/planet_type))
			probabilities[initial(planet_type.planet)] = initial(planet_type.weight)
	planet = SSmapping.planet_types[force_encounter ? force_encounter : pickweightAllowZero(probabilities)]


	if(planet.planet !=DYNAMIC_WORLD_ASTEROID && planet.planet != DYNAMIC_WORLD_SPACERUIN) //these aren't real planets
		planet_name = "[gen_planet_name()]"
		Rename(planet_name)
		token.name = "[planet_name]" + " ([planet.name])"
	if(planet.planet == DYNAMIC_WORLD_ASTEROID || planet.planet == DYNAMIC_WORLD_SPACERUIN)
		Rename(planet.name)
		token.name = "[planet.name]"

	token.icon_state = planet.icon_state
	token.desc = planet.desc
	token.color = planet.color
	ruin_type = planet.ruin_type
	default_baseturf = planet.default_baseturf
	mapgen = planet.mapgen
	weather_controller_type = planet.weather_controller_type
	landing_sound = planet.landing_sound
	preserve_level = planet.preserve_level //it came to me while I was looking at chickens

	if(vlevel_height >= 255 && vlevel_width >= 255) //little easter egg
		planet_name = "LV-[pick(rand(11111,99999))]"
		token.icon_state = "sector"
		Rename(planet_name)

// - SERVER ISSUE: LOADING ALL PLANETS AT ROUND START KILLS PERFORMANCE BEYOND WHAT IS REASONABLE. OPTIMIZE SSMOBS IF YOU WANT THIS BACK
// #ifdef FULL_INIT //Initialising planets roundstart isn't NECESSARY, but is very nice in production. Takes a long time to load, though.
// 	if(load_now)
// 		load_level() //Load the level whenever it's randomised
// #endif

	if(!preserve_level)
		token.desc += " It may not still be here if you leave it."
		token.update_icon()

/datum/overmap/dynamic/proc/gen_planet_name()
	. = ""
	switch(rand(1,10))
		if(1 to 4)
			for(var/i in 1 to rand(2,3))
				. += capitalize(pick(GLOB.alphabet))
			. += "-"
			. += "[pick(rand(1,999))]"
		if(4 to 9)
			. += "[pick(GLOB.planet_names)] \Roman[rand(1,9)]"
		if(10)
			. += "[pick(GLOB.planet_prefixes)] [pick(GLOB.planet_names)]"

/**
 * Load a level for a ship that's visiting the level.
 * * visiting shuttle - The docking port of the shuttle visiting the level.
 */
/datum/overmap/dynamic/proc/load_level()
	if(mapzone)
		return TRUE
	log_shuttle("[src] [REF(src)] LEVEL_INIT")
	// use the ruin type in template if it exists, or pick from ruin list if IT exists; otherwise null
	var/selected_ruin = template || (ruin_type ? pickweightAllowZero(SSmapping.ruin_types_probabilities[ruin_type]) : null)
	var/list/dynamic_encounter_values = SSovermap.spawn_dynamic_encounter(src, selected_ruin)
	if(!length(dynamic_encounter_values))
		return FALSE
	mapzone = dynamic_encounter_values[1]
	reserve_docks = dynamic_encounter_values[2]
	ruin_turfs = dynamic_encounter_values[3]
	return TRUE

/datum/overmap/dynamic/empty
	name = "Empty Space"

/datum/overmap/dynamic/empty/choose_level_type()
	return

/datum/overmap/dynamic/empty/post_undocked(datum/overmap/ship/controlled/dock_requester)
	if(length(mapzone?.get_mind_mobs()))
		return //Dont fuck over stranded people? tbh this shouldn't be called on this condition, instead of bandaiding it inside
	log_shuttle("[src] [REF(src)] UNLOAD")
	qdel(src)


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
	ambientsounds = RUINS
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

// Used for caves on multi-biome planetoids.
/area/overmap_encounter/planetoid/cave
	name = "\improper Planetoid Cavern"
	sound_environment = SOUND_ENVIRONMENT_CAVE
	ambientsounds = SPOOKY
	allow_weather = FALSE

/area/overmap_encounter/planetoid/lava
	name = "\improper Volcanic Planetoid"
	ambientsounds = MINING

/area/overmap_encounter/planetoid/ice
	name = "\improper Frozen Planetoid"
	sound_environment = SOUND_ENVIRONMENT_CAVE
	ambientsounds = SPOOKY

/area/overmap_encounter/planetoid/sand
	name = "\improper Sandy Planetoid"
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	ambientsounds = MINING

/area/overmap_encounter/planetoid/jungle
	name = "\improper Jungle Planetoid"
	sound_environment = SOUND_ENVIRONMENT_FOREST
	ambientsounds = AWAY_MISSION

/area/overmap_encounter/planetoid/rockplanet
	name = "\improper Rocky Planetoid"
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	ambientsounds = AWAY_MISSION

/area/overmap_encounter/planetoid/rockplanet/explored//for use in ruins
	area_flags = VALID_TERRITORY

/area/overmap_encounter/planetoid/beachplanet
	name = "\improper Beach Planetoid"
	sound_environment = SOUND_ENVIRONMENT_FOREST
	ambientsounds = BEACH

/area/overmap_encounter/planetoid/wasteplanet
	name = "\improper Waste Planetoid"
	sound_environment = SOUND_ENVIRONMENT_HANGAR
	ambientsounds = MAINTENANCE

/area/overmap_encounter/planetoid/reebe
	name = "\improper Yellow Space"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	area_flags = HIDDEN_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED //allows jaunters to work
	ambientsounds = REEBE

/area/overmap_encounter/planetoid/asteroid
	name = "\improper Asteroid Field"
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	ambientsounds = SPACE

/area/overmap_encounter/planetoid/gas_giant
	name = "\improper Gas Giant"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	ambientsounds = REEBE
	has_gravity = GAS_GIANT_GRAVITY
