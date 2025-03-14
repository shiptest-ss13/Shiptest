/datum/mission/ruin/multiple
	var/required_turned_in = 0
	var/required_count = 1

/datum/mission/ruin/multiple/turn_in(atom/movable/item_to_turn_in)
	if(required_count - required_turned_in > 1)
		do_sparks(3, FALSE, get_turf(item_to_turn_in))
		qdel(item_to_turn_in)
		required_turned_in++
	else
		return ..()

/datum/mission/ruin/multiple/e11_stash
	name = "recover a stash of Eoehoma weapons"
	desc = "My first mate found a Eoehoma document detailing a production plant for energy weapons in the sector, we'll pay well if you can recover and deliver 6 guns back to us."
	faction = /datum/faction/independent
	value = 2750
	setpiece_item = /obj/item/gun/energy/e_gun/e11
	specific_item = FALSE
	required_count = 6

/datum/mission/ruin/multiple/e11_stash/can_turn_in(atom/movable/item_to_check)
	if(istype(item_to_check, /obj/item/gun))
		var/obj/item/gun/eoehoma_gun = item_to_check
		if(eoehoma_gun.manufacturer == MANUFACTURER_EOEHOMA)
			return TRUE
