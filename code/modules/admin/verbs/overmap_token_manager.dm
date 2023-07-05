/client/proc/overmap_datum_token_manager()
	set name = "Overmap Datum Token Manager"
	set category = "Admin.Game"
	set desc = "Manage the tokens of the overmap datum."

	var/static/datum/overmap_datum_token_manager/manager
	if(isnull(manager))
		manager = new
	manager.ui_interact(mob)

/// Datum for the overmap datum token manager.
/datum/overmap_datum_token_manager

/datum/overmap_datum_token_manager/ui_state(mob/user)
	return GLOB.admin_state

/datum/overmap_datum_token_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(isnull(ui))
		ui = new(user, src, "OvermapTokenManager")
		ui.open()

/datum/overmap_datum_token_manager/proc/get_name_and_ref(datum/overmap/from)
	if(isnull(from))
		return null
	return list(
		"name" = from.name,
		"ref" = REF(from),
	)

/datum/overmap_datum_token_manager/ui_data(mob/user)
	. = list()
	for(var/datum/overmap/overmap_datum as anything in SSovermap.overmap_objects)
		var/datum_type = "[overmap_datum.type]"
		if(!(datum_type in .))
			.[datum_type] = list()

		var/list/datum_info = list()
		.[datum_type] += list(datum_info)

		datum_info["name"] = overmap_datum.name
		datum_info["ref"] = REF(overmap_datum)
		datum_info["token"] = get_name_and_ref(overmap_datum.token)
		datum_info["position"] = list(overmap_datum.x, overmap_datum.y)
		datum_info["docked_to"] = get_name_and_ref(overmap_datum.docked_to)

		var/list/docked_info = list()
		datum_info["docked"] = docked_info
		for(var/datum/overmap/docked as anything in overmap_datum.contents)
			docked_info += list(get_name_and_ref(docked))

		if(istype(overmap_datum, /datum/overmap/ship/controlled))
			var/datum/overmap/ship/controlled/ship = overmap_datum
			datum_info["ship_port_ref"] = REF(ship.shuttle_port)

/datum/overmap_datum_token_manager/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("vv")
			var/datum/target = locate(params["ref"])
			if(isnull(target))
				return
			ui.user.client.debug_variables(target)
			return TRUE

		if("jump")
			var/target = locate(params["ref"])
			if(isnull(target))
				return

			if(!isobserver(ui.user) && !ui.user.client.admin_ghost())
				return
			ui.user.forceMove(get_turf(target))
			return TRUE

		if("token-new")
			var/datum/overmap/target = locate(params["ref"]) in SSovermap.overmap_objects
			if(isnull(target))
				return
			target.set_or_create_token()
			message_admins("[key_name_admin(ui.user)] regenerated the token for [target.name] ([target.type])")
			return TRUE

		if("token-force-update")
			var/datum/overmap/target = locate(params["ref"]) in SSovermap.overmap_objects
			if(isnull(target))
				return
			target.set_or_create_token(target.token)
			message_admins("[key_name_admin(ui.user)] forced an update of the token for [target.name] ([target.type])")
			return TRUE
