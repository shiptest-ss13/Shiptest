/// Called when alt clicked and the item has unique reskin options
/obj/item/proc/on_click_alt_reskin(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		return NONE

	if(!(obj_flags & INFINITE_RESKIN) && current_skin)
		return NONE

	INVOKE_ASYNC(src, PROC_REF(reskin_obj), user)
	return TRUE

/**
 * Checks if we should set up reskinning,
 * by default if unique_reskin is set.
 *
 * Called on setup_reskinning().
 * Inheritors should override this to add their own checks.
 */
/obj/item/proc/check_setup_reskinning()
	SHOULD_CALL_PARENT(TRUE)
	if(unique_reskin)
		return TRUE

	return FALSE

/**
 * Registers signals and context for reskinning,
 * if check_setup_reskinning() passes.
 *
 * Called on Initialize(...).
 * Inheritors should override this to add their own setup steps,
 * or to avoid double calling register_context().
 */
/obj/item/proc/setup_reskinning()
	SHOULD_CALL_PARENT(FALSE)

	if(current_skin)
		if(LAZYLEN(unique_reskin))
			update_item_skin()
		else
			stack_trace("[src] is initilized with a current skin while having an empty reskin list.")

	if(!check_setup_reskinning())
		return

	RegisterSignal(src, COMSIG_CLICK_ALT, PROC_REF(on_click_alt_reskin))
	//register_context()

/**
 * Reskins object based on a user's choice
 *
 * Arguments:
 * * user The mob choosing a reskin option
 */
/obj/item/proc/reskin_obj(mob/user)
	if(!LAZYLEN(unique_reskin))
		return

	var/list/items = list()
	for(var/reskin_option in unique_reskin)
		var/image/item_image = image(icon = src.icon, icon_state = unique_reskin[reskin_option])
		items += list("[reskin_option]" = item_image)
	//sort_list(items)

	var/pick = show_radial_menu(user, src, items, custom_check = CALLBACK(src, PROC_REF(check_reskin_menu), user), radius = 38, require_near = TRUE)
	if(!pick)
		return
	if(!unique_reskin[pick])
		return
	current_skin = pick
	icon_state = unique_reskin[pick]

	if (unique_reskin_changes_base_icon_state)
		base_icon_state = icon_state
	if (unique_reskin_changes_inhand)
		item_state = icon_state
	if(unique_reskin_changes_name)
		name = pick

	update_item_skin()

	to_chat(user, "[src] is now skinned as '[pick].'")
	SEND_SIGNAL(src, COMSIG_ITEM_RESKIN, user, pick)

/obj/item/proc/update_item_skin()
	icon_state = unique_reskin[current_skin]

	if(!icon_state)
		WARNING("The current skin of [src] does not exist in its list of reskins.")
	if (unique_reskin_changes_base_icon_state)
		base_icon_state = icon_state
	if (unique_reskin_changes_inhand)
		item_state = icon_state
	if(unique_reskin_changes_name)
		name = current_skin

	update_appearance()

/**
 * Checks if we are allowed to interact with a radial menu for reskins
 *
 * Arguments:
 * * user The mob interacting with the menu
 */
/obj/item/proc/check_reskin_menu(mob/user)
	if(QDELETED(src))
		return FALSE
	if(!(obj_flags & INFINITE_RESKIN) && current_skin)
		return FALSE
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE
