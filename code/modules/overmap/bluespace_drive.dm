#define JUMP_STATE_OFF 0
#define JUMP_STATE_CHARGING 1
#define JUMP_STATE_IONIZING 2
#define JUMP_STATE_FIRING 3
#define JUMP_STATE_FINALIZED 4
#define JUMP_CHARGE_DELAY (7 SECONDS)
#define JUMP_CHARGEUP_TIME (1 MINUTES)

/*
* Unfinished, for now it's nice decor for mappers.
* * Originally I was going to move the bluespace jump behavior otnot this device, then i realized this would require a lot of remapping, so I left it on the
*/

/obj/machinery/bluespace_drive
	name = "AU/W-class bluespace drive"
	desc = "Amazing innovations after studying the solarian sun have now compacted the massive AU-class bluespace rooms of the past into barely a 2 meter big machine. This in turn, vastly reduced vessel sizes, resulting in a new age of space travel across the cosmos... and here the miracle sits silently, gathering dust as you forgot to clean it last week."
	icon = 'icons/obj/machines/bsdrive.dmi'
	icon_state = "bsdrive_left"
	var/icon_screen = "bsdrive_left_screen"
	circuit = /obj/item/circuitboard/computer/shuttle
	light_color = LIGHT_COLOR_CYAN
	clicksound = null
	density = TRUE

	/// The ship we reside on for ease of access
	var/datum/overmap/ship/controlled/current_ship

/obj/machinery/bluespace_drive/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	current_ship = port.current_ship
	if(current_ship)
		current_ship.ship_modules[SHIPMODULE_BSDRIVE] = src

/obj/machinery/bluespace_drive/Destroy()
	if(current_ship)
		LAZYREMOVE(current_ship.ship_modules, src)
		current_ship = null
	return ..()

#undef JUMP_STATE_OFF
#undef JUMP_STATE_CHARGING
#undef JUMP_STATE_IONIZING
#undef JUMP_STATE_FIRING
#undef JUMP_STATE_FINALIZED
#undef JUMP_CHARGE_DELAY
#undef JUMP_CHARGEUP_TIME
