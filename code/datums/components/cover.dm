/datum/component/cover
	var/blocking = TRUE
	var/proj_pass_rate = 50 // how many projectiles will pass this cover, lower means stronger cover
	var/block_dir
	var/cover_on_own_tile = FALSE

/datum/component/cover/Initialize(blocking, pass_rate, block_dir)
	. = ..()
	if(!isstructure(parent))
		return
	RegisterSignal(parent, COMSIG_OBJ_UPDATE_COVER, PROC_REF(update_cover))

/datum/component/cover/proc/update_cover()
	return

/datum/component/cover/proc/try_block()
	return

