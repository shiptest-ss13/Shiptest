
/obj/item/attachment/gun
	name = "underbarrel gun"
	desc = "A gun that goes on the underbarrel of another gun. You probably shouldn't be seeing this."
	icon_state = "gun"

	attach_features_flags = ATTACH_REMOVABLE_HAND
	pixel_shift_x = 1
	pixel_shift_y = 4
	wield_delay = 0.1 SECONDS
	var/weapon_type = /obj/item/gun/ballistic/shotgun/automatic
	var/obj/item/gun/attached_gun
	var/allow_hand_interaction = FALSE
	//basically so the fire select shows the right icon
	var/underbarrel_prefix = ""
	var/has_safety = TRUE

/obj/item/attachment/gun/Initialize(mapload, spawn_empty = FALSE)
	. = ..()
	if(weapon_type)
		attached_gun = new weapon_type(src,spawn_empty)
		attached_gun.interaction_flags_item = NONE

/obj/item/attachment/gun/Destroy()
	. = ..()
	QDEL_NULL(attached_gun)

/obj/item/attachment/gun/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	// if(FIREMODE_UNDERBARREL in gun.gun_firemodes)
	// 	to_chat(user,span_warning("The [gun] already has an underbarrel gun and can't take the [src]!"))
	// 	return FALSE
	// else
	// 	gun.gun_firemodes += FIREMODE_UNDERBARREL
	gun.underbarrel_prefix = underbarrel_prefix
	if(attached_gun)
		attached_gun.safety = gun.safety
	//gun.build_firemodes()
	if(user)
		gun.equipped(user)

/obj/item/attachment/gun/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	// var/firemode_to_remove = gun.gun_firemodes.Find(FIREMODE_UNDERBARREL)
	// if(firemode_to_remove)
	// 	gun.gun_firemodes -= gun.gun_firemodes[firemode_to_remove]
	gun.underbarrel_prefix = ""
	// gun.build_firemodes()
	// gun.equipped(user)

/obj/item/attachment/gun/on_wield(obj/item/gun/gun, mob/user, list/params)
	if(attached_gun)
		attached_gun.wielded_fully = TRUE

/obj/item/attachment/gun/on_unwield(obj/item/gun/gun, mob/user, list/params)
	if(attached_gun)
		attached_gun.on_unwield(src, user)

/obj/item/attachment/gun/on_attacked(obj/item/gun/gun, mob/user, obj/item/attack_item)
	attackby(attack_item,user)
	return COMPONENT_SECONDARY_CANCEL_ATTACK_CHAIN

/obj/item/attachment/gun/on_fire_gun(obj/item/gun/gun, mob/living/user, atom/target, flag, params)
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		INVOKE_ASYNC(attached_gun, TYPE_PROC_REF(/obj/item/gun, fire_gun), target, user, flag, params)
		attached_gun.process_fire(target,user,TRUE)
		return COMPONENT_CANCEL_GUN_FIRE

/obj/item/attachment/gun/unique_action(mob/living/user)
	attached_gun.unique_action(user)

/obj/item/attachment/gun/on_attack_hand(obj/item/gun/gun, mob/user, list/examine_list)
	hand_attack_interaction(user)
	return COMPONENT_NO_ATTACK_HAND

/obj/item/attachment/gun/attack_hand(mob/user)
	if(loc == user && user.is_holding(src) && allow_hand_interaction)
		if(hand_attack_interaction(user))
			return COMPONENT_NO_ATTACK_HAND
	return ..()

/obj/item/attachment/gun/proc/hand_attack_interaction(mob/user)
	return COMPONENT_NO_ATTACK_HAND

/obj/item/attachment/gun/on_secondary_action(obj/item/gun/gun, mob/user)
	attached_gun.unique_action(user)
	return OVERRIDE_SECONDARY_ACTION

/obj/item/attachment/gun/on_ctrl_click(obj/item/gun/gun, mob/user)
	if(has_safety)
		attached_gun.toggle_safety(user,TRUE, TRUE)

/obj/item/attachment/gun/on_alt_click(obj/item/gun/gun, mob/user, list/examine_list)
	return FALSE
	// if(gun.gun_firemodes[gun.firemode_index] == FIREMODE_UNDERBARREL)
	// 	AltClick(user)
	// 	return TRUE
	// else
	// 	return FALSE


