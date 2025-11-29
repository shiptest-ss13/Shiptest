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
	/// Time to wait between shots
	var/cooldown_time
	/// How much spread does a shot have?
	var/spread = 2
	/// Tracks time between shots
	COOLDOWN_DECLARE(fire_cooldown)

/datum/component/ranged_attacks/Initialize(
	casing_type,
	projectile_type,
	projectile_sound = 'sound/weapons/gun/pistol/shot.ogg',
	burst_shots,
	burst_intervals = 0.2 SECONDS,
	cooldown_time = 3 SECONDS,
	spread = 2
)
	. = ..()
	if(!isbasicmob(parent))
		return COMPONENT_INCOMPATIBLE

	src.casing_type = casing_type
	src.projectile_sound = projectile_sound
	src.projectile_type = projectile_type
	src.cooldown_time = cooldown_time
	src.spread = spread

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
	INVOKE_ASYNC(src, PROC_REF(async_fire_ranged_attack), firer, target, modifiers)


/datum/component/ranged_attacks/proc/async_fire_ranged_attack(mob/living/basic/firer, atom/target, modifiers)
	var/turf/startloc = get_turf(firer)

	if(casing_type)
		var/obj/item/ammo_casing/casing = new casing_type(startloc)
		playsound(firer, projectile_sound, 100, TRUE)
		casing.fire_casing(target, firer, null, null, null, ran_zone(), rand(-spread, spread), firer)
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
		P.preparePixelProjectile(target, firer)
		P.fire()
