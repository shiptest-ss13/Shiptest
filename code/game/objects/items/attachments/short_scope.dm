/obj/item/attachment/scope
	name = "scope"
	desc = "An attachment for the scope of a weapon. Allows one to aim down the sight."
	icon_state = "small_scope"

	slot = ATTACHMENT_SLOT_SCOPE
	pixel_shift_x = 1
	pixel_shift_y = 2
	size_mod = 0
	unique_reskin = list(
		"Scope" = "small_scope",
		"Classic" = "small_scope_old",
		)
	unique_reskin_changes_inhand = TRUE
	var/zoom_mod = 4
	var/zoom_out_mod = 0
	var/min_recoil_mod = 0.1
	var/aim_slowdown_mod = 0.2

/obj/item/attachment/scope/old
	icon_state = "small_scope_old"

/obj/item/attachment/scope/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.zoom_amt = zoom_mod
	gun.zoom_out_amt = zoom_out_mod
	gun.min_recoil_aimed = min_recoil_mod
	gun.aimed_wield_slowdown += aim_slowdown_mod

/obj/item/attachment/scope/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.zoom_amt = initial(gun.zoom_amt)
	gun.zoom_out_amt = initial(gun.zoom_out_amt)
	gun.min_recoil_aimed = initial(gun.min_recoil_aimed)
	gun.aimed_wield_slowdown = initial(gun.aimed_wield_slowdown)
	return TRUE
