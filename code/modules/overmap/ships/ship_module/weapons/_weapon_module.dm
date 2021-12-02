/datum/ship_module/weapon
	abstract = /datum/ship_module/weapon
	slot = SHIP_SLOT_WEAPON
	flags = 0 // Weapons aren't unique unless sub types want them to be
	/// A list of all the damage types this weapon inflicts
	var/list/damage_types = list(DAMAGE_PHYSICAL)
	/// The actual damage the weapon deals
	var/damage = 0
	/// The amount of damage at random that is added/subtracted
	var/damage_variance = 0

/datum/ship_module/weapon/proc/weapon_fire(obj/structure/overmap/ship/simulated/parent, obj/structure/ship_module/weapon/struc, obj/structure/overmap/ship/simulated/target)
	if(!struc.ammo)
		return WEAPON_EMPTY
	if(!struc.obj_integrity)
		return WEAPON_BROKEN
	if(struc.reload_timer_id)
		return WEAPON_RELOADING
	if(!struc.weapon_fire(src, parent, struc, target))
		return WEAPON_FAIL
	if(damage_variance)
		var/variance = rand(-damage_variance, damage_variance)
		damage += variance
	if(damage <= 0)
		return WEAPON_RICHOCHET
	return weapon_hit(parent, struc, target, damage)

/datum/ship_module/weapon/proc/weapon_hit(obj/structure/overmap/ship/simulated/parent, obj/structure/ship_module/weapon/struc, obj/structure/overmap/ship/simulated/target, damage)
	if(target.recieve_damage(damage, parent, damage_types))
		return WEAPON_HIT
	return WEAPON_MISS

/obj/structure/ship_module/weapon
	name = "Default Weapon Module"
	var/ammo = 1
	var/mag_size = 1
	var/reload_eta = FALSE
	var/reload_time = 2 SECONDS
	var/reload_timer_id

/obj/structure/ship_module/weapon/proc/weapon_fire(obj/structure/overmap/ship/simulated/parent, obj/structure/ship_module/weapon/struc, obj/structure/overmap/ship/simulated/target)
	return TRUE

/obj/structure/ship_module/weapon/proc/try_reload()
	if(reload_timer_id)
		return
	if(!reload_start())
		return FALSE
	reload_timer_id = addtimer(CALLBACK(src, .proc/reload_finish), reload_time, TIMER_STOPPABLE|TIMER_OVERRIDE|TIMER_UNIQUE)
	reload_eta = world.time + timeleft(reload_timer_id)
	return TRUE

/obj/structure/ship_module/weapon/proc/reload_start()
	return TRUE

/obj/structure/ship_module/weapon/proc/reload_finish()
	SHOULD_CALL_PARENT(TRUE)
	reload_timer_id = null
	ammo = mag_size
