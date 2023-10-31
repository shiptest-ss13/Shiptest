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
	var/wave_downtime
	var/spawning_paused = FALSE
	var/wave_timer


/datum/component/spawner/Initialize(_mob_types, _spawn_time, _faction, _spawn_text, _max_mobs, _spawn_sound, _spawn_distance_min, _spawn_distance_max, _wave_length, _wave_downtime)
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

	RegisterSignal(parent, list(COMSIG_PARENT_QDELETING), .proc/stop_spawning)
	START_PROCESSING(SSprocessing, src)

/datum/component/spawner/process()
	if(spawning_paused)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/START_PROCESSING, SSprocessing, src), wave_downtime)
		spawning_paused = FALSE
		wave_timer = null
		stop_spawning()
	try_spawn_mob()

/datum/component/spawner/proc/stop_spawning(force)
	SIGNAL_HANDLER

	STOP_PROCESSING(SSprocessing, src)
	for(var/mob/living/simple_animal/L in spawned_mobs)
		if(L.nest == src)
			L.nest = null
	spawned_mobs = null

/datum/component/spawner/proc/try_spawn_mob()
	var/atom/P = parent
	var/turf/spot = P.loc
	if(!wave_timer && wave_length)
		wave_timer = wave_length + world.time
	if(world.time > wave_timer)
		spawning_paused = TRUE
		return 0
	if(spawned_mobs.len >= max_mobs)
		return 0
	if(spawn_delay > world.time)
		return 0
	//Avoid using this with spawners that add this component on initialize
	//It causes numerous runtime errors during planet generation
	if(spawn_distance_max > 1)
		spot = pick(turf_peel(spawn_distance_max, spawn_distance_min, P.loc, view_based = TRUE))
		if(!spot)
			spot = pick(circlerangeturfs(P.loc, spawn_distance_max))
	spawn_delay = world.time + spawn_time
	var/chosen_mob_type = pickweight(mob_types)
	var/mob/living/simple_animal/L = new chosen_mob_type(spot)
	L.flags_1 |= (P.flags_1 & ADMIN_SPAWNED_1)
	spawned_mobs += L
	L.nest = src
	L.faction = src.faction
	P.visible_message("<span class='danger'>[L] [pick(spawn_text)] [P].</span>")
	if(length(spawn_sound))
		playsound(P, pick(spawn_sound), 50, TRUE)



/**
 * Behaves like the orange() proc, but only looks in the outer range of the function (The "peel" of the orange).
 * Can't think of a better place to put this.
 * Credit to ArcaneMusic for this very handy proc
 */
/proc/turf_peel(outer_range, inner_range, center, view_based = FALSE)
	var/list/peel = list()
	var/list/outer
	var/list/inner
	if(view_based)
		outer = circleviewturfs(center, outer_range)
		inner = circleviewturfs(center, inner_range)
	else
		outer = circlerangeturfs(center, outer_range)
		inner = circlerangeturfs(center, inner_range)
	for(var/turf/possible_spawn in outer)
		if(possible_spawn in inner)
			continue
		if(istype(possible_spawn, /turf/closed))
			continue
		peel += possible_spawn
	return peel

