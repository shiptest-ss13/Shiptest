//Hoods for winter coats and chaplain hoodie etc

/obj/item/clothing/suit/hooded
	icon = 'icons/obj/clothing/suits/hooded.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/hooded.dmi'
	actions_types = list(/datum/action/item_action/toggle_hood)
	var/obj/item/clothing/head/hooded/hood
	var/hoodtype = /obj/item/clothing/head/hooded/winterhood //so the chaplain hoodie or other hoodies can override this
	pocket_storage_component_path = FALSE

	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE

	equip_sound = 'sound/items/equip/cloth_equip.ogg'
	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC
	equip_delay_self = EQUIP_DELAY_COAT
	equip_delay_other = EQUIP_DELAY_COAT * 1.5
	strip_delay = EQUIP_DELAY_COAT * 1.5

/obj/item/clothing/suit/hooded/Initialize()
	. = ..()
	if(!base_icon_state)
		base_icon_state = icon_state
	make_hood()

/obj/item/clothing/suit/hooded/Destroy()
	. = ..()
	qdel(hood)
	hood = null

/obj/item/clothing/suit/hooded/reskin_obj(mob/M, change_name)
	. = ..()
	if(hood)
		hood.icon_state = base_icon_state
	return

/obj/item/clothing/suit/hooded/proc/make_hood()
	if(!hood)
		var/obj/item/clothing/head/hooded/W = new hoodtype(src)
		W.suit = src
		hood = W

/obj/item/clothing/suit/hooded/ui_action_click()
	toggle_hood()

/obj/item/clothing/suit/hooded/item_action_slot_check(slot, mob/user)
	if(slot == ITEM_SLOT_OCLOTHING)
		return 1

/obj/item/clothing/suit/hooded/equipped(mob/user, slot)
	if(slot != ITEM_SLOT_OCLOTHING)
		remove_hood()
	..()

/obj/item/clothing/suit/hooded/proc/remove_hood()
	suittoggled = FALSE
	if(hood)
		if(ishuman(hood.loc))
			var/mob/living/carbon/H = hood.loc
			H.transferItemToLoc(hood, src, TRUE)
			H.update_inv_wear_suit()
			update_appearance()
			H.regenerate_icons()
		else
			hood.forceMove(src)
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()

/obj/item/clothing/suit/hooded/update_appearance(updates)
	if(suittoggled)
		icon_state = "[base_icon_state]_t"
	else
		icon_state = base_icon_state
	. = ..()

/obj/item/clothing/suit/hooded/dropped()
	..()
	remove_hood()

/obj/item/clothing/suit/hooded/proc/toggle_hood()
	if(!suittoggled)
		if(ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			if(H.wear_suit != src)
				to_chat(H, span_warning("You must be wearing [src] to put up the hood!"))
				return
			if(H.head)
				to_chat(H, span_warning("You're already wearing something on your head!"))
				return
			else if(H.equip_to_slot_if_possible(hood,ITEM_SLOT_HEAD,0,0,1))
				suittoggled = TRUE
				H.update_inv_wear_suit()
				update_appearance()
				H.regenerate_icons()
				for(var/X in actions)
					var/datum/action/A = X
					A.UpdateButtonIcon()
	else
		remove_hood()

/obj/item/clothing/head/hooded
	var/obj/item/clothing/suit/hooded/suit

/obj/item/clothing/head/hooded/Destroy()
	suit = null
	return ..()

/obj/item/clothing/head/hooded/dropped()
	..()
	if(suit)
		suit.remove_hood()

/obj/item/clothing/head/hooded/equipped(mob/user, slot)
	..()
	if(slot != ITEM_SLOT_HEAD)
		if(suit)
			suit.remove_hood()
		else
			qdel(src)

//Toggle exosuits for different aesthetic styles (hoodies, suit jacket buttons, etc)
/obj/item/clothing/suit/toggle
	icon = 'icons/obj/clothing/suits/toggle.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/toggle.dmi'
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE

	equip_sound = 'sound/items/equip/cloth_equip.ogg'
	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC
	equip_delay_self = EQUIP_DELAY_COAT
	equip_delay_other = EQUIP_DELAY_COAT * 1.5
	strip_delay = EQUIP_DELAY_COAT * 1.5

/obj/item/clothing/suit/toggle/AltClick(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		return FALSE

	. = SEND_SIGNAL(src, COMSIG_CLICK_ALT, user)
	if(. & COMPONENT_CANCEL_CLICK_ALT)
		return

	if(unique_reskin && !current_skin)
		reskin_obj(user)
		return TRUE

	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		return FALSE
	suit_toggle(user)


	return TRUE

/obj/item/clothing/suit/toggle/ui_action_click()
	suit_toggle()

/obj/item/clothing/suit/toggle/proc/suit_toggle()
	set src in usr

	if(!can_use(usr))
		return 0

	to_chat(usr, span_notice("You toggle [src]'s [togglename]."))
	if(src.suittoggled)
		src.icon_state = "[initial(icon_state)]"
		src.suittoggled = FALSE
	else if(!src.suittoggled)
		src.icon_state = "[initial(icon_state)]_t"
		src.suittoggled = TRUE
	usr.update_inv_wear_suit()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/suit/toggle/examine(mob/user)
	. = ..()
	. += "Alt-click on [src] to toggle the [togglename]."

//Hardsuit toggle code
/obj/item/clothing/suit/space/hardsuit/Initialize()
	MakeHelmet()
	. = ..()

/obj/item/clothing/suit/space/hardsuit/Destroy()
	if(!QDELETED(helmet))
		helmet.suit = null
		qdel(helmet)
		helmet = null
	QDEL_NULL(jetpack)
	return ..()

/obj/item/clothing/head/helmet/space/hardsuit/Destroy()
	if(suit)
		suit.helmet = null
	return ..()

/obj/item/clothing/suit/space/hardsuit/proc/MakeHelmet()
	if(!helmettype)
		return
	if(!helmet)
		var/obj/item/clothing/head/helmet/space/hardsuit/W = new helmettype(src)
		W.suit = src
		helmet = W

/obj/item/clothing/suit/space/hardsuit/ui_action_click()
	..()
	ToggleHelmet()

/obj/item/clothing/suit/space/hardsuit/equipped(mob/user, slot)
	if(!helmettype)
		return
	if(slot != ITEM_SLOT_OCLOTHING)
		RemoveHelmet()
	..()

/obj/item/clothing/suit/space/hardsuit/proc/RemoveHelmet()
	if(!helmet)
		return
	suittoggled = FALSE
	if(ishuman(helmet.loc))
		var/mob/living/carbon/H = helmet.loc
		if(helmet.on)
			helmet.attack_self(H)
		H.transferItemToLoc(helmet, src, TRUE)
		H.update_inv_wear_suit()
		to_chat(H, span_notice("The helmet on the hardsuit disengages."))
		playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)
	else
		helmet.forceMove(src)

/obj/item/clothing/suit/space/hardsuit/dropped()
	..()
	RemoveHelmet()

/obj/item/clothing/suit/space/hardsuit/proc/ToggleHelmet()
	var/mob/living/carbon/human/H = src.loc
	if(!helmettype)
		return
	if(!helmet)
		to_chat(H, span_warning("The helmet's lightbulb seems to be damaged! You'll need a replacement bulb."))
		return
	if(!suittoggled)
		if(ishuman(src.loc))
			if(H.wear_suit != src)
				to_chat(H, span_warning("You must be wearing [src] to engage the helmet!"))
				return
			if(H.head)
				to_chat(H, span_warning("You're already wearing something on your head!"))
				return
			else if(H.equip_to_slot_if_possible(helmet,ITEM_SLOT_HEAD,0,0,1))
				to_chat(H, span_notice("You engage the helmet on the hardsuit."))
				suittoggled = TRUE
				H.update_inv_wear_suit()
				playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)
	else
		RemoveHelmet()
