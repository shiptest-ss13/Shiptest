/datum/mission/drill
	name = "Class 1 core sample mission"
	desc = "We require geological information from one of the neighboring planetoids . \
			Please anchor the drill in place and defend it until it has gathered enough samples.\
			Operation of the core sampling drill is extremely dangerous, caution is advised. "
	value = 2000
	duration = 80 MINUTES
	weight = 8

	var/obj/machinery/drill/mission/sampler
	var/num_wanted = 4
	var/class_wanted = 1

/datum/mission/drill/New(...)
	num_wanted = rand(num_wanted-2,num_wanted+2)
	value += num_wanted*100
	return ..()

/datum/mission/drill/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	. = ..()
	sampler = spawn_bound(/obj/machinery/drill/mission, accept_loc, VARSET_CALLBACK(src, sampler, null))
	sampler.mission_class = class_wanted
	sampler.num_wanted = num_wanted
	sampler.name += " (Class [class_wanted])"
//Gives players a little extra money for going past the mission goal
/datum/mission/drill/turn_in()
	value += (sampler.num_current - num_wanted)*50
	. = ..()

/datum/mission/drill/can_complete()
	. = ..()
	if(!.)
		return
	var/obj/docking_port/mobile/scanner_port = SSshuttle.get_containing_shuttle(sampler)
	return . && (sampler.num_current >= num_wanted) && (scanner_port?.current_ship == servant)

/datum/mission/drill/get_progress_string()
	if(!sampler)
		return "0/[num_wanted]"
	else
		return "[sampler.num_current]/[num_wanted]"

/datum/mission/drill/Destroy()
	sampler = null
	return ..()

/datum/mission/drill/turn_in()
	recall_bound(sampler)
	return ..()

/datum/mission/drill/give_up()
	recall_bound(sampler)
	return ..()

/datum/mission/drill/classtwo
	name = "Class 2 core sample mission"
	value = 3500
	weight = 6
	class_wanted = 2
	num_wanted = 6

/datum/mission/drill/classthree
	name = "Class 3 core sample mission"
	value = 5000
	weight = 4
	duration = 100 MINUTES
	class_wanted = 3
	num_wanted = 8

/*
		Core sampling drill
*/

/obj/machinery/drill/mission
	name = "core sampling research drill"
	desc = "A specialized laser drill designed to extract geological samples."

	var/num_current = 0
	var/mission_class
	var/num_wanted

/obj/machinery/drill/mission/examine()
	. = ..()
	. += "<span class='notice'>The drill contains [num_current] of the [num_wanted] samples needed.</span>"

/obj/machinery/drill/mission/start_mining()
	if(mining.vein_class < mission_class && mining)
		say("Error: A vein class of [mission_class] or greater is required for operation.")
		return
	. = ..()

/obj/machinery/drill/mission/mine_success()
	num_current++
