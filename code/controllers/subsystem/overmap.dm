SUBSYSTEM_DEF(overmap)
	name = "Overmap"
	wait = 10
	init_order = INIT_ORDER_OVERMAP
	flags = SS_KEEP_TIMING|SS_NO_TICK_CHECK
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	///Defines which generator to use for the overmap
	var/generator_type = OVERMAP_GENERATOR_RANDOM

	/// All the existing star systems, it's gonna be atleast 1 including the main system
	var/list/tracked_star_systems = list()

	///List of all overmap objects.
	var/list/overmap_objects = list()
	///List of all simulated ships. All ships in this list are fully initialized.
	var/list/controlled_ships = list()
	///List of spawned outposts. The default spawn location is the first index.
	var/list/outposts = list()
	///List of all events
	var/list/events = list()

	/// The mandatory and default star system
	var/datum/overmap_star_system/default_system

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

	if(length(tracked_star_systems) >= 1)
		WARNING("Attempted to create more than 1 star system. Bugs may occur as this isn't very well supported, you have been warned")
	tracked_star_systems += new_starsystem
	return new_starsystem

/**
 * Creates an overmap object for shuttles, triggers initialization procs for ships
 */
/datum/controller/subsystem/overmap/Initialize(start_timeofday)
	overmap_objects = list()
	controlled_ships = list()
	outposts = list()
	events = list()

	default_system = create_new_star_system(new /datum/overmap_star_system/outposted)

	return ..()

/datum/controller/subsystem/overmap/proc/spawn_new_star_system(datum/overmap_star_system/system_to_spawn=/datum/overmap_star_system)
	return create_new_star_system(new system_to_spawn)

/datum/controller/subsystem/overmap/fire()
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
	for(var/O in overmap_objects)
		if(istype(O, /datum/overmap/dynamic))
			var/datum/overmap/dynamic/D = O
			if(D.mapzone?.is_in_bounds(source))
				return D

/// Returns TRUE if players should be allowed to create a ship by "standard" means, and FALSE otherwise.
/datum/controller/subsystem/overmap/proc/player_ship_spawn_allowed()
	if(!(GLOB.ship_spawn_enabled) || (get_num_cap_ships() >= CONFIG_GET(number/max_shuttle_count)))
		return FALSE
	return TRUE

/// Returns the number of ships on the overmap that count against the spawn cap.
/datum/controller/subsystem/overmap/proc/get_num_cap_ships()
	var/ship_count = 0
	for(var/datum/overmap/ship/controlled/Ship as anything in controlled_ships)
		if(!Ship.source_template || Ship.source_template.category != "subshuttles")
			ship_count++
	return ship_count

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
	outposts = SSovermap.outposts


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


/////////////////////////////////////////////////////////////////////
/////////////////           OVERMAP DATUM           /////////////////
/////////////////////////////////////////////////////////////////////

/datum/overmap_star_system
	/// Name of the star system
	var/name
	/// It's x coordinate in the galaxy
	var/star_x = 0
	/// It's y coordinate in the galaxy
	var/star_y = 0

	///Defines which generator to use for the overmap
	var/generator_type
	///List of all overmap objects in the star system.
	var/list/overmap_objects = list()
	///List of all simulated ships in the star system.
	var/list/controlled_ships = list()
	///List of spawned outposts in the star system
	var/list/outposts = list()
	///List of all events in the star system.
	var/list/events = list()

	///The virtual level that contains the overmap
	var/datum/virtual_level/overmap_vlevel

	///The two-dimensional list that contains every single tile in the star system as a sublist.
	var/list/list/overmap_container

	///Map of tiles at each radius (represented by index) around the sun
	var/list/list/radius_positions
	///Width/height of the overmap "zlevel"
	var/size
	///Do we have a outpost in this system?
	var/has_outpost = TRUE //TODO SET TO FALSE, ITS ONLY SET TO TRUE FOR TESTING

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

/datum/overmap_star_system/wilderness
	name = null
	has_outpost = FALSE

/datum/overmap_star_system/wilderness/oldgen
	generator_type = OVERMAP_GENERATOR_RANDOM

/datum/overmap_star_system/outposted
	name = "Ligmata Teagarden Memorial sector"
	has_outpost = TRUE

	//main colors, used for dockable terrestrials, and background
	primary_color = "#ffffdf"
	secondary_color = "#828282"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#494982"
	hazard_secondary_color = "#a2b210"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#fbaa51"
	secondary_structure_color = "#fb1010"

	override_object_colors = TRUE
	overmap_icon_state = "overmap"

/datum/overmap_star_system/zx_spectrum_pallete
	//main colors, used for dockable terrestrials, and background
	primary_color = "#00ffff"
	secondary_color = "#ff00ff"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#ff0000"
	hazard_secondary_color = "#0000ff"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#ffff00"
	secondary_structure_color = "#00ff00"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_black_bg"

/datum/overmap_star_system/gameboy
	//main colors, used for dockable terrestrials, and background
	primary_color = "#8bad10"
	secondary_color = "#0f380f"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#8bad10"
	hazard_secondary_color = "#306230"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#9bbc0f"
	secondary_structure_color = "#8bad10"

	override_object_colors = TRUE
	overmap_icon_state = "overmap"

/datum/overmap_star_system/virtualboy
	//main colors, used for dockable terrestrials, and background
	primary_color = "#aa0000"
	secondary_color = "#ff0000"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#aa0000"
	hazard_secondary_color = "#550000"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#ff0000"
	secondary_structure_color = "#aa0000"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_black_bg"

/datum/overmap_star_system/qud //hi lamb
	//main colors, used for dockable terrestrials, and background
	primary_color = "#b1c9c3"
	secondary_color = "#155352"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#d74200"
	hazard_secondary_color = "#e99f10"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#ffffff"
	secondary_structure_color = "#b154cf"

	override_object_colors = TRUE
	overmap_icon_state = "overmap"

/datum/overmap_star_system/amber_term
	//main colors, used for dockable terrestrials, and background
	primary_color = "#ffb000"
	secondary_color = "#eb7500"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#ffb000"
	hazard_secondary_color = "#eb7500"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#ffcc00"
	secondary_structure_color = "#ffb000"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_black_bg"

/datum/overmap_star_system/amber_term/post_edit_token_state(datum/overmap/datum_to_edit)
	datum_to_edit.token.remove_filter("gloweffect")
	if(datum_to_edit.token.color)
		datum_to_edit.token.add_filter("gloweffect", 5, list("type"="drop_shadow", "color"= datum_to_edit.token.color + "F0", "size"=2, "offset"=1))
	else
		datum_to_edit.token.add_filter("gloweffect", 5, list("type"="drop_shadow", "color"= "#808080", "size"=2, "offset"=1))


/datum/overmap_star_system/New()
	var/starname
	if(!name)
		starname = gen_star_name() //we reuse this for the name of the star if name isnt defined, like a uncharted sector or something
		name = starname //we then give it here
	overmap_objects = list()
	controlled_ships = list()
	outposts = list()
	events = list()

	if(!generator_type)
		generator_type = CONFIG_GET(string/overmap_generator_type)
	if(!size)
		size = CONFIG_GET(number/overmap_size)

	overmap_container = new/list(size, size, 0)

	var/encounter_name = name
	var/datum/map_zone/mapzone = SSmapping.create_map_zone(encounter_name)
	overmap_vlevel = SSmapping.create_virtual_level(encounter_name, list(), mapzone, size + MAP_EDGE_PAD * 2, size + MAP_EDGE_PAD * 2)
	overmap_vlevel.current_systen = src
	overmap_vlevel.reserve_margin(MAP_EDGE_PAD)
	overmap_vlevel.fill_in(/turf/open/overmap, /area/overmap)
	overmap_vlevel.selfloop()

	if (!generator_type) //TODO: maybe datumize these?
		generator_type = OVERMAP_GENERATOR_RANDOM

	if (generator_type == OVERMAP_GENERATOR_SOLAR)
		var/datum/overmap/star/center
		var/startype = pick(subtypesof(/datum/overmap/star))
		center = new startype(list("x" = round(size / 2 + 1), "y" = round(size / 2 + 1)), src)
		center.name = starname
		radius_positions = list()
		for(var/x in 1 to size)
			for(var/y in 1 to size)
				radius_positions["[round(sqrt((x - center.x) ** 2 + (y - center.y) ** 2)) + 1]"] += list(list("x" = x, "y" = y))
		if(!hazard_primary_color)
			hazard_primary_color = center.spectral_type
		else
			center.custom_color = FALSE
			center.spectral_type = hazard_primary_color
			center.alter_token_appearance()

	create_map()

	return ..()

/datum/overmap_star_system/Destroy(force, ...)
	if(!force)
		stack_trace("Something has attempted to delete a star system. THIS SHOULD NEVER HAPPEN. STACK TRACING TO SEE WHY THIS IS HAPPENING. PANIC.")
		message_admins("<span class='danger'>Something has attempted to delete a star system. THIS SHOULD NEVER HAPPEN. STACK TRACING TO SEE WHY THIS IS HAPPENING. CHECK RUNTIMES NOW.</span>")
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
	if (generator_type == OVERMAP_GENERATOR_SOLAR)
		spawn_events_in_orbits()
		spawn_ruin_levels_in_orbits()
	else
		spawn_events()
		spawn_ruin_levels()

	if(has_outpost)
		spawn_outpost()
//		spawn_initial_ships()

	//I the initial ship causes more problem than it's worth anyways, works fine without one too
	//spawn_initial_ships()

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
		var/event_type = pickweight(GLOB.overmap_event_pick_list)
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
	for(var/i in 1 to CONFIG_GET(number/max_overmap_dynamic_events))
		new /datum/overmap/dynamic(system_spawned_in = src)

/datum/overmap_star_system/proc/spawn_ruin_levels_in_orbits()
	for(var/i in 1 to CONFIG_GET(number/max_overmap_dynamic_events))
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
	var/list/location = get_unused_overmap_square_in_radius(rand(3, round(size/5)))

	var/datum/overmap/outpost/found_type
	if(fexists(OUTPOST_OVERRIDE_FILEPATH))
		var/file_text = trim_right(file2text(OUTPOST_OVERRIDE_FILEPATH)) // trim_right because there's often a trailing newline
		var/datum/overmap/outpost/potential_type = text2path(file_text)
		if(!potential_type || !ispath(potential_type, /datum/overmap/outpost))
			stack_trace("SSovermap found an outpost override file at [OUTPOST_OVERRIDE_FILEPATH], but was unable to find the outpost type [potential_type]!")
		else
			found_type = potential_type
		fdel(OUTPOST_OVERRIDE_FILEPATH) // don't want it to affect 2 rounds in a row.

	if(!found_type)
		var/list/possible_types = subtypesof(/datum/overmap/outpost)
		for(var/datum/overmap/outpost/outpost_type as anything in possible_types)
			if(!initial(outpost_type.main_template))
				possible_types -= outpost_type
		found_type = pick(possible_types)

	new found_type(location, src)
	return

/*
/datum/controller/subsystem/overmap/proc/spawn_initial_ships()
#ifndef UNIT_TESTS
	var/datum/map_template/shuttle/selected_template = SSmapping.maplist[pick(SSmapping.maplist)]
	INIT_ANNOUNCE("Loading [selected_template.name]...")
	SSovermap.spawn_ship_at_start(selected_template)
	if(SSdbcore.Connect())
		var/datum/DBQuery/query_round_map_name = SSdbcore.NewQuery({"
			UPDATE [format_table_name("round")] SET map_name = :map_name WHERE id = :round_id
		"}, list("map_name" = selected_template.name, "round_id" = GLOB.round_id))
		query_round_map_name.Execute()
		qdel(query_round_map_name)
#endif
*/

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
	mapgen.populate_turfs(vlevel.get_unreserved_block())

	if(dynamic_datum.weather_controller_type)
		new dynamic_datum.weather_controller_type(mapzone)

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

	return list(mapzone, docking_ports, ruin_turfs, ruin_templates)

/datum/overmap_star_system/proc/overmap_container_view(user = usr) //this is broken rn, idfk know html viewers works
	if(!overmap_container)
		return
	. += "<a href='?src=[REF(src)];refresh=1'>\[Refresh\]</a><br><code>"
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
			. += "<a href='?src=[REF(src)];view_object=[REF(thing_to_link)]' title='[x]x, [y]y'>[add_leading(add_trailing(tile, 2), 3)]</a>" //"centers" the character
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
/// Returns TRUE if players should be allowed to create a ship by "standard" means, and FALSE otherwise.
/datum/controller/subsystem/overmap/proc/player_ship_spawn_allowed()
	if(!(GLOB.ship_spawn_enabled) || (get_num_cap_ships() >= CONFIG_GET(number/max_shuttle_count)))
		return FALSE
	return TRUE

/datum/overmap_star_system/ngr
	name = "Gorlex Controlled - Ecbatana"

	has_outpost = FALSE

	//main colors, used for dockable terrestrials, and background
	primary_color = "#d9ad82"
	secondary_color = "#c48c60"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#c13623"
	hazard_secondary_color = "#943a43"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#83db2b"
	secondary_structure_color = "#21a52e"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_dark"
