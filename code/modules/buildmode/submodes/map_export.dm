/datum/buildmode_mode/export
	key = "export"

	use_corner_selection = TRUE

	var/shuttle_flag = SAVE_SHUTTLEAREA_DONTCARE
	var/save_flag = SAVE_ALL
	var/static/is_running = FALSE

/datum/buildmode_mode/export/change_settings(client/c)
	var/static/list/options = list("Object Saving" = SAVE_OBJECTS,
									"Mob Saving" = SAVE_MOBS,
									"Turf Saving" = SAVE_TURFS,
									"Area Saving" = SAVE_AREAS,
									"Space Turf Saving" = SAVE_SPACE,
									"Object Property Saving" = SAVE_OBJECT_PROPERTIES)
	var/what_to_change = tgui_input_list(c, "What export setting would you like to toggle?", "Map Exporter", options)
	save_flag ^= options[what_to_change]
	to_chat(c, "<span class='notice'>[what_to_change] is now [save_flag & options[what_to_change] ? "ENABLED" : "DISABLED"].</span>")

/datum/buildmode_mode/export/show_help(client/c)
	to_chat(c, "<span class='notice'>***********************************************************</span>")
	to_chat(c, "<span class='notice'>Left Mouse Button on turf/obj/mob      = Select corner</span>")
	to_chat(c, "<span class='notice'>Right Mouse Button on buildmode button = Set export options</span>")
	to_chat(c, "<span class='notice'>***********************************************************</span>")

/datum/buildmode_mode/export/handle_selected_area(client/c, params)
	var/list/pa = params2list(params)
	var/left_click = pa.Find("left")

	//Ensure the selection is actually done
	if(!left_click)
		to_chat(usr, "<span class='warning'>Invalid selection.</span>")
		return

	//If someone somehow gets build mode, stop them from using this.
	if(!check_rights(R_ADMIN))
		message_admins("[ckey(usr)] tried to run the map save generator but was rejected due to insufficient perms.")
		to_chat(usr, "<span class='warning'>You must have +ADMIN rights to use this.</span>")
		return
	//Emergency check
	if(get_dist(cornerA, cornerB) > 60 || cornerA.z != cornerB.z)
		var/confirm = alert("Are you sure about this? Exporting large maps may take quite a while.", "Map Exporter", "Yes", "No")
		if(confirm != "Yes")
			return

	if(cornerA == cornerB)
		return

	if(is_running)
		to_chat(usr, "<span class='warning'>Someone is already running the generator! Try again in a little bit.</span>")
		return

	to_chat(usr, "<span class='warning'>Saving, please wait...</span>")
	is_running = TRUE

	log_admin("Build Mode: [key_name(c)] is exporting the map area from [AREACOORD(cornerA)] through [AREACOORD(cornerB)]") //I put this before the actual saving of the map because it likely won't log if it crashes the fucking server

	//oversimplified for readability and understandibility

	var/minx = min(cornerA.x, cornerB.x)
	var/miny = min(cornerA.y, cornerB.y)
	var/minz = min(cornerA.z, cornerB.z)

	var/maxx = max(cornerA.x, cornerB.x)
	var/maxy = max(cornerA.y, cornerB.y)
	var/maxz = max(cornerA.z, cornerB.z)

	//Step 1: Get the data (This can take a while)
	var/dat = write_map(minx, miny, minz, maxx, maxy, maxz, save_flag, shuttle_flag)

	//Step 2: Write the data to a file
	var/filedir = file("data/exported-map.dmm")
	if(fexists(filedir))
		fdel(filedir)
	WRITE_FILE(filedir, "[dat]")

	//Step 3: Give the file to client for download
	usr << ftp(filedir)

	//Step 4: Remove the file from the server (hopefully we can find a way to avoid step)
	fdel(filedir)
	alert("Area saved successfully.", "Action Successful!", "Ok")
	is_running = FALSE
