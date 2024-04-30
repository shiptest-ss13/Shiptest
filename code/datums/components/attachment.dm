/datum/component/attachment
	var/slot
	var/has_toggle
	var/list/valid_parent_types
	var/datum/callback/on_attach
	var/datum/callback/on_detach
	var/datum/callback/on_toggle
	var/datum/callback/on_preattack
	var/list/datum/action/actions

/datum/component/attachment/Initialize(
		slot = ATTACHMENT_SLOT_RAIL,
		has_toggle = FALSE,
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
	src.has_toggle = has_toggle
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
	if(has_toggle)
		RegisterSignal(parent, COMSIG_ATTACHMENT_TOGGLE, PROC_REF(try_toggle))
	RegisterSignal(parent, COMSIG_ATTACHMENT_PRE_ATTACK, PROC_REF(relay_pre_attack))
	RegisterSignal(parent, COMSIG_ATTACHMENT_UPDATE_OVERLAY, PROC_REF(update_overlays))
	RegisterSignal(parent, COMSIG_ATTACHMENT_GET_SLOT, PROC_REF(send_slot))

	for(var/signal in signals)
		RegisterSignal(parent, signal, signals[signal])

	var/datum/action/attachment_action = new /datum/action/attachment(parent)
	actions += attachment_action

/datum/component/attachment/Destroy(force, silent)
	REMOVE_TRAIT(parent, TRAIT_ATTACHABLE, "attachable")
	if(actions && length(actions))
		var/obj/item/gun/parent = src.parent
		parent.actions -= actions
		QDEL_LIST(actions)
	return ..()

/datum/component/attachment/proc/try_toggle(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(do_toggle), parent, holder, user)


/datum/component/attachment/proc/do_toggle(obj/item/parent, obj/item/holder, mob/user)
	if(on_toggle)
		on_toggle.Invoke( holder, user)
		return TRUE

	parent.attack_self(user)
	return TRUE

/datum/component/attachment/proc/update_overlays(obj/item/parent, list/overlays, list/offset)
	overlays += mutable_appearance(parent.icon, "[parent.icon_state]-attached")

/datum/component/attachment/proc/try_attach(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER

	if(!parent.Adjacent(user) || (length(valid_parent_types) && (holder.type in valid_parent_types)))
		return FALSE

	if(on_attach && !on_attach.Invoke(holder, user))
		return FALSE

	parent.forceMove(holder)
	if(length(actions))
		holder.actions += actions

	return TRUE

/datum/component/attachment/proc/try_detach(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER

	if(!parent.Adjacent(user) || (valid_parent_types && (holder.type in valid_parent_types)))
		return FALSE

	if(on_attach && !on_detach.Invoke(holder, user))
		return FALSE

	if(length(actions))
		holder.actions -= actions

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
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS
	button_icon_state = null

/datum/action/attachment/New(target)
	name = target.name
