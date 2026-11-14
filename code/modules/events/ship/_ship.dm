/datum/round_event_control/ship
	requires_ship = TRUE
	description = "Event local to a ship"
	admin_setup = list(/datum/event_admin_setup/listed_options/ship)

/datum/round_event/ship
	var/datum/overmap/ship/controlled/target_ship

/datum/round_event/ship/setup()
	if(SSovermap.controlled_ships && length(SSovermap.controlled_ships))
		target_ship = pick(SSovermap.controlled_ships)
		return TRUE
	return FALSE

/datum/round_event/ship/announce_deadchat(random, cause)
	deadchat_broadcast(" has just been[random ? " randomly" : ""] triggered[cause ? " by [cause]" : ""]!", "<b>[control.name]</b>. Located on [target_ship.name]", message_type=DEADCHAT_ANNOUNCEMENT) //STOP ASSUMING IT'S BADMINS!

/datum/round_event/ship/proc/find_event_area()
	if(length(target_ship.shuttle_port.shuttle_areas))
		return pick(target_ship.shuttle_port.shuttle_areas)

/datum/round_event/ship/proc/find_event_turf()
	var/area/ship_area = find_event_area()
	return pick(get_area_turfs(ship_area))

/datum/event_admin_setup/listed_options/ship
	input_text = "Select Ship"
	normal_run_option = "Random Ship"

/datum/event_admin_setup/listed_options/ship/get_list()
	return LAZYCOPY(SSovermap.controlled_ships)

/datum/event_admin_setup/listed_options/ship/apply_to_event(datum/round_event/ship/event)
	if(isnull(chosen))
		if(SSovermap.controlled_ships && length(SSovermap.controlled_ships))
			event.target_ship = pick(SSovermap.controlled_ships)
	else
		event.target_ship = chosen
	if(!isdatum(event.target_ship))
		return ADMIN_CANCEL_EVENT
	message_admins("[event.target_ship] was selected for [src]")
