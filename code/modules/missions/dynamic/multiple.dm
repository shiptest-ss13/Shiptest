/datum/mission/ruin/multiple
	//this type does not currently support specific items as they arent stored in a list.
	specific_item = FALSE
	var/required_turned_in = 0
	var/required_count = 1

/datum/mission/ruin/multiple/turn_in(atom/movable/item_to_turn_in)
	if(required_count - required_turned_in > 1)
		do_sparks(3, FALSE, get_turf(item_to_turn_in))
		qdel(item_to_turn_in)
		required_turned_in++
	else
		return ..()
