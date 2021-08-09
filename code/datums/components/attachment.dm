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

/datum/component/attachment
	var/slot
	var/list/valid_parent_types
	var/datum/callback/on_attach
	var/datum/callback/on_detach
	var/datum/callback/on_toggle
	var/mutable_appearance/attachment_overlay
	var/list/datum/action/actions

/datum/component/attachment/Initialize(
		slot = ATTACHMENT_SLOT_RAIL,
		mutable_appearance/attachment_overlay = null,
		valid_parent_types = list(/obj/item/gun),
		datum/callback/on_attach = null,
		datum/callback/on_detach = null,
		datum/callback/on_toggle = null,
		list/signals = null,
	)

	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.slot = slot
	src.attachment_overlay = attachment_overlay
	src.valid_parent_types = valid_parent_types
	src.on_attach = on_attach
	src.on_detach = on_detach
	src.on_toggle = on_toggle

	ADD_TRAIT(parent, TRAIT_ATTACHABLE, src)
	RegisterSignal(parent, COMSIG_ATTACHMENT_ATTACH, .proc/try_attach)
	RegisterSignal(parent, COMSIG_ATTACHMENT_DETACH, .proc/try_detach)
	RegisterSignal(parent, COMSIG_ATTACHMENT_TOGGLE, .proc/try_toggle)

	if(attachment_overlay)
		RegisterSignal(parent, COMSIG_ATTACHMENT_UPDATE_OVERLAY, .proc/update_overlays)

	for(var/signal in signals)
		RegisterSignal(parent, signal, signals[signal])

/datum/component/attachment/Destroy(force, silent)
	REMOVE_TRAIT(parent, TRAIT_ATTACHABLE, src)
	if(actions && length(actions))
		var/obj/item/gun/parent = src.parent
		parent.actions -= actions
		QDEL_LIST(actions)
	return ..()

/datum/component/attachment/proc/try_toggle(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER

	CallAsync(src, .proc/do_toggle)


/datum/component/attachment/proc/do_toggle(obj/item/parent, obj/item/holder, mob/user)
	if(on_toggle)
		on_toggle.Invoke(parent, holder, user)
		return TRUE

	parent.attack_self(user)
	return TRUE

/datum/component/attachment/proc/update_overlays(obj/item/parent, list/overlays, list/offset)
	overlays += attachment_overlay

/datum/component/attachment/proc/try_attach(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER

	if(!parent.Adjacent(user) || (length(valid_parent_types) && (holder.type in valid_parent_types)))
		return FALSE

	if(on_attach && !on_attach.Invoke(parent, holder, user))
		return FALSE

	parent.forceMove(holder)
	return TRUE

/datum/component/attachment/proc/try_detach(obj/item/parent, obj/item/holder, mob/user)
	SIGNAL_HANDLER

	if(!parent.Adjacent(user) || (valid_parent_types && (holder.type in valid_parent_types)))
		return FALSE

	if(on_attach && !on_detach.Invoke(parent, holder, user))
		return FALSE

	if(user.can_put_in_hand(parent))
		user.put_in_hand(parent)
		return TRUE

	parent.forceMove(holder.drop_location())
	return TRUE
