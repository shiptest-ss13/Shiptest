/obj/item/attachment/silencer
	name = "suppressor"
	desc = "An attachment for the barrel of a firearm. Does not completely silence a weapon, but does make it much quieter and a bit more accurate at the cost of bullet speed and increased muzzle flash."
	icon_state = "silencer"

	allow_icon_state_prefixes = TRUE
	slot = ATTACHMENT_SLOT_MUZZLE
	pixel_shift_x = 1
	pixel_shift_y = 2
	size_mod = 1
	spread_unwielded_mod = 4
	wield_delay = 0.2 SECONDS

/obj/item/attachment/silencer/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.suppressed = TRUE
	gun.recoil -= 1
	gun.light_range += 1
	gun.light_power += 1

/obj/item/attachment/silencer/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.suppressed = FALSE
	gun.recoil += 1
	gun.light_range -= 1
	gun.light_power -= 1
	return TRUE

/obj/item/attachment/silencer/on_beforefire(obj/item/gun/gun, atom/target, mob/user, list/params)
	gun.chambered.BB.alpha = 75
	gun.chambered.BB.set_light_range(0)
	gun.chambered.BB.set_light_on(FALSE)
	gun.chambered.BB.speed *= 1.9
	return FALSE

/obj/item/attachment/muzzle_brake
	name = "muzzle_brake"
	desc = "An attachment for the barrel of a firearm. Hides the muzzle flash completely and gives greater control over recoil, in exchange for being significantly louderi."
	icon_state = "brake"

	allow_icon_state_prefixes = TRUE
	slot = ATTACHMENT_SLOT_MUZZLE
	pixel_shift_x = 1
	pixel_shift_y = 2
	spread_mod = -3
	spread_unwielded_mod = 2
	wield_delay = 0.1 SECONDS

/obj/item/attachment/muzzle_brake/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.has_muzzle_flash = FALSE

/obj/item/attachment/muzzle_brake/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.has_muzzle_flash = gun::has_muzzle_flash
	return TRUE

/obj/item/attachment/muzzle_brake/on_beforefire(obj/item/gun/gun, atom/target, mob/user, list/params)
	gun.chambered.BB.alpha = 50
	gun.chambered.BB.set_light_on(FALSE)
	gun.chambered.BB.speed *= 1.5
	RegisterSignal(gun.chambered.BB, COMSIG_MOVABLE_MOVED, PROC_REF(handle_movement))
	return FALSE

/obj/item/attachment/muzzle_brake/proc/handle_movement(/obj/projectile/projectile)
	var/actualrange = -(projectile.range - projectile.decayedRange)
	if(actualrange > 3)
		projectile.alpha = projectile::alpha
		projectile.set_light_on(TRUE)
		projectile.UnregisterSignal(src, COMSIG_MOVABLE_MOVED)


