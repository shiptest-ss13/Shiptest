/**
 * # The datum that handle spawning into stuff (ships, unghosted roles, outpost...)
 *
 * Intended to me a mostly ooc utlity.
 */
/datum/crew
	/// Name of the "crew"
	var/name
	/// Manifest list of people on the ship
	var/list/manifest = list()


	/// List of the species autorised to join this crew, overriden by the job specific whitelist.
	/// Must be a specie id (/datum/species/var/id, check the modules/mob/living/carbon/species_type to know a species ID)
	var/list/species_whitelist = list()
	/// Assoc list of job and their species whitelist.
	var/list/species_whitelist_byjob = list()

	var/list/datum/mind/owner_candidates

	var/list/atom/spawn_points = list()
	var/list/atom/spawn_points_byjob_name = list()

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
	var/join_mode = SHIP_JOIN_MODE_OPEN
	/// Lazylist of /datum/ship_applications for this ship. Only used if join_mode == SHIP_JOIN_MODE_APPLY
	var/list/datum/ship_application/applications

	/// The class of the ship or type of location
	var/class = ""
	/// Short memo of the ship shown to new joins
	var/memo = null
	///Assoc list of remaining open job slots (job = remaining slots)
	var/list/job_slots = list()
	///List of the job available job slots on crew creation.
	var/list/base_job_slots = list()
	///Time that next job slot change can occur
	COOLDOWN_DECLARE(job_slot_adjustment_cooldown)

/**
 * * Return TRUE if the crew was successfully renamed otherwise FALSE
 */
/datum/crew/proc/Rename(new_name)
	name = new_name
	return

/**
 * * Initialise the crew object.
 * * Must :
 * * - Populate the joblist
 * * - Create the structures the players will spanw in.
 * *
 */
/datum/crew/New()
	SHOULD_CALL_PARENT(TRUE)

	SSjob.all_crew += src

/**
 * * Destroy a crew object
 * * delete_location - weather the location attatched to the crew must be deleted (ship planet...)
 */
/datum/crew/Destroy()
	for(var/a_key in applications)
		// it handles removal itself
		qdel(applications[a_key])
	// set ourselves to ownerless to unregister signals
	set_owner_mob(null)
	SSjob.all_crew -= src
	return ..()

/**
 *	Add a mob to a crew and spawn it in.
 *  Assume that if the job need a special spawn point this point is disponible (ex : AI need a disponible core.
 */
/datum/crew/proc/join_crew(mob/M, datum/job/job)
	SHOULD_CALL_PARENT(TRUE)

	if (spawn_points_byjob_name[job.name] && length(spawn_points_byjob_name[job.name]) > 0)
		pick(spawn_points_byjob_name[job.name]).JoinPlayerHere(M, TRUE)
	else
		pick(spawn_points).JoinPlayerHere(M, TRUE)

	manifest_inject(M, M.client, job)


/**
 *	Returns a turf that can be jumped to by observers, admins, and such.
 */
/datum/crew/proc/get_jump_to_turf()
	RETURN_TYPE(/turf)
	return

/**
 *	Weather the crew can be joined.
 */
/datum/crew/proc/is_join_option()
	return (length(job_slots) >= 1 && (length(spawn_points) > 0 || length(spawn_points_byjob_name) > 0)) && join_mode != SHIP_JOIN_MODE_CLOSED

/datum/crew/proc/get_application(mob/applicant)
	var/index_key = applicant.client?.holder?.fakekey ? applicant.client.holder.fakekey : applicant.key
	return LAZYACCESS(applications, ckey(index_key))

/**
 * Bastardized version of GLOB.manifest.manifest_inject, but used per ship.
 * Adds the passed-in mob to the list of ship owner candidates, and makes them
 * the ship owner if there is currently none.
 *
 * * M - Mob to add to the manifest
 * * C - client of the mob to add to the manifest
 * * job - Job of the mob to add to the manifest
 */
/datum/crew/proc/manifest_inject(mob/living/M, client/C, datum/job/job)
	// no idea why this check exists
	if(M.mind.assigned_role != M.mind.special_role)
		manifest[M.real_name] = job

	var/mind_info = list(
		name = M.real_name,
		eligible = TRUE
	)
	LAZYSET(owner_candidates, M.mind, mind_info)
	RegisterSignal(M.mind, COMSIG_PARENT_QDELETING, .proc/crew_mind_deleting)
	if(!owner_mob)
		set_owner_mob(M)

/datum/crew/proc/set_owner_mob(mob/new_owner)
	if(owner_mob)
		// we (hopefully) don't have to hook qdeletion,
		// because when mobs are qdeleted, they ghostize, which SHOULD transfer the key.
		// that means they raise the logout signal, so we transfer to the ghost
		UnregisterSignal(owner_mob, COMSIG_MOB_LOGOUT)
		UnregisterSignal(owner_mob, COMSIG_MOB_GO_INACTIVE)
		// testing trace because i am afraid
		if(owner_mob.mind != owner_mind) // minds should never be changed without a key change and associated logout signal
			stack_trace("[src]'s owner mob [owner_mob] (mind [owner_mob.mind], player [owner_mob.mind.key]) silently changed its mind from [owner_mind] (player [owner_mind.key])!")
		owner_act.Remove(owner_mob)

	if(!new_owner) // owner mob is being set to null; we're becoming ownerless
		owner_mob = null
		owner_mind = null
		if(owner_act)
			QDEL_NULL(owner_act)
		// this gets automatically deleted in /datum/Destroy() if we are being destroyed
		owner_check_timer_id = addtimer(CALLBACK(src, .proc/check_owner), 5 MINUTES, TIMER_STOPPABLE|TIMER_LOOP|TIMER_DELETE_ME)
		return

	owner_mob = new_owner
	owner_mind = owner_mob.mind
	if(owner_check_timer_id) // we know we have an owner since we didn't return up there
		deltimer(owner_check_timer_id)

	// testing trace
	// not 100% sure this is needed
	if(!(owner_mind in owner_candidates))
		stack_trace("[src] tried to set ship owner to [new_owner] despite its mind [new_owner.mind] not being in owner_candidates!")

	RegisterSignal(owner_mob, COMSIG_MOB_LOGOUT, .proc/owner_mob_logout)
	RegisterSignal(owner_mob, COMSIG_MOB_GO_INACTIVE, .proc/owner_mob_afk)
	if(!owner_act)
		owner_act = new(src)
	owner_act.Grant(owner_mob)

/datum/crew/proc/crew_mind_deleting(datum/mind/del_mind)
	SIGNAL_HANDLER

	UnregisterSignal(del_mind, COMSIG_PARENT_QDELETING)
	LAZYREMOVE(owner_candidates, del_mind)
	if(owner_mind == del_mind)
		set_owner_mob(get_best_owner_mob())

/datum/crew/proc/owner_mob_logout(mob/mob_logging)
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

/datum/crew/proc/owner_mob_afk(mob/going_afk)
	SIGNAL_HANDLER

	set_owner_mob(get_best_owner_mob())

/datum/crew/proc/check_owner()
	if(owner_mob)
		return
	var/mob/new_mob = get_best_owner_mob()
	if(new_mob)
		set_owner_mob(new_mob)

// goes through our list of candidates and finds a valid candidate for ship owner, or null if none can be found
/datum/crew/proc/get_best_owner_mob()
	. = null
	for(var/datum/mind/possible as anything in owner_candidates)
		var/mob/cand_mob = get_mob_if_valid_owner(possible)
		if(cand_mob)
			return cand_mob

/datum/crew/proc/get_mob_if_valid_owner(datum/mind/candidate)
	if(!(candidate in owner_candidates) || !owner_candidates[candidate]["eligible"])
		return null
	var/mob/cand_mob = candidate.active ? candidate.current : candidate.get_ghost(FALSE, FALSE)
	// testing trace
	if(cand_mob && cand_mob.mind != candidate)
		stack_trace("AAAAAAAAAAAAAAAGH")
	return (cand_mob != null && cand_mob.client && !cand_mob.client.is_afk() ? cand_mob : null)
