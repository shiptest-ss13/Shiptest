/proc/power_failure(z_level)
	priority_announce("As a maintenance measure, power will be shut off for an indeterminate duration.", "Power Systems Maintenance", 'sound/ai/poweroff.ogg', zlevel = z_level)
	for(var/obj/machinery/power/smes/S in GLOB.machines)
		if(istype(get_area(S), /area/ship/science/ai_chamber) || (z_level && S.virtual_z() != z_level))
			continue
		S.charge = 0
		S.output_level = 0
		S.output_attempt = FALSE
		S.update_appearance()
		S.power_change()

	for(var/area/A in GLOB.sortedAreas)
		if(!A.requires_power || A.always_unpowered)
			continue
		if(GLOB.typecache_powerfailure_safe_areas[A.type])
			continue

		A.power_light = FALSE
		A.power_equip = FALSE
		A.power_environ = FALSE
		A.power_change()

	for(var/obj/machinery/power/apc/C in GLOB.apcs_list)
		if(!C.cell || (z_level && C.virtual_z() != z_level))
			continue
		var/area/A = C.area
		if(GLOB.typecache_powerfailure_safe_areas[A.type])
			continue

		C.cell.charge = 0

/proc/power_restore(z_level)
	priority_announce("Power has been restored. We apologize for the inconvenience.", "Power Systems Nominal", 'sound/ai/poweron.ogg', zlevel = z_level)
	for(var/obj/machinery/power/apc/C in GLOB.machines)
		if(!C.cell || (z_level && C.virtual_z() != z_level))
			continue
		C.cell.charge = C.cell.maxcharge
		COOLDOWN_RESET(C, failure_timer)
	for(var/obj/machinery/power/smes/S in GLOB.machines)
		if(z_level && S.virtual_z() != z_level)
			continue
		S.charge = S.capacity
		S.output_level = S.output_level_max
		S.output_attempt = TRUE
		S.update_appearance()
		S.power_change()
	for(var/area/A in GLOB.sortedAreas)
		if(!A.requires_power || A.always_unpowered)
			continue
		if(!istype(A, /area/shuttle))
			A.power_light = TRUE
			A.power_equip = TRUE
			A.power_environ = TRUE
			A.power_change()

/proc/power_restore_quick()
	priority_announce("All SMESs have been recharged. We apologize for the inconvenience.", "Power Systems Nominal", 'sound/ai/poweron.ogg')
	for(var/obj/machinery/power/smes/S in GLOB.machines)
		S.charge = S.capacity
		S.output_level = S.output_level_max
		S.output_attempt = TRUE
		S.update_appearance()
		S.power_change()

