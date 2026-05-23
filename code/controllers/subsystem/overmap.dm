SUBSYSTEM_DEF(overmap)
	name = "Overmap"
	wait = 10
	init_order = INIT_ORDER_OVERMAP
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	/// All the existing star systems, it's gonna be atleast 1 including the main system
	var/list/datum/overmap_star_system/tracked_star_systems = list()

	//outpost sectors
	var/list/safe_sectors = list()

	//wilderness sectors
	var/list/wild_sectors = list()

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

#ifdef FULL_INIT

	var/primary_outpost_sector = pick(subtypesof(/datum/overmap_star_system/safezone) - /datum/overmap_star_system/safezone/json_example)
	var/secondary_outpost_sector = pick(subtypesof(/datum/overmap_star_system/safezone) - primary_outpost_sector - /datum/overmap_star_system/safezone/json_example)
	var/primary_wilderness_sector = pick(typesof(/datum/overmap_star_system/wilderness))
	var/secondary_wilderness_sector = pick(typesof(/datum/overmap_star_system/wilderness) - primary_wilderness_sector)

	/* needs refactor for multi outpost
	if(fexists(SAFEZONE_OVERRIDE_FILEPATH))
		var/file_text = trim_right(file2text(SAFEZONE_OVERRIDE_FILEPATH)) // trim_right because there's often a trailing newline
		var/datum/overmap_star_system/safezone/potential_type = text2path(file_text)
		if(!potential_type || !ispath(potential_type, /datum/overmap_star_system/safezone))
			stack_trace("SSovermap found an safezone override file at [SAFEZONE_OVERRIDE_FILEPATH], but was unable to find the system type [potential_type]!")
		else
			outpost_sector_types = potential_type
		fdel(SAFEZONE_OVERRIDE_FILEPATH) // don't want it to affect 2 rounds in a row.
	*/

	//future project: make overmap "styles" a selection

	//4 systems. Outpost-Wilderness-Outpost-Wilderness
	tracked_star_systems[1] = spawn_new_star_system(primary_outpost_sector)
	safe_sectors += tracked_star_systems[1]
	tracked_star_systems[2] = spawn_new_star_system(primary_wilderness_sector)
	wild_sectors += tracked_star_systems[2]
	tracked_star_systems[3] = spawn_new_star_system(secondary_outpost_sector)
	safe_sectors += tracked_star_systems[3]
	tracked_star_systems[4] = spawn_new_star_system(secondary_wilderness_sector)
	wild_sectors += tracked_star_systems[4]

	looplink_4_systems()

#else

	tracked_star_systems[1] = spawn_new_star_system(/datum/overmap_star_system/safezone)
	safe_sectors += tracked_star_systems[1]
	tracked_star_systems[2] = spawn_new_star_system(/datum/overmap_star_system/wilderness)
	wild_sectors += tracked_star_systems[2]

	tracked_star_systems[1].create_jump_point_link(tracked_star_systems[2],4)

#endif

	SEND_GLOBAL_SIGNAL(COMSIG_OVERMAP_FINISHED_CREATION)

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

/datum/controller/subsystem/overmap/proc/link_systems_to_center()
	var/datum/overmap_star_system/first_system = safe_sectors[1]
	var/datum/overmap_star_system/second_system = safe_sectors[2]
	first_system.create_jump_point_link(wild_sectors[1], 4)
	second_system.create_jump_point_link(wild_sectors[1], 8)

/datum/controller/subsystem/overmap/proc/looplink_4_systems()
	var/sector_size = length(tracked_star_systems)
	var/list/jump_dirs = list(5, 6, 10, 9) //NE=>SE->SW->NW
	for(var/i = 1, i <= sector_size, i++)
		var/datum/overmap_star_system/source_system = tracked_star_systems[i]
		var/datum/overmap_star_system/target_system
		if(i==sector_size)
			target_system = tracked_star_systems[1]
		else
			target_system = tracked_star_systems[i+1]
		source_system.create_jump_point(target_system, jump_dirs[i])

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

/datum/controller/subsystem/overmap/proc/get_outpost(datum/overmap_star_system/target_system)
	if(!length(target_system.outposts))
		return "No outpost exists in [target_system.name]."
	return target_system.outposts[1]

/datum/controller/subsystem/overmap/proc/get_outpost_coords(datum/overmap_star_system/target_system)
	if(!length(target_system.outposts))
		return "No outpost exists in [target_system.name]."
	return "[target_system.outposts[1]?:x]-[target_system.outposts[1]?:y]"

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

/datum/controller/subsystem/overmap/proc/get_spawn_outposts()
	var/list/valid_outposts
	for(var/datum/overmap/outpost/outpost in outposts)
		if(outpost.valid_spawn_location)
			valid_outposts += outpost
	return valid_outposts

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

//spaghetti AGAIN

/datum/controller/subsystem/overmap/proc/outpost_recall()
	var/datum/eor_outpost_picker/picker = new /datum/eor_outpost_picker
	picker.call_recall()

#define OUTPOST_SWAP_TIME 30 SECONDS

/datum/eor_outpost_picker
	var/datum/overmap/outpost/outpost_of_the_day
	var/triggering

/datum/eor_outpost_picker/New(datum/overmap/outpost/_excluded_outpost)
	. = ..()
	call_recall(_excluded_outpost)

/**
 * Plays an announcement, closes an outpost, and makes the main outpost system jump-to-able
 */
///Selects an outpost and makes its sector jumpable.

/datum/eor_outpost_picker/proc/call_recall(datum/overmap/outpost/excluded_outpost)

	if(length(SSovermap.outposts) == 1)
		message_admins("Only one outpost.")
		outpost_of_the_day = SSovermap.outposts[1]
		outpost_of_the_day.current_overmap.can_jump_to = TRUE
		return TRUE

	else
		outpost_of_the_day = pick(SSovermap.outposts - excluded_outpost)

	if(!outpost_of_the_day)
		message_admins("Outpost recall found no valid outposts!")
		return FALSE

	triggering = TRUE

	message_admins("Bluespace lighthouse igniting at [outpost_of_the_day] in [DisplayTimeText(OUTPOST_SWAP_TIME)] (<a href='byond://?src=[REF(src)];different_outpost=1'>DIFFERENT_OUTPOST</a>)")

	sleep(OUTPOST_SWAP_TIME)

	var/datum/overmap/outpost/loser_outpost = pick(SSovermap.outposts - outpost_of_the_day)

	if(!triggering)
		return FALSE

	priority_announce("[outpost_of_the_day] has activated a bluespace lighthouse, all vessels in the area are advised to jump directly to port.", "Bluespace Beacon", null, sender_override = "[outpost_of_the_day] Communications")
	outpost_of_the_day.current_overmap.can_jump_to = TRUE
	for (var/datum/overmap/ship/controlled/target_ship in SSovermap.controlled_ships)
		target_ship.blacklisted[loser_outpost] = "[loser_outpost] has closed for the incoming bluespace stormfront."

/datum/eor_outpost_picker/Topic(href, href_list)
	..()
	if(href_list["different_outpost"])
		if(!triggering)
			to_chat(usr, span_admin("Too late to change outposts now!"))
			return
		triggering = FALSE
		message_admins("[key_name_admin(usr)] chose to have a different outpost host end of round!")
		log_admin_private("[key_name(usr)] rerolled end of round outpost.")
		SSblackbox.record_feedback("tally", "overmap_eor_outpost_reroll", 1, type)
		new /datum/eor_outpost_picker(outpost_of_the_day)

#undef OUTPOST_SWAP_TIME
