/obj/item/attachment/silencer
	name = "silencer"
	desc = "For when you need to kill someone but not be seen killing someone!"
	icon_state = "silencer"
	slot = ATTACHMENT_SLOT_MUZZLE
	has_toggle = TRUE

/obj/item/attachment/silencer/Attach(obj/item/gun/gun, mob/user)
	. = ..()
	gun.suppressed = TRUE

/obj/item/attachment/silencer/Detach(obj/item/gun/gun, mob/user)
	. = ..()
	gun.suppressed = FALSE
	return TRUE
