// Fires the rest of a burst after the first shot
/datum/gun_burst
	var/obj/item/gun/gun
	var/atom/target
	var/mob/living/user
	var/message
	var/params
	var/zone_override
	var/spread_override
	var/next_iteration = 2 // the first shot is fired normally
	var/next_shot_time

/datum/gun_burst/New(obj/item/gun/gun, atom/target, mob/living/user, message, params, zone_override, spread_override)
	src.gun = gun
	src.target = target
	src.user = user
	src.message = message
	src.params = params
	src.zone_override = zone_override
	src.spread_override = spread_override
	next_shot_time = world.time + gun.burst_delay
	START_PROCESSING(SSprojectiles, src)

/datum/gun_burst/Destroy(force)
	STOP_PROCESSING(SSprojectiles, src)
	if(gun)
		gun.currently_firing_burst = FALSE
		if(gun.active_burst == src)
			gun.active_burst = null
	gun = null
	target = null
	user = null
	return ..()

/datum/gun_burst/process(seconds_per_tick)
	if(QDELETED(gun) || !gun.currently_firing_burst)
		qdel(src)
		return
	while(world.time >= next_shot_time)
		var/shot_was_late = (world.time - next_shot_time) >= world.tick_lag
		var/schedule_base = shot_was_late ? world.time : next_shot_time
		gun.process_fire(target, user, message, params, zone_override, 0, TRUE, spread_override, next_iteration)
		next_iteration++
		if(QDELETED(src) || QDELETED(gun) || !gun.currently_firing_burst || next_iteration > gun.burst_size)
			qdel(src)
			return
		next_shot_time = schedule_base + gun.burst_delay
