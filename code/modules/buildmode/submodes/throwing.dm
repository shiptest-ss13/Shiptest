/datum/buildmode_mode/throwing
	key = "throw"

	var/atom/movable/throw_atom = null

/datum/buildmode_mode/throwing/Destroy()
	throw_atom = null
	return ..()

/datum/buildmode_mode/throwing/show_help(client/target_client)
	to_chat(target_client, span_purple(examine_block(
		"[span_bold("Select")] -> Left Mouse Button on turf/obj/mob\n\
		[span_bold("Throw")] -> Right Mouse Button on turf/obj/mob"))
	)

/datum/buildmode_mode/throwing/handle_click(client/target_client, params, obj/object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if(isturf(object))
			return
		throw_atom = object
		to_chat(target_client, "Selected object '[throw_atom]'")
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(throw_atom)
			throw_atom.throw_at(object, 10, 1, target_client.mob)
			log_admin("Build Mode: [key_name(target_client)] threw [throw_atom] at [object] ([AREACOORD(object)])")
