/obj/structure/nomifactory
	name = "Nomifactory Node"
	desc = "It does... something?"
	icon = 'icons/obj/nomifactory.dmi'
	density = FALSE
	anchored = TRUE

	/// List of connected nomifactory nodes
	var/list/connected_nodes
	/// Does this node only support cardinal connections
	var/connection_allow_digonal = FALSE
	/// This exists to ensure we dont enter a refresh loop
	VAR_PRIVATE/last_refresh

	var/list/construction_steps = list(
		TOOL_WRENCH,
		TOOL_WELDER
	)
	var/construction_stage = 1

/obj/structure/nomifactory/Initialize()
	. = ..()
	if(!(icon_state in icon_states(icon)))
		stack_trace("[src] had an invalid icon state at initialize.")
		icon = 'icons/obj/nomifactory.dmi'
		icon_state = null
	SSnomifactory.all_nodes += src
	connected_nodes = new

/obj/structure/nomifactory/Destroy()
	. = ..()
	SSnomifactory.all_nodes -= src
	for(var/obj/structure/nomifactory/node as anything in connected_nodes)
		node.connected_nodes -= src
	connected_nodes = null

/obj/structure/nomifactory/wrench_act(mob/living/user, obj/item/I)
	if(!construction_finished() || user.a_intent == INTENT_HARM)
		return ..()

	dir = turn(dir, 90)
	say("Now facing [dir2text(dir)]")
	return COMPONENT_BLOCK_TOOL_ATTACK

/obj/structure/nomifactory/proc/construction_finished()
	return construction_stage == length(construction_steps) + 1

/obj/structure/nomifactory/proc/allow_nomifactory_connection(dir, obj/structure/nomifactory/connectee)
	if(!connection_allow_digonal)
		if(dir in GLOB.diagonals)
			return FALSE

	return construction_finished()

/obj/structure/nomifactory/proc/refresh_nomifactory_connections(requested_at = world.time)
	if(last_refresh == requested_at)
		return
	if(!construction_finished())
		return
	last_refresh = requested_at

	var/old_connections = connected_nodes
	connected_nodes = new

	var/list/check_dirs = GLOB.cardinals
	if(connection_allow_digonal)
		check_dirs |= GLOB.diagonals

	for(var/dir in check_dirs)
		var/turf/check = get_turf(get_step(src, dir))
		var/obj/structure/nomifactory/node = locate() in check
		if(QDELETED(node))
			continue
		connected_nodes[node] = dir

	for(var/obj/structure/nomifactory/old_node as anything in old_connections)
		if(QDELETED(old_node))
			continue
		if(!(old_node in connected_nodes))
			old_node.on_nomifactory_disconnection(src, get_dir(old_node, src))
			old_node.refresh_nomifactory_connections(requested_at)

	for(var/obj/structure/nomifactory/new_node as anything in connected_nodes)
		if(!(new_node in old_connections))
			new_node.on_nomifactory_connection(src, get_dir(new_node, src))
			new_node.refresh_nomifactory_connections(requested_at)

/obj/structure/nomifactory/proc/on_nomifactory_connection(obj/structure/nomifactory/node, dir)
	SHOULD_CALL_PARENT(TRUE)
	connected_nodes[node] = dir

/obj/structure/nomifactory/proc/on_nomifactory_disconnection(obj/structure/nomifactory/node, dir)
	SHOULD_CALL_PARENT(TRUE)
	connected_nodes -= node

/obj/structure/nomifactory/proc/nomifactory_process()
	return

/obj/structure/nomifactory/examine(mob/user)
	. = ..()

	if(!construction_finished())
		var/needed = "something"
		var/old

		var/current = construction_steps[construction_stage]
		if(ispath(current))
			var/atom/current_as_atom = current
			current = initial(current_as_atom.name)

		var/previous = construction_stage > 1 ? construction_steps[construction_stage-1] : null
		if(ispath(previous))
			var/atom/previous_as_atom = previous
			previous = initial(previous_as_atom.name)

		switch(current)
			if(TOOL_CROWBAR)
				needed = "The frame needs to be <i>pried</i> into place"
			if(TOOL_MULTITOOL)
				needed = "Some circuitry needs to be enabled"
			if(TOOL_SCREWDRIVER)
				needed = "Some circuitry needs to be <i>screwed</i> into place"
			if(TOOL_WELDER)
				needed = "The frame needs to be <i>welded</i>"
			if(TOOL_WRENCH)
				needed = "The frame needs to be <i>secured</i>"
			if(TOOL_WIRECUTTER)
				needed = "Some circuitry needs to be trimmed"
			else
				needed = "It needs [current] applied to it"

		if(previous)
			switch(previous)
				if(TOOL_CROWBAR)
					old = "You can <i>pry</i> the frame out of place"
				if(TOOL_MULTITOOL)
					old = "Some circuitry can be disabled"
				if(TOOL_SCREWDRIVER)
					old = "Some circuitry can be <i>unscrewed</i>"
				if(TOOL_WELDER)
					old = "The frame can be <i>unwelded</i>"
				if(TOOL_WRENCH)
					old = "The frame can be <i>unsecured</i>"
				if(TOOL_WIRECUTTER)
					old = "Some circuitry can be trimmed out"
				else
					old = "[previous] can be undone"

		. += needed
		if(old)
			. += old
	else
		. += "You could deconstruct it with a <i>welding tool and crowbar</i>"

/obj/structure/nomifactory/attackby(obj/item/I, mob/living/user, params)
	if(!construction_finished())
		var/current = construction_steps[construction_stage]
		var/previous = construction_stage > 1 ? construction_steps[construction_stage-1] : null

		if(I.type == current || I.tool_behaviour == current)
			if(!I.use(construction_steps[current]))
				to_chat(user, "<span class='warning'>You fail to complete the step!</span>")
				return TRUE

			construction_stage++
			to_chat(user, "<span class='notice'>You complete the step.</span>")
			return TRUE

		if(I.type == previous || I.tool_behaviour == previous)
			construction_stage--
			to_chat(user, "<span class='notice'>You undo your work.</span>")
			return TRUE

	if(I.tool_behaviour == TOOL_WELDER)
		var/obj/item/weldingtool/welder = I
		if(!welder.welding)
			return ..()
		var/obj/item/offhand = user.get_inactive_held_item()
		if(istype(offhand) && offhand.tool_behaviour == TOOL_CROWBAR)
			if(!do_after_mob(user, src, 2 SECONDS))
				return TRUE

			if(construction_stage > 1)
				to_chat(user, "<span class='danger'>You forcibly rip apart some of [src]!</span>")
				construction_stage--
				return TRUE
			else
				to_chat(user, "<span class='danger'>You finish ripping apart [src]!</span>")
				qdel(src)
				return TRUE

	return ..()

/obj/structure/nomifactory/multitool_act(mob/living/user, obj/item/I)
	refresh_nomifactory_connections()
	to_chat(user, "<span class='notice'>You press the factory reset button!</span>")
	return COMPONENT_BLOCK_TOOL_ATTACK
