/datum/buildmode_mode/modify_overmap
	key = "modifyovermap"
	var/datum/datum_holder = null

// FIXME: add logic which adds a button displaying the icon
// of the currently selected path

/datum/buildmode_mode/modify_overmap/show_help(client/target_client)
	to_chat(target_client, span_purple(boxed_message(
		"[span_bold("Set datum type")] -> Right Mouse Button on buildmode button\n\
		[span_bold("Copy datum type")] -> Left Mouse Button + Alt on Overmap Token\n\
		[span_bold("Place datum")] -> Left Mouse Button on  Overmap Token\n\
		[span_bold("Delete datum")] -> Right Mouse Button on Overmap Token\n\
		[span_bold("Mass delete datum on current overmap (DANGER)")] -> Right Mouse Button + Alt Button on Overmap Token"))
	)

/datum/buildmode_mode/modify_overmap/change_settings(client/target_client)
	var/target_path = input(target_client, "Enter typepath:", "Typepath", "/datum/overmap/dynamic")
	datum_holder = text2path(target_path)
	if(!ispath(datum_holder))
		datum_holder = pick_closest_path(target_path,get_fancy_list_of_datum_types())
		if(!datum_holder)
			alert("No path was selected")
			return
		else if(!ispath(datum_holder, /datum/overmap))
			datum_holder = null
			alert("That path is not allowed. Use a subtype of /datum/overmap")
			return
/*
notes for self:

the parameters are from the client, meaning object is what they clicked on, not what theyre trying to place
*/
/datum/buildmode_mode/modify_overmap/handle_click(client/target_client, params, obj/object)
	var/list/modifiers = params2list(params)
	var/left_click = LAZYACCESS(modifiers, LEFT_CLICK)
	var/right_click = LAZYACCESS(modifiers, RIGHT_CLICK)
	var/alt_click = LAZYACCESS(modifiers, ALT_CLICK)
	var/turf/current_turf = get_turf(object)
	if(!istype(current_turf.loc,/area/overmap))
		to_chat(target_client, "<span class='warning'>Please only use this tool on the overmap.</span>")
		return FALSE

	if(left_click && alt_click)
		if (istype(object, /obj/overmap))
			var/obj/overmap/selected_token = object
			datum_holder = selected_token.parent.type
			to_chat(target_client, "<span class='notice'>[initial(selected_token.name)] ([selected_token.parent.type]) selected.</span>")
		else
			to_chat(target_client, "<span class='notice'>[initial(object.name)] is not an overmap token! Please select again.</span>")
	else if(left_click)
		if(ispath(datum_holder,/datum/overmap))
			var/datum/virtual_level/vlevel = current_turf.get_virtual_level()

			var/overmap_x = current_turf.x - (vlevel.low_x + vlevel.reserved_margin) + 1
			var/overmap_y = current_turf.y - (vlevel.low_y + vlevel.reserved_margin) + 1
			var/list/position = list() //wish i could do this like new datum_holder(list(overmap_x["x"],overmap_y["y"])) but idk how so onto how its done in randomverbs
			position["x"] = overmap_x
			position["y"] = overmap_y

			new datum_holder(position,vlevel.current_systen)

			log_admin("Build Mode: [key_name(target_client)] modified [overmap_x], [overmap_y] in [AREACOORD(object)] to [datum_holder]")
		else
			to_chat(target_client, "<span class='warning'>Select a overmap object first.</span>")

	else if(right_click && !alt_click)
		if(istype(object, /obj/overmap))
			var/obj/overmap/selected_token = object
			log_admin("Build Mode: [key_name(target_client)] deleted [selected_token.name] at [AREACOORD(object)] [selected_token.parent.x], [selected_token.parent.y].")
			qdel(selected_token.parent)

	else if (right_click && alt_click)
		if(check_rights(R_DEBUG|R_SERVER))	//Prevents buildmoded non-admins from breaking everything.
			if(!istype(object, /obj/overmap))
				return
			var/obj/overmap/selected_token = object
			var/datum/overmap/selected_overmap_datum = selected_token.parent

			var/action_type = alert("Strict type ([selected_overmap_datum.type]) or type and all subtypes?",,"Strict type","Type and subtypes","Cancel")
			if(action_type == "Cancel" || !action_type)
				return

			if(alert("Are you really sure you want to delete all instances of type [selected_overmap_datum.type]? THIS MAY BREAK THE ROUND. MAKE SURE THIS ISN'T THE MAIN OVERMAP.",,"Yes","No") != "Yes")
				return

			if(alert("Second confirmation required. Delete EVERYTHING on current overmap? ARE YOU SURE?",,"Yes","No") != "Yes")
				return

			var/O_type = selected_overmap_datum.type
			switch(action_type)
				if("Strict type")
					var/i = 0
					for(var/datum/overmap/target in selected_overmap_datum.current_overmap.overmap_objects)
						if(target.type == O_type)
							i++
							qdel(target)
						CHECK_TICK
					if(!i)
						to_chat(usr, "No instances of this type exist")
						return
					log_admin("[key_name(usr)] deleted all instances of type [O_type] ([i] instances deleted) ")
					message_admins("<span class='notice'>[key_name(usr)] deleted all instances of type [O_type] ([i] instances deleted) </span>")
				if("Type and subtypes")
					var/i = 0
					for(var/target in SSovermap.overmap_objects)
						if(istype(target,O_type))
							i++
							qdel(target)
						CHECK_TICK
					if(!i)
						to_chat(usr, "No instances of this type exist")
						return
					log_admin("[key_name(usr)] deleted all instances of type or subtype of [O_type] ([i] instances deleted) ")
					message_admins("<span class='notice'>[key_name(usr)] deleted all instances of type or subtype of [O_type] ([i] instances deleted) </span>")


/datum/buildmode_mode/move_overmap
	key = "moveovermap"

	var/datum/overmap/selected_object = null

/datum/buildmode_mode/move_overmap/Destroy()
	selected_object = null
	return ..()

/datum/buildmode_mode/move_overmap/show_help(client/target_client)
	to_chat(target_client, span_purple(boxed_message(
		"[span_bold("Select")] -> Left Mouse Button on a overmap token\n\
		[span_bold("Throw")] -> Right Mouse Button on a overmap spot"))
	)

/datum/buildmode_mode/move_overmap/handle_click(client/target_client, params, obj/object)
	var/list/modifiers = params2list(params)
	var/turf/current_turf = get_turf(object)
	if(!istype(current_turf.loc,/area/overmap))
		to_chat(target_client, "<span class='warning'>Please only ever use this tool on the overmap, please.</span>")
		return FALSE
	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if (istype(object, /obj/overmap))
			var/obj/overmap/selected_token = object
			selected_object = selected_token.parent
			to_chat(target_client, "Selected '[selected_object]'")
		else
			to_chat(target_client, "<span class='notice'>[initial(object.name)] is not an overmap token! Please select again.</span>")

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(selected_object)
			var/datum/virtual_level/vlevel = current_turf.get_virtual_level()

			var/overmap_x = current_turf.x - (vlevel.low_x + vlevel.reserved_margin) + 1
			var/overmap_y = current_turf.y - (vlevel.low_y + vlevel.reserved_margin) + 1

			if(vlevel.current_systen != selected_object.current_overmap)
				selected_object.move_overmaps(vlevel.current_systen,overmap_x,overmap_y)
			else
				selected_object.overmap_move(overmap_x,overmap_y,vlevel.current_systen)

			log_admin("Build Mode: [key_name(target_client)] moved [selected_object] to [overmap_x], [overmap_y] at ([AREACOORD(object)])")
