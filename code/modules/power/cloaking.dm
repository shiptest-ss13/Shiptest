#define WATTS_PER_TURF 200
#define BASE_RECHARGE_RATE 80

/obj/machinery/power/cloak
	name = "ship cloaking device"
	desc = "A machine capable of hiding a ship from long-range scanners. Very high power consumption. \
			There is a warning label advising against flying through electrical storms while active."
	density = TRUE
	use_power = NO_POWER_USE
	active_power_usage = WATTS_PER_TURF
	circuit = /obj/item/circuitboard/machine/cloak

	icon = 'icons/obj/machines/bsm.dmi'
	icon_state = "bsm_idle"
	base_icon_state = "bsm"

	/// Whether the cloaking device is active
	var/cloak_active = FALSE
	/// The current limit on power draw
	var/recharge_rate = 0
	/// The maximum power the cloaking device can draw from the power network
	var/max_recharge_rate = 40000
	/// Current stored power
	var/current_charge
	/// Maximum power storage
	var/max_charge
	/// Multiplier for power consumption
	var/power_multiplier = 1
	/// Traits granted to the ship while active
	var/list/cloak_traits = list(TRAIT_CLOAKED)
	/// The ship linked to this cloaking device
	var/datum/overmap/ship/controlled/linked_ship

/obj/machinery/power/cloak/Initialize(mapload, apply_default_parts)
	. = ..()
	recharge_rate ||= max_recharge_rate / 2
	connect_to_network()
	START_PROCESSING(SSmachines, src)

/obj/machinery/power/cloak/Destroy()
	set_cloak(FALSE)
	if(linked_ship)
		for(var/obj/console as anything in linked_ship.helms)
			console.update_static_data_for_all_viewers()
		unlink_from_ship()
	return ..()

/obj/machinery/power/cloak/examine(mob/user)
	. = ..()
	. += "<b>Right-Click</b> to quickly toggle it."
	if(!powernet)
		. += span_notice("There is no power grid connection.")
	if(!linked_ship)
		. += span_warning("It is not linked to a ship! Use a multitool to link it to the helm.")

/obj/machinery/power/cloak/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CloakingDevice", name)
		ui.open()

/obj/machinery/power/cloak/ui_data(mob/user)
	return list(
		"cloak_active" = cloak_active,
		"recharge_rate" = recharge_rate,
		"current_charge" = current_charge,
		"available_power" = avail(),
	)

/obj/machinery/power/cloak/ui_static_data(mob/user)
	return list(
		"linked_ship" = !isnull(linked_ship),
		"power_consumption" = active_power_usage,
		"max_recharge_rate" = max_recharge_rate,
		"max_charge" = max_charge,
		"observer" = isobserver(user) && !isAdminGhostAI(user)
	)

/obj/machinery/power/cloak/ui_act(action, list/params)
	. = ..()

	if(!isliving(usr))
		return

	switch(action)
		if("toggle_cloak")
			set_cloak(!cloak_active)
			return TRUE
		if("set_charge_rate")
			var/new_charge_rate = params["target"]
			if(!isnum(new_charge_rate))
				return FALSE
			recharge_rate = clamp(new_charge_rate, 0, max_recharge_rate)
			return TRUE

/obj/machinery/power/cloak/RefreshParts()
	. = ..()
	max_charge = 0
	current_charge = 0
	max_recharge_rate = 0
	for(var/obj/item/stock_parts/cell/cell in component_parts)
		max_charge += cell.maxcharge / GLOB.CELLRATE
		current_charge += cell.charge / GLOB.CELLRATE
	for(var/obj/item/stock_parts/capacitor/capacitor in component_parts)
		max_recharge_rate += capacitor.rating * BASE_RECHARGE_RATE / GLOB.CELLRATE
		recharge_rate = clamp(recharge_rate, 0, max_recharge_rate)
	update_static_data_for_all_viewers()

/obj/machinery/power/cloak/exchange_parts(mob/user, obj/item/storage/part_replacer/replacer)
	for(var/obj/item/stock_parts/cell/cell in component_parts)
		cell.charge = (current_charge / max_charge) * cell.maxcharge
	return ..()

/obj/machinery/power/cloak/on_deconstruction()
	for(var/obj/item/stock_parts/cell/cell in component_parts)
		cell.charge = (current_charge / max_charge) * cell.maxcharge

/obj/machinery/power/cloak/attack_hand_secondary(mob/user, list/modifiers)
	set_cloak(!cloak_active)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/power/cloak/screwdriver_act(mob/living/user, obj/item/tool, list/modifiers)
	if(flags_1 & NODECONSTRUCT_1)
		return FALSE
	if(cloak_active)
		balloon_alert(user, "turn it off!")
		return TRUE
	panel_open = !panel_open
	tool.play_tool_sound(src, 50)
	update_appearance(UPDATE_ICON_STATE)
	return TRUE

/obj/machinery/power/cloak/crowbar_act(mob/living/user, obj/item/tool, list/modifiers)
	default_deconstruction_crowbar(tool)
	return TRUE

/obj/machinery/power/cloak/multitool_act(mob/living/user, obj/item/multitool/tool, list/modifiers)
	if(istype(tool, /obj/item/multitool))
		tool.buffer = WEAKREF(src)
		balloon_alert(user, "saved to buffer")
	return TRUE

/obj/machinery/power/cloak/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	if(port.current_ship.ship_modules[SHIPMODULE_CLOAKING])
		return
	link_to_ship(port.current_ship, port)

/obj/machinery/power/cloak/proc/link_to_ship(datum/overmap/ship/controlled/new_ship, obj/docking_port/mobile/new_port)
	new_port ||= new_ship.shuttle_port
	linked_ship = new_ship
	linked_ship.ship_modules[SHIPMODULE_CLOAKING] = src
	active_power_usage = new_port.turf_count * power_multiplier * WATTS_PER_TURF
	update_appearance(UPDATE_ICON_STATE)
	update_static_data_for_all_viewers()
	for(var/obj/console as anything in linked_ship.helms)
		console.update_static_data_for_all_viewers()

/obj/machinery/power/cloak/proc/unlink_from_ship()
	set_cloak(FALSE)
	active_power_usage = 0
	linked_ship.ship_modules[SHIPMODULE_CLOAKING] = null
	linked_ship = null
	update_appearance(UPDATE_ICON_STATE)

/obj/machinery/power/cloak/update_icon_state()
	. = ..()
	if(panel_open)
		icon_state = "[base_icon_state]_t"
	else if(!linked_ship)
		icon_state = "[base_icon_state]_off"
	else
		icon_state = "[base_icon_state]_[cloak_active ? "on" : "idle"]"

/obj/machinery/power/cloak/proc/set_cloak(new_state, mob/user)
	if(new_state == cloak_active)
		return FALSE
	if(!linked_ship)
		if(!new_state)
			cloak_active = FALSE
		if(user)
			balloon_alert(user, "no linked ship!")
		return FALSE
	if(new_state && current_charge < active_power_usage)
		if(user)
			balloon_alert(user, "insufficient power!")
		return FALSE
	cloak_active = new_state

	var/cloak_sound
	if(cloak_active)
		cloak_sound = 'sound/vehicles/cloak_activate.ogg'
		for(var/trait in cloak_traits)
			ADD_TRAIT(linked_ship, trait, SHIPMODULE_CLOAKING)
	else
		cloak_sound = 'sound/vehicles/cloak_deactivate.ogg'
		for(var/trait in cloak_traits)
			REMOVE_TRAIT(linked_ship, trait, SHIPMODULE_CLOAKING)

	var/turf/own_turf = get_turf(src)
	var/source_z = "[own_turf.virtual_z]"
	var/list/listeners = (LAZYACCESS(SSmobs.players_by_virtual_z, source_z) || list()) | (LAZYACCESS(SSmobs.dead_players_by_virtual_z, source_z) || list())
	for(var/mob/listener as anything in listeners)
		listener.playsound_local(listener, cloak_sound, 50, FALSE, pressure_affected = FALSE)

	play_click_sound("switch")
	update_appearance(UPDATE_ICON_STATE)
	return TRUE

/obj/machinery/power/cloak/process(seconds_per_tick)
	if(!powernet)
		connect_to_network()

	if(current_charge < max_charge && recharge_rate > 0)
		var/delta_power = min(max_charge - current_charge, recharge_rate, surplus())
		current_charge += delta_power
		add_load(delta_power)
	if(!cloak_active)
		return

	var/power_consumption = active_power_usage
	if(current_charge < power_consumption)
		current_charge = 0
		balloon_alert_to_viewers("out of power!")
		set_cloak(FALSE)
		return
	current_charge -= power_consumption

/obj/machinery/power/cloak/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(cloak_active)
		visible_message("[src] ")
		tesla_zap(src, 5, active_power_usage / 10, ZAP_DEFAULT_FLAGS)
		set_cloak(FALSE)

/obj/machinery/power/cloak/advanced
	name = "\improper BFRD-3A cloaking device"
	desc = "A bluespace-field radar deflector, capable of cloaking ships at a low enough power cost to be practical. "
	power_multiplier = 0.5
	circuit = /obj/item/circuitboard/machine/advanced_cloak
	cloak_traits = list(TRAIT_BLUESPACE_SHIFT, TRAIT_CLOAKED)

#undef BASE_RECHARGE_RATE
#undef WATTS_PER_TURF
