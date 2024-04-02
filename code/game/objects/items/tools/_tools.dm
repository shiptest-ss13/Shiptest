/obj/item/tool
	name = "tool"
	icon = 'icons/obj/tools.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 10
	throwforce = 10
	w_class = WEIGHT_CLASS_SMALL

/******************************
	/* Data and Checking */
*******************************/
/obj/item/proc/has_quality(quality_id)
	return !quality_id || (quality_id in tool_qualities)


/obj/item/proc/get_tool_quality(quality_id)
	if(tool_qualities && tool_qualities.len)
		return tool_qualities[quality_id]
	return null

//We are cheking if our item got required qualities. If we require several qualities, and item posses more than one of those, we ask user to choose how that item should be used
/obj/item/proc/get_tool_type(mob/living/user, list/required_qualities, atom/use_on, datum/callback/CB)
	if(!tool_qualities) //This is not a tool, or does not have tool qualities
		return

	var/list/L = required_qualities & tool_qualities

	if(L.len)
		if(L.len == 1)
			return L[1]
		for(var/i in L)
			L[i] = image(icon = 'icons/mob/radial.dmi', icon_state = i)
		return show_radial_menu(user, use_on ? use_on : user, L, tooltips = TRUE, require_near = TRUE, custom_check = CB)
