/datum/buildmode_mode/copy
	key = "copy"
	var/atom/movable/stored = null

/datum/buildmode_mode/copy/Destroy()
	stored = null
	return ..()

/datum/buildmode_mode/copy/show_help(client/target_client)
	to_chat(target_client, span_purple(examine_block(
		"[span_bold("Spawn a copy of selected target")] -> Left Mouse Button on obj/turf/mob\n\
		[span_bold("Select target to copy")] -> Right Mouse Button on obj/mob"))
	)

/datum/buildmode_mode/copy/handle_click(client/target_client, params, obj/object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		var/turf/T = get_turf(object)
		if(stored)
			DuplicateObject(stored, perfectcopy=1, sameloc=0,newloc=T)
			log_admin("Build Mode: [key_name(target_client)] copied [stored] to [AREACOORD(object)]")
	else if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(ismovable(object)) // No copying turfs for now.
			to_chat(target_client, "<span class='notice'>[object] set as template.</span>")
			stored = object
