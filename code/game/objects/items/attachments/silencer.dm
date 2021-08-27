/obj/item/attachment/silencer
	name = "silencer"
	desc = "For when you need to kill someone but not be seen killing someone!"
	icon_state = "silencer"
	slot = ATTACHMENT_SLOT_MUZZLE

/obj/item/attachment/silencer/Attach(obj/item/gun/gun, mob/user)
	. = ..()
	if(!gun.can_suppress)
		to_chat(user, "<span class='warning'>You cannot attach [src] to [gun]!</span>")
		return FALSE
	gun.suppressed = TRUE

/obj/item/attachment/silencer/Toggle(obj/item/gun/gun, mob/user)
	. = ..()
	// TODO: Consider making attachments that dont toggle a custom subtype
	if(toggled)
		Toggle(gun, user)

/obj/item/attachment/silencer/Detach(obj/item/gun/gun, mob/user)
	. = ..()
	if(!gun.can_unsuppress)
		to_chat(user, "<span class='warning'>You cannot detach [src] from [gun]!</span>")
		return FALSE
	gun.suppressed = FALSE
	return TRUE
