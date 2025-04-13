/obj/item/attachment/silencer
	name = "suppressor"
	desc = "An attachment for the barrel of a firearm. Does not completely silence a weapon, but does make it much quieter and a bit more accurate at the cost of bullet speed and increased muzzle flash."
	icon_state = "silencer"

	allow_icon_state_prefixes = TRUE
	slot = ATTACHMENT_SLOT_MUZZLE
	pixel_shift_x = 1
	pixel_shift_y = 1
	size_mod = 1
	spread_mod = -2
	spread_unwielded_mod = 4
	wield_delay = 0.2 SECONDS

/obj/item/attachment/silencer/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.suppressed = TRUE
	gun.recoil -= 1
	gun.recoil_unwielded -= 1
	gun.light_range += 1
	gun.light_power += 1

/obj/item/attachment/silencer/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.suppressed = FALSE
	gun.recoil += 1
	gun.recoil_unwielded += 1
	gun.light_range -= 1
	gun.light_power -= 1
	return TRUE

/obj/item/attachment/silencer/on_beforefire(obj/item/gun/gun, atom/target, mob/user, list/params)
	gun.chambered.BB.alpha = 75
	gun.chambered.BB.set_light_range(0)
	gun.chambered.BB.set_light_on(FALSE)
	gun.chambered.BB.speed *= 2
	return FALSE
