// Where a basic mob calls home, and admins setting it

/datum/ai_controller/basic_controller/forget_home()
	clear_blackboard_key(BB_BASIC_MOB_HOME_TURF)
	clear_blackboard_key(BB_BASIC_MOB_HOME_CHOSEN)
	clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT)
	clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT_SINCE)
	clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT_HOP)
	clear_blackboard_key(BB_BASIC_MOB_HOME_TRAIL)
	clear_blackboard_key(BB_BASIC_MOB_HOME_TRAIL_NEXT)
	clear_blackboard_key(BB_BASIC_MOB_HOME_TRAIL_SINCE)
	clear_blackboard_key(BB_BASIC_MOB_GUARD_ANCHOR)
	clear_blackboard_key(BB_BASIC_MOB_GUARD_ANCHOR_FOR)
	clear_blackboard_key(BB_BASIC_MOB_GUARD_HOME_TRAIL)
	cancel_movement_actions() // and stop walking back to the old one

/datum/ai_controller/basic_controller/set_home(turf/spot)
	forget_home()
	set_blackboard_key(BB_BASIC_MOB_HOME_TURF, spot)
	set_blackboard_key(BB_BASIC_MOB_HOME_CHOSEN, TRUE)
	wake_up() // so we go there even if we were asleep

/datum/ai_controller/basic_controller/proc/admin_set_home(mob/user)
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
