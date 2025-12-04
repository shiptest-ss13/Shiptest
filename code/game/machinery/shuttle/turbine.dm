// TURBINE v2 AKA rev4407 Engine reborn!

// How to use it? - Mappers
//
// This is a very good power generating mechanism. All you need is a blast furnace with soaring flames and output.
// Not everything is included yet so the turbine can run out of fuel quiet quickly. The best thing about the turbine is that even
// though something is on fire that passes through it, it won't be on fire as it passes out of it. So the exhaust fumes can still
// containt unreacted fuel - plasma and oxygen that needs to be filtered out and re-routed back. This of course requires smart piping
// For a computer to work with the turbine the compressor requires a comp_id matching with the turbine computer's id. This will be
// subjected to a change in the near future mind you. Right now this method of generating power is a good backup but don't expect it
// become a main power source unless some work is done. Have fun. At 50k RPM it generates 60k power. So more than one turbine is needed!
//
// - Numbers
//
// Example setup	 S - sparker
//					 B - Blast doors into space for venting
// *BBB****BBB*		 C - Compressor
// S    CT    *		 T - Turbine
// * ^ *  * V *		 D - Doors with firedoor
// **|***D**|**      ^ - Fuel feed (Not vent, but a gas outlet)
//   |      |        V - Suction vent (Like the ones in atmos
//


/obj/machinery/power/compressor
	name = "compressor"
	desc = "The compressor stage of a gas turbine generator."
	icon = 'icons/obj/atmospherics/components/turbine.dmi'
	icon_state = "compressor"
	density = TRUE
	resistance_flags = FIRE_PROOF
	CanAtmosPass = ATMOS_PASS_DENSITY
	use_power = NO_POWER_USE // powered by gas flow
	interacts_with_air = TRUE
	circuit = /obj/item/circuitboard/machine/power_compressor
	var/obj/machinery/power/shuttle/engine/turbine/turbine
	var/datum/gas_mixture/gas_contained
	var/starter = 0
	var/rpm = 0
	var/rpmtarget = 0
	var/capacity = 1e6
	var/comp_id = 0
	var/efficiency = 1
	var/intake_ratio = 0.1 // might add a way to adjust this in-game later

/obj/machinery/power/shuttle/engine/turbine/lavaland
	destroy_output = TRUE

/obj/machinery/power/compressor/Destroy()
	SSair.stop_processing_machine(src)
	if (turbine && turbine.compressor == src)
		turbine.compressor = null
	if(isopenturf(loc))
		loc.assume_air(gas_contained)
		loc.air_update_turf()
	turbine = null
	return ..()

/obj/machinery/power/shuttle/engine/turbine
	name = "gas turbine generator"
	desc = "A gas turbine used for backup power generation."
	icon = 'icons/obj/atmospherics/components/turbine.dmi'
	icon_state = "turbine"
	density = TRUE
	resistance_flags = FIRE_PROOF
	CanAtmosPass = ATMOS_PASS_DENSITY
	use_power = NO_POWER_USE // powered by gas flow
	interacts_with_air = TRUE
	circuit = /obj/item/circuitboard/machine/power_turbine
	thrust = 0 // no thrust by default
	icon_state_closed = "turbine"
	icon_state_open = "turbine"
	icon_state_off = "turbine"
	var/opened = 0
	var/obj/machinery/power/compressor/compressor
	var/lastgen = 0
	var/productivity = 1
	var/destroy_output = FALSE //Destroy the output gas instead of actually outputting it. Used on lavaland to prevent cooking the zlevel

/obj/machinery/power/shuttle/engine/turbine/Destroy()
	SSair.stop_processing_machine(src)
	if (compressor && compressor.turbine == src)
		compressor.turbine = null
	compressor = null
	return ..()

// the inlet stage of the gas turbine electricity generator

/obj/machinery/power/compressor/Initialize(mapload)
	. = ..()
	// The inlet of the compressor is the direction it faces
	gas_contained = new
	SSair.start_processing_machine(src, mapload)
	locate_machinery()
	if(!turbine)
		atom_break()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/power/compressor/LateInitialize()
	. = ..()
	var/turf/comp_turf = get_turf(src)
	comp_turf.ImmediateCalculateAdjacentTurfs() // turbine blocks atmos so update the turf it's on or stuff breaks

#define COMPFRICTION 5e5

/obj/machinery/power/compressor/locate_machinery()
	if(turbine)
		return
	turbine = locate() in get_step(src, turn(dir, 180))
	if(turbine)
		set_machine_stat(machine_stat & ~BROKEN)
		turbine.locate_machinery()
	else
		turbine = null
		atom_break()

/obj/machinery/power/compressor/RefreshParts()
	var/E = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		E += M.rating
	efficiency = max(E / 6, 1)

/obj/machinery/power/compressor/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: Efficiency at <b>[efficiency*100]%</b>.")

/obj/machinery/power/compressor/attackby(obj/item/I, mob/user, params)
	if(default_deconstruction_screwdriver(user, initial(icon_state), initial(icon_state), I))
		return

	if(default_change_direction_wrench(user, I))
		if(turbine)
			to_chat(user, span_notice("Turbine connected."))
			set_machine_stat(machine_stat & ~BROKEN)
		else
			to_chat(user, span_alert("Turbine not connected."))
		return

	default_deconstruction_crowbar(I)

/obj/machinery/power/compressor/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/I)
	. = ..()
	if(panel_open)
		set_machine_stat(machine_stat | MAINT)
	else
		set_machine_stat(machine_stat & ~MAINT)

//update when moved or changing direction
/obj/machinery/power/compressor/setDir(newdir)
	. = ..()
	locate_machinery()

/obj/machinery/power/compressor/Move(atom/newloc, direct, glide_size_override)
	. = ..()
	locate_machinery()

/obj/machinery/power/compressor/process(seconds_per_tick)
	return

/obj/machinery/power/compressor/process_atmos(seconds_per_tick)
	// RPM function to include compression friction - be advised that too low/high of a compfriction value can make things screwy
	rpm -= 1
	rpm = (0.9 * rpm) + (0.1 * rpmtarget)
	rpm = min(rpm, (COMPFRICTION*efficiency)/2)
	rpm = max(0, rpm - (rpm**2)/(COMPFRICTION*efficiency))

	update_overlays()

	if(!turbine || (turbine.machine_stat & BROKEN))
		locate_machinery() // try to find the other part if we somehow got disconnected

	if((machine_stat & (BROKEN|MAINT)) || !starter) // if we didn't find it...
		rpmtarget = 0
		return

	var/turf/inturf = get_step(src, dir)
	var/datum/gas_mixture/environment = inturf.return_air()
	var/external_pressure = environment.return_pressure()
	var/pressure_delta = external_pressure - gas_contained.return_pressure()

	// Equalize the gas between the environment and the internal gas mix
	if(pressure_delta > 0)
		var/datum/gas_mixture/removed = environment.remove_ratio((1 - ((1 - intake_ratio)**seconds_per_tick)) * pressure_delta / (external_pressure * 2)) // silly math to keep it consistent with seconds_per_tick
		gas_contained.merge(removed)
		inturf.air_update_turf()

/obj/machinery/power/compressor/update_overlays()
	. = ..()
	if(rpm>50000)
		add_overlay(mutable_appearance(icon, "comp-o4", FLY_LAYER))
	else if(rpm>10000)
		add_overlay(mutable_appearance(icon, "comp-o3", FLY_LAYER))
	else if(rpm>2000)
		add_overlay(mutable_appearance(icon, "comp-o2", FLY_LAYER))
	else if(rpm>500)
		add_overlay(mutable_appearance(icon, "comp-o1", FLY_LAYER))

// These are crucial to working of a turbine - the stats modify the power output. TurbGenQ modifies how much raw energy can you get from
// rpms, TurbGenG modifies the shape of the curve - the lower the value the less straight the curve is.

#define TURBGENQ 200000
#define TURBGENG 0.5
#define POWER_TO_THRUST 0.001 // power production to thrust ratio

/obj/machinery/power/shuttle/engine/turbine/Initialize(mapload)
	. = ..()
	SSair.start_processing_machine(src, mapload)
	locate_machinery()
	if(!compressor)
		atom_break()
	connect_to_network()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/power/shuttle/engine/turbine/LateInitialize()
	. = ..()
	var/turf/comp_turf = get_turf(src)
	comp_turf.ImmediateCalculateAdjacentTurfs() // turbine blocks atmos so update the turf it's on or stuff breaks

/obj/machinery/power/shuttle/engine/turbine/RefreshParts()
	var/P = 0
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		P += C.rating
	productivity = P / 6

/obj/machinery/power/shuttle/engine/turbine/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: Productivity at <b>[productivity*100]%</b>.")

/obj/machinery/power/shuttle/engine/turbine/locate_machinery()
	if(compressor)
		return
	compressor = locate() in get_step(src, turn(dir, 180))
	if(compressor)
		set_machine_stat(machine_stat & ~BROKEN)
		compressor.locate_machinery()
	else
		compressor = null
		atom_break()

/obj/machinery/power/shuttle/engine/turbine/process(seconds_per_tick)
	add_avail(lastgen) // add power in process() so it doesn't update power output separately from the rest of the powernet (bad)
	update_overlays()

/obj/machinery/power/shuttle/engine/turbine/process_atmos(seconds_per_tick)
	if(!compressor)
		set_machine_stat(BROKEN)
		locate_machinery() // try to find the missing piece

	if(machine_stat & (BROKEN|MAINT)) // we're only running half a turbine, don't continue
		return

	// This is the power generation function. If anything is needed it's good to plot it in EXCEL before modifying
	// the TURBGENQ and TURBGENG values

	lastgen = ((compressor.rpm / TURBGENQ)**TURBGENG) * TURBGENQ * productivity
	thrust = lastgen * POWER_TO_THRUST // second law

	var/turf/outturf = get_step(src, dir)
	if(!LAZYLEN(outturf.atmos_adjacent_turfs))
		compressor.rpmtarget = 0
		return

	// Move gas from the compressor to the outlet
	var/datum/gas_mixture/environment = outturf.return_air()
	var/internal_pressure = compressor.gas_contained.return_pressure()
	var/pressure_delta = internal_pressure - environment.return_pressure()

	// Now set the compressor's RPM target based on how much gas is flowing through
	compressor.rpmtarget = max(0, pressure_delta * compressor.gas_contained.return_volume() / (R_IDEAL_GAS_EQUATION * 4))

	// Equalize the gas between the internal gas mix and the environment
	if(pressure_delta > 0)
		var/datum/gas_mixture/removed = compressor.gas_contained.remove_ratio(pressure_delta / (internal_pressure * 2))
		if(destroy_output)
			qdel(removed)
			return
		outturf.assume_air(removed)
		outturf.air_update_turf()

// Return the current thrust amount
/obj/machinery/power/shuttle/engine/turbine/burn_engine(percentage, seconds_per_tick)
	return thrust * seconds_per_tick * (percentage / 100)

// Return the current power output
/obj/machinery/power/shuttle/engine/turbine/return_fuel()
	return lastgen

// Return the maximum power output
/obj/machinery/power/shuttle/engine/turbine/return_fuel_cap()
	return ((COMPFRICTION*(compressor ? compressor.efficiency : 1) / (TURBGENQ*4))**TURBGENG) * TURBGENQ * productivity

// Return the maximum power output
/obj/machinery/power/shuttle/engine/turbine/update_engine()
	if(!(flags_1 & INITIALIZED_1))
		return FALSE
	thruster_active = !panel_open && compressor
	return thruster_active

// If it works, put an overlay that it works!
/obj/machinery/power/shuttle/engine/turbine/update_overlays()
	. = ..()
	if(lastgen > 100)
		add_overlay(mutable_appearance(icon, "turb-o", FLY_LAYER))

/obj/machinery/power/shuttle/engine/turbine/attackby(obj/item/I, mob/user, params)
	if(default_deconstruction_screwdriver(user, initial(icon_state), initial(icon_state), I))
		return

	if(default_change_direction_wrench(user, I))
		if(compressor)
			to_chat(user, span_notice("Compressor connected."))
		else
			to_chat(user, span_alert("Compressor not connected."))
			atom_break()
		return

	default_deconstruction_crowbar(I)

/obj/machinery/power/shuttle/engine/turbine/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/I)
	. = ..()
	if(panel_open)
		set_machine_stat(machine_stat | MAINT)
	else
		set_machine_stat(machine_stat & ~MAINT)

// update if it moves or changes direction
/obj/machinery/power/shuttle/engine/turbine/setDir(newdir)
	. = ..()
	locate_machinery()

/obj/machinery/power/shuttle/engine/turbine/Move(atom/newloc, direct, glide_size_override)
	. = ..()
	locate_machinery()

/obj/machinery/power/shuttle/engine/turbine/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TurbineComputer", name)
		ui.open()

/obj/machinery/power/shuttle/engine/turbine/ui_data(mob/user)
	var/list/data = list()
	data["compressor"] = compressor ? TRUE : FALSE
	data["compressor_broke"] = (!compressor || (compressor.machine_stat & (BROKEN|MAINT))) ? TRUE : FALSE
	data["turbine"] = compressor?.turbine ? TRUE : FALSE
	data["turbine_broke"] = (!compressor || !compressor.turbine || (compressor.turbine.machine_stat & (BROKEN|MAINT))) ? TRUE : FALSE
	data["online"] = compressor?.starter
	data["power"] = DisplayPower(compressor?.turbine?.lastgen)
	data["rpm"] = compressor?.rpm
	data["temp"] = compressor?.gas_contained.return_temperature()
	data["pressure"] = compressor?.gas_contained.return_pressure()
	return data

/obj/machinery/power/shuttle/engine/turbine/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toggle_power")
			if(compressor && compressor.turbine)
				compressor.starter = !compressor.starter
				. = TRUE
		if("reconnect")
			locate_machinery()
			. = TRUE

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// COMPUTER NEEDS A SERIOUS REWRITE.

/obj/machinery/computer/turbine_computer
	name = "gas turbine control computer"
	desc = "A computer to remotely control a gas turbine."
	icon_screen = "turbinecomp"
	icon_keyboard = "tech_key"
	circuit = /obj/item/circuitboard/computer/turbine_computer
	var/obj/machinery/power/compressor/compressor
	var/id = 0

/obj/machinery/computer/turbine_computer/retro
	icon = 'icons/obj/machines/retro_computer.dmi'
	icon_state = "computer-retro"
	deconpath = /obj/structure/frame/computer/retro

/obj/machinery/computer/turbine_computer/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/turbine_computer/LateInitialize()
	locate_machinery()

/obj/machinery/computer/turbine_computer/locate_machinery()
	if(id)
		for(var/obj/machinery/power/compressor/C in SSair.atmos_air_machinery)
			if(C.comp_id == id)
				compressor = C
				return
	else
		compressor = locate(/obj/machinery/power/compressor) in range(7, src)

/obj/machinery/computer/turbine_computer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TurbineComputer", name)
		ui.open()

/obj/machinery/computer/turbine_computer/ui_data(mob/user)
	var/list/data = list()
	data["compressor"] = compressor ? TRUE : FALSE
	data["compressor_broke"] = (!compressor || (compressor.machine_stat & (BROKEN|MAINT))) ? TRUE : FALSE
	data["turbine"] = compressor?.turbine ? TRUE : FALSE
	data["turbine_broke"] = (!compressor || !compressor.turbine || (compressor.turbine.machine_stat & (BROKEN|MAINT))) ? TRUE : FALSE
	data["online"] = compressor?.starter
	data["power"] = DisplayPower(compressor?.turbine?.lastgen)
	data["rpm"] = compressor?.rpm
	data["temp"] = compressor?.gas_contained.return_temperature()
	data["pressure"] = compressor?.gas_contained.return_pressure()
	return data

/obj/machinery/computer/turbine_computer/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toggle_power")
			if(compressor && compressor.turbine)
				compressor.starter = !compressor.starter
				. = TRUE
		if("reconnect")
			locate_machinery()
			. = TRUE

#undef POWER_TO_THRUST
#undef COMPFRICTION
#undef TURBGENQ
#undef TURBGENG
