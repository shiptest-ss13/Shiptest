/**
 * This component handle crew spawnpoints.
 *
 * It's assumed that is has a parrent on creation.
 */
/datum/component/spawn_point
	/// The crew attatched to this spawnpoint.
	var/datum/crew/crew
	/// The job which this spawnpoint provide, generic spawnpoint (like cryo) if empty.
	var/list/jobs_name
	/// Weather jobs not specified in (jobs_name) can use this spawn point.
	var/exclusive


/**
 *  jobs : List of the jobnames provided by the spawnpoint, accecible to all jobs if empty or null.
 *  exlusive : weather jobs not specified within jobs can use this spawnpoint.
 */
/datum/component/spawn_point/Initialize(list/_jobs=list(), _exclusive=TRUE)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	jobs_name = _jobs
	exclusive = _exclusive


/datum/component/spawn_point/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_CONNECT_TO_SHUTTLE, .proc/connect_to_shuttle)

/datum/component/spawn_point/UnregisterFromParent()
	RegisterSignal(parent, COMSIG_ATOM_CONNECT_TO_SHUTTLE)


/datum/component/spawn_point/proc/connect_to_crew(datum/crew/_crew)
	if(crew)
		disconnect_from_crew()
	crew = _crew
	if(!(jobs_name && jobs_name.len) || !exclusive)
		crew.spawn_points.Add(src)
	if(jobs_name.len)
		for(var/jname in jobs_name)
			if(crew.spawn_points_byjob_name[jname])
				crew.spawn_points_byjob_name[jname] += src
			else
				crew.spawn_points_byjob_name[jname] = list(src)


/datum/component/spawn_point/proc/disconnect_from_crew()
	if(!crew)
		return
	crew.spawn_points -= src
	if(jobs_name && jobs_name.len)
		for(var/jname in jobs_name)
			crew.spawn_points_byjob_name[jname] -= src
	crew = null

/**
 *	Spawn the player at this point
 */
/datum/component/spawn_point/proc/spawn_player(mob/M)
	var/atom/P = parent
	P.JoinPlayerHere(M)
	. = M

/datum/component/spawn_point/proc/connect_to_shuttle(atom/source, obj/docking_port/mobile/port)
	if (crew)
		return
	if (port && port.current_ship && port.current_ship.crew)
		connect_to_crew(port.current_ship.crew)

/**
 *
 * To handle `/obj/effect/mob_spawn`
 *
 */
/datum/component/spawn_point/mob_spawn
	var/uses = 0
	var/datum/job/spawner_job

/**
 * _jobs : must be a list containing exacly one string being the name of the job.
 */
/datum/component/spawn_point/mob_spawn/Initialize(list/_jobs=list(), _exclusive=TRUE)
	if(!istype(parent, /obj/effect/mob_spawn))
		return COMPONENT_INCOMPATIBLE
	..()

/datum/component/spawn_point/mob_spawn/Destroy()
	disconnect_from_crew()

/datum/component/spawn_point/mob_spawn/spawn_player(mob/M)
	var/obj/effect/mob_spawn/P = parent
	. = P.create(M.ckey)
	if (parent) //The parent might get deleted if it's out of use.
		update_uses()

/datum/component/spawn_point/mob_spawn/connect_to_crew(datum/crew/_crew)
	..()
	spawner_job = crew.get_job_by_name(jobs_name[1])
	if(!spawner_job)
		spawner_job = new /datum/job(jobs_name[1], null)
		spawner_job.is_human_job = FALSE
		spawner_job.need_special_spawn_point = TRUE
	update_uses()


/datum/component/spawn_point/mob_spawn/disconnect_from_crew()
	if(!crew)
		return
	update_uses()
	crew.job_slots[spawner_job] -= uses

	uses = 0
	spawner_job = null
	..()

/datum/component/spawn_point/mob_spawn/proc/update_uses()
	if (!crew)
		return
	var/obj/effect/mob_spawn/P = parent
	crew.job_slots[spawner_job] += P.uses - uses
	uses = P.uses
