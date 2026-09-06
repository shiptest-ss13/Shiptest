/datum/buildmode_mode/portal
	key = "portal"

	use_corner_selection = TRUE

	var/portal_lifespan = 0
	var/portal_accuracy = 0
	var/make_ladder = FALSE

	var/atom/objholder = null

/datum/buildmode_mode/portal/show_help(client/target_client)
	to_chat(target_client, span_purple(boxed_message(
		"[span_bold("Select portal locations")] -> Left Mouse Button on turf/obj/mob\n\
		[span_bold("Portal settings")] -> Right Mouse Button on buildmode button"))
	)

/datum/buildmode_mode/portal/handle_click(client/target_client, params, obj/object)
	if(isnull(objholder))
		to_chat(target_client, span_warning("Select an object type first."))
		deselect_region()
		return
	..()

/datum/buildmode_mode/portal/change_settings(client/target_client)
	if(tgui_alert(target_client,"Make it a ladder instead?", "Ladderfy?", list("Yes", "No")) == "Yes")
		objholder = /obj/structure/ladder
		make_ladder = TRUE
	else
		make_ladder = FALSE
		portal_lifespan = input(target_client, "Set portal lifespan time. 0 for infinite", text("Input")) as num|null
		if(portal_lifespan <= 0)
			portal_lifespan = 0
		portal_accuracy = input(target_client, "Set portal accuracy. Lower is better.", text("Input")) as num|null
		if(portal_accuracy == null)
			portal_accuracy = 0
		var/atom/temp_path
		var/target_path = input(target_client, "Enter typepath:", "Typepath", "/obj/effect/portal")
		temp_path = text2path(target_path)
		if(!ispath(temp_path))
			temp_path = pick_closest_path(target_path)
			if(!temp_path)
				alert("No path was selected")
				return
			if(!ispath(temp_path, /obj/effect/portal))
				alert("Not a portal!")
				return
		objholder = temp_path
	if(!isnull(objholder))
		BM.preview_selected_item(objholder)

/datum/buildmode_mode/portal/handle_selected_area(client/c, params)
	if(make_ladder)
		create_ladder_pair(get_turf(cornerA), get_turf(cornerB))
	else
		create_portal_pair(get_turf(cornerA), get_turf(cornerB), portal_lifespan, portal_accuracy, objholder)
