/datum/round_event_control/ship/spider_infestation
	name = "Spider Infestation"
	typepath = /datum/round_event/ship/spider_infestation
	weight = 1
	max_occurrences = 2
	min_players = 15
	earliest_start = 30 MINUTES

/datum/round_event/ship/spider_infestation
	var/spawncount = 1

/datum/round_event/ship/spider_infestation/setup()
	. = ..()
	announce_when = rand(announce_when, announce_when + 50)
	spawncount = rand(1, 4)

/datum/round_event/ship/spider_infestation/announce(fake)
	var/area/event_area = find_event_area()
	priority_announce(
		"Unidentified lifesigns detected coming aboard [target_ship]. Secure any exterior access, including ducting and ventilation.",
		"Lifesign Alert",
		'sound/ai/aliens.ogg',
		sender_override = "Lifesign Detection System",
		zlevel = event_area.virtual_z()
	)

/datum/round_event/ship/spider_infestation/start()
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
		var/spawn_type = /obj/structure/spider/spiderling
		if(prob(66))
			spawn_type = /obj/structure/spider/spiderling/nurse
		announce_to_ghosts(spawn_atom_to_turf(spawn_type, vent, 1, FALSE))
		vents -= vent
		spawncount--
