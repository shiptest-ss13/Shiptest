#define ELEVATOR_IDLE "elevator_idle"
#define ELEVATOR_BUSY "elevator_busy"

// Multi-z "above" and "below" are based on the assumption of equally-sized virtual reserves.
// However, outpost hangars may be differently-sized. Thus, we have to manually handle movement up and down.

// This is paired with a rudimentary (read: shitty) elevator control system I hacked together (One-Car Selective Collective).
// "But wait," you might ask, "wouldn't it be easier to just follow the latest call or movement command?"
// Yes, but it wouldn't lead to funny elevator moments like trying to pack into an already stuffed elevator.
/datum/elevator_master
	/// The list of elevator platforms to be moved by the elevator master. This is the part of the elevator that players and items are moved by.
	var/list/obj/structure/elevator_platform/platforms

	/// amount of time spent between floors while moving
	var/floor_move_time = 3 SECONDS
	/// amount of time spent on a floor after arriving but before opening doors
	var/door_open_time = 2 SECONDS
	/// amount of time spent between opening doors and closing them
	var/floor_idle_time = 7 SECONDS

	/// List of floor datums that the elevator may move between.
	var/list/datum/floor/floor_list = list()

	/// The index into the floor list at which the current floor datum resides. Numbers displayed to players are modified by floor_offset and fake_floors.
	var/cur_index = 1
	/// The direction the elevator is looking for future stops in. This enables the elevator to skip a floor with an order to go DOWN when it is heading UP.
	/// Value is either the dir UP or the dir DOWN, for simplicity.
	var/seeking_dir = DOWN
	/// The elevator's current state. The elevator clears all pending calls / destinations through a chain of procs linked by timers:
	/// check_move() -> move_elevator() -> arrive_on_floor() -> optionally, cycle_doors() -> check_move().
	/// Occasionally, cycle_doors() will be the entry point instead. During this chain, cur_state is ELEVATOR_BUSY. Otherwise,
	/// the elevator is in ELEVATOR_IDLE, and may be activated if a new call or destination is registered.
	var/cur_state = ELEVATOR_IDLE

	/// Player-facing floor numbers are offset by this value. Thus, with the default floor_offset as -1, the first floor
	/// will show as floor "0", the second as floor "1", and so on. This only affects player-facing displays:
	/// floor_list and cur_index behave exactly the same regardless of this value.
	var/floor_offset = -1
	/// If this variable is a positive integer, the status display and elevator buttons will act as though the first
	/// fake_floors floors exist, but are inaccessible. For example, with a floor_offset of -1 and a fake_floors of 2,
	/// the floor controls will display 2 unreachable floors at the bottom of the panel with values "0" and "1".
	/// This only affects player-facing displays: floor_list and cur_index behave exactly the same regardless of this value.
	var/fake_floors = 0

	/// The button machine used by the elevator "car" to control its destination floor.
	var/obj/machinery/elevator_floor_button/button
	/// The button machine used by the elevator "car" to display its current floor, heading direction, and to play sounds from.
	var/obj/machinery/status_display/elevator/display


/datum/elevator_master/New(obj/structure/elevator_platform)
	. = ..()

	// elevator masters are only instanced by elevator platforms in their Initialize() if they have none and cannot find any on adjacent tiles.
	// thus, the first platform in a "blob" of platforms to initialize creates an elevator master, which adopts that platform and all
	// other platforms in the blob.
	for(var/plat in get_platform_blob(elevator_platform))
		add_platform(plat)

/datum/elevator_master/Destroy()
	for(var/obj/structure/elevator_platform/plat as anything in platforms)
		remove_platform(plat)

	if(button)
		button.master = null
	if(display)
		display.master = null
	. = ..()

/*
	Elevator platform management
*/

/// Adds an elevator platform to the list of linked platforms.
/datum/elevator_master/proc/add_platform(obj/structure/elevator_platform/new_platform)
	if(new_platform in platforms)
		return
	new_platform.master_datum = src
	LAZYADD(platforms, new_platform)
	// we don't need to hook qdeletion here; they remove themselves via remove_platform in their Destroy()

/// Removes an elevator platform from the list of linked platforms.
/datum/elevator_master/proc/remove_platform(obj/structure/elevator_platform/old_platform)
	if(!(old_platform in platforms))
		return
	old_platform.master_datum = null
	LAZYREMOVE(platforms, old_platform)

/datum/elevator_master/proc/get_platform_blob(obj/structure/elevator_platform/start)
	// the list of platforms that have yet to be checked for neighbors
	var/list/unchecked_platforms = list(start)
	// platforms whose neighbors have been checked. we will return this list
	var/list/checked_platforms = list()

	while(unchecked_platforms.len)
		// pop platform off the top of the stack
		var/obj/structure/elevator_platform/top_plat = unchecked_platforms[unchecked_platforms.len]
		unchecked_platforms.len -= 1 // did you know this trims off a list's last element?

		// add it to the checked platforms
		checked_platforms += top_plat
		// add its adjacent platforms to the unchecked platforms
		var/list/adj_platforms = top_plat.get_adj_platforms()
		for(var/obj/structure/elevator_platform/new_plat as anything in adj_platforms)
			if(checked_platforms.Find(new_plat) || unchecked_platforms.Find(new_plat))
				continue
			unchecked_platforms += new_plat

	return checked_platforms

/*
	Movement chain entrypoints
*/
// Both of these procs update the elevator's internal floor list with either a call or a destination,
// registered on a floor. If the elevator is idle, they serve as the entrypoint into the check_move() movement chain,
// calling either cycle_doors() or check_move() to send the elevator on its way.
// While this chain is active, the elevator's cur_state is ELEVATOR_BUSY; it will only return to ELEVATOR_IDLE
// once the chain is complete, which only occurs if it has no outstanding destinations or calls.

/datum/elevator_master/proc/add_call_on_floor(datum/floor/floor, call_dir)
	// there used to be a check here that returned if there was already a call in this direction on this floor.
	// however, this resulted in the elevator occasionally getting stuck if left in an invalid state.

	// Elevator is idle (not currently trying to clear all its calls), and thus we can either start it moving or open the doors.
	if(cur_state == ELEVATOR_IDLE)
		// both paths begin the movement chain
		if(floor_list[cur_index] == floor)
			// no need to change the color of the button; just open the doors
			cycle_doors()
		else
			// it's on another floor, but idle, so get it moving
			floor.calls |= call_dir
			floor.button?.update_icon()
			check_move()
		return
	// since the elevator is busy, we do not want to start a new chain
	floor.calls |= call_dir
	floor.button?.update_icon()

/datum/elevator_master/proc/set_dest_on_floor(datum/floor/floor)
	// Elevator is idle (not currently trying to clear all its calls), and thus we can either start it moving or open the doors.
	if(cur_state == ELEVATOR_IDLE)
		// both paths begin the movement chain
		if(floor_list[cur_index] == floor)
			cycle_doors()
		else
			// it's on another floor, but idle, so get it moving
			floor.is_dest = TRUE
			check_move()
		return
	// since the elevator is busy, we do not want to start a new chain
	if(floor_list[cur_index] != floor)
		floor.is_dest = TRUE

/*
	Movement chain procs
*/

// This is what "starts" the elevator moving to another floor; it will recursively call itself through:
// check_move() -> move_elevator() -> arrive_on_floor() -> optionally, cycle_doors() -> check_move(),
// during which it will be ELEVATOR_BUSY, until it has cleared all of the pending calls and destinations,
// thus returning to ELEVATOR_IDLE. Occasionally, cycle_doors() is used as the entry point instead; the chain is the same.
/datum/elevator_master/proc/check_move()
	// Technically, this could be set just above the move_elevator timer, as otherwise it will become busy shortly.
	// However, setting it here makes it clearer that this is the beginning of a chain that will only complete when next_move == NONE.
	cur_state = ELEVATOR_BUSY

	var/flip_dir = REVERSE_DIR(seeking_dir)
	var/next_move = NONE
	if(check_floors_in_dir(cur_index, seeking_dir))
		next_move = seeking_dir
	else if(check_floors_in_dir(cur_index, flip_dir))
		next_move = flip_dir

	if(next_move != NONE)
		// sets in motion a chain of procs that will, after a bit, call check_move() again.
		addtimer(CALLBACK(src, PROC_REF(move_elevator), next_move), floor_move_time)
		return

	// This is the only way the elevator may become idle: if it does not find anywhere to go on check_move().
	cur_state = ELEVATOR_IDLE

// Returns TRUE if there is a floor in the given direction after the current one which should be visited while travelling that direction.
// That is, the floor is set as a destination, or has a call in the direction being moved in, or both. This is used to prevent, for instance,
// a call to head DOWN being visited while the elevator is fulfilling a request to move UP to a higher floor.
/datum/elevator_master/proc/check_floors_in_dir(start_index, check_dir)
	var/step = (check_dir == DOWN ? -1 : 1)
	// looks for floors in the direction passed, starting at the first floor in that direction from the passed start_index
	for(var/i = start_index + step, i >= 1 && i <= length(floor_list), i += step)
		var/datum/floor/i_floor = floor_list[i]
		if(i_floor.is_dest || i_floor.calls)
			return TRUE
	return FALSE

// Moves the elevator platforms either UP or DOWN, and updates the seeking_dir in that direction.
// Calls arrive_on_floor(), continuing the chain; the two are separated for easier readability.
/datum/elevator_master/proc/move_elevator(going)
	// DOWN moves towards the first floor, UP moves towards the last.
	var/new_index = cur_index + (going == DOWN ? -1 : 1)
	if(new_index < 1 || new_index > length(floor_list))
		return
	var/turf/cur_anchor = floor_list[cur_index].anchor
	var/turf/new_anchor = floor_list[new_index].anchor
	for(var/obj/structure/elevator_platform/plat as anything in platforms)
		var/turf/platform_dest = locate(
			new_anchor.x + (plat.x - cur_anchor.x),
			new_anchor.y + (plat.y - cur_anchor.y),
			new_anchor.z
		)
		plat.travel(platform_dest, FALSE)
	cur_index = new_index
	seeking_dir = going

	arrive_on_floor()

/datum/elevator_master/proc/arrive_on_floor()
	var/datum/floor/cur_floor = floor_list[cur_index]

	// open if there is a destination on this floor
	// OR a call on this floor in the direction we're already headed
	var/open_on_floor = (cur_floor.is_dest || (cur_floor.calls & seeking_dir))
	// OR if there is a call on this floor in the opposite direction WITHOUT any other landings in the direction we're headed
	if(!open_on_floor && (cur_floor.calls & REVERSE_DIR(seeking_dir)) && !check_floors_in_dir(cur_index, seeking_dir))
		open_on_floor = TRUE
		seeking_dir = REVERSE_DIR(seeking_dir)

	if(display)
		display.set_message("[cur_index + fake_floors + floor_offset]", seeking_dir == UP ? "UP" : "DOWN")
		display.update()
		if(open_on_floor)
			playsound(
				display,
				seeking_dir == UP ? 'sound/items/ding.ogg' : 'sound/items/ding_twice.ogg',
				100,
				FALSE
			)
		else
			// quieter
			playsound(display, 'sound/misc/compiler-stage1.ogg', 75, FALSE)

	// These continue the movement chain.
	// cycle_doors() eventually invokes check_move() via timers.
	if(open_on_floor)
		cycle_doors()
	else
		check_move()

// Typically, this is called by a check_move() recursive chain to stop on a floor. However, it may also be called when a user
// presses the call button on a floor on which the elevator is currently present. Thus, cur_state is set to ELEVATOR_BUSY
// so that the elevator is correctly busy until it finishes its chain.
/datum/elevator_master/proc/cycle_doors()
	cur_state = ELEVATOR_BUSY
	var/datum/floor/cur_floor = floor_list[cur_index]
	cur_floor.is_dest = FALSE
	cur_floor.calls &= ~seeking_dir
	cur_floor.button?.update_icon()

	addtimer(CALLBACK(src, PROC_REF(open_doors), cur_floor), door_open_time)
	addtimer(CALLBACK(src, PROC_REF(close_doors), cur_floor), door_open_time+floor_idle_time)
	// Continue the check_move() chain.
	addtimer(CALLBACK(src, PROC_REF(check_move)), door_open_time+floor_idle_time+(1 SECONDS))

/datum/elevator_master/proc/open_doors(datum/floor/d_floor)
	for(var/obj/machinery/door/fl_door as anything in d_floor.doors)
		if(!fl_door.hasPower())
			continue
		if(!fl_door.wires.is_cut(WIRE_BOLTS))
			fl_door.unlock()
		fl_door.autoclose = FALSE
		INVOKE_ASYNC(fl_door, TYPE_PROC_REF(/obj/machinery/door, open))

/datum/elevator_master/proc/close_doors(datum/floor/d_floor)
	for(var/obj/machinery/door/fl_door as anything in d_floor.doors)
		// respect the cut wire
		fl_door.autoclose = fl_door.wires.is_cut(WIRE_TIMING)
		INVOKE_ASYNC(fl_door, TYPE_PROC_REF(/obj/machinery/door, close))
		// bolts can be lowered without power, or a cut wire (since if wire is cut they're automatically down)
		fl_door.lock()

/*
	Floor-management procs
*/

/// Given an elevator landmark and list of elevator machine landmarks, creates a floor by calling add_floor and qdeletes the passed landmarks after pulling the objects they mark.
/datum/elevator_master/proc/add_floor_landmarks(obj/effect/landmark/outpost/elevator/anchor, list/obj/effect/landmark/outpost/elevator_machine/machine_marks)
	var/turf/anchor_turf = anchor.loc
	var/obj/machinery/elevator_call_button/button
	var/obj/machinery/door/doors = list()

	for(var/obj/effect/landmark/outpost/elevator_machine/mach_mark as anything in machine_marks)
		if(!button)
			button = locate() in mach_mark.loc
		var/obj/machinery/door/a_door = locate() in mach_mark.loc
		if(a_door)
			doors += a_door
		qdel(mach_mark)
	qdel(anchor)

	add_floor(anchor_turf, button, doors)
	return

/// Adds a floor to the elevator's floor list. Default behavior is to append the floor.
/// Index passed should not exceed the floor list's current length.
/datum/elevator_master/proc/add_floor(turf/anchor, obj/machinery/elevator_call_button/button, list/obj/machinery/door/doors, index = 0)
	// if we're adding to the middle of the floor list, we may have to update the current index
	// 0 appends to the END of the list, hence the check if index is nonzero
	if(index != 0 && index <= cur_index)
		cur_index++

	var/datum/floor/new_floor = new(src, anchor, button, doors)
	floor_list.Insert(index, new_floor)

/// Removes a floor from the elevator's floor list. If the floor is equal to the elevator's current floor, fails and returns FALSE.
/// Otherwise, the floor is removed, the current floor's number is updated if necessary, and returns TRUE.
/// Currently unused.
/datum/elevator_master/proc/remove_floor(index)
	if(index == cur_index)
		return FALSE

	if(index < cur_index)
		cur_index--

	qdel(floor_list[index])
	floor_list.Cut(index, index+1)
	return TRUE

/*
	Floor data structure
*/

/// Keeping a reference to master makes cleanup easier.
/datum/floor
	var/datum/elevator_master/master

	var/calls = NONE
	var/is_dest = FALSE

	var/turf/anchor
	var/obj/machinery/elevator_call_button/button
	var/list/obj/machinery/door/doors

/datum/floor/New(_master, _anchor, _button, list/_doors)
	master = _master
	anchor = _anchor
	button = _button
	doors = _doors
	if(button)
		button.my_floor = src
	for(var/obj/machinery/door/fl_door as anything in doors)
		// you can always lower the bolts; doors are locked on floor creation to ensure no entry into shaft
		fl_door.lock()
		// don't want door refs hanging around
		RegisterSignal(fl_door, COMSIG_QDELETING, PROC_REF(door_qdelete))

// Deletion via means other than /datum/elevator_master/remove_floor() are likely to cause nasty elevator desyncs.
/datum/floor/Destroy()
	master.floor_list -= src

	if(button)
		button.my_floor = null
		button.update_icon()
	. = ..()

/datum/floor/proc/door_qdelete(datum/source)
	doors -= source

#undef ELEVATOR_IDLE
#undef ELEVATOR_BUSY
