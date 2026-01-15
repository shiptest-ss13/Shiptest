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
	interaction_options = list(INTERACTION_OVERMAP_DOCK, INTERACTION_OVERMAP_QUICKDOCK, INTERACTION_OVERMAP_HAIL, INTERACTION_OVERMAP_INTERDICTION)

	///Vessel estimated thrust per full burn
	var/est_thrust
	///Average fuel fullness percentage
	var/avg_fuel_amnt = 100
	///Cooldown until the ship can be renamed again
	COOLDOWN_DECLARE(rename_cooldown)

	///The docking port of the linked shuttle. To add a port after creating a controlled ship datum, use [/datum/overmap/ship/controlled/proc/connect_new_shuttle_port].
	VAR_FINAL/obj/docking_port/mobile/shuttle_port
	///The map template the shuttle was spawned from, if it was indeed created from a template.
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
	///Crew Owned Bank Accounts.
	var/list/crew_bank_accounts = list()
	///magic number for telling us how much of a mission goes into each crew member's bank account
	var/crew_share = 0.02

	/// List of currently-accepted missions.
	var/list/datum/mission/missions
	/// The maximum number of currently active missions that a ship may take on.
	var/max_missions = 3

	/// Manifest list of people on the ship. Indexed by mob REAL NAME. value is JOB INSTANCE
	var/list/manifest = list()

	/// List of mob refs indexed by their job instance
	var/list/datum/weakref/job_holder_refs = list()

	var/list/datum/mind/owner_candidates

	/// The mob of the current ship owner. Tracking mostly uses this; that lets us pick up on logouts, which let us
	/// determine if a player is switching to control of a mob with a different mind, who thus shouldn't be the ship owner.
	var/mob/owner_mob
	/// The mind of the current ship owner. Mostly kept around so that we can scream in panic if this gets changed behind our back.
	var/datum/mind/owner_mind
	/// The action datum given to the current owner; will be null if we don't have one.
	var/datum/action/ship_owner/owner_act
	/// The ID of the timer that is used to check for a new owner, if the ship ends up with a null owner.
	var/owner_check_timer_id

	/// The ship's join mode. Controls whether players can join freely, have to apply, or can't join at all.
	var/join_mode = SHIP_JOIN_MODE_CLOSED
	/// Lazylist of /datum/ship_applications for this ship. Only used if join_mode == SHIP_JOIN_MODE_APPLY
	var/list/datum/ship_application/applications

	/// an assoc list
	var/ship_modules = list()

	/// Short memo of the ship shown to new joins
	var/memo = null
	///Assoc list of remaining open job slots (job = remaining slots)
	var/list/job_slots
	///Time that next job slot change can occur
	COOLDOWN_DECLARE(job_slot_adjustment_cooldown)

	///The ship's real name, without the prefix
	var/real_name

	///Stations the ship has been blacklisted from landing at, associative station = reason
	var/list/blacklisted = list()

	///The cooldown for events hitting this ship. Generally used by events with a big consquence and fires slower than normal, like flares
	COOLDOWN_DECLARE(event_cooldown)

/datum/overmap/ship/controlled/Rename(new_name, force = FALSE)
	var/old_name = name
	var/full_name = "[source_template.prefix] [new_name]"
	if(!force && !COOLDOWN_FINISHED(src, rename_cooldown) || !..(full_name, force))
		return FALSE

	message_admins("[key_name_admin(usr)] renamed vessel '[old_name]' to '[full_name]'")
	log_admin("[key_name(src)] has renamed vessel '[old_name]' to '[full_name]'")
	SSblackbox.record_feedback("text", "ship_renames", 1, full_name)

	real_name = new_name
	shuttle_port?.name = full_name
	ship_account.account_holder = full_name

	if(shipkey)
		shipkey.name = "ship key ([full_name])"

	for(var/area/shuttle_area as anything in shuttle_port?.shuttle_areas)
		shuttle_area.rename_area("[full_name] [initial(shuttle_area.name)]")

	for(var/datum/weakref/stupid_fax in shuttle_port?.fax_list)
		var/obj/machinery/fax/our_fax = stupid_fax.resolve()
		our_fax.fax_name = "[get_area_name(our_fax)] Fax Machine"
	if(!force)
		COOLDOWN_START(src, rename_cooldown, 5 MINUTES)
		if(shuttle_port?.virtual_z() == null)
			return TRUE
		priority_announce("The [old_name] has been renamed to the [full_name].", "Docking Announcement", sender_override = full_name, zlevel = shuttle_port?.virtual_z())

	return TRUE

/**
 * * creation_template - The template used to create the ship.
 * * target_port - The port to dock the new ship to.
 */
/datum/overmap/ship/controlled/Initialize(position, system_spawned_in, datum/map_template/shuttle/creation_template, create_shuttle = TRUE, outpost_special_docking_perms)
	. = ..()
	if(creation_template)
		source_template = creation_template
		unique_ship_access = source_template.unique_ship_access
		job_slots = source_template.job_slots?.Copy()
		stationary_icon_state = creation_template.token_icon_state
		alter_token_appearance()
		if(create_shuttle)
			shuttle_port = SSshuttle.load_template(creation_template, src)
			if(!shuttle_port) //Loading failed, if the shuttle is supposed to be created, we need to delete ourselves.
				qdel(src) // Can't return INITIALIZE_HINT_QDEL here since this isn't ACTUAL initialisation. Considering changing the name of the proc.
				return
			if(istype(position, /datum/overmap))
				docked_to = null // Dock() complains if you're already docked to something when you Dock, even on force
				Dock(position, force = TRUE)

			refresh_engines()
		ship_account = new(name, source_template.starting_funds)
		if(outpost_special_docking_perms)
			outpost_special_dock_perms = TRUE

	else
		stack_trace("Attempted to create a controlled ship without a template!")
		source_template = new(rename = "Overmap Object [length(SSovermap.overmap_objects)]")
	RegisterSignal(src, COMSIG_OVERMAP_CALIBRATE_JUMP, PROC_REF(do_jump))
	RegisterSignal(src, COMSIG_OVERMAP_CANCEL_JUMP, PROC_REF(stop_jump))
#ifdef UNIT_TESTS
	Rename("[source_template]", TRUE)
#else
	Rename(pick_list_replacements(SHIP_NAMES_FILE, pick(source_template.name_categories)), TRUE)
#endif
	SSovermap.controlled_ships += src
	current_overmap.controlled_ships += src

	GLOB.ship_select_tgui?.update_static_data_for_all_viewers()
	GLOB.crew_manifest_tgui?.update_static_data_for_all_viewers()

/datum/overmap/ship/controlled/Destroy()
	//SHOULD be called first
	. = ..()
	SSovermap.controlled_ships -= src
	current_overmap.controlled_ships -= src
	helms.Cut()
	QDEL_LIST(missions)
	LAZYCLEARLIST(owner_candidates)
	if(!QDELETED(shuttle_port))
		shuttle_port.current_ship = null
		qdel(shuttle_port, TRUE)
		shuttle_port = null
	if(!QDELETED(ship_account))
		QDEL_NULL(ship_account)
	if(!QDELETED(shipkey))
		QDEL_NULL(shipkey)
	manifest.Cut()
	crew_bank_accounts.Cut()
	job_holder_refs.Cut()
	job_slots.Cut()
	blacklisted.Cut()
	for(var/a_key in applications)
		if(isnull(applications[a_key]))
			continue
		// it handles removal itself
		qdel(applications[a_key])
	LAZYCLEARLIST(applications)
	GLOB.ship_select_tgui?.update_static_data_for_all_viewers()
	GLOB.crew_manifest_tgui?.update_static_data_for_all_viewers()
	// set ourselves to ownerless to unregister signals
	set_owner_mob(null)

/datum/overmap/ship/controlled/get_jump_to_turf()
	return get_turf(shuttle_port)

/datum/overmap/ship/controlled/pre_dock(datum/overmap/to_dock, datum/docking_ticket/ticket)
	if(ticket.target != src || ticket.issuer != to_dock)
		ticket.docking_error = "Invalid target."
		return FALSE
	if(!shuttle_port.check_dock(ticket.target_port, ticket=ticket))
		if(!ticket.docking_error)
			ticket.docking_error = "Targeted docking port invalid."
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

/datum/overmap/ship/controlled/pre_docked(datum/overmap/ship/controlled/dock_requester, override_dock)
	if(override_dock)
		return new /datum/docking_ticket(override_dock, src, dock_requester)

	for(var/obj/docking_port/stationary/docking_port in shuttle_port.docking_points)
		if(dock_requester.shuttle_port.check_dock(docking_port))
			return new /datum/docking_ticket(docking_port, src, dock_requester)
	return ..()

/datum/overmap/ship/controlled/get_dockable_locations(datum/overmap/requesting_interactor)
	var/list/docks = list()
	for(var/obj/docking_port/stationary/docking_port as anything in shuttle_port.docking_points)
		if(!docking_port.docked && !docking_port.current_docking_ticket)
			LAZYADD(docks, docking_port)
	return docks


/**
 * Docks to an empty dynamic encounter. Used for intership interaction, structural modifications, and such
 */
/datum/overmap/ship/controlled/proc/dock_in_empty_space()
	var/datum/overmap/dynamic/empty/empty_space = locate() in current_overmap.overmap_container[x][y]
	if(!empty_space)
		empty_space = new(list("x" = x, "y" = y), current_overmap)
	if(empty_space) //Don't make this an else
		Dock(empty_space)

/datum/overmap/ship/controlled/burn_engines(percentage = 100, seconds_per_tick)
	var/thrust_used = 0 //The amount of thrust that the engines will provide with one burn
	refresh_engines()
	calculate_avg_fuel()
	for(var/obj/machinery/power/shuttle/engine/real_engine as anything in shuttle_port.get_engines())
		if(!real_engine.enabled)
			continue
		thrust_used += real_engine.burn_engine(percentage, seconds_per_tick)

	thrust_used = thrust_used / (shuttle_port.turf_count * 100)
	est_thrust = thrust_used * 100 / (percentage * seconds_per_tick) //cheeky way of rechecking the thrust, check it every time it's used

	return thrust_used

/**
 * Just double checks all the engines on the shuttle
 */
/datum/overmap/ship/controlled/proc/refresh_engines()
	var/calculated_thrust
	for(var/obj/machinery/power/shuttle/engine/real_engine as anything in shuttle_port.get_engines())
		real_engine.update_engine()
		if(real_engine.enabled)
			calculated_thrust += real_engine.thrust
	est_thrust = calculated_thrust / (shuttle_port.turf_count * 100) * 1 SECONDS / SSphysics.wait

/**
 * Calculates the average fuel fullness of all engines.
 */
/datum/overmap/ship/controlled/proc/calculate_avg_fuel()
	var/fuel_avg = 0
	var/engine_amnt = 0
	for(var/obj/machinery/power/shuttle/engine/real_engine as anything in shuttle_port.get_engines())
		if(!real_engine.enabled)
			continue
		fuel_avg += real_engine.return_fuel() / real_engine.return_fuel_cap()
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

/datum/overmap/ship/controlled/proc/is_join_option()
	return (length(shuttle_port.spawn_points) >= 1) && (length(job_slots) >= 1) && join_mode != SHIP_JOIN_MODE_CLOSED

/datum/overmap/ship/controlled/proc/get_application(mob/applicant)
	var/index_key = applicant.client?.holder?.fakekey ? applicant.client.holder.fakekey : applicant.key
	return LAZYACCESS(applications, ckey(index_key))

/**
 * Bastardized version of GLOB.manifest.manifest_inject, but used per ship.
 * Adds the passed-in mob to the list of ship owner candidates, and makes them
 * the ship owner if there is currently none.
 *
 * * H - Human mob to add to the manifest
 * * C - client of the mob to add to the manifest
 * * human_job - Job of the human mob to add to the manifest
 */
/datum/overmap/ship/controlled/proc/manifest_inject(mob/living/carbon/human/H, client/C, datum/job/human_job)
	// no idea why this check exists
	if(H.mind.assigned_role != H.mind.special_role)
		manifest[H.real_name] = human_job

	var/mind_info = list(
		name = H.real_name,
		eligible = TRUE
	)
	LAZYSET(owner_candidates, H.mind, mind_info)
	H.mind.original_ship = WEAKREF(src)
	RegisterSignal(H.mind, COMSIG_QDELETING, PROC_REF(crew_mind_deleting))
	if(!owner_mob)
		set_owner_mob(H)

	if(!(human_job in job_holder_refs))
		job_holder_refs[human_job] = list()
	job_holder_refs[human_job] += WEAKREF(H)
	if(H.account_id)
		crew_bank_accounts += WEAKREF(H.get_bank_account())

	GLOB.crew_manifest_tgui?.update_static_data_for_all_viewers()
	GLOB.ship_select_tgui?.update_static_data_for_all_viewers()

/datum/overmap/ship/controlled/proc/manifest_remove(mob/living/carbon/human/removed)
	manifest -= removed.real_name
	GLOB.crew_manifest_tgui?.update_static_data_for_all_viewers()
	GLOB.ship_select_tgui?.update_static_data_for_all_viewers()

/**
 * adds a mob's real name to a crew's guestbooks
 *
 * * H - human mob to add to the crew's guestbooks
 */
/datum/overmap/ship/controlled/proc/add_mob_to_crew_guestbook(mob/living/carbon/human/H)
	// iterate over the human list to find crewmembers
	for(var/mob/living/carbon/human/crewmember as anything in GLOB.human_list)
		if(crewmember == H)
			continue
		if(!(crewmember.real_name in manifest))
			continue
		if(!crewmember.mind?.guestbook)
			continue

		// add the mob to the crewmember's guestbook and viceversa
		crewmember.mind.guestbook.add_guest(crewmember, H, H.real_name, H.real_name, TRUE)
		H.mind.guestbook.add_guest(H, crewmember, crewmember.real_name, crewmember.real_name, TRUE)

/datum/overmap/ship/controlled/proc/set_owner_mob(mob/new_owner)
	if(owner_mob)
		// we (hopefully) don't have to hook qdeletion,
		// because when mobs are qdeleted, they ghostize, which SHOULD transfer the key.
		// that means they raise the logout signal, so we transfer to the ghost
		UnregisterSignal(owner_mob, COMSIG_MOB_LOGOUT)
		UnregisterSignal(owner_mob, COMSIG_MOB_GO_INACTIVE)
		// testing trace because i am afraid
		if(owner_mob.mind && owner_mob.mind != owner_mind)
			// moving minds means moving keys; if this trips, a mind moved without a key move for us to pick up on
			// when transferring mind from one body to another, source mob's mind is set to null before the transfer. thus the null check
			// i'm going to be honest i don't have a fucking clue if this code works. mind code is hell
			stack_trace("[src]'s owner mob [owner_mob] (mind [owner_mob.mind], player [owner_mob.mind.key]) silently changed its mind from [owner_mind] (player [owner_mind.key])!")
		owner_act.Remove(owner_mob)

	if(!new_owner) // owner mob is being set to null; we're becoming ownerless
		owner_mob = null
		owner_mind = null
		if(owner_act)
			QDEL_NULL(owner_act)
		// turns out that timers don't get added to active_timers if the datum is getting qdeleted.
		// so this timer was sitting around after deletion and clogging up runtime logs. thus, the QDELING() check. oops!
		if(!owner_check_timer_id && !QDELING(src))
			owner_check_timer_id = addtimer(CALLBACK(src, PROC_REF(check_owner)), 5 MINUTES, TIMER_STOPPABLE|TIMER_LOOP|TIMER_DELETE_ME)
		return

	owner_mob = new_owner
	owner_mind = owner_mob.mind
	if(owner_check_timer_id) // we know we have an owner since we didn't return up there
		deltimer(owner_check_timer_id)
		owner_check_timer_id = null

	// testing trace
	// not 100% sure this is needed
	if(!(owner_mind in owner_candidates))
		stack_trace("[src] tried to set ship owner to [new_owner] despite its mind [new_owner.mind] not being in owner_candidates!")

	RegisterSignal(owner_mob, COMSIG_MOB_LOGOUT, PROC_REF(owner_mob_logout))
	RegisterSignal(owner_mob, COMSIG_MOB_GO_INACTIVE, PROC_REF(owner_mob_afk))
	if(!owner_act)
		owner_act = new(src)
	owner_act.Grant(owner_mob)

/datum/overmap/ship/controlled/proc/crew_mind_deleting(datum/mind/del_mind)
	SIGNAL_HANDLER

	UnregisterSignal(del_mind, COMSIG_QDELETING)
	LAZYREMOVE(owner_candidates, del_mind)
	if(owner_mind == del_mind)
		set_owner_mob(get_best_owner_mob())

/datum/overmap/ship/controlled/proc/owner_mob_logout(mob/mob_logging)
	SIGNAL_HANDLER

	var/mob/new_mob = GLOB.directory[ckey(owner_mind.key)]?.mob // get owner's client and through that their new mob
	var/needs_new_owner = FALSE
	if(!new_mob || new_mob.mind != owner_mind || new_mob.client.is_afk())
		needs_new_owner = TRUE
	else if(istype(new_mob, /mob/dead/observer))
		var/mob/dead/observer/new_ghost = new_mob
		if(!new_ghost.can_reenter_corpse)
			needs_new_owner = TRUE

	if(needs_new_owner)
		new_mob = get_best_owner_mob()
	set_owner_mob(new_mob)

/datum/overmap/ship/controlled/proc/owner_mob_afk(mob/going_afk)
	SIGNAL_HANDLER

	set_owner_mob(get_best_owner_mob())

/datum/overmap/ship/controlled/proc/check_owner()
	if(owner_mob)
		return
	var/mob/new_mob = get_best_owner_mob()
	if(new_mob)
		set_owner_mob(new_mob)

// goes through our list of candidates and finds a valid candidate for ship owner, or null if none can be found
/datum/overmap/ship/controlled/proc/get_best_owner_mob()
	. = null
	for(var/datum/mind/possible as anything in owner_candidates)
		var/mob/cand_mob = get_mob_if_valid_owner(possible)
		if(cand_mob)
			return cand_mob

/datum/overmap/ship/controlled/proc/get_mob_if_valid_owner(datum/mind/candidate)
	if(!(candidate in owner_candidates) || !owner_candidates[candidate]["eligible"])
		return null
	var/mob/cand_mob = candidate.active ? candidate.current : candidate.get_ghost(FALSE, FALSE)
	// testing trace
	if(cand_mob && cand_mob.mind != candidate)
		stack_trace("AAAAAAAAAAAAAAAGH")
	return (cand_mob != null && cand_mob.client && !cand_mob.client.is_afk() ? cand_mob : null)

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


/datum/overmap/ship/controlled/alter_token_appearance()
	if(!source_template)
		return ..()
	desc = {"[span_boldnotice("IFF is reporting the following:")]
	[span_bold("Affiliation: ")][source_template.faction.name]
	[span_bold("Class: ")][source_template.short_name]
	[span_bold("Velocity: ")][round(get_speed(), 0.1)] Gm/s"}
	return ..()

//when bluespace jumping gets moved to its own machine make this NOT look for non-vewscreen helms
/datum/overmap/ship/controlled/proc/do_jump(obj/item/source, datum/overmap_star_system/new_system, new_x, new_y)
	var/obj/machinery/computer/helm/our_helm
	for(var/obj/machinery/computer/helm/checked_helm as anything in helms)
		if(checked_helm.viewer)
			continue
		our_helm = checked_helm
		break
	var/list/newpos
	if(new_x && new_y)
		newpos = list("x" = new_x, "y" = new_y)

	if(our_helm)
		our_helm.calibrate_jump(new_system, newpos)

//ditto
/datum/overmap/ship/controlled/proc/stop_jump(obj/item/source)
	var/obj/machinery/computer/helm/our_helm
	for(var/obj/machinery/computer/helm/checked_helm as anything in helms)
		if(checked_helm.viewer)
			continue
		our_helm = checked_helm
		break

	if(our_helm)
		our_helm.cancel_jump()


/obj/item/key/ship
	name = "ship key"
	desc = "A key for locking and unlocking the helm of a ship, comes with a ball chain so it can be worn around the neck. Comes with a cute little shuttle-shaped keychain."
	icon_state = "shipkey"
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
		update_appearance()
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

