// fake magazines for AI, so they can "reload"
/datum/component/ai_magazine
	var/magazine_size = 0
	var/shots_left = 0
	var/reload_time = 3 SECONDS
	var/reload_sound = 'sound/weapons/gun/general/magazine_insert_full.ogg'
	var/eject_sound = 'sound/weapons/gun/general/magazine_remove_full.ogg'
	var/eject_empty_sound = 'sound/weapons/gun/general/magazine_remove_empty.ogg'
	var/chamber_sound
	var/cycle_sound
	var/single_loads = FALSE
	var/single_load_time = 0.5 SECONDS
	var/last_fired_time = 0
	var/reloading = FALSE //so we dont try to shoot during a reload
	//bumped whenever a reload starts or is broken off, so the timers of one we broke off know they're stale
	var/reload_id = 0
	//for single loaders, from when we count rounds going in between fights, see top_off()
	var/topped_off_since = 0
	var/magazine_name = "magazine"
	var/weapon_name = "weapon"

/datum/component/ai_magazine/Initialize(gun_type, magazine_size, reload_time)
	. = ..()
	if(!isbasicmob(parent))
		return COMPONENT_INCOMPATIBLE
	if(gun_type)
		set_from_gun(gun_type)
	if(magazine_size)
		src.magazine_size = magazine_size
	if(reload_time)
		src.reload_time = reload_time
	if(!src.magazine_size)
		return COMPONENT_INCOMPATIBLE // nothing to count
	shots_left = src.magazine_size

/datum/component/ai_magazine/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_BASICMOB_PRE_RANGED_ATTACK, PROC_REF(on_pre_fire))

/datum/component/ai_magazine/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_BASICMOB_PRE_RANGED_ATTACK)

// stops firing while reloading, and takes a shot off the magazine when firing, reloading once it's empty
/datum/component/ai_magazine/proc/on_pre_fire(mob/living/basic/source, atom/target)
	SIGNAL_HANDLER
	if(reloading)
		if(!single_loads || shots_left <= 0)
			return COMPONENT_CANCEL_RANGED_ATTACK
		// loading a round at a time, so we break off to fire what's in, as a player would
		reload_id++
		reloading = FALSE
	top_off()
	if(shots_left <= 0)
		start_reload()
		return COMPONENT_CANCEL_RANGED_ATTACK
	shots_left--
	last_fired_time = world.time
	topped_off_since = world.time
	if(cycle_sound)
		addtimer(CALLBACK(src, PROC_REF(play_if_alive), cycle_sound), 0.4 SECONDS)
	if(shots_left <= 0)
		addtimer(CALLBACK(src, PROC_REF(start_reload)), 0.1 SECONDS) // once the shot's gone off
	return NONE

/datum/component/ai_magazine/proc/needs_reload()
	return !reloading && shots_left < magazine_size

// for single loaders
/datum/component/ai_magazine/proc/top_off()
	if(!single_loads || reloading || shots_left >= magazine_size)
		return
	// a couple of seconds after our last shot, we start feeding rounds in between fights
	// dont top up between volleys in a fight! looks weird and leads to seemingly infinite ammo situations
	var/mob/living/basic/basic_mob = parent
	var/datum/ai_controller/controller = basic_mob.ai_controller
	var/fight_ended = 0
	if(controller && !isnull(controller.blackboard[BB_BASIC_MOB_LAST_SAW_ENEMY_TIME]))
		fight_ended = controller.blackboard[BB_BASIC_MOB_LAST_SAW_ENEMY_TIME] + AI_FIGHT_MEMORY
	var/loading_time = world.time - max(topped_off_since, last_fired_time + 2 SECONDS, fight_ended)
	if(loading_time <= 0)
		return
	var/rounds = min(magazine_size - shots_left, round(loading_time / single_load_time))
	if(rounds <= 0)
		return
	shots_left += rounds
	topped_off_since = max(topped_off_since, last_fired_time + 2 SECONDS) + rounds * single_load_time // so these rounds aren't counted again

/datum/component/ai_magazine/proc/start_reload(tactical = FALSE)
	var/mob/living/basic/basic_mob = parent
	if(reloading || basic_mob.stat == DEAD)
		return FALSE
	top_off()
	if(shots_left >= magazine_size)
		return FALSE
	reloading = TRUE
	reload_id++
	var/this_reload_time = reload_time
	if(single_loads)
		// a round at a time, each one heard going in, so players can count them, and each one ready to fire once it's in
		var/rounds_to_load = magazine_size - max(shots_left, 0)
		this_reload_time = rounds_to_load * single_load_time
		addtimer(CALLBACK(src, PROC_REF(load_round), rounds_to_load, reload_id), single_load_time)
	else
		playsound(basic_mob, tactical ? eject_sound : eject_empty_sound, 50, TRUE)
	if(!tactical)
		basic_mob.visible_message(span_notice("[basic_mob] starts reloading."))
		ai_callout(basic_mob, AI_CALLOUT_RELOADING)
	else if(single_loads)
		basic_mob.visible_message(span_notice("[basic_mob] starts topping off [basic_mob.p_their()] [weapon_name]."))
	else
		basic_mob.visible_message(span_notice("[basic_mob] starts swapping out [basic_mob.p_their()] [magazine_name]."))
	addtimer(CALLBACK(src, PROC_REF(finish_reload), tactical, reload_id), this_reload_time)
	return TRUE

/datum/component/ai_magazine/proc/finish_reload(tactical = FALSE, id)
	if(id != reload_id)
		return // we broke it off to fire
	reloading = FALSE
	shots_left = magazine_size
	topped_off_since = world.time
	if(!single_loads)
		play_if_alive(reload_sound)
	if(chamber_sound && !tactical)
		addtimer(CALLBACK(src, PROC_REF(play_if_alive), chamber_sound), 0.4 SECONDS)
	var/mob/living/basic/basic_mob = parent
	if(basic_mob.stat == DEAD)
		return
	if(!tactical)
		basic_mob.visible_message(span_notice("[basic_mob] finishes reloading."))
	else if(single_loads)
		basic_mob.visible_message(span_notice("[basic_mob] finishes topping off [basic_mob.p_their()] [weapon_name]."))
	else
		basic_mob.visible_message(span_notice("[basic_mob] finishes swapping out [basic_mob.p_their()] [magazine_name]."))

/datum/component/ai_magazine/proc/load_round(rounds_left, id)
	if(id != reload_id)
		return // we broke it off to fire
	play_if_alive(reload_sound)
	shots_left = min(magazine_size, shots_left + 1)
	if(rounds_left > 1)
		addtimer(CALLBACK(src, PROC_REF(load_round), rounds_left - 1, id), single_load_time)

/datum/component/ai_magazine/proc/play_if_alive(sound)
	var/mob/living/basic/basic_mob = parent
	if(basic_mob.stat != DEAD)
		playsound(basic_mob, sound, 50, TRUE)

/datum/component/ai_magazine/proc/set_from_gun(gun_type)
	var/capacity = get_gun_capacity(gun_type)
	if(!capacity)
		return
	magazine_size = capacity
	var/obj/item/gun/gun_path = gun_type
	reload_sound = initial(gun_path.load_sound)
	weapon_name = initial(gun_path.name)
	eject_sound = initial(gun_path.eject_sound)
	eject_empty_sound = eject_sound
	if(ispath(gun_type, /obj/item/gun/energy))
		magazine_name = "cell"
		// energy guns make the same noise taking a cell out as putting one in
		eject_sound = reload_sound
		eject_empty_sound = reload_sound
	if(ispath(gun_type, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/ballistic_path = gun_type
		eject_empty_sound = initial(ballistic_path.eject_empty_sound)
		// whatever a player would do to chamber a round after loading this gun
		var/bolt_type = initial(ballistic_path.bolt_type)
		switch(bolt_type)
			if(BOLT_TYPE_STANDARD, BOLT_TYPE_OPEN)
				chamber_sound = initial(ballistic_path.rack_sound)
			if(BOLT_TYPE_LOCKING, BOLT_TYPE_CLIP)
				chamber_sound = initial(ballistic_path.bolt_drop_sound)
		// pump, lever and bolt actions need racking after every shot
		if(!initial(ballistic_path.semi_auto) && bolt_type != BOLT_TYPE_NO_BOLT)
			cycle_sound = initial(ballistic_path.rack_sound)
		// tube fed shotguns, lever and bolt actions, and revolvers load a round at a time
		if(initial(gun_path.internal_magazine))
			single_loads = TRUE
			reload_time = capacity * single_load_time

/proc/get_gun_capacity(gun_type)
	var/static/list/capacity_by_type = list()
	if(!ispath(gun_type, /obj/item/gun))
		return 0
	if(!isnull(capacity_by_type[gun_type]))
		return capacity_by_type[gun_type]
	var/capacity = 0
	var/obj/item/gun/gun = new gun_type
	if(istype(gun, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/ballistic_gun = gun
		capacity = ballistic_gun.magazine?.max_ammo || 0
	else if(istype(gun, /obj/item/gun/energy))
		var/obj/item/gun/energy/energy_gun = gun
		var/highest_cost = 0
		for(var/obj/item/ammo_casing/energy/shot in energy_gun.ammo_type)
			highest_cost = max(highest_cost, shot.e_cost)
		if(energy_gun.cell && highest_cost)
			capacity = round(energy_gun.cell.maxcharge / highest_cost)
	qdel(gun)
	capacity_by_type[gun_type] = capacity
	return capacity
