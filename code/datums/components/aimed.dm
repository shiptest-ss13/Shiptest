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

	COOLDOWN_DECLARE(next_shot_cd)

/datum/component/aimed_fire/Initialize(_autofire_shot_delay)
	. = ..()
	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE
	var/obj/item/gun = parent
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(wake_up))
	RegisterSignal(parent, COMSIG_GUN_DISABLE_AIMEDFIRE, PROC_REF(disable_aimedfire))
	RegisterSignal(parent, COMSIG_GUN_ENABLE_AIMEDFIRE, PROC_REF(enable_aimedfire))
	RegisterSignal(parent, COMSIG_GUN_SET_AIMEDFIRE_SPEED, PROC_REF(set_aimedfire_speed))
	if(_autofire_shot_delay)
		autofire_shot_delay = _autofire_shot_delay
	if(autofire_stat == AUTOFIRE_STAT_IDLE && ismob(gun.loc))
		var/mob/user = gun.loc
		wake_up(src, user)

/datum/component/aimed_fire/Destroy()
	aimedfire_off()
	return ..()

/datum/component/automatic_fire/process(seconds_per_tick)
	if(autofire_stat != AIMEDFIRE_STAT_FIRING)
		STOP_PROCESSING(SSprojectiles, src)
		return

	process_shot()

/datum/component/aimed_fire/proc/wake_up(datum/source, mob/user, slot)
	SIGNAL_HANDLER

	if(autofire_stat == AIMEDFIRE_STAT_ALERT)
		return //We've updated the firemode. No need for more.
	if(autofire_stat == AIMEDFIRE_STAT_FIRING)
		stop_aimedfiring() //Let's stop shooting to avoid issues.
		return
	if(iscarbon(user))
		var/mob/living/carbon/sniper = user
		if(sniper.is_holding(parent))
			aimedfire_on(sniper.client)

// There is a gun and there is a user wielding it. The component now waits for the mouse click.
/datum/component/aimed_fire/proc/aimedfire_on(client/usercli)
	SIGNAL_HANDLER

	if(autofire_stat != AIMEDFIRE_STAT_IDLE)
		return
	autofire_stat = AIMEDFIRE_STAT_ALERT
	if(!QDELETED(usercli))
		clicker = usercli
		shooter = clicker.mob
		RegisterSignal(clicker, COMSIG_CLIENT_MOUSEDOWN, PROC_REF(on_mouse_down))
	if(!QDELETED(shooter))
		RegisterSignal(shooter, COMSIG_MOB_LOGOUT, PROC_REF(autofire_off))
		UnregisterSignal(shooter, COMSIG_MOB_LOGIN)
	RegisterSignals(parent, list(COMSIG_QDELETING, COMSIG_ITEM_DROPPED), PROC_REF(aimedfire_off))
	parent.RegisterSignal(src, COMSIG_AIMEDFIRE_ONMOUSEDOWN, TYPE_PROC_REF(/obj/item/gun, aimedfire_bypass_check))
	parent.RegisterSignal(parent, COMSIG_AIMEDFIRE_SHOT, TYPE_PROC_REF(/obj/item/gun, do_aimedfire))

/datum/component/automatic_fire/proc/aimedfire_off(datum/source)
	SIGNAL_HANDLER
	if(aimedfire_stat == AIMEDFIRE_STAT_IDLE)
		return
	if(aimedfire_stat == AIMEDFIRE_STAT_FIRING)
		stop_aimedfiring()

	aimedfire_stat = AIMEDFIRE_STAT_IDLE

	if(!QDELETED(clicker))
		UnregisterSignal(clicker, list(COMSIG_CLIENT_MOUSEDOWN, COMSIG_CLIENT_MOUSEUP, COMSIG_CLIENT_MOUSEDRAG))
	mouse_status = AUTOFIRE_MOUSEUP //In regards to the component there's no click anymore to care about.
	clicker = null
	if(!QDELETED(shooter))
		RegisterSignal(shooter, COMSIG_MOB_LOGIN, PROC_REF(on_client_login))
		UnregisterSignal(shooter, COMSIG_MOB_LOGOUT)
	UnregisterSignal(parent, list(COMSIG_QDELETING, COMSIG_ITEM_DROPPED))
	shooter = null
	parent.UnregisterSignal(parent, COMSIG_AIMEDFIRE_SHOT)
	parent.UnregisterSignal(src, COMSIG_AIMEDFIRE_ONMOUSEDOWN)

/datum/component/automatic_fire/proc/on_client_login(mob/source)
	SIGNAL_HANDLER
	if(!source.client)
		return
	if(source.is_holding(parent))
		autofire_on(source.client)
