/obj/machinery/computer/ship_modules
	name = "ship module overview"
	desc = "Used to view and manage ship modules."
	icon_screen = "navigation"
	icon_keyboard = "tech_key"
	var/datum/overmap/ship/controlled/current_ship

/obj/machinery/computer/ship_modules/proc/reconnect_ship()
	var/obj/docking_port/mobile/port = SSshuttle.get_containing_shuttle(src)
	if(port?.current_ship)
		current_ship = port.current_ship

/obj/machinery/computer/ship_modules/ui_status(mob/user)
	if(current_ship.owner_mob == user)
		return ..()
	return min(..(), UI_UPDATE)

/obj/machinery/computer/ship_modules/ui_interact(mob/user, datum/tgui/ui)
	if(isnull(current_ship))
		reconnect_ship()
		if(isnull(current_ship))
			SStgui.close_uis(src)
			say("Mainframe connection lost.")
			return

	ui = SStgui.try_update_ui(user, src, ui)
	if(isnull(ui))
		ui = new(user, src, "ShipModules")
		ui.open()

/obj/machinery/computer/ship_modules/ui_data(mob/user)
	. = list()
	.["modules"] = list()
	for(var/datum/ship_module/module as anything in current_ship.get_installed_modules(enabled_only = FALSE))
		.["modules"] += list(list(
			"ref" = REF(module),
			"name" = module.name,
			"info" = module.render_info(user),
			"enabled" = module.is_enabled,
			"configurable" = module.is_configurable,
		))

/obj/machinery/computer/ship_modules/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	switch(action)
		if("remove")
			var/datum/ship_module/module = locate(params["ref"])
			if(!istype(module))
				return

			if(!(module in current_ship.get_installed_modules(module.type)))
				return

			module.uninstall(current_ship)
			say("Module uninstalled.")
			SEND_SIGNAL(current_ship, COMSIG_SHIP_MODULES_UPDATED)
			return TRUE

		if("toggle")
			var/datum/ship_module/module = locate(params["ref"])
			if(!istype(module))
				return

			if(!(module in current_ship.get_installed_modules(module.type, enabled_only = FALSE)))
				return

			module.is_enabled = !module.is_enabled
			say("Module [module.is_enabled ? "enabled" : "disabled"].")
			SEND_SIGNAL(current_ship, COMSIG_SHIP_MODULES_UPDATED)
			return TRUE

		if("configure")
			var/datum/ship_module/module = locate(params["ref"])
			if(!istype(module))
				return

			if(!(module in current_ship.get_installed_modules(module.type, enabled_only = FALSE)))
				return

			module.configure(ui.user)
			return TRUE
