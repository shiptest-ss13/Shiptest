/obj/machinery/computer/ship/weapons
	name = "Weapons Control"
	icon_screen = "weapons-s"
	icon_keyboard = "weapons-k"
	circuit = /obj/item/circuitboard/computer/ship/weapons
	tgui_interface_id = "ShipWeaponsConsole"
	light_color = LIGHT_COLOR_YELLOW
	clicksound = null
	var/list/last_hit_data

/obj/item/circuitboard/computer/ship/weapons
	name = "Weapons Control (Computer Board)"
	build_path = /obj/machinery/computer/ship/weapons

/obj/machinery/computer/ship/weapons/ui_static_data(mob/user)
	// Generate weapon data list; this really shouldnt change very often
	var/list/wep_data = list(
		"weapon_lookup" = list()
	)
	for(var/datum/ship_module/weapon/weapon as anything in current_ship.modules[SHIP_SLOT_WEAPON])
		var/wep_ref = ref(weapon)
		wep_data["weapon_lookup"] += wep_ref
		wep_data["weapon_data"][wep_ref] = list(
			"name" = weapon.name,
			"structure_count" = length(weapon.installed_on[current_ship]),
			"damage_types" = convert_damage_types_to_readable_string(weapon.damage_types),
			"damage_base" = weapon.damage,
			"damage_variance" = weapon.damage_variance,
			"structure_lookup" = list(),
			"structure_data" = list()
		)
	return wep_data

/obj/machinery/computer/ship/weapons/ui_data(mob/user)
	var/list/data = list(
		"structure_data" = list()
	)
	for(var/datum/ship_module/weapon/weapon as anything in current_ship.modules[SHIP_SLOT_WEAPON])
		for(var/obj/structure/ship_module/weapon/struc as anything in weapon.installed_on[current_ship])
			var/struc_ref = ref(struc)
			data["structure_data"][struc_ref] = list(
				"name" = struc.name,
				"loaded" = struc.check_loaded(),
				"ammo_max" = struc.mag_size,
				"reloading" = !!struc.reload_timer_id,
				"reload_time" = struc.reload_time,
				"reload_left" = struc.reload_eta - world.time
			)
	data["last_hit_data"] = length(last_hit_data) ? last_hit_data : FALSE
	return data

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
