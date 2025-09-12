
//allows a client to trigger an event
//aka Badmin Central
/client/proc/force_event()
	set name = "Trigger Event"
	set category = "Event"
	set desc = "Forces an event to occur."

	if(!holder ||!check_rights(R_FUN))
		return

	holder.force_event()

/datum/admins/proc/force_event()
	var/dat 	= ""
	var/normal 	= ""
	var/magic 	= ""
	var/holiday = ""
	for(var/datum/round_event_control/E in SSevents.control)
		dat = "<BR><A href='byond://?src=[REF(src)];[HrefToken()];forceevent=[REF(E)]'>[E]</A> Weight:[E.weight] Max Occurances:[E.max_occurrences]"
		if(E.category == EVENT_CATEGORY_HOLIDAY)
			holiday	+= dat
		else if(E.category == EVENT_CATEGORY_ADMINBUS)
			magic 	+= dat
		else
			normal 	+= dat

	dat = normal + "<BR>" + magic + "<BR>" + holiday

	var/datum/browser/popup = new(usr, "forceevent", "Force Random Event", 300, 750)
	popup.set_content(dat)
	popup.open()
