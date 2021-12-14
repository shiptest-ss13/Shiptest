/obj/item/ship_module_handheld
	name = "Prototype F-24R Contruction Assistant"
	desc = "Using the modern wonders of nanobots and streamlined material liquefaction technology this handheld has the ability to use a linked silo to create specialized structures for your vessel."
	var/obj/machinery/computer/ship/helm/linked_helm
	var/datum/component/remote_materials/materials
	var/datum/ship_module/selected_module
	var/turf/target_turf

/obj/item/ship_module_handheld/Initialize(mapload)
	. = ..()
	materials = AddComponent(/datum/component/remote_materials, "module_handheld", mapload, FALSE)

/obj/item/ship_module_handheld/Destroy()
	. = ..()
	QDEL_NULL(materials)
	linked_helm = null
	selected_module = null

/obj/item/ship_module_handheld/ui_static_data(mob/user)
	. = ..()
	var/list/module_lookup = new
	for(var/m_path in GLOB.ship_modules)
		var/datum/ship_module/module = GLOB.ship_modules[m_path]
		var/list/m_data = new
		m_data["name"] = module.name
		m_data["cost"] = module.cost
		m_data["slot"] = module.slot
		m_data["install_allow"] = module.can_install(linked_helm.current_ship) == MODULE_INSTALL_GOOD
		m_data["install_reason"] = module_install_reason(m_data["can_install"])
		module_lookup["[m_path]"] = m_data
	.["module_lookup"] = module_lookup

/obj/item/ship_module_handheld/attack_obj(obj/machinery/computer/ship/helm/attacked, mob/living/user)
	if(!istype(attacked))
		return ..()
	linked_helm = attacked
	say("Linked to Ship Database.")
	return TRUE

/obj/item/ship_module_handheld/attack_self(mob/user)
	if(!linked_helm || (linked_helm.get_virtual_z_level() != get_virtual_z_level()))
		linked_helm = null
		say("Linking failure with Ship Database.")
		return TRUE
	ui_interact(user)

/obj/item/ship_module_handheld/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ShipModuleHandheld")
		ui.open()
		ui.set_autoupdate(TRUE)

/obj/item/ship_module_handheld/ui_data(mob/user)
	. = ..()
	var/obj/structure/overmap/ship/simulated/current_ship = linked_helm.current_ship
	var/list/ship_data = list(
		"name" = current_ship.name,
		"position" = list(
			"x" = current_ship.x,
			"y" = current_ship.y,
			"z" = current_ship.get_virtual_z_level()
		),
		"valid_target" = !!target_turf,
		"target" = list(
			"name" = target_turf?.name || "no target",
			"x" = target_turf?.x || -1,
			"y" = target_turf?.y || -1,
			"z" = target_turf?.get_virtual_z_level() || -1
		)
	)
	.["ship_data"] = ship_data
	var/list/selected_data = list(
		"name" = selected_module.name,
		"desc" = selected_module.description,
		"slot" = selected_module.slot,
		"cost" = selected_module.cost
	)
	.["selected_data"] = selected_data

/obj/item/ship_module_handheld/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("set_target")
			target_turf = get_turf(src)
			say("Updated target turf to: [target_turf].")
			return TRUE
		if("build")
			if(!target_turf)
				say("Invalid target for construction.")
				return TRUE
			var/datum/ship_module/module = GLOB.ship_modules[params["module"]]
			if(!istype(module))
				say("Error synchronizing with module database.")
				stack_trace("Failed to retrieve module instance for given path '[params["module"]]'")
				return TRUE
			if(module.can_install(linked_helm.current_ship) != MODULE_INSTALL_GOOD)
				say("Failed to begin installation of module.")
				return TRUE
			module.install(linked_helm.current_ship, usr, target_turf)
			return TRUE
		if("uninstall")
			if(!target_turf)
				say("Invalid target for construction.")
				return TRUE
			var/datum/ship_module/module = GLOB.ship_modules[params["module"]]
			if(!istype(module))
				say("Error synchronizing with module database.")
				stack_trace("Failed to retrieve module instance for given path '[params["module"]]'")
				return TRUE
			var/obj/structure/ship_module/target = locate(module.structure_path) in target_turf
			if(!istype(target))
				say("Invalid target location.")
				return TRUE
			module.uninstall(linked_helm.current_ship, target)
