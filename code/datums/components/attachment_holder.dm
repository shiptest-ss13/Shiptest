/datum/component/attachment_holder
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	///List of things you can attach to the parent
	var/list/valid_types = null
	///How many slots a parent can hold of any one slot
	var/list/slot_room = null
	///Icon offsets, should match the sprite itself so just find the position where it should attach
	var/list/slot_offsets = null
	var/list/obj/item/attachments = list()

/datum/component/attachment_holder/Initialize(
	list/slot_room = null,
	list/valid_types = null,
	list/slot_offsets = null,
	list/default_attachments = null
	)

	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE
	var/obj/item/gun/parent_gun = parent

	src.slot_room = slot_room
	src.valid_types = typecacheof(valid_types)
	src.slot_offsets = slot_offsets

	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(handle_attack))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY_SECONDARY, PROC_REF(handle_secondary_attack))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(handle_examine))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(handle_examine_more))
	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(handle_qdel))
	RegisterSignal(parent, COMSIG_GUN_TRY_FIRE, PROC_REF(handle_gun_try_fire))
	RegisterSignal(parent, COMSIG_ITEM_PRE_ATTACK_SECONDARY, PROC_REF(handle_item_pre_attack))
	RegisterSignal(parent, COMSIG_TWOHANDED_WIELD, PROC_REF(handle_item_wield))
	RegisterSignal(parent, COMSIG_TWOHANDED_UNWIELD, PROC_REF(handle_item_unwield))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND_SECONDARY, PROC_REF(handle_hand_attack))
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(handle_ctrl_shift_click))
	RegisterSignal(parent, COMSIG_CLICK_CTRL, PROC_REF(handle_ctrl_click))
	RegisterSignal(parent, COMSIG_CLICK_ALT, PROC_REF(handle_alt_click))
	RegisterSignal(parent, COMSIG_CLICK_SECONDARY_ACTION, PROC_REF(handle_secondary_action))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(handle_overlays))

	if(length(default_attachments))
		for(var/attachment in default_attachments)
			var/obj/item/attachment/new_attachment = new attachment(parent_gun.loc)
			INVOKE_ASYNC(src, PROC_REF(do_attach), new_attachment, null, TRUE)

/datum/component/attachment_holder/proc/handle_overlays(obj/item/parent, list/overlays)
	SIGNAL_HANDLER

	for(var/obj/item/attachment/attach as anything in attachments)
		var/slot = SEND_SIGNAL(attach, COMSIG_ATTACHMENT_GET_SLOT)
		slot = attachment_slot_from_bflag(slot)
		var/list/attach_overlays = list()
		SEND_SIGNAL(attach, COMSIG_ATTACHMENT_UPDATE_OVERLAY, attach_overlays)
		for(var/mutable_appearance/overlay as anything in attach_overlays)
			if(slot_offsets && slot_offsets[slot])
				var/matrix/overlay_matrix = new
				overlay_matrix.Translate(slot_offsets[slot]["x"] - attach.pixel_shift_x, slot_offsets[slot]["y"] - attach.pixel_shift_y)
				overlay.transform = overlay_matrix
			overlays += overlay

/datum/component/attachment_holder/proc/handle_qdel()
	SIGNAL_HANDLER
	qdel(src)

/datum/component/attachment_holder/Destroy(force)
	QDEL_LIST(attachments)
	attachments = null
	return ..()

/datum/component/attachment_holder/proc/attachments_to_list(only_toggles = FALSE)
	. = list()
	for(var/obj/item/attachment/attach as anything in attachments)
		if(attach.name in .)
			stack_trace("two attachments with same name; this shouldn't happen and will cause failures")
			continue
		if(only_toggles && !(attach.attach_features_flags & ATTACH_TOGGLE))
			continue
		.[attach.name] = attach

/datum/component/attachment_holder/proc/handle_ctrl_shift_click(obj/item/parent, mob/user)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(do_attachment_radial), parent, user)

/datum/component/attachment_holder/proc/handle_alt_click(obj/item/parent, mob/user)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(handle_detach), parent, user)
	return TRUE

/datum/component/attachment_holder/proc/handle_ctrl_click(obj/item/parent, mob/user)
	SIGNAL_HANDLER

	for(var/obj/item/attach as anything in attachments)
		if(SEND_SIGNAL(attach, COMSIG_ATTACHMENT_CTRL_CLICK, parent, user))
			return TRUE

/datum/component/attachment_holder/proc/do_attachment_radial(obj/item/parent, mob/user)
	var/list/attachments_as_list = attachments_to_list(TRUE)
	var/selection = show_radial_menu(user, parent, attachments_as_list)
	var/obj/item/attach = attachments_as_list[selection]
	if(!attach)
		return
	SEND_SIGNAL(attach, COMSIG_ATTACHMENT_TOGGLE, parent, user)

/datum/component/attachment_holder/proc/handle_examine(obj/item/parent, mob/user, list/examine_list)
	if(length(attachments))
		examine_list += span_notice("It has [length(attachments)] attachment\s.")
		examine_list += span_notice("You can remove them by pressing alt-click on the [parent] on harm intent.")
	for(var/obj/item/attach as anything in attachments)
		SEND_SIGNAL(attach, COMSIG_ATTACHMENT_EXAMINE, user, examine_list)

/datum/component/attachment_holder/proc/handle_examine_more(obj/item/parent, mob/user, list/examine_list)
	for(var/key in slot_room)
		if(slot_room[key])
			examine_list += span_notice("It has [slot_room[key]] slot\s free for [key] attachments.")
	if(length(attachments))
		examine_list += span_notice("It has the following attachments:")
		for(var/obj/item/attach as anything in attachments)
			examine_list += span_notice("\t- [attach.name]")
	if(length(valid_types))
		examine_list += span_notice("It can accept:")
		for(var/obj/attach_type as anything in valid_types)
			examine_list += span_notice("\t- [initial(attach_type.name)]")
	for(var/obj/item/attach as anything in attachments)
		SEND_SIGNAL(attach, COMSIG_ATTACHMENT_EXAMINE_MORE, user, examine_list)

/datum/component/attachment_holder/proc/do_attach(obj/item/attachment, mob/user, bypass_checks)
	var/slot = SEND_SIGNAL(attachment, COMSIG_ATTACHMENT_GET_SLOT)
	slot = attachment_slot_from_bflag(slot)
	if(!(is_type_in_typecache(attachment,valid_types)))
		to_chat(user, span_notice("[attachment] is not a valid attachment for this [parent]!"))
		return
	if(!slot_room[slot])
		to_chat(user, span_notice("[parent] does not contain room for [attachment]!"))
		return
	slot_room[slot]--
	. = SEND_SIGNAL(attachment, COMSIG_ATTACHMENT_ATTACH, parent, user, bypass_checks)
	if(.)
		attachments += attachment
		var/atom/parent = src.parent
		parent.update_icon()

/datum/component/attachment_holder/proc/do_detach(obj/item/attachment, mob/user)
	var/slot = SEND_SIGNAL(attachment, COMSIG_ATTACHMENT_GET_SLOT)
	slot = attachment_slot_from_bflag(slot)
	. = SEND_SIGNAL(attachment, COMSIG_ATTACHMENT_DETACH, parent, user)
	if(.)
		if(slot in slot_room)
			slot_room[slot]++
		attachments -= attachment
		var/atom/parent = src.parent
		parent.update_icon()

/datum/component/attachment_holder/proc/handle_detach(obj/item/parent,  mob/user, obj/item/tool)
	var/list/tool_list = list()
	var/list/hand_list = list()
	for(var/obj/item/attachment/attach as anything in attachments)
		if(attach.attach_features_flags & ATTACH_REMOVABLE_TOOL)
			tool_list[attach.name] = attach
		if(attach.attach_features_flags & ATTACH_REMOVABLE_HAND)
			hand_list[attach.name] = attach
	if(tool)
		if(!length(tool_list))
			return
		var/selected = tgui_input_list(user, "Select Attachment", "Detach", tool_list)
		if(!parent.Adjacent(user) || !selected || !tool || !tool.use_tool(parent, user, 2 SECONDS * tool.toolspeed))
			return
		if(selected)
			do_detach(tool_list[selected], user)
	else
		if(!length(hand_list))
			return
		var/selected = tgui_input_list(user, "Select Attachment", "Detach", hand_list)
		if(selected)
			if(do_after(user, 2 SECONDS, parent))
				do_detach(hand_list[selected], user)


/datum/component/attachment_holder/proc/handle_attack(obj/item/parent, obj/item/item, mob/user)
	SIGNAL_HANDLER

	if(!user.Adjacent(parent))
		return

	if(item.tool_behaviour == TOOL_CROWBAR && length(attachments))
		INVOKE_ASYNC(src, PROC_REF(handle_detach), parent, user, item)
		return TRUE

	if(HAS_TRAIT(item, TRAIT_ATTACHABLE))
		INVOKE_ASYNC(src, PROC_REF(do_attach), item, user)
		return TRUE

/datum/component/attachment_holder/proc/handle_secondary_attack(obj/item/parent, obj/item/item, mob/user)
	SIGNAL_HANDLER

	for(var/obj/item/attach as anything in attachments)
		if(SEND_SIGNAL(attach, COMSIG_ATTACHMENT_ATTACK, parent, item, user))
			parent.update_icon()
			return TRUE

/datum/component/attachment_holder/proc/handle_gun_try_fire(obj/item/gun/parent_gun, mob/user, atom/target, flag, params)
	SIGNAL_HANDLER

	for(var/obj/item/attach as anything in attachments)
		if(SEND_SIGNAL(attach, COMSIG_ATTACHMENT_TRY_FIRE_GUN, parent_gun, user, target, flag, params))
			return COMPONENT_CANCEL_GUN_FIRE

/datum/component/attachment_holder/proc/handle_item_pre_attack(obj/item/parent, atom/target_atom, mob/user, params)
	SIGNAL_HANDLER

	for(var/obj/item/attach as anything in attachments)
		if(SEND_SIGNAL(attach, COMSIG_ATTACHMENT_PRE_ATTACK, parent, target_atom, user, params))
			return TRUE

/datum/component/attachment_holder/proc/handle_item_wield(obj/item/parent, mob/user, params)
	SIGNAL_HANDLER

	for(var/obj/item/attach as anything in attachments)
		if(SEND_SIGNAL(attach, COMSIG_ATTACHMENT_WIELD , parent, user, params))
			return TRUE

/datum/component/attachment_holder/proc/handle_item_unwield(obj/item/parent, mob/user, params)
	SIGNAL_HANDLER

	for(var/obj/item/attach as anything in attachments)
		if(SEND_SIGNAL(attach, COMSIG_ATTACHMENT_UNWIELD, parent, user, params))
			return TRUE

/datum/component/attachment_holder/proc/handle_hand_attack(obj/item/parent, mob/user, params)
	SIGNAL_HANDLER

	for(var/obj/item/attach as anything in attachments)
		if(SEND_SIGNAL(attach, COMSIG_ATTACHMENT_ATTACK_HAND, parent, user, params))
			return TRUE

/datum/component/attachment_holder/proc/handle_unique_action(obj/item/parent, mob/user, params)
	SIGNAL_HANDLER

	for(var/obj/item/attach as anything in attachments)
		if(SEND_SIGNAL(attach, COMSIG_ATTACHMENT_UNIQUE_ACTION, parent, user, params))
			return TRUE

/datum/component/attachment_holder/proc/handle_secondary_action(obj/item/parent, mob/user, params)
	SIGNAL_HANDLER

	for(var/obj/item/attach as anything in attachments)
		if(SEND_SIGNAL(attach, COMSIG_ATTACHMENT_SECONDARY_ACTION, parent, user, params))
			return TRUE
