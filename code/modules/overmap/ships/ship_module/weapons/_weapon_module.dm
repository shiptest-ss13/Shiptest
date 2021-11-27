/datum/ship_module/weapon
	abstract = /datum/ship_module/weapon
	slot = SHIP_SLOT_WEAPON
	flags = 0 // Weapons aren't unique unless sub types want them to be
	/// A list of all the damage types this weapon inflicts
	var/list/damage_types = list(DAMAGE_PHYSICAL)
	/// The actual damage the weapon deals
	var/damage = 0

/datum/ship_module/weapon/proc/weapon_fire(obj/structure/overmap/ship/simulated/parent, obj/structure/overmap/ship/simulated/target, obj/structure/ship_module/weapon/module)
	var/obj/structure/ship_module/weapon/struc = installed_on[parent]
	if(!struc.ammo)
		return WEAPON_EMPTY
	if(!struc.obj_integrity)
		return WEAPON_BROKEN
	if(struc.reloading)
		return WEAPON_RELOADING
	return weapon_hit(parent, target, module, damage)

/datum/ship_module/weapon/proc/weapon_hit(obj/structure/overmap/ship/simulated/parent, obj/structure/overmap/ship/simulated/target, obj/structure/ship_module/weapon/module, damage)
	if(target.recieve_damage(damage, parent, damage_types))
		return WEAPON_HIT
	return WEAPON_MISS

/obj/structure/ship_module/weapon
	name = "Default Weapon Module"
	var/ammo = 1
	var/mag_size = 1
	var/reloading = FALSE
	var/reload_time = 2 SECONDS

/obj/structure/ship_module/weapon/proc/try_reload()
	if(reloading)
		return
	reloading = TRUE
	addtimer(CALLBACK(src, .proc/reload), reload_time)

/obj/structure/ship_module/weapon/proc/reload()
	ammo = mag_size
