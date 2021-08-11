/obj/item/attachment
	name = "broken attachment"
	desc = "alert coders"
	icon = 'icons/obj/attachments.dmi'

	var/slot = ATTACHMENT_SLOT_RAIL
	var/list/valid_parents = list()
	var/list/signals = list()

	var/toggled = FALSE

	var/datum/component/attachment/attachment_comp

/obj/item/attachment/Initialize()
	. = ..()
	attachment_comp = AddComponent( \
		/datum/component/attachment, \
		slot, \
		valid_parents, \
		CALLBACK(src, .proc/Attach), \
		CALLBACK(src, .proc/Detach), \
		CALLBACK(src, .proc/Toggle), \
		CALLBACK(src, .proc/PreAttack), \
		signals)

/obj/item/attachment/proc/Toggle(obj/item/gun/gun, mob/user)
	SHOULD_CALL_PARENT(TRUE)

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
