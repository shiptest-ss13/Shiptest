/datum/round_event_control/ship/rodent_infestation
	name = "Small Rodent Infestation"
	typepath = /datum/round_event/ship/rodent_infestation
	weight = 15
	max_occurrences = 5
	min_players = 1
	earliest_start = 5 MINUTES
	admin_setup = list(
		/datum/event_admin_setup/listed_options/ship,
		/datum/event_admin_setup/listed_options/rodent,
		/datum/event_admin_setup/input_number/rodent
	)

/datum/round_event/ship/rodent_infestation
	var/mob/living/basic/rodent_type = /mob/living/basic/mouse
	var/spawncount = 1

/datum/round_event/ship/rodent_infestation/start()
	var/list/vents = list()
	if(!length(target_ship.shuttle_port.shuttle_areas))
		return FALSE

	for(var/area/ship_area in target_ship.shuttle_port.shuttle_areas)
		for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in ship_area)
			if(QDELETED(temp_vent))
				continue
			if(!temp_vent.welded)
				vents += temp_vent

	while((spawncount >= 1) && vents.len)
		var/obj/vent = pick(vents)
		announce_to_ghosts(spawn_atom_to_turf(rodent_type, vent, 1, FALSE))
		vents -= vent
		spawncount--

/datum/event_admin_setup/listed_options/rodent
	input_text = "Name your chosen warrior"
	normal_run_option = "Random Rodent"

/datum/event_admin_setup/listed_options/rodent/get_list()
	return subtypesof(/mob/living/basic) + subtypesof(/mob/living/simple_animal)

/datum/event_admin_setup/listed_options/rodent/apply_to_event(datum/round_event/ship/rodent_infestation/event)
	if(isnull(chosen))
		event.rodent_type = pick(/mob/living/basic/mouse, /mob/living/basic/mouse/rat, /mob/living/basic/cockroach)
	else
		event.rodent_type = chosen

/datum/event_admin_setup/input_number/rodent
	input_text = "How strong do you want your hoard"
	default_value = 3

/datum/event_admin_setup/input_number/rodent/apply_to_event(datum/round_event/ship/rodent_infestation/event)
	if(isnull(chosen_value))
		event.spawncount = rand(2,4)
	else
		event.spawncount = chosen_value

