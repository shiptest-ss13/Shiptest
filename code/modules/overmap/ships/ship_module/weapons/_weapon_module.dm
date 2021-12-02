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
	if(QDELETED(struc.loaded))
		return WEAPON_EMPTY
	if(!struc.obj_integrity)
		return WEAPON_BROKEN
	if(struc.reload_timer_id)
		return WEAPON_RELOADING
	if(!struc.weapon_fire(parent, struc, target))
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
	/// Currently loaded shell
	var/atom/movable/loaded
	/// Maximum ammo that can be chambered into the magazine
	var/mag_size = 1
	/// The expected world.time of reload finish
	var/reload_eta = FALSE
	/// How long does a reload take
	var/reload_time = 2 SECONDS
	/// timer ID for our reload
	var/reload_timer_id
	/// The actual ammo this weapon uses to fire
	var/ammo_type = /obj/item/ammo_casing/magic/fireball

/obj/structure/ship_module/weapon/attackby(obj/item/hitby, mob/living/user, params)
	if(!istype(hitby, ammo_type))
		return ..()
	. = TRUE
	if(length(contents) >= mag_size)
		to_chat(user, "<span class='notice'>You cannot fit [hitby] into [src].</span>")
	else
		to_chat(user, "<span class='notice'>You insert [hitby] into [src].</span>")
		hitby.forceMove(src)

/obj/structure/ship_module/weapon/proc/check_ammo()
	return istype(loaded, ammo_type)

/obj/structure/ship_module/weapon/proc/check_loaded()
	return !QDELETED(loaded)

/obj/structure/ship_module/weapon/proc/weapon_fire(obj/structure/overmap/ship/simulated/parent, obj/structure/ship_module/weapon/struc, obj/structure/overmap/ship/simulated/target)
	explosion(src, 0, 0, 0, 3)
	. = check_ammo()
	QDEL_NULL(loaded)

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
	if(!QDELETED(loaded))
		loaded.forceMove(loc)
	for(var/ammo in contents)
		loaded = ammo
		return
