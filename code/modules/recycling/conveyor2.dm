//conveyor2 is pretty much like the original, except it supports corners, but not diverters.
//note that corner pieces transfer stuff clockwise when running forward, and anti-clockwise backwards.
#define MAX_CONVEYOR_ITEMS_MOVE 30
GLOBAL_LIST_EMPTY(conveyors_by_id)

/obj/machinery/conveyor
	icon = 'icons/obj/recycling.dmi'
	icon_state = "conveyor_map"
	name = "conveyor belt"
	desc = "A conveyor belt."
	base_icon_state = "conveyor"
	layer = BELOW_OPEN_DOOR_LAYER
	processing_flags = START_PROCESSING_MANUALLY
	subsystem_type = /datum/controller/subsystem/processing/fastprocess
	var/operating = 0	// 1 if running forward, -1 if backwards, 0 if off
	var/operable = 1	// true if can operate (no broken segments in this belt run)
	var/forwards		// this is the default (forward) direction, set by the map dir
	var/backwards		// hopefully self-explanatory
	var/movedir			// the actual direction to move stuff in

	var/list/affecting	// the list of all items that will be moved this ptick
	var/id = ""			// the control ID	- must match controller ID
	var/verted = 1		// Inverts the direction the conveyor belt moves.
	var/conveying = FALSE

/obj/machinery/conveyor/auto/outpost
	id = "outpost-conveyor"
	desc = "A sturdy conveyor belt. It is well-fastened to the floor and cannot be pried up."
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF

/obj/machinery/conveyor/auto/outpost/attackby(obj/item/I, mob/user, params)
	return

/obj/machinery/conveyor/inverted //Directions inverted so you can use different corner peices.
	icon_state = "conveyor_map_inverted"
	verted = -1

/obj/machinery/conveyor/inverted/Initialize(mapload)
	. = ..()
	if(mapload && !(ISDIAGONALDIR(dir)))
		log_mapping("[src] at [AREACOORD(src)] spawned without using a diagonal dir. Please replace with a normal version.")

// Auto conveyour is always on unless unpowered

/obj/machinery/conveyor/auto/Initialize(mapload, newdir)
	. = ..()
	operating = TRUE
	update_move_direction()

/obj/machinery/conveyor/auto/update()
	. = ..()
	if(.)
		operating = TRUE
		update_appearance()
		begin_processing()                                              //WS Edit - Auto Conveyor Fix (Issue #331)

// create a conveyor
/obj/machinery/conveyor/Initialize(mapload, newdir, newid)
	. = ..()
	if(newdir)
		setDir(newdir)
	if(newid)
		id = newid
	update_move_direction()
	LAZYADD(GLOB.conveyors_by_id[id], src)

/obj/machinery/conveyor/Destroy()
	LAZYREMOVE(GLOB.conveyors_by_id[id], src)
	. = ..()

/obj/machinery/conveyor/vv_edit_var(var_name, var_value)
	if (var_name == NAMEOF(src, id))
		// if "id" is varedited, update our list membership
		LAZYREMOVE(GLOB.conveyors_by_id[id], src)
		. = ..()
		LAZYADD(GLOB.conveyors_by_id[id], src)
	else
		return ..()

/obj/machinery/conveyor/setDir(newdir)
	. = ..()
	update_move_direction()

/obj/machinery/conveyor/proc/update_move_direction()
	switch(dir)
		if(NORTH)
			forwards = NORTH
			backwards = SOUTH
		if(SOUTH)
			forwards = SOUTH
			backwards = NORTH
		if(EAST)
			forwards = EAST
			backwards = WEST
		if(WEST)
			forwards = WEST
			backwards = EAST
		if(NORTHEAST)
			forwards = EAST
			backwards = SOUTH
		if(NORTHWEST)
			forwards = NORTH
			backwards = EAST
		if(SOUTHEAST)
			forwards = SOUTH
			backwards = WEST
		if(SOUTHWEST)
			forwards = WEST
			backwards = NORTH
	if(verted == -1)
		var/temp = forwards
		forwards = backwards
		backwards = temp
	if(operating == 1)
		movedir = forwards
	else
		movedir = backwards
	update()

/obj/machinery/conveyor/update_icon_state()
	icon_state = "[base_icon_state][(machine_stat & BROKEN) ? "-broken" : (operating * verted)]"
	return ..()

/obj/machinery/conveyor/proc/update()
	if(machine_stat & BROKEN || !operable || machine_stat & NOPOWER)
		operating = FALSE
		update_appearance()
		return FALSE
	return TRUE

// machine process
// move items to the target location
/obj/machinery/conveyor/process(seconds_per_tick)
	if(machine_stat & (BROKEN | NOPOWER))
		return

	//If the conveyor is broken or already moving items
	if(!operating || conveying)
		return

	use_power(6)

	//get the first 30 items in contents
	affecting = list()
	var/i = 0
	var/list/items = loc.contents - src
	for(var/item in items)
		i++ // we're sure it's a real target to move at this point
		if(i >= MAX_CONVEYOR_ITEMS_MOVE)
			break
		affecting.Add(item)

	conveying = TRUE
	addtimer(CALLBACK(src, PROC_REF(convey), affecting), 1)

/obj/machinery/conveyor/proc/convey(list/affecting)
	for(var/atom/movable/A in affecting)
		if(!QDELETED(A) && (A.loc == loc))
			A.ConveyorMove(movedir)
			//Give this a chance to yield if the server is busy
			CHECK_TICK
	conveying = FALSE

// attack with item, place item on conveyor
/obj/machinery/conveyor/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_CROWBAR)
		user.visible_message(span_notice("[user] struggles to pry up \the [src] with \the [I]."), \
		span_notice("You struggle to pry up \the [src] with \the [I]."))
		if(I.use_tool(src, user, 40, volume=40))
			if(!(machine_stat & BROKEN))
				var/obj/item/stack/conveyor/C = new /obj/item/stack/conveyor(loc, 1, TRUE, id)
				transfer_fingerprints_to(C)
			to_chat(user, span_notice("You remove the conveyor belt."))
			qdel(src)

	else if(I.tool_behaviour == TOOL_WRENCH)
		if(!(machine_stat & BROKEN))
			I.play_tool_sound(src)
			setDir(turn(dir,-45))
			update_move_direction()
			to_chat(user, span_notice("You rotate [src]."))

	else if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(!(machine_stat & BROKEN))
			verted = verted * -1
			update_move_direction()
			to_chat(user, span_notice("You reverse [src]'s direction."))

	else if(user.a_intent != INTENT_HARM)
		user.transferItemToLoc(I, drop_location())
	else
		return ..()

// attack with hand, move pulled object onto conveyor
/obj/machinery/conveyor/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	user.Move_Pulled(src)

// make the conveyor broken
// also propagate inoperability to any connected conveyor with the same ID
/obj/machinery/conveyor/proc/broken()
	atom_break()
	update()

	var/obj/machinery/conveyor/C = locate() in get_step(src, dir)
	if(C)
		C.set_operable(dir, id, 0)

	C = locate() in get_step(src, turn(dir,180))
	if(C)
		C.set_operable(turn(dir,180), id, 0)


//set the operable var if ID matches, propagating in the given direction

/obj/machinery/conveyor/proc/set_operable(stepdir, match_id, op)

	if(id != match_id)
		return
	operable = op

	update()
	var/obj/machinery/conveyor/C = locate() in get_step(src, stepdir)
	if(C)
		C.set_operable(stepdir, id, op)

/obj/machinery/conveyor/power_change()
	. = ..()
	update()

// the conveyor control switch
//
//

/obj/machinery/conveyor_switch
	name = "conveyor switch"
	desc = "A conveyor control switch."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "switch-off"
	base_icon_state = "switch"
	processing_flags = START_PROCESSING_MANUALLY

	var/position = 0			// 0 off, -1 reverse, 1 forward
	var/last_pos = -1			// last direction setting
	var/oneway = FALSE			// if the switch only operates the conveyor belts in a single direction.
	var/invert_icon = FALSE		// If the level points the opposite direction when it's turned on.

	var/id = "" 				// must match conveyor IDs to control them

/obj/machinery/conveyor_switch/Initialize(mapload, newid)
	. = ..()
	if (newid)
		id = newid
	update_appearance()
	LAZYADD(GLOB.conveyors_by_id[id], src)
	wires = new /datum/wires/conveyor(src)

/obj/machinery/conveyor_switch/Destroy()
	LAZYREMOVE(GLOB.conveyors_by_id[id], src)
	QDEL_NULL(wires)
	. = ..()

/obj/machinery/conveyor_switch/vv_edit_var(var_name, var_value)
	if (var_name == NAMEOF(src, id))
		// if "id" is varedited, update our list membership
		LAZYREMOVE(GLOB.conveyors_by_id[id], src)
		. = ..()
		LAZYADD(GLOB.conveyors_by_id[id], src)
	else
		return ..()

// update the icon depending on the position

/obj/machinery/conveyor_switch/update_icon_state()
	if(position < 0)
		icon_state = "[base_icon_state]-[invert_icon ? "fwd" : "rev"]"
		return ..()
	if(position > 0)
		icon_state = "[base_icon_state]-[invert_icon ? "rev" : "fwd"]"
		return ..()
	icon_state = "[base_icon_state]-off"
	return ..()

/// Updates all conveyor belts that are linked to this switch, and tells them to start processing.
/obj/machinery/conveyor_switch/proc/update_linked_conveyors()
	for(var/obj/machinery/conveyor/C in GLOB.conveyors_by_id[id])
		C.operating = position
		C.update_move_direction()
		C.update_appearance()
		if(C.operating)
			C.begin_processing()
		else
			C.end_processing()
		CHECK_TICK

/// Finds any switches with same `id` as this one, and set their position and icon to match us.
/obj/machinery/conveyor_switch/proc/update_linked_switches()
	for(var/obj/machinery/conveyor_switch/S in GLOB.conveyors_by_id[id])
		S.invert_icon = invert_icon
		S.position = position
		S.update_appearance()
		CHECK_TICK

/// Updates the switch's `position` and `last_pos` variable. Useful so that the switch can properly cycle between the forwards, backwards and neutral positions.
/obj/machinery/conveyor_switch/proc/update_position()
	if(position == 0)
		if(oneway)   //is it a oneway switch
			position = oneway
		else
			if(last_pos < 0)
				position = 1
				last_pos = 0
			else
				position = -1
				last_pos = 0
	else
		last_pos = position
		position = 0

/// Called when a user clicks on this switch with an open hand.
/obj/machinery/conveyor_switch/interact(mob/user)
	add_fingerprint(user)
	play_click_sound("switch")
	update_position()
	update_appearance()
	update_linked_conveyors()
	update_linked_switches()


/obj/machinery/conveyor_switch/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_CROWBAR)
		var/obj/item/conveyor_switch_construct/C = new/obj/item/conveyor_switch_construct(src.loc)
		C.id = id
		transfer_fingerprints_to(C)
		to_chat(user, span_notice("You detach the conveyor switch."))
		qdel(src)
	if(is_wire_tool(I))
		wires.interact(user)
		return TRUE

/obj/machinery/conveyor_switch/oneway
	icon_state = "conveyor_switch_oneway"
	desc = "A conveyor control switch. It appears to only go in one direction."
	oneway = TRUE

/obj/machinery/conveyor_switch/oneway/Initialize()
	. = ..()
	if((dir == NORTH) || (dir == WEST))
		invert_icon = TRUE

/obj/item/conveyor_switch_construct
	name = "conveyor switch assembly"
	desc = "A conveyor control switch assembly."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "switch-off"
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron = 450, /datum/material/glass = 190) // WS Edit - Item Materials
	var/id = "" //inherited by the switch

/obj/item/conveyor_switch_construct/Initialize()
	. = ..()
	id = "[rand()]" //this couldn't possibly go wrong

/obj/item/conveyor_switch_construct/attack_self(mob/user)
	for(var/obj/item/stack/conveyor/C in view())
		C.id = id
	to_chat(user, span_notice("You have linked all nearby conveyor belt assemblies to this switch."))

/obj/item/conveyor_switch_construct/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity || user.stat || !isfloorturf(A))
		return
	var/found = 0
	for(var/obj/machinery/conveyor/C in view())
		if(C.id == src.id)
			found = 1
			break
	if(!found)
		to_chat(user, "[icon2html(src, user)]<span class=notice>The conveyor switch did not detect any linked conveyor belts in range.</span>")
		return
	var/obj/machinery/conveyor_switch/NC = new/obj/machinery/conveyor_switch(A, id)
	transfer_fingerprints_to(NC)
	qdel(src)

/obj/item/stack/conveyor
	name = "conveyor belt assembly"
	desc = "A conveyor belt assembly."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "conveyor_construct"
	max_amount = 30
	singular_name = "conveyor belt"
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron = 3000) // WS Edit - Item Materials
	///id for linking
	var/id = ""

/obj/item/stack/conveyor/Initialize(mapload, new_amount, merge = TRUE, _id)
	. = ..()
	id = _id

/obj/item/stack/conveyor/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity || user.stat || !isfloorturf(A))
		return
	var/cdir = get_dir(A, user)
	if(A == user.loc)
		to_chat(user, span_warning("You cannot place a conveyor belt under yourself!"))
		return
	var/obj/machinery/conveyor/C = new/obj/machinery/conveyor(A, cdir, id)
	transfer_fingerprints_to(C)
	use(1)

/obj/item/stack/conveyor/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/conveyor_switch_construct))
		to_chat(user, span_notice("You link the switch to the conveyor belt assembly."))
		var/obj/item/conveyor_switch_construct/C = I
		id = C.id

/obj/item/stack/conveyor/update_weight()
	return FALSE

/obj/item/stack/conveyor/thirty
	amount = 30

/obj/item/paper/guides/conveyor
	name = "paper- 'Nano-it-up U-build series, #9: Build your very own conveyor belt, in SPACE'"
	default_raw_text = "<h1>Congratulations!</h1><p>You are now the proud owner of the best conveyor set available for space mail order! We at Nano-it-up know you love to prepare your own structures without wasting time, so we have devised a special streamlined assembly procedure that puts all other mail-order products to shame!</p><p>Firstly, you need to link the conveyor switch assembly to each of the conveyor belt assemblies. After doing so, you simply need to install the belt assemblies onto the floor, et voila, belt built. Our special Nano-it-up smart switch will detected any linked assemblies as far as the eye can see! This convenience, you can only have it when you Nano-it-up. Stay nano!</p>"

#undef MAX_CONVEYOR_ITEMS_MOVE
