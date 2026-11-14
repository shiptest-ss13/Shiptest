// Tools for admins working out what an AI is up to: its state and planning tree views from View Variables, and its log of what it decides

/datum/ai_controller/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_AI_STATE, "Show AI State")
	VV_DROPDOWN_OPTION(VV_HK_AI_LOG_DECISIONS, "Toggle AI Decision Logging")
	VV_DROPDOWN_OPTION(VV_HK_AI_TREE, "Show AI Tree")

/datum/ai_controller/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_AI_STATE] && check_rights(R_DEBUG))
		to_chat(usr, span_notice(get_debug_state()))
	if(href_list[VV_HK_AI_TREE] && check_rights(R_DEBUG))
		to_chat(usr, span_notice(get_debug_tree()))
	if(href_list[VV_HK_AI_LOG_DECISIONS] && check_rights(R_DEBUG))
		to_chat(usr, span_notice("[pawn] [toggle_decision_logging() ? "is now" : "is no longer"] logging its AI decisions."))

/datum/ai_controller/proc/admin_set_home(mob/user)
	var/static/list/choices = list("Where I'm standing", "Where it stands now", "Coordinates")
	var/choice = tgui_input_list(user, "Where should [pawn] call home?", "Set AI Home", choices)
	if(!choice || QDELETED(src))
		return
	var/turf/spot
	switch(choice)
		if("Where I'm standing")
			spot = get_turf(user)
		if("Where it stands now")
			spot = get_turf(pawn)
		if("Coordinates")
			var/datum/virtual_level/vlevel = pawn.get_virtual_level()
			if(!vlevel)
				to_chat(user, span_warning("[pawn] isn't on a virtual level, so there's nothing to take coordinates from."))
				return
			var/list/our_coords = vlevel.get_relative_coords(pawn)
			var/x = tgui_input_number(user, "X coordinate on [pawn]'s level", "Set AI Home", our_coords[1], vlevel.high_x - vlevel.low_x + 1, 1)
			var/y = isnull(x) ? null : tgui_input_number(user, "Y coordinate on [pawn]'s level", "Set AI Home", our_coords[2], vlevel.high_y - vlevel.low_y + 1, 1)
			if(isnull(y) || QDELETED(src))
				return
			spot = locate(vlevel.low_x + x - 1, vlevel.low_y + y - 1, vlevel.z_value)
	if(!spot || QDELETED(src))
		return
	var/move_there = FALSE
	if(spot != get_turf(pawn))
		var/how = tgui_alert(user, "Should [pawn] walk there, or be moved there now?", "Set AI Home", list("Walk there", "Move it now"))
		if(!how || QDELETED(src))
			return
		move_there = how == "Move it now"
	var/stop_wandering = FALSE
	if(idle_behavior)
		var/wander = tgui_alert(user, "Should [pawn] keep wandering about when it's got nothing to do, or stay on the spot?", "Set AI Home", list("Keep wandering", "Stay put"))
		if(!wander || QDELETED(src))
			return
		stop_wandering = wander == "Stay put"
	if(move_there)
		var/atom/movable/moving_pawn = pawn
		moving_pawn.forceMove(spot)
	if(stop_wandering)
		QDEL_NULL(idle_behavior)
	set_home(spot)
	if(spot.virtual_z() != pawn.virtual_z())
		to_chat(user, span_warning("That's not on [pawn]'s level, so it won't get there by itself. Move it there, or it'll give up and make wherever it is home."))
	var/list/shown_coords = spot.get_relative_location() || list(spot.x, spot.y)
	log_admin("[key_name(user)] set the AI home of [key_name(pawn)] to [AREACOORD(spot)][move_there ? " and moved it there" : ""][stop_wandering ? ", and stopped it wandering" : ""].")
	to_chat(user, span_notice("[pawn] now calls [get_area_name(spot, TRUE)] ([shown_coords[1]], [shown_coords[2]]) home[move_there ? ", and is there" : ""][stop_wandering ? ", and stays put when idle" : ""]."))

/// A readout of what the mob's doing and its knowledge
/datum/ai_controller/proc/get_debug_state()
	var/static/list/status_names = list("[AI_STATUS_ON]" = "on", "[AI_STATUS_OFF]" = "off", "[AI_STATUS_IDLE]" = "asleep")
	. = list("<b>AI state of [pawn] ([type])</b>")
	. += "Status: [status_names["[ai_status]"] || ai_status][low_priority ? ", low priority (nobody alive on its z-level, so it only thinks every [AI_LOW_PRIORITY_INTERVAL / 10] seconds)" : ""][able_to_plan() ? "" : ", <b>can't plan</b> until what it's doing finishes"]"
	var/list/behavior_lines = list()
	for(var/datum/ai_behavior/behavior as anything in current_behaviors)
		var/list/arguments = behavior_args[behavior.type]
		behavior_lines += "[behavior.type][length(arguments) ? " ([arguments.Join(", ")])" : ""][behavior.behavior_flags & AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION ? "" : " <b>blocks planning</b>"]"
	. += "Doing: [length(behavior_lines) ? behavior_lines.Join("; ") : "nothing"]"
	. += "Moving to: [current_movement_target ? debug_describe(current_movement_target) : "nowhere"][calculating_path ? ", working out a path" : ""][length(movement_path) ? ", [length(movement_path)] steps left" : ""]"
	pawn_conditions = null // as things are now, rather than as of our last plan
	. += "Conditions: [ai_conditions_to_text(get_conditions()) || "none"]"
	var/turf/pawn_turf = get_turf(pawn)
	. += "Standing at: [pawn_turf ? "[pawn_turf.x],[pawn_turf.y]" : "nowhere"]"
	// what our shot checks make of the line to who we're fighting, for working out why we are or aren't shooting
	var/atom/target = blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/mob/living/living_pawn = pawn
	if(istype(living_pawn) && living_pawn.GetComponent(/datum/component/ranged_attacks) && isatom(target) && !QDELETED(target))
		var/atom/blocker = get_shot_blocker(pawn_turf, get_turf(target), pass_flags = get_ai_shot_pass_flags(living_pawn))
		. += "Shot at target: [blocker ? "blocked by [debug_describe(blocker)], [has_clear_shot(living_pawn, target) ? "worth shooting through" : "<b>not worth shooting through</b>"]" : "clear"]"
	if(logging_decisions)
		. += "<b>Last plan:</b>"
		for(var/line in last_plan)
			. += "&nbsp;&nbsp;[line]"
		. += "<b>Recent decisions:</b>"
		for(var/line in decision_log)
			. += "&nbsp;&nbsp;[line]"
	else
		. += "<i>Not logging decisions. Turn on Toggle AI Decision Logging to see what it plans and decides.</i>"
	. += "<b>Blackboard:</b>"
	for(var/key in blackboard)
		var/value = blackboard[key]
		if(isnull(value))
			continue
		. += "&nbsp;&nbsp;[key]: [debug_describe(value)][describe_time_key(key, value)]"
	return jointext(., "<br>")

/// For the state view, how long ago or how far off a blackboard key holding a world.time is, like " (4.5s ago)", going by its name, or "" for any other key
/datum/ai_controller/proc/describe_time_key(key, value)
	if(!isnum(value) || !istext(key))
		return ""
	if(!findtext(key, "_time") && !findtext(key, "_since") && !findtext(key, "_until") && !findtext(key, "_next_") && !findtext(key, "_at", -3))
		return ""
	var/difference = round(abs(value - world.time) / 10, 0.1)
	return value > world.time ? " (in [difference]s)" : " ([difference]s ago)"

/// AI_CONDITION_* flags as text
/proc/ai_conditions_to_text(conditions)
	var/static/list/condition_names = list(
		"has target" = AI_CONDITION_HAS_TARGET,
		"target seen" = AI_CONDITION_TARGET_SEEN,
		"target lost" = AI_CONDITION_TARGET_LOST,
		"target adjacent" = AI_CONDITION_TARGET_ADJACENT,
		"taking cover" = AI_CONDITION_TAKING_COVER,
		"fighting from cover" = AI_CONDITION_FIGHTING_FROM_COVER,
		"flanking" = AI_CONDITION_FLANKING,
		"repositioning" = AI_CONDITION_REPOSITIONING,
		"backing off" = AI_CONDITION_BACKING_OFF,
		"seeking safety" = AI_CONDITION_SEEKING_SAFETY,
		"unsafe spot" = AI_CONDITION_UNSAFE_SPOT,
		"has ranged attack" = AI_CONDITION_HAS_RANGED_ATTACK,
		"broken" = AI_CONDITION_BROKEN,
		"reloading" = AI_CONDITION_RELOADING,
	)
	var/list/names = list()
	for(var/name in condition_names)
		if(conditions & condition_names[name])
			names += name
	return names.Join(", ")

/**
 * How we decide what to do, for admins: our senses, then each planning subtree in the order it gets its say, with its guard,
 * and whether that guard would let it plan right now. The first to take over planning stops the rest, so read it top to bottom
 */
/datum/ai_controller/proc/get_debug_tree()
	pawn_conditions = null // as things are now, rather than as of our last plan
	var/current_conditions = get_conditions()
	. = list("<b>AI tree of [pawn] ([type])</b>")
	. += "Conditions now: [ai_conditions_to_text(current_conditions) || "none"]"
	. += "<b>Senses</b>, every plan:"
	for(var/datum/ai_sensor/sensor as anything in sensors)
		. += "&nbsp;&nbsp;[sensor.type]"
	if(!length(sensors))
		. += "&nbsp;&nbsp;none"
	. += "<b>Planning</b>, top to bottom:"
	. += describe_subtrees(planning_subtrees, current_conditions, 1)
	. += "Then, with nothing to do: [idle_behavior ? idle_behavior.type : "nothing"]"
	return jointext(., "<br>")

/// Lines for the AI tree view about each of subtrees, depth levels in, with its guard and whether it'd plan right now, and what's in any groups among them
/datum/ai_controller/proc/describe_subtrees(list/subtrees, current_conditions, depth)
	. = list()
	var/indent = ""
	for(var/level in 1 to depth)
		indent += "&nbsp;&nbsp;&nbsp;&nbsp;"
	var/index = 0
	for(var/datum/ai_planning_subtree/subtree as anything in subtrees)
		index++
		var/list/guard = list()
		if(subtree.required_conditions)
			guard += "needs [ai_conditions_to_text(subtree.required_conditions)]"
		if(subtree.blocking_conditions)
			guard += "not while [ai_conditions_to_text(subtree.blocking_conditions)]"
		var/passes = subtree.guard_passes(current_conditions)
		. += "[indent][index]. [passes ? "" : "<s>"][subtree.type][passes ? "" : "</s>"][length(guard) ? " ([guard.Join("; ")])" : ""][passes ? "" : ", <i>skipped now</i>"]"
		for(var/line in subtree.describe_for_tree(src))
			. += "[indent]&nbsp;&nbsp;&nbsp;&nbsp;[line]"
		var/list/children = subtree.get_child_subtrees()
		if(length(children))
			. += describe_subtrees(children, current_conditions, depth + 1)

/// Describes a blackboard value for get_debug_state()
/datum/ai_controller/proc/debug_describe(value)
	if(isatom(value))
		var/atom/thing = value
		var/turf/where = get_turf(thing)
		return "[thing] ([thing.type])[where ? " at [where.x],[where.y]" : ""][where && get_turf(pawn) ? ", [get_dist(pawn, where)] tiles away" : ""]"
	if(islist(value))
		var/list/value_list = value
		return "list of [length(value_list)]"
	if(isdatum(value))
		var/datum/thing = value
		return "[thing.type]"
	return "[value]"

/// Notes something we decided, for admins working out what we're up to, if decision logging is enabled.
/datum/ai_controller/proc/log_decision(text)
	LAZYADD(decision_log, "[round(world.time / 10, 0.1)]s: [text]")
	if(length(decision_log) > AI_DECISION_LOG_LENGTH)
		decision_log.Cut(1, 2)

/// Starts or stops logging what we decide, for admins.
/datum/ai_controller/proc/toggle_decision_logging()
	logging_decisions = !logging_decisions
	if(!logging_decisions)
		decision_log = null
		last_plan = null
	return logging_decisions
