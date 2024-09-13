/client/proc/map_template_load()
	set category = "Debug"
	set name = "Map template - Place"

	var/datum/map_template/template

	var/map = input(src, "Choose a Map Template to place at your CURRENT LOCATION","Place Map Template") as null|anything in sortList(SSmapping.map_templates)
	if(!map)
		return
	template = SSmapping.map_templates[map]

	var/turf/T = get_turf(mob)
	if(!T)
		return

	var/list/preview = list()
	for(var/S in template.get_affected_turfs(T,centered = TRUE))
		var/image/item = image('icons/turf/overlays.dmi',S,"greenOverlay")
		item.plane = ABOVE_LIGHTING_PLANE
		preview += item
	images += preview
	if(alert(src,"Confirm location.","Template Confirm","Yes","No") == "Yes")
		if(template.load(T, centered = TRUE))
			message_admins("<span class='adminnotice'>[key_name_admin(src)] has placed a map template ([template.name]) at [ADMIN_COORDJMP(T)]</span>")
		else
			to_chat(src, "Failed to place map", confidential = TRUE)
	images -= preview

/client/proc/map_template_upload()
	set category = "Debug"
	set name = "Map Template - Upload"

	var/map = input(src, "Choose a Map Template to upload to template storage","Upload Map Template") as null|file
	if(!map)
		return
	if(copytext("[map]", -4) != ".dmm")//4 == length(".dmm")
		to_chat(src, "<span class='warning'>Filename must end in '.dmm': [map]</span>", confidential = TRUE)
		return
	var/datum/map_template/new_map
	var/template_type = input(src, "What kind of map is this?", "Map type", list("Normal", "Norm. & Mark", "Shuttle", "Static Overmap Obj.", "Cancel"))
	switch(template_type)
		if("Normal")
			new_map = new /datum/map_template(map, "[map]", TRUE)
		if("Norm. & Mark")
			new_map = new /datum/map_template(map, "[map]", TRUE)
		if("Static Overmap Obj.")
			new_map = new /datum/map_template(map, "[map]", TRUE)
		if("Shuttle")
			new_map = new /datum/map_template/shuttle(map, "[map]", TRUE)
		else
			return
	if(!new_map.cached_map)
		to_chat(src, "<span class='warning'>Map template '[map]' failed to parse properly.</span>", confidential = TRUE)
		return

	var/datum/map_report/report = new_map.cached_map.check_for_errors()
	var/report_link
	if(report)
		report.show_to(src)
		report_link = " - <a href='?src=[REF(report)];[HrefToken(TRUE)];show=1'>validation report</a>"
		to_chat(src, "<span class='warning'>Map template '[map]' <a href='?src=[REF(report)];[HrefToken()];show=1'>failed validation</a>.</span>", confidential = TRUE)
		if(report.loadable)
			var/response = alert(src, "The map failed validation, would you like to load it anyways?", "Map Errors", "Cancel", "Upload Anyways")
			if(response != "Upload Anyways")
				return
		else
			alert(src, "The map failed validation and cannot be loaded.", "Map Errors", "Oh Darn")
			return

	SSmapping.map_templates[map] = new_map
	if(template_type == "Shuttle")
		var/datum/map_template/shuttle/shuttle_template = new_map
		shuttle_template.file_name = "[map]"
		shuttle_template.category = "uploaded"
		SSmapping.shuttle_templates["[map]"] = shuttle_template
		shuttle_template.ui_interact(usr)
	message_admins("<span class='adminnotice'>[key_name_admin(src)] has uploaded a map template '[map]' ([new_map.width]x[new_map.height])[report_link].</span>")
	to_chat(src, "<span class='notice'>Map template '[map]' ready to place ([new_map.width]x[new_map.height])</span>", confidential = TRUE)

	if(template_type == "Norm. & Mark")
		mark_datum(new_map)
		to_chat(src, "<span class='notice'>Map template '[map]' ready to place and marked.</span>", confidential = TRUE)

	if(template_type == "Static Overmap Obj.")
		var/location
		var/list/choices = list("Random Overmap Square", "Specific Overmap Square")
		var/choice = input("Select a location for the outpost.", "Outpost Location") as null|anything in choices
		switch(choice)
			if(null)
				return
			if("Random Overmap Square")
				location = null
			if("Specific Overmap Square")
				var/loc_x = input(usr, "X overmap coordinate:") as num
				var/loc_y = input(usr, "Y overmap coordinate:") as num
				location = list("x" = loc_x, "y" = loc_y)

		var/datum/overmap_star_system/selected_system //the star system we are
		if(length(SSovermap.tracked_star_systems) > 1)
			selected_system = tgui_input_list(usr, "Which star system do you want to spawn it in?", "Spawn Planet/Ruin", SSovermap.tracked_star_systems)
		else
			selected_system = SSovermap.tracked_star_systems[1]
		if(!selected_system)
			return //if selected_system didnt get selected, we nope out, this is very bad

		var/datum/overmap/static_object/created = new /datum/overmap/static_object/admin_loaded(location, selected_system)
		created.map_to_load = map

		message_admins(span_big("Click here to jump to the overmap token: " + ADMIN_JMP(created.token)))

		to_chat(src, "<span class='notice'>Map template '[map]' ready to loaded with load_level().</span>", confidential = TRUE)
