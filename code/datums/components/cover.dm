/datum/component/cover
	/// how many projectiles will pass this cover, lower means stronger cover
	var/proj_pass_rate = 50
	/// if this is directional cover (eg. flipped tables)
	var/directional_cover = FALSE
	/// check if the incoming thing is coming from the same type of cover object. If it is, let it through.
	var/continuous_cover = FALSE
	/// if continuous cover is enabled, is there other types this cover should things in from?
	var/allowed_in_from

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
	SIGNAL_HANDLER
	if(pass_rate)
		proj_pass_rate = pass_rate
	return

/datum/component/cover/proc/try_block(obj/blocker, atom/movable/mover, border_dir)
	SIGNAL_HANDLER
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
