/datum/buildmode_mode/export
	key = "export"

	use_corner_selection = TRUE

/datum/buildmode_mode/export/show_help(client/c)
	to_chat(c, "<span class='notice'>***********************************************************</span>")
	to_chat(c, "<span class='notice'>Left Mouse Button on turf/obj/mob      = Select corner</span>")
	to_chat(c, "<span class='notice'>***********************************************************</span>")

/datum/buildmode_mode/export/handle_selected_area(client/c, params)
	var/list/pa = params2list(params)
	var/left_click = pa.Find("left")

	if(left_click) //rectangular

		var/confirm = alert("Are you sure you want to do this? This may cause extreme lag!", "Map Exporter", "Yes", "No")

		if(confirm != "Yes")
			return

		var/file_name = sanitize_filename(input("File name to export:", "Map Exporter", "exportedmap") as text)

		log_admin("Build Mode: [key_name(c)] exported the map area from [AREACOORD(cornerA)] through [AREACOORD(cornerB)]") //I put this before the actual saving of the map because it likely won't log if it crashes the fucking server

		//oversimplified for readability and understandibility

		var/minx = min(cornerA.x, cornerB.x)
		var/miny = min(cornerA.y, cornerB.y)
		var/minz = min(cornerA.z, cornerB.z)

		var/maxx = max(cornerA.x, cornerB.x)
		var/maxy = max(cornerA.y, cornerB.y)
		var/maxz = max(cornerA.z, cornerB.z)

		var/map_text = write_map(minx, miny, minz, maxx, maxy, maxz, 24)
		if(map_text)
			text2file(map_text, "data/[file_name].dmm")
			usr << ftp("data/[file_name].dmm", "[file_name].dmm")
		else
			to_chat(usr, "<span class='warning'>Map export failed!</span>")
