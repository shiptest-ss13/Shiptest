/*
All ShuttleMove procs go here
*/

/************************************Base procs************************************/

// Called on every turf in the shuttle region, returns a bitflag for allowed movements of that turf
// returns the new move_mode (based on the old)
/turf/proc/fromShuttleMove(turf/newT, move_mode)
	if(!(move_mode & MOVE_AREA) || !isshuttleturf(src))
		return move_mode

	clear_adjacencies()

	return move_mode | MOVE_TURF | MOVE_CONTENTS

// Called from the new turf before anything has been moved
// Only gets called if fromShuttleMove returns true first
// returns the new move_mode (based on the old)
/turf/proc/toShuttleMove(turf/oldT, move_mode, obj/docking_port/mobile/shuttle)
	. = move_mode
	if(!(. & MOVE_TURF))
		return

	clear_adjacencies()

	for(var/atom/movable/thing as anything in contents)
		if(ismob(thing))
			if(isliving(thing))
				var/mob/living/M = thing
				if(M.buckled)
					M.buckled.unbuckle_mob(M, 1)
				if(M.pulledby)
					M.pulledby.stop_pulling()
				M.stop_pulling()
				M.visible_message(span_warning("[shuttle] slams into [M]!"))
				SSblackbox.record_feedback("tally", "shuttle_gib", 1, M.type)
				log_attack("[key_name(M)] was shuttle gibbed by [shuttle].")
				if(isanimal(M) || isbasicmob(M))
					qdel(M)
				else
					M.gib()


		else //non-living mobs shouldn't be affected by shuttles, which is why this is an else
			if(!isobj(thing))
				qdel(thing)
				continue
			var/obj/object = thing
			if(object.resistance_flags & LANDING_PROOF)
				continue
			qdel(thing)

// Called on the old turf to move the turf data
/turf/proc/onShuttleMove(turf/newT, list/movement_force, move_dir, shuttle_layers)
	if(newT == src) // In case of in place shuttle rotation shenanigans.
		return
	//Destination turf changes
	//Baseturfs is definitely a list or this proc wouldnt be called
	var/depth = 0
	for(var/k in 0 to baseturfs.len-2) //2 less than the length because we never want to cut the entire baseturf list.
		if(baseturfs[baseturfs.len-k] != /turf/baseturf_skipover/shuttle)
			continue
		shuttle_layers--
		if(!shuttle_layers)
			depth = k + 1
			break
	if(!depth)
		CRASH("A turf queued to move via shuttle somehow had no skipover in baseturfs. [src]([type]):[loc]")

	//The current type is added to the old baseturfs with CopyOnTop, so the next index after the old turf would be 2 more than the current baseturfs length.
	var/inject_index = islist(newT.baseturfs) ? newT.baseturfs.len + 2 : 3
	newT.CopyOnTop(src, 1, depth, TRUE, CHANGETURF_DEFER_CHANGE)
	var/area/ship/new_loc = get_area(newT)
	if(istype(new_loc) && new_loc.mobile_port) //Keep track of hull breached shuttles
		for(var/i in 0 to new_loc.get_missing_shuttles(newT)) //Start at 0 because get_missing_shuttles() will report 1 less missing shuttle because of the CopyOnTop()
			newT.baseturfs.Insert(inject_index, /turf/baseturf_skipover/shuttle)

	return TRUE

// Called on the new turf after everything has been moved
/turf/proc/afterShuttleMove(turf/oldT, rotation, list/all_towed_shuttles)
	//Dealing with the turf we left behind
	oldT.TransferComponents(src)
	src.base_icon_state = oldT.base_icon_state
	SEND_SIGNAL(oldT, COMSIG_TURF_AFTER_SHUTTLE_MOVE, src) //Mostly for decals

	if(rotation)
		shuttleRotate(rotation) //see shuttle_rotate.dm

	//find the boundary between the shuttle that left and what remains
	var/area/ship/ship_area = loc
	if(!istype(ship_area))
		return TRUE

	//Only run this code if it's a ship area
	var/obj/docking_port/mobile/top_shuttle = ship_area.mobile_port
	var/shuttle_layers = -1 * ship_area.get_missing_shuttles(src)
	for(var/index in 1 to length(all_towed_shuttles))
		var/obj/docking_port/mobile/M = all_towed_shuttles[index]
		if(!M.underlying_turf_area[src])
			continue
		shuttle_layers++
		if(M == top_shuttle)
			break
	var/BT_index = length(baseturfs)
	var/BT
	for(var/i in 1 to shuttle_layers)
		while(BT_index)
			BT = baseturfs[BT_index--]
			if(BT == /turf/baseturf_skipover/shuttle)
				break
	if(!BT_index && length(baseturfs))
		CRASH("A turf queued to clean up after a shuttle dock somehow didn't have enough skipovers in baseturfs. [oldT]([oldT.type]):[oldT.loc]")

	if(BT_index != length(baseturfs))
		oldT.ScrapeAway(baseturfs.len - BT_index, CHANGETURF_FORCEOP|CHANGETURF_DEFER_CHANGE)

	return TRUE

/turf/proc/lateShuttleMove(turf/oldT)
	AfterChange()
	oldT.AfterChange()


/////////////////////////////////////////////////////////////////////////////////////

// Called on every atom in shuttle turf contents before anything has been moved
// returns the new move_mode (based on the old)
// WARNING: Do not leave turf contents in beforeShuttleMove or dock() will runtime
/atom/movable/proc/beforeShuttleMove(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	SHOULD_CALL_PARENT(TRUE)
	return move_mode

// Called on atoms to move the atom to the new location
/atom/movable/proc/onShuttleMove(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock, list/obj/docking_port/mobile/towed_shuttles)
	SHOULD_CALL_PARENT(TRUE)
	if(newT == oldT) // In case of in place shuttle rotation shenanigans.
		return

	if(loc != oldT) // This is for multi tile objects
		return

	abstract_move(newT)

	return TRUE

// Called on atoms after everything has been moved
/atom/movable/proc/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	SHOULD_CALL_PARENT(TRUE)
	if(light)
		update_light()
	if(rotation)
		shuttleRotate(rotation)
	update_parallax_contents()
	return TRUE

/atom/movable/proc/lateShuttleMove(turf/oldT, list/movement_force, move_dir)
	SHOULD_CALL_PARENT(TRUE)
	if(!movement_force || anchored)
		return
	var/throw_force = movement_force["THROW"]
	if(!throw_force)
		return
	var/turf/target = get_edge_target_turf(src, move_dir)
	var/range = throw_force * 10
	range = CEILING(rand(range-(range*0.1), range+(range*0.1)), 10)/10
	var/speed = range/5
	safe_throw_at(target, range, speed, force = MOVE_FORCE_EXTREMELY_STRONG)

/////////////////////////////////////////////////////////////////////////////////////

// Called on areas before anything has been moved
// returns the new move_mode (based on the old)
/area/proc/beforeShuttleMove(list/shuttle_areas)
	if(!shuttle_areas[src])
		return NONE
	return MOVE_AREA

// Called on areas to move their turf between areas
/area/proc/onShuttleMove(turf/oldT, turf/newT, area/underlying_old_area)
	if(newT == oldT) // In case of in place shuttle rotation shenanigans.
		return TRUE

	contents -= oldT
	underlying_old_area.contents += oldT
	oldT.change_area(src, underlying_old_area)
	//The old turf has now been given back to the area that turf originaly belonged to

	var/area/old_dest_area = newT.loc
	parallax_movedir = old_dest_area.parallax_movedir

	old_dest_area.contents -= newT
	contents += newT
	newT.change_area(old_dest_area, src)
	return TRUE

// Called on areas after everything has been moved
/area/proc/afterShuttleMove(new_parallax_dir)
	parallax_movedir = new_parallax_dir
	return TRUE

/area/proc/lateShuttleMove()
	return

/************************************Turf move procs************************************/

/************************************Area move procs************************************/

/************************************Machinery move procs************************************/

/obj/machinery/door/airlock/beforeShuttleMove(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	for(var/obj/machinery/door/airlock/A in range(1, src))  // includes src
		A.shuttledocked = FALSE
		A.air_tight = TRUE
		INVOKE_ASYNC(A, TYPE_PROC_REF(/obj/machinery/door, close))

/obj/machinery/door/airlock/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	update_aac_docked(oldT)
	update_aac_docked()
	var/current_area = get_area(src)
	for(var/obj/machinery/door/airlock/A in orange(1, src))  // does not include src
		if(get_area(A) != current_area)  // does not include double-wide airlocks unless actually docked
			// Cycle linking is only disabled if we are actually adjacent to another airlock
			shuttledocked = TRUE
			A.shuttledocked = TRUE

/obj/machinery/camera/beforeShuttleMove(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(. & MOVE_AREA)
		. |= MOVE_CONTENTS
		GLOB.cameranet.removeCamera(src)

/obj/machinery/camera/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	GLOB.cameranet.addCamera(src)

/obj/machinery/mech_bay_recharge_port/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir)
	. = ..()
	recharging_turf = get_step(loc, dir)

/obj/machinery/atmospherics/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	if(pipe_vision_img)
		pipe_vision_img.loc = loc

/obj/machinery/computer/auxillary_base/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	SSblackbox.record_feedback("associative", "colonies_dropped", 1, list("x" = x, "y" = y, "z" = z))

/obj/machinery/gravity_generator/main/beforeShuttleMove(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	on = FALSE
	update_list()

/obj/machinery/gravity_generator/main/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	if(charge_count != 0 && charging_state != POWER_UP)
		on = TRUE
	update_list()

/obj/machinery/atmospherics/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	var/missing_nodes = FALSE
	for(var/i in 1 to device_type)
		if(nodes[i])
			var/obj/machinery/atmospherics/node = nodes[i]
			var/connected = FALSE
			for(var/D in GLOB.cardinals)
				if(node in get_step(src, D))
					connected = TRUE
					break

			if(!connected)
				nullifyNode(i)

		if(!nodes[i])
			missing_nodes = TRUE

	if(missing_nodes)
		atmosinit()
		for(var/obj/machinery/atmospherics/A in pipeline_expansion())
			A.atmosinit()
			if(A.returnPipenet())
				A.addMember(src)
		SSair.add_to_rebuild_queue(src)
	else
		// atmosinit() calls update_appearance(), so we don't need to call it
		update_appearance()

/************************************Item move procs************************************/


/obj/item/storage/pod/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	// If the pod was launched, the storage will always open. The reserved_level check
	// ignores the movement of the shuttle from the transit level to
	// the station as it is loaded in.
	if (oldT && !is_reserved_level(oldT))
		unlocked = TRUE

/obj/item/gun/lateShuttleMove(turf/oldT, list/movement_force, move_dir)
	. = ..()
	if(prob(GUN_NO_SAFETY_MALFUNCTION_CHANCE_MEDIUM))
		discharge("is thrown around by the force of the take off")

/************************************Mob move procs************************************/

/mob/onShuttleMove(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock, list/obj/docking_port/mobile/towed_shuttles)
	if(!move_on_shuttle)
		return
	. = ..()

/mob/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	if(!move_on_shuttle)
		return
	. = ..()
	if(client && movement_force)
		var/shake_force = max(movement_force["THROW"], movement_force["KNOCKDOWN"])
		if(buckled)
			shake_force *= 0.25
		shake_camera(src, shake_force, 1)

/mob/living/lateShuttleMove(turf/oldT, list/movement_force, move_dir)
	if(buckled)
		return

	. = ..()

	var/knockdown = movement_force["KNOCKDOWN"]
	if(knockdown)
		Paralyze(knockdown)


/mob/living/simple_animal/hostile/megafauna/onShuttleMove(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock, list/obj/docking_port/mobile/towed_shuttles)
	. = ..()
	message_admins("Megafauna [src] [ADMIN_FLW(src)] moved via shuttle from [ADMIN_COORDJMP(oldT)] to [ADMIN_COORDJMP(loc)]")

/************************************Structure move procs************************************/

/obj/structure/grille/beforeShuttleMove(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(. & MOVE_AREA)
		. |= MOVE_CONTENTS

/obj/structure/lattice/beforeShuttleMove(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(. & MOVE_AREA)
		. |= MOVE_CONTENTS

/obj/structure/cable/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	if(powernet)
		powernet.remove_cable(src)

/obj/structure/cable/lateShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	propagate_if_no_network()

/obj/structure/shuttle/beforeShuttleMove(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(. & MOVE_AREA)
		. |= MOVE_CONTENTS

/obj/structure/ladder/beforeShuttleMove(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if (!(resistance_flags & INDESTRUCTIBLE))
		disconnect()

/obj/structure/ladder/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	if (!(resistance_flags & INDESTRUCTIBLE))
		LateInitialize()

/obj/structure/ladder/onShuttleMove(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock, list/obj/docking_port/mobile/towed_shuttles)
	if (resistance_flags & INDESTRUCTIBLE)
		// simply don't be moved
		return FALSE
	return ..()

/************************************Misc move procs************************************/

/atom/movable/lighting_object/onShuttleMove()
	SHOULD_CALL_PARENT(FALSE)
	return FALSE

/obj/docking_port/mobile/beforeShuttleMove(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(moving_dock == src)
		. |= MOVE_CONTENTS

/obj/docking_port/mobile/onShuttleMove(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock, list/obj/docking_port/mobile/towed_shuttles)
	if(!towed_shuttles[src] && !moving_dock.can_move_docking_ports)
		return FALSE
	. = ..()

/obj/docking_port/stationary/onShuttleMove(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock, list/obj/docking_port/mobile/towed_shuttles)
	if(old_dock == src) //Never take our old port
		return FALSE
	if((!(src in moving_dock.docking_points) || !towed_shuttles[docked]) && !moving_dock.can_move_docking_ports)
		return FALSE
	. = ..()
