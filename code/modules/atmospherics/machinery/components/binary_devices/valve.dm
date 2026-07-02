/*
It's like a regular ol' straight pipe, but you can turn it on and off.
*/

/obj/machinery/atmospherics/components/binary/valve
	icon_state = "mvalve_map-3"

	name = "manual valve"
	desc = "A pipe with a valve that can be used to disable flow of gas through it."

	can_unwrench = TRUE
	shift_underlay_only = FALSE

	interaction_flags_machine = INTERACT_MACHINE_UNPOWERED | INTERACT_MACHINE_OPEN //Intentionally no allow_silicon flag
	pipe_flags = PIPING_CARDINAL_AUTONORMALIZE

	var/frequency = 0
	var/id = null

	var/has_interact_delay = TRUE


	var/valve_type = "m" //lets us have a nice, clean, OOP update_icon_nopipes()
	/// prefix for overlay, avoids shit ton of sprite reuse
	var/valve_overlay_prefix = "red"

	construction_type = /obj/item/pipe/binary
	pipe_state = "mvalve"

	var/switching = FALSE
	var/togglesound = 'sound/effects/bin_open.ogg'
	var/sound_vol = 100

	var/mutable_appearance/valve_handle = null

/obj/machinery/atmospherics/components/binary/valve/Initialize()
	. = ..()
	if(valve_overlay_prefix)
		valve_handle = mutable_appearance(icon, "[valve_overlay_prefix]-[set_overlay_offset(piping_layer)]")

/obj/machinery/atmospherics/components/binary/valve/update_icon_nopipes()
	normalize_cardinal_directions()
	cut_overlays()
	//why isnt the offset set manually like other atmos shit? oldcode everyone...
	icon_state = "[valve_type]valve_[on ? "on" : "off"]-[set_overlay_offset(piping_layer)]"
	if(!valve_overlay_prefix)
		return
	add_overlay(valve_handle)

/obj/machinery/atmospherics/components/binary/valve/proc/toggle()
	if(on)
		on = FALSE
		update_icon_nopipes()
		investigate_log("was closed by [usr ? key_name(usr) : "a remote signal"]", INVESTIGATE_ATMOS)
	else
		on = TRUE
		update_icon_nopipes()
		update_parents()
		var/datum/pipeline/parent1 = parents[1]
		parent1.reconcile_air()
		investigate_log("was opened by [usr ? key_name(usr) : "a remote signal"]", INVESTIGATE_ATMOS)
	playsound(loc, togglesound, sound_vol, TRUE)

/obj/machinery/atmospherics/components/binary/valve/interact(mob/user)
	add_fingerprint(usr)
	if(switching)
		return
	if(has_interact_delay)
		visible_message(span_notice("[user] starts to turn \the [src]..."), span_notice("You start to turn \the [src]..."), span_notice("You hear creaking metal."))

		switching = TRUE
		if(!do_after(user, 5 SECONDS, src))
			switching = FALSE
			return
	if(in_range(src, user))
		if(has_interact_delay)
			visible_message(span_notice("[user] finishes turning \the [src]."), span_notice("You finish turning \the [src]."), span_notice("You hear hissing."))
		else
			visible_message(span_notice("[user] toggles \the [src] with a button press."), span_notice("You toggle \the [src]."), span_notice("You hear a click followed by a beep."))
	else
		visible_message(span_notice("[src] silently beeps."), blind_message=span_notice("You hear a silent beep."))
	update_icon_nopipes()
	toggle()
	switching = FALSE

/obj/machinery/atmospherics/components/binary/valve/Destroy()
	. = ..()
	if(valve_handle)
		QDEL_NULL(valve_handle)

/obj/machinery/atmospherics/components/binary/valve/digital // can be controlled by AI
	icon_state = "dvalve_map-3"

	name = "digital valve"
	desc = "A digitally controlled valve."
	valve_type = "d"
	pipe_state = "dvalve"

	valve_overlay_prefix = FALSE

	has_interact_delay = FALSE

	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_UNPOWERED | INTERACT_MACHINE_OPEN | INTERACT_MACHINE_OPEN_SILICON

	togglesound = 'sound/machines/triple_beep.ogg'
	sound_vol = 40

/obj/machinery/atmospherics/components/binary/valve/digital/update_icon_nopipes(animation)
	if(!is_operational)
		normalize_cardinal_directions()
		icon_state = "dvalve_nopower-[set_overlay_offset(piping_layer)]"
		return
	..()

/obj/machinery/atmospherics/components/binary/valve/digital/toggle()
	use_power(ACTIVE_DRAW_MINIMAL)
	. = ..()

/obj/machinery/atmospherics/components/binary/valve/digital/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(prob(50) && is_operational)
		toggle()

/obj/machinery/atmospherics/components/binary/valve/layer1
	piping_layer = 1
	icon_state = "mvalve_map-1"

/obj/machinery/atmospherics/components/binary/valve/layer2
	piping_layer = 2
	icon_state = "mvalve_map-2"

/obj/machinery/atmospherics/components/binary/valve/layer4
	piping_layer = 4
	icon_state = "mvalve_map-4"

/obj/machinery/atmospherics/components/binary/valve/layer5
	piping_layer = 5
	icon_state = "mvalve_map-5"

/obj/machinery/atmospherics/components/binary/valve/on
	on = TRUE

/obj/machinery/atmospherics/components/binary/valve/on/layer1
	piping_layer = 1
	icon_state = "mvalve_map-1"

/obj/machinery/atmospherics/components/binary/valve/on/layer2
	piping_layer = 2
	icon_state = "mvalve_map-2"

/obj/machinery/atmospherics/components/binary/valve/on/layer4
	piping_layer = 4
	icon_state = "mvalve_map-4"

/obj/machinery/atmospherics/components/binary/valve/on/layer5
	piping_layer = 5
	icon_state = "mvalve_map-5"

//blue
/obj/machinery/atmospherics/components/binary/valve/blue
	valve_overlay_prefix = "blue"
	icon_state = "mvalve_blue_map-3"

/obj/machinery/atmospherics/components/binary/valve/blue/layer1
	piping_layer = 1
	icon_state = "mvalve_blue_map-1"

/obj/machinery/atmospherics/components/binary/valve/blue/layer2
	piping_layer = 2
	icon_state = "mvalve_blue_map-2"

/obj/machinery/atmospherics/components/binary/valve/blue/layer4
	piping_layer = 4
	icon_state = "mvalve_blue_map-4"

/obj/machinery/atmospherics/components/binary/valve/blue/layer5
	piping_layer = 5
	icon_state = "mvalve_blue_map-5"

/obj/machinery/atmospherics/components/binary/valve/blue/on
	on = TRUE

/obj/machinery/atmospherics/components/binary/valve/blue/on/layer1
	piping_layer = 1
	icon_state = "mvalve_blue_map-1"

/obj/machinery/atmospherics/components/binary/valve/blue/on/layer2
	piping_layer = 2
	icon_state = "mvalve_blue_map-2"

/obj/machinery/atmospherics/components/binary/valve/blue/on/layer4
	piping_layer = 4
	icon_state = "mvalve_blue_map-4"

/obj/machinery/atmospherics/components/binary/valve/blue/on/layer5
	piping_layer = 5
	icon_state = "mvalve_blue_map-5"

//yellow

/obj/machinery/atmospherics/components/binary/valve/yellow
	valve_overlay_prefix = "yellow"
	icon_state = "mvalve_yellow_map-3"

/obj/machinery/atmospherics/components/binary/valve/yellow/layer1
	piping_layer = 1
	icon_state = "mvalve_yellow_map-1"

/obj/machinery/atmospherics/components/binary/valve/yellow/layer2
	piping_layer = 2
	icon_state = "mvalve_yellow_map-2"

/obj/machinery/atmospherics/components/binary/valve/yellow/layer4
	piping_layer = 4
	icon_state = "mvalve_yellow_map-4"

/obj/machinery/atmospherics/components/binary/valve/yellow/layer5
	piping_layer = 5
	icon_state = "mvalve_yellow_map-5"

/obj/machinery/atmospherics/components/binary/valve/yellow/on
	on = TRUE

/obj/machinery/atmospherics/components/binary/valve/yellow/on/layer1
	piping_layer = 1
	icon_state = "mvalve_yellow_map-1"

/obj/machinery/atmospherics/components/binary/valve/yellow/on/layer2
	piping_layer = 2
	icon_state = "mvalve_yellow_map-2"

/obj/machinery/atmospherics/components/binary/valve/yellow/on/layer4
	piping_layer = 4
	icon_state = "mvalve_yellow_map-4"

/obj/machinery/atmospherics/components/binary/valve/yellow/on/layer5
	piping_layer = 5
	icon_state = "mvalve_yellow_map-5"

//green

/obj/machinery/atmospherics/components/binary/valve/green
	valve_overlay_prefix = "green"
	icon_state = "mvalve_green_map-3"

/obj/machinery/atmospherics/components/binary/valve/green/layer1
	piping_layer = 1
	icon_state = "mvalve_green_map-1"

/obj/machinery/atmospherics/components/binary/valve/green/layer2
	piping_layer = 2
	icon_state = "mvalve_green_map-2"

/obj/machinery/atmospherics/components/binary/valve/green/layer4
	piping_layer = 4
	icon_state = "mvalve_green_map-4"

/obj/machinery/atmospherics/components/binary/valve/green/layer5
	piping_layer = 5
	icon_state = "mvalve_green_map-5"

/obj/machinery/atmospherics/components/binary/valve/green/on
	on = TRUE

/obj/machinery/atmospherics/components/binary/valve/green/on/layer1
	piping_layer = 1
	icon_state = "mvalve_green_map-1"

/obj/machinery/atmospherics/components/binary/valve/green/on/layer2
	piping_layer = 2
	icon_state = "mvalve_green_map-2"

/obj/machinery/atmospherics/components/binary/valve/green/on/layer4
	piping_layer = 4
	icon_state = "mvalve_green_map-4"

/obj/machinery/atmospherics/components/binary/valve/green/on/layer5
	piping_layer = 5
	icon_state = "mvalve_green_map-5"

/obj/machinery/atmospherics/components/binary/valve/digital/layer2
	piping_layer = 2
	icon_state = "dvalve_map-2"

/obj/machinery/atmospherics/components/binary/valve/digital/layer4
	piping_layer = 4
	icon_state = "dvalve_map-4"

/obj/machinery/atmospherics/components/binary/valve/digital/on
	on = TRUE

/obj/machinery/atmospherics/components/binary/valve/digital/on/layer2
	piping_layer = 2
	icon_state = "dvalve_map-2"

/obj/machinery/atmospherics/components/binary/valve/digital/on/layer4
	piping_layer = 4
	icon_state = "dvalve_map-4"
