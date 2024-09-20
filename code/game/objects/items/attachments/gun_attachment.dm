/obj/item/attachment/gun
	name = "underbarrel gun"
	desc = "A gun that goes on the underbarrel of another gun. You probably shouldnt be seeing this."
	icon_state = "laserpointer"

	attach_features_flags = ATTACH_REMOVABLE_HAND|ATTACH_TOGGLE
	pixel_shift_x = 1
	pixel_shift_y = 4
	wield_delay = 0.1 SECONDS
	var/weapon_type = /obj/item/gun/ballistic/automatic/pistol/ringneck
	var/obj/item/gun/attached_gun

/obj/item/attachment/gun/Initialize()
	. = ..()
	attached_gun = new gun_to_spawn(src)
	attached_gun.safety = FALSE

/obj/item/attachment/gun/on_afterattack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	if(toggled)
		attached_gun.process_fire(target,user,TRUE)
		return COMPONENT_NO_ATTACK
