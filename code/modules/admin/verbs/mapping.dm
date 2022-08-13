//- Are all the floors with or without air, as they should be? (regular or airless)
//- Does the area have an APC?
//- Does the area have an Air Alarm?
//- Does the area have a Request Console?
//- Does the area have lights?
//- Does the area have a light switch?
//- Does the area have enough intercoms?
//- Does the area have enough security cameras? (Use the 'Camera Range Display' verb under Debug)
//- Is the area connected to the scrubbers air loop?
//- Is the area connected to the vent air loop? (vent pumps)
//- Is everything wired properly?
//- Does the area have a fire alarm and firedoors?
//- Do all pod doors work properly?
//- Are accesses set properly on doors, pod buttons, etc.
//- Are all items placed properly? (not below vents, scrubbers, tables)
//- Does the disposal system work properly from all the disposal units in this room and all the units, the pipes of which pass through this room?
//- Check for any misplaced or stacked piece of pipe (air and disposal)
//- Check for any misplaced or stacked piece of wire
//- Identify how hard it is to break into the area and where the weak points are
//- Check if the area has too much empty space. If so, make it smaller and replace the rest with maintenance tunnels.

GLOBAL_LIST_INIT(admin_verbs_debug_mapping, list(
	/client/proc/camera_view, 				//-errorage
	/client/proc/sec_camera_report, 		//-errorage
	/client/proc/intercom_view, 			//-errorage
	/client/proc/air_status, //Air things
	/client/proc/Cell, //More air things
	/client/proc/check_atmos,
	/client/proc/check_wiring,
	/client/proc/count_objects_on_z_level,
	/client/proc/count_objects_all,
	/client/proc/cmd_assume_direct_control,	//-errorage
	/client/proc/cmd_give_direct_control,
	/client/proc/startSinglo,
	/client/proc/set_server_fps,	//allows you to set the ticklag.
	/client/proc/cmd_admin_grantfullaccess,
	/client/proc/cmd_admin_areatest_all,
	/client/proc/cmd_admin_areatest_station,
	#ifdef TESTING
	/client/proc/see_dirty_varedits,
	#endif
	/client/proc/cmd_admin_test_atmos_controllers,
	/client/proc/cmd_admin_rejuvenate,
	/datum/admins/proc/show_traitor_panel,
	/client/proc/disable_communication,
	/client/proc/cmd_show_at_list,
	/client/proc/cmd_show_at_markers,
	/client/proc/manipulate_organs,
	/client/proc/start_line_profiling,
	/client/proc/stop_line_profiling,
	/client/proc/show_line_profiling,
	/client/proc/create_mapping_job_icons,
	/client/proc/debug_z_levels,
	/client/proc/map_zones_info,
	/client/proc/place_ruin,
	/client/proc/export_map
))
GLOBAL_PROTECT(admin_verbs_debug_mapping)

/obj/effect/debugging/mapfix_marker
	name = "map fix marker"
	icon = 'icons/hud/screen_gen.dmi'
	icon_state = "mapfixmarker"
	desc = "I am a mappers mistake."

/obj/effect/debugging/marker
	icon = 'icons/turf/areas.dmi'
	icon_state = "yellow"

/obj/effect/debugging/marker/Move()
	return 0

/client/proc/camera_view()
	set category = "Mapping"
	set name = "Camera Range Display"

	var/on = FALSE
	for(var/turf/T in world)
		if(T.maptext)
			on = TRUE
		T.maptext = null

	if(!on)
		var/list/seen = list()
		for(var/obj/machinery/camera/C in GLOB.cameranet.cameras)
			for(var/turf/T in C.can_see())
				seen[T]++
		for(var/turf/T in seen)
			T.maptext = "[seen[T]]"
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Show Camera Range") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Show Camera Range")

#ifdef TESTING
GLOBAL_LIST_EMPTY(dirty_vars)

/client/proc/see_dirty_varedits()
	set category = "Mapping"
	set name = "Dirty Varedits"

	var/list/dat = list()
	dat += "<h3>Abandon all hope ye who enter here</h3><br><br>"
	for(var/thing in GLOB.dirty_vars)
		dat += "[thing]<br>"
		CHECK_TICK
	var/datum/browser/popup = new(usr, "dirty_vars", "Dirty Varedits", 900, 750)
	popup.set_content(dat.Join())
	popup.open()
#endif

/client/proc/sec_camera_report()
	set category = "Mapping"
	set name = "Camera Report"

	if(!Master)
		alert(usr,"Master_controller not found.","Sec Camera Report")
		return 0

	var/list/obj/machinery/camera/CL = list()

	for(var/obj/machinery/camera/C in GLOB.cameranet.cameras)
		CL += C

	var/output = {"<B>Camera Abnormalities Report</B><HR>
<B>The following abnormalities have been detected. The ones in red need immediate attention: Some of those in black may be intentional.</B><BR><ul>"}

	for(var/obj/machinery/camera/C1 in CL)
		for(var/obj/machinery/camera/C2 in CL)
			if(C1 != C2)
				if(C1.c_tag == C2.c_tag)
					output += "<li><font color='red'>c_tag match for cameras at [ADMIN_VERBOSEJMP(C1)] and [ADMIN_VERBOSEJMP(C2)] - c_tag is [C1.c_tag]</font></li>"
				if(C1.loc == C2.loc && C1.dir == C2.dir && C1.pixel_x == C2.pixel_x && C1.pixel_y == C2.pixel_y)
					output += "<li><font color='red'>FULLY overlapping cameras at [ADMIN_VERBOSEJMP(C1)] Networks: [json_encode(C1.network)] and [json_encode(C2.network)]</font></li>"
				if(C1.loc == C2.loc)
					output += "<li>Overlapping cameras at [ADMIN_VERBOSEJMP(C1)] Networks: [json_encode(C1.network)] and [json_encode(C2.network)]</li>"
		var/turf/T = get_step(C1,turn(C1.dir,180))
		if(!T || !isturf(T) || !T.density)
			if(!(locate(/obj/structure/grille) in T))
				var/window_check = 0
				for(var/obj/structure/window/W in T)
					if (W.dir == turn(C1.dir,180) || (W.dir in list(NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST)))
						window_check = 1
						break
				if(!window_check)
					output += "<li><font color='red'>Camera not connected to wall at [ADMIN_VERBOSEJMP(C1)] Network: [json_encode(C1.network)]</font></li>"

	output += "</ul>"
	usr << browse(output,"window=airreport;size=1000x500")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Show Camera Report") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/intercom_view()
	set category = "Mapping"
	set name = "Intercom Range Display"

	var/static/intercom_range_display_status = FALSE
	intercom_range_display_status = !intercom_range_display_status //blame cyberboss if this breaks something

	for(var/obj/effect/debugging/marker/M in world)
		qdel(M)

	if(intercom_range_display_status)
		for(var/obj/item/radio/intercom/I in world)
			for(var/turf/T in orange(7,I))
				var/obj/effect/debugging/marker/F = new/obj/effect/debugging/marker(T)
				if (!(F in view(7,I.loc)))
					qdel(F)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Show Intercom Range") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_show_at_list()
	set category = "Mapping"
	set name = "Show roundstart AT list"
	set desc = "Displays a list of active turfs coordinates at roundstart"

	var/dat = {"<b>Coordinate list of Active Turfs at Roundstart</b>
	<br>Real-time Active Turfs list you can see in Air Subsystem at active_turfs var<br>"}

	for(var/t in GLOB.active_turfs_startlist)
		var/turf/T = t
		dat += "[ADMIN_VERBOSEJMP(T)]\n"
		dat += "<br>"

	usr << browse(dat, "window=at_list")

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Show Roundstart Active Turfs") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_show_at_markers()
	set category = "Mapping"
	set name = "Show roundstart AT markers"
	set desc = "Places a marker on all active-at-roundstart turfs"

	var/count = 0
	for(var/obj/effect/abstract/marker/at/AT in GLOB.all_abstract_markers)
		qdel(AT)
		count++

	if(count)
		to_chat(usr, "[count] AT markers removed.", confidential = TRUE)
	else
		for(var/t in GLOB.active_turfs_startlist)
			new /obj/effect/abstract/marker/at(t)
			count++
		to_chat(usr, "[count] AT markers placed.", confidential = TRUE)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Show Roundstart Active Turf Markers")

/client/proc/enable_debug_verbs()
	set category = "Debug"
	set name = "Debug verbs - Enable"
	if(!check_rights(R_DEBUG))
		return
	remove_verb(src, /client/proc/enable_debug_verbs)
	add_verb(src, list(/client/proc/disable_debug_verbs, GLOB.admin_verbs_debug_mapping))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Enable Debug Verbs") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/disable_debug_verbs()
	set category = "Debug"
	set name = "Debug verbs - Disable"
	remove_verb(src, list(/client/proc/disable_debug_verbs, GLOB.admin_verbs_debug_mapping))
	add_verb(src, /client/proc/enable_debug_verbs)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Disable Debug Verbs") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/count_objects_on_z_level()
	set category = "Mapping"
	set name = "Count Objects On Level"
	var/level = input("Which z-level?","Level?") as text|null
	if(!level)
		return
	var/num_level = text2num(level)
	if(!num_level)
		return
	if(!isnum(num_level))
		return

	var/type_text = input("Which type path?","Path?") as text|null
	if(!type_text)
		return
	var/type_path = text2path(type_text)
	if(!type_path)
		return

	var/count = 0

	var/list/atom/atom_list = list()

	for(var/atom/A in world)
		if(istype(A,type_path))
			var/atom/B = A
			while(!(isturf(B.loc)))
				if(B && B.loc)
					B = B.loc
				else
					break
			if(B)
				if(B.z == num_level)
					count++
					atom_list += A

	to_chat(world, "There are [count] objects of type [type_path] on z-level [num_level]", confidential = TRUE)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Count Objects Zlevel") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/count_objects_all()
	set category = "Mapping"
	set name = "Count Objects All"

	var/type_text = input("Which type path?","") as text|null
	if(!type_text)
		return
	var/type_path = text2path(type_text)
	if(!type_path)
		return

	var/count = 0

	for(var/atom/A in world)
		if(istype(A,type_path))
			count++

	to_chat(world, "There are [count] objects of type [type_path] in the game world", confidential = TRUE)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Count Objects All") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


//This proc is intended to detect lag problems relating to communication procs
GLOBAL_VAR_INIT(say_disabled, FALSE)
/client/proc/disable_communication()
	set category = "Mapping"
	set name = "Disable all communication verbs"

	GLOB.say_disabled = !GLOB.say_disabled
	if(GLOB.say_disabled)
		message_admins("[key] used 'Disable all communication verbs', killing all communication methods.")
	else
		message_admins("[key] used 'Disable all communication verbs', restoring all communication methods.")

//This generates the icon states for job starting location landmarks.
/client/proc/create_mapping_job_icons()
	set name = "Generate job landmarks icons"
	set category = "Mapping"
	var/icon/final = icon()
	var/mob/living/carbon/human/dummy/D = new(locate(1,1,1)) //spawn on 1,1,1 so we don't have runtimes when items are deleted
	D.setDir(SOUTH)
	for(var/job in subtypesof(/datum/job))
		var/datum/job/JB = new job
		switch(JB.name)
			if("AI")
				final.Insert(icon('icons/mob/ai.dmi', "ai", SOUTH, 1), "AI")
			if("Cyborg")
				final.Insert(icon('icons/mob/robots.dmi', "robot", SOUTH, 1), "Cyborg")
			else
				for(var/obj/item/I in D)
					qdel(I)
				randomize_human(D)
				JB.equip(D, TRUE, FALSE)
				COMPILE_OVERLAYS(D)
				var/icon/I = icon(getFlatIcon(D), frame = 1)
				final.Insert(I, JB.name)
	qdel(D)
	//Also add the x
	for(var/x_number in 1 to 4)
		final.Insert(icon('icons/hud/screen_gen.dmi', "x[x_number == 1 ? "" : x_number]"), "x[x_number == 1 ? "" : x_number]")
	fcopy(final, "icons/mob/landmarks.dmi")

/client/proc/debug_z_levels()
	set name = "Debug Z-Levels"
	set category = "Mapping"

	var/list/z_list = SSmapping.z_list
	var/list/messages = list()
	messages += "<b>World</b>: [world.maxx] x [world.maxy] x [world.maxz]<br>"

	for(var/z in 1 to max(world.maxz, z_list.len))
		if (z > z_list.len)
			messages += "Z level: <b>[z]</b>: Unmanaged (out of bounds)<br>"
			continue
		var/datum/space_level/space_level = z_list[z]
		if (!space_level)
			messages += "Z level: <b>[z]</b>: Unmanaged (null)<br>"
			continue

		messages += "Z level: <b>[z]</b>: [space_level.name]<br>"
		if (space_level.z_value != z)
			messages += "-- z_value is [space_level.z_value], should be [z]<br>"
		if (z > world.maxz)
			messages += "-- exceeds max z"

	messages += "<table border='1'>"
	messages += "</table>"

	to_chat(src, messages.Join(""), confidential = TRUE)

#define SUB_ZONE_INFO_FULL(virtual_level) "[virtual_level.parent_map_zone.id]. [virtual_level.id]. [virtual_level.name]"
#define MAP_ZONE_INFO(map_zone) "[map_zone.id]. [map_zone.name]" //Works for virtual level or map zones

/client/proc/map_zones_info()
	set name = "Map-Zones Info"
	set category = "Mapping"

	var/list/dat = list()
	for(var/datum/map_zone/map_zone as anything in SSmapping.map_zones)
		dat += "[MAP_ZONE_INFO(map_zone)]:"
		for(var/datum/virtual_level/virtual_level as anything in map_zone.virtual_levels)
			dat += "<BR> - [MAP_ZONE_INFO(virtual_level)]:"
			var/turf/low_bound = locate(virtual_level.low_x, virtual_level.low_y, virtual_level.z_value)
			var/turf/high_bound = locate(virtual_level.high_x, virtual_level.high_y, virtual_level.z_value)
			dat += "<BR> -- Low bounds: [ADMIN_JMP(low_bound)], High bounds: [ADMIN_JMP(high_bound)]"
			dat += "<BR> -- Reservation: LowX: [virtual_level.low_x], LowY: [virtual_level.low_y], HighX: [virtual_level.high_x], HighY: [virtual_level.high_y]"
			dat += "<BR> -- Reserved Margin: [virtual_level.reserved_margin]"
			dat += "<BR> -- Traits: [json_encode(virtual_level.traits)]"
			if(length(virtual_level.crosslinked))
				dat += "<BR> -- Crosslinkage: (map zone ID, zone ID, name)"
				for(var/dir in virtual_level.crosslinked)
					var/datum/virtual_level/linked_zone = virtual_level.crosslinked[dir]
					var/dir_string
					//precompiler cant handle those for a switch
					if(dir == "[NORTH]")
						dir_string = "North"
					else if(dir == "[SOUTH]")
						dir_string = "South"
					else if(dir == "[WEST]")
						dir_string = "West"
					else if(dir == "[EAST]")
						dir_string = "East"
					var/zone_string
					if(linked_zone == virtual_level)
						zone_string = "SELF LINKED"
					else
						zone_string = SUB_ZONE_INFO_FULL(linked_zone)
					dat += "<BR> --- [dir_string]: [zone_string]"
			if(virtual_level.up_linkage)
				dat += "<BR> -- Up-linkage: [SUB_ZONE_INFO_FULL(virtual_level.up_linkage)]"
			if(virtual_level.down_linkage)
				dat += "<BR> -- Down-linkage: [SUB_ZONE_INFO_FULL(virtual_level.down_linkage)]"
		dat += "<HR>"
	dat += "Physical map dimensions: [world.maxx], [world.maxy], [world.maxz]"
	dat += "<BR>Physical levels:"
	for(var/z in 1 to SSmapping.z_list.len)
		var/datum/space_level/space_level = SSmapping.z_list[z]
		dat += "<BR> - [z]. [space_level.name]"
		if(length(space_level.virtual_levels))
			dat += "<BR> -- Contained virtual level reservations:"
			for(var/datum/virtual_level/virtual_level as anything in space_level.virtual_levels)
				dat += "<BR> --- [SUB_ZONE_INFO_FULL(virtual_level)]"
	var/datum/browser/popup = new(usr, "map zone debug", "Map-Zones info", 600, 600)
	popup.set_content(dat.Join())
	popup.open()

#undef SUB_ZONE_INFO_FULL
#undef MAP_ZONE_INFO

/client/proc/export_map()
	set category = "Mapping"
	set name = "Export Map"

	var/z_level = input("Export Which Z-Level?", "Map Exporter", 2) as num
	var/start_x = input("Start X?", "Map Exporter", 1) as num
	var/start_y = input("Start Y?", "Map Exporter", 1) as num
	var/end_x = input("End X?", "Map Exporter", world.maxx-1) as num
	var/end_y = input("End Y?", "Map Exporter", world.maxy-1) as num
	var/date = time2text(world.timeofday, "YYYY-MM-DD_hh-mm-ss")
	var/file_name = sanitize_filename(input("Filename?", "Map Exporter", "exportedmap_[date]") as text)
	var/confirm = tgui_alert(usr, "Are you sure you want to do this? This will cause extreme lag!", "Map Exporter", list("Yes", "No"))

	if(confirm != "Yes")
		return

	var map_text = write_map(start_x, start_y, z_level, end_x, end_y, z_level)
	text2file(map_text, "data/[file_name].dmm")
	usr << ftp("data/[file_name].dmm", "[file_name].dmm")
