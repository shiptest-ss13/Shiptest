/obj/machinery/computer/records/sec//TODO:SANITY
	name = "security records console"
	desc = "Used to view and edit personnel's security records."
	icon_screen = "security"
	icon_keyboard = "security_key"
	req_one_access = list(ACCESS_SECURITY, ACCESS_FORENSICS_LOCKERS)
	circuit = /obj/item/circuitboard/computer/secure_data
	light_color = COLOR_SOFT_RED

/obj/machinery/computer/records/sec/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(.)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "SecurityRecords")
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/machinery/computer/records/med/ui_data(mob/user)
	var/list/data = ..()

	data["available_statuses"] = WANTED_STATUSES()
	data["current_user"] = user.name

	var/list/records = list()
	for(var/datum/data/record/target in SSdatacore.get_records(linked_ship))
		var/list/crimes = list()
		for(var/datum/data/crime/crime in target.fields[DATACORE_CRIMES])
			crimes += list(list(
				author = crime.author,
				crime_ref = REF(crime),
				details = crime.crimeDetails,
				name = crime.crimeName,
				time = crime.time,
			))
		records += list(list(
			age = target.fields[DATACORE_AGE],
			record_ref = REF(target),
			fingerprint = target.fields[DATACORE_FINGERPRINT],
			gender = target.fields[DATACORE_GENDER],
			name = target.fields[DATACORE_NAME],
			rank = target.fields[DATACORE_RANK],
			species = target.fields[DATACORE_SPECIES],
			wanted_status = target.fields[DATACORE_CRIMINAL_STATUS],
		))

	data["records"] = records

	return data

/obj/machinery/computer/records/sec/syndie
	icon_keyboard = "syndie_key"

/obj/machinery/computer/records/sec/laptop
	name = "security laptop"
	desc = "A cheap Nanotrasen security laptop, it functions as a security records console. It's bolted to the table."
	icon_state = "laptop"
	icon_screen = "seclaptop"
	icon_keyboard = "laptop_key"
	pass_flags = PASSTABLE
	unique_icon = TRUE
