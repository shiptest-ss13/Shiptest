/obj/item/attachment
	name = "broken attachment"
	desc = "alert coders"
	icon = 'icons/obj/guns/attachments.dmi'

	var/slot = ATTACHMENT_SLOT_RAIL
	///various yes no flags associated with attachments. See defines for these: [ATTACH_REMOVABLE]
	var/attach_features_flags = ATTACH_REMOVABLE
	var/list/valid_parents = list()
	var/list/signals = list()
	var/datum/component/attachment/attachment_comp

	var/toggled = FALSE
	var/toggle_on_sound = 'sound/items/flashlight_on.ogg'
	var/toggle_off_sound = 'sound/items/flashlight_off.ogg'

	///Determines the amount of pixels to move the icon state for the overlay. in the x direction
	var/pixel_shift_x = 16
	///Determines the amount of pixels to move the icon state for the overlay. in the y direction
	var/pixel_shift_y = 16

/obj/item/attachment/Initialize()
	. = ..()
	attachment_comp = AddComponent( \
		/datum/component/attachment, \
		slot, \
		attach_features_flags, \
		valid_parents, \
		CALLBACK(src, PROC_REF(Attach)), \
		CALLBACK(src, PROC_REF(Detach)), \
		CALLBACK(src, PROC_REF(Toggle)), \
		CALLBACK(src, PROC_REF(PreAttack)), \
		signals)

/obj/item/attachment/Destroy()
	qdel(attachment_comp)
	attachment_comp = null
	. = ..()

/obj/item/attachment/proc/Toggle(obj/item/gun/gun, mob/user)
	SHOULD_CALL_PARENT(TRUE)

	playsound(user, toggled ? toggle_on_sound : toggle_off_sound, 40, TRUE)
	toggled = !toggled
	icon_state = "[initial(icon_state)][toggled ? "-on" : ""]"

/// Checks if a user should be allowed to attach this attachment to the given parent
/obj/item/attachment/proc/Attach(obj/item/gun/gun, mob/user)
	SHOULD_CALL_PARENT(TRUE)

	if(toggled)
		to_chat(user, "<span class='warning'>You cannot attach [src] while it is active!</span>")
		return FALSE

	return TRUE

/obj/item/attachment/proc/Detach(obj/item/gun/gun, mob/user)
	SHOULD_CALL_PARENT(TRUE)

	if(toggled)
		Toggle(gun, user)
	return TRUE

/obj/item/attachment/proc/PreAttack(obj/item/gun/gun, atom/target, mob/user, list/params)
	return FALSE
