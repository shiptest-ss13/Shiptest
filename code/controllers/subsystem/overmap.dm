SUBSYSTEM_DEF(overmap)
	name = "Overmap"
	wait = 10
	init_order = INIT_ORDER_OVERMAP
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	/// All the existing star systems, it's gonna be atleast 1 including the main system
	var/list/tracked_star_systems = list()

	///List of all overmap objects.
	var/list/overmap_objects = list()
	///List of all simulated ships. All ships in this list are fully initialized.
	var/list/controlled_ships = list()
	///List of spawned outposts. The default spawn location is the first index.
	var/list/outposts = list()

	///List of all dynamic overmap datums
	var/list/dynamic_encounters  = list()
	///List of all events
	var/list/events = list()

	/// The primary star system that holds the outpost
	var/datum/overmap_star_system/safe_system

	/// The secondary star system that allows planet spawns
	var/datum/overmap_star_system/wild_system

	///Should events be processed
	var/events_enabled = TRUE

	///Whether or not a ship is currently being spawned. Used to prevent multiple ships from being spawned at once.
	var/ship_spawning //TODO: Make a proper queue for this

/datum/controller/subsystem/overmap/get_metrics()
	. = ..()
	var/list/cust = list()
	cust["overmap_objects"] = length(overmap_objects)
	cust["controlled_ships"] = length(controlled_ships)
	.["custom"] = cust


/datum/controller/subsystem/overmap/proc/create_new_star_system(datum/overmap_star_system/new_starsystem)
	//if(length(tracked_star_systems) >= 1)
	//	CRASH("Attempted to create more than 1 star system. Having mutiple star systems is not supported.")

	tracked_star_systems += new_starsystem
	return new_starsystem

/**
 * Creates an overmap object for shuttles, triggers initialization procs for ships
 */
/datum/controller/subsystem/overmap/Initialize(start_timeofday)
	overmap_objects = list()
	controlled_ships = list()
	outposts = list()
	dynamic_encounters = list()
	events = list()

	var/list/sector_types = pick(subtypesof(/datum/overmap_star_system/safezone) - /datum/overmap_star_system/safezone/json_example)

	if(fexists(SAFEZONE_OVERRIDE_FILEPATH))
		var/file_text = trim_right(file2text(SAFEZONE_OVERRIDE_FILEPATH)) // trim_right because there's often a trailing newline
		var/datum/overmap_star_system/safezone/potential_type = text2path(file_text)
		if(!potential_type || !ispath(potential_type, /datum/overmap_star_system/safezone))
			stack_trace("SSovermap found an safezone override file at [SAFEZONE_OVERRIDE_FILEPATH], but was unable to find the system type [potential_type]!")
		else
			sector_types = potential_type
		fdel(SAFEZONE_OVERRIDE_FILEPATH) // don't want it to affect 2 rounds in a row.

	safe_system = create_new_star_system(new sector_types)
	wild_system = create_new_star_system (new /datum/overmap_star_system/shiptest)

	//if jump locations arent setup, revert to the old system
	if(!safe_system.jump_spawnlocs)
		return ..()
	var/list/total_spawn_locations = list()
	var/list/location_to_use
	var/datum/overmap/jump_point/point_used

	for(var/list/jumppoint_spawnloc as anything in safe_system.jump_spawnlocs)
		total_spawn_locations += list(jumppoint_spawnloc)

	location_to_use = pick(total_spawn_locations)
	point_used = safe_system.create_jump_point_link(wild_system, location_to_use["dir"])
	point_used.overmap_move(location_to_use["x"], location_to_use["y"])

	safe_system.can_jump_to = FALSE
	wild_system.can_jump_to = FALSE
	return ..()

/datum/controller/subsystem/overmap/proc/spawn_new_star_system(datum/overmap_star_system/system_to_spawn=/datum/overmap_star_system)
	if(istype(system_to_spawn))
		return create_new_star_system(system_to_spawn)
	return create_new_star_system(new system_to_spawn)

/datum/controller/subsystem/overmap/fire()
	for(var/datum/overmap_star_system/current_system as anything in tracked_star_systems)
		if(!current_system.encounters_refresh)
			continue
		current_system.handle_dynamic_encounters()

	if(events_enabled)
		for(var/datum/overmap/event/E as anything in events)
			if(E.get_nearby_overmap_objects())
				E.apply_effect()
				if(MC_TICK_CHECK)
					return

/**
 * Gets the parent overmap object (e.g. the planet the atom is on) for a given atom.
 * * source - The object you want to get the corresponding parent overmap object for.
 */
/datum/controller/subsystem/overmap/proc/get_overmap_object_by_location(atom/source, exclude_ship = FALSE)
	var/turf/T = get_turf(source)
	var/area/ship/A = get_area(source)
	while(istype(A) && A.mobile_port && !exclude_ship)
		if(A.mobile_port.current_ship)
			return A.mobile_port.current_ship
		A = A.mobile_port.underlying_turf_area[T]
	for(var/datum/overmap/dynamic/our_dynamic as anything in overmap_objects)
		if(!istype(our_dynamic))
			continue
		if(our_dynamic.mapzone?.is_in_bounds(source))
			return our_dynamic
	for(var/datum/overmap/static_object/our_static as anything in overmap_objects)
		if(!istype(our_static))
			continue
		if(our_static.mapzone?.is_in_bounds(source))
			return our_static
	for(var/datum/overmap/outpost/our_outpost as anything in overmap_objects)
		if(!istype(our_outpost))
			continue
		if(our_outpost.mapzone?.is_in_bounds(source))
			return our_outpost

/datum/controller/subsystem/overmap/proc/get_main_outpost()
	if(!length(outposts))
		return "No outpost exists in this area of space."
	return outposts[1]

/datum/controller/subsystem/overmap/proc/get_main_outpost_coords()
	if(!length(outposts))
		return "No outpost exists in this area of space."
	return "[outposts[1]?:x]-[outposts[1]?:y]"

/datum/controller/subsystem/overmap/proc/ship_crew_percentage()
	var/ship_percentages = 0
	var/counted_ships = 0
	for(var/datum/overmap/ship/controlled/ship_datum in controlled_ships)
		var/slot_count = 0
		if(!ship_datum.source_template || ship_datum.source_template.category == "subshuttles")
			continue
		for(var/job_slot in ship_datum.source_template.job_slots)
			slot_count += ship_datum.source_template.job_slots[job_slot]
		if(!slot_count)
			continue
		ship_percentages += ((length(ship_datum.manifest) / slot_count) * 100)
		counted_ships++
	if(ship_percentages && counted_ships)
		return round(ship_percentages / counted_ships)
	return 0

/datum/controller/subsystem/overmap/proc/ship_locking_percentage()
	return round(clamp(clamp(((world.time - (CONFIG_GET(number/ship_locking_starts) MINUTES)) / (1 MINUTES)), 0, 25) + TRANSFER_FACTOR * 100, 0, 50))

/// Returns TRUE if players should be allowed to create a ship by "standard" means, and FALSE otherwise.
/datum/controller/subsystem/overmap/proc/player_ship_spawn_allowed()
	if(!(GLOB.ship_spawn_enabled) || (get_num_cap_ships() >= CONFIG_GET(number/max_shuttle_count)))
		return FALSE
	if((length(controlled_ships) > 2 && CONFIG_GET(flag/auto_ship_spawn_locking)) && ship_crew_percentage() < ship_locking_percentage())
		return FALSE
	return TRUE

/// Returns the number of ships on the overmap that count against the spawn cap.
/datum/controller/subsystem/overmap/proc/get_num_cap_ships()
	var/ship_count = 0
	for(var/datum/overmap/ship/controlled/Ship as anything in controlled_ships)
		if(!Ship.source_template || Ship.source_template.category != "subshuttles")
			ship_count++
	return ship_count

/datum/controller/subsystem/overmap/proc/get_fancy_manifest()
	var/list/manifest_out = list()
	for(var/datum/overmap/ship/controlled/ship as anything in controlled_ships)
		if(!length(ship.manifest))
			continue
		var/list/data = list()
		data["color"] = ship.source_template.faction.color
		data["mode"] = ship.join_mode
		for(var/crewmember in ship.manifest)
			var/datum/job/crewmember_job = ship.manifest[crewmember]
			data["crew"] += list(list(
				"name" = crewmember,
				"rank" = crewmember_job.name,
				"officer" = crewmember_job.officer
			))
		manifest_out["[ship.name] ([ship.source_template.short_name])"] = data

	return manifest_out

/datum/controller/subsystem/overmap/proc/get_manifest()
	var/list/manifest_out = list()
	for(var/datum/overmap/ship/controlled/ship as anything in controlled_ships)
		if(!length(ship.manifest))
			continue
		manifest_out["[ship.name] ([ship.source_template.short_name])"] = list()
		for(var/crewmember in ship.manifest)
			var/datum/job/crewmember_job = ship.manifest[crewmember]
			manifest_out["[ship.name] ([ship.source_template.short_name])"] += list(list(
				"name" = crewmember,
				"rank" = crewmember_job.name,
				"officer" = crewmember_job.officer
			))

	return manifest_out

/datum/controller/subsystem/overmap/proc/get_manifest_html(monochrome = FALSE)
	var/list/manifest = get_manifest()
	var/dat = {"
	<head><style>
		.manifest {border-collapse:collapse;}
		.manifest td, th {border:1px solid [monochrome ? "black":"#DEF; background-color:white; color:black"]; padding:.25em}
		.manifest th {height: 2em; [monochrome ? "border-top-width: 3px":"background-color: #48C; color:white"]}
		.manifest tr.head th { [monochrome ? "border-top-width: 1px":"background-color: #488;"] }
		.manifest tr.alt td {[monochrome ? "border-top-width: 2px":"background-color: #DEF"]}
	</style></head>
	<table class="manifest" width='350px'>
	<tr class='head'><th>Name</th><th>Rank</th></tr>
	"}
	for(var/department in manifest)
		var/list/entries = manifest[department]
		dat += "<tr><th colspan=3>[department]</th></tr>"
		var/even = FALSE
		for(var/entry in entries)
			var/list/entry_list = entry
			dat += "<tr[even ? " class='alt'" : ""]><td>[entry_list["name"]]</td><td>[entry_list["rank"]]</td></tr>"
			even = !even

	dat += "</table>"
	dat = replacetext(dat, "\n", "")
	dat = replacetext(dat, "\t", "")
	return dat

/datum/controller/subsystem/overmap/Recover()
	overmap_objects = SSovermap.overmap_objects
	controlled_ships = SSovermap.controlled_ships
	events = SSovermap.events
	dynamic_encounters = SSovermap.dynamic_encounters
	outposts = SSovermap.outposts
	tracked_star_systems = SSovermap.tracked_star_systems


/datum/controller/subsystem/overmap/proc/get_random_star_system()
	if(length(tracked_star_systems) >= 1) //if theres only one star system, why bother?
		return SSovermap.tracked_star_systems[1]
	else
		return SSovermap.tracked_star_systems[rand(1,length(tracked_star_systems))] //if there are more than one, grab one at random

/**
 * Spawns a controlled ship with the passed template at the template's preferred spawn location.
 * Inteded for ship purchases, etc.
 */
/datum/controller/subsystem/overmap/proc/spawn_ship_at_start(datum/map_template/shuttle/template, position, datum/overmap_star_system/system_to_spawn_in)
	//Should never happen, but just in case. This'll delay the next spawn until the current one is done.
	UNTIL(!ship_spawning)

	if(!istype(position, /datum/overmap))
		if(!system_to_spawn_in)
			ship_spawning = FALSE
			CRASH("Ship attemped to be spawned at coords but no star system specificed!")

	var/ship_loc = position
	var/datum/overmap/our_spawn_location = position
	if(our_spawn_location)
		system_to_spawn_in = our_spawn_location.current_overmap

	if(!ship_loc && template.space_spawn)
		ship_loc = null
	else
		ship_loc = SSovermap.outposts[1]

	ship_spawning = TRUE
	. = new /datum/overmap/ship/controlled(ship_loc, system_to_spawn_in, template) //This statement SHOULDN'T runtime (not counting runtimes actually in the constructor) so ship_spawning should always be toggled.
	ship_spawning = FALSE

/**
 * Gets the interference power of nearby overmap objects.
 * Inteded to get called by radios, but i'm sure you could use this for other things.
 */
/// Gets the interference power of nearby overmap objects.
/datum/controller/subsystem/overmap/proc/get_overmap_interference(atom/source)
	var/datum/overmap/our_overmap_object = get_overmap_object_by_location(source)
	var/interference_power = 0

	if(istype(our_overmap_object))
		interference_power += our_overmap_object.interference_power
		for(var/datum/overmap/nearby_obj as anything in our_overmap_object.get_nearby_overmap_objects(empty_if_src_docked = FALSE))
			if(!istype(nearby_obj))
				continue
			interference_power += nearby_obj.interference_power

		for(var/direction as anything in GLOB.cardinals)
			var/newcords = our_overmap_object.get_overmap_step(direction)
			for(var/datum/overmap/nearby_obj as anything in our_overmap_object.current_overmap.overmap_container[newcords["x"]][newcords["y"]])
				if(!istype(nearby_obj))
					continue
				interference_power += nearby_obj.interference_power / 8
		return max(interference_power,0)


/////////////////////////////////////////////////////////////////////
/////////////////         STAR SYSTEM DATUM         /////////////////
/////////////////////////////////////////////////////////////////////

/datum/overmap_star_system
	/// Name of the star system
	var/name
	/// Name of the star
	var/starname
	///Type of the star
	var/datum/overmap/star/startype

	///Defines which generator to use for the overmap
	var/generator_type
	///List of all overmap objects in the star system.
	var/list/overmap_objects = list()
	///List of all simulated ships in the star system.
	var/list/controlled_ships = list()
	///List of spawned outposts in the star system
	var/list/outposts = list()
	///List of all dynamic overmap datums in the star system.
	var/list/dynamic_encounters  = list()
	///List of all events in the star system.
	var/list/events = list()


	///The virtual level that contains the overmap
	var/datum/virtual_level/overmap_vlevel

	///The two-dimensional list that contains every single tile in the star system as a sublist.
	var/list/list/overmap_container

	///Map of tiles at each radius (represented by index) around the sun
	var/list/list/radius_positions
	///Map of tiles that can have jump points spawned there (represented by index)
	var/list/list/jump_spawnlocs
	///Width/height of the overmap "zlevel"
	var/size
	///The maximum amount of dynamic events that can spawn in this sector.
	var/max_overmap_dynamic_events
	///Do we have a outpost in this system?
	var/has_outpost = FALSE
	///The abliltiy for the system to automaticly spawn and despawn dynamic encounters
	var/encounters_refresh = FALSE
	/// Our faction of the outpost
	var/faction
	/// If generator_type is set to OVERMAP_GENERATOR_JSON, we load all overmap objects from this
	var/json

	///the list of dynamic planets that can spawn in this sector
	var/list/dynamic_probabilities

	//fancy color shit! yayyyyy!

	//main colors, used for dockable terrestrials, and background
	var/primary_color = "#D8D8D8"
	var/secondary_color = "#3a3f85"

	//hazard colors, used for the overmap hazards and sun
	var/hazard_primary_color = null //this should take the color of the sun if not defined, which we want for generic sectors
	var/hazard_secondary_color = "#9D96AD"

	//structure colors, used for ships and outposts/colonies
	var/primary_structure_color = "#FFFFFF"
	var/secondary_structure_color = "#FFFFFF"

	///the tileset we use, just the icon we force tokens to use, override only if nessary
	var/tileset = 'icons/misc/overmap.dmi'
	///This is the flag that makes it so all overmap objects use the same uniform color above. If false, tokens use their default colors
	var/override_object_colors = FALSE

	///the icon state for the overmap background. if using a bright background, use "overmap", if dark, "overmap_dark"
	var/overmap_icon_state = "overmap_dark"

	//Can players bluespace jump to this sector? Recommended to be FALSE if this is a punchcard or for some event
	var/can_jump_to = TRUE
	//can our pallete be selected randomly roundstart? set to no for subtypes or if you dont change the pallete
	var/can_be_selected_randomly = TRUE

	/// Datum type for the main outpost spawned here
	var/default_outpost_type

	COOLDOWN_DECLARE(dynamic_despawn_cooldown)

/datum/overmap_star_system/New(generate_now=TRUE)
	if(generate_now)
		setup_system()

/datum/overmap_star_system/proc/setup_system()
	//if this is a json, copy the invo before we do anything more
	if(generator_type == OVERMAP_GENERATOR_JSON)
		copy_system_info_from_json(json)

	if(!starname)
		starname = gen_star_name() //we reuse this for the name of the star if name isnt defined, like a uncharted sector or something
	if(!name)
		name = starname //we then give it here
	overmap_objects = list()
	controlled_ships = list()
	outposts = list()
	events = list()

	if(isnull(dynamic_probabilities))
		dynamic_probabilities = list()
		for(var/datum/planet_type/planet_type as anything in subtypesof(/datum/planet_type))
			dynamic_probabilities[initial(planet_type.planet)] = initial(planet_type.weight)

	if(!generator_type)
		generator_type = CONFIG_GET(string/overmap_generator_type)
	if(!size)
		size = CONFIG_GET(number/overmap_size)
	if(!max_overmap_dynamic_events)
		max_overmap_dynamic_events = isnull(max_overmap_dynamic_events)

	overmap_container = new/list(size, size, 0)

	var/encounter_name = name
	var/datum/map_zone/mapzone = SSmapping.create_map_zone(encounter_name)
	overmap_vlevel = SSmapping.create_virtual_level(encounter_name, list(), mapzone, size + MAP_EDGE_PAD * 2, size + MAP_EDGE_PAD * 2)
	overmap_vlevel.current_systen = src
	overmap_vlevel.reserve_margin(MAP_EDGE_PAD)
	overmap_vlevel.fill_in(/turf/open/overmap, /area/overmap)
	overmap_vlevel.selfloop()
	var/area/our_area = get_area(OVERMAP_TOKEN_TURF(1, 1, src))

	our_area.rename_area ("[our_area.name] ([name])")
	//before you ask, no, for some reason it doesnt add itself automatically
	if(!(our_area in GLOB.sortedAreas))
		GLOB.sortedAreas.Add(our_area)
		sortTim(GLOB.sortedAreas, /proc/cmp_name_asc)

	if (!generator_type) //TODO: maybe datumize these?
		generator_type = OVERMAP_GENERATOR_RANDOM

	if ((generator_type == OVERMAP_GENERATOR_SOLAR) || (generator_type == OVERMAP_GENERATOR_RANDOM))
		var/datum/overmap/star/center
		if(!startype)
			startype = pick(subtypesof(/datum/overmap/star))
		center = new startype(list("x" = round(size / 2 + 1), "y" = round(size / 2 + 1)), src)
		if(starname)
			center.name = starname
		radius_positions = list()
		for(var/x in 1 to size)
			for(var/y in 1 to size)
				radius_positions["[round(sqrt((x - center.x) ** 2 + (y - center.y) ** 2)) + 1]"] += list(list("x" = x, "y" = y))
		if(!hazard_primary_color)
			hazard_primary_color = center.get_rand_spectral_color(center.spectral_type, center.color_vary)
		else
			center.custom_color = FALSE
			center.spectral_type = hazard_primary_color
			center.alter_token_appearance()
	//meant for editing outpost maps on locals
	#ifndef FULL_INIT
	new /datum/overmap/mapping_helper/ez_export_button(list("x" = 1, "y" = 1), src)
	if(size > 1)
		new /datum/overmap/mapping_helper/ez_varedit_system(list("x" = 2, "y" = 1), src)
	#endif


	create_map()


/datum/overmap_star_system/Destroy(force, ...)
	//if we haven't even generated a map yet, don't freak out about it
	if(!overmap_container)
		return ..()
	if(!force)
		stack_trace("Something has attempted to delete a star system. THIS SHOULD NEVER HAPPEN. STACK TRACING TO SEE WHY THIS IS HAPPENING.")
		message_admins("<span class='danger'>Something has attempted to delete a star system. THIS SHOULD NEVER HAPPEN. STACK TRACING TO SEE WHY THIS IS HAPPENING. CHECK RUNTIMES.</span>")
		return QDEL_HINT_LETMELIVE
	stack_trace("Something has attempted to delete a star system but it was a force delete, so we are assuming it was inentional. This should still not happen reguardless, but cleaning up the system.")
	message_admins("<span class='danger'>Something has attempted to delete a star system but it was a force delete, so we are assuming it was inentional. This should still not happen reguardless, but cleaning up the system.</span>")
	SSovermap.tracked_star_systems -= src
	for(var/datum/thing_to_del as anything in overmap_objects)
		qdel(thing_to_del)
	return ..()


/datum/overmap_star_system/proc/gen_star_name()
	return "[pick(GLOB.star_names)] [pick(GLOB.greek_letters)]"

/**
 * The proc that creates all the objects on the overmap, split into seperate procs for redundancy.
 */
/datum/overmap_star_system/proc/create_map()
	switch(generator_type)
		if(OVERMAP_GENERATOR_SOLAR)
			spawn_events_in_orbits()
		if(OVERMAP_GENERATOR_RANDOM)
			spawn_events()
		if(OVERMAP_GENERATOR_JSON)
			import_from_json(json)

	spawn_ruin_levels()

	if(has_outpost)
		spawn_outpost()

/**
 * VERY Simple random generation for overmap events, spawns the event in a random turf and sometimes spreads it out similar to ores
 */
/datum/overmap_star_system/proc/spawn_events()
	var/max_clusters = CONFIG_GET(number/max_overmap_event_clusters)
	for(var/i in 1 to max_clusters)
		spawn_event_cluster(pick(subtypesof(/datum/overmap/event)), get_unused_overmap_square())

/datum/overmap_star_system/proc/spawn_events_in_orbits()
	var/list/orbits = list()
	for(var/i in 3 to length(radius_positions) / 2) // At least two away to prevent overlap
		orbits += "[i]"

	var/max_clusters = CONFIG_GET(number/max_overmap_event_clusters)
	for(var/i in 1 to max_clusters)
		if(CONFIG_GET(number/max_overmap_events) <= length(events))
			return
		if(!length(orbits))
			break // Can't fit any more in
		var/event_type = pick_weight(GLOB.overmap_event_pick_list)
		var/selected_orbit = pick(orbits)

		var/list/T = get_unused_overmap_square_in_radius(selected_orbit)
		if(!T)
			orbits -= "[selected_orbit]" // This orbit is full, move onto the next
			continue

		var/datum/overmap/event/E = new event_type(T, src)
		for(var/list/position as anything in radius_positions[selected_orbit])
			if(locate(/datum/overmap) in overmap_container[position["x"]][position["y"]])
				continue
			if(!prob(E.spread_chance))
				continue
			new event_type(position, src)

/**
 * Creates an overmap object for each ruin level, making them accessible.
 */
/datum/overmap_star_system/proc/spawn_ruin_levels()
	for(var/i in 1 to max_overmap_dynamic_events)
		spawn_ruin_level()


/datum/overmap_star_system/proc/spawn_ruin_level()
	new /datum/overmap/dynamic(system_spawned_in = src)

/**
 * See [/datum/controller/subsystem/overmap/proc/spawn_events], spawns "veins" (like ores) of events
 */
/datum/overmap_star_system/proc/spawn_event_cluster(datum/overmap/event/type, list/location, chance)
	if(CONFIG_GET(number/max_overmap_events) <= LAZYLEN(events))
		return
	var/datum/overmap/event/E = new type(location, src)
	if(!chance)
		chance = E.spread_chance
	for(var/dir in GLOB.cardinals)
		if(prob(chance))

			if(locate(/datum/overmap) in overmap_container[location["x"]][location["y"]])
				continue
			spawn_event_cluster(type, location, chance / 2)

/**
 * Creates a single outpost somewhere near the center of the system.
 */
/datum/overmap_star_system/proc/spawn_outpost()
	var/list/location = get_unused_overmap_square_in_radius(rand(4, round(size/5)))

	if(!default_outpost_type)
		var/list/possible_types = subtypesof(/datum/overmap/outpost)
		for(var/datum/overmap/outpost/outpost_type as anything in possible_types)
			if(!initial(outpost_type.main_template))
				possible_types -= outpost_type
		default_outpost_type = pick(possible_types)

	var/datum/overmap/outpost/our_outpost = new default_outpost_type(location, src)

	//gets rid of nearby events that casue radio interference
	for(var/direction as anything in GLOB.cardinals)
		var/newcords = our_outpost.get_overmap_step(direction)
		for(var/datum/overmap/event/nearby_event as anything in our_outpost.current_overmap.overmap_container[newcords["x"]][newcords["y"]])
			if(!istype(nearby_event))
				continue
			if(nearby_event.interference_power)
				qdel(nearby_event)
	return

/**
 * This is tangentily related to dynmaic missions, its doing the same despawn thing you added for overmap events. Its meant to cycle out planets very slowly.
 */
/datum/overmap_star_system/proc/handle_dynamic_encounters()
	if(length(dynamic_encounters) < max_overmap_dynamic_events)
		spawn_ruin_level()
	if(COOLDOWN_FINISHED(src, dynamic_despawn_cooldown))
		//need to make this have a weight for older planets at some point soon
		var/datum/overmap/dynamic/picked_encounter = pick(dynamic_encounters)
		if(picked_encounter)
			//If we manage to start a countdown, 5 minute timer, else, try again in a minute.
			//Cant run this first section of the fire too hot as we still need MC_TICK_CHECK to not run out for events.
			//This should probally moved to its own fire or just otherwise handled better.
			if(picked_encounter.start_countdown(10 MINUTES, secondary_structure_color))
				COOLDOWN_START(src, dynamic_despawn_cooldown, 5 MINUTES)
			else
				COOLDOWN_START(src, dynamic_despawn_cooldown, 1 MINUTES)

/**
 * Reserves a square dynamic encounter area, generates it, and spawns a ruin in it if one is supplied.
 * * on_planet - If the encounter should be on a generated planet. Required, as it will be otherwise inaccessible.
 * * ruin_type - The type of ruin to spawn, or null if none should be placed.
 */
/datum/overmap_star_system/proc/spawn_dynamic_encounter(datum/overmap/dynamic/dynamic_datum, ruin_type)
	log_shuttle("SSOVERMAP: SPAWNING DYNAMIC ENCOUNTER STARTED")
	if(!dynamic_datum)
		CRASH("spawn_dynamic_encounter called without any datum to spawn!")
	if(!dynamic_datum.default_baseturf)
		CRASH("spawn_dynamic_encounter called with overmap datum [REF(dynamic_datum)], which lacks a default_baseturf!")

	var/datum/map_generator/mapgen = new dynamic_datum.mapgen
	var/datum/map_template/ruin/used_ruin = ispath(ruin_type) ? (new ruin_type) : ruin_type
	SSblackbox.record_feedback("tally", "encounter_spawned", 1, "[dynamic_datum.mapgen]")

	// name is random but PROBABLY unique
	var/encounter_name = dynamic_datum.planet_name || "\improper Uncharted Space [dynamic_datum.x]/[dynamic_datum.y]-[rand(1111, 9999)]"
	var/datum/map_zone/mapzone = SSmapping.create_map_zone(encounter_name)
	var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(
		encounter_name,
		list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = dynamic_datum.default_baseturf, ZTRAIT_GRAVITY = dynamic_datum.gravity),
		mapzone,
		dynamic_datum.vlevel_width,
		dynamic_datum.vlevel_height,
		ALLOCATION_QUADRANT,
		QUADRANT_MAP_SIZE
	)

	vlevel.reserve_margin(QUADRANT_SIZE_BORDER)

	mapgen.pre_generation(dynamic_datum)

	// the generataed turfs start unpopulated (i.e. no flora / fauna / etc.). we add that AFTER placing the ruin, relying on the ruin's areas to determine what gets populated
	log_shuttle("SSOVERMAP: START_DYN_E: RUNNING MAPGEN REF [REF(mapgen)] FOR VLEV [vlevel.id] OF TYPE [mapgen.type]")
	mapgen.generate_turfs(vlevel.get_unreserved_block())

	var/list/ruin_turfs = list()
	var/list/ruin_templates = list()
	if(used_ruin)
		var/turf/ruin_turf = locate(
			rand(
				vlevel.low_x+6 + vlevel.reserved_margin,
				vlevel.high_x-used_ruin.width-6 - vlevel.reserved_margin
			),
			vlevel.high_y-used_ruin.height-6 - vlevel.reserved_margin,
			vlevel.z_value
		)
		used_ruin.load(ruin_turf)
		ruin_turfs[used_ruin.name] = ruin_turf
		ruin_templates[used_ruin.name] = used_ruin

	// fill in the turfs, AFTER generating the ruin. this prevents them from generating within the ruin
	// and ALSO prevents the ruin from being spaced when it spawns in
	// WITHOUT needing to fill the reservation with a bunch of dummy turfs
	if(dynamic_datum.populate_turfs)
		mapgen.populate_turfs(vlevel.get_unreserved_block())

	///post generation things, such as greebles or smoothening out terrain generation.
	mapgen.post_generation(vlevel.get_unreserved_block())

	if(dynamic_datum.weather_controller_type)
		new dynamic_datum.weather_controller_type(mapzone)

	var/list/areas_to_update = get_areas(/area/overmap_encounter/planetoid)
	for(var/area/overmap_encounter/planetoid as anything in areas_to_update)
		if(mapzone.is_in_bounds(planetoid))
			planetoid.update_light()


	// locates the first dock in the bottom left, accounting for padding and the border
	var/turf/primary_docking_turf = locate(
		vlevel.low_x+RESERVE_DOCK_DEFAULT_PADDING + vlevel.reserved_margin,
		vlevel.low_y+RESERVE_DOCK_DEFAULT_PADDING + vlevel.reserved_margin,
		vlevel.z_value
		)
	// now we need to offset to account for the first dock
	var/turf/secondary_docking_turf = locate(
		primary_docking_turf.x+RESERVE_DOCK_MAX_SIZE_LONG+RESERVE_DOCK_DEFAULT_PADDING,
		primary_docking_turf.y,
		primary_docking_turf.z
		)

	var/list/docking_ports = list()

	var/obj/docking_port/stationary/primary_dock = new(primary_docking_turf)
	primary_dock.dir = NORTH
	primary_dock.name = "[encounter_name] docking location #1"
	primary_dock.height = RESERVE_DOCK_MAX_SIZE_SHORT
	primary_dock.width = RESERVE_DOCK_MAX_SIZE_LONG
	primary_dock.dheight = 0
	primary_dock.dwidth = 0
	primary_dock.adjust_dock_for_landing = TRUE
	docking_ports += primary_dock

	var/obj/docking_port/stationary/secondary_dock = new(secondary_docking_turf)
	secondary_dock.dir = NORTH
	secondary_dock.name = "[encounter_name] docking location #2"
	secondary_dock.height = RESERVE_DOCK_MAX_SIZE_SHORT
	secondary_dock.width = RESERVE_DOCK_MAX_SIZE_LONG
	secondary_dock.dheight = 0
	secondary_dock.dwidth = 0
	secondary_dock.adjust_dock_for_landing = TRUE
	docking_ports += secondary_dock

	if(!used_ruin)
		// no ruin, so we can make more docks upward
		var/turf/tertiary_docking_turf = locate(
			primary_docking_turf.x,
			primary_docking_turf.y+RESERVE_DOCK_MAX_SIZE_SHORT+RESERVE_DOCK_DEFAULT_PADDING,
			primary_docking_turf.z
		)
		// rinse and repeat
		var/turf/quaternary_docking_turf = locate(
			secondary_docking_turf.x,
			secondary_docking_turf.y+RESERVE_DOCK_MAX_SIZE_SHORT+RESERVE_DOCK_DEFAULT_PADDING,
			secondary_docking_turf.z
		)

		var/obj/docking_port/stationary/tertiary_dock = new(tertiary_docking_turf)
		tertiary_dock.dir = NORTH
		tertiary_dock.name = "[encounter_name] docking location #3"
		tertiary_dock.height = RESERVE_DOCK_MAX_SIZE_SHORT
		tertiary_dock.width = RESERVE_DOCK_MAX_SIZE_LONG
		tertiary_dock.dheight = 0
		tertiary_dock.dwidth = 0
		tertiary_dock.adjust_dock_for_landing = TRUE
		docking_ports += tertiary_dock

		var/obj/docking_port/stationary/quaternary_dock = new(quaternary_docking_turf)
		quaternary_dock.dir = NORTH
		quaternary_dock.name = "[encounter_name] docking location #4"
		quaternary_dock.height = RESERVE_DOCK_MAX_SIZE_SHORT
		quaternary_dock.width = RESERVE_DOCK_MAX_SIZE_LONG
		quaternary_dock.dheight = 0
		quaternary_dock.dwidth = 0
		quaternary_dock.adjust_dock_for_landing = TRUE
		docking_ports += quaternary_dock

	else // we've spawned a ruin and are now checking for any docks that it has
		for(var/obj/docking_port/stationary/port as obj in SSshuttle.stationary)
			if(port.virtual_z() == vlevel.id)
				if(port in docking_ports)
					continue
				docking_ports += port


	return list(mapzone, docking_ports, ruin_turfs, ruin_templates)

/**
 * Reserves a square dynamic encounter area then loads a map.
 * * on_planet - If the encounter should be on a generated planet. Required, as it will be otherwise inaccessible.
 * * ruin_type - The type of ruin to spawn, or null if none should be placed.
 */
/datum/overmap_star_system/proc/spawn_static_encounter(datum/overmap/static_object/static_datum, map)
	log_shuttle("SSOVERMAP: SPAWNING STATIC ENCOUNTER STARTED")
	if(!static_datum)
		CRASH("spawn_static_encounter called without any datum to spawn!")
	if(!static_datum.default_baseturf)
		CRASH("spawn_static_encounter called with overmap datum [REF(static_datum)], which lacks a default_baseturf!")
	if(!map)
		CRASH("spawn_static_encounter called with overmap datum [REF(static_datum)], which lacks any map_to_load!")

	var/use_mapgen = FALSE
	if(static_datum.mapgen)
		use_mapgen = TRUE
	var/datum/map_template/map_to_load = ispath(map) ? (new map) : map
	var/datum/map_zone/mapzone
	var/datum/virtual_level/vlevel

	if(static_datum.load_seperate_z)
		mapzone = map_to_load.load_new_z()
		vlevel = mapzone.virtual_levels[1]
	else
		// name is random but PROBABLY unique
		var/encounter_name = static_datum.planet_name || "\improper Uncharted Space [static_datum.x]/[static_datum.y]-[rand(1111, 9999)]"
		mapzone = SSmapping.create_map_zone(encounter_name)
		vlevel = SSmapping.create_virtual_level(
			encounter_name,
			list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = static_datum.default_baseturf, ZTRAIT_GRAVITY = static_datum.gravity),
			mapzone,
			map_to_load.width,
			map_to_load.height,
			ALLOCATION_QUADRANT,
			QUADRANT_MAP_SIZE
		)

	vlevel.reserve_margin(static_datum.border_size)

	var/datum/map_generator/mapgen

	//if we even use mapgen, do mapgen things, otherwise just load the god damn map
	if(use_mapgen)
		mapgen = new static_datum.mapgen
		mapgen.pre_generation(static_datum)
		log_shuttle("SSOVERMAP: START_STATIC_E: RUNNING MAPGEN REF [REF(mapgen)] FOR VLEV [vlevel.id] OF TYPE [mapgen.type]")
		mapgen.generate_turfs(vlevel.get_unreserved_block())

	var/turf/spawn_turf = locate(vlevel.low_x,vlevel.low_y,vlevel.z_value)
	map_to_load.load(spawn_turf)

	if(use_mapgen)
		mapgen.populate_turfs(vlevel.get_unreserved_block())

	if(static_datum.weather_controller_type)
		new static_datum.weather_controller_type(mapzone)

	var/list/docking_ports = list()

	for(var/obj/docking_port/stationary/port as obj in SSshuttle.stationary)
		if(port.virtual_z() == vlevel.id)
			docking_ports += port

	return list(mapzone, docking_ports)


/datum/overmap_star_system/proc/overmap_container_view(user = usr) //this is broken rn, idfk know html viewers works
	if(!overmap_container)
		return
	. += "<a href='byond://?src=[REF(src)];refresh=1'>\[Refresh\]</a><br><code>"
	for(var/y in size to 1 step -1)
		for(var/x in 1 to size)
			var/tile
			var/thing_to_link
			if(length(overmap_container[x][y]) > 1)
				tile = length(overmap_container[x][y])
				thing_to_link = overmap_container[x][y]
			else if(length(overmap_container[x][y]) == 1)
				var/datum/overmap/overmap_thing = overmap_container[x][y][1]
				tile = overmap_thing.char_rep || "o" //fall back to "o" if no char_rep
				thing_to_link = overmap_thing
			else
				tile = "."
				thing_to_link = overmap_container[x][y]
			. += "<a href='byond://?src=[REF(src)];view_object=[REF(thing_to_link)]' title='[x]x, [y]y'>[add_leading(add_trailing(tile, 2), 3)]</a>" //"centers" the character
		. += "<br>"
		CHECK_TICK
	. += "</code>"
	var/datum/browser/popup = new(usr, "overmap_viewer", "Overmap Viewer", 850, 700)
	popup.set_content(.)
	popup.open()

/datum/overmap_star_system/Topic(href, href_list[])
	. = ..()
	if(!check_rights(R_DEBUG))
		return
	var/mob/user = usr
	if(href_list["refresh"])
		overmap_container_view(user)
	if(href_list["view_object"])
		var/target = locate(href_list["view_object"])
		user.client.debug_variables(target)

/**
 * Returns a random, usually empty turf in the overmap
 * * thing_to_not_have - The thing you don't want to be in the found tile, for example, an overmap event [/datum/overmap/event].
 * * tries - How many attempts it will try before giving up finding an unused tile.
 */
/datum/overmap_star_system/proc/get_unused_overmap_square(thing_to_not_have = /datum/overmap, tries = MAX_OVERMAP_PLACEMENT_ATTEMPTS, force = FALSE)
	for(var/i in 1 to tries)
		. = list("x" = rand(1, size), "y" = rand(1, size))
		if(locate(thing_to_not_have) in overmap_container[.["x"]][.["y"]])
			continue
		return

	if(!force)
		. = null

/**
 * Returns a random turf in a radius from the star, or a random empty turf if OVERMAP_GENERATOR_RANDOM is the active generator.
 * * thing_to_not_have - The thing you don't want to be in the found tile, for example, an overmap event [/datum/overmap/event].
 * * tries - How many attempts it will try before giving up finding an unused tile..
 * * radius - The distance from the star to search for an empty tile.
 */
/datum/overmap_star_system/proc/get_unused_overmap_square_in_radius(radius, thing_to_not_have = /datum/overmap, tries = MAX_OVERMAP_PLACEMENT_ATTEMPTS, force = FALSE)
	if(!radius)
		radius = "[rand(3, length(radius_positions) / 2)]"
	if(isnum(radius))
		radius = "[radius]"

	for(var/i in 1 to tries)
		. = pick(radius_positions[radius])
		if(locate(thing_to_not_have) in overmap_container[.["x"]][.["y"]])
			continue
		return // returns . for those who don't know

	if(!force)
		. = null

/**
 * Edits a token after it's updated by alter_token_appearance(). Meant for visual effects
 * * token_to_edit - The overmap object we're editing [/datum/overmap/event].
 */
/datum/overmap_star_system/proc/post_edit_token_state(datum/overmap/datum_to_edit)
	datum_to_edit.token.remove_filter("gloweffect")
	return

/**
 * Updates everything in the system's token state
 * Useful for events!
 */
/datum/overmap_star_system/proc/update_all_colors()
	for(var/datum/overmap/current_object as anything in overmap_objects)
		current_object.alter_token_appearance()

/**
 * Creates 2 jump points to link an overmap to another one "naturally"
 * * destination_system - The destination system we want to connect us to [/datum/overmap_star_system].
 * * point_direction - The direction we spawn the jump point spawn in. In the target system we make one in the opposite direction.
 */
//Returns the jump point in our system
/datum/overmap_star_system/proc/create_jump_point_link(datum/overmap_star_system/destination_system, point_direction)
	var/datum/overmap/jump_point/point2 = new(destination_system.get_overmap_edge(REVERSE_DIR(point_direction)), destination_system)
	point2.dir = REVERSE_DIR(point_direction)
	var/datum/overmap/jump_point/point1 = new(get_overmap_edge(point_direction), src, point2)
	point1.dir = point_direction
	point1.alter_token_appearance()
	point2.alter_token_appearance()
	return point1

/**
 * Gets the edge of a star system
 * * dir - The direction we are getting the edge from.
 */
//Returns the jump point in our system
/datum/overmap_star_system/proc/get_overmap_edge(dir)
	var/center_coords = round(size / 2 + 1)

	var/edge_x = center_coords
	var/edge_y = center_coords

	if(dir & NORTH)
		edge_y = round(size - size/15)
	else if(dir & SOUTH)
		edge_y = round(size/15 + 2)
	if(dir & EAST)
		edge_x = round(size - size/15)
	else if(dir & WEST)
		edge_x = round(size/15 + 2)

	if(edge_x > size) // I don't know how to do this better atm
		edge_x = size
	if(edge_y > size)
		edge_y = size


	if(edge_x <= 0) // I don't know how to do this better atm
		edge_x = size
	if(edge_y <= 0)
		edge_y = size


	return list("x" = edge_x, "y" = edge_y)

//exports current star system to json, meant to load with
/datum/overmap_star_system/proc/export_to_json(user)
	if(user)
		usr = user
	//Step 1: Get the data
	var/list/file_data = list()
	file_data["system_info"] =  list()
	file_data["objects"] =  list()

	var/list/system_data = file_data["system_info"]
	var/list/objects_data = file_data["objects"]

	system_data["name"] = name
	system_data["starname"] = starname
	system_data["startype"] = startype
	system_data["size"] = size
	system_data["max_overmap_dynamic_events"] = max_overmap_dynamic_events
	system_data["faction"] = faction
	system_data["dynamic_probabilities"] = dynamic_probabilities
	system_data["can_jump_to"] = can_jump_to

	//overmap color stuff
	system_data["override_object_colors"] = override_object_colors

	system_data["primary_color"] = primary_color
	system_data["secondary_color"] = secondary_color
	system_data["hazard_primary_color"] = hazard_primary_color
	system_data["hazard_secondary_color"] = hazard_secondary_color
	system_data["primary_structure_color"] = primary_structure_color
	system_data["secondary_structure_color"] = secondary_structure_color

	system_data["overmap_icon_state"] = overmap_icon_state


	for(var/datum/overmap/current_object as anything in overmap_objects)
		var/count = (objects_data.len + 1)
		//dont save limited lifetime events
		if(current_object.death_time)
			continue
		//if X or Y = null, dont save
		if(!current_object.x || !current_object.y)
			continue
		//ignore ships, unless they are non-player ships
		if(istype(current_object, /datum/overmap/ship/controlled))
			continue
		//prooobably dont save this either...
		if(istype(current_object, /datum/overmap/jump_point))
			continue
		//especially not this
		if(istype(current_object, /datum/overmap/mapping_helper/ez_export_button))
			continue
		//and this
		if(istype(current_object, /datum/overmap/mapping_helper/ez_varedit_system))
			continue
		objects_data["[current_object.type]_[count]"] = list()
		var/list/current_data = objects_data["[current_object.type]_[count]"]
		current_data["type"] = current_object.type

		//if we arent an hazard and worth saving the name of, save the name and desc
		if(istype(current_object, /datum/overmap/dynamic) \
		|| istype(current_object, /datum/overmap/outpost) \
		|| istype(current_object, /datum/overmap/static_object)\
		|| istype(current_object, /datum/overmap/fluff)\
		|| istype(current_object, /datum/overmap/star)\
		)
			if(current_object.name != current_object::name)
				current_data["name"] = current_object.name
			if(current_object.desc != current_object::desc)
				current_data["desc"] = current_object.desc
			if(current_object.interference_power != current_object::interference_power)
				current_data["interference_power"] = current_object.interference_power

		//custom handling for star
		if(istype(current_object, /datum/overmap/star))
			var/datum/overmap/star/current_star = current_object
			current_data["custom_color"] = current_star.custom_color

		//custom handling for the jump point helper
		if(istype(current_object, /datum/overmap/mapping_helper/wild_sector_jumppoint_helper))
			var/datum/overmap/mapping_helper/wild_sector_jumppoint_helper/current_helper = current_object
			current_data["dir"] = current_helper.dir

		//custom handling for customizable/fluff objects
		if(istype(current_object, /datum/overmap/fluff))
			var/datum/overmap/fluff/current_fluff = current_object
			//if edited, absolutely save these vars
			if(current_fluff.token_icon_state != current_fluff::token_icon_state)
				current_data["token_icon_state"] = current_fluff.token_icon_state
			if(current_fluff.overmap_color_type != current_fluff::overmap_color_type)
				current_data["overmap_color_type"] = current_fluff.overmap_color_type
			if(current_fluff.default_color != current_fluff::default_color)
				current_data["default_color"] = current_fluff.default_color
			if(current_fluff.docking_message != current_fluff::docking_message)
				current_data["docking_message"] = current_fluff.docking_message
			if(current_fluff.dir)
				current_data["dir"] = current_fluff.dir

		//custom handling for dynamic events
		if(istype(current_object, /datum/overmap/dynamic))
			var/datum/overmap/dynamic/current_dynamic = current_object
			current_data["force_encounter"] = current_dynamic.force_encounter ? current_dynamic.force_encounter : current_dynamic.planet.type
			current_data["preserve_level"] = current_dynamic.preserve_level
			current_data["planet_name"] = current_dynamic.planet_name
			current_data["selected_ruin"] = current_dynamic.selected_ruin

		//custom handling for static events
		if(istype(current_object, /datum/overmap/static_object))
			var/datum/overmap/static_object/current_static = current_object
			current_data["mapgen"] = current_static.mapgen
			current_data["preserve_level"] = current_static.preserve_level
			current_data["planet_name"] = current_static.planet_name
			current_data["token_icon_state"] = current_static.token_icon_state
			current_data["gravity"] = current_static.gravity
			current_data["weather_controller_type"] = current_static.weather_controller_type
			current_data["default_baseturf "] = current_static.default_baseturf
			current_data["border_size"] = current_static.border_size
			current_data["landing_sound"] = current_static.landing_sound

		current_data["x"] = current_object.x
		current_data["y"] = current_object.y

	//Step 2: Write the data to a file
	var/json_file = file("data/exported-starsystem.json")
	if(fexists(json_file))
		fdel(json_file)
	WRITE_FILE(json_file, json_encode(file_data, JSON_PRETTY_PRINT))
	message_admins("Wrote star system data to [json_file]")

	//Step 3: Give the file to client for download
	usr << ftp(json_file)

	//Step 4: Remove the file from the server (hopefully we can find a way to avoid step)
	fdel(json_file)
	alert("Star system saved successfully.", "Action Successful!", "Ok")

/datum/overmap_star_system/proc/copy_system_info_from_json(json_file)
	if(!json_file && !islist(json_file))
		if(!fexists(json_file))
			log_game("The json map path \"[json_file]\" attempted to load, but no such file exists!")
			stack_trace("The json map path \"[json_file]\" attempted to load, but no such file exists!")
			return

	if(!json_file)
		return

	var/list/file_data = json_decode(file2text(json_file))
	var/list/system_data = file_data["system_info"]


	// apply the sector parameters data
	name = system_data["name"]
	starname = system_data["starname"]
	startype = system_data["startype"]
	size = system_data["size"]
	max_overmap_dynamic_events = system_data["max_overmap_dynamic_events"]
	faction = system_data["faction"]
	dynamic_probabilities = system_data["dynamic_probabilities"]
	can_jump_to = system_data["can_jump_to"]

	//overmap color stuff
	override_object_colors = system_data["override_object_colors"]

	primary_color = system_data["primary_color"]
	secondary_color = system_data["secondary_color"]
	hazard_primary_color = system_data["hazard_primary_color"]
	hazard_secondary_color = system_data["hazard_secondary_color"]
	primary_structure_color = system_data["primary_structure_color"]
	secondary_structure_color = system_data["secondary_structure_color"]

	overmap_icon_state = system_data["overmap_icon_state"]

/datum/overmap_star_system/proc/import_from_json(json_file)

	if(!json_file && !islist(json_file))
		if(!fexists(json_file))
			log_game("The json map path \"[json_file]\" attempted to load, but no such file exists!")
			return

	if(!json_file)
		return

	var/list/file_data = json_decode(file2text(json_file))
	var/list/objects_data = file_data["objects"]

	for(var/current_object as anything in objects_data)

		var/datum/overmap/obj_typepath

		var/list/current_data = objects_data["[current_object]"]
		var/list/coords = list("x" = current_data["x"], "y" = current_data["y"])
		if(!current_data["x"] || !current_data["y"])
			continue

		obj_typepath = current_data["type"]

		var/datum/overmap/new_obj = new obj_typepath(coords, src)

		//custom handling for star
		if(istype(new_obj, /datum/overmap/star))
			var/datum/overmap/star/current_star = new_obj
			current_star.custom_color = current_data["custom_color"]

		//custom handling for the jump point helper
		if(istype(new_obj, /datum/overmap/mapping_helper/wild_sector_jumppoint_helper))
			var/datum/overmap/mapping_helper/wild_sector_jumppoint_helper/current_helper = new_obj
			current_helper.dir = current_data["dir"]
			current_helper.token.setDir(current_data["dir"])

		//custom handling for customizable/fluff objects
		if(istype(new_obj, /datum/overmap/fluff))
			var/datum/overmap/fluff/current_fluff = new_obj
			if(current_data["token_icon_state"])
				current_fluff.token_icon_state = current_data["token_icon_state"]
			if(current_data["overmap_color_type"])
				current_fluff.overmap_color_type = current_data["overmap_color_type"]
			if(current_data["default_color"])
				current_fluff.default_color = current_data["default_color"]
			if(current_data["docking_message"])
				current_fluff.docking_message = current_data["docking_message"]
			if(current_data["dir"])
				current_fluff.dir = current_data["dir"]
				current_fluff.token.setDir(current_data["dir"])

		//custom handling for dynamic events
		if(istype(new_obj, /datum/overmap/dynamic))
			var/datum/overmap/dynamic/current_dynamic = new_obj
			if(current_data["force_encounter"])
				current_dynamic.force_encounter = text2path(current_data["force_encounter"])
			current_dynamic.preserve_level = current_data["preserve_level"]
			current_dynamic.planet_name = current_data["planet_name"]
			current_dynamic.selected_ruin = current_data["selected_ruin"]
			current_dynamic.choose_level_type()

		//custom handling for static events
		if(istype(new_obj, /datum/overmap/static_object))
			var/datum/overmap/static_object/current_static = new_obj
			current_static.mapgen = current_data["mapgen"]
			current_static.preserve_level = current_data["preserve_level"]
			current_static.planet_name = current_data["planet_name"]
			current_static.token_icon_state = current_data["token_icon_state"]
			current_static.gravity = current_data["gravity"]
			current_static.weather_controller_type = current_data["weather_controller_type"]
			current_static.default_baseturf = current_data["default_baseturf "]
			current_static.border_size = current_data["border_size"]
			current_static.landing_sound = current_data["landing_sound"]

		//load names and desc, if any
		if(current_data["name"])
			new_obj.name = current_data["name"]
		if(current_data["desc"])
			new_obj.desc = current_data["desc"]
		if(current_data["interference_power"])
			new_obj.interference_power = current_data["interference_power"]

		new_obj.alter_token_appearance()

	//https://github.com/BeeStation/NSV13/blob/5f66318e4560efa01ac839b48e9e9929f52d7275/nsv13/code/controllers/subsystem/starsystem.dm#L140
	//https://github.com/tgstation/tgstation/blob/d7eada0ebcf4ad37dca2283b201823e47a154fb5/code/modules/mob/living/basic/pets/parrot/poly.dm#L130


//meant to be a duplicate of default to be selectable in the spawn menu
/datum/overmap_star_system/wilderness
	can_be_selected_randomly = FALSE

/datum/overmap_star_system/oldcolors
	override_object_colors = TRUE
	can_be_selected_randomly = FALSE

/datum/overmap_star_system/oldgen //wouldnt it be funny to have this generate sometimes just for shits and giggles
	generator_type = OVERMAP_GENERATOR_RANDOM
	can_be_selected_randomly = FALSE

//default shiptest overmap
/datum/overmap_star_system/shiptest
	has_outpost = FALSE
	can_be_selected_randomly = FALSE
	encounters_refresh = TRUE

/datum/overmap_star_system/shiptest/create_map()
	max_overmap_dynamic_events = CONFIG_GET(number/max_overmap_dynamic_events)
	. = ..()

/datum/overmap_star_system/admin_sandbox
	name = "Admin Sandbox"
	size = 20
	can_be_selected_randomly = FALSE
	can_jump_to = FALSE
	generator_type = OVERMAP_GENERATOR_NONE

/datum/overmap_star_system/admin_sandbox/create_map()
	new /datum/overmap/sandbox_instructions(list("x" = round(size / 2 + 1), "y" = round(size / 2 + 1)), src)

/datum/overmap/sandbox_instructions
	name = "Admin Sandbox"
	token_icon_state = "sandbox"

/datum/overmap/sandbox_instructions/Initialize(position, datum/overmap_star_system/system_spawned_in, ...)
	. = ..()
	alter_token_appearance()

/datum/overmap/sandbox_instructions/alter_token_appearance()
	desc = {"
	[span_boldnotice("Welcome to the admin sandbox!")]
	This will ONLY appear for the duration of the testmerge so admins can play with their new tools without torturing players. Too much.
	No, players can't visit here. Unless you throw them here, mwahahahaa.\n
	The buildmode (F7) tools are:
	The [span_notice("(//) --> OVERMAP")] tool is to move overmap objects.
	The [span_notice("MODIF. OVERMAP")] tool is similar in usuage to BUILD ADV but to manipulate the overmap only.
	"}
	return ..()

//not meant to be seen normally: this shows the eventing/storytelling potential of json overmaps
//while unable to add sectors to punchards yet, this could be a good sample punchcard map, not in the main overmap but in its own enviroment
/datum/overmap_star_system/sunset_example
	name = "Abandoned - New Dawn"
	can_be_selected_randomly = FALSE
	can_jump_to = FALSE
	json = '_maps/sectors/sunset_starsystem.json'
	generator_type = OVERMAP_GENERATOR_JSON
