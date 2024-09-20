///Most of the logic of attachments is held within the component which allows you to add other items as attachments in theory
/obj/item/attachment
	name = "broken attachment"
	desc = "alert coders"
	icon = 'icons/obj/guns/attachments.dmi'
	w_class = WEIGHT_CLASS_SMALL

	//Slot the attachment goes on, also used in descriptions so should be player readable
	var/slot = ATTACHMENT_SLOT_RAIL
	///various yes no flags associated with attachments. See defines for these: [_DEFINES/guns.dm]
	var/attach_features_flags = ATTACH_REMOVABLE_HAND
	///See attachment component
	var/list/valid_parents = list()
	///Unused.. but could hold extra callbacks I assume?
	var/list/signals = list()
	///Component that handles most of the logic of attachments
	var/datum/component/attachment/attachment_comp

	///If the attachment is on or off
	var/toggled = FALSE
	var/toggle_on_sound = 'sound/items/flashlight_on.ogg'
	var/toggle_off_sound = 'sound/items/flashlight_off.ogg'

	///Determines the amount of pixels to move the icon state for the overlay. in the x direction
	var/pixel_shift_x = 16
	///Determines the amount of pixels to move the icon state for the overlay. in the y direction
	var/pixel_shift_y = 16

	//Toggle modifers are handled seperatly
	///Modifier applied to the parent
	var/spread_mod = 0
	///Modifier applied to the parent
	var/spread_unwielded_mod = 0
	///Modifier applied to the parent, deciseconds
	var/wield_delay = 0
	///Modifier applied to the parent
	var/size_mod = 0

/obj/item/attachment/Initialize()
	. = ..()
	attachment_comp = AddComponent( \
		/datum/component/attachment, \
		slot, \
		attach_features_flags, \
		valid_parents, \
		CALLBACK(src, PROC_REF(apply_attachment)), \
		CALLBACK(src, PROC_REF(remove_attachment)), \
		CALLBACK(src, PROC_REF(toggle_attachment)), \
		CALLBACK(src, PROC_REF(on_preattack)), \
		CALLBACK(src, PROC_REF(on_afterattack)), \
		signals)

/obj/item/attachment/Destroy()
	qdel(attachment_comp)
	attachment_comp = null
	. = ..()

/obj/item/attachment/proc/toggle_attachment(obj/item/gun/gun, mob/user)
	SHOULD_CALL_PARENT(TRUE)

	playsound(user, toggled ? toggle_on_sound : toggle_off_sound, 40, TRUE)
	toggled = !toggled
	icon_state = "[initial(icon_state)][toggled ? "-on" : ""]"

/// Checks if a user should be allowed to attach this attachment to the given parent
/obj/item/attachment/proc/apply_attachment(obj/item/gun/gun, mob/user)
	SHOULD_CALL_PARENT(TRUE)

	if(toggled)
		to_chat(user, span_warning("You cannot attach [src] while it is active!"))
		return FALSE

	apply_modifiers(gun, user, TRUE)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_insert_alt.ogg', 75, 1)
	return TRUE

/obj/item/attachment/proc/remove_attachment(obj/item/gun/gun, mob/user)
	SHOULD_CALL_PARENT(TRUE)

	if(toggled)
		toggle_attachment(gun, user)

	apply_modifiers(gun, user, FALSE)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_release_alt.ogg', 75, 1)
	return TRUE

/obj/item/attachment/proc/on_preattack(obj/item/gun/gun, atom/target, mob/user, list/params)
	return FALSE

/obj/item/attachment/proc/on_afterattack(obj/item/gun/gun, atom/target, mob/user, list/params)
	return FALSE

///Handles the modifiers to the parent gun
/obj/item/attachment/proc/apply_modifiers(obj/item/gun/gun, mob/user, attaching)
	if(attaching)
		gun.spread += spread_mod
		gun.spread_unwielded += spread_unwielded_mod
		gun.wield_delay += wield_delay
		gun.w_class += size_mod
	else
		gun.spread -= spread_mod
		gun.spread_unwielded -= spread_unwielded_mod
		gun.wield_delay -= wield_delay
		gun.w_class -= size_mod
