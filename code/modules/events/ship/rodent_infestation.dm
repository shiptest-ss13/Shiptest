/datum/round_event_control/rodent_infestation
	name = "Small Rodent Infestation"
	typepath = /datum/round_event/ship/rodent_infestation
	weight = 15
	max_occurrences = 5
	min_players = 1
	earliest_start = 5 MINUTES

/datum/round_event/ship/rodent_infestation
	var/mob/living/basic/rodent_type = /mob/living/basic/mouse
	var/spawncount = 1

/datum/round_event/ship/rodent_infestation/setup()
	if(!..())
		return FALSE
	spawncount = rand(2, 4)
	//rodent_type = pick(/mob/living/simple_animal/mouse, /mob/living/simple_animal/hostile/rat)

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
