#define COLLECT_ONE 0
#define COLLECT_EVERYTHING 1
#define COLLECT_SAME 2

#define DROP_NOTHING 0
#define DROP_AT_PARENT 1
#define DROP_AT_LOCATION 2

// External storage-related logic:
// /mob/proc/ClickOn() in /_onclick/click.dm - clicking items in storages
// /mob/living/Move() in /modules/mob/living/living.dm - hiding storage boxes on mob movement

/datum/component/storage
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/datum/component/storage/concrete/master		//If not null, all actions act on master and this is just an access point.

	var/list/can_hold								//if this is set, only items, and their children, will fit
	var/list/cant_hold								//if this is set, items, and their children, won't fit
	var/list/exception_hold           //if set, these items will be the exception to the max size of object that can fit.
	var/list/can_hold_trait							/// If set can only contain stuff with this single trait present.
	var/list/can_hold_max_of_items 			// if set, storage can only hold up to the set amount of said item.

	var/can_hold_description

	var/list/mob/is_using							//lazy list of mobs looking at the contents of this storage.

	var/locked = FALSE								//when locked nothing can see inside or use it.
	var/locked_flavor = "seems to be locked!"					//prevents tochat messages related to locked from sending

	/// If the storage object can be accessed while equipped to slot by mob(e.g. backpack in back slot)
	var/worn_access = TRUE
	/// If the storage object can be accessed while being held anywhere on a mob
	var/carry_access = TRUE

	/// Storage flags, including what kinds of limiters we use for how many items we can hold
	var/storage_flags = STORAGE_FLAGS_LEGACY_DEFAULT
	/// Max w_class we can hold. Applies to [STORAGE_LIMIT_COMBINED_W_CLASS] and [STORAGE_LIMIT_VOLUME]
	var/max_w_class = WEIGHT_CLASS_SMALL
	/// Max combined w_class. Applies to [STORAGE_LIMIT_COMBINED_W_CLASS]
	var/max_combined_w_class = WEIGHT_CLASS_SMALL * 7
	/// Max items we can hold. Applies to [STORAGE_LIMIT_MAX_ITEMS]
	var/max_items = 7
	/// Max volume we can hold. Applies to [STORAGE_LIMIT_VOLUME]. Auto scaled on New() if unset.
	var/max_volume

	var/emp_shielded = FALSE

	var/silent = FALSE								//whether this makes a message when things are put in.
	var/click_gather = FALSE						//whether this can be clicked on items to pick it up rather than the other way around.
	var/use_sound = "rustle"						//sound to play on interacting.
	var/allow_quick_empty = FALSE					//allow empty verb which allows dumping on the floor of everything inside quickly.
	var/allow_quick_gather = FALSE					//allow toggle mob verb which toggles collecting all items from a tile.

	var/collection_mode = COLLECT_EVERYTHING

	var/insert_preposition = "in"					//you put things "in" a bag, but "on" a tray.

	var/display_numerical_stacking = FALSE			//stack things of the same type and show as a single object with a number.

	/// Ui objects by person. mob = list(objects)
	var/list/ui_by_mob = list()

	var/allow_big_nesting = FALSE					//allow storage objects of the same or greater size.

	var/attack_hand_interact = TRUE					//interact on attack hand.
	var/quickdraw = FALSE							//altclick interact
	///can we quickopen storage when it's in a pocket
	var/pocket_openable = FALSE

	var/datum/action/item_action/storage_gather_mode/modeswitch_action

	//Screen variables: Do not mess with these vars unless you know what you're doing. They're not defines so storage that isn't in the same location can be supported in the future.
	var/screen_max_columns = 7							//These two determine maximum screen sizes.
	var/screen_max_rows = INFINITY
	var/screen_pixel_x = 16								//These two are pixel values for screen loc of boxes and closer
	var/screen_pixel_y = 25
	var/screen_start_x = 4								//These two are where the storage starts being rendered, screen_loc wise.
	var/screen_start_y = 2
	//End

	var/limited_random_access = FALSE					//Quick if statement in accessible_items to determine if we care at all about what people can access at once.
	var/limited_random_access_stack_position = 0					//If >0, can only access top <x> items
	var/limited_random_access_stack_bottom_up = FALSE

/datum/component/storage/Initialize(datum/component/storage/concrete/master)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	if(master)
		change_master(master)

	RegisterSignal(parent, COMSIG_CONTAINS_STORAGE, PROC_REF(on_check))
	RegisterSignal(parent, COMSIG_IS_STORAGE_LOCKED, PROC_REF(check_locked))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_SHOW, PROC_REF(signal_show_attempt))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_INSERT, PROC_REF(signal_insertion_attempt))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_CAN_INSERT, PROC_REF(signal_can_insert))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_TAKE_TYPE, PROC_REF(signal_take_type))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_FILL_TYPE, PROC_REF(signal_fill_type))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_SET_LOCKSTATE, PROC_REF(set_locked))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_TAKE, PROC_REF(signal_take_obj))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_QUICK_EMPTY, PROC_REF(signal_quick_empty))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_HIDE_FROM, PROC_REF(signal_hide_attempt))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_HIDE_ALL, PROC_REF(close_all))
	RegisterSignal(parent, COMSIG_TRY_STORAGE_RETURN_INVENTORY, PROC_REF(signal_return_inv))

	RegisterSignal(parent, COMSIG_TOPIC, PROC_REF(topic_handle))

	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(attackby))

	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_PAW, PROC_REF(on_attack_hand))
	RegisterSignal(parent, COMSIG_ATOM_EMP_ACT, PROC_REF(emp_act))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_GHOST, PROC_REF(show_to_ghost))
	RegisterSignal(parent, COMSIG_ATOM_ENTERED, PROC_REF(refresh_mob_views))
	RegisterSignal(parent, COMSIG_ATOM_EXITED, PROC_REF(_remove_and_refresh))
	RegisterSignal(parent, COMSIG_ATOM_CANREACH, PROC_REF(canreach_react))

	RegisterSignal(parent, COMSIG_ITEM_PRE_ATTACK, PROC_REF(preattack_intercept))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(attack_self))
	RegisterSignal(parent, COMSIG_ITEM_PICKUP, PROC_REF(signal_on_pickup))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(signal_on_equip))

	RegisterSignal(parent, COMSIG_MOVABLE_POST_THROW, PROC_REF(close_all))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))

	RegisterSignals(parent, list(COMSIG_CLICK_ALT, COMSIG_ATOM_ATTACK_HAND_SECONDARY, COMSIG_ITEM_ATTACK_SELF_SECONDARY), PROC_REF(on_open_storage_click))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY_SECONDARY, PROC_REF(on_open_storage_attackby))
	RegisterSignal(parent, COMSIG_MOUSEDROP_ONTO, PROC_REF(mousedrop_onto))
	RegisterSignal(parent, COMSIG_MOUSEDROPPED_ONTO, PROC_REF(mousedrop_receive))

	update_actions()

/datum/component/storage/Destroy()
	close_all()
	wipe_ui_objects()
	LAZYCLEARLIST(is_using)
	return ..()

/datum/component/storage/proc/wipe_ui_objects()
	for(var/i in ui_by_mob)
		var/list/objects = ui_by_mob[i]
		QDEL_LIST(objects)
	ui_by_mob.Cut()

/datum/component/storage/PreTransfer()
	update_actions()

/datum/component/storage/proc/set_holdable(can_hold_list, cant_hold_list)
	can_hold_description = generate_hold_desc(can_hold_list)

	if (can_hold_list != null)
		can_hold = typecacheof(can_hold_list)

	if (cant_hold_list != null)
		cant_hold = typecacheof(cant_hold_list)

/datum/component/storage/proc/generate_hold_desc(can_hold_list)
	var/list/desc = list()

	for(var/valid_type in can_hold_list)
		var/obj/item/valid_item = valid_type
		desc += "\a [initial(valid_item.name)]"

	return "\n\t[span_notice("[desc.Join("\n\t")]")]"

/datum/component/storage/proc/update_actions()
	QDEL_NULL(modeswitch_action)
	if(!isitem(parent) || !allow_quick_gather)
		return
	var/obj/item/I = parent
	modeswitch_action = new(I)
	RegisterSignal(modeswitch_action, COMSIG_ACTION_TRIGGER, PROC_REF(action_trigger))
	if(I.obj_flags & IN_INVENTORY)
		var/mob/M = I.loc
		if(!istype(M))
			return
		modeswitch_action.Grant(M)

/datum/component/storage/proc/change_master(datum/component/storage/concrete/new_master)
	if(new_master == src || (!isnull(new_master) && !istype(new_master)))
		return FALSE
	if(master)
		master.on_slave_unlink(src)
	master = new_master
	if(master)
		master.on_slave_link(src)
	return TRUE

/datum/component/storage/proc/master()
	if(master == src)
		return			//infinite loops yo.
	return master

/datum/component/storage/proc/real_location()
	var/datum/component/storage/concrete/master = master()
	return master? master.real_location() : null

//What players can access
//this proc can probably eat a refactor at some point.
/datum/component/storage/proc/accessible_items(random_access = TRUE)
	var/list/contents = contents()
	if(contents)
		if(limited_random_access && random_access)
			if(limited_random_access_stack_position && (length(contents) > limited_random_access_stack_position))
				if(limited_random_access_stack_bottom_up)
					contents.Cut(1, limited_random_access_stack_position + 1)
				else
					contents.Cut(1, length(contents) - limited_random_access_stack_position + 1)
	return contents

/datum/component/storage/proc/canreach_react(datum/source, list/next)
	SIGNAL_HANDLER

	var/datum/component/storage/concrete/master = master()
	if(!master)
		return
	. = COMPONENT_BLOCK_REACH
	next += master.parent
	for(var/i in master.slaves)
		var/datum/component/storage/slave = i
		next += slave.parent

/datum/component/storage/proc/on_move()
	SIGNAL_HANDLER

	var/atom/A = parent
	for(var/mob/living/L in can_see_contents())
		if(!L.CanReach(A))
			ui_hide(L)

/datum/component/storage/proc/attack_self(datum/source, mob/M)
	SIGNAL_HANDLER

	if(locked)
		to_chat(M, span_warning("[parent] [locked_flavor]"))
		return FALSE
	if((M.get_active_held_item() == parent) && allow_quick_empty)
		INVOKE_ASYNC(src, PROC_REF(quick_empty), M)

/datum/component/storage/proc/preattack_intercept(datum/source, obj/O, mob/M, params)
	SIGNAL_HANDLER

	if(!isitem(O) || !click_gather || SEND_SIGNAL(O, COMSIG_CONTAINS_STORAGE))
		return FALSE
	. = COMPONENT_NO_ATTACK
	if(!access_check(M))
		return FALSE
	if(locked)
		to_chat(M, span_warning("[parent] [locked_flavor]"))
		return FALSE
	var/obj/item/I = O
	if(collection_mode == COLLECT_ONE)
		if(can_be_inserted(I, null, M))
			handle_item_insertion(I, null, M)
		return
	if(!isturf(I.loc))
		return
	INVOKE_ASYNC(src, PROC_REF(async_preattack_intercept), I, M)

///async functionality from preattack_intercept
/datum/component/storage/proc/async_preattack_intercept(obj/item/I, mob/M)
	var/list/things = I.loc.contents.Copy()
	if(collection_mode == COLLECT_SAME)
		things = typecache_filter_list(things, typecacheof(I.type))
	var/len = length(things)
	if(!len)
		to_chat(M, span_warning("You failed to pick up anything with [parent]!"))
		return
	if(!M.CanReach(I, src, TRUE)) // You can't steal things you can't see or reach
		return
	if(I.anchored)
		to_chat(M, span_warning("\The [I] is stuck to the ground and cannot be picked up by [parent]!"))
		return
	var/datum/progressbar/progress = new(M, len, I.loc)
	var/list/rejections = list()
	while(do_after(M, 10, parent, NONE, FALSE, CALLBACK(src, PROC_REF(handle_mass_pickup), things, I.loc, rejections, progress)))
		stoplag(1)
	progress.end_progress()
	to_chat(M, span_notice("You put everything you could [insert_preposition] [parent]."))

/datum/component/storage/proc/handle_mass_item_insertion(list/things, datum/component/storage/src_object, mob/user, datum/progressbar/progress)
	var/atom/source_real_location = src_object.real_location()
	for(var/obj/item/I in things)
		things -= I
		if(I.loc != source_real_location)
			continue
		if(user.active_storage != src_object)
			if(I.on_found(user))
				break
		if(can_be_inserted(I,FALSE,user))
			handle_item_insertion(I, TRUE, user)
		if (TICK_CHECK)
			progress.update(progress.goal - things.len)
			return TRUE

	progress.update(progress.goal - things.len)
	return FALSE

/datum/component/storage/proc/handle_mass_pickup(list/things, atom/thing_loc, list/rejections, datum/progressbar/progress)
	var/atom/real_location = real_location()
	for(var/obj/item/I in things)
		things -= I
		if(I.loc != thing_loc)
			continue
		if(I.type in rejections) // To limit bag spamming: any given type only complains once
			continue
		if(!can_be_inserted(I, stop_messages = TRUE))	// Note can_be_inserted still makes noise when the answer is no
			if(real_location.contents.len >= max_items)
				break
			rejections += I.type	// therefore full bags are still a little spammy
			continue

		handle_item_insertion(I, TRUE)	//The TRUE stops the "You put the [parent] into [S]" insertion message from being displayed.

		if (TICK_CHECK)
			progress.update(progress.goal - things.len)
			return TRUE

	progress.update(progress.goal - things.len)
	return FALSE

/datum/component/storage/proc/quick_empty(mob/M)
	var/atom/A = parent
	if(!M.canUseStorage() || !A.Adjacent(M) || M.incapacitated())
		return
	if(!access_check(M))
		return FALSE
	if(locked)
		to_chat(M, span_warning("[parent] seems to be [locked_flavor]!"))
		return FALSE
	A.add_fingerprint(M)
	to_chat(M, span_notice("You start dumping out [parent]."))
	var/turf/T = get_turf(A)
	var/list/things = contents()
	var/datum/progressbar/progress = new(M, length(things), T)
	while (do_after(M, 1 SECONDS, T, NONE, FALSE, CALLBACK(src, PROC_REF(mass_remove_from_storage), T, things, progress)))
		stoplag(1)
	progress.end_progress()

/datum/component/storage/proc/mass_remove_from_storage(atom/target, list/things, datum/progressbar/progress, trigger_on_found = TRUE)
	var/atom/real_location = real_location()
	for(var/obj/item/I in things)
		things -= I
		if(I.loc != real_location)
			continue
		remove_from_storage(I, target)
		I.pixel_x = rand(-10,10)
		I.pixel_y = rand(-10,10)
		if(trigger_on_found && I.on_found())
			return FALSE
		if(TICK_CHECK)
			progress.update(progress.goal - length(things))
			return TRUE
	progress.update(progress.goal - length(things))
	return FALSE

/datum/component/storage/proc/do_quick_empty(atom/_target)
	if(!_target)
		_target = get_turf(parent)
	if(usr)
		ui_hide(usr)
	var/list/contents = contents()
	var/atom/real_location = real_location()
	for(var/obj/item/I in contents)
		if(I.loc != real_location)
			continue
		remove_from_storage(I, _target)
	return TRUE

/datum/component/storage/proc/set_locked(datum/source, new_state)
	SIGNAL_HANDLER

	locked = new_state
	if(locked)
		close_all()

/datum/component/storage/proc/mob_deleted(datum/source)
	SIGNAL_HANDLER
	ui_hide(source)

/datum/component/storage/proc/close(mob/M)
	ui_hide(M)

/datum/component/storage/proc/close_all()
	SIGNAL_HANDLER

	. = FALSE
	for(var/mob/M in can_see_contents())
		close(M)
		. = TRUE //returns TRUE if any mobs actually got a close(M) call

/datum/component/storage/proc/emp_act(datum/source, severity)
	SIGNAL_HANDLER

	if(emp_shielded)
		return
	var/datum/component/storage/concrete/master = master()
	master.emp_act(source, severity)

//Resets something that is being removed from storage.
/datum/component/storage/proc/_removal_reset(atom/movable/thing)
	if(!istype(thing))
		return FALSE
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	return master._removal_reset(thing)

/datum/component/storage/proc/_remove_and_refresh(datum/source, atom/movable/thing)
	_removal_reset(thing) // THIS NEEDS TO HAPPEN AFTER SO LAYERING DOESN'T BREAK!
	refresh_mob_views()

//Call this proc to handle the removal of an item from the storage item. The item will be moved to the new_location target, if that is null it's being deleted
/datum/component/storage/proc/remove_from_storage(atom/movable/AM, atom/new_location)
	if(!istype(AM))
		return FALSE
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	return master.remove_from_storage(AM, new_location)

/datum/component/storage/proc/refresh_mob_views()
	SIGNAL_HANDLER

	var/list/seeing = can_see_contents()
	for(var/i in seeing)
		ui_show(i)
	return TRUE

/datum/component/storage/proc/can_see_contents()
	var/list/cansee = list()
	for(var/mob/M in is_using)
		if(M.active_storage == src && M.client)
			cansee |= M
		else
			LAZYREMOVE(is_using, M)
			UnregisterSignal(M, COMSIG_QDELETING)
	return cansee

//Tries to dump content
/datum/component/storage/proc/dump_content_at(atom/dest_object, mob/M)
	var/atom/A = parent
	var/atom/dump_destination = dest_object.get_dumping_location()
	if(M.CanReach(A) && dump_destination && M.CanReach(dump_destination))
		if(!access_check(M))
			return FALSE
		if(locked)
			to_chat(M, span_warning("[parent] seems to be [locked_flavor]!"))
			return FALSE
		if(dump_destination.storage_contents_dump_act(src, M))
			playsound(A, "rustle", 50, TRUE, -5)
			return TRUE
	return FALSE

/datum/component/storage/proc/get_dumping_location(atom/dest_object)
	var/datum/component/storage/storage = dest_object.GetComponent(/datum/component/storage)
	if(storage)
		return storage.real_location()
	return dest_object.get_dumping_location()

//This proc is called when you want to place an item into the storage item.
/datum/component/storage/proc/attackby(datum/source, obj/item/I, mob/M, params)
	SIGNAL_HANDLER

	if(istype(I, /obj/item/hand_labeler))
		var/obj/item/hand_labeler/labeler = I
		if(labeler.mode)
			return FALSE
	. = TRUE //no afterattack
	if(iscyborg(M))
		return
	if(!can_be_inserted(I, FALSE, M))
		var/atom/real_location = real_location()
		if(real_location.contents.len >= max_items) //don't use items on the backpack if they don't fit
			return TRUE
		return FALSE
	handle_item_insertion(I, FALSE, M)

/datum/component/storage/proc/return_inv(recursive)
	var/list/ret = list()
	ret |= contents()
	if(recursive)
		for(var/i in ret.Copy())
			var/atom/A = i
			SEND_SIGNAL(A, COMSIG_TRY_STORAGE_RETURN_INVENTORY, ret, TRUE)
	return ret

/datum/component/storage/proc/contents()			//ONLY USE IF YOU NEED TO COPY CONTENTS OF REAL LOCATION, COPYING IS NOT AS FAST AS DIRECT ACCESS!
	var/atom/real_location = real_location()
	return real_location.contents.Copy()

//Abuses the fact that lists are just references, or something like that.
/datum/component/storage/proc/signal_return_inv(datum/source, list/interface, recursive = TRUE)
	SIGNAL_HANDLER

	if(!islist(interface))
		return FALSE
	interface |= return_inv(recursive)
	return TRUE

/datum/component/storage/proc/topic_handle(datum/source, user, href_list)
	SIGNAL_HANDLER

	if(href_list["show_valid_pocket_items"])
		handle_show_valid_items(source, user)

/datum/component/storage/proc/handle_show_valid_items(datum/source, user)
	to_chat(user, span_notice("[source] can hold: [can_hold_description]"))

/datum/component/storage/proc/mousedrop_onto(datum/source, atom/over_object, mob/M)
	SIGNAL_HANDLER

	set waitfor = FALSE
	. = COMPONENT_NO_MOUSEDROP
	var/atom/A = parent
	if(istype(A, /obj/item))
		var/obj/item/I = A
		I.remove_outline()	//Removes the outline when we drag
	if(!ismob(M))
		return
	if(!over_object)
		return
	if(ismecha(M.loc)) // stops inventory actions in a mech
		return
	if(M.incapacitated() || !M.canUseStorage())
		return
	A.add_fingerprint(M)
	// this must come before the screen objects only block, dunno why it wasn't before
	if(over_object == M)
		user_show_to_mob(M)
	if(!istype(over_object, /atom/movable/screen))
		INVOKE_ASYNC(src, PROC_REF(dump_content_at), over_object, M)
		return
	if(A.loc != M)
		return
	playsound(A, "rustle", 50, TRUE, -5)
	if(istype(over_object, /atom/movable/screen/inventory/hand))
		var/atom/movable/screen/inventory/hand/H = over_object
		M.putItemFromInventoryInHandIfPossible(A, H.held_index, FALSE, TRUE)
		return
	A.add_fingerprint(M)

/datum/component/storage/proc/user_show_to_mob(mob/M, force = FALSE, silent = FALSE)
	var/atom/A = parent
	if(!istype(M))
		return FALSE
	A.add_fingerprint(M)
	if(!force && locked)
		to_chat(M, span_warning("[parent] seems to be [locked_flavor]!"))
		return FALSE
	if(!force && !access_check(M))
		return FALSE
	if(force || M.CanReach(parent, view_only = TRUE))
		if(use_sound && !silent)
			playsound(A, use_sound, 50, TRUE, -5)
		ui_show(M)

/datum/component/storage/proc/mousedrop_receive(datum/source, atom/movable/O, mob/M)
	SIGNAL_HANDLER

	if(isitem(O))
		var/obj/item/I = O
		if(iscarbon(M) || isdrone(M))
			var/mob/living/L = M
			if(!L.incapacitated() && I == L.get_active_held_item())
				if(!SEND_SIGNAL(I, COMSIG_CONTAINS_STORAGE) && can_be_inserted(I, FALSE))	//If it has storage it should be trying to dump, not insert.
					handle_item_insertion(I, FALSE, L)

//This proc return 1 if the item can be picked up and 0 if it can't.
//Set the stop_messages to stop it from printing messages
/datum/component/storage/proc/can_be_inserted(obj/item/I, stop_messages = FALSE, mob/M, bypass_access = FALSE)
	if(!istype(I) || (I.item_flags & ABSTRACT))
		return FALSE //Not an item
	if(I == parent)
		return FALSE	//no paradoxes for you
	var/atom/real_location = real_location()
	var/atom/host = parent
	if(real_location == I.loc)
		return FALSE //Means the item is already in the storage item
	if(!bypass_access)//For stuff like setting up outfits, setting up roundstart backpacks, etc.
		if(!access_check(M))
			return FALSE
	if(locked)
		if(M && !stop_messages)
			host.add_fingerprint(M)
			to_chat(M, span_warning("[host] seems to be [locked_flavor]!"))
		return FALSE
	if(length(can_hold))
		if(!is_type_in_typecache(I, can_hold))
			if(!stop_messages)
				to_chat(M, span_warning("[host] cannot hold [I]!"))
			return FALSE
	if(length(can_hold_max_of_items))
		if(is_type_in_typecache(I,can_hold_max_of_items))
			var/amount = 0
			for(var/_item in contents())
				if(is_type_in_typecache(_item,can_hold_max_of_items))
					amount++
			if(amount >= can_hold_max_of_items[I.type])
				if(!stop_messages)
					to_chat(M, span_warning("[host] cannot hold another [I]!"))
				return FALSE
	if(is_type_in_typecache(I, cant_hold) || HAS_TRAIT(I, TRAIT_NO_STORAGE_INSERT) || (can_hold_trait && !HAS_TRAIT(I, can_hold_trait))) //Items which this container can't hold.
		if(!stop_messages)
			to_chat(M, span_warning("[host] cannot hold [I]!"))
		return FALSE
	// STORAGE LIMITS
	if(storage_flags & STORAGE_LIMIT_MAX_ITEMS)
		if(real_location.contents.len >= max_items)
			if(!stop_messages)
				to_chat(M, span_warning("[host] has too much junk in it, make some space!"))
			return FALSE //Storage item is full
	if(storage_flags & STORAGE_LIMIT_MAX_W_CLASS)
		if(I.w_class > max_w_class && !is_type_in_typecache(I, exception_hold))
			if(!stop_messages)
				to_chat(M, span_warning("[I] is much too long for [host]!"))
			return FALSE
	if(storage_flags & STORAGE_LIMIT_COMBINED_W_CLASS)
		var/sum_w_class = I.w_class
		for(var/obj/item/_I in real_location)
			sum_w_class += _I.w_class //Adds up the combined w_classes which will be in the storage item if the item is added to it.
		if(sum_w_class > max_combined_w_class)
			if(!stop_messages)
				to_chat(M, span_warning("[I] won't fit in [host], make some space!"))
			return FALSE
	if(storage_flags & STORAGE_LIMIT_VOLUME)
		var/sum_volume = I.get_w_volume()
		for(var/obj/item/_I in real_location)
			sum_volume += _I.get_w_volume()
		if(sum_volume > get_max_volume())
			if(!stop_messages)
				to_chat(M, span_warning("[I] is too large to fit in [host], make some space!"))
			return FALSE
	/////////////////
	if(isitem(host))
		var/obj/item/IP = host
		var/datum/component/storage/STR_I = I.GetComponent(/datum/component/storage)
		if((I.w_class >= IP.w_class) && STR_I && !allow_big_nesting)
			if(!stop_messages)
				to_chat(M, span_warning("[IP] cannot hold [I] as it's a storage item of the same size!"))
			return FALSE //To prevent the stacking of same sized storage items.
	if(HAS_TRAIT(I, TRAIT_NODROP)) //SHOULD be handled in unEquip, but better safe than sorry.
		if(!stop_messages)
			to_chat(M, span_warning("\the [I] is stuck to your hand, you can't put it in \the [host]!"))
		return FALSE
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	return master.slave_can_insert_object(src, I, stop_messages, M)

/datum/component/storage/proc/_insert_physical_item(obj/item/I, override = FALSE)
	return FALSE

//This proc handles items being inserted. It does not perform any checks of whether an item can or can't be inserted. That's done by can_be_inserted()
//The prevent_warning parameter will stop the insertion message from being displayed. It is intended for cases where you are inserting multiple items at once,
//such as when picking up all the items on a tile with one click.
/datum/component/storage/proc/handle_item_insertion(obj/item/I, prevent_warning = FALSE, mob/M, datum/component/storage/remote)
	var/atom/parent = src.parent
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	if(silent)
		prevent_warning = TRUE
	if(M)
		parent.add_fingerprint(M)
	. = master.handle_item_insertion_from_slave(src, I, prevent_warning, M)

/datum/component/storage/proc/mob_item_insertion_feedback(mob/user, mob/M, obj/item/I, override = FALSE)
	if(silent && !override)
		return
	if(use_sound)
		playsound(parent, "rustle", 50, TRUE, -5)
	for(var/mob/viewing in viewers(user, null))
		if(M == viewing)
			to_chat(usr, span_notice("You put [I] [insert_preposition]to [parent]."))
		else if(in_range(M, viewing)) //If someone is standing close enough, they can tell what it is...
			viewing.show_message(span_notice("[M] puts [I] [insert_preposition]to [parent]."), MSG_VISUAL)
		else if(I && I.w_class >= 3) //Otherwise they can only see large or normal items from a distance...
			viewing.show_message(span_notice("[M] puts [I] [insert_preposition]to [parent]."), MSG_VISUAL)

/datum/component/storage/proc/update_icon()
	if(isobj(parent))
		var/obj/O = parent
		O.update_appearance()

/datum/component/storage/proc/signal_insertion_attempt(datum/source, obj/item/I, mob/M, silent = FALSE, force = FALSE, bypass_access = FALSE)
	SIGNAL_HANDLER

	if((!force && !can_be_inserted(I, TRUE, M, bypass_access)) || (I == parent))
		return FALSE
	return handle_item_insertion(I, silent, M)

/datum/component/storage/proc/signal_can_insert(datum/source, obj/item/I, mob/M, silent = FALSE, bypass_access = FALSE)
	SIGNAL_HANDLER

	return can_be_inserted(I, silent, M, bypass_access)

/datum/component/storage/proc/show_to_ghost(datum/source, mob/dead/observer/M)
	SIGNAL_HANDLER

	return user_show_to_mob(M, TRUE, TRUE)

/datum/component/storage/proc/signal_show_attempt(datum/source, mob/showto, force = FALSE)
	SIGNAL_HANDLER

	return user_show_to_mob(showto, force)

/datum/component/storage/proc/on_check()
	SIGNAL_HANDLER

	return TRUE

/datum/component/storage/proc/check_locked()
	SIGNAL_HANDLER

	return locked

/datum/component/storage/proc/signal_take_type(datum/source, type, atom/destination, amount = INFINITY, check_adjacent = FALSE, force = FALSE, mob/user, list/inserted)
	SIGNAL_HANDLER

	if(!force)
		if(check_adjacent)
			if(!user || !user.CanReach(destination) || !user.CanReach(parent))
				return FALSE
	var/list/taking = typecache_filter_list(contents(), typecacheof(type))
	if(taking.len > amount)
		taking.len = amount
	if(inserted)			//duplicated code for performance, don't bother checking retval/checking for list every item.
		for(var/i in taking)
			if(remove_from_storage(i, destination))
				inserted |= i
	else
		for(var/i in taking)
			remove_from_storage(i, destination)
	return TRUE

/datum/component/storage/proc/remaining_space_items()
	var/atom/real_location = real_location()
	return max(0, max_items - real_location.contents.len)

/datum/component/storage/proc/signal_fill_type(datum/source, type, amount = 20, force = FALSE)
	SIGNAL_HANDLER

	var/atom/real_location = real_location()
	if(!force)
		amount = min(remaining_space_items(), amount)
	for(var/i in 1 to amount)
		if(!handle_item_insertion(new type(real_location), TRUE))
			return i > 1 //return TRUE only if at least one insertion has been successful.
		if(QDELETED(src))
			return TRUE
	return TRUE

/datum/component/storage/proc/on_attack_hand(datum/source, mob/user)
	SIGNAL_HANDLER

	var/atom/A = parent
	if(!attack_hand_interact)
		return
	if(user.active_storage == src && A.loc == user) //if you're already looking inside the storage item
		user.active_storage.close(user)
		close(user)
		. = COMPONENT_NO_ATTACK_HAND
		return

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!pocket_openable) //some things should be opened in pockets
			if(H.l_store == A && !H.get_active_held_item())	//Prevents opening if it's in a pocket.
				. = COMPONENT_NO_ATTACK_HAND
				INVOKE_ASYNC(H, TYPE_PROC_REF(/mob, put_in_hands), A)
				H.l_store = null
				return
			if(H.r_store == A && !H.get_active_held_item())
				. = COMPONENT_NO_ATTACK_HAND
				INVOKE_ASYNC(H, TYPE_PROC_REF(/mob, put_in_hands), A)
				H.r_store = null
				return

	if(A.loc == user)
		. = COMPONENT_NO_ATTACK_HAND
		if(!access_check(user))
			return FALSE
		if(locked)
			to_chat(user, span_warning("[parent] seems to be [locked_flavor]!"))
		else
			ui_show(user)
			if(use_sound)
				playsound(A, use_sound, 50, TRUE, -5)

/datum/component/storage/proc/signal_on_pickup(datum/source, mob/user)
	SIGNAL_HANDLER

	update_actions()
	for(var/mob/M in can_see_contents() - user)
		close(M)

/datum/component/storage/proc/signal_on_equip(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!worn_access)
		close(user)

/datum/component/storage/proc/signal_take_obj(datum/source, atom/movable/AM, new_loc, force = FALSE)
	SIGNAL_HANDLER

	if(!(AM in real_location()))
		return FALSE
	return remove_from_storage(AM, new_loc)

/datum/component/storage/proc/signal_quick_empty(datum/source, atom/loctarget)
	SIGNAL_HANDLER

	return do_quick_empty(loctarget)

/datum/component/storage/proc/signal_hide_attempt(datum/source, mob/target)
	SIGNAL_HANDLER

	return ui_hide(target)
/datum/component/storage/proc/open_storage(mob/user)
	if(!isliving(user) || !user.CanReach(parent) || user.incapacitated())
		return FALSE
	if(locked)
		to_chat(user, span_warning("[parent] seems to be locked!"))
		return FALSE

	. = TRUE
	var/atom/A = parent
	if(!quickdraw)
		A.add_fingerprint(user)
		user_show_to_mob(user)
		playsound(A, "rustle", 50, TRUE, -5)
		return
	var/obj/item/to_remove = locate() in real_location()
	if(!to_remove)
		return

	INVOKE_ASYNC(src, PROC_REF(attempt_put_in_hands), to_remove, user)

/datum/component/storage/proc/on_open_storage_click(datum/source, mob/user, list/modifiers)
	SIGNAL_HANDLER

	if(open_storage(user))
		return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/storage/proc/on_open_storage_attackby(datum/source, obj/item/weapon, mob/user, params)
	SIGNAL_HANDLER

	if(open_storage(user))
		return COMPONENT_SECONDARY_CANCEL_ATTACK_CHAIN

///attempt to put an item from contents into the users hands
/datum/component/storage/proc/attempt_put_in_hands(obj/item/to_remove, mob/user)
	var/atom/parent_as_atom = parent
	parent_as_atom.add_fingerprint(user)
	remove_from_storage(to_remove, get_turf(user))
	if(!user.put_in_hands(to_remove))
		to_chat(user, span_notice("You fumble for [to_remove] and it falls on the floor."))
		return
	user.visible_message(span_warning("[user] draws [to_remove] from [parent]!"), span_notice("You draw [to_remove] from [parent]."))

/datum/component/storage/proc/action_trigger(datum/signal_source, datum/action/source)
	SIGNAL_HANDLER

	gather_mode_switch(source.owner)
	return COMPONENT_ACTION_BLOCK_TRIGGER

/datum/component/storage/proc/gather_mode_switch(mob/user)
	collection_mode = (collection_mode+1)%3
	switch(collection_mode)
		if(COLLECT_SAME)
			to_chat(user, span_notice("[parent] now picks up all items of a single type at once."))
		if(COLLECT_EVERYTHING)
			to_chat(user, span_notice("[parent] now picks up all items in a tile at once."))
		if(COLLECT_ONE)
			to_chat(user, span_notice("[parent] now picks up one item at a time."))

//Gets our max volume
/datum/component/storage/proc/get_max_volume()
	return max_volume || AUTO_SCALE_STORAGE_VOLUME(max_w_class, max_combined_w_class)

//checks for mob-related storage access conditions
/datum/component/storage/proc/access_check(mob/user, message = TRUE)
	var/atom/parent_atom = parent

	//if we are inside another storage object, check access there recursively
	var/atom/container_atom = parent_atom.loc
	var/datum/component/storage/container_storage = container_atom.GetComponent(/datum/component/storage)
	if(container_storage && !container_storage.access_check(user))
		return FALSE // If we can't access the storage we're in, we can't access us, message is handled by recursion

	if(ismob(container_atom))
		var/mob/holder = container_atom

		if(!carry_access)
			if(message)
				to_chat(user, span_warning("[parent_atom] is too cumbersome to open inhand, you're going to have to set it down!"))
			return FALSE

		if(!worn_access && !holder.held_items.Find(parent_atom))
			if(message)
				to_chat(user, span_warning("Your arms aren't long enough to reach [parent_atom] while it's on your back!"))
			return FALSE
	return TRUE
