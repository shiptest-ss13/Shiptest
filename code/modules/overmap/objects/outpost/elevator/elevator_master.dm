// DEBUG: remove; move all defines to proper files
#define ANCHOR_TYPE turf
#define FLIP_DIR(dir) (((dir) == DOWN) ? UP : DOWN)

// DEBUG: merge ELEVATOR_MOVING and ELEVATOR_DOOR_CYCLE?
#define ELEVATOR_IDLE "elevator_idle"
#define ELEVATOR_MOVING "elevator_moving"
#define ELEVATOR_DOOR_CYCLE "elevator_door_cycle"



// DEBUG: redo documentation

// Multi-z "above" and "below" are based on the assumption of equally-sized virtual reserves.
// However, outpost hangars may be differently-sized. Thus, we have to manually handle movement up and down.

// This is paired with a rudimentary (read: shitty) elevator control system I hacked together (One-Car Selective Collective).
// "But wait," you might ask, "wouldn't it be easier to just follow the latest call or movement command?"
// Yes, but it wouldn't lead to funny elevator moments like trying to pack into an already stuffed elevator.
/datum/elevator_master
	var/list/platforms

	/// amount of time spent between floors while moving
	var/floor_move_time = 3 SECONDS
	/// amount of time spent on a floor after arriving but before opening doors
	var/door_open_time = 2 SECONDS
	/// amount of time spent between opening doors and closing them
	var/floor_idle_time = 7 SECONDS

	// DEBUG: variable for has_doors?

	var/list/datum/floor/floor_list = list()

	// DEBUG: remove? is cur_index default value of 1 problematic?
	var/cur_index = 1
	// DEBUG: name is shitty, misleading
	var/last_move = DOWN
	var/cur_state = ELEVATOR_IDLE

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
	// DEBUG: leaves "headless" elevator platforms, existing in an invalid state
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
	// DEBUG: maybe fire an alert or a contingency that the elevator has run out of platforms?

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

// DEBUG: Insert() behavior given indexes out of range?
/// Adds a floor to the elevator's floor list. Default behavior is to append the floor.
// DEBUG: ANCHOR_TYPE
/datum/elevator_master/proc/add_floor(atom/anchor, obj/machinery/elevator_call_button/button, list/obj/machinery/door/doors, index = 0)
	// if we're adding to the middle of the floor list, we may have to update the current index
	// 0 appends to the END of the list, hence the check if index is nonzero
	if(index != 0 && index < cur_index)
		cur_index++

	var/datum/floor/new_floor = new(src, anchor, button, doors)
	floor_list.Insert(index, new_floor)

/// Removes a floor from the elevator's floor list. If the floor is equal to the elevator's current floor, fails and returns FALSE.
/// Otherwise, the floor is removed, the current floor's number is updated if necessary, and returns TRUE.
/datum/elevator_master/proc/remove_floor(index) // DEBUG: support removal of passed floor ref?
	if(index == cur_index)
		return FALSE

	if(index < cur_index)
		cur_index--

	qdel(floor_list[index])
	floor_list.Cut(index, index+1)
	return TRUE

/datum/elevator_master/proc/move_elevator(going)
	// DOWN moves towards the first floor, UP moves towards the last.
	var/new_index = cur_index + (going == DOWN ? -1 : 1)
	// DEBUG: this check should be present in outer layers as well
	if(new_index < 1 || new_index > length(floor_list))
		return
	// DEBUG: ANCHOR_TYPE
	var/atom/cur_anchor = floor_list[cur_index].anchor
	var/atom/new_anchor = floor_list[new_index].anchor
	for(var/obj/structure/elevator_platform/plat as anything in platforms)
		var/turf/platform_dest = locate(
			new_anchor.x + (plat.x - cur_anchor.x),
			new_anchor.y + (plat.y - cur_anchor.y),
			new_anchor.z
		)
		// DEBUG: consider crushing, one way or the other
		plat.travel(platform_dest)
	cur_index = new_index
	last_move = going

	arrive_on_floor()

// DEBUG: this is unnecessary. 555-come-on-now
/datum/elevator_master/proc/check_floors_in_dir(start_index, check_dir)
	var/step = (check_dir == DOWN ? -1 : 1)
	for(var/i = start_index + step, i >= 1 && i <= length(floor_list), i += step)
		var/datum/floor/i_floor = floor_list[i]
		if(i_floor.is_dest || i_floor.calls)
			return i // DEBUG: does this return value have any use? i remember storing it for some reason but don't remember what it was
	return FALSE

/datum/elevator_master/proc/arrive_on_floor()
	// DEBUG: also, include ambient movement noise as well as chime?
	var/datum/floor/cur_floor = floor_list[cur_index]

	// open if there is a destination on this floor
	// OR a call on this floor in the direction we're already headed
	var/open_on_floor = (cur_floor.is_dest || (cur_floor.calls & last_move))
	// OR if there is a call on this floor in the opposite direction WITHOUT any other landings in the direction we're headed
	if(!open_on_floor && (cur_floor.calls & FLIP_DIR(last_move)) && !check_floors_in_dir(cur_index, last_move))
		open_on_floor = TRUE
		// DEBUG: rename "last move" so this isn't a fucking insane thing to do
		last_move = FLIP_DIR(last_move)

	if(display)
		// DEBUG: inadequate for correct sync on landing. also consider floor offsets to "cur_index"
		display.set_message("[cur_index]", last_move == UP ? "UP" : "DOWN")
		display.update()
		if(open_on_floor)
			playsound(
				display,
				last_move == UP ? 'sound/items/ding.ogg' : 'sound/items/ding_twice.ogg',
				100,
				FALSE
			)
		else
			// quieter
			playsound(display, 'sound/misc/compiler-stage1.ogg', 75, FALSE)

	// both of these change the current state
	if(open_on_floor)
		cycle_doors()
	else
		check_move()


/datum/elevator_master/proc/cycle_doors()
	// DEBUG: some sort of state restriction here? hmm. rename to open_on_floor()?

	cur_state = ELEVATOR_DOOR_CYCLE
	var/datum/floor/cur_floor = floor_list[cur_index]
	cur_floor.is_dest = FALSE
	cur_floor.calls &= ~last_move
	cur_floor.button?.update_icon()

	addtimer(CALLBACK(src, .proc/open_doors, cur_floor), door_open_time)
	// DEBUG: NOTE this model doesn't allow for interruption of closing doors (think open/close door buttons, etc.)
	addtimer(CALLBACK(src, .proc/close_doors, cur_floor), door_open_time+floor_idle_time)
	addtimer(CALLBACK(src, .proc/check_move), door_open_time+floor_idle_time+(1 SECONDS))

/datum/elevator_master/proc/check_move()
	var/flip_dir = FLIP_DIR(last_move)
	// DEBUG: obviously this only needs one list parse
	var/next_move = NONE
	if(check_floors_in_dir(cur_index, last_move))
		next_move = last_move
	else if(check_floors_in_dir(cur_index, flip_dir))
		next_move = flip_dir
	if(next_move != NONE)
		cur_state = ELEVATOR_MOVING
		addtimer(CALLBACK(src, .proc/move_elevator, next_move), floor_move_time)
	else
		cur_state = ELEVATOR_IDLE

/datum/elevator_master/proc/add_call_on_floor(datum/floor/floor, call_dir)
	if(floor.calls & call_dir)
		return
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
		return
	floor.calls |= call_dir
	floor.button?.update_icon()

// DEBUG: it was late when i wrote this code so it probably sucks
/datum/elevator_master/proc/set_dest_on_floor(datum/floor/floor)
	if(floor.is_dest)
		return
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
		// DEBUG: does this correctly call derived method?
		INVOKE_ASYNC(fl_door, /obj/machinery/door.proc/open)

/datum/elevator_master/proc/close_doors(datum/floor/d_floor)
	for(var/obj/machinery/door/fl_door as anything in d_floor.doors)
		// respect the cut wire
		fl_door.autoclose = fl_door.wires.is_cut(WIRE_TIMING)
		// DEBUG: does this correctly call derived method?
		// DEBUG: also, "real" elevators won't take off unless there is nobody within the doors. consider impact of airlock safeties?
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

	// DEBUG: ANCHOR_TYPE
	// DEBUG: really, anchors BETTER be turfs, otherwise more fucking refs to cleanup to prevent harddels
	// DEBUG: lord have fucking mercy on me
	var/atom/anchor
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
