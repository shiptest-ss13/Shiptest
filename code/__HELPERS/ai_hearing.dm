// Helpers for AI working out what it can hear, and which of its allies would hear it

// how far away a sound from source sounds to listener, with each wall between them counting as wall_penalty more tiles, or null if that's further than distance.
// Thin air carries it less far, unless it doesn't go through the air, like over the radio
/proc/get_heard_distance(atom/source, atom/listener, distance, wall_penalty, through_air = TRUE)
	var/heard_distance = get_dist(source, listener)
	if(through_air && heard_distance > 1) // right by it, we hear it whatever the air, as players do
		// never quite nothing, as up close we'd still see the flash or feel it through the floor
		distance *= max(get_sound_pressure_factor(get_turf(source), get_turf(listener)), AI_MINIMUM_SOUND_FACTOR)
	if(heard_distance > distance)
		return null
	for(var/turf/line_turf as anything in get_line(source, listener))
		if(line_turf.density)
			heard_distance += wall_penalty
			if(heard_distance > distance)
				return null
	return heard_distance

// how much of its usual distance a sound carries between source and listener, going by the thinner air of the two, as for players,
/proc/get_sound_pressure_factor(turf/source, turf/listener)
	var/datum/gas_mixture/source_air = source?.return_air()
	var/datum/gas_mixture/listener_air = listener?.return_air()
	if(!source_air || !listener_air)
		return 0 // space
	var/pressure = min(source_air.return_pressure(), listener_air.return_pressure())
	// fading from normal air down to where players hear nothing, as /proc/playsound() does for players
	if(pressure >= ONE_ATMOSPHERE)
		return 1
	return max((pressure - SOUND_MINIMUM_PRESSURE) / (ONE_ATMOSPHERE - SOUND_MINIMUM_PRESSURE), 0)

// whether victim is source or one of their own, don't celebrate
/proc/ai_is_ally(mob/living/source, mob/living/victim)
	return victim == source || source.faction_check_mob(victim)

/proc/get_ai_allies_in_range(mob/living/source, range)
	. = list()
	for(var/mob/living/ally in range(range, source))
		if(ally != source && ally.stat == CONSCIOUS && !ally.client && ally.ai_controller && source.faction_check_mob(ally))
			. += ally

/proc/get_ai_allies_in_earshot(mob/living/source, range = 7, wall_penalty = AI_HEARING_WALL_PENALTY)
	. = list()
	for(var/mob/living/ally as anything in get_ai_allies_in_range(source, range))
		if(!isnull(get_heard_distance(source, ally, range, wall_penalty, through_air = FALSE))) // over the radio, so the air doesn't matter
			. += ally

// fuzz sound origin so they dont always home in the direct location. can be in a wall but thats intentional
/proc/guess_sound_origin(turf/origin, inaccuracy, somewhere_to_stand = FALSE)
	if(inaccuracy < 1)
		return origin
	for(var/attempt in 1 to 5)
		var/turf/guess = locate(origin.x + rand(-inaccuracy, inaccuracy), origin.y + rand(-inaccuracy, inaccuracy), origin.z)
		if(guess && (!somewhere_to_stand || (isopenturf(guess) && !guess.is_blocked_turf(TRUE))))
			return guess
	return origin
