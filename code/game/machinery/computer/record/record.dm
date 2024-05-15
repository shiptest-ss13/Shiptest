/obj/machinery/computer/record//TODO:SANITY
	name = "records console"
	desc = "This can be used to check medical records."
	icon_screen = "medcomp"
	icon_keyboard = "med_key"
	req_one_access = list()
	circuit = /obj/item/circuitboard/computer
	var/rank = null
	var/screen = null
	var/datum/data/record/active1
	var/datum/data/record/active2
	var/temp = null
	var/printing = null
	//Sorting Variables
	var/sortBy = "name"
	var/order = 1 // -1 = Descending - 1 = Ascending
/*
	var/datum/overmap/ship/controlled/linked_libary

/obj/machinery/computer/record/initialize()
	. = ..()
	var/datum/overmap/ship/controlled/linked_ship = SSshuttle.get_ship(src)
	if(linked_ship)
		if(linked_ship.linked_libary)
			linked_libary = linked_ship.linked_libary
			return
*/

/obj/machinery/computer/record/proc/can_use_record_console(mob/user, message = 1, record1, record2)
	if(user)
		if(message)
			if(authenticated)
				if(user.canUseTopic(src, !issilicon(user)))
					if(!record1 || record1 == active1)
						if(!record2 || record2 == active2)
							return TRUE
	return FALSE
