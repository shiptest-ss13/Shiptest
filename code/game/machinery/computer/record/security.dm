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

/obj/machinery/computer/records/sec/ui_data(mob/user)
	var/list/data = ..()

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
			security_note = target.fields[DATACORE_NOTES_SECURITY],
		))

	data["records"] = records

	return data

/obj/machinery/computer/records/sec/ui_static_data(mob/user)
	var/list/data = list()
	data["min_age"] = AGE_MIN
	data["max_age"] = AGE_MAX
	data["available_statuses"] = WANTED_STATUSES
	return data

/obj/machinery/computer/records/sec/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	var/mob/user = ui.user

	var/datum/data/record/target
	if(params["record_ref"])
		target = locate(params["record_ref"]) in SSdatacore.get_records(linked_ship)

	if(!target)
		return FALSE

	switch(action)
		if("add_crime")
			//add_crime(user, target, params)
			return TRUE

		if("edit_crime")
			//edit_crime(user, target, params)
			return TRUE

		if("invalidate_crime")
			//invalidate_crime(user, target, params)
			return TRUE

		if("set_note")
			var/note = trim(params["security_note"], MAX_MESSAGE_LEN)
			investigate_log("[user] has changed the security note of record: \"[target]\" from \"[target.fields[DATACORE_NOTES_SECURITY]]\" to \"[note]\".")
			target.fields[DATACORE_NOTES_SECURITY] = note
			return TRUE

		if("set_wanted_status")
			var/wanted_status = params["wanted_status"]
			if(!wanted_status || !(wanted_status in WANTED_STATUSES))
				return FALSE

			investigate_log("[target.name] has been set from [target.fields[DATACORE_CRIMINAL_STATUS]] to [wanted_status] by [key_name(usr)].", INVESTIGATE_RECORDS)
			target.fields[DATACORE_CRIMINAL_STATUS] = wanted_status

			return TRUE

	return FALSE

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
