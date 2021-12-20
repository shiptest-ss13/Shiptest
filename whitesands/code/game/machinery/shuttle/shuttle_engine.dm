/**
  * ## Engine Thrusters
  * The workhorse of any movable ship, these engines (usually) take in some kind fuel and produce thrust to move ships.
  *
  */
/obj/machinery/power/shuttle/engine
	name = "shuttle thruster"
	desc = "A thruster for shuttles."
	circuit = /obj/item/circuitboard/machine/shuttle/engine
	CanAtmosPass = FALSE //so people can actually tend to their engines
	/// Used to determine whether the engine is considered "on" or "off".
	var/thruster_active = FALSE
	/// Used by the ship component to selectively fire engines.
	/// If false, the engine will fire, even if other engines might.
	var/enabled = TRUE
	/// Used by subtypes as part of determining "true" thrust.
	var/thrust = 0 * FORCE_TON_GM_PER_SEC_SQUARE

// these 3 procs are organized in the order they'll likely be called
/obj/machinery/power/shuttle/engine/Initialize()
	. = ..()
	update_icon_state()

/obj/machinery/power/shuttle/engine/connect_to_shuttle(obj/docking_port/mobile/port)
	LAZYADD(port.ship_comp?.engine_list, src)

// DEBUG REMOVE -- not sure if this is necessary; seems like it'd maybe be already done in Initialize()?
/obj/machinery/power/shuttle/engine/on_construction()
	. = ..()
	update_icon_state()

/obj/machinery/power/shuttle/engine/Destroy()
	. = ..()
	var/obj/docking_port/mobile/port = SSshuttle.get_containing_shuttle(src)
	if(port && port.ship_comp)
		LAZYREMOVE(port.ship_comp.engine_list, src)

/obj/machinery/power/shuttle/engine/update_icon_state()
	update_engine() //Calls this so it sets the accurate icon
	if(panel_open)
		icon_state = icon_state_open
	else if(thruster_active)
		icon_state = icon_state_closed
	else
		icon_state = icon_state_off

/obj/machinery/power/shuttle/engine/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(do_after(user, MIN_TOOL_SOUND_DELAY, target=src))
		enabled = !enabled
		to_chat(user, "<span class='notice'>You [enabled ? "enable" : "disable"] [src].")

/**
  * Updates the engine state, used to determine the engine's icon.
  * All functions should return if the parent function returns false.
  */
/obj/machinery/power/shuttle/engine/proc/update_engine()
	SHOULD_CALL_PARENT(TRUE)
	thruster_active = !panel_open
	return thruster_active

/**
  * Burns an amount of fuel influenced by the given pow_coeff.
  * Returns the thrust generated.
  *
  * Arguments:
  * * pow_coeff - Non-negative number representing burn power, where 1 is "full" power. May be higher than 1.
  */
/obj/machinery/power/shuttle/engine/proc/burn_engine(pow_coeff)
	update_icon_state()
	return 0

/**
  * Returns how much fuel is left as a fraction between 0 (empty) and 1 (full), or null if N/A.
  */
/obj/machinery/power/shuttle/engine/proc/return_fuel()
	return null
