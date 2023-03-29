/datum/round_event_control/borer
	name = "Borer"
	typepath = /datum/round_event/ghost_role/borer
	weight = 10 //Default weight
	max_occurrences = 1
	min_players = 15 //10 is MINIMUM needed, but this is not a gamemode that does well in lowpop
	earliest_start = 24000 //40 min, double default timer


/datum/round_event_control/borer/canSpawnEvent()
	. = ..()
	if(!.)
		return .

	for(var/mob/living/simple_animal/borer/B in GLOB.player_list)
		if(B.stat != DEAD)
			return FALSE

/datum/round_event/ghost_role/borer
	announceWhen	= 400

	minimum_required = 1
	role_name = "cortical borer"

	// 50% chance of being incremented by one
	var/spawncount = 1
	fakeable = TRUE

/datum/round_event/ghost_role/borer/setup()
	announceWhen = rand(announceWhen, announceWhen + 50)
	if(prob(50))
		spawncount++

/datum/round_event/ghost_role/borer/announce(fake)
	var/living_borers = FALSE
	for(var/mob/living/simple_animal/borer/B in GLOB.player_list)
		if(B.stat != DEAD)
			living_borers = TRUE

	if(living_borers || fake)
		priority_announce("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", 'sound/ai/aliens.ogg')

/datum/round_event/ghost_role/borer/spawn_role()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in GLOB.machines)
		if(QDELETED(temp_vent))
			continue
		if(!temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(!temp_vent_parent)
				continue//no parent vent
			//Stops Borers getting stuck in small networks.
			//See: Security, Virology
			if(temp_vent_parent.other_atmosmch.len > 20)
				vents += temp_vent

	if(!vents.len)
		message_admins("An event attempted to spawn a borer but no suitable vents were found. Shutting down.")
		return MAP_ERROR

	var/list/candidates = get_candidates(ROLE_BORER, null, ROLE_BORER)

	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS

	while(spawncount > 0 && vents.len && candidates.len)
		var/obj/vent = pick_n_take(vents)
		var/client/C = pick_n_take(candidates)

		var/mob/living/simple_animal/borer/new_borer = new(vent.loc)
		new_borer.key = C.key

		spawncount--
		message_admins("[ADMIN_LOOKUPFLW(new_borer)] has been made into a borer by an event.")
		log_game("[key_name(new_borer)] was spawned as a borer by an event.")
		spawned_mobs += new_borer

	return SUCCESSFUL_SPAWN
