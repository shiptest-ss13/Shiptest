/**
 * Configurable ranged attack for basic mobs.
 */
/datum/component/ranged_attacks
	/// What kind of casing do we use to fire?
	var/casing_type
	/// What kind of projectile to we fire? Use only one of this or casing_type
	var/projectile_type
	/// Sound to play when we fire our projectile
	var/projectile_sound
	/// how many shots we will fire
	var/burst_shots
	/// intervals between shots
	var/burst_intervals
	/// Time to wait between volleys, enforced by the AI firing them, see /datum/ai_behavior/basic_ranged_attack. Null leaves it to the AI's own cooldown
	var/cooldown_time
	/// How much spread does a shot have?
	var/spread = 2
	/// How far our attack actually reaches, for things like flamethrowers. Null for as far as our AI would shoot
	var/effective_range
	/// If FALSE, we don't fire a casing or projectile, like a flamethrower, so neither need setting
	var/needs_ammo = TRUE
	/// Tracks time between shots
	COOLDOWN_DECLARE(fire_cooldown)
	/// With a player at the controls, how many more shots of their current burst are still to come, which the cooldown lets through
	var/player_follow_ups_owed = 0
	/// Extra spread on the AI's first volley at someone, before it's settled its aim
	var/first_contact_spread = 0
	/// Until when our shots get first_contact_spread, for the rest of that first volley
	var/unsettled_until = 0

/datum/component/ranged_attacks/Initialize(
	casing_type,
	projectile_type,
	projectile_sound = 'sound/weapons/gun/pistol/shot.ogg',
	burst_shots,
	burst_intervals = 0.2 SECONDS,
	cooldown_time,
	spread = 2,
	first_contact_spread = 0
)
	. = ..()
	if(!isbasicmob(parent))
		return COMPONENT_INCOMPATIBLE

	src.casing_type = casing_type
	src.projectile_sound = projectile_sound
	src.projectile_type = projectile_type
	src.cooldown_time = cooldown_time
	src.spread = spread
	src.first_contact_spread = first_contact_spread

	if(!needs_ammo)
		return
	if (casing_type && projectile_type)
		CRASH("Set both casing type and projectile type in [parent]'s ranged attacks component! uhoh! stinky!")
	if (!casing_type && !projectile_type)
		CRASH("Set neither casing type nor projectile type in [parent]'s ranged attacks component! What are they supposed to be attacking with, air?")
	if(burst_shots <= 1)
		return
	src.burst_shots = burst_shots
	src.burst_intervals = burst_intervals

/datum/component/ranged_attacks/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOB_ATTACK_RANGED, PROC_REF(fire_ranged_attack))

/datum/component/ranged_attacks/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_MOB_ATTACK_RANGED)

/datum/component/ranged_attacks/proc/fire_ranged_attack(mob/living/basic/firer, atom/target, modifiers)
	SIGNAL_HANDLER
	if(firer.client && !try_player_volley(firer, target))
		return // the AI paces its own volleys, but a player could otherwise fire as fast as they click
	if(SEND_SIGNAL(firer, COMSIG_BASICMOB_PRE_RANGED_ATTACK, target) & COMPONENT_CANCEL_RANGED_ATTACK)
		return // like when we're reloading
	var/datum/ai_controller/controller = firer.ai_controller
	controller?.set_blackboard_key(BB_BASIC_MOB_SHOTS_FIRED, controller.blackboard[BB_BASIC_MOB_SHOTS_FIRED] + 1)
	controller?.set_blackboard_key(BB_BASIC_MOB_LAST_FIRED_AT, target)
	controller?.set_blackboard_key(BB_BASIC_MOB_LAST_FIRED_TIME, world.time)
	var/shot_spread = spread + (!firer.client && world.time <= unsettled_until ? first_contact_spread : 0)
	INVOKE_ASYNC(src, PROC_REF(async_fire_ranged_attack), firer, target, modifiers, shot_spread)


/datum/component/ranged_attacks/proc/async_fire_ranged_attack(mob/living/basic/firer, atom/target, modifiers, shot_spread = spread)
	var/turf/startloc = get_turf(firer)
	firer.face_atom(target) // turn to whatever we're shooting at, rather than wherever we happened to be facing

	if(casing_type)
		var/obj/item/ammo_casing/casing = new casing_type(startloc)
		playsound(firer, projectile_sound, 100, TRUE)
		casing.fire_casing(target, firer, null, null, null, null, rand(-shot_spread, shot_spread), firer)
		casing.on_eject(firer)

	else if(projectile_type)
		var/obj/projectile/P = new projectile_type(startloc)
		playsound(firer, projectile_sound, 100, TRUE)
		P.starting = startloc
		P.firer = firer
		P.fired_from = firer
		P.yo = target.y - startloc.y
		P.xo = target.x - startloc.x
		P.original = target
		P.preparePixelProjectile(target, firer, spread = rand(-shot_spread, shot_spread))
		P.fire()
		alert_ai_to_gunfire(firer, SUPPRESSED_NONE, FALSE, firer) // casings do this themselves

// player controlled nonsense
/datum/component/ranged_attacks/proc/try_player_volley(mob/living/basic/firer, atom/target)
	if(player_follow_ups_owed > 0)
		player_follow_ups_owed--
		return TRUE
	if(!COOLDOWN_FINISHED(src, fire_cooldown))
		return FALSE
	COOLDOWN_START(src, fire_cooldown, cooldown_time || 1 SECONDS)
	var/extra_shots = (get_burst_shots() || 1) - 1
	if(extra_shots > 0)
		player_follow_ups_owed = extra_shots
		schedule_follow_ups(target, extra_shots, burst_intervals)
	return TRUE

/datum/component/ranged_attacks/proc/get_projectile_type()
	if(projectile_type)
		return projectile_type
	var/obj/item/ammo_casing/casing = casing_type
	return initial(casing.projectile_type)

// how many shots each volley fires, or null if the AI firing them should decide
/datum/component/ranged_attacks/proc/get_burst_shots()
	return burst_shots

/datum/component/ranged_attacks/proc/ready_to_fire()
	return !cooldown_time || COOLDOWN_FINISHED(src, fire_cooldown)

// start fire a volley or burst of shots
/datum/component/ranged_attacks/proc/fire_volley(atom/target, shots = 1, interval = 0.2 SECONDS)
	var/mob/living/basic/firer = parent
	var/volley_shots = get_burst_shots() || shots
	var/volley_interval = burst_shots ? burst_intervals : interval
	var/datum/ai_controller/controller = firer.ai_controller
	if(first_contact_spread && controller && (controller.blackboard[BB_BASIC_MOB_LAST_FIRED_AT] != target || world.time - controller.blackboard[BB_BASIC_MOB_LAST_FIRED_TIME] > AI_AIM_SETTLED_MEMORY))
		unsettled_until = world.time + (volley_shots - 1) * volley_interval // for the duration of this volley minus the first
	firer.RangedAttack(target)
	schedule_follow_ups(target, volley_shots - 1, volley_interval)

// the rest of a volley after its first shot, one every interval, at where target was now if they're gone by then
/datum/component/ranged_attacks/proc/schedule_follow_ups(atom/target, count, interval)
	var/turf/fallback_turf = get_turf(target)
	for(var/shot in 1 to count)
		addtimer(CALLBACK(src, PROC_REF(fire_follow_up_shot), WEAKREF(target), fallback_turf), shot * interval)

// one of the follow-up shots of a volley after its started
/datum/component/ranged_attacks/proc/fire_follow_up_shot(datum/weakref/target_ref, turf/fallback_turf)
	var/mob/living/basic/firer = parent
	if(QDELETED(firer) || firer.stat == DEAD || firer.incapacitated())
		if(player_follow_ups_owed > 0)
			player_follow_ups_owed-- // still gone, so a player doesn't get it as a free shot later
		return
	var/atom/target = target_ref?.resolve()
	if(!firer.client && target && !has_clear_shot(firer, target))
		return // no more clear shot so stop shooting
	firer.RangedAttack(target || fallback_turf)

/datum/component/ranged_attacks/proc/try_start_volley(blind_fire = FALSE)
	if(!cooldown_time)
		return TRUE
	if(!COOLDOWN_FINISHED(src, fire_cooldown))
		return FALSE
	if(!blind_fire)
		COOLDOWN_START(src, fire_cooldown, cooldown_time)
	return TRUE

// what our shots get through, like glass for lasers, for AI working out if it's got a clear shot
/datum/component/ranged_attacks/proc/get_pass_flags()
	var/obj/projectile/fired_type = get_projectile_type()
	return fired_type ? initial(fired_type.pass_flags) : PASSTABLE

/datum/component/ranged_attacks/flamethrower
	needs_ammo = FALSE
	effective_range = 4

/datum/component/ranged_attacks/flamethrower/async_fire_ranged_attack(mob/living/basic/firer, atom/target, modifiers)
	var/turf/flame_end = get_ranged_target_turf_direct(firer, target, effective_range)
	var/list/burn_turfs = get_line(firer, flame_end) - get_turf(firer)
	firer.visible_message(span_danger("<b>[firer]</b> sprays fire at [target]!"))
	playsound(firer, projectile_sound, 100, TRUE)
	spray_fire_line(firer, burn_turfs, "flamethrower", TRUE, 10)
