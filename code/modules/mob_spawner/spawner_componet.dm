/datum/component/spawner
	var/mob_types = list(/mob/living/simple_animal/hostile/carp)
	var/spawn_time = 300 //30 seconds default
	var/list/spawned_mobs = list()
	var/spawn_delay = 0
	var/max_mobs = 5
	var/list/spawn_text = list("emerges from")
	var/list/faction = list("mining")
	var/list/spawn_sound = list()
	var/spawn_distance_min = 1
	var/spawn_distance_max = 1
	var/wave_length //Average time until break in spawning
	var/wave_downtime //Average time until spawning starts again
	var/wave_timer
	var/current_timerid
	var/spawn_amount

/datum/component/spawner/Initialize(_mob_types, _spawn_time, _faction, _spawn_text, _max_mobs, _spawn_sound, _spawn_distance_min, _spawn_distance_max, _wave_length, _wave_downtime, _spawn_amount = 1)
	if(_spawn_time)
		spawn_time=_spawn_time
	if(_mob_types)
		mob_types=_mob_types
	if(_faction)
		faction=_faction
	if(_spawn_text)
		spawn_text=_spawn_text
	if(_max_mobs)
		max_mobs=_max_mobs
	if(_spawn_sound)
		spawn_sound=_spawn_sound
	if(_spawn_distance_min)
		spawn_distance_min=_spawn_distance_min
	if(_spawn_distance_max)
		spawn_distance_max=_spawn_distance_max
	if(_wave_length)
		wave_length = _wave_length
	if(_wave_downtime)
		wave_downtime = _wave_downtime
	if(_spawn_amount)
		spawn_amount = _spawn_amount

	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(stop_spawning))
	RegisterSignal(parent, COMSIG_SPAWNER_TOGGLE_SPAWNING, PROC_REF(toggle_spawning))
	START_PROCESSING(SSprocessing, src)

/datum/component/spawner/process(seconds_per_tick)
	if(!parent) //Sanity check for instances where the spawner may be sleeping while the parent is destroyed
		qdel(src)
		return
	try_spawn_mob()

/datum/component/spawner/proc/stop_spawning(force)
	SIGNAL_HANDLER

	STOP_PROCESSING(SSprocessing, src)
	deltimer(current_timerid)
	for(var/mob/living/simple_animal/L in spawned_mobs)
		if(L.nest == src)
			L.nest = null
	spawned_mobs = null

//Different from stop_spawning() as it doesn't untether all mobs from it and is meant for temporarily stopping spawning
/datum/component/spawner/proc/toggle_spawning(datum/source, currently_spawning)
	SIGNAL_HANDLER

	if(currently_spawning)
		STOP_PROCESSING(SSprocessing, src)
		deltimer(current_timerid) //Otherwise if spawning is paused while the wave timer is loose it'll just unpause on its own
		COOLDOWN_RESET(src, wave_timer)
		return FALSE
	else
		START_PROCESSING(SSprocessing, src)
		return TRUE

/datum/component/spawner/proc/try_spawn_mob()
	var/atom/P = parent
	var/turf/spot = get_turf(P)
	//Checks for handling the wave-based pausing and unpausing of spawning
	//Almost certainly a better way to do this, but until then this technically works
	if(wave_length)
		if(!wave_timer)
			COOLDOWN_START(src, wave_timer, wave_length)
		if(wave_timer && COOLDOWN_FINISHED(src, wave_timer))
			COOLDOWN_RESET(src, wave_timer)
			STOP_PROCESSING(SSprocessing, src)
			current_timerid = addtimer(CALLBACK(src, PROC_REF(toggle_spawning)), wave_downtime, TIMER_STOPPABLE)
			return
	////////////////////////////////
	if(length(spawned_mobs) >= max_mobs)
		return
	if(!COOLDOWN_FINISHED(src, spawn_delay))
		return
	COOLDOWN_START(src, spawn_delay, spawn_time)
	var/to_spawn = clamp(spawn_amount, 1, max_mobs - length(spawned_mobs))
	for(var/mob_index in 1 to to_spawn)
		if(length(spawned_mobs) >= max_mobs)
			return
		if(spawn_distance_max > 1)
			var/origin = spot
			var/list/peel = turf_peel(spawn_distance_max, spawn_distance_min, origin, view_based = TRUE)
			if(length(peel))
				spot = pick(peel)
			else
				spot = pick(circleviewturfs(origin, spawn_distance_max))
		var/chosen_mob_type = pick_weight(mob_types)
		var/mob/living/simple_animal/L = new chosen_mob_type(spot)
		L.flags_1 |= (P.flags_1 & ADMIN_SPAWNED_1)
		spawned_mobs += L
		L.nest = src
		L.faction = src.faction
		P.visible_message(span_danger("[L] [pick(spawn_text)] [P]."))
		if(length(spawn_sound))
			playsound(P, pick(spawn_sound), 50, TRUE)
