/obj/item/attachment/scope
	name = "scope"
	desc = "An attachment for the scope of a weapon. Allows one to aim down the sight."
	icon_state = "small_scope"

	slot = ATTACHMENT_SLOT_SCOPE
	pixel_shift_x = 1
	pixel_shift_y = 2
	size_mod = 0
	var/range_modifier = SHORT_SCOPE_ZOOM
	var/min_recoil_mod = 0.1
	var/aim_slowdown_mod = 0.2

/obj/item/attachment/scope/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.min_recoil_aimed = min_recoil_mod
	gun.AddComponent(/datum/component/scope, range_modifier = max(range_modifier, gun.range_modifier), aimed_wield_slowdown = (aim_slowdown_mod + gun.aimed_wield_slowdown))

/obj/item/attachment/scope/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.min_recoil_aimed = initial(gun.min_recoil_aimed)
	gun.AddComponent(/datum/component/scope, range_modifier = gun.range_modifier, aimed_wield_slowdown = gun.aimed_wield_slowdown)
	return TRUE

/obj/item/attachment/scope/long
	name = "long range scope"
	icon_state = "scope"

	size_mod = 1
	range_modifier = LONG_SCOPE_ZOOM

	min_recoil_mod = 0.1
	aim_slowdown_mod = 0.4
