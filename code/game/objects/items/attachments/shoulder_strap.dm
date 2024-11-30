/obj/item/attachment/strap
	name = "shoulder strap"
	desc = "A leather shoulder strap for longarms for easy carrying on the shoulder."
	icon_state = "laserpointer"

	attach_features_flags = ATTACH_REMOVABLE_HAND
	pixel_shift_x = 1
	pixel_shift_y = 4
	wield_delay = 0.1 SECONDS

/obj/item/attachment/strap/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(!(gun.slot_flags | ITEM_SLOT_SUITSTORE))
		gun.slot_flags = gun.slot_flags | ITEM_SLOT_SUITSTORE
	ADD_TRAIT(gun,TRAIT_FORCE_SUIT_STORAGE,src)

/obj/item/attachment/strap/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.slot_flags = initial(gun.slot_flags)
	REMOVE_TRAIT(gun,TRAIT_FORCE_SUIT_STORAGE,src)
