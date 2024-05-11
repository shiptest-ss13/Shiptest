/obj/item/clothing/under/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bodycamera_holder)

/**
 * The bodycamera
 *
 * This is the item that gets installed into items that have the bodycamera_holder element
 */
/obj/item/bodycam
	name = "\a body camera"
	icon = 'icons/obj/bodycamera.dmi'
	icon_state = "bodycamera"
	desc = "A small camera that can be attached to clothing, there's an instructions tag if you look a little closer..."
	///The camera itself.
	var/obj/machinery/camera/builtin_bodycamera
	var/list/cameranetwork = list("ss13")

/obj/item/bodycam/examine_more(mob/user)
	. = ..()
	. += list(span_notice("Use [src] on any under clothing item to quickly install it."))
	. += list(span_notice("Use a [span_bold("screwdriver")] to remove it."))
	. += list(span_notice("While equipped, use your ID card on the vest to activate/deactivate the camera."))
	. += list(span_notice("Unequipping the clothing item will immediately deactivate the camera."))

/obj/item/bodycam/AltClick(mob/user)
	. = ..()


/obj/item/bodycam/Destroy()
	if(builtin_bodycamera)
		turn_off()
	return ..()

/obj/item/bodycam/proc/is_on()
	if(isnull(builtin_bodycamera))
		return FALSE
	return TRUE

/obj/item/bodycam/proc/turn_on(mob/user, obj/item/card/id/id_card)
	builtin_bodycamera = new(user)
	builtin_bodycamera.internal_light = FALSE
	builtin_bodycamera.network = cameranetwork
	builtin_bodycamera.c_tag = "-Body Camera: [(id_card.registered_name)] ([id_card.assignment])"
	playsound(loc, 'sound/machines/beep.ogg', get_clamped_volume(), TRUE, -1)
	if(user)
		user.balloon_alert(user, "bodycamera activated")

/obj/item/bodycam/proc/turn_off(mob/user)
	if(user)
		user.balloon_alert(user, "bodycamera deactivated")
	playsound(loc, 'sound/machines/beep.ogg', get_clamped_volume(), TRUE, -1)
	QDEL_NULL(builtin_bodycamera)


/**
 * Bodycamera component
 *
 * Allows anything to have a body camera inserted into it
 */
/datum/component/bodycamera_holder
	///The installed bodycamera
	var/obj/item/bodycam/bodycamera_installed
	///The clothing part this needs to be on. This could possibly just be done by checking the clothing's slot
	var/clothingtype_required = ITEM_SLOT_OCLOTHING

/datum/component/bodycamera_holder/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE_MORE, PROC_REF(on_examine_more))
	RegisterSignal(parent, COMSIG_ATOM_SCREWDRIVER_ACT, PROC_REF(on_screwdriver_act))

/datum/component/bodycamera_holder/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_SCREWDRIVER_ACT)
	UnregisterSignal(parent, COMSIG_PARENT_ATTACKBY)
	UnregisterSignal(parent, COMSIG_PARENT_EXAMINE)
	QDEL_NULL(bodycamera_installed)
	return ..()

/datum/component/bodycamera_holder/proc/turn_camera_on(mob/living/user, obj/item/card)
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_unequip))
	bodycamera_installed.turn_on(user, card)

/datum/component/bodycamera_holder/proc/turn_camera_off(mob/living/user)
	UnregisterSignal(parent, COMSIG_ITEM_DROPPED)
	bodycamera_installed.turn_off(user)

/// When the camera holder is unequipped
/datum/component/bodycamera_holder/proc/on_unequip(mob/living/source, force, atom/newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER
	turn_camera_off()

/// When examining
/datum/component/bodycamera_holder/proc/on_examine_more(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(bodycamera_installed)
		examine_list += span_notice("It has [bodycamera_installed] installed.")
	else
		examine_list += span_notice("It has a spot to hook up a body camera onto.")

/// When items are used on it. Bodycamera/ID card
/datum/component/bodycamera_holder/proc/on_attackby(datum/source, obj/item/item, mob/living/user)
	SIGNAL_HANDLER

	if(istype(item, /obj/item/bodycam))
		if(bodycamera_installed)
			user.balloon_alert(user, "camera already installed!")
			playsound(source, 'sound/machines/buzz-two.ogg', item.get_clamped_volume(), TRUE, -1)
		else
			item.forceMove(source)
			bodycamera_installed = item
			playsound(source, 'sound/items/screwdriver.ogg', item.get_clamped_volume(), TRUE, -1)
		return

	if(!bodycamera_installed)
		return

	var/obj/item/card/id/card = item.GetID()
	if(!card)
		return

	if(source != user.get_item_by_slot(ITEM_SLOT_ICLOTHING))
		user.balloon_alert(user, "must be wearing item!")
		return

	//Do we have a camera on or off?
	if(bodycamera_installed.is_on())
		turn_camera_off(user)
	else
		turn_camera_on(user, card)

/// When a screwdriver is used on it
/datum/component/bodycamera_holder/proc/on_screwdriver_act(atom/source, mob/user, obj/item/tool)
	SIGNAL_HANDLER

	if(!bodycamera_installed)
		return
	if(bodycamera_installed.is_on())
		turn_camera_off(user)
	playsound(source, 'sound/items/screwdriver.ogg', tool.get_clamped_volume(), TRUE, -1)
	bodycamera_installed.forceMove(user.loc)
	INVOKE_ASYNC(user, TYPE_PROC_REF(/mob, put_in_hands), bodycamera_installed)
	bodycamera_installed = null
