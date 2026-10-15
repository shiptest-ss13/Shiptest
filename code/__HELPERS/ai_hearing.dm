// Helpers for AI working out what it can hear, and which of its allies would hear it

// how far away a sound from source sounds to listener, with each wall between them counting as wall_penalty more tiles, or null if that's further than distance
/proc/get_heard_distance(atom/source, atom/listener, distance, wall_penalty)
	var/heard_distance = get_dist(source, listener)
	if(heard_distance > distance)
		return null
	for(var/turf/line_turf as anything in get_line(source, listener))
		if(line_turf.density)
			heard_distance += wall_penalty
			if(heard_distance > distance)
				return null
	return heard_distance

/proc/get_ai_allies_in_range(mob/living/source, range)
	. = list()
	for(var/mob/living/ally in range(range, source))
		if(ally != source && ally.stat == CONSCIOUS && !ally.client && ally.ai_controller && source.faction_check_mob(ally))
			. += ally

/proc/get_ai_allies_in_earshot(mob/living/source, range = 7, wall_penalty = AI_HEARING_WALL_PENALTY)
	. = list()
	for(var/mob/living/ally as anything in get_ai_allies_in_range(source, range))
		if(!isnull(get_heard_distance(source, ally, range, wall_penalty)))
			. += ally
