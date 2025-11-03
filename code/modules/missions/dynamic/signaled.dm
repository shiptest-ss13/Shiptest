/datum/mission/ruin/signaled
	var/registered_type
	/// What signal will spawn the required item
	var/mission_main_signal

/datum/mission/ruin/signaled/spawn_main_piece(obj/effect/landmark/mission_poi/mission_poi)
	var/atom/movable/registered_item = mission_poi.use_poi(registered_type, src)
	if(isatom(registered_item))
		set_bound(registered_item, null, FALSE, TRUE)
		RegisterSignal(registered_item, mission_main_signal, PROC_REF(on_signaled))
	else
		stack_trace("[src] did not generate a required item.")
		qdel(src)

/datum/mission/ruin/signaled/proc/on_signaled(atom/movable/registered_item)
	SIGNAL_HANDLER

	required_item = new setpiece_item(registered_item.loc)
	set_bound(required_item, null, FALSE, TRUE)
	UnregisterSignal(registered_item, mission_main_signal)
	remove_bound(registered_item)

/obj/effect/landmark/mission_poi/main/drill

/datum/mission/ruin/signaled/drill
	name = "Drill Activation"
	desc = "An industrial drill has been deployed for prospecting efforts on this world. \
			The drill was disabled by local fauna, and our staff were unable to complete the prospecting operation. \
			Go to the site, activate the drill, and complete the initial sampling run. \
			Return the data that the drill produces for your reward."
	value = 15000
	mission_limit = 5
	faction = list(
		/datum/faction/nt,
		/datum/faction/nt/ns_logi,
		/datum/faction/nt/vigilitas,
		/datum/faction/independent
	)
	registered_type = /obj/machinery/drill/mission/ruin
	setpiece_item = /obj/item/drill_readout
	mission_main_signal = COMSIG_DRILL_SAMPLES_DONE

/*
	Core sampling drill
*/

/obj/machinery/drill/mission
	name = "core sampling research drill"
	desc = "A specialized laser drill designed to extract geological samples."

	var/num_current = 0
	var/mission_class
	var/num_wanted
	var/obj/structure/vein/orevein_wanted

/obj/machinery/drill/mission/examine()
	. = ..()
	. += span_notice("The drill contains [num_current] of the [num_wanted] samples needed.")

/obj/machinery/drill/mission/start_mining()
	if(orevein_wanted && !istype(our_vein, orevein_wanted))
		say("Error: Incorrect class of planetiod for operation.")
		return
	if(our_vein.vein_class < mission_class && our_vein)
		say("Error: A vein class of [mission_class] or greater is required for operation.")
		return
	return ..()

/obj/machinery/drill/mission/mine_success()
	num_current++

	if(num_current == num_wanted)
		SEND_SIGNAL(src, COMSIG_DRILL_SAMPLES_DONE)
		say("Required samples gathered, shutting down!")
		if(active)
			stop_mining()

/obj/machinery/drill/mission/ruin
	name = "industrial grade mining drill"
	desc = "A large scale laser drill. It's able to mine vast amounts of minerals from near-surface ore pockets, this one is designed for mining outposts."
	mission_class = 4
	num_wanted = 10

/obj/item/drill_readout
	name = "geological sampling data"
	desc = "A lengthy report on the geological conditions of the world."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "docs_part"
	item_state = "paper"
	w_class = WEIGHT_CLASS_SMALL
