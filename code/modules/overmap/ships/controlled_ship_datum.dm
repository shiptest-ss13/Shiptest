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

	///Vessel estimated thrust per full burn
	var/est_thrust
	///Average fuel fullness percentage
	var/avg_fuel_amnt = 100
	///Cooldown until the ship can be renamed again
	COOLDOWN_DECLARE(rename_cooldown)

	///The docking port of the linked shuttle. To add a port after creating a controlled ship datum, use [/datum/overmap/ship/controlled/proc/connect_new_shuttle_port].
	VAR_FINAL/obj/docking_port/mobile/shuttle_port
	///The map template the shuttle was spawned from, if it was indeed created from a template. CAN BE NULL (ex. custom-built ships).
	var/datum/map_template/shuttle/source_template
	///Whether objects on the ship require an ID with ship access granted
	var/unique_ship_access = FALSE

	/// The shipkey for this ship
	var/obj/item/key/ship/shipkey
	/// All helms connected to this ship
	var/list/obj/machinery/computer/helm/helms = list()
	/// Is helm access for this ship locked
	var/helm_locked = FALSE
	///Shipwide bank account used for cargo consoles and bounty payouts.
	var/datum/bank_account/ship/ship_account

	/// List of currently-accepted missions.
	var/list/datum/mission/missions
	/// The maximum number of currently active missions that a ship may take on.
	var/max_missions = 2

	var/datum/crew/ship/crew

/datum/overmap/ship/controlled/Rename(new_name, force = FALSE)
	var/oldname = name
	if(!..() || (!COOLDOWN_FINISHED(src, rename_cooldown) && !force))
		return FALSE
	message_admins("[key_name_admin(usr)] renamed vessel '[oldname]' to '[new_name]'")
	log_admin("[key_name(src)] has renamed vessel '[oldname]' to '[new_name]'")
	shuttle_port?.name = new_name
	ship_account.account_holder = new_name
	if (crew)
		crew.Rename(new_name)
	if(shipkey)
		shipkey.name = "ship key ([new_name])"
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
/datum/overmap/ship/controlled/Initialize(position, datum/map_template/shuttle/creation_template, create_shuttle = TRUE, create_crew = FALSE)
	. = ..()


	if(creation_template)
		source_template = creation_template
		unique_ship_access = source_template.unique_ship_access
		if (create_crew)
			crew = new(src)
		if(create_shuttle)
			shuttle_port = SSshuttle.load_template(creation_template, src)
			if(!shuttle_port) //Loading failed, if the shuttle is supposed to be created, we need to delete ourselves.
				qdel(src) // Can't return INITIALIZE_HINT_QDEL here since this isn't ACTUAL initialisation. Considering changing the name of the proc.
				return
			refresh_engines()

	ship_account = new(name, 2000)
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
	if(!QDELETED(ship_account))
		QDEL_NULL(ship_account)
	// set ourselves to ownerless to unregister signals
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
	priority_announce("Beginning docking procedures. Completion in [dock_time/10] seconds.", "Docking Announcement", sender_override = name, zlevel = shuttle_port.virtual_z())
	shuttle_port.create_ripples(ticket.target_port, dock_time)
	shuttle_port.play_engine_sound(shuttle_port, shuttle_port.landing_sound)
	shuttle_port.play_engine_sound(ticket.target_port, shuttle_port.landing_sound)

/datum/overmap/ship/controlled/complete_dock(datum/overmap/dock_target, datum/docking_ticket/ticket)
	shuttle_port.initiate_docking(ticket.target_port)
	. = ..()
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
	shuttle_port.play_engine_sound(shuttle_port, shuttle_port.takeoff_sound)

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
	return ..()

/**
 * Docks to an empty dynamic encounter. Used for intership interaction, structural modifications, and such
 */
/datum/overmap/ship/controlled/proc/dock_in_empty_space()
	var/datum/overmap/dynamic/empty/E = locate() in SSovermap.overmap_container[x][y]
	if(!E)
		E = new(list("x" = x, "y" = y))
	if(E) //Don't make this an else
		Dock(E)

/datum/overmap/ship/controlled/burn_engines(percentage = 100, deltatime)
	if(docked_to || docking)
		CRASH("[src] burned engines while docking or docked!")

	var/thrust_used = 0 //The amount of thrust that the engines will provide with one burn
	refresh_engines()
	calculate_avg_fuel()
	for(var/obj/machinery/power/shuttle/engine/E as anything in shuttle_port.engine_list)
		if(!E.enabled)
			continue
		thrust_used += E.burn_engine(percentage, deltatime)

	thrust_used = thrust_used / (shuttle_port.turf_count * 100)
	est_thrust = thrust_used / percentage * 100 //cheeky way of rechecking the thrust, check it every time it's used

	return thrust_used

/**
 * Just double checks all the engines on the shuttle
 */
/datum/overmap/ship/controlled/proc/refresh_engines()
	var/calculated_thrust
	for(var/obj/machinery/power/shuttle/engine/E as anything in shuttle_port.engine_list)
		E.update_engine()
		if(E.enabled)
			calculated_thrust += E.thrust
	est_thrust = calculated_thrust / (shuttle_port.turf_count * 100)

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
		//Slow down a little when there's no fuel
		adjust_speed(clamp(-speed_x, max_speed * -0.001, max_speed * 0.001), clamp(-speed_y, max_speed * -0.001, max_speed * 0.001))

	return ..()

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
	refresh_engines()
	shuttle_port.name = name
	for(var/area/shuttle_area as anything in shuttle_port.shuttle_areas)
		shuttle_area.rename_area("[name] [initial(shuttle_area.name)]")

/datum/overmap/ship/controlled/proc/attempt_key_usage(mob/user, obj/item/key/ship/shipkey, obj/machinery/computer/helm/target_helm)
	user.changeNext_move(CLICK_CD_MELEE)

	if(shipkey.master_ship != src)
		target_helm?.say("Invalid shipkey usage attempted, forcibly locking down.")
		helm_locked = TRUE
	else
		helm_locked = !helm_locked
		playsound(src, helm_locked ? 'sound/machines/button4.ogg' : 'sound/machines/button3.ogg')

	for(var/obj/machinery/computer/helm/helm as anything in helms)
		SStgui.close_uis(helm)
		helm.say(helm_locked ? "Helm console is now locked." : "Helm console has been unlocked.")

/obj/item/key/ship
	name = "ship key"
	desc = "A key for locking and unlocking the helm of a ship, comes with a ball chain so it can be worn around the neck. Comes with a cute little shuttle-shaped keychain."
	icon_state = "keyship"
	var/datum/overmap/ship/controlled/master_ship
	var/static/list/key_colors = list(
		"blue" = "#4646fc",
		"red" = "#fd4b54",
		"salmon" = "#faacac",
		"brown" = "#a36933",
		"green" = "#3dc752",
		"lime" = "#7ffd6e",
		"cyan" = "#00ffdd",
		"purple" = "#8c3cf5",
		"yellow" = "#ffdd44"
	)
	var/random_color = TRUE //if the key uses random coloring (logic stolen from screwdriver.dm)
	slot_flags = ITEM_SLOT_NECK

/obj/item/key/ship/Initialize(mapload, datum/overmap/ship/controlled/master_ship)
	. = ..()
	src.master_ship = master_ship
	master_ship.shipkey = src
	if(random_color) //random colors!
		icon_state = "shipkey_plasticbod"
		var/our_color = pick(key_colors)
		add_atom_colour(key_colors[our_color], FIXED_COLOUR_PRIORITY)
		update_icon()
	name = "ship key ([master_ship.name])"

/obj/item/key/ship/update_overlays()
	. = ..()
	if(!random_color) //icon override
		return
	var/mutable_appearance/base_overlay = mutable_appearance(icon, "shipkey_metalybits")
	base_overlay.appearance_flags = RESET_COLOR
	. += base_overlay

/obj/item/key/ship/Destroy()
	master_ship.shipkey = null
	master_ship = null
	return ..()

/obj/item/key/ship/attack_self(mob/user)
	if(!master_ship || !Adjacent(user))
		return ..()

	master_ship.attempt_key_usage(user, src, src) // hello I am a helm console I promise
	return TRUE

/obj/item/key/ship/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is stabbing [src] into [user.p_their()] [pick("temple", "heart")] and turns it off. It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return(OXYLOSS)
