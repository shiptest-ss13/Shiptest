#define CONTROL_LOSS_TRAIT "control_loss"

/obj/item/organ/brain/remote_control
	name = "Remote Uplink Positronic Frame Controller"
	desc = "A remote controller for humanoid robotic frames. It can be linked to a stationary mainframe unit."
	icon = 'icons/obj/module.dmi'
	icon_state = "boris"
	organ_flags = ORGAN_SYNTHETIC | ORGAN_PERSISTENT
	status = ORGAN_ROBOTIC
	zone = BODY_ZONE_CHEST
	actions_types = list(/datum/action/item_action/organ_action/undeploy_frame)
	/// A weakref containing the AI linked to this remote controller.
	var/datum/weakref/linked_ai_ref
	/// The action granted to the linked AI that deploys it to this frame.
	var/datum/action/innate/deploy_frame/deploy_action

/obj/item/organ/brain/remote_control/Initialize()
	. = ..()
	deploy_action = new(src)

/obj/item/organ/brain/remote_control/Destroy()
	. = ..()
	QDEL_NULL(deploy_action)

/obj/item/organ/brain/remote_control/examine(mob/user)
	. = ..()
	var/mob/living/silicon/ai/our_ai = linked_ai_ref?.resolve()
	if(our_ai)
		. += span_notice("It is linked to [our_ai].")
	else
		. += span_notice("It is not linked to an AI!")

/obj/item/organ/brain/remote_control/Insert(mob/living/carbon/new_owner, special, drop_if_replaced = TRUE, no_id_transfer = FALSE)
	. = ..()
	var/mob/living/silicon/ai/linked_ai = linked_ai_ref?.resolve()
	if(linked_ai)
		link_frame(new_owner, linked_ai)
	update_control_status()

/obj/item/organ/brain/remote_control/Remove(mob/living/carbon/old_owner, special, no_id_transfer)
	var/mob/living/silicon/ai/linked_ai = linked_ai_ref?.resolve()
	if(linked_ai)
		unlink_frame(old_owner, linked_ai)
	update_control_status(TRUE)
	return ..()

/obj/item/organ/brain/remote_control/multitool_act(mob/living/user, obj/item/multitool/tool, list/modifiers)
	. = ..()
	if(. & COMPONENT_BLOCK_TOOL_ATTACK)
		return
	if(!multitool_check_buffer(user, tool))
		return
	if(isAI(tool.buffer))
		set_linked_ai(tool.buffer)
		balloon_alert(user, "linked to [tool.buffer]")
	else
		balloon_alert(user, "no linked AI!")
	return COMPONENT_BLOCK_TOOL_ATTACK

/// Returns the linked AI, if it exists.
/obj/item/organ/brain/remote_control/proc/get_linked_ai()
	RETURN_TYPE(/mob/living/silicon/ai)
	return linked_ai_ref?.resolve()

/// Sets the linked AI to a new AI, or removes an existing one if the argument is null.
/obj/item/organ/brain/remote_control/proc/set_linked_ai(mob/living/silicon/ai/new_ai)
	var/mob/living/silicon/ai/old_ai = linked_ai_ref?.resolve()
	if(old_ai)
		if(owner)
			unlink_frame(owner, old_ai)
		UnregisterSignal(new_ai, list(COMSIG_QDELETING, COMSIG_AI_DECONSTRUCT_CORE))
	linked_ai_ref = null
	if(new_ai)
		linked_ai_ref = WEAKREF(new_ai)
		if(owner)
			link_frame(owner, new_ai)
		RegisterSignals(new_ai, list(COMSIG_QDELETING, COMSIG_AI_DECONSTRUCT_CORE), PROC_REF(handle_core_loss))
	update_control_status()

/// Handles the linked AI being deconstructed or deleted.
/obj/item/organ/brain/remote_control/proc/handle_core_loss(mob/living/silicon/ai/source)
	SIGNAL_HANDLER
	if(owner)
		to_chat(owner, span_userdanger("ERROR: Lost connection with core!"))
		if(QDELETED(source))
			owner.ghostize()
		else
			undeploy_from_frame(owner, source)
	set_linked_ai(null)

/// This updates whether the frame should be incapacitated by losing its linked core. Roger Roger.
/obj/item/organ/brain/remote_control/proc/update_control_status(removing = FALSE)
	if(!owner)
		return
	if(!removing && !linked_ai_ref?.resolve())
		ADD_TRAIT(owner, TRAIT_INCAPACITATED, CONTROL_LOSS_TRAIT)
		ADD_TRAIT(owner, TRAIT_IMMOBILIZED, CONTROL_LOSS_TRAIT)
		ADD_TRAIT(owner, TRAIT_FLOORED, CONTROL_LOSS_TRAIT)
	else
		REMOVE_TRAIT(owner, TRAIT_INCAPACITATED, CONTROL_LOSS_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, CONTROL_LOSS_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_FLOORED, CONTROL_LOSS_TRAIT)

/obj/item/organ/brain/remote_control/proc/link_frame(mob/living/carbon/frame, mob/living/silicon/ai/core)
	deploy_action.set_frame(frame)
	deploy_action.Grant(core)
	frame.has_unlimited_silicon_privilege = TRUE
	ADD_TRAIT(frame, TRAIT_REMOTE_CONTROL, REF(src))
	ADD_TRAIT(frame, TRAIT_BINARY_RADIO, REF(src))
	RegisterSignal(frame, COMSIG_MOB_DEATH, PROC_REF(on_frame_death))
	RegisterSignal(frame, COMSIG_MOB_HAS_SHIP_ACCESS, PROC_REF(on_ship_access))
	RegisterSignal(frame, COMSIG_MOB_ATTACK_RANGED_SECONDARY, PROC_REF(on_ranged_attack))
	RegisterSignal(frame, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))

/obj/item/organ/brain/remote_control/proc/unlink_frame(mob/living/carbon/frame, mob/living/silicon/ai/core)
	deploy_action.Remove(core)
	deploy_action.set_frame(null)
	frame.has_unlimited_silicon_privilege = frame::has_unlimited_silicon_privilege
	if(frame.mind)
		undeploy_from_frame(frame, core)
	REMOVE_TRAIT(frame, TRAIT_REMOTE_CONTROL, REF(src))
	REMOVE_TRAIT(frame, TRAIT_BINARY_RADIO, REF(src))
	UnregisterSignal(frame, list(COMSIG_MOB_DEATH, COMSIG_MOB_HAS_SHIP_ACCESS, COMSIG_MOB_ATTACK_RANGED_SECONDARY, COMSIG_HUMAN_EARLY_UNARMED_ATTACK))

/obj/item/organ/brain/remote_control/proc/deploy_to_frame(mob/living/carbon/frame, mob/living/silicon/ai/core)
	if(!core.mind)
		return
	if(frame.stat >= HARD_CRIT)
		to_chat(core, span_warning("ERROR: [frame.real_name] is not responding!"))
		return
	if(organ_flags & ORGAN_FAILING)
		to_chat(core, span_warning("ERROR: Remote controller is non-functional!"))
		return
	core.mind.transfer_to(frame)
	core.diag_hud_set_deployed()

/obj/item/organ/brain/remote_control/proc/undeploy_from_frame(mob/living/carbon/frame, mob/living/silicon/ai/core)
	if(!frame.mind)
		return
	frame.mind.transfer_to(core)
	core.diag_hud_set_deployed()

/obj/item/organ/brain/remote_control/proc/on_ship_access(mob/source, datum/overmap/ship/controlled/ship)
	SIGNAL_HANDLER
	var/mob/living/silicon/ai/linked_ai = linked_ai_ref?.resolve()
	if(linked_ai && linked_ai.has_ship_access(ship))
		return ALLOW_SHIP_ACCESS

/obj/item/organ/brain/remote_control/proc/on_ranged_attack(mob/living/carbon/source, atom/target, list/modifiers)
	SIGNAL_HANDLER
	if(target.attack_ai(source))
		return COMPONENT_SECONDARY_CANCEL_ATTACK_CHAIN

/obj/item/organ/brain/remote_control/proc/on_unarmed_attack(mob/living/carbon/source, atom/target, list/modifiers)
	SIGNAL_HANDLER
	if(!LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	if(target.attack_ai(source))
		return COMPONENT_NO_ATTACK_HAND

/obj/item/organ/brain/remote_control/proc/on_frame_death(mob/living/source)
	SIGNAL_HANDLER
	var/mob/living/silicon/ai/linked_ai = linked_ai_ref?.resolve()
	if(!linked_ai)
		source.ghostize()
		return
	to_chat(source, span_userdanger("ERROR: Lost connection with remote frame!"))
	undeploy_from_frame(source, linked_ai)

/datum/action/item_action/organ_action/undeploy_frame
	name = "Disconnect from frame"
	desc = "Stop controlling your remote frame and resume normal core operations."
	icon_icon = 'icons/mob/actions/actions_AI.dmi'
	button_icon_state = "ai_core"
	check_flags = NONE

/datum/action/item_action/organ_action/undeploy_frame/Trigger()
	. = ..()
	var/obj/item/organ/brain/remote_control/controller = target
	var/mob/living/silicon/ai/core = controller.get_linked_ai()
	if(!core)
		CRASH("Action [type] was available to a remote frame with no linked AI!")
	controller.undeploy_from_frame(owner, core)

/datum/action/innate/deploy_frame
	name = "Connect to frame"
	/// The frame linked to this action.
	var/mob/living/carbon/frame
	/// Static list of overlays to copy from the frame onto the button icon.
	var/static/list/overlays_to_copy = list(BODY_BEHIND_LAYER, BODYPARTS_LOW_LAYER, BODYPARTS_LAYER, BODY_ADJ_LAYER, BODY_LAYER, FRONT_MUTATIONS_LAYER, BODYPARTS_HIGH_LAYER, BODY_FRONT_LAYER)

/datum/action/innate/deploy_frame/Destroy()
	frame = null
	return ..()

/datum/action/innate/deploy_frame/proc/set_frame(mob/living/carbon/new_frame)
	frame = new_frame
	if(frame)
		name = "Connect to [frame.real_name]"
	UpdateButtons()

/datum/action/innate/deploy_frame/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force)
	. = ..()
	if(!frame)
		return
	for(var/frame_layer in overlays_to_copy)
		current_button.add_overlay(frame.overlays_standing[frame_layer])

/datum/action/innate/deploy_frame/Trigger()
	var/mob/living/silicon/ai/core = owner
	if(!core)
		return
	if(!frame)
		to_chat(core, span_warning("ERROR: Connection has been lost with this frame."))
		Remove(core)
		CRASH("[type] had no linked frame, while still being usable by [core]!")
	var/obj/item/organ/brain/remote_control/controller = target
	controller.deploy_to_frame(frame, core)

#undef CONTROL_LOSS_TRAIT
