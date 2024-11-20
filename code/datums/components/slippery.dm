/datum/component/slippery
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	var/force_drop_items = FALSE
	var/knockdown_time = 0
	var/paralyze_time = 0
	var/lube_flags
	var/datum/callback/callback

	var/mob/living/holder
	var/list/slot_whitelist = list(ITEM_SLOT_OCLOTHING, ITEM_SLOT_ICLOTHING, ITEM_SLOT_GLOVES, ITEM_SLOT_FEET, ITEM_SLOT_HEAD, ITEM_SLOT_MASK, ITEM_SLOT_BELT, ITEM_SLOT_NECK)

	///what we give to connect_loc by default, makes slippable mobs moving over us slip
	var/static/list/default_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(Slip),
	)

	///what we give to connect_loc if we're an item and get equipped by a mob. makes slippable mobs moving over our holder slip
	var/static/list/holder_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(Slip_on_wearer),
	)

	/// The connect_loc_behalf component for the holder_connections list.
	var/datum/weakref/holder_connect_loc_behalf

/datum/component/slippery/Initialize(_knockdown, _lube_flags = NONE, datum/callback/_callback, _paralyze, _force_drop = FALSE)
	knockdown_time = max(_knockdown, 0)
	paralyze_time = max(_paralyze, 0)
	force_drop_items = _force_drop
	lube_flags = _lube_flags
	callback = _callback
	add_connect_loc_behalf_to_parent()

	if(ismovable(parent))
		if(isitem(parent))
			RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
			RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	else
		RegisterSignal(parent, COMSIG_ATOM_ENTERED, PROC_REF(Slip))

/datum/component/slippery/proc/add_connect_loc_behalf_to_parent()
	if(ismovable(parent))
		AddComponent(/datum/component/connect_loc_behalf, parent, default_connections)

/datum/component/slippery/InheritComponent(datum/component/slippery/component, i_am_original, knockdown, lube_flags = NONE, datum/callback/callback, paralyze, force_drop = FALSE, slot_whitelist)
	if(component)
		knockdown = component.knockdown_time
		lube_flags = component.lube_flags
		callback = component.callback
		paralyze = component.paralyze_time
		force_drop = component.force_drop_items
		slot_whitelist = component.slot_whitelist

	src.knockdown_time = max(knockdown, 0)
	src.paralyze_time = max(paralyze, 0)
	src.force_drop_items = force_drop
	src.lube_flags = lube_flags
	src.callback = callback
	if(slot_whitelist)
		src.slot_whitelist = slot_whitelist

/datum/component/slippery/proc/Slip(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER
	if(!isliving(arrived))
		return
	var/mob/living/victim = arrived
	if(!(victim.movement_type & FLYING) && victim.slip(knockdown_time, parent, lube_flags, paralyze_time, force_drop_items) && callback)
		callback.Invoke(victim)

/datum/component/slippery/proc/on_equip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if((!LAZYLEN(slot_whitelist) || (slot in slot_whitelist)) && isliving(equipper))
		holder = equipper
		qdel(GetComponent(/datum/component/connect_loc_behalf))
		AddComponent(/datum/component/connect_loc_behalf, holder, holder_connections)
		RegisterSignal(holder, COMSIG_PARENT_PREQDELETED, PROC_REF(holder_deleted))

/datum/component/slippery/proc/holder_deleted(datum/source, datum/possible_holder)
	SIGNAL_HANDLER

	if(possible_holder == holder)
		holder = null

/datum/component/slippery/proc/on_drop(datum/source, mob/user)
	SIGNAL_HANDLER

	UnregisterSignal(user, COMSIG_PARENT_PREQDELETED)

	qdel(GetComponent(/datum/component/connect_loc_behalf))
	add_connect_loc_behalf_to_parent()

	holder = null

/datum/component/slippery/proc/Slip_on_wearer(datum/source, atom/movable/arrived)
	SIGNAL_HANDLER
