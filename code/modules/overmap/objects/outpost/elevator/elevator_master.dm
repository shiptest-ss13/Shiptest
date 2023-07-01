#define ELEVATOR_IDLE "elevator_idle"
#define ELEVATOR_BUSY "elevator_busy"

// DEBUG: redo documentation

// Multi-z "above" and "below" are based on the assumption of equally-sized virtual reserves.
// However, outpost hangars may be differently-sized. Thus, we have to manually handle movement up and down.

// This is paired with a rudimentary (read: shitty) elevator control system I hacked together (One-Car Selective Collective).
// "But wait," you might ask, "wouldn't it be easier to just follow the latest call or movement command?"
// Yes, but it wouldn't lead to funny elevator moments like trying to pack into an already stuffed elevator.
/datum/elevator_master
	var/list/platforms

	/// amount of time spent between floors while moving
	var/floor_move_time = 5 SECONDS
	/// amount of time spent on a floor after arriving but before opening doors
	var/door_open_time = 2 SECONDS
	/// amount of time spent between opening doors and closing them
	var/floor_idle_time = 8 SECONDS

	var/list/datum/floor/floor_list = list()

	var/cur_index = 1
	var/seeking_dir = DOWN
	var/cur_state = ELEVATOR_IDLE

	/// If floor_offset is a positive integer, the status display and elevator buttons will
	/// act as though the first floor_offset floors exist, but are inaccessible.
	/// For example, if floor_offset is 2, floor 1 will appear as though it is floor 3.
	/// This only affects player-facing displays, and has no impact on internal data structures.
	var/floor_offset = 0

	// button for the elevator car
	var/obj/machinery/elevator_floor_button/button
	// display for the elevator car
	var/obj/machinery/status_display/elevator/display


/datum/elevator_master/New(obj/structure/elevator_platform)
	. = ..()

	// elevator masters are only instanced by elevator platforms after their spawn
	// when they are, it's a sign that a flood-fill is needed
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

/datum/elevator_master/proc/add_platform(obj/structure/elevator_platform/new_platform)
	if(new_platform in platforms)
		return
	new_platform.master_datum = src
	LAZYADD(platforms, new_platform)
	// we don't need to hook qdeletion here; they remove themselves via remove_platform in their Destroy()

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
/datum/elevator_master/proc/remove_floor(index)
	if(index == cur_index)
		return FALSE

	if(index < cur_index)
		cur_index--

	qdel(floor_list[index])
	floor_list.Cut(index, index+1)
	return TRUE

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

	return add_floor(anchor_turf, button, doors)

/datum/elevator_master/proc/move_elevator(going)
	// DOWN moves towards the first floor, UP moves towards the last.
	var/new_index = cur_index + (going == DOWN ? -1 : 1)
	// DEBUG: this check should be present in outer layers as well
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

/datum/elevator_master/proc/check_floors_in_dir(start_index, check_dir)
	var/step = (check_dir == DOWN ? -1 : 1)
	// looks for floors in the direction passed, starting at the first floor in that direction from the passed start_index
	for(var/i = start_index + step, i >= 1 && i <= length(floor_list), i += step)
		var/datum/floor/i_floor = floor_list[i]
		if(i_floor.is_dest || i_floor.calls)
			return TRUE
	return FALSE

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
		// DEBUG: inadequate for correct sync on landing, i.e. it will say it is going UP when it lands on a floor without a queued direction
		display.set_message("[cur_index+floor_offset]", seeking_dir == UP ? "UP" : "DOWN")
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

	// cycle_doors() eventually collapses down to check_move().
	if(open_on_floor)
		cycle_doors()
	else
		check_move()


/datum/elevator_master/proc/cycle_doors()
	if(cur_state != ELEVATOR_IDLE) // sanity check. if the elevator is doing ANYTHING, don't open doors.
		return

	cur_state = ELEVATOR_BUSY
	var/datum/floor/cur_floor = floor_list[cur_index]
	cur_floor.is_dest = FALSE
	cur_floor.calls &= ~seeking_dir
	cur_floor.button?.update_icon()

	addtimer(CALLBACK(src, .proc/open_doors, cur_floor), door_open_time)
	addtimer(CALLBACK(src, .proc/close_doors, cur_floor), door_open_time+floor_idle_time)
	// check_move starts a chain that ultimately ends with us back in ELEVATOR_IDLE
	addtimer(CALLBACK(src, .proc/check_   move), door_open_time+floor_idle_time+(1 SECONDS))

/datum/elevator_master/proc/check_move()
	var/flip_dir = REVERSE_DIR(seeking_dir)
	var/next_move = NONE
	if(check_floors_in_dir(cur_index, seeking_dir))
		next_move = seeking_dir
	else if(check_floors_in_dir(cur_index, flip_dir))
		next_move = flip_dir
	if(next_move != NONE)
		cur_state = ELEVATOR_BUSY
		addtimer(CALLBACK(src, .proc/move_elevator, next_move), floor_move_time)
	else
		cur_state = ELEVATOR_IDLE

/datum/elevator_master/proc/add_call_on_floor(datum/floor/floor, call_dir)
	// there used to be a check here that returned if there was already a call in this direction on this floor.
	// however, this resulted in the elevator occasionally getting stuck if left in an invalid state.

	// elevator is just sitting somewhere, not moving or performing a door cycle
	if(cur_state == ELEVATOR_IDLE)
		// both of these change the state away from ELEVATOR_IDLE
		if(floor_list[cur_index] == floor)
			cycle_doors()
			// no need to change the color of the button
		else
			floor.calls |= call_dir
			floor.button?.update_icon()
			check_move()
	else
		floor.calls |= call_dir
		floor.button?.update_icon()

/datum/elevator_master/proc/set_dest_on_floor(datum/floor/floor)
	// elevator is not moving / cycling doors
	if(cur_state == ELEVATOR_IDLE)
		// ensures a state change
		if(floor_list[cur_index] == floor)
			cycle_doors()
		else
			floor.is_dest = TRUE
			check_move()
		return
	if(floor_list[cur_index] != floor)
		floor.is_dest = TRUE

/datum/elevator_master/proc/open_doors(datum/floor/d_floor)
	for(var/obj/machinery/door/fl_door as anything in d_floor.doors)
		if(!fl_door.hasPower())
			continue
		if(!fl_door.wires.is_cut(WIRE_BOLTS))
			fl_door.unlock()
		fl_door.autoclose = FALSE
		INVOKE_ASYNC(fl_door, /obj/machinery/door.proc/open)

/datum/elevator_master/proc/close_doors(datum/floor/d_floor)
	for(var/obj/machinery/door/fl_door as anything in d_floor.doors)
		// respect the cut wire
		fl_door.autoclose = fl_door.wires.is_cut(WIRE_TIMING)
		INVOKE_ASYNC(fl_door, /obj/machinery/door.proc/close)
		// bolts can be lowered without power, or a cut wire (since if wire is cut they're automatically down)
		fl_door.lock()



/*
	Floor data structure
*/

/// Pretty much just a datastructure collating floor information.
/// Keeping a reference to master makes the ref situation easier.
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
		RegisterSignal(fl_door, COMSIG_PARENT_QDELETING, .proc/door_qdelete)

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
