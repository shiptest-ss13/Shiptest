/obj/item/binoculars
	name = "binoculars"
	desc = "Used for long-distance surveillance."
	item_state = "binoculars"
	icon_state = "binoculars"
	mob_overlay_icon = 'icons/mob/binoculars.dmi'
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL

/obj/item/binoculars/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/obj/item/binoculars/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=8, force_wielded=12)
	AddComponent(/datum/component/scope, range_modifier = 4, aimed_wield_slowdown = 1.5, zoom_method = ZOOM_METHOD_WIELD)

/obj/item/binoculars/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	user.visible_message(span_notice("[user] holds [src] up to [user.p_their()] eyes."), span_notice("You hold [src] up to your eyes."))
	item_state = "binoculars_wielded"
	user.regenerate_icons()

/obj/item/binoculars/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	user.visible_message(span_notice("[user] lowers [src]."), span_notice("You lower [src]."))
	item_state = "binoculars"
	user.regenerate_icons()
