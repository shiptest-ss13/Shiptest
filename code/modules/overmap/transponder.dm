/*
* Unfinished, for now it's nice decor for mappers
* * Planned for starsector-esque 'going dark' mechanics and ATC larping with this, but it's best i leave it for later. Still, might as well make mappers happy!
*/
/obj/machinery/computer/transponder
	name = "Transponder"
	desc = "Used to control the ship's communications systems, allegedly."
	icon = 'icons/obj/machines/transponder.dmi'
	icon_state = "transponder"
	icon_screen = "transponder-screen"
	icon_keyboard = null
	circuit = /obj/item/circuitboard/computer/shuttle
	light_color = LIGHT_COLOR_GREEN
	clicksound = null

	/// The ship we reside on for ease of access
	var/datum/overmap/ship/controlled/current_ship

/obj/machinery/computer/transponder/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	current_ship = port.current_ship
	if(current_ship)
		current_ship.ship_modules[SHIPMODULE_TRANSPONDER] = src

/obj/machinery/computer/transponder/Destroy()
	if(current_ship)
		LAZYREMOVE(current_ship.ship_modules, src)
		current_ship = null
	return ..()
