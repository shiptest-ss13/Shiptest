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
			crew.spawn_points_byjob_name[jname] += src

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
	. = P.JoinPlayerHere(M)

/datum/component/spawn_point/proc/connect_to_shuttle(atom/source, obj/docking_port/mobile/port)
	if (crew)
		return
	if (port && port.current_ship && port.current_ship.crew)
		connect_to_crew(port.current_ship.crew)


////
/datum/component/spawn_point/mob_spawn/Initialize(list/_jobs=list(), _exclusive=TRUE)
	if(!istype(parent, /obj/effect/mob_spawn)
		return COMPONENT_INCOMPATIBLE
	return ..()
