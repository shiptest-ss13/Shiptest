/datum/component/cover
	var/proj_pass_rate = 50 // how many projectiles will pass this cover, lower means stronger cover
	var/directional_cover = FALSE // if this is directional cover (eg. flipped tables)
	var/cover_on_own_tile = FALSE
	// whether the cover should let projectiles come in from similar cover objects. eg sandbags vs random rocks
	var/continuous_cover = FALSE
	var/allowed_in_from // if continuous cover is enabled, is there other types this cover should allow projectiles in from?

/datum/component/cover/Initialize(pass_rate, d_cover, continuous, allowed)
	. = ..()
	if(!isatom(parent))
		return
	if(pass_rate)
		proj_pass_rate = pass_rate
	if(d_cover)
		directional_cover = d_cover
	if(continuous)
		continuous_cover = continuous
	if(allowed)
		allowed_in_from = allowed
	RegisterSignal(parent, COMSIG_OBJ_UPDATE_COVER, PROC_REF(update_cover))
	RegisterSignal(parent, COMSIG_ATOM_TRY_ALLOW_THROUGH, PROC_REF(try_block))

/datum/component/cover/Destroy(force)
	UnregisterSignal(parent, COMSIG_OBJ_UPDATE_COVER)
	UnregisterSignal(parent, COMSIG_ATOM_TRY_ALLOW_THROUGH)
	return ..()


/datum/component/cover/proc/update_cover(obj/blocker, pass_rate)
	if(pass_rate)
		proj_pass_rate = pass_rate
	return

/datum/component/cover/proc/try_block(obj/blocker, atom/movable/mover, border_dir)
	var/turf/mover_turf = get_turf(mover)
	if(continuous_cover && ((locate(blocker.type) in mover_turf) || (locate(allowed_in_from) in mover_turf)))
		return TRUE
	else if(istype(mover, /obj/projectile))
		if(!blocker.anchored)
			return TRUE
		var/obj/projectile/proj = mover
		if(proj.firer && blocker.Adjacent(proj.firer))
			return TRUE
		if(directional_cover && blocker.dir != border_dir)
			return TRUE
		if(prob(proj_pass_rate))
			return TRUE
		return FALSE

