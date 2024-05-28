

/obj/machinery/computer/records/med//TODO:SANITY
	name = "medical records console"
	desc = "This can be used to check medical records."
	icon_screen = "medcomp"
	icon_keyboard = "med_key"
	req_one_access = list(ACCESS_MEDICAL, ACCESS_FORENSICS_LOCKERS)
	circuit = /obj/item/circuitboard/computer/med_data
	light_color = LIGHT_COLOR_BLUE

/obj/machinery/computer/records/med/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(.)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "MedicalRecords")
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/computer/records/med/ui_data(mob/user)
	var/list/data = ..()

	var/list/records = list()
	for(var/datum/data/record/target in SSdatacore.get_records(linked_ship))
		records += list(list(
			age = target.fields[DATACORE_AGE],
			blood_type = target.fields[DATACORE_BLOOD_TYPE],
			record_ref = REF(target),
			dna = target.fields[DATACORE_BLOOD_DNA],
			gender = target.fields[DATACORE_GENDER],
			disabilities = target.fields[DATACORE_DISABILITIES],
			physical_status = target.fields[DATACORE_PHYSICAL_HEALTH],
			mental_status = target.fields[DATACORE_MENTAL_HEALTH],
			name = target.fields[DATACORE_NAME],
			rank = target.fields[DATACORE_RANK],
			species = target.fields[DATACORE_SPECIES],
		))

	data["records"] = records

	return data

/obj/machinery/computer/records/med/ui_static_data(mob/user)
	var/list/data = list()
	data["min_age"] = AGE_MIN
	data["max_age"] = AGE_MAX
	data["physical_statuses"] = PHYSICAL_STATUSES
	data["mental_statuses"] = MENTAL_STATUSES
	return data

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

