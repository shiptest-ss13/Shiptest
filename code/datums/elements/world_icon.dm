/////////////////////////////////////////////////////////////
////////// WORLD ICON ELEMENT DIRECTORY //////////
/////////////////////////////////////////////////////////////
//PORTED FROM MOJAVE SUN//

// Slap onto something to give it a world icon that differs from the inventory one (allows for realistically sized objects and all that) //
// To fix 25/06/2021 : Blood Decals, Mutable Overlays and other baked in bitch ass overlays that need to be remade when the icon changes //
// Fixed 07/05/2022: Now you can deal with the above by handling everything with attached_proc instead
// Fixed 12/04/2023: Icon states, Needs major tuning up by someone who can properly make it work

/datum/element/world_icon
	argument_hash_start_idx = 2
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	//If we want COMPLEX world icon behavior, this proc will handle icon updating when the item is NOT in the inventory.
	//I just assumed that the default update_icon is for inventory sprites because ss13 basically focuses on how the sprites
	//look on your hand, not how they realistically look in the world.
	var/attached_proc
	/// Only used if attached_proc doesn't exist, simply changes the icon of target to this when it's in the inventory
	var/inventory_icon
	/// Only used if attached_proc doesn't exist, simply changes the icon of target to this when it's NOT in the inventory
	var/world_icon
	/// Only used when inventory state icon is different from original
	var/inventory_icon_state
	/// Only used when world state icon is different from original, pretty much just the original "icon_state" but if you for some reason need to flip the standard icon states for this element around you can use this
	var/world_icon_state

/datum/element/world_icon/Attach(obj/item/target, attached_proc, world_icon, inventory_icon, world_icon_state, inventory_icon_state)
	. = ..()
	if(!istype(target))
		return ELEMENT_INCOMPATIBLE

	src.attached_proc = attached_proc
	src.world_icon = world_icon
	src.world_icon_state = world_icon_state
	src.inventory_icon = inventory_icon
	src.inventory_icon_state = inventory_icon_state
	RegisterSignal(target, COMSIG_ATOM_UPDATE_ICON, PROC_REF(update_icon))
	RegisterSignal(target, COMSIG_ATOM_UPDATE_ICON_STATE, PROC_REF(update_icon_state))
	RegisterSignals(target, list(COMSIG_ITEM_EQUIPPED, COMSIG_STORAGE_ENTERED, COMSIG_ITEM_DROPPED, COMSIG_STORAGE_EXITED), PROC_REF(inventory_updated))
	target.update_appearance(UPDATE_ICON)
	target.update_appearance(UPDATE_ICON_STATE)

/datum/element/world_icon/Detach(obj/item/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_UPDATE_ICON)
	UnregisterSignal(source, COMSIG_ATOM_UPDATE_ICON_STATE, PROC_REF(update_icon_state))
	UnregisterSignal(source, list(COMSIG_ITEM_EQUIPPED, COMSIG_STORAGE_ENTERED, COMSIG_ITEM_DROPPED, COMSIG_STORAGE_EXITED))
	source.update_appearance(UPDATE_ICON)
	source.update_appearance(UPDATE_ICON_STATE)

/datum/element/world_icon/proc/update_icon(obj/item/source, updates)
	SIGNAL_HANDLER

	if((source.item_flags & IN_INVENTORY) || (source.loc && SEND_SIGNAL(source.loc, COMSIG_CONTAINS_STORAGE)))
		if(attached_proc)
			return
		return default_inventory_icon(source)

	if(attached_proc)
		return call(source, attached_proc)(updates)
	else
		return default_world_icon(source)

/datum/element/world_icon/proc/update_icon_state(obj/item/source, updates)
	SIGNAL_HANDLER

	if((source.item_flags & IN_INVENTORY) || (source.loc && SEND_SIGNAL(source.loc, COMSIG_CONTAINS_STORAGE)))
		if(attached_proc)
			return
		return default_inventory_icon_state(source)

	if(attached_proc)
		return call(source, attached_proc)(updates)
	else
		return default_world_icon_state(source)

/datum/element/world_icon/proc/inventory_updated(obj/item/source)
	SIGNAL_HANDLER

	source.update_appearance(UPDATE_ICON)
	source.update_appearance(UPDATE_ICON_STATE)

/datum/element/world_icon/proc/default_inventory_icon(obj/item/source)
	SIGNAL_HANDLER

	source.icon = inventory_icon

/datum/element/world_icon/proc/default_world_icon(obj/item/source)
	SIGNAL_HANDLER

	source.icon = world_icon

/datum/element/world_icon/proc/default_inventory_icon_state(obj/item/source)
	SIGNAL_HANDLER

	if(!inventory_icon_state)
		source.icon_state = source.icon_state
		return

	INVOKE_ASYNC(src, PROC_REF(check_inventory_state), source)

/datum/element/world_icon/proc/default_world_icon_state(obj/item/source)
	SIGNAL_HANDLER

	if(!world_icon_state)
		source.icon_state = source.item_state
		return

	INVOKE_ASYNC(src, PROC_REF(check_world_icon_state), source)

/datum/element/world_icon/proc/check_inventory_state(obj/item/source)
	SIGNAL_HANDLER

	inventory_icon_state = source.inventory_state
	source.icon_state = inventory_icon_state

/datum/element/world_icon/proc/check_world_icon_state(obj/item/source)
	SIGNAL_HANDLER

	world_icon_state = source.world_state
	source.icon_state = world_icon_state
