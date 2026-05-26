#define AIMEDFIRE_MOUSEUP 0
#define AIMEDFIRE_MOUSEDOWN 1

#define AIMING_BEAM_ANGLE_CHANGE_THRESHOLD 0.1

/datum/component/aimed_fire
	var/client/clicker
	var/mob/living/shooter
	var/atom/target
	var/turf/target_loc //For dealing with locking on targets due to BYOND engine limitations (the mouse input only happening when mouse moves).
	var/aimedfire_stat = AIMEDFIRE_STAT_IDLE
	var/mouse_parameters
	var/mouse_status = AIMEDFIRE_MOUSEUP //This seems hacky but there can be two MouseDown() without a MouseUp() in between if the user holds click and uses alt+tab, printscreen or similar.
	var/enabled = TRUE

	var/aiming_time = 12
	var/aiming_time_fire_threshold = 5
	var/aiming_time_left = 12
	var/aiming_time_increase_user_movement = 3
	var/aiming_time_increase_angle_multiplier = 0.3

	var/last_process = 0
	var/lastangle = 0
	var/aiming_lastangle = 0
	var/delay = 25
	var/lastfire = 0
	var/list/obj/effect/projectile/tracer/current_tracers

/datum/component/aimed_fire/Initialize(_aiming_time, _aiming_threshold, _movement_delay, _angle_delay)
	. = ..()
	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE
	var/obj/item/gun = parent
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(wake_up))
	RegisterSignal(parent, COMSIG_GUN_DISABLE_AIMEDFIRE, PROC_REF(disable_aimedfire))
	RegisterSignal(parent, COMSIG_GUN_ENABLE_AIMEDFIRE, PROC_REF(enable_aimedfire))
	if(_aiming_time)
		aiming_time = _aiming_time
	if(_aiming_threshold)
		aiming_time_fire_threshold = _aiming_threshold
	if(_movement_delay)
		aiming_time_increase_user_movement = _movement_delay
	if(_angle_delay)
		aiming_time_increase_angle_multiplier = _angle_delay
	if(aimedfire_stat == AIMEDFIRE_STAT_IDLE && ismob(gun.loc))
		var/mob/user = gun.loc
		wake_up(src, user)

/datum/component/aimed_fire/Destroy()
	aimedfire_off()
	return ..()

/datum/component/aimed_fire/proc/on_mob_move()
	if(aimedfire_stat == AIMEDFIRE_STAT_AIMING)
		delay_penalty(aiming_time_increase_user_movement)
		process_aim()
		aiming_beam(TRUE)

//good
/datum/component/aimed_fire/process(seconds_per_tick)
	if(aimedfire_stat != AIMEDFIRE_STAT_AIMING)
		STOP_PROCESSING(SSprojectiles, src)
		return
	aiming_time_left = max(0, aiming_time_left - (world.time - last_process))
	aiming_beam(TRUE)
	last_process = world.time

/datum/component/aimed_fire/proc/wake_up(datum/source, mob/user, slot)
	SIGNAL_HANDLER

	if(aimedfire_stat == AIMEDFIRE_STAT_ALERT)
		return //We've updated the firemode. No need for more.
	if(aimedfire_stat == AIMEDFIRE_STAT_AIMING)
		stop_aiming() //Let's stop shooting to avoid issues.
		return
	if(iscarbon(user))
		var/mob/living/carbon/sniper = user
		if(sniper.is_holding(parent))
			aimedfire_on(sniper.client)

// There is a gun and there is a user wielding it. The component now waits for the mouse click.
/datum/component/aimed_fire/proc/aimedfire_on(client/usercli)
	SIGNAL_HANDLER

	if(aimedfire_stat != AIMEDFIRE_STAT_IDLE)
		return
	aimedfire_stat = AIMEDFIRE_STAT_ALERT
	if(!QDELETED(usercli))
		clicker = usercli
		shooter = clicker.mob
		RegisterSignal(clicker, COMSIG_CLIENT_MOUSEDOWN, PROC_REF(on_mouse_down))
	if(!QDELETED(shooter))
		RegisterSignal(shooter, COMSIG_MOB_LOGOUT, PROC_REF(aimedfire_off))
		UnregisterSignal(shooter, COMSIG_MOB_LOGIN)
	RegisterSignals(parent, list(COMSIG_QDELETING, COMSIG_ITEM_DROPPED), PROC_REF(aimedfire_off))
	parent.RegisterSignal(src, COMSIG_AIMEDFIRE_ONMOUSEDOWN, TYPE_PROC_REF(/obj/item/gun, aimedfire_bypass_check))
	parent.RegisterSignal(parent, COMSIG_AIMEDFIRE_SHOT, TYPE_PROC_REF(/obj/item/gun, do_aimedfire))

/datum/component/aimed_fire/proc/aimedfire_off(datum/source)
	SIGNAL_HANDLER
	if(aimedfire_stat == AIMEDFIRE_STAT_IDLE)
		return
	if(aimedfire_stat == AIMEDFIRE_STAT_AIMING)
		stop_aiming()

	aimedfire_stat = AIMEDFIRE_STAT_IDLE

	if(!QDELETED(clicker))
		UnregisterSignal(clicker, list(COMSIG_CLIENT_MOUSEDOWN, COMSIG_CLIENT_MOUSEUP, COMSIG_CLIENT_MOUSEDRAG))
	mouse_status = AIMEDFIRE_MOUSEUP //In regards to the component there's no click anymore to care about.
	clicker = null
	if(!QDELETED(shooter))
		RegisterSignal(shooter, COMSIG_MOB_LOGIN, PROC_REF(on_client_login))
		UnregisterSignal(shooter, COMSIG_MOB_LOGOUT)
	UnregisterSignal(parent, list(COMSIG_QDELETING, COMSIG_ITEM_DROPPED))
	shooter = null
	parent.UnregisterSignal(parent, COMSIG_AIMEDFIRE_SHOT)
	parent.UnregisterSignal(src, COMSIG_AIMEDFIRE_ONMOUSEDOWN)

/datum/component/aimed_fire/proc/on_client_login(mob/source)
	SIGNAL_HANDLER
	if(!source.client)
		return
	if(source.is_holding(parent))
		aimedfire_on(source.client)

/datum/component/aimed_fire/proc/on_mouse_down(client/source, atom/_target, turf/location, control, params)
	SIGNAL_HANDLER
	var/list/modifiers = params2list(params) //If they're shift+clicking, for example, let's not have them accidentally shoot.

	if(!enabled)
		return
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		return
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		return
	if(LAZYACCESS(modifiers, ALT_CLICK))
		return
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	if(source.mob.throw_mode)
		return
	if(!isturf(source.mob.loc)) //No firing inside lockers and stuff.
		return
	if(get_dist(source.mob, _target) < 2) //Adjacent clicking.
		return

	if(isnull(location)) //Clicking on a screen object.
		if(_target.plane != CLICKCATCHER_PLANE) //The clickcatcher is a special case. We want the click to trigger then, under it.
			return //If we click and drag on our worn backpack, for example, we want it to open instead.
		_target = parse_caught_click_modifiers(modifiers, get_turf(source.eye), source)
		params = list2params(modifiers)
		if(!_target)
			CRASH("Failed to get the turf under clickcatcher")

	if(SEND_SIGNAL(src, COMSIG_AIMEDFIRE_ONMOUSEDOWN, source, _target, location, control, params) & COMPONENT_AIMEDFIRE_ONMOUSEDOWN_BYPASS)
		return

	source.click_intercept_time = world.time //From this point onwards Click() will no longer be triggered.

	if(aimedfire_stat == (AIMEDFIRE_STAT_IDLE))
		CRASH("on_mouse_down() called with [aimedfire_stat] aimedfire_stat")
	if(aimedfire_stat == AIMEDFIRE_STAT_AIMING)
		stop_aiming() //This can happen if we click and hold and then alt+tab, printscreen or other such action. MouseUp won't be called then and it will keep aimedfiring.

	target = _target
	target_loc = get_turf(target)
	mouse_parameters = params
	INVOKE_ASYNC(src, PROC_REF(start_aiming))

//Dakka-dakka
/datum/component/aimed_fire/proc/start_aiming()
	if(aimedfire_stat == AIMEDFIRE_STAT_AIMING)
		return //Already aiming.
	aimedfire_stat = AIMEDFIRE_STAT_AIMING

	clicker.mouse_override_icon = 'icons/effects/mouse_pointers/weapon_pointer.dmi'
	clicker.mouse_pointer_icon = clicker.mouse_override_icon

	if(mouse_status == AIMEDFIRE_MOUSEUP) //See mouse_status definition for the reason for this.
		RegisterSignal(clicker, COMSIG_CLIENT_MOUSEUP, PROC_REF(on_mouse_up))
		mouse_status = AIMEDFIRE_MOUSEDOWN

	RegisterSignal(shooter, COMSIG_MOB_SWAP_HANDS, PROC_REF(stop_aiming))
	RegisterSignal(shooter, COMSIG_MOVABLE_MOVED, PROC_REF(on_mob_move))
	RegisterSignal(parent, COMSIG_CLICK_UNIQUE_ACTION, PROC_REF(cancel_shot))

	if(isgun(parent))
		var/obj/item/gun/shoota = parent
		if(!shoota.on_aimedfire_start(shooter=shooter)) //This is needed because the minigun has a do_after before firing and signals are async.
			stop_aiming()
			return
	if(aimedfire_stat != AIMEDFIRE_STAT_AIMING)
		return //Things may have changed while on_aimedfire_start() was being processed, due to do_after's sleep.

	aiming_time_left = aiming_time
	last_process = world.time
	var/angle = get_angle(shooter,target)
	START_PROCESSING(SSprojectiles, src)
	aiming_beam(TRUE, angle)
	RegisterSignal(clicker, COMSIG_CLIENT_MOUSEDRAG, PROC_REF(on_mouse_drag))

/datum/component/aimed_fire/proc/cancel_shot()
	stop_aiming()
	return OVERRIDE_UNIQUE_ACTION

/datum/component/aimed_fire/proc/on_mouse_up(datum/source, atom/object, turf/location, control, params, shot_canceled = FALSE)
	SIGNAL_HANDLER
	UnregisterSignal(clicker, COMSIG_CLIENT_MOUSEUP)
	mouse_status = AIMEDFIRE_MOUSEUP
	process_aim()
	if(aiming_time_left <= aiming_time_fire_threshold && !shot_canceled)
		to_chat(shooter,"aiming time left = [aiming_time_left] / threshold = [aiming_time_fire_threshold]")
		process_shot()
	to_chat(shooter,"second check, aiming time left = [aiming_time_left] / threshold = [aiming_time_fire_threshold]")
	if(aimedfire_stat == AIMEDFIRE_STAT_AIMING)
		stop_aiming()
	return COMPONENT_CLIENT_MOUSEUP_INTERCEPT

/datum/component/aimed_fire/proc/stop_aiming(datum/source, atom/object, turf/location, control, params)
	SIGNAL_HANDLER
	if(aimedfire_stat != AIMEDFIRE_STAT_AIMING)
		return
	STOP_PROCESSING(SSprojectiles, src)
	aimedfire_stat = AIMEDFIRE_STAT_ALERT
	if(clicker)
		clicker.mouse_override_icon = null
		clicker.mouse_pointer_icon = clicker.mouse_override_icon
		UnregisterSignal(clicker, COMSIG_CLIENT_MOUSEDRAG)
	if(!QDELETED(shooter))
		UnregisterSignal(shooter, COMSIG_MOB_SWAP_HANDS)
		UnregisterSignal(shooter, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(parent, COMSIG_CLICK_UNIQUE_ACTION)
	QDEL_LIST(current_tracers)
	aiming_time_left = aiming_time
	target = null
	target_loc = null
	mouse_parameters = null

/datum/component/aimed_fire/proc/on_mouse_drag(client/source, atom/src_object, atom/over_object, turf/src_location, turf/over_location, src_control, over_control, params)
	SIGNAL_HANDLER
	if(isnull(over_location)) //This happens when the mouse is over an inventory or screen object, or on entering deep darkness, for example.
		var/list/modifiers = params2list(params)
		var/new_target = parse_caught_click_modifiers(modifiers, get_turf(source.eye), source)
		params = list2params(modifiers)
		mouse_parameters = params
		if(!new_target)
			if(QDELETED(target)) //No new target acquired, and old one was deleted, get us out of here.
				stop_aiming()
				CRASH("on_mouse_drag failed to get the turf under screen object [over_object.type]. Old target was incidentally QDELETED.")
			target = get_turf(target) //If previous target wasn't a turf, let's turn it into one to avoid locking onto a potentially moving target.
			target_loc = target
			CRASH("on_mouse_drag failed to get the turf under screen object [over_object.type]")
		target = new_target
		target_loc = new_target
		process_aim(new_target)
		return
	target = over_object
	target_loc = get_turf(over_object)
	process_aim(target)
	mouse_parameters = params

/datum/component/aimed_fire/proc/process_aim(target)
	if(istype(shooter) && shooter.client && shooter.client.mouseParams)
		var/angle
		if(target)
			angle = get_angle(shooter,target)
		else
			angle = mouse_angle_from_client(shooter.client)
		shooter.setDir(angle2dir_cardinal(angle))
		var/difference = abs(closer_angle_difference(lastangle, angle))
		delay_penalty(difference * aiming_time_increase_angle_multiplier)
		lastangle = angle

/datum/component/aimed_fire/proc/delay_penalty(amount)
	aiming_time_left = clamp(aiming_time_left + amount, 0, aiming_time)

//proccess the aim here
/datum/component/aimed_fire/proc/process_shot()
	if(aimedfire_stat != AIMEDFIRE_STAT_AIMING)
		return FALSE
	if(QDELETED(target) || get_turf(target) != target_loc) //Target moved or got destroyed since we last aimed.
		target = target_loc //So we keep firing on the emptied tile until we move our mouse and find a new target.
	if(get_dist(shooter, target) <= 0)
		target = get_step(shooter, shooter.dir) //Shoot in the direction faced if the mouse is on the same tile as we are.
		target_loc = target
	else if(!in_view_range(shooter, target))
		stop_aiming() //Elvis has left the building.
		return FALSE
	shooter.face_atom(target)
	if(SEND_SIGNAL(parent, COMSIG_AIMEDFIRE_SHOT, target, shooter, mouse_parameters) & COMPONENT_AIMEDFIRE_SHOT_SUCCESS)
		return TRUE
	// process_aim(target)
	// return TRUE
	stop_aiming()
	return FALSE

/datum/component/aimed_fire/proc/aiming_beam(force_update = FALSE, new_angle)
	if(new_angle)
		lastangle = new_angle
	var/diff = abs(aiming_lastangle - lastangle)
	if(diff < AIMING_BEAM_ANGLE_CHANGE_THRESHOLD && !force_update)
		return
	aiming_lastangle = lastangle
	var/obj/projectile/beam/hitscan/aiming/P = new
	if(aiming_time)
		var/percent = ((100/aiming_time)*max((aiming_time_left-aiming_time_fire_threshold),0))
		P.color = rgb(255 * percent,255 * ((100 - percent) / 100),0)
	else
		P.color = rgb(0, 255, 0)
	var/turf/curloc = get_turf(parent)
	var/turf/targloc = get_turf(shooter.client.mouseObject)
	if(!istype(targloc))
		if(!istype(curloc))
			return
		targloc = get_turf_in_angle(lastangle, curloc, 10)
	var/mouse_modifiers = params2list(shooter.client.mouseParams)
	P.preparePixelProjectile(targloc, shooter, mouse_modifiers, 0)
	P.fire(lastangle)

/obj/projectile/beam/hitscan/aiming
	tracer_type = /obj/effect/projectile/tracer/tracer/aiming
	name = "aiming beam"
	icon = ""
	hitsound = null
	hitsound_non_living = null
	nodamage = TRUE
	damage = 0
	hitscan_light_range = 0
	hitscan_light_intensity = 0
	hitscan_light_color_override = "#99ff99"
	reflectable = REFLECT_FAKEPROJECTILE
	near_miss_sound = null
	ricochet_sound = null
	range = 50

	muzzle_type = null
	impact_type = null

/obj/projectile/beam/beam_rifle/hitscan/aiming_beam/prehit_pierce(atom/target)
	return PROJECTILE_DELETE_WITHOUT_HITTING

/obj/projectile/beam/beam_rifle/hitscan/aiming_beam/on_hit()
	qdel(src)
	return BULLET_ACT_BLOCK

// Gun procs.

/obj/item/gun/proc/on_aimedfire_start(datum/source, atom/target, mob/living/shooter, params)
	if(current_cooldown || shooter.stat)
		return FALSE
	if(!can_shoot()) //we call pre_fire so bolts/slides work correctly
		INVOKE_ASYNC(src, PROC_REF(do_aimedfire_shot), source, target, shooter, params)
		return NONE
	if(weapon_weight == WEAPON_HEAVY && (!wielded))
		to_chat(shooter, span_warning("You need a more secure grip to fire [src]!"))
		return FALSE
	return TRUE


/obj/item/gun/proc/aimedfire_bypass_check(datum/source, client/clicker, atom/target, turf/location, control, params)
	SIGNAL_HANDLER
	if(clicker.mob.get_active_held_item() != src)
		return COMPONENT_AIMEDFIRE_ONMOUSEDOWN_BYPASS


/obj/item/gun/proc/do_aimedfire(datum/source, atom/target, mob/living/shooter, params)
	SIGNAL_HANDLER
	if(current_cooldown || shooter.incapacitated())
		return NONE
	if(weapon_weight == WEAPON_HEAVY && (!wielded))
		to_chat(shooter, span_warning("You need a more secure grip to fire [src]!"))
		return NONE
	if(!can_shoot()) //we stop if we cant shoot but also calling pre_fire so the bolt works correctly if it's a weird open bolt weapon.
		INVOKE_ASYNC(src, PROC_REF(do_aimedfire_shot), source, target, shooter, params)
		return NONE
	INVOKE_ASYNC(src, PROC_REF(do_aimedfire_shot), source, target, shooter, params)
	return COMPONENT_AIMEDFIRE_SHOT_SUCCESS //All is well, we can continue shooting.


/obj/item/gun/proc/do_aimedfire_shot(datum/source, atom/target, mob/living/shooter, params)
	pre_fire(target, shooter, TRUE, FALSE, params) //dual wielding is handled here

/datum/component/aimed_fire/proc/disable_aimedfire(datum/source)
	enabled = FALSE

/datum/component/aimed_fire/proc/enable_aimedfire(datum/source)
	enabled = TRUE

#undef AIMEDFIRE_MOUSEUP
#undef AIMEDFIRE_MOUSEDOWN

