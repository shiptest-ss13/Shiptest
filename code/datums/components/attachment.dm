/datum/component/attachment
	///Slot the attachment goes on, also used in descriptions so should be player readable
	var/slot
	///various yes no flags associated with attachments. See defines for these: [_DEFINES/guns.dm]
	var/attach_features_flags
	///Unused so far, should probally handle it in the parent unless you have a specific reason
	var/list/valid_parent_types
	var/datum/callback/on_attach
	var/datum/callback/on_detach
	var/datum/callback/on_toggle
	///Called on the parents preattack
	var/datum/callback/on_preattack
	///Unused...Also a little broken..
	var/list/datum/action/actions
	///Generated if the attachment can toggle, sends COMSIG_ATTACHMENT_TOGGLE
	var/datum/action/attachment/attachment_toggle_action

/datum/component/attachment/Initialize(
		slot = ATTACHMENT_SLOT_RAIL,
		attach_features_flags = ATTACH_REMOVABLE_HAND,
		valid_parent_types = list(/obj/item/gun),
		datum/callback/on_attach = null,
		datum/callback/on_detach = null,
		datum/callback/on_toggle = null,
		datum/callback/on_preattack = null,
		list/signals = null
	)

	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.slot = slot
	src.attach_features_flags = attach_features_flags
	src.valid_parent_types = valid_parent_types
	src.on_attach = on_attach
	src.on_detach = on_detach
	src.on_toggle = on_toggle
	src.on_preattack = on_preattack

	ADD_TRAIT(parent, TRAIT_ATTACHABLE, "attachable")
	RegisterSignal(parent, COMSIG_ATTACHMENT_ATTACH, PROC_REF(try_attach))
	RegisterSignal(parent, COMSIG_ATTACHMENT_DETACH, PROC_REF(try_detach))
	RegisterSignal(parent, COMSIG_ATTACHMENT_EXAMINE, PROC_REF(handle_examine))
	RegisterSignal(parent, COMSIG_ATTACHMENT_EXAMINE_MORE, PROC_REF(handle_examine_more))
	if(attach_features_flags & ATTACH_TOGGLE)
		RegisterSignal(parent, COMSIG_ATTACHMENT_TOGGLE, PROC_REF(try_toggle))
		attachment_toggle_action = new /datum/action/attachment(parent)
	RegisterSignal(parent, COMSIG_ATTACHMENT_PRE_ATTACK, PROC_REF(relay_pre_attack))
	RegisterSignal(parent, COMSIG_ATTACHMENT_UPDATE_OVERLAY, PROC_REF(update_overlays))
	RegisterSignal(parent, COMSIG_ATTACHMENT_GET_SLOT, PROC_REF(send_slot))

	for(var/signal in signals)
		RegisterSignal(parent, signal, signals[signal])

/datum/component/attachment/Destroy(force)
	REMOVE_TRAIT(parent, TRAIT_ATTACHABLE, "attachable")
	if(actions && length(actions))
		var/obj/item/gun/parent = src.parent
		parent.actions -= actions
		QDEL_LIST(actions)
	qdel(attachment_toggle_action)
	return ..()

/datum/component/attachment/proc/try_toggle(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER
	if(attach_features_flags & ATTACH_TOGGLE)
		INVOKE_ASYNC(src, PROC_REF(do_toggle), parent, holder, user)
		holder.update_icon()
		attachment_toggle_action.UpdateButtonIcon()

/datum/component/attachment/proc/do_toggle(obj/item/parent, obj/item/holder, mob/user)
	if(on_toggle)
		on_toggle.Invoke(holder, user)
		return TRUE

	parent.attack_self(user)
	return TRUE

/datum/component/attachment/proc/update_overlays(obj/item/parent, list/overlays, list/offset)
	if(!(attach_features_flags & ATTACH_NO_SPRITE))
		overlays += mutable_appearance(parent.icon, "[parent.icon_state]-attached")

/datum/component/attachment/proc/try_attach(obj/item/parent, obj/item/holder, mob/user, bypass_checks)
	SIGNAL_HANDLER

	if(!bypass_checks)
		if(!parent.Adjacent(user) || (length(valid_parent_types) && (holder.type in valid_parent_types)))
			return FALSE

	if(on_attach && !on_attach.Invoke(holder, user))
		return FALSE

	parent.forceMove(holder)

	if(attach_features_flags & ATTACH_TOGGLE)
		holder.actions += list(attachment_toggle_action)
		attachment_toggle_action.gun = holder
		attachment_toggle_action.Grant(user)

	return TRUE

/datum/component/attachment/proc/try_detach(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER

	if(!parent.Adjacent(user) || (valid_parent_types && (holder.type in valid_parent_types)))
		return FALSE

	if(on_attach && !on_detach.Invoke(holder, user))
		return FALSE

	if(attach_features_flags & ATTACH_TOGGLE)
		holder.actions -= list(attachment_toggle_action)
		attachment_toggle_action.gun = null
		attachment_toggle_action.Remove(user)

	if(user.can_put_in_hand(parent))
		user.put_in_hand(parent)
		return TRUE

	parent.forceMove(holder.drop_location())
	return TRUE

/datum/component/attachment/proc/handle_examine(obj/item/parent, mob/user, list/examine_list)
	SIGNAL_HANDLER

/datum/component/attachment/proc/handle_examine_more(obj/item/parent, mob/user, list/examine_list)
	SIGNAL_HANDLER

/datum/component/attachment/proc/relay_pre_attack(obj/item/parent, obj/item/gun, atom/target_atom, mob/user, params)
	SIGNAL_HANDLER_DOES_SLEEP

	if(on_preattack)
		return on_preattack.Invoke(gun, target_atom, user, params)

/datum/component/attachment/proc/send_slot(obj/item/parent)
	SIGNAL_HANDLER
	return attachment_slot_to_bflag(slot)

/datum/action/attachment
	name = "Toggle Attachment"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS
	button_icon_state = null
	///Decides where we send our toggle signal for when pressed
	var/obj/item/gun/gun = null

/datum/action/attachment/New(Target)
	..()
	name = "Toggle [target.name]"
	button.name = name
	icon_icon = target.icon
	button_icon_state = target.icon_state

/datum/action/attachment/Destroy()
	. = ..()
	gun = null

/datum/action/attachment/Trigger()
	..()
	SEND_SIGNAL(target, COMSIG_ATTACHMENT_TOGGLE, gun, owner)

/datum/action/attachment/UpdateButtonIcon()
	icon_icon = target.icon
	button_icon_state = target.icon_state
	..()

//Copied from item action..
/datum/action/attachment/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force)
	if(button_icon && button_icon_state)
		// If set, use the custom icon that we set instead
		// of the item appearence
		..()
	else if((target && current_button.appearance_cache != target.appearance) || force) //replace with /ref comparison if this is not valid.
		var/obj/item/I = target
		var/old_layer = I.layer
		var/old_plane = I.plane
		I.layer = FLOAT_LAYER //AAAH
		I.plane = FLOAT_PLANE //^ what that guy said
		current_button.cut_overlays()
		current_button.add_overlay(I)
		I.layer = old_layer
		I.plane = old_plane
		current_button.appearance_cache = I.appearance
