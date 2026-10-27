// Helpers for AI working out what it can hear, and which of its allies would hear it

// how far away a sound from source sounds to listener, with each wall between them counting as wall_penalty more tiles, or null if that's further than distance.
/proc/get_heard_distance(atom/source, atom/listener, distance, wall_penalty, through_air = TRUE)
	var/heard_distance = get_dist(source, listener)
	// ai always hear a little
	if(through_air && heard_distance > 1)
		distance *= max(get_sound_pressure_factor(get_turf(source), get_turf(listener)), AI_MINIMUM_SOUND_FACTOR)
	if(heard_distance > distance)
		return null
	for(var/turf/line_turf as anything in get_line(source, listener))
		if(line_turf.density)
			heard_distance += wall_penalty
			if(heard_distance > distance)
				return null
	return heard_distance

/proc/get_sound_pressure_factor(turf/source, turf/listener)
	var/datum/gas_mixture/source_air = source?.return_air()
	var/datum/gas_mixture/listener_air = listener?.return_air()
	if(!source_air || !listener_air)
		return 0 // space
	var/pressure = min(source_air.return_pressure(), listener_air.return_pressure())
	// fading from normal air down to where players hear nothing
	if(pressure >= ONE_ATMOSPHERE)
		return 1
	return max((pressure - SOUND_MINIMUM_PRESSURE) / (ONE_ATMOSPHERE - SOUND_MINIMUM_PRESSURE), 0)

// whether victim is source or one of their own, don't celebrate
/proc/ai_is_ally(mob/living/source, mob/living/victim)
	return victim == source || source.faction_check_mob(victim)

GLOBAL_LIST_EMPTY(ai_tick_caches)
GLOBAL_VAR_INIT(ai_tick_cache_time, -1)

// a list kept under cache_name for the rest of this tick, for working something out once for every AI asking. Emptied the first time it's asked for on a later tick, and at the start of each SSai_controllers fire, so it doesn't hold onto anything deleted since while every AI is asleep
/proc/ai_tick_cache(cache_name)
	if(GLOB.ai_tick_cache_time != world.time)
		clear_ai_tick_caches()
	. = GLOB.ai_tick_caches[cache_name]
	if(isnull(.))
		. = list()
		GLOB.ai_tick_caches[cache_name] = .

/proc/clear_ai_tick_caches()
	GLOB.ai_tick_caches.Cut()
	GLOB.ai_tick_cache_time = world.time

// the AI-controlled mobs on z_level, awake or asleep, worked out once a tick for everyone asking, rather than each of us going through everything in range(). Don't change the list it gives
/proc/get_ai_mobs_on_z(z_level)
	var/list/mobs_by_z = ai_tick_cache("mobs_by_z")
	if(!mobs_by_z["built"])
		mobs_by_z["built"] = TRUE
		var/list/controllers = SSai_controllers.active_ai_controllers.Copy()
		for(var/virtual_level in SSai_controllers.sleeping_ai_by_virtual_level)
			controllers += SSai_controllers.sleeping_ai_by_virtual_level[virtual_level]
		for(var/datum/ai_controller/controller as anything in controllers)
			var/mob/living/pawn = controller.pawn
			if(!isliving(pawn) || !isturf(pawn.loc))
				continue // only those out on a turf, as range() would give us, so not someone shut in a locker
			LAZYADD(mobs_by_z["[pawn.z]"], pawn)
	return mobs_by_z["[z_level]"] || list()

// ours within range of source, awake and AI-controlled. Asked a lot, by morale, callouts, orders and the like, so worked out once a tick for each of us and range
/proc/get_ai_allies_in_range(mob/living/source, range)
	var/list/allies_by_asker = ai_tick_cache("allies_by_asker")
	var/asker_key = "[REF(source)]|[range]"
	var/list/allies = allies_by_asker[asker_key]
	if(isnull(allies))
		allies = list()
		var/turf/source_turf = get_turf(source)
		if(source_turf)
			for(var/mob/living/ally as anything in get_ai_mobs_on_z(source_turf.z))
				if(ally != source && get_dist(source_turf, ally) <= range && !ally.client && source.faction_check_mob(ally))
					allies += ally
		allies_by_asker[asker_key] = allies
	. = list()
	for(var/mob/living/ally as anything in allies)
		if(!QDELETED(ally) && ally.stat == CONSCIOUS) // checked fresh, as one of ours may go down between askings in the same tick
			. += ally

/proc/get_ai_allies_in_earshot(mob/living/source, range = 7, wall_penalty = AI_HEARING_WALL_PENALTY)
	. = list()
	for(var/mob/living/ally as anything in get_ai_allies_in_range(source, range))
		if(!isnull(get_heard_distance(source, ally, range, wall_penalty, through_air = FALSE))) // over the radio, so the air doesn't matter
			. += ally

// fuzz sound origin so they dont always home in the direct location.
/proc/guess_sound_origin(turf/origin, inaccuracy, somewhere_to_stand = FALSE, atom/listener)
	if(inaccuracy < 1)
		return origin
	var/origin_distance = listener ? get_dist(listener, origin) : 0
	for(var/attempt in 1 to 5)
		var/turf/guess = locate(origin.x + rand(-inaccuracy, inaccuracy), origin.y + rand(-inaccuracy, inaccuracy), origin.z)
		if(!guess)
			continue
		if(listener && get_dist(listener, guess) < origin_distance && ai_can_see(listener, guess))
			continue // if we can see the guessed spot dont bother guessing
		if(!somewhere_to_stand || (isopenturf(guess) && !guess.is_blocked_turf(TRUE)))
			return guess
	return origin
