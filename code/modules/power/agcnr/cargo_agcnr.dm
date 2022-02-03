// Cargo AGCNR stuff. For when you want a reactor on your ship but don't have one.

/obj/item/survivalcapsule/reactor
	name = "AGCNR Reactor Beacon"
	desc = "A special bluespace beacon designed to teleport a reactor assembly to the ship that it is activated on.<br><b>WARNING: When deployed, the reactor's area must be manually connected to the ship's area network for proper power and gravity functionality.</b>"
	icon = 'icons/obj/device.dmi'
	icon_state = "beacon"
	template_id = "reactor"

/datum/map_template/shelter/reactor
	name = "RBMK Reactor"
	shelter_id = "reactor"
	description = "A reactor core, coolant and moderator loop not included."
	mappath = "_maps/templates/reactor_1.dmm"

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/cargo

/obj/machinery/atmospherics/components/trinary/nuclear_reactor/cargo/Initialize()
	. = ..()
	id = rand(1, 1000000) // Gives a random ID for our new reactor.

/obj/machinery/computer/reactor/cargo
	anchored = FALSE
	id = null

/obj/machinery/computer/reactor/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_WRENCH)
		to_chat(user, "<span class='notice'>You [!anchored ? "secure \the [src] in place."  : "remove the securing bolts."]</span>")
		anchored = !anchored
		density = anchored
		I.play_tool_sound(src)
		return TRUE
	. = ..()

/obj/machinery/computer/reactor/control_rods/cargo
	anchored = FALSE
	id = null

/obj/machinery/computer/reactor/stats/cargo
	anchored = FALSE
	id = null

/obj/machinery/computer/reactor/fuel_rods/cargo
	anchored = FALSE
	id = null
