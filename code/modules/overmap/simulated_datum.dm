///Name of the file used for ship name random selection
#define SHIP_NAMES_FILE "ship_names.json"

/datum/overmap/ship/simulated
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

	///The docking port of the linked shuttle
	var/obj/docking_port/mobile/shuttle_port
	///The map template the shuttle was spawned from, if it was indeed created from a template. CAN BE NULL (ex. custom-built ships).
	var/datum/map_template/shuttle/source_template

	///Assoc list of remaining open job slots (job = remaining slots)
	var/list/job_slots = list(new /datum/job/captain() = 1, new /datum/job/assistant() = 5)
	///Manifest list of people on the ship
	var/list/manifest = list()
	///Time that next job slot change can occur
	var/job_slot_adjustment_cooldown = 0
	///Whether or not new players are allowed to join the ship
	var/join_allowed = TRUE
	///Short memo of the ship shown to new joins
	var/memo = ""

	///Shipwide bank account
	var/datum/bank_account/ship/ship_account

/datum/overmap/ship/simulated/Rename(new_name, force = FALSE)
	var/oldname = name
	if(!..() || (!COOLDOWN_FINISHED(src, rename_cooldown) && !force))
		return FALSE
	priority_announce("The [oldname] has been renamed to the [new_name].", "Docking Announcement", sender_override = new_name, zlevel = shuttle_port.virtual_z())
	message_admins("[key_name_admin(usr)] renamed vessel '[oldname]' to '[new_name]'")
	shuttle_port.name = new_name
	for(var/area/shuttle_area as anything in shuttle_port.shuttle_areas)
		shuttle_area.rename_area("[new_name] [initial(shuttle_area.name)]")
	if(!force)
		COOLDOWN_START(src, rename_cooldown, 5 MINUTES)
	return TRUE

/datum/overmap/ship/simulated/Initialize(placement_x, placement_y, datum/map_template/shuttle/creation_template)
	. = ..()
	if(creation_template)
		source_template = creation_template
		shuttle_port = SSshuttle.load_template(creation_template, src)
#ifdef UNIT_TESTS
		Rename("[source_template]")
#else
		Rename("[source_template.prefix] [pick_list_replacements(SHIP_NAMES_FILE, pick(source_template.name_categories))]", TRUE)
#endif
		calculate_mass()
		refresh_engines()
	SSovermap.simulated_ships += src

/datum/overmap/ship/simulated/Destroy()
	SSovermap.simulated_ships -= src
	. = ..()

/datum/overmap/ship/simulated/pre_dock(datum/overmap/to_dock, datum/docking_ticket/ticket)
	if(ticket.target != src || ticket.issuer != to_dock)
		return FALSE
	if(!shuttle_port.check_dock(ticket.target_port))
		return FALSE
	return TRUE

/datum/overmap/ship/simulated/start_dock(datum/overmap/to_dock, datum/docking_ticket/ticket)
	refresh_engines()
	shuttle_port.movement_force = list("KNOCKDOWN" = FLOOR(est_thrust / 50, 1), "THROW" = FLOOR(est_thrust / 500, 1))
	priority_announce("Beginning docking procedures. Completion in [dock_time/10] seconds.", "Docking Announcement", sender_override = name, zlevel = shuttle_port.virtual_z())
	shuttle_port.create_ripples(ticket.target_port, dock_time)

/datum/overmap/ship/simulated/complete_dock(datum/overmap/dock_target, datum/docking_ticket/ticket)
	shuttle_port.initiate_docking(ticket.target_port)
	. = ..()
	if(istype(dock_target, /datum/overmap/ship/simulated)) //hardcoded and bad
		var/datum/overmap/ship/simulated/S = dock_target
		S.shuttle_port.shuttle_areas |= shuttle_port.shuttle_areas

/datum/overmap/ship/simulated/Undock()
	var/dock_time_temp = dock_time
	if(!shuttle_port.check_transit_zone()  != TRANSIT_READY)
		dock_time *= 2 // Give it double the time in order to reserve transit space

	priority_announce("Beginning undocking procedures. Completion in [dock_time/10] seconds.", "Docking Announcement", sender_override = name, zlevel = shuttle_port.virtual_z())

	. = ..()
	dock_time = dock_time_temp // Set it back to the original value if it was changed

/datum/overmap/ship/simulated/complete_undock()
	shuttle_port.enterTransit()
	return ..()

/datum/overmap/ship/simulated/post_undocked(datum/overmap/ship/simulated/dock_requester)
	if(istype(dock_requester, /datum/overmap/ship/simulated))
		var/datum/overmap/ship/simulated/docker_port = dock_requester
		shuttle_port.shuttle_areas += docker_port.shuttle_port.shuttle_areas

/**
  * Docks to an empty dynamic encounter. Used for intership interaction, structural modifications, and such
  * * user - The user that initiated the action
  */
/datum/overmap/ship/simulated/proc/dock_in_empty_space(mob/user)
	var/obj/structure/overmap/dynamic/empty/E
	E = locate() in get_turf(src)
	if(!E)
		E = new(get_turf(src))
	if(E)
		return Dock(E)

/datum/overmap/ship/simulated/burn_engines(n_dir = null, percentage = 100)
	if(docked_to)
		return

	var/thrust_used = 0 //The amount of thrust that the engines will provide with one burn
	refresh_engines()
	if(!mass)
		calculate_mass()
	calculate_avg_fuel()
	for(var/obj/machinery/power/shuttle/engine/E in shuttle_port.engine_list)
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
/datum/overmap/ship/simulated/proc/refresh_engines()
	var/calculated_thrust
	for(var/obj/machinery/power/shuttle/engine/E in shuttle_port.engine_list)
		E.update_engine()
		if(E.enabled)
			calculated_thrust += E.thrust
	est_thrust = calculated_thrust

/**
  * Calculates the mass based on the amount of turfs in the shuttle's areas
  */
/datum/overmap/ship/simulated/proc/calculate_mass()
	. = 0
	var/list/areas = shuttle_port.shuttle_areas
	for(var/shuttle_area in areas)
		. += length(get_area_turfs(shuttle_area))
	mass = .

/**
  * Calculates the average fuel fullness of all engines.
  */
/datum/overmap/ship/simulated/proc/calculate_avg_fuel()
	var/fuel_avg = 0
	var/engine_amnt = 0
	for(var/obj/machinery/power/shuttle/engine/E in shuttle_port.engine_list)
		if(!E.enabled)
			continue
		fuel_avg += E.return_fuel() / E.return_fuel_cap()
		engine_amnt++
	if(!engine_amnt || !fuel_avg)
		avg_fuel_amnt = 0
		return
	avg_fuel_amnt = round(fuel_avg / engine_amnt * 100)

/datum/overmap/ship/simulated/tick_move()
	if(avg_fuel_amnt < 1)
		decelerate(max_speed / 100)
	..()

/**
  * Bastardized version of GLOB.manifest.manifest_inject, but used per ship
  *
  */
/datum/overmap/ship/simulated/proc/manifest_inject(mob/living/carbon/human/H, client/C, datum/job/human_job)
	set waitfor = FALSE
	if(H.mind && (H.mind.assigned_role != H.mind.special_role))
		manifest[H.real_name] = human_job
