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
	update_icon()
	update_door_name()

/obj/structure/poddoor_assembly/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation, ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS, null, CALLBACK(src, .proc/can_be_rotated))

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
				. += "<span class='notice'>The anchoring bolts are <b>wrenched</b> in place, but the maintenance panel needs <i>wiring</i>.</span>"
			else
				. +=  "<span class='notice'>The anchoring bolts are <i>unwrenched</i>, and the assembly could be <i>welded apart</i>.</span>"
		if(AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
			. += "<span class='notice'>The maintenance panel is <b>wired</b>, but the circuit slot is <i>empty</i>.</span>"
		if(AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
			. += "<span class='notice'>The circuit is <b>connected loosely</b> to its slot.</span>"
	. += "<span class='notice'>The assembly [welded ? "is firmly <b>welded</b> into place" : "needs to be <i>welded</i> to the floor in order to complete it"].</span>"
	. += "<span class='notice'>There is a small placard on the assembly[doorname].</span>"

/obj/structure/poddoor_assembly/attackby(obj/item/item_used, mob/user, params)
	if(istype(item_used, /obj/item/pen))
		var/new_name = stripped_input(user, "Enter the name for the assembly.", name, created_name,MAX_NAME_LEN)
		if(!new_name || (!in_range(src, usr) && loc != usr))
			return
		created_name = new_name

	else if(item_used.tool_behaviour == TOOL_WELDER)
		if(!item_used.tool_start_check(user, amount=0))
			return

		else if(!anchored)
			user.visible_message("<span class='warning'>[user] cuts apart [src].</span>", \
								"<span class='notice'>You start to slice apart [src]...</span>")
			if(item_used.use_tool(src, user, 4 SECONDS, volume=50))
				to_chat(user, "<span class='notice'>You disassemble [src].</span>")
				deconstruct(TRUE)
		else if(!welded)
			user.visible_message("<span class='warning'>[user] welds [src].</span>", \
								"<span class='notice'>You start to weld [src] to the floor...</span>")
			if(item_used.use_tool(src, user, 4 SECONDS, volume=50))
				if(!anchored || welded)
					return
				to_chat(user, "<span class='notice'>You weld [src] to the floor.</span>")
				welded = TRUE
		else
			user.visible_message("<span class='warning'>[user] welds [src].</span>", \
								"<span class='notice'>You start to weld [src] free from the floor...</span>")
			if(item_used.use_tool(src, user, 4 SECONDS, volume=50))
				if(!welded)
					return
				to_chat(user, "<span class='notice'>You weld [src] from the floor.</span>")
				welded = FALSE

	else if(item_used.tool_behaviour == TOOL_WRENCH)
		if(!anchored)
			var/door_check = TRUE
			if(locate(/obj/machinery/door/poddoor) in loc)
				door_check = FALSE
				return

			if(door_check)
				user.visible_message(
					"<span class='notice'>[user] secures [src] to the floor.</span>",
					"<span class='notice'>You start to secure [src] to the floor...</span>",
					"<span class='hear'>You hear wrenching.</span>"
				)

				if(item_used.use_tool(src, user, 4 SECONDS, volume=100))
					if(anchored)
						return
					to_chat(user, "<span class='notice'>You secure [src].</span>")
					set_anchored(TRUE)
			else
				to_chat(user, "There is another [base_name] here!")

		else
			user.visible_message(
				"<span class='notice'>[user] unsecures [src] from the floor.</span>",
				"<span class='notice'>You start to free [src] from the floor...</span>",
				"<span class='hear'>You hear wrenching.</span>"
			)
			if(item_used.use_tool(src, user, 4 SECONDS, volume=100))
				if(!anchored)
					return
				to_chat(user, "<span class='notice'>You unsecure [src].</span>")
				name = "airlock assembly"
				set_anchored(FALSE)

	else if(istype(item_used, /obj/item/stack/cable_coil) && state == AIRLOCK_ASSEMBLY_NEEDS_WIRES)
		if(!item_used.tool_start_check(user, amount=1))
			return

		user.visible_message("<span class='notice'>[user] wires [src].</span>", \
							"<span class='notice'>You start to wire [src]...</span>")
		if(item_used.use_tool(src, user, 4 SECONDS, amount=1))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_WIRES)
				return
			state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
			to_chat(user, "<span class='notice'>You wire [src].</span>")

	else if(item_used.tool_behaviour == TOOL_WIRECUTTER && state == AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
		user.visible_message("<span class='notice'>[user] cuts the wires from [src].</span>", \
							"<span class='notice'>You start to cut the wires from [src]...</span>")

		if(item_used.use_tool(src, user, 4 SECONDS, volume=100))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
				return
			to_chat(user, "<span class='notice'>You cut the wires from the [src].</span>")
			new/obj/item/stack/cable_coil(get_turf(user), 1)
			state = AIRLOCK_ASSEMBLY_NEEDS_WIRES

	else if(istype(item_used, /obj/item/electronics/airlock) && state == AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
		item_used.play_tool_sound(src, 100)
		user.visible_message("<span class='notice'>[user] installs the electronics into [src].</span>", \
							"<span class='notice'>You start to install electronics into [src]...</span>")
		if(do_after(user, 4 SECONDS, target = src))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
				return
			if(!user.transferItemToLoc(item_used, src))
				return

			to_chat(user, "<span class='notice'>You install the electronics.</span>")
			state = AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER
			electronics = item_used

	else if((item_used.tool_behaviour == TOOL_CROWBAR) && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
		user.visible_message("<span class='notice'>[user] removes the electronics from [src].</span>", \
							"<span class='notice'>You start to remove electronics from [src]...</span>")

		if(item_used.use_tool(src, user, 4 SECONDS, volume=100))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
				return
			to_chat(user, "<span class='notice'>You remove the electronics.</span>")
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
			"<span class='notice'>[user] finishes [src].</span>",
			"<span class='notice'>You start finishing [src]...</span>"
		)
		if(item_used.use_tool(src, user, 4 SECONDS, volume=100))
			if(!welded)
				return
			if(loc && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
				to_chat(user, "<span class='notice'>You finish [src].</span>")
				var/obj/machinery/door/poddoor/door = new poddoor_type(loc)
				door.setDir(dir)
				if(created_name)
					door.name = created_name
				else
					door.name = base_name
				door.assemblytype = previous_assembly
				electronics.forceMove(door)
				door.update_icon()
				qdel(src)
	else
		return ..()
	update_door_name()
	update_icon()

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
