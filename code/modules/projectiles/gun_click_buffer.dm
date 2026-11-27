// Holds a click that lands within the buffer window and replays it when ready, instead of dropping it
/obj/item/gun/proc/try_buffer_click(mob/living/user, atom/target, params, list/modifiers)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return FALSE
	if(currently_firing_burst || user.throw_mode || !isturf(user.loc))
		return FALSE
	if(get_dist(user, target) <= 1 && !is_point_blank_shot(user, target)) // ignore adjacent clicks, might be melee
		return FALSE
	var/ready_time = max(user.next_move, fire_cooldown_end)
	if(world.time >= ready_time || ready_time - world.time > GUN_CLICK_BUFFER_WINDOW)
		return FALSE
	if(buffered_click)
		buffered_click.target = target
		buffered_click.params = params
	else
		buffered_click = new(src, user, target, params)
	return TRUE

/obj/item/gun/proc/is_point_blank_shot(mob/living/user, atom/target)
	if(!ismob(target) || target == user)
		return FALSE
	if(user.a_intent == INTENT_DISARM || user.a_intent == INTENT_GRAB)
		return FALSE
	return user.zone_selected != BODY_ZONE_PRECISE_MOUTH

/datum/buffered_gun_click
	var/obj/item/gun/gun
	var/mob/living/user
	var/atom/target
	var/params
	var/expire_time

/datum/buffered_gun_click/New(obj/item/gun/gun, mob/living/user, atom/target, params)
	src.gun = gun
	src.user = user
	src.target = target
	src.params = params
	expire_time = world.time + GUN_CLICK_BUFFER_WINDOW + world.tick_lag
	START_PROCESSING(SSprojectiles, src)

/datum/buffered_gun_click/Destroy(force)
	STOP_PROCESSING(SSprojectiles, src)
	if(gun?.buffered_click == src)
		gun.buffered_click = null
	gun = null
	user = null
	target = null
	return ..()

/datum/buffered_gun_click/process(seconds_per_tick)
	if(QDELETED(gun) || QDELETED(user) || QDELETED(target) || user.get_active_held_item() != gun)
		qdel(src)
		return
	if(world.time <= user.next_click || world.time < max(user.next_move, gun.fire_cooldown_end))
		if(world.time > expire_time)
			qdel(src)
		return
	if(get_dist(user, target) <= 1 && !gun.is_point_blank_shot(user, target)) // intent changed while waiting
		qdel(src)
		return
	var/mob/living/clicker = user
	var/atom/click_target = target
	var/click_params = params
	qdel(src)
	clicker.ClickOn(click_target, click_params)
