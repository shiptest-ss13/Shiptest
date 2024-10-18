/datum/mission/dynamic/signaled
	var/registered_type
	var/atom/movable/registered_item
	/// What signal will spawn the required item
	var/mission_main_signal

/datum/mission/dynamic/signaled/spawn_main_piece(obj/effect/landmark/mission_poi/mission_poi)
	var/registered_item = set_bound(mission_poi.use_poi(registered_type), null, FALSE, TRUE)
	RegisterSignal(registered_item, mission_main_signal, PROC_REF(on_signaled))

/datum/mission/dynamic/signaled/proc/on_signaled(atom/movable/registered_item)
	SIGNAL_HANDLER

	required_item = new setpiece_item(registered_item.loc)
	set_bound(required_item, null, FALSE, TRUE)
	UnregisterSignal(registered_item, mission_main_signal)
	remove_bound(registered_item)

/obj/effect/landmark/mission_poi/main/drill

/datum/mission/dynamic/signaled/drill
	name = "drill mission"
	desc = "get this drill back up and running and send us proof"
	value = 3000
	faction = list(
		/datum/faction/nt,
		/datum/faction/nt/ns_logi,
		/datum/faction/nt/vigilitas,
		/datum/faction/frontier,
		/datum/faction/independent
	)
	registered_type = /obj/machinery/drill/mission/ruin
	setpiece_item = /obj/item/drill_readout
	mission_main_signal = COMSIG_DRILL_SAMPLES_DONE

/*
 * Core sampling drill
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
	if(num_current == num_wanted)
		SEND_SIGNAL(src, COMSIG_DRILL_SAMPLES_DONE)

//I want this to be a 3x3 machine in future
/obj/machinery/drill/mission/ruin
	name = "industrial grade mining drill"
	desc = "A large scale laser drill. It's able to mine vast amounts of minerals from near-surface ore pockets, this one is designed for mining outposts."
	anchored = TRUE
	mission_class = 4
	num_wanted = 15

/obj/item/drill_readout
	name = "drill debug information"
	desc = "Created by a mining outpost drill."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "paper"
	item_state = "paper"
	w_class = WEIGHT_CLASS_SMALL
