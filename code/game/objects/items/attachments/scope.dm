/obj/item/attachment/scope
	name = "bayonet"
	icon_state = "scope"
	slot = ATTACHMENT_SLOT_SCOPE
	var/zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	var/zoom_out_amt = 5


/obj/item/attachment/scope/Attach(obj/item/gun/gun, mob/user)
	. = ..()
	gun.zoomable = TRUE
	gun.zoom_amt = zoom_amt
	gun.zoom_out_amt = zoom_out_amt
	gun.build_zooming()

/obj/item/attachment/scope/Detach(obj/item/gun/gun, mob/user)
	. = ..()
	gun.zoomable = FALSE
	gun.zoom_amt = initial(gun.zoom_amt)
	gun.zoom_out_amt = initial(gun.zoom_out_amt)
	gun.actions -= gun.azoom
	qdel(gun.azoom)
	return TRUE
