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
	var/planet
	///Planet's flavor name, if it is a planet.
	var/planet_name
	///List of probabilities for each type of planet.
	var/static/list/probabilities
	///The planet that will be forced to load
	var/force_encounter

/datum/overmap/dynamic/Initialize(position, ...)
	. = ..()
	choose_level_type()

/datum/overmap/dynamic/Destroy()
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

/datum/overmap/dynamic/pre_docked(datum/overmap/ship/controlled/dock_requester)
	if(!load_level())
		return FALSE
	else
		var/dock_to_use = null
		for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
			if(!dock.get_docked())
				dock_to_use = dock
				break

		if(!dock_to_use)
			return FALSE
		adjust_dock_to_shuttle(dock_to_use, dock_requester.shuttle_port)
		return new /datum/docking_ticket(dock_to_use, src, dock_requester)

/datum/overmap/dynamic/post_docked(datum/overmap/ship/controlled/dock_requester)
	if(planet_name)
		for(var/mob/M as anything in GLOB.player_list)
			if(dock_requester.shuttle_port.is_in_shuttle_bounds(M))
				M.play_screen_text("<span class='maptext' style=font-size:24pt;text-align:center valign='top'><u>[planet_name]</u></span><br>[station_time_timestamp_fancy("hh:mm")]")

/datum/overmap/dynamic/post_undocked(datum/overmap/dock_requester)
	if(preserve_level)
		return

	if(length(mapzone?.get_mind_mobs()))
		return //Dont fuck over stranded people? tbh this shouldn't be called on this condition, instead of bandaiding it inside

	log_shuttle("[src] [REF(src)] UNLOAD")
	var/list/results = SSovermap.get_unused_overmap_square()
	Move(results["x"], results["y"])
	choose_level_type()

	for(var/obj/docking_port/stationary/dock as anything in reserve_docks)
		reserve_docks -= dock
		qdel(dock, TRUE)
	reserve_docks = null
	if(mapzone)
		mapzone.clear_reservation()
		QDEL_NULL(mapzone)

/**
  * Chooses a type of level for the dynamic level to use.
  */
/datum/overmap/dynamic/proc/choose_level_type()
	var/chosen
	if(!probabilities)
		probabilities = list(DYNAMIC_WORLD_LAVA = min(length(SSmapping.lava_ruins_templates), 20),
		DYNAMIC_WORLD_ICE = min(length(SSmapping.ice_ruins_templates), 20),
		DYNAMIC_WORLD_JUNGLE = min(length(SSmapping.jungle_ruins_templates), 20),
		DYNAMIC_WORLD_SAND = min(length(SSmapping.sand_ruins_templates), 20),
		DYNAMIC_WORLD_SPACERUIN = min(length(SSmapping.space_ruins_templates), 20),
		DYNAMIC_WORLD_ROCKPLANET = min(length(SSmapping.rock_ruins_templates), 20),
		//DYNAMIC_WORLD_REEBE = 1, //very rare because of major lack of skil //TODO, make removing no teleport not break things, then it can be reenabled
		DYNAMIC_WORLD_ASTEROID = 30)

	if(force_encounter)
		chosen = force_encounter
	else
		chosen = pickweight(probabilities)
	switch(chosen)
		if(DYNAMIC_WORLD_LAVA)
			Rename("strange lava planet")
			token.desc = "A very weak energy signal originating from a planet with lots of seismic and volcanic activity."
			planet = DYNAMIC_WORLD_LAVA
			token.icon_state = "globe"
			token.color = COLOR_ORANGE
			planet_name = gen_planet_name()
		if(DYNAMIC_WORLD_ICE)
			Rename("strange ice planet")
			token.desc = "A very weak energy signal originating from a planet with traces of water and extremely low temperatures."
			planet = DYNAMIC_WORLD_ICE
			token.icon_state = "globe"
			token.color = COLOR_BLUE_LIGHT
			planet_name = gen_planet_name()
		if(DYNAMIC_WORLD_JUNGLE)
			Rename("strange jungle planet")
			token.desc = "A very weak energy signal originating from a planet teeming with life."
			planet = DYNAMIC_WORLD_JUNGLE
			token.icon_state = "globe"
			token.color = COLOR_LIME
			planet_name = gen_planet_name()
		if(DYNAMIC_WORLD_SAND)
			Rename("strange sand planet")
			token.desc = "A very weak energy signal originating from a planet with many traces of silica."
			planet = DYNAMIC_WORLD_SAND
			token.icon_state = "globe"
			token.color = COLOR_GRAY
			planet_name = gen_planet_name()
		if(DYNAMIC_WORLD_ROCKPLANET)
			Rename("strange rock planet")
			token.desc = "A very weak energy signal originating from a abandoned industrial planet."
			planet = DYNAMIC_WORLD_ROCKPLANET
			token.icon_state = "globe"
			token.color = COLOR_BROWN
			planet_name = gen_planet_name()
		if(DYNAMIC_WORLD_REEBE)
			Rename("???")
			token.desc = "Some sort of strange portal. Theres no identification of what this is."
			planet = DYNAMIC_WORLD_REEBE
			token.icon_state = "wormhole"
			token.color = COLOR_YELLOW
		if(DYNAMIC_WORLD_ASTEROID)
			Rename("large asteroid")
			token.desc = "A large asteroid with significant traces of minerals."
			planet = DYNAMIC_WORLD_ASTEROID
			token.icon_state = "asteroid"
			token.color = COLOR_GRAY
		if(DYNAMIC_WORLD_SPACERUIN)
			Rename("weak energy signal")
			token.desc = "A very weak energy signal emenating from space."
			planet = DYNAMIC_WORLD_SPACERUIN
			token.icon_state = "strange_event"
			token.color = null
	token.desc += !preserve_level && "It may not still be here if you leave it."

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
	if(!COOLDOWN_FINISHED(SSovermap, encounter_cooldown))
		return FALSE
	log_shuttle("[src] [REF(src)] LEVEL_INIT")
	var/list/dynamic_encounter_values = SSovermap.spawn_dynamic_encounter(planet, TRUE, ruin_type = template)
	if(!length(dynamic_encounter_values))
		return FALSE
	mapzone = dynamic_encounter_values[1]
	reserve_docks = dynamic_encounter_values[2]
	return TRUE

/**
 * Alters the position and orientation of a stationary docking port to ensure that any mobile port small enough can dock within its bounds
 */
/datum/overmap/dynamic/proc/adjust_dock_to_shuttle(obj/docking_port/stationary/dock_to_adjust, obj/docking_port/mobile/shuttle)
	log_shuttle("[src] [REF(src)] DOCKING: ADJUST [dock_to_adjust] [REF(dock_to_adjust)] TO [shuttle][REF(shuttle)]")
	// the shuttle's dimensions where "true height" measures distance from the shuttle's fore to its aft
	var/shuttle_true_height = shuttle.height
	var/shuttle_true_width = shuttle.width
	// if the port's location is perpendicular to the shuttle's fore, the "true height" is the port's "width" and vice-versa
	if(EWCOMPONENT(shuttle.port_direction))
		shuttle_true_height = shuttle.width
		shuttle_true_width = shuttle.height

	// the dir the stationary port should be facing (note that it points inwards)
	var/final_facing_dir = angle2dir(dir2angle(shuttle_true_height > shuttle_true_width ? EAST : NORTH)+dir2angle(shuttle.port_direction)+180)

	var/list/old_corners = dock_to_adjust.return_coords() // coords for "bottom left" / "top right" of dock's covered area, rotated by dock's current dir
	var/list/new_dock_location // TBD coords of the new location
	if(final_facing_dir == dock_to_adjust.dir)
		new_dock_location = list(old_corners[1], old_corners[2]) // don't move the corner
	else if(final_facing_dir == angle2dir(dir2angle(dock_to_adjust.dir)+180))
		new_dock_location = list(old_corners[3], old_corners[4]) // flip corner to the opposite
	else
		var/combined_dirs = final_facing_dir | dock_to_adjust.dir
		if(combined_dirs == (NORTH|EAST) || combined_dirs == (SOUTH|WEST))
			new_dock_location = list(old_corners[1], old_corners[4]) // move the corner vertically
		else
			new_dock_location = list(old_corners[3], old_corners[2]) // move the corner horizontally
		// we need to flip the height and width
		var/dock_height_store = dock_to_adjust.height
		dock_to_adjust.height = dock_to_adjust.width
		dock_to_adjust.width = dock_height_store

	dock_to_adjust.dir = final_facing_dir
	if(shuttle.height > dock_to_adjust.height || shuttle.width > dock_to_adjust.width)
		CRASH("Shuttle cannot fit in dock!")

	// offset for the dock within its area
	var/new_dheight = round((dock_to_adjust.height-shuttle.height)/2) + shuttle.dheight
	var/new_dwidth = round((dock_to_adjust.width-shuttle.width)/2) + shuttle.dwidth

	// use the relative-to-dir offset above to find the absolute position offset for the dock
	switch(final_facing_dir)
		if(NORTH)
			new_dock_location[1] += new_dwidth
			new_dock_location[2] += new_dheight
		if(SOUTH)
			new_dock_location[1] -= new_dwidth
			new_dock_location[2] -= new_dheight
		if(EAST)
			new_dock_location[1] += new_dheight
			new_dock_location[2] -= new_dwidth
		if(WEST)
			new_dock_location[1] -= new_dheight
			new_dock_location[2] += new_dwidth

	dock_to_adjust.forceMove(locate(new_dock_location[1], new_dock_location[2], dock_to_adjust.z))
	dock_to_adjust.dheight = new_dheight
	dock_to_adjust.dwidth = new_dwidth

/area/overmap_encounter
	name = "\improper Overmap Encounter"
	icon_state = "away"
	area_flags = HIDDEN_AREA | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | NOTELEPORT
	flags_1 = CAN_BE_DIRTY_1
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	sound_environment = SOUND_ENVIRONMENT_STONEROOM
	ambientsounds = RUINS
	outdoors = TRUE

/area/overmap_encounter/planetoid
	name = "\improper Unknown Planetoid"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	has_gravity = STANDARD_GRAVITY
	always_unpowered = TRUE

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
	sound_environment = SOUND_ENVIRONMENT_HANGAR
	ambientsounds = MAINTENANCE

/area/overmap_encounter/planetoid/rockplanet/explored//for use in ruins
	area_flags = UNIQUE_AREA
	area_flags = VALID_TERRITORY | UNIQUE_AREA

/area/overmap_encounter/planetoid/reebe
	name = "\improper Yellow Space"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	ambientsounds = REEBE

/area/overmap_encounter/planetoid/reebe/Entered(atom/movable/AM)
	. = ..()
	if(ismob(AM))
		var/mob/M = AM
		if(M.client)
			addtimer(CALLBACK(M.client, /client/proc/play_reebe_ambience), 900)

/datum/overmap/dynamic/empty
	name = "Empty Space"

/datum/overmap/dynamic/empty/choose_level_type()
	return

/datum/overmap/dynamic/empty/post_undocked(datum/overmap/ship/controlled/dock_requester)
	if(length(mapzone?.get_mind_mobs()))
		return //Dont fuck over stranded people? tbh this shouldn't be called on this condition, instead of bandaiding it inside
	log_shuttle("[src] [REF(src)] UNLOAD")
	qdel(src)
