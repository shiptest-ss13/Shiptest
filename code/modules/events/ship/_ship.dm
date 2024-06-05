/datum/round_event/ship
	var/datum/overmap/ship/controlled/target_ship

/datum/round_event/ship/setup()
	if(SSovermap.controlled_ships && length(SSovermap.controlled_ships))
		target_ship = pick(SSovermap.controlled_ships)
	else
		return FALSE
	return TRUE
