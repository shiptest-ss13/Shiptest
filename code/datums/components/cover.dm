/datum/component/cover
	var/blocking = TRUE
	var/proj_pass_rate = 50 // how many projectiles will pass this cover, lower means stronger cover
	var/block_dir
	var/cover_on_own_tile = FALSE
	// whether the cover should let projectiles come in from similar cover objects. eg sandbags vs random rocks
	var/continuous_cover = FALSE

/datum/component/cover/Initialize(_pass_rate, _block_dir, _blocking)
	. = ..()
	if(!isstructure(parent))
		return
	if(_blocking)
		blocking = _blocking
	if(_pass_rate)
		proj_pass_rate = _pass_rate
	if(_block_dir)
		block_dir = _block_dir
	RegisterSignal(parent, COMSIG_OBJ_UPDATE_COVER, PROC_REF(update_cover))
	RegisterSignal(parent, COMSIG_ATOM_TRY_ALLOW_THROUGH, PROC_REF(try_block))

/datum/component/cover/Destroy(force)
	UnregisterSignal(parent, COMSIG_OBJ_UPDATE_COVER)
	UnregisterSignal(parent, COMSIG_ATOM_TRY_ALLOW_THROUGH)
	return ..()


/datum/component/cover/proc/update_cover(obj/blocker, _pass_rate, _block_dir,  _blocking)
	if(_blocking)
		blocking = _blocking

	if(_pass_rate)
		proj_pass_rate = _pass_rate

	if(_block_dir)
		block_dir = _block_dir
	return

/datum/component/cover/proc/try_block(obj/blocker, atom/movable/mover, border_dir)
	if(locate(blocker.type) in get_turf(mover))
		return TRUE
	else if(istype(mover, /obj/projectile))
		if(!blocker.anchored)
			return TRUE
		var/obj/projectile/proj = mover
		if(proj.firer && blocker.Adjacent(proj.firer))
			return TRUE
		if(prob(proj_pass_rate))
			return TRUE
		return FALSE

