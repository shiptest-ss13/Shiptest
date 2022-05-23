/datum/mission/research
	var/num_current = 0
	var/num_wanted
	var/datum/overmap/objective_type

	var/static/list/datum/overmap/objective_types = list(
		/datum/overmap/event/meteor = "meteor",
		/datum/overmap/event/emp = "ion",
		/datum/overmap/event/electric = "electrical storm"
	)

/datum/mission/research/New()
	objective_type = pick(objective_types)
	num_wanted = rand(3, 8)
	duration = rand(16, 24) MINUTES // 20 +- 4
	var/pay_amt = rand(3, 5) * 50 // (4 +- 1) * 50
	value = round(pay_amt * num_wanted * (20 MINUTES / duration), 25)

	name = "[objective_types[objective_type]] research mission"
	desc = "Fly through some [objective_types[objective_type]]s on the overmap to get me data."

/datum/mission/research/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	. = ..()
	RegisterSignal(servant, COMSIG_OVERMAP_MOVED, .proc/ship_moved)
	return

/datum/mission/research/get_progress_string()
	return "[num_current]/[num_wanted]"

/datum/mission/research/is_complete()
	return ..() && (num_current >= num_wanted)

/datum/mission/research/proc/ship_moved(datum/overmap/ship/controlled/S, old_x, old_y, new_x, new_y)
	SIGNAL_HANDLER
	if(is_failed() || is_complete() || S != servant)
		return
	var/datum/overmap/O = locate(objective_type) in SSovermap.overmap_container[new_x][new_y]
	if(!O)
		return
	num_current++
	return
