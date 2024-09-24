/obj/item/attachment/gun
	name = "underbarrel gun"
	desc = "A gun that goes on the underbarrel of another gun. You probably shouldn't be seeing this."
	icon_state = "laserpointer"

	attach_features_flags = ATTACH_REMOVABLE_HAND|ATTACH_TOGGLE
	pixel_shift_x = 1
	pixel_shift_y = 4
	wield_delay = 0.1 SECONDS
	var/weapon_type = /obj/item/gun/ballistic/shotgun/automatic/combat
	var/obj/item/gun/attached_gun

/obj/item/attachment/gun/Initialize()
	. = ..()
	if(weapon_type)
		attached_gun = new weapon_type(src)

/obj/item/attachment/gun/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(attached_gun)
		attached_gun.safety = gun.safety

/obj/item/attachment/gun/on_wield(obj/item/gun/gun, mob/user, list/params)
	attached_gun.on_wield(src,user)

/obj/item/attachment/gun/on_unwield(obj/item/gun/gun, mob/user, list/params)
	attached_gun.on_unwield(src, user)

/obj/item/attachment/gun/on_attacked(obj/item/gun/gun, mob/user, obj/item/attack_item)
	return FALSE

/obj/item/attachment/gun/on_preattack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	if(toggled)
		attached_gun.process_fire(target,user,TRUE)
		return COMPONENT_NO_ATTACK

/obj/item/attachment/gun/on_unique_action(obj/item/gun/gun, mob/user)
	if(toggled)
		attached_gun.unique_action(user)
		return OVERIDE_UNIQUE_ACTION

/obj/item/attachment/gun/on_ctrl_click(obj/item/gun/gun, mob/user)
	attached_gun.toggle_safety(user,TRUE)

