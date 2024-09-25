/obj/item/attachment/gun
	name = "underbarrel gun"
	desc = "A gun that goes on the underbarrel of another gun. You probably shouldn't be seeing this."
	icon_state = "laserpointer"

	attach_features_flags = ATTACH_REMOVABLE_HAND
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
	if(FIREMODE_OTHER in gun.gun_firemodes)
		to_chat(user,span_warning("The [gun] can't take the [src]!"))
		return FALSE
	else
		gun.gun_firemodes += FIREMODE_OTHER
	if(attached_gun)
		attached_gun.safety = gun.safety
	gun.build_firemodes()

/obj/item/attachment/gun/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/firemode_to_remove = gun.gun_firemodes.Find(FIREMODE_OTHER)
	if(firemode_to_remove)
		gun.gun_firemodes -= gun.gun_firemodes[firemode_to_remove]
	gun.build_firemodes()

/obj/item/attachment/gun/on_wield(obj/item/gun/gun, mob/user, list/params)
	attached_gun.on_wield(src,user)

/obj/item/attachment/gun/on_unwield(obj/item/gun/gun, mob/user, list/params)
	attached_gun.on_unwield(src, user)

/obj/item/attachment/gun/on_attacked(obj/item/gun/gun, mob/user, obj/item/attack_item)
	if(gun.gun_firemodes[gun.firemode_index] == FIREMODE_OTHER)
		attackby(attack_item,user)

/obj/item/attachment/gun/on_preattack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	if(gun.gun_firemodes[gun.firemode_index] == FIREMODE_OTHER)
		attached_gun.process_fire(target,user,TRUE)
		return COMPONENT_NO_ATTACK

/obj/item/attachment/gun/unique_action(mob/living/user)
	attached_gun.unique_action(user)

/obj/item/attachment/gun/on_unique_action(obj/item/gun/gun, mob/user)
	if(gun.gun_firemodes[gun.firemode_index] == FIREMODE_OTHER)
		attached_gun.unique_action(user)
		return OVERIDE_UNIQUE_ACTION

/obj/item/attachment/gun/on_ctrl_click(obj/item/gun/gun, mob/user)
	attached_gun.toggle_safety(user,TRUE)

