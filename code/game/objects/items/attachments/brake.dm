/obj/item/attachment/muzzle_brake
	name = "muzzle brake"
	desc = "An attachment for the barrel of a firearm. Hides the muzzle flash completely and gives greater control over recoil, in exchange for being significantly louderi."
	icon_state = "brake"

	allow_icon_state_prefixes = TRUE
	slot = ATTACHMENT_SLOT_MUZZLE
	pixel_shift_x = 0
	pixel_shift_y = 2
	spread_mod = -3
	spread_unwielded_mod = 2
	wield_delay = 0.1 SECONDS

/obj/item/attachment/muzzle_brake/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.has_muzzle_flash = FALSE
	gun.recoil_unwielded += 1
	gun.fire_sound_volume *= 1.7
	gun.fire_sound_extrarange += 10

/obj/item/attachment/muzzle_brake/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.has_muzzle_flash = gun::has_muzzle_flash
	gun.recoil_unwielded -= 1
	gun.fire_sound_volume = gun::fire_sound_volume
	gun.fire_sound_extrarange -= 10
	return TRUE

/obj/item/attachment/muzzle_brake/on_beforefire(obj/item/gun/gun, atom/target, mob/user, list/params)
	gun.chambered.BB.alpha = 75
	gun.chambered.BB.set_light_on(FALSE)
	gun.chambered.BB.speed *= 1.5
	RegisterSignal(gun.chambered.BB, COMSIG_MOVABLE_MOVED, PROC_REF(handle_movement))
	return FALSE

/obj/item/attachment/muzzle_brake/proc/handle_movement(obj/projectile/projectile)
	var/actualrange = -(projectile.range - projectile.decayedRange)
	if(actualrange >= 3)
		projectile.alpha = 150
	if(actualrange > 4)
		projectile.alpha = projectile::alpha
		projectile.set_light_on(TRUE)
		projectile.UnregisterSignal(src, COMSIG_MOVABLE_MOVED)


