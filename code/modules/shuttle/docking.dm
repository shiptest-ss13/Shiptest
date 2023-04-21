// Q: Why are there so many C-like for loops in this file? Aren't those bad practice?
// A: There's a bug in the BYOND compiler that causes runtiming procs in try blocks within for loops,
//    of the form for(var/i in 1 to N) or similar, to cause the loop to break prematurely if the runtiming proc's
//    return value is being used (such as to store a value or in an if() statement).
//    Thus, all loops of that form in this file have been replaced with their C-like equivalent for consistency,
//    even if the loop can't trigger the bug (such as if it lacks a proc call or try block).

/// This is the main proc. It instantly moves our mobile port to stationary port `new_dock`.
/obj/docking_port/mobile/proc/initiate_docking(obj/docking_port/stationary/new_dock, movement_direction, force=FALSE)
	// Crashing this ship with NO SURVIVORS
	if(new_dock.docked == src)
		remove_ripples()
		return DOCKING_SUCCESS

	if(!force)
		if(!check_dock(new_dock))
			remove_ripples()
			return DOCKING_BLOCKED
		if(!can_move())
			remove_ripples()
			return DOCKING_IMMOBILIZED

	var/obj/docking_port/stationary/old_dock = docked

	/**************************************************************************************************************
		Both lists are associative with a turf:bitflag structure. (new_turfs bitflag space unused currently)
		The bitflag contains the data for what inhabitants of that coordinate should be moved to the new location
		The bitflags can be found in __DEFINES/shuttles.dm
	*/
	var/list/old_turfs = return_ordered_turfs(x, y, z, dir)
	var/list/new_turfs = return_ordered_turfs(new_dock.x, new_dock.y, new_dock.z, new_dock.dir)
	CHECK_TICK
	/**************************************************************************************************************/

	// The underlying old area is the area assumed to be under the shuttle's starting location
	// If it no longer/has never existed it will be created
	var/list/area/underlying_old_area = list()

	var/rotation = 0
	if(new_dock.dir != dir) //Even when the dirs are the same rotation is coming out as not 0 for some reason
		rotation = dir2angle(new_dock.dir)-dir2angle(dir)
		if ((rotation % 90) != 0)
			rotation += (rotation % 90) //diagonal rotations not allowed, round up
		rotation = SIMPLIFY_DEGREES(rotation)

	if(!movement_direction)
		movement_direction = turn(preferred_direction, 180)

	var/list/moved_atoms = list() //Everything not a turf that gets moved in the shuttle
	var/list/areas_to_move = list() //unique assoc list of areas on turfs being moved

	. = preflight_check(old_turfs, new_turfs, areas_to_move, rotation)
	if(.)
		remove_ripples()
		return

	if(!force)
		if(!check_dock(new_dock))
			remove_ripples()
			return DOCKING_BLOCKED
		if(!can_move())
			remove_ripples()
			return DOCKING_IMMOBILIZED

	kill_atmos_infos(old_turfs, new_turfs)

	var/list/obj/docking_port/mobile/all_towed_shuttles = get_all_towed_shuttles()

	// Moving to the new location will trample the ripples there at the exact
	// same time any mobs there are trampled, to avoid any discrepancy where
	// the ripples go away before it is safe.

	takeoff(old_turfs, new_turfs, moved_atoms, rotation, movement_direction, old_dock, new_dock, underlying_old_area, all_towed_shuttles)

	CHECK_TICK

	cleanup_runway(new_dock, old_turfs, new_turfs, areas_to_move, moved_atoms, rotation, movement_direction, underlying_old_area, all_towed_shuttles)

	CHECK_TICK

	//Updating docked properties
	new_dock.docked = src
	if(docked) //Shuttles don't have a dock when initially loaded
		docked.docked = null
	docked = new_dock

	check_poddoors()

	// remove any stragglers just in case, and clear the list
	remove_ripples()

	play_engine_sound(src, launch_sound)
	play_engine_sound(old_dock, launch_sound)
	return DOCKING_SUCCESS

/obj/docking_port/mobile/proc/kill_atmos_infos(list/old_turfs, list/new_turfs)
	for(var/turf/oldT as anything in old_turfs)
		oldT.blocks_air = TRUE
		oldT.set_sleeping(TRUE)
	for(var/turf/newT as anything in new_turfs)
		newT.blocks_air = TRUE
		newT.set_sleeping(TRUE)

/obj/docking_port/mobile/proc/throw_exception(exception/e)
	throw e

/obj/docking_port/mobile/proc/preflight_check(list/old_turfs, list/new_turfs, list/areas_to_move, rotation)
	var/list/exceptions_list = list()
	// Recount turfs since we've got them all anyways
	var/new_turf_count = 0
	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= old_turfs.len, i++)
		try
			CHECK_TICK
			var/turf/oldT = old_turfs[i]
			var/turf/newT = new_turfs[i]
			if(!newT)
				return DOCKING_NULL_DESTINATION
			if(!oldT)
				return DOCKING_NULL_SOURCE

			var/move_mode
			var/area/old_area = oldT.loc

			var/list/area/all_shuttle_areas = list()
			for(var/obj/docking_port/mobile/M in get_all_towed_shuttles())
				all_shuttle_areas |= M.shuttle_areas
			move_mode = old_area.beforeShuttleMove(all_shuttle_areas)											//areas											//areas

			var/list/old_contents = oldT.contents
			// C-like for loop; see top of file for explanation
			for(var/k = 1, k <= old_contents.len, k++)
				try
					CHECK_TICK
					var/atom/movable/moving_atom = old_contents[k]
					if(moving_atom.loc != oldT) //fix for multi-tile objects
						continue
					move_mode = moving_atom.beforeShuttleMove(newT, rotation, move_mode, src)					//atoms
				catch(var/exception/e1)
					exceptions_list += e1

			move_mode = oldT.fromShuttleMove(newT, move_mode)												//turfs
			move_mode = newT.toShuttleMove(oldT, move_mode, src)											//turfs

			if(move_mode & MOVE_AREA)
				areas_to_move[old_area] = TRUE

			if(move_mode & MOVE_TURF)
				new_turf_count++

			old_turfs[oldT] = move_mode

		catch(var/exception/e2)
			exceptions_list += e2

	turf_count = new_turf_count

	for(var/exception/e3 in exceptions_list)
		CHECK_TICK
		throw_exception(e3)

/obj/docking_port/mobile/proc/takeoff(list/old_turfs, list/new_turfs, list/moved_atoms, rotation, movement_direction, obj/docking_port/stationary/old_dock, obj/docking_port/stationary/new_dock, area/underlying_old_area, list/all_towed_shuttles)
	var/list/exceptions_list = list()
	//Keep track of what shuttles we're landing on in case we're relanding on a shuttle we were on.
	var/list/parent_shuttles = list()
	if(old_dock && old_dock.owner_ship)
		old_dock.owner_ship.towed_shuttles -= src
	if(new_dock.owner_ship)
		new_dock.owner_ship.towed_shuttles |= src
		parent_shuttles += new_dock.owner_ship
	//Matrix multiply to get from current coords to new coords
	//Calculate this before this mobile port moves
	var/matrix/displacement_matrix = matrix(-src.x, -src.y, MATRIX_TRANSLATE) * matrix(rotation, MATRIX_ROTATE) *matrix(new_dock.x, new_dock.y, MATRIX_TRANSLATE)
	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= old_turfs.len, i++)
		try
			var/turf/oldT = old_turfs[i]
			var/turf/newT = new_turfs[i]
			var/move_mode = old_turfs[oldT]
			if(move_mode & MOVE_CONTENTS)
				for(var/k in oldT)
					try
						var/atom/movable/moving_atom = k
						if(moving_atom.loc != oldT) //fix for multi-tile objects
							continue
						if(moving_atom.onShuttleMove(newT, oldT, movement_force, movement_direction, old_dock, src, all_towed_shuttles))	//atoms
							moved_atoms[moving_atom] = oldT
					catch(var/exception/e1)
						exceptions_list += e1
		catch(var/exception/e1)
			exceptions_list += e1

	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= old_turfs.len, i++)
		try
			var/turf/oldT = old_turfs[i]
			var/turf/newT = new_turfs[i]
			var/move_mode = old_turfs[oldT]
			if(move_mode & MOVE_TURF)
				var/area/ship/A = oldT.loc
				var/obj/docking_port/mobile/top_shuttle = A?.mobile_port
				var/obj/docking_port/mobile/M = A.mobile_port
				//Initial value offsets shuttles with missing skipover baseturfs being counted.
				var/shuttle_layers = -1*A.get_missing_shuttles(oldT)

				//Count the shuttles on this turf as the number of skipovers we'll go down for the baseturf copy.
				// C-like for loop; see top of file for explanation
				for(var/index = 1, index <= all_towed_shuttles.len, index++)
					M = all_towed_shuttles[index]
					if(!M.underlying_turf_area[oldT]) //This shuttle isn't on this turf
						continue
					shuttle_layers++
					if(M == top_shuttle) //This is the highest shuttle on this turf, end here
						break

				if(shuttle_layers > 0)
					oldT.onShuttleMove(newT, movement_force, movement_direction, shuttle_layers)									//turfs
		catch(var/exception/e2)
			exceptions_list += e2

	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= old_turfs.len, i++)
		try
			var/turf/oldT = old_turfs[i]
			var/turf/newT = new_turfs[i]
			var/move_mode = old_turfs[oldT]
			if(move_mode & MOVE_AREA)
				var/area/ship/shuttle_area = oldT.loc //The area on the shuttle, typecasted for the checks further down
				var/area/ship/target_area = newT.loc //The area we're landing on
				var/area/ship/new_area //The area that we leave behind

				//Find the new area, and update the underlying_turf_area of all towed shuttles
				var/obj/docking_port/mobile/M
				// C-like for loop; see top of file for explanation
				for(var/index = 0, index < all_towed_shuttles.len, index++) // note the different start value and end condition
					M = all_towed_shuttles[all_towed_shuttles.len-index]
					if(!M.underlying_turf_area[oldT]) //the shuttle isn't on this turf
						continue
					new_area = M.underlying_turf_area[oldT]
					M.underlying_turf_area -= oldT
					if(!istype(new_area) || !all_towed_shuttles[new_area.mobile_port]) //If the next area isn't part of a towed shuttle, this is the bottommost shuttle and should set its new underlying area for this turf to the target area
						M.underlying_turf_area[newT] = target_area
						break
					M.underlying_turf_area[newT] = new_area

				if(!new_area) //This shouldn't happen, but just in case
					new_area = GLOB.areas_by_type[SHUTTLE_DEFAULT_UNDERLYING_AREA]
				if(istype(new_area) && new_area.mobile_port && !(new_area.mobile_port in parent_shuttles) && (M in new_area.mobile_port.towed_shuttles)) //Remove bottom shuttle from old parent shuttle's towed_shuttles
					new_area.mobile_port.towed_shuttles -= M
				if(istype(target_area) && target_area.mobile_port) //Add bottom shuttle to new parent shuttle's towed_shuttles
					target_area.mobile_port.towed_shuttles |= M
					parent_shuttles |= target_area.mobile_port //for use in the check above so we don't remove this shuttle from the towed shuttles of a shuttle that we're immediately relanding on.

				underlying_old_area |= new_area //lists are objects, which aren't popped off the stack, so this is the same list that is passed to cleanup runway
				shuttle_area.onShuttleMove(oldT, newT, new_area)										//areas
		catch(var/exception/e3)
			exceptions_list += e3

	for(var/obj/docking_port/stationary/docking_point in docking_points)
		try
			if(!(docking_point in moved_atoms))
				var/matrix/new_loc_matrix = matrix(docking_point.x, docking_point.y, MATRIX_TRANSLATE) * displacement_matrix
				var/oldT = get_turf(docking_point)
				var/newT = locate(new_loc_matrix.c, new_loc_matrix.f, new_dock.z) //This assumes non-multi-z shuttles
				docking_point.onShuttleMove(newT, oldT, movement_force, movement_direction, old_dock, src, all_towed_shuttles)
				moved_atoms[docking_point] = oldT
		catch(var/exception/e3AndAHalf)
			exceptions_list |= e3AndAHalf

	for(var/exception/e4 in exceptions_list)
		CHECK_TICK
		throw_exception(e4)

/obj/docking_port/mobile/proc/cleanup_runway(obj/docking_port/stationary/new_dock, list/old_turfs, list/new_turfs, list/areas_to_move, list/moved_atoms, rotation, movement_direction, area/underlying_old_area, list/all_towed_shuttles)
	var/list/exceptions_list = list()
	for(var/area/A1 in underlying_old_area)
		try
			CHECK_TICK
			A1.afterShuttleMove()
		catch(var/exception/e0)
			exceptions_list += e0

	// Parallax handling
	// This needs to be done before the atom after move
	var/new_parallax_dir = FALSE
	if(istype(new_dock, /obj/docking_port/stationary/transit))
		new_parallax_dir = preferred_direction

	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= areas_to_move.len, i++)
		try
			CHECK_TICK
			var/area/internal_area = areas_to_move[i]
			internal_area.afterShuttleMove(new_parallax_dir)												//areas
		catch(var/exception/e1)
			exceptions_list += e1

	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= old_turfs.len, i++)
		try
			CHECK_TICK
			if(!(old_turfs[old_turfs[i]] & MOVE_TURF))
				continue
			var/turf/oldT = old_turfs[i]
			var/turf/newT = new_turfs[i]
			newT.afterShuttleMove(oldT, rotation, all_towed_shuttles)															//turfs
		catch(var/exception/e2)
			exceptions_list += e2

	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= moved_atoms.len, i++)
		try
			CHECK_TICK
			var/atom/movable/moved_object = moved_atoms[i]
			if(QDELETED(moved_object))
				continue
			var/turf/oldT = moved_atoms[moved_object]
			moved_object.afterShuttleMove(oldT, movement_force, dir, preferred_direction, movement_direction, rotation)//atoms
		catch(var/exception/e3)
			exceptions_list += e3

	// lateShuttleMove (There had better be a really good reason for additional stages beyond this)

	for(var/area/A2 in underlying_old_area)
		try
			CHECK_TICK
			A2.lateShuttleMove()
		catch(var/exception/e4)
			exceptions_list += e4

	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= areas_to_move.len, i++)
		try
			CHECK_TICK
			var/area/internal_area = areas_to_move[i]
			internal_area.lateShuttleMove()
		catch(var/exception/e5)
			exceptions_list += e5

	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= old_turfs.len, i++)
		try
			CHECK_TICK
			if(!(old_turfs[old_turfs[i]] & MOVE_CONTENTS | MOVE_TURF))
				continue
			var/turf/oldT = old_turfs[i]
			var/turf/newT = new_turfs[i]
			newT.lateShuttleMove(oldT)
		catch(var/exception/e6)
			exceptions_list += e6

	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= moved_atoms.len, i++)
		try
			CHECK_TICK
			var/atom/movable/moved_object = moved_atoms[i]
			if(QDELETED(moved_object))
				continue
			var/turf/oldT = moved_atoms[moved_object]
			moved_object.lateShuttleMove(oldT, movement_force, movement_direction)
		catch(var/exception/e7)
			exceptions_list += e7

	for(var/exception/e8 in exceptions_list)
		CHECK_TICK
		throw_exception(e8)

/obj/docking_port/mobile/proc/reset_air()
	var/list/turfs = return_ordered_turfs(x, y, z, dir)

	// C-like for loop; see top of file for explanation
	for(var/i = 1, i <= length(turfs), i++)
		var/turf/open/T = turfs[i]
		if(istype(T))
			T.air.copy_from_turf(T)
