/obj/machinery/status_display
	icon = 'starbloom_modules/aesthetics/status_display/icons/status_display.dmi'

/obj/machinery/status_display/LateInitialize()
	. = ..()
	set_picture("default")

/obj/machinery/status_display/syndie
	name = "syndicate status display"

/obj/machinery/status_display/syndie/LateInitialize()
	. = ..()
	set_picture("synd")
