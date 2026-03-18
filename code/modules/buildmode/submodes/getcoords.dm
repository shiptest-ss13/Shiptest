/datum/buildmode_mode/getcoords
	key = "getcoords"

/datum/buildmode_mode/getcoords/show_help(client/target_client)
	to_chat(target_client, span_purple(boxed_message(
		"[span_bold("Get local and overmap coords of tile")] -> Left Click Mouse Button on turf"\
	))
	)


/datum/buildmode_mode/getcoords/handle_click(client/target_client, params, datum/object as null|area|mob|obj|turf)
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, LEFT_CLICK))
		//get coords
		var/turf/targloc = get_turf(object)
		var/message

		var/datum/virtual_level/our_vlevel = targloc.get_virtual_level()
		if(!our_vlevel)
			return
		var/datum/overmap/our_overmap_object = targloc.get_overmap_location()
		var/list/coords = our_vlevel.get_relative_coords(targloc)

		message += "[span_big("Vlevel coords: X [coords[1]]/Y [coords[2]]")]\n"
		if(our_overmap_object)
			message += "[span_big("Overmap coords: X [our_overmap_object.x]/Y [our_overmap_object.y]")]\n"
		else
			message += "[span_big("Invalid or N/A Overmap object?")]"
		to_chat(target_client, span_notice("[message]"))



