

/obj/machinery/computer/records/med//TODO:SANITY
	name = "medical records console"
	desc = "This can be used to check medical records."
	icon_screen = "medcomp"
	icon_keyboard = "med_key"
	req_one_access = list(ACCESS_MEDICAL, ACCESS_FORENSICS_LOCKERS)
	circuit = /obj/item/circuitboard/computer/med_data
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/computer/records/med/syndie
	icon_keyboard = "syndie_key"

/obj/machinery/computer/records/med/laptop
	name = "medical laptop"
	desc = "A cheap Nanotrasen medical laptop, it functions as a medical records computer. It's bolted to the table."
	icon_state = "laptop"
	icon_screen = "medlaptop"
	icon_keyboard = "laptop_key"
	pass_flags = PASSTABLE
	unique_icon = TRUE
