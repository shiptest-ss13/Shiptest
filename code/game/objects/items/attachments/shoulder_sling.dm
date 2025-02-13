/obj/item/attachment/sling
	name = "shoulder sling"
	desc = "A leather shoulder sling for longarms to allow for easy carrying on the shoulder without the need for traditional armor holsters."
	icon_state = "sling"

	attach_features_flags = ATTACH_REMOVABLE_HAND
	pixel_shift_x = 14
	pixel_shift_y = 15
	render_layer = BELOW_OBJ_LAYER
	render_plane = BELOW_OBJ_LAYER
	wield_delay = 0.2 SECONDS

	var/check_size = FALSE

/obj/item/attachment/sling/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(initial(gun.w_class) < WEIGHT_CLASS_BULKY && check_size)
		to_chat(user,span_warning("The frame of the \the [gun] isn't large enough to support \the [src]!"))
		return FALSE
	if(!(gun.slot_flags | ITEM_SLOT_SUITSTORE))
		gun.slot_flags = gun.slot_flags | ITEM_SLOT_SUITSTORE
	ADD_TRAIT(gun,TRAIT_FORCE_SUIT_STORAGE,REF(src))

/obj/item/attachment/sling/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.slot_flags = initial(gun.slot_flags)
	REMOVE_TRAIT(gun,TRAIT_FORCE_SUIT_STORAGE, REF(src))

/obj/item/attachment/sling/examine(mob/user)
	. = ..()
	. += span_notice("The shoulder sling can only be attached to bulky or heavier guns.")
