/datum/round_event_control/rodent_infestation
	name = "Small Rodent Infestation"
	typepath = /datum/round_event/ship/rodent_infestation
	weight = 10
	max_occurrences = 3
	min_players = 0
	earliest_start = 0 //5 MINUTES

/datum/round_event/rodent_infestation
	announceWhen	= 400
	var/mob/living/simple_animal/rodent_type
	var/spawncount = 1


/datum/round_event/rodent_infestation/setup()
	spawncount = rand(5, 8)
	rodent_type = pick(/mob/living/simple_animal/mouse, /mob/living/simple_animal/hostile/rat)

/datum/round_event/rodent_infestation/start()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in GLOB.machines)
		if(QDELETED(temp_vent))
			continue
		if(!temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(temp_vent_parent.other_atmosmch.len > 20)
				vents += temp_vent

	while((spawncount >= 1) && vents.len)
		var/obj/vent = pick(vents)
		announce_to_ghosts(spawn_atom_to_turf(rodent_type, vent, 1, FALSE))
		vents -= vent
		spawncount--
