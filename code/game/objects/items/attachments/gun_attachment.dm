/obj/item/attachment/gun
	name = "underbarrel gun"
	desc = "A gun that goes on the underbarrel of another gun. You probably shouldnt be seeing this."
	icon_state = "laserpointer"

	attach_features_flags = ATTACH_REMOVABLE_HAND|ATTACH_TOGGLE
	pixel_shift_x = 1
	pixel_shift_y = 4
	wield_delay = 0.1 SECONDS
	var/obj/item/gun/gun_to_spawn = /obj/item/gun/ballistic/automatic/pistol
	var/obj/item/gun/attached_gun

/obj/item/attachment/gun/Initialize()
	. = ..()
	attached_gun = new gun_to_spawn(src)
	attached_gun.safety = FALSE

/obj/item/attachment/gun/on_preattack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	if(toggled)
		attached_gun.pre_attack(user,target,params)
		return COMPONENT_NO_ATTACK
