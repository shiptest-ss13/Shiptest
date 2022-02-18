/datum/component/shiploving
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	var/inform_admins = FALSE
	var/disallow_soul_imbue = TRUE
	var/allow_death = FALSE
	var/datum/overmap/ship/controlled/parent_ship

/datum/component/shiploving/Initialize(parent_ship, inform_admins = FALSE, allow_death = FALSE)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_MOVABLE_Z_CHANGED), .proc/check_in_bounds)
	RegisterSignal(parent, list(COMSIG_MOVABLE_SECLUDED_LOCATION), .proc/relocate)
	RegisterSignal(parent, list(COMSIG_PARENT_PREQDELETED), .proc/check_deletion)
	RegisterSignal(parent, list(COMSIG_ITEM_IMBUE_SOUL), .proc/check_soul_imbue)
	RegisterSignal(parent, list(COMSIG_ITEM_MARK_RETRIEVAL), .proc/check_mark_retrieval)
	src.inform_admins = inform_admins
	src.allow_death = allow_death
	src.parent_ship = parent_ship
	if(!parent_ship)
		for(var/datum/overmap/ship/controlled/ship as anything in SSovermap.controlled_ships)
			if(get_area(parent) in ship.shuttle_port.shuttle_areas)
				parent_ship = ship
				break
	if(!parent_ship)
		message_admins("[parent] created with [type] outside a ship, assigning a ship at random!")
		parent_ship = pick(SSovermap.controlled_ships)
	check_in_bounds() // Just in case something is being created outside of station/centcom

/datum/component/shiploving/InheritComponent(datum/component/shiploving/newc, i_am_original, parent_ship, inform_admins, allow_death)
	if (i_am_original)
		if (newc)
			inform_admins = newc.inform_admins
			allow_death = newc.allow_death
			parent_ship = newc.parent_ship
		else
			inform_admins = inform_admins

/datum/component/shiploving/proc/relocate()
	SIGNAL_HANDLER
	var/turf/targetturf
	for(var/area/area as anything in parent_ship.shuttle_port.shuttle_areas)
		var/obj/machinery/computer/helm/helm = locate() in area
		if(helm)
			targetturf = get_turf(helm)
			break
	if(!targetturf)
		message_admins("[type] failed to locate targetturf for [parent]")
		return null
	playsound(parent, 'sound/machines/synth_no.ogg', 5, TRUE)
	var/atom/movable/parent_atom = src.parent
	parent_atom.forceMove(targetturf)
	to_chat(get(parent, /mob), "<span class='danger'>You can't help but feel that you just lost something back there...</span>")
	return targetturf

/datum/component/shiploving/proc/check_in_bounds()
	SIGNAL_HANDLER

	if(in_bounds())
		return
	else
		var/turf/currentturf = get_turf(src)
		var/turf/targetturf = relocate()
		log_game("[parent] has been moved out of bounds in [loc_name(currentturf)]. Moving it to [loc_name(targetturf)].")
		if(inform_admins)
			message_admins("[parent] has been moved out of bounds in [ADMIN_VERBOSEJMP(currentturf)]. Moving it to [ADMIN_VERBOSEJMP(targetturf)].")

/datum/component/shiploving/proc/check_soul_imbue()
	SIGNAL_HANDLER

	return disallow_soul_imbue

/datum/component/shiploving/proc/check_mark_retrieval()
	SIGNAL_HANDLER

	return COMPONENT_BLOCK_MARK_RETRIEVAL

/datum/component/shiploving/proc/in_bounds()
#ifdef UNIT_TESTS
	return TRUE // during unit tests ships are loaded without being added to the overmap
#else
	var/datum/virtual_level/v_ship = parent_ship.shuttle_port.get_virtual_level()
	return v_ship.is_in_bounds(parent)
#endif

/datum/component/shiploving/proc/check_deletion(datum/source, force) // TRUE = interrupt deletion, FALSE = proceed with deletion

	SIGNAL_HANDLER


	var/turf/T = get_turf(parent)

	if(inform_admins && force)
		message_admins("[parent] has been !!force deleted!! in [ADMIN_VERBOSEJMP(T)].")
		log_game("[parent] has been !!force deleted!! in [loc_name(T)].")

	if(!force && !allow_death)
		var/turf/targetturf = relocate()
		log_game("[parent] has been destroyed in [loc_name(T)]. Moving it to [loc_name(targetturf)].")
		if(inform_admins)
			message_admins("[parent] has been destroyed in [ADMIN_VERBOSEJMP(T)]. Moving it to [ADMIN_VERBOSEJMP(targetturf)].")
		return TRUE
	return FALSE
