#define AIMEDFIRE_MOUSEUP 0
#define AIMEDFIRE_MOUSEDOWN 1

/datum/component/aimed_fire
	var/client/clicker
	var/mob/living/shooter
	var/atom/target
	var/turf/target_loc //For dealing with locking on targets due to BYOND engine limitations (the mouse input only happening when mouse moves).
	var/aimedfire_stat = AIMEDFIRE_STAT_IDLE
	var/mouse_parameters
	var/aimedfire_shot_delay = 0.1 SECONDS //Time between individual shots.
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

	COOLDOWN_DECLARE(next_shot_cd)

/datum/component/aimed_fire/Initialize(_aiming_time, _aiming_threshold, _movement_delay, _angle_delay)
	. = ..()
	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE
	var/obj/item/gun = parent
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(wake_up))
	RegisterSignal(parent, COMSIG_GUN_DISABLE_AIMEDFIRE, PROC_REF(disable_aimedfire))
	RegisterSignal(parent, COMSIG_GUN_ENABLE_AIMEDFIRE, PROC_REF(enable_aimedfire))
	//RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_mob_move))
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
	//setuser(null)
	return ..()

//good
/datum/component/aimed_fire/process(seconds_per_tick)
	if(aimedfire_stat != AIMEDFIRE_STAT_FIRING)
		STOP_PROCESSING(SSprojectiles, src)
		return
		// last_process = world.time
		// return
	check_user()
	aiming_time_left = max(0, aiming_time_left - (world.time - last_process))
	//aiming_beam(TRUE)
	last_process = world.time

	// process_shot()

/datum/component/aimed_fire/proc/check_user(automatic_cleanup = TRUE)
	if(!istype(shooter) || !isturf(shooter.loc) || !(src in shooter.held_items) || shooter.incapacitated())	//Doesn't work if you're not holding it!
		//if(automatic_cleanup)
			//stop_aiming()
			//set_user(null)
		return FALSE
	return TRUE

// /obj/item/gun/proc/start_aiming(target)
// 	aiming_time_left = aiming_time
	//aiming = TRUE
	// process_aim(target)
	//aiming_beam(TRUE)

// /obj/item/gun/proc/stop_aiming(mob/user)
// 	set waitfor = FALSE
// 	aiming_time_left = aiming_time
	//aiming = FALSE
	//QDEL_LIST(current_tracers)

/datum/component/aimed_fire/proc/wake_up(datum/source, mob/user, slot)
	SIGNAL_HANDLER

	if(aimedfire_stat == AIMEDFIRE_STAT_ALERT)
		return //We've updated the firemode. No need for more.
	if(aimedfire_stat == AIMEDFIRE_STAT_FIRING)
		stop_aimedfiring() //Let's stop shooting to avoid issues.
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
	if(aimedfire_stat == AIMEDFIRE_STAT_FIRING)
		stop_aimedfiring()

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
	if(aimedfire_stat == AIMEDFIRE_STAT_FIRING)
		stop_aimedfiring() //This can happen if we click and hold and then alt+tab, printscreen or other such action. MouseUp won't be called then and it will keep aimedfiring.

	target = _target
	target_loc = get_turf(target)
	mouse_parameters = params
	INVOKE_ASYNC(src, PROC_REF(start_aiming))

//Dakka-dakka
/datum/component/aimed_fire/proc/start_aiming()
	if(aimedfire_stat == AIMEDFIRE_STAT_FIRING)
		return //Already aiming.
	aimedfire_stat = AIMEDFIRE_STAT_FIRING

	clicker.mouse_override_icon = 'icons/effects/mouse_pointers/weapon_pointer.dmi'
	clicker.mouse_pointer_icon = clicker.mouse_override_icon

	if(mouse_status == AIMEDFIRE_MOUSEUP) //See mouse_status definition for the reason for this.
		RegisterSignal(clicker, COMSIG_CLIENT_MOUSEUP, PROC_REF(on_mouse_up))
		mouse_status = AIMEDFIRE_MOUSEDOWN

	RegisterSignal(shooter, COMSIG_MOB_SWAP_HANDS, PROC_REF(stop_aimedfiring))

	if(isgun(parent))
		var/obj/item/gun/shoota = parent
		if(!shoota.on_aimedfire_start(shooter=shooter)) //This is needed because the minigun has a do_after before firing and signals are async.
			stop_aimedfiring()
			return
	if(aimedfire_stat != AIMEDFIRE_STAT_FIRING)
		return //Things may have changed while on_aimedfire_start() was being processed, due to do_after's sleep.

	// if(!process_shot()) //First shot is processed instantly.
	// 	return //If it fails, such as when the gun is empty, then there's no need to schedule a second shot.

	last_process = world.time
	START_PROCESSING(SSprojectiles, src)
	//declare last time here?
	RegisterSignal(clicker, COMSIG_CLIENT_MOUSEDRAG, PROC_REF(on_mouse_drag))

/datum/component/aimed_fire/proc/on_mouse_up(datum/source, atom/object, turf/location, control, params)
	SIGNAL_HANDLER
	UnregisterSignal(clicker, COMSIG_CLIENT_MOUSEUP)
	mouse_status = AIMEDFIRE_MOUSEUP
	process_aim()
	if(aiming_time_left <= aiming_time_fire_threshold)
		process_shot()
	if(aimedfire_stat == AIMEDFIRE_STAT_FIRING)
		stop_aimedfiring()
	return COMPONENT_CLIENT_MOUSEUP_INTERCEPT

/datum/component/aimed_fire/proc/stop_aimedfiring(datum/source, atom/object, turf/location, control, params)
	SIGNAL_HANDLER
	if(aimedfire_stat != AIMEDFIRE_STAT_FIRING)
		return
	STOP_PROCESSING(SSprojectiles, src)
	aimedfire_stat = AIMEDFIRE_STAT_ALERT
	if(clicker)
		clicker.mouse_override_icon = null
		clicker.mouse_pointer_icon = clicker.mouse_override_icon
		UnregisterSignal(clicker, COMSIG_CLIENT_MOUSEDRAG)
	if(!QDELETED(shooter))
		UnregisterSignal(shooter, COMSIG_MOB_SWAP_HANDS)
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
				stop_aimedfiring()
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
	if(aimedfire_stat != AIMEDFIRE_STAT_FIRING)
		return FALSE
	if(!COOLDOWN_FINISHED(src, next_shot_cd))
		return TRUE
	if(QDELETED(target) || get_turf(target) != target_loc) //Target moved or got destroyed since we last aimed.
		target = target_loc //So we keep firing on the emptied tile until we move our mouse and find a new target.
	if(get_dist(shooter, target) <= 0)
		target = get_step(shooter, shooter.dir) //Shoot in the direction faced if the mouse is on the same tile as we are.
		target_loc = target
	else if(!in_view_range(shooter, target))
		stop_aimedfiring() //Elvis has left the building.
		return FALSE
	shooter.face_atom(target)
	if(SEND_SIGNAL(parent, COMSIG_AIMEDFIRE_SHOT, target, shooter, mouse_parameters) & COMPONENT_AIMEDFIRE_SHOT_SUCCESS)
		return TRUE
	// process_aim(target)
	// return TRUE
	stop_aimedfiring()
	return FALSE

// /obj/item/gun/proc/aiming_beam(force_update = FALSE, new_angle)
// 	var/diff = abs(aiming_lastangle - lastangle)
// 	if(!check_user())
// 		return
// 	if(diff < AIMING_BEAM_ANGLE_CHANGE_THRESHOLD && !force_update)
// 		return
// 	aiming_lastangle = lastangle
// 	var/obj/projectile/beam/beam_rifle/hitscan/aiming_beam/P = new
// 	P.gun = src
// 	if(aiming_time)
// 		var/percent = ((100/aiming_time)*aiming_time_left)
// 		P.color = rgb(255 * percent,255 * ((100 - percent) / 100),0)
// 	else
// 		P.color = rgb(0, 255, 0)
// 	var/turf/curloc = get_turf(src)
// 	var/turf/targloc = get_turf(current_user.client.mouseObject)
// 	if(!istype(targloc))
// 		if(!istype(curloc))
// 			return
// 		targloc = get_turf_in_angle(lastangle, curloc, 10)
// 	var/mouse_modifiers = params2list(current_user.client.mouseParams)
// 	P.preparePixelProjectile(targloc, current_user, mouse_modifiers, 0)
// 	P.fire(lastangle)

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

