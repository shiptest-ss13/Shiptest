/obj/machinery/computer/records
	name = "records console"
	desc = "This can be used to check records."
	icon_screen = "medcomp"
	icon_keyboard = "med_key"
	req_one_access = list()
	circuit = /obj/item/circuitboard/computer
	var/datum/overmap/ship/controlled/linked_ship

/obj/machinery/computer/records/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	linked_ship = port.current_ship

/obj/machinery/computer/records/disconnect_from_shuttle(obj/docking_port/mobile/port)
	. = ..()
	linked_ship = null

/*
/obj/machinery/computer/records/attacked_by(obj/item/attacking_item, mob/living/user)
	. = ..()
	if(!istype(attacking_item, /obj/item/photo))
		return
	insert_new_record(user, attacking_item)
*/

/obj/machinery/computer/records/ui_data(mob/user)
	var/list/data = ..()

	var/has_access = (authenticated && isliving(user)) || isAdminGhostAI(user)
	data["authenticated"] = has_access
	data["library_name"] = linked_ship.name
	if(!has_access)
		return data

	return data

/obj/machinery/computer/records/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	var/mob/user = ui.user

	var/datum/data/record/target
	if(params["record_ref"])
		target = locate(params["record_ref"]) in SSdatacore.get_records(linked_ship)

	switch(action)
		if("expunge_record")
			if(!target)
				return FALSE

			expunge_record_info(target)
			balloon_alert(user, "record expunged")
			investigate_log("[key_name(user)] expunged the record of [target[DATACORE_NAME]].", INVESTIGATE_RECORDS)
			return TRUE

		if("purge_records")
			SSdatacore.wipe_records(linked_ship)
			return TRUE

		if("new_record")
			var/name = stripped_input(user, "Enter the name of the new record.", "New Record", "", MAX_NAME_LEN)
			if(!name)
				return FALSE

			SSdatacore.create_record(linked_ship, name)
			balloon_alert(user, "record created")
			return TRUE

		if("login")
			authenticated = secure_login(usr)
			investigate_log("[key_name(usr)] [authenticated ? "successfully logged" : "failed to log"] into the [src].", INVESTIGATE_RECORDS)
			return TRUE

		if("logout")
			balloon_alert(usr, "logged out")
			playsound(src, 'sound/machines/terminal_off.ogg', 70, TRUE)
			authenticated = FALSE

			return TRUE

		if("edit_field")
			target = locate(params["ref"]) in SSdatacore.get_records(linked_ship)
			var/field = params["field"]
			if(!field || !(field in target.fields))
				return FALSE

			var/value = trim(params["value"], MAX_BROADCAST_LEN)
			investigate_log("[key_name(usr)] changed the field: \"[field]\" with value: \"[target.fields[field]]\" to new value: \"[value || "Unknown"]\"", INVESTIGATE_RECORDS)
			target.fields[field] = value || "Unknown"

			return TRUE

		if("view_record")
			if(!target)
				return FALSE

			playsound(src, "sound/machines/terminal_button0[rand(1, 8)].ogg", 50, TRUE)
			balloon_alert(usr, "viewing record for [target.fields[DATACORE_NAME]]")
			return TRUE

	return FALSE

/obj/machinery/computer/records/proc/secure_login(mob/user)
	if(!is_operational)
		return FALSE

	if(!allowed(user))
		balloon_alert(user, "access denied")
		return FALSE

	balloon_alert(user, "logged in")
	playsound(src, 'sound/machines/terminal_on.ogg', 70, TRUE)

	return TRUE

/// Deletes medical information from a record.
/obj/machinery/computer/records/proc/expunge_record_info(datum/data/record/target)
	if(!target)
		return FALSE

	target.fields[DATACORE_NAME] = "Unknown"
	target.fields[DATACORE_AGE] = 18
	target.fields[DATACORE_GENDER] = "Unknown"
	target.fields[DATACORE_SPECIES] = "Unknown"
	target.fields[DATACORE_BLOOD_TYPE] = pick(list("A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"))
	target.fields[DATACORE_BLOOD_DNA] = "Unknown"
	target.fields[DATACORE_DISABILITIES] = ""
	target.fields[DATACORE_DISABILITIES_DETAILS] = ""
	target.fields[DATACORE_PHYSICAL_HEALTH] = ""
	target.fields[DATACORE_MENTAL_HEALTH] = ""
	target.fields[DATACORE_RANK] = "Unknown"

	return TRUE

/*
/obj/machinery/computer/records/proc/insert_new_record(mob/user, obj/item/photo/mugshot)
	if(!mugshot || !is_operational)
		return FALSE

	if(!authenticated && !allowed(user))
		balloon_alert(user, "access denied")
		playsound(src, 'sound/machines/terminal_error.ogg', 70, TRUE)
		return FALSE

	if(mugshot.picture.psize_x > world.icon_size || mugshot.picture.psize_y > world.icon_size)
		balloon_alert(user, "photo too large!")
		playsound(src, 'sound/machines/terminal_error.ogg', 70, TRUE)
		return FALSE

	var/trimmed = copytext(mugshot.name, 9, MAX_NAME_LEN) // Remove "photo - "
	var/name = stripped_input(user, "Enter the name of the new record.", "New Record", trimmed, MAX_NAME_LEN)
	if(!name || !is_operational || !mugshot || QDELETED(mugshot) || QDELETED(src))
		return FALSE

	var/datum/data/record/new_record = SSdatacore.create_record(linked_ship, name)
	new_record.fields[DATACORE_APPEARANCE] = mugshot.picture.picture_image
	balloon_alert(user, "record created")
	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 70, TRUE)

	qdel(mugshot)

	return TRUE
*/
