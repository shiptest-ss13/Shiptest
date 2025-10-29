/obj/machinery/recharger
	name = "recharger"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "recharger"
	base_icon_state = "recharger"
	desc = "A charging dock for energy based weaponry. However someones modified it to work with most things with cells."
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_MINIMAL
	active_power_usage = ACTIVE_DRAW_LOW
	circuit = /obj/item/circuitboard/machine/recharger
	pass_flags = PASSTABLE
	var/obj/item/charging = null
	var/recharge_coeff = 1
	var/using_power = FALSE //Did we put power into "charging" last process()?
	///Did we finish recharging the currently inserted item?
	var/finished_recharging = FALSE

	var/static/list/allowed_devices = typecacheof(list(
		/obj/item/gun/energy,
		/obj/item/melee/baton,
		/obj/item/ammo_box/magazine/recharge,
		/obj/item/modular_computer,
		/obj/item/gun/ballistic/automatic/powered,
		/obj/item/gun/ballistic/automatic/assault/e40,
		/obj/item/attachment/gun/energy,
		/obj/item/stock_parts/cell/gun,
		/obj/item/melee/energy/flyssa
		))

/obj/machinery/recharger/RefreshParts()
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		recharge_coeff = C.rating

/obj/machinery/recharger/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !issilicon(user) && !isobserver(user))
		. += span_warning("You're too far away to examine [src]'s contents and display!")
		return

	if(charging)
		. += span_notice("\The [src] contains:")
		. += span_notice("- \A [charging].")

	if(!(machine_stat & (NOPOWER|BROKEN)))
		. += span_notice("The status display reads:")
		. += span_notice("- Recharging <b>[recharge_coeff*10]%</b> cell charge per cycle.")
		if(charging)
			var/obj/item/stock_parts/cell/C = charging.get_cell()
			if(istype(charging, /obj/item/stock_parts/cell))
				. += span_notice("- \The [charging]'s charge is at <b>[C.percent()]%</b>.")
			else
				. += span_notice("- \The [charging]'s cell is at <b>[C.percent()]%</b>.")


/obj/machinery/recharger/proc/setCharging(new_charging)
	charging = new_charging
	if (new_charging)
		START_PROCESSING(SSmachines, src)
		finished_recharging = FALSE
		set_active_power()
		using_power = TRUE
		update_appearance()
	else
		set_idle_power()
		using_power = FALSE
		update_appearance()

/obj/machinery/recharger/attackby(obj/item/G, mob/user, params)
	if(G.tool_behaviour == TOOL_WRENCH)
		if(charging)
			to_chat(user, span_notice("Remove the charging item first!"))
			return
		set_anchored(!anchored)
		power_change()
		to_chat(user, span_notice("You [anchored ? "attached" : "detached"] [src]."))
		G.play_tool_sound(src)
		return

	var/allowed = G.get_cell()

	if(allowed)
		if(anchored)
			if(charging || panel_open)
				return TRUE

			//Checks to make sure he's not in space doing it, and that the area got proper power.
			var/area/a = get_area(src)
			if(!isarea(a) || a.power_equip == 0)
				to_chat(user, span_notice("[src] blinks red as you try to insert [G]."))
				return TRUE

			if (istype(G, /obj/item/gun/energy))
				var/obj/item/gun/energy/E = G
				if(!E.can_charge)
					to_chat(user, span_notice("Your gun has no external power connector."))
					return TRUE

			if(!user.transferItemToLoc(G, src))
				return TRUE
			setCharging(G)

		else
			to_chat(user, span_notice("[src] isn't connected to anything!"))
		return TRUE

	if(anchored && !charging)
		if(default_deconstruction_screwdriver(user, "recharger-open", "recharger", G))
			return

		if(panel_open && G.tool_behaviour == TOOL_CROWBAR)
			default_deconstruction_crowbar(G)
			return

	return ..()

/obj/machinery/recharger/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	add_fingerprint(user)
	if(charging)
		charging.forceMove(drop_location())
		charging.update_appearance()
		user.put_in_hands(charging)
		setCharging(null)

/obj/machinery/recharger/attack_tk(mob/user)
	if(charging)
		charging.forceMove(drop_location())
		charging.update_appearance()
		setCharging(null)

/obj/machinery/recharger/process(seconds_per_tick)
	if(machine_stat & (NOPOWER|BROKEN) || !anchored)
		return PROCESS_KILL

	using_power = FALSE
	if(charging)
		var/obj/item/stock_parts/cell/C = charging.get_cell()
		if(C)
			if(C.charge < C.maxcharge)
				C.give(C.chargerate * recharge_coeff * seconds_per_tick / 2)
				use_power(125 * recharge_coeff * seconds_per_tick)
				using_power = TRUE
			update_appearance()

		if(istype(charging, /obj/item/ammo_box/magazine/recharge))
			var/obj/item/ammo_box/magazine/recharge/R = charging
			if(R.stored_ammo.len < R.max_ammo)
				R.stored_ammo += new R.ammo_type(R)
				use_power(100 * recharge_coeff * seconds_per_tick)
				using_power = TRUE
			update_appearance()
			return
		if(!using_power && !finished_recharging) //Inserted thing is at max charge/ammo, notify those around us
			finished_recharging = TRUE
			playsound(src, 'sound/machines/ping.ogg', 30, TRUE)
			say("[charging] has finished recharging!")
	else
		return PROCESS_KILL

/obj/machinery/recharger/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_CONTENTS)
		return
	if(!(machine_stat & (NOPOWER|BROKEN)) && anchored)
		if(istype(charging,  /obj/item/gun/energy))
			var/obj/item/gun/energy/E = charging
			if(E.cell)
				E.cell.emp_act(severity)

		else if(istype(charging, /obj/item/melee/baton))
			var/obj/item/melee/baton/B = charging
			if(B.cell)
				B.cell.charge = 0


/obj/machinery/recharger/update_appearance(updates)
	. = ..()
	if((machine_stat & (NOPOWER|BROKEN)) || panel_open || !anchored)
		luminosity = 0
		return
	luminosity = 1

/obj/machinery/recharger/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN) || !anchored || panel_open)
		return

	luminosity = 1
	if(!charging)
		SSvis_overlays.add_vis_overlay(src, icon, "[base_icon_state]-empty", layer, plane, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "[base_icon_state]-empty", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)
		return
	if(using_power)
		SSvis_overlays.add_vis_overlay(src, icon, "[base_icon_state]-charging", layer, plane, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "[base_icon_state]-charging", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)
		return

	SSvis_overlays.add_vis_overlay(src, icon, "[base_icon_state]-full", layer, plane, dir, alpha)
	SSvis_overlays.add_vis_overlay(src, icon, "[base_icon_state]-full", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)
