/datum/buildmode_mode/advanced
	key = "advanced"
	var/atom/objholder = null

// FIXME: add logic which adds a button displaying the icon
// of the currently selected path

/datum/buildmode_mode/advanced/show_help(client/target_client)
	to_chat(target_client, span_purple(examine_block(
		"[span_bold("Set object type")] -> Right Mouse Button on buildmode button\n\
		[span_bold("Copy object type")] -> Left Mouse Button + Alt on turf/obj\n\
		[span_bold("Place objects")] -> Left Mouse Button on turf/obj\n\
		[span_bold("Delete objects")] -> Right Mouse Button\n\
		\n\
		Use the button in the upper left corner to change the direction of built objects."))
	)

/datum/buildmode_mode/advanced/change_settings(client/target_client)
	var/target_path = input(target_client, "Enter typepath:", "Typepath", "/obj/structure/closet")
	objholder = text2path(target_path)
	if(!ispath(objholder))
		objholder = pick_closest_path(target_path)
		if(!objholder)
			alert("No path was selected")
			return
		else if(ispath(objholder, /area))
			objholder = null
			alert("That path is not allowed.")
			return
	BM.preview_selected_item(objholder)

/datum/buildmode_mode/advanced/handle_click(client/target_client, params, obj/object)
	var/list/modifiers = params2list(params)
	var/left_click = LAZYACCESS(modifiers, LEFT_CLICK)
	var/right_click = LAZYACCESS(modifiers, RIGHT_CLICK)
	var/alt_click = LAZYACCESS(modifiers, ALT_CLICK)

	if(left_click && alt_click)
		if (istype(object, /turf) || istype(object, /obj) || istype(object, /mob))
			objholder = object.type
			to_chat(target_client, "<span class='notice'>[initial(object.name)] ([object.type]) selected.</span>")
			BM.preview_selected_item(objholder)
		else
			to_chat(target_client, "<span class='notice'>[initial(object.name)] is not a turf, object, or mob! Please select again.</span>")
	else if(left_click)
		if(ispath(objholder,/turf))
			var/turf/T = get_turf(object)
			log_admin("Build Mode: [key_name(target_client)] modified [T] in [AREACOORD(object)] to [objholder]")
			T = T.ChangeTurf(objholder)
			T.setDir(BM.build_dir)
		else if(ispath(objholder, /obj/effect/turf_decal))
			var/turf/T = get_turf(object)
			T.AddElement(/datum/element/decal, initial(objholder.icon), initial(objholder.icon_state), BM.build_dir, FALSE, initial(objholder.color), null, null, initial(objholder.alpha))
			log_admin("Build Mode: [key_name(target_client)] in [AREACOORD(object)] added a [initial(objholder.name)] decal with dir [BM.build_dir] to [T]")
		else if(!isnull(objholder))
			var/obj/A = new objholder (get_turf(object))
			A.setDir(BM.build_dir)
			log_admin("Build Mode: [key_name(target_client)] modified [A]'s [COORD(A)] dir to [BM.build_dir]")
		else
			to_chat(target_client, "<span class='warning'>Select object type first.</span>")
	else if(right_click)
		if(isobj(object))
			log_admin("Build Mode: [key_name(target_client)] deleted [object] at [AREACOORD(object)]")
			qdel(object)
