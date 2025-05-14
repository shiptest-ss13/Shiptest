// poddoor assemblies
// for building pod doors,
// blast doors and such. features copious amounts of copypasted code from door_assembly.dm

/obj/structure/poddoor_assembly
	name = "blast door assembly"
	icon = 'icons/obj/doors/blastdoor.dmi'
	icon_state = "open"
	anchored = FALSE
	density = FALSE
	max_integrity = 200
	var/obj/item/electronics/airlock/electronics = null
	var/poddoor_type = /obj/machinery/door/poddoor/preopen //type of pod dooor when completed
	var/state = AIRLOCK_ASSEMBLY_NEEDS_WIRES //cope
	var/base_name = "blast door"
	var/created_name = null
	var/previous_assembly = /obj/structure/poddoor_assembly
	var/material_amt = 15
	var/material_type = /obj/item/stack/sheet/plasteel
	var/welded = FALSE // checks if the thing is welded to the floor

/obj/structure/poddoor_assembly/Initialize()
	. = ..()
	update_appearance()
	update_door_name()

/obj/structure/poddoor_assembly/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation, ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS, null, CALLBACK(src, PROC_REF(can_be_rotated)))

/obj/structure/poddoor_assembly/proc/can_be_rotated(mob/user, rotation_type)
	return !anchored

/obj/structure/poddoor_assembly/examine(mob/user)
	. = ..()
	var/doorname = ""
	if(created_name)
		doorname = ", written on it is '[created_name]'"
	switch(state)
		if(AIRLOCK_ASSEMBLY_NEEDS_WIRES)
			if(anchored)
				. += span_notice("The anchoring bolts are <b>wrenched</b> in place, but the maintenance panel needs <i>wiring</i>.")
			else
				. +=  span_notice("The anchoring bolts are <i>unwrenched</i>, and the assembly could be <i>welded apart</i>.")
		if(AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
			. += span_notice("The maintenance panel is <b>wired</b>, but the circuit slot is <i>empty</i>.")
		if(AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
			. += span_notice("The circuit is <b>connected loosely</b> to its slot.")
	. += span_notice("The assembly [welded ? "is firmly <b>welded</b> into place" : "needs to be <i>welded</i> to the floor in order to complete it"].")
	. += span_notice("There is a small placard on the assembly[doorname].")

/obj/structure/poddoor_assembly/attackby(obj/item/item_used, mob/user, params)
	if(istype(item_used, /obj/item/pen))
		var/new_name = stripped_input(user, "Enter the name for the assembly.", name, created_name,MAX_NAME_LEN)
		if(!new_name || (!in_range(src, usr) && loc != usr))
			return
		created_name = new_name

	else if(item_used.tool_behaviour == TOOL_WELDER)
		if(!item_used.tool_start_check(user, src, amount=0))
			return

		else if(!anchored)
			user.visible_message(span_warning("[user] cuts apart [src]."), \
								span_notice("You start to slice apart [src]..."))
			if(item_used.use_tool(src, user, 4 SECONDS, volume=50))
				to_chat(user, span_notice("You disassemble [src]."))
				deconstruct(TRUE)
		else if(!welded)
			user.visible_message(span_warning("[user] welds [src]."), \
								span_notice("You start to weld [src] to the floor..."))
			if(item_used.use_tool(src, user, 4 SECONDS, volume=50))
				if(!anchored || welded)
					return
				to_chat(user, span_notice("You weld [src] to the floor."))
				welded = TRUE
		else
			user.visible_message(span_warning("[user] welds [src]."), \
								span_notice("You start to weld [src] free from the floor..."))
			if(item_used.use_tool(src, user, 4 SECONDS, volume=50))
				if(!welded)
					return
				to_chat(user, span_notice("You weld [src] from the floor."))
				welded = FALSE

	else if(item_used.tool_behaviour == TOOL_WRENCH)
		if(!anchored)
			var/door_check = TRUE
			if(locate(/obj/machinery/door/poddoor) in loc)
				door_check = FALSE
				return

			if(door_check)
				user.visible_message(
					span_notice("[user] secures [src] to the floor."),
					span_notice("You start to secure [src] to the floor..."),
					span_hear("You hear wrenching.")
				)

				if(item_used.use_tool(src, user, 4 SECONDS, volume=100))
					if(anchored)
						return
					to_chat(user, span_notice("You secure [src]."))
					set_anchored(TRUE)
			else
				to_chat(user, "There is another [base_name] here!")

		else
			user.visible_message(
				span_notice("[user] unsecures [src] from the floor."),
				span_notice("You start to free [src] from the floor..."),
				span_hear("You hear wrenching.")
			)
			if(item_used.use_tool(src, user, 4 SECONDS, volume=100))
				if(!anchored)
					return
				to_chat(user, span_notice("You unsecure [src]."))
				name = "airlock assembly"
				set_anchored(FALSE)

	else if(istype(item_used, /obj/item/stack/cable_coil) && state == AIRLOCK_ASSEMBLY_NEEDS_WIRES)
		if(!item_used.tool_start_check(user, src, amount=1))
			return

		user.visible_message(span_notice("[user] wires [src]."), \
							span_notice("You start to wire [src]..."))
		if(item_used.use_tool(src, user, 4 SECONDS, amount=1))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_WIRES)
				return
			state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
			to_chat(user, span_notice("You wire [src]."))

	else if(item_used.tool_behaviour == TOOL_WIRECUTTER && state == AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
		user.visible_message(span_notice("[user] cuts the wires from [src]."), \
							span_notice("You start to cut the wires from [src]..."))

		if(item_used.use_tool(src, user, 4 SECONDS, volume=100))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
				return
			to_chat(user, span_notice("You cut the wires from the [src]."))
			new/obj/item/stack/cable_coil(get_turf(user), 1)
			state = AIRLOCK_ASSEMBLY_NEEDS_WIRES

	else if(istype(item_used, /obj/item/electronics/airlock) && state == AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
		item_used.play_tool_sound(src, 100)
		user.visible_message(span_notice("[user] installs the electronics into [src]."), \
							span_notice("You start to install electronics into [src]..."))
		if(do_after(user, 4 SECONDS, target = src))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
				return
			if(!user.transferItemToLoc(item_used, src))
				return

			to_chat(user, span_notice("You install the electronics."))
			state = AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER
			electronics = item_used

	else if((item_used.tool_behaviour == TOOL_CROWBAR) && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
		user.visible_message(span_notice("[user] removes the electronics from [src]."), \
							span_notice("You start to remove electronics from [src]..."))

		if(item_used.use_tool(src, user, 4 SECONDS, volume=100))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
				return
			to_chat(user, span_notice("You remove the electronics."))
			state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
			var/obj/item/electronics/airlock/airlock_electronics
			if (!electronics)
				airlock_electronics = new /obj/item/electronics/airlock(loc)
			else
				airlock_electronics = electronics
				electronics = null
				airlock_electronics.forceMove(loc)

	else if((item_used.tool_behaviour == TOOL_SCREWDRIVER) && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER && welded)
		user.visible_message(
			span_notice("[user] finishes [src]."),
			span_notice("You start finishing [src]...")
		)
		if(item_used.use_tool(src, user, 4 SECONDS, volume=100))
			if(!welded)
				return
			if(loc && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
				to_chat(user, span_notice("You finish [src]."))
				var/obj/machinery/door/poddoor/door = new poddoor_type(loc)
				door.setDir(dir)
				if(created_name)
					door.name = created_name
				else
					door.name = base_name
				door.assemblytype = previous_assembly
				electronics.forceMove(door)
				door.update_appearance()
				qdel(src)
	else
		return ..()
	update_door_name()
	update_appearance()

/obj/structure/poddoor_assembly/deconstruct_act(mob/living/user, obj/item/tool)
	if(..())
		return TRUE
	if(!tool.tool_start_check(user, src, amount=0))
		return TRUE
	user.visible_message(span_notice("[user] cuts apart [src]."), span_notice("You start to slice apart [src]..."))
	if(tool.use_tool(src, user, 4 SECONDS, volume=50))
		to_chat(user, span_notice("You disassemble [src]."))
		deconstruct(TRUE)
	return TRUE

/obj/structure/poddoor_assembly/proc/update_door_name()

	switch(state)
		if(AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
			name = "wired "
		if(AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
			name = "near finished "
		else
			name = ""
	name += "[base_name] assembly"

/obj/structure/poddoor_assembly/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		var/turf/T = get_turf(src)
		if(!disassembled)
			material_amt = rand(2,4)
		new material_type(T, material_amt)
	qdel(src)

/obj/structure/poddoor_assembly/shutters
	name = "shutters assembly"
	icon = 'icons/obj/doors/shutters.dmi'
	icon_state = "open"
	poddoor_type = /obj/machinery/door/poddoor/shutters/preopen
	base_name = "shutters"
	previous_assembly = /obj/structure/poddoor_assembly/shutters
	material_amt = 5
