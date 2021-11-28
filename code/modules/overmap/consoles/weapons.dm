/obj/machinery/computer/ship/weapons
	name = "Weapons Control"
	icon_screen = "weapons-s"
	icon_keyboard = "weapons-k"
	circuit = /obj/item/circuitboard/computer/ship/weapons
	tgui_interface_id = "ShipWeaponsConsole"
	light_color = LIGHT_COLOR_YELLOW
	clicksound = null
	var/list/last_hit_data

/obj/machinery/computer/ship/weapons/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	// Active weapon type
	var/datum/ship_module/weapon/active_module = locate(params["active_module"])
	if(!istype(active_module))
		CRASH("Invalid active_module reference. incorrect type: [active_module.type]")
	// selected weapon id
	var/selected_weapon = params["weapon_select"]
	// weapon structure
	var/obj/structure/ship_module/weapon/weapon = active_module.get_module_structure_by_id(selected_weapon)
	if(!weapon)
		CRASH("Unable to find active weapon structure? invalid id: [selected_weapon]")

	switch(action)
		if("weapon-reload")
			weapon.try_reload()
			return TRUE
		if("weapon-fire")
			var/obj/structure/overmap/target = locate(params["target"])
			if(!istype(target))
				CRASH("Illegal target ref.")
			var/old_integ = target.integrity
			var/fire_resp = active_module.weapon_fire(current_ship, weapon, target)
			last_hit_data = list()
			last_hit_data["state"] = fire_resp
			last_hit_data["old_integrity"] = old_integ
			last_hit_data["new_integrity"] = target.integrity
			last_hit_data["damage"] = old_integ - target.integrity
			return TRUE
	return FALSE
