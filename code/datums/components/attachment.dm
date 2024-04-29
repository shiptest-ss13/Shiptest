#define COMSIG_ATTACHMENT_ATTACH "attach-attach"
#define COMSIG_ATTACHMENT_DETACH "attach-detach"
#define COMSIG_ATTACHMENT_EXAMINE "attach-examine"
#define COMSIG_ATTACHMENT_EXAMINE_MORE "attach-examine-more"
#define COMSIG_ATTACHMENT_PRE_ATTACK "attach-pre-attack"
#define COMSIG_ATTACHMENT_ATTACK "attach-attacked"
#define COMSIG_ATTACHMENT_UPDATE_OVERLAY "attach-overlay"

#define COMSIG_ATTACHMENT_GET_SLOT "attach-slot-who"
#define ATTACHMENT_SLOT_MUZZLE "attach-slot-muzzle"
#define ATTACHMENT_SLOT_SCOPE "attach-slot-scope"
#define ATTACHMENT_SLOT_GRIP "attach-slot-grip"
#define ATTACHMENT_SLOT_RAIL "attach-slot-rail"

#define COMSIG_ATTACHMENT_TOGGLE "attach-toggle"

#define TRAIT_ATTACHABLE "attachable"

#define ATTACHMENT_DEFAULT_SLOT_AVAILABLE list( \
	ATTACHMENT_SLOT_MUZZLE = 1, \
	ATTACHMENT_SLOT_SCOPE = 1, \
	ATTACHMENT_SLOT_GRIP = 1, \
	ATTACHMENT_SLOT_RAIL = 1, \
)

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
	if(has_toggle)
		RegisterSignal(parent, COMSIG_ATTACHMENT_TOGGLE, PROC_REF(try_toggle))
	RegisterSignal(parent, COMSIG_ATTACHMENT_PRE_ATTACK, PROC_REF(relay_pre_attack))
	RegisterSignal(parent, COMSIG_ATTACHMENT_UPDATE_OVERLAY, PROC_REF(update_overlays))
	RegisterSignal(parent, COMSIG_ATTACHMENT_GET_SLOT, PROC_REF(send_slot))

	for(var/signal in signals)
		RegisterSignal(parent, signal, signals[signal])

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
	return TRUE

/datum/component/attachment/proc/try_detach(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER

	if(!parent.Adjacent(user) || (valid_parent_types && (holder.type in valid_parent_types)))
		return FALSE

	if(on_attach && !on_detach.Invoke(holder, user))
		return FALSE

	if(user.can_put_in_hand(parent))
		user.put_in_hand(parent)
		return TRUE

	parent.forceMove(holder.drop_location())
	return TRUE

/datum/component/attachment/proc/relay_pre_attack(obj/item/parent, obj/item/gun, atom/target_atom, mob/user, params)
	SIGNAL_HANDLER_DOES_SLEEP

	if(on_preattack)
		return on_preattack.Invoke(gun, target_atom, user, params)

/datum/component/attachment/proc/send_slot(obj/item/parent)
	SIGNAL_HANDLER
	return slot
