///Name of the file used for ship name random selection
#define SHIP_NAMES_FILE "ship_names.json"

/**
  * # Simulated overmap ship
  *
  * A ship that corresponds to an actual, physical shuttle.
  *
  * Can be docked to any other overmap datum that has a valid docking process.
  */
/datum/overmap/ship/controlled
	token_type = /obj/overmap/rendered
	dock_time = 10 SECONDS

	///Vessel estimated thrust
	var/est_thrust
	///Average fuel fullness percentage
	var/avg_fuel_amnt = 100
	///Cooldown until the ship can be renamed again
	COOLDOWN_DECLARE(rename_cooldown)
	///Vessel approximate mass
	var/mass

	///The docking port of the linked shuttle. To add a port after creating a controlled ship datum, use [/datum/overmap/ship/controlled/proc/connect_new_shuttle_port].
	VAR_FINAL/obj/docking_port/mobile/shuttle_port
	///The map template the shuttle was spawned from, if it was indeed created from a template. CAN BE NULL (ex. custom-built ships).
	var/datum/map_template/shuttle/source_template

	///Assoc list of remaining open job slots (job = remaining slots)
	var/list/job_slots = list(new /datum/job/captain() = 1, new /datum/job/assistant() = 5)
	///Manifest list of people on the ship
	var/list/manifest = list()
	///Time that next job slot change can occur
	COOLDOWN_DECLARE(job_slot_adjustment_cooldown)
	///Whether or not new players are allowed to join the ship
	var/join_allowed = TRUE
	///Short memo of the ship shown to new joins
	var/memo = ""

	///Shipwide bank account used for cargo consoles and bounty payouts.
	var/datum/bank_account/ship/ship_account

/datum/overmap/ship/controlled/Rename(new_name, force = FALSE)
	var/oldname = name
	if(!..() || (!COOLDOWN_FINISHED(src, rename_cooldown) && !force))
		return FALSE
	message_admins("[key_name_admin(usr)] renamed vessel '[oldname]' to '[new_name]'")
	shuttle_port?.name = new_name
	ship_account.account_holder = new_name
	for(var/area/shuttle_area as anything in shuttle_port?.shuttle_areas)
		shuttle_area.rename_area("[new_name] [initial(shuttle_area.name)]")
	if(!force)
		COOLDOWN_START(src, rename_cooldown, 5 MINUTES)
		priority_announce("The [oldname] has been renamed to the [new_name].", "Docking Announcement", sender_override = new_name, zlevel = shuttle_port.virtual_z())
	return TRUE

/**
  * * creation_template - The template used to create the ship.
  * * target_port - The port to dock the new ship to.
  */
/datum/overmap/ship/controlled/Initialize(position, datum/map_template/shuttle/creation_template, create_shuttle = TRUE)
	. = ..()
	if(creation_template)
		source_template = creation_template
		job_slots = source_template.job_slots?.Copy()
		if(create_shuttle)
			shuttle_port = SSshuttle.load_template(creation_template, src)
			calculate_mass()
			refresh_engines()

	ship_account = new(name, 7500)
#ifdef UNIT_TESTS
	Rename("[source_template]")
#else
	Rename("[source_template.prefix] [pick_list_replacements(SHIP_NAMES_FILE, pick(source_template.name_categories))]", TRUE)
#endif
	SSovermap.controlled_ships += src

/datum/overmap/ship/controlled/Destroy()
	SSovermap.controlled_ships -= src
	if(!QDELETED(shuttle_port))
		shuttle_port.intoTheSunset()
	QDEL_NULL(ship_account)
	return ..()

/datum/overmap/ship/controlled/get_jump_to_turf()
	return get_turf(shuttle_port)

/datum/overmap/ship/controlled/pre_dock(datum/overmap/to_dock, datum/docking_ticket/ticket)
	if(ticket.target != src || ticket.issuer != to_dock)
		return FALSE
	if(!shuttle_port.check_dock(ticket.target_port))
		return FALSE
	return TRUE

/datum/overmap/ship/controlled/start_dock(datum/overmap/to_dock, datum/docking_ticket/ticket)
	log_shuttle("[src] [REF(src)] DOCKING: STARTED REQUEST FOR [to_dock] AT [ticket.target_port]")
	refresh_engines()
	shuttle_port.movement_force = list("KNOCKDOWN" = FLOOR(est_thrust / 50, 1), "THROW" = FLOOR(est_thrust / 500, 1))
	priority_announce("Beginning docking procedures. Completion in [dock_time/10] seconds.", "Docking Announcement", sender_override = name, zlevel = shuttle_port.virtual_z())
	shuttle_port.create_ripples(ticket.target_port, dock_time)

/datum/overmap/ship/controlled/complete_dock(datum/overmap/dock_target, datum/docking_ticket/ticket)
	shuttle_port.initiate_docking(ticket.target_port)
	. = ..()
	if(istype(dock_target, /datum/overmap/ship/controlled)) //hardcoded and bad
		var/datum/overmap/ship/controlled/S = dock_target
		S.shuttle_port.shuttle_areas |= shuttle_port.shuttle_areas
	log_shuttle("[src] [REF(src)] COMPLETE DOCK: FINISHED DOCKING TO [dock_target] AT [ticket.target_port]")

/datum/overmap/ship/controlled/Undock(force = FALSE)
	if(docking)
		return
	log_shuttle("[src] [REF(src)] UNDOCK: STARTED UNDOCK FROM [docked_to]")
	var/dock_time_temp = dock_time
	if(shuttle_port.check_transit_zone() != TRANSIT_READY)
		dock_time *= 2 // Give it double the time in order to reserve transit space
		if(force)
			SSshuttle.transit_requesters -= shuttle_port
			SSshuttle.generate_transit_dock(shuttle_port) // We need a port, NOW.

	priority_announce("Beginning undocking procedures. Completion in [dock_time/10] seconds.", "Docking Announcement", sender_override = name, zlevel = shuttle_port.virtual_z())

	. = ..()
	dock_time = dock_time_temp // Set it back to the original value if it was changed

/datum/overmap/ship/controlled/complete_undock()
	shuttle_port.initiate_docking(shuttle_port.assigned_transit)
	log_shuttle("[src] [REF(src)] COMPLETE UNDOCK: FINISHED UNDOCK FROM [docked_to]")
	return ..()

/datum/overmap/ship/controlled/pre_docked(datum/overmap/ship/controlled/dock_requester)
	for(var/obj/docking_port/stationary/docking_port in shuttle_port.docking_points)
		if(dock_requester.shuttle_port.check_dock(docking_port))
			return new /datum/docking_ticket(docking_port, src, dock_requester)

/datum/overmap/ship/controlled/post_undocked(datum/overmap/dock_requester)
	if(istype(dock_requester, /datum/overmap/ship/controlled))
		var/datum/overmap/ship/controlled/docker_port = dock_requester
		shuttle_port.shuttle_areas += docker_port.shuttle_port.shuttle_areas

/**
  * Docks to an empty dynamic encounter. Used for intership interaction, structural modifications, and such
  */
/datum/overmap/ship/controlled/proc/dock_in_empty_space()
	var/datum/overmap/dynamic/empty/E = locate() in SSovermap.overmap_container[x][y]
	if(!E)
		E = new(list("x" = x, "y" = y))
	if(E) //Don't make this an else
		Dock(E)

/datum/overmap/ship/controlled/burn_engines(n_dir = null, percentage = 100)
	if(docked_to || docking)
		CRASH("[src] burned engines while docking or docked!")

	var/thrust_used = 0 //The amount of thrust that the engines will provide with one burn
	refresh_engines()
	if(!mass)
		calculate_mass()
	calculate_avg_fuel()
	for(var/obj/machinery/power/shuttle/engine/E as anything in shuttle_port.engine_list)
		if(!E.enabled)
			continue
		thrust_used += E.burn_engine(percentage)
	est_thrust = thrust_used //cheeky way of rechecking the thrust, check it every time it's used
	thrust_used = thrust_used / max(mass * 100, 1) //do not know why this minimum check is here, but I clearly ran into an issue here before
	if(n_dir)
		accelerate(n_dir, thrust_used)
	else
		decelerate(thrust_used)

/**
  * Just double checks all the engines on the shuttle
  */
/datum/overmap/ship/controlled/proc/refresh_engines()
	var/calculated_thrust
	for(var/obj/machinery/power/shuttle/engine/E as anything in shuttle_port.engine_list)
		E.update_engine()
		if(E.enabled)
			calculated_thrust += E.thrust
	est_thrust = calculated_thrust

/**
  * Calculates the mass based on the amount of turfs in the shuttle's areas
  */
/datum/overmap/ship/controlled/proc/calculate_mass()
	. = 0
	var/list/areas = shuttle_port.shuttle_areas
	for(var/shuttle_area in areas)
		. += length(get_area_turfs(shuttle_area))
	mass = .

/**
  * Calculates the average fuel fullness of all engines.
  */
/datum/overmap/ship/controlled/proc/calculate_avg_fuel()
	var/fuel_avg = 0
	var/engine_amnt = 0
	for(var/obj/machinery/power/shuttle/engine/E as anything in shuttle_port.engine_list)
		if(!E.enabled)
			continue
		fuel_avg += E.return_fuel() / E.return_fuel_cap()
		engine_amnt++
	if(!engine_amnt || !fuel_avg)
		avg_fuel_amnt = 0
		return
	avg_fuel_amnt = round(fuel_avg / engine_amnt * 100)

/datum/overmap/ship/controlled/tick_move()
	if(avg_fuel_amnt < 1)
		decelerate(max_speed / 100)
	return ..()

/**
  * Bastardized version of GLOB.manifest.manifest_inject, but used per ship
  *
  * * H - Human mob to add to the manifest
  * * C - client of the mob to add to the manifest
  * * human_job - Job of the human mob to add to the manifest
  */
/datum/overmap/ship/controlled/proc/manifest_inject(mob/living/carbon/human/H, client/C, datum/job/human_job)
	if(H.mind && (H.mind.assigned_role != H.mind.special_role))
		manifest[H.real_name] = human_job

/**
  * Connects a new shuttle port to the ship datum. Should be used very shortly after the ship is created, if at all.
  * Used to connect the shuttle port to a ship datum that was created without a template.
  *
  * * new_port - The new shuttle port to connect to the ship.
  */
/datum/overmap/ship/controlled/proc/connect_new_shuttle_port(obj/docking_port/mobile/new_port)
	if(shuttle_port)
		CRASH("Attempted to connect a new port to a ship that already has a port!")
	shuttle_port = new_port
	calculate_mass()
	refresh_engines()
	shuttle_port.name = name
	for(var/area/shuttle_area as anything in shuttle_port.shuttle_areas)
		shuttle_area.rename_area("[name] [initial(shuttle_area.name)]")
