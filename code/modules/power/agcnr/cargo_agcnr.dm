// Cargo AGCNR stuff. For when you want a reactor on your ship but don't have one.

/obj/item/survivalcapsule/reactor
	name = "AGCNR Reactor Beacon"
	desc = "A special bluespace beacon designed to teleport a reactor assembly to the ship that it is activated on."
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

/obj/machinery/computer/reactor/control_rods/cargo
	anchored = FALSE
	id = null

/obj/machinery/computer/reactor/stats/cargo
	anchored = FALSE
	id = null

/obj/machinery/computer/reactor/fuel_rods/cargo
	anchored = FALSE
	id = null
