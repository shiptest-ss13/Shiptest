/datum/buildmode_mode/relocate_to
	key = "relocate_to"

	var/atom/movable/relocate_atom = null

/datum/buildmode_mode/relocate_to/Destroy()
	relocate_atom = null
	return ..()

/datum/buildmode_mode/relocate_to/show_help(client/target_client)
	to_chat(target_client, span_purple(examine_block(
		"[span_bold("Select")] -> Left Mouse Button on obj/mob\n\
		[span_bold("Relocate")] -> Right Mouse Button on turf/obj/mob"))
	)

/datum/buildmode_mode/relocate_to/handle_click(client/target_client, params, obj/object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if(isturf(object))
			return
		relocate_atom = object
		to_chat(target_client, "Selected object '[relocate_atom]'")
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(relocate_atom)
			var/atom/loc = get_turf(object)
			relocate_atom.forceMove(loc)
			log_admin("Build Mode: [key_name(target_client)] relocated [relocate_atom] at [object] ([AREACOORD(object)])")
