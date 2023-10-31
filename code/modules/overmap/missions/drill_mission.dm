/datum/mission/drill
	name = "Class 2 core sample mission"
	desc = "We require geological information from one of the neighboring planetoids . \
			Please anchor the drill in place and defend it until it has gathered enough smaples.\
			Operation of the core sampling drill is extremely dangerous, use caution. "
	value = 3000
	duration = 80 MINUTES
	weight = 10

	var/obj/machinery/drill/research/sampler
	var/num_wanted = 10
	var/class_wanted = 2

/datum/mission/drill/New(...)
	num_wanted = rand(num_wanted-2,num_wanted+2)
	value += num_wanted*100

/datum/mission/drill/can_complete()
	. = ..()
	if(!.)
		return
	var/obj/docking_port/mobile/scanner_port = SSshuttle.get_containing_shuttle(sampler)
	return . && (sampler.num_current >= num_wanted) && (scanner_port?.current_ship == servant)

/datum/mission/drill/get_progress_string()
	return "[sampler.num_current]/[num_wanted]"

/datum/mission/research/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	. = ..()
	sampler = spawn_bound(/obj/machinery/drill/mission, accept_loc, VARSET_CALLBACK(src, sampler, null))

/datum/mission/drill/Destroy()
	sampler = null
	return ..()

/datum/mission/drill/turn_in()
	recall_bound(sampler)
	return ..()

/datum/mission/drill/give_up()
	recall_bound(sampler)
	return ..()

/*
		Core sampling drill
*/

/obj/machinery/drill/mission
	name = "core sampling research drill"
	desc = "A specialized laser drill designed to extract geological samples."

	var/num_current
	var/mission_class

/obj/machinery/drill/examine()
	. = ..()
	. += "<span class='notice'>The drill contains [num_current] of the [].</span>"

/obj/machinery/drill/mission/start_mining()
	if(mining.vein_class < mission_class)
		to_chat(user, "<span class='notice'>[src] requires at least a class [mission_class] vein or higher.</span>")
		return
	. = ..()

/obj/machinery/drill/mission/mine()
	if(mining.mining_charges)
		mining.mining_charges--
		num_current++
		start_mining()
	else if(!mining.mining_charges)
		say("Error: Vein Depleted")
		active = FALSE
		update_icon_state()
		update_overlays()

