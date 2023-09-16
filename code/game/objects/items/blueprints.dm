#define AREA_ERRNONE 0
#define AREA_STATION 1
#define AREA_SPACE 2
#define AREA_SPECIAL 3

/obj/item/areaeditor
	name = "area modification item"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "blueprints"
	attack_verb = list("attacked", "bapped", "hit")
	var/fluffnotice = "Nobody's gonna read this stuff!"
	var/in_use = FALSE

/obj/item/areaeditor/attack_self(mob/user)
	add_fingerprint(user)
	. = "<BODY><HTML><head><title>[src]</title></head> \
				<h2>[station_name()] [src.name]</h2> \
				<small>[fluffnotice]</small><hr>"
	switch(get_area_type())
		if(AREA_SPACE)
			. += "<p>According to the [src.name], you are now in an unclaimed territory.</p>"
		if(AREA_SPECIAL)
			. += "<p>This place is not noted on the [src.name].</p>"
	. += "<p><a href='?src=[REF(src)];create_area=1'>Create or modify an existing area</a></p>"


/obj/item/areaeditor/Topic(href, href_list)
	if(..())
		return TRUE
	if(!usr.canUseTopic(src) || usr != loc)
		usr << browse(null, "window=blueprints")
		return TRUE
	if(href_list["create_area"])
		if(in_use)
			return
		var/area/A = get_area(usr)
		if(A.area_flags & NOTELEPORT)
			to_chat(usr, "<span class='warning'>You cannot edit restricted areas.</span>")
			return
		in_use = TRUE
		create_area(usr)
		in_use = FALSE
	updateUsrDialog()

//Station blueprints!!!
/obj/item/areaeditor/blueprints
	name = "station blueprints"
	desc = "Blueprints of what appear to be an experimental station design, with a large spinal weapon mounted to the front. There is a \"Classified\" stamp and several coffee stains on it."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "blueprints"
	fluffnotice = "Property of Nanotrasen. For heads of staff only. Store in high-secure storage."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/list/image/showing = list()
	var/client/viewing
	var/legend = FALSE	//Viewing the wire legend


/obj/item/areaeditor/blueprints/Destroy()
	clear_viewer()
	return ..()


/obj/item/areaeditor/blueprints/attack_self(mob/user)
	. = ..()
	if(!legend)
		var/area/A = get_area(user)
		if(get_area_type() == AREA_STATION)
			. += "<p>According to \the [src], you are now in <b>\"[html_encode(A.name)]\"</b>.</p>"
			. += "<p><a href='?src=[REF(src)];edit_area=1'>Change area name</a></p>"
		. += "<p><a href='?src=[REF(src)];view_legend=1'>View wire colour legend</a></p>"
		if(!viewing)
			. += "<p><a href='?src=[REF(src)];view_blueprints=1'>View structural data</a></p>"
		else
			. += "<p><a href='?src=[REF(src)];refresh=1'>Refresh structural data</a></p>"
			. += "<p><a href='?src=[REF(src)];hide_blueprints=1'>Hide structural data</a></p>"
	else
		if(legend == TRUE)
			. += "<a href='?src=[REF(src)];exit_legend=1'><< Back</a>"
			. += view_wire_devices(user);
		else
			//legend is a wireset
			. += "<a href='?src=[REF(src)];view_legend=1'><< Back</a>"
			. += view_wire_set(user, legend)
	var/datum/browser/popup = new(user, "blueprints", "[src]", 700, 500)
	popup.set_content(.)
	popup.open()
	onclose(user, "blueprints")


/obj/item/areaeditor/blueprints/Topic(href, href_list)
	if(..())
		return
	if(href_list["edit_area"])
		if(get_area_type()!=AREA_STATION)
			return
		if(in_use)
			return
		in_use = TRUE
		edit_area()
		in_use = FALSE
	if(href_list["exit_legend"])
		legend = FALSE;
	if(href_list["view_legend"])
		legend = TRUE;
	if(href_list["view_wireset"])
		legend = href_list["view_wireset"];
	if(href_list["view_blueprints"])
		set_viewer(usr, "<span class='notice'>You flip the blueprints over to view the complex information diagram.</span>")
	if(href_list["hide_blueprints"])
		clear_viewer(usr,"<span class='notice'>You flip the blueprints over to view the simple information diagram.</span>")
	if(href_list["refresh"])
		clear_viewer(usr)
		set_viewer(usr)

	attack_self(usr) //this is not the proper way, but neither of the old update procs work! it's too ancient and I'm tired shush.

/obj/item/areaeditor/blueprints/proc/get_images(turf/T, viewsize)
	. = list()
	for(var/turf/TT in range(viewsize, T))
		if(TT.blueprint_data)
			. += TT.blueprint_data

/obj/item/areaeditor/blueprints/proc/set_viewer(mob/user, message = "")
	if(user && user.client)
		if(viewing)
			clear_viewer()
		viewing = user.client
		showing = get_images(get_turf(user), viewing.view)
		viewing.images |= showing
		if(message)
			to_chat(user, message)

/obj/item/areaeditor/blueprints/proc/clear_viewer(mob/user, message = "")
	if(viewing)
		viewing.images -= showing
		viewing = null
	showing.Cut()
	if(message)
		to_chat(user, message)

/obj/item/areaeditor/blueprints/dropped(mob/user)
	..()
	clear_viewer()
	legend = FALSE


/obj/item/areaeditor/proc/get_area_type(area/A)
	if (!A)
		A = get_area(usr)
	if(A.outdoors)
		return AREA_SPACE
	var/list/SPECIALS = list(
		/area/shuttle,
		/area/centcom,
		/area/asteroid,
		/area/tdome,
		/area/wizard_station
	)
	for (var/type in SPECIALS)
		if (istype(A,type))
			return AREA_SPECIAL
	return AREA_STATION

/obj/item/areaeditor/blueprints/proc/view_wire_devices(mob/user)
	var/message = "<br>You examine the wire legend.<br>"
	for(var/wireset in GLOB.wire_color_directory)
		message += "<br><a href='?src=[REF(src)];view_wireset=[wireset]'>[GLOB.wire_name_directory[wireset]]</a>"
	message += "</p>"
	return message

/obj/item/areaeditor/blueprints/proc/view_wire_set(mob/user, wireset)
	//for some reason you can't use wireset directly as a derefencer so this is the next best :/
	for(var/device in GLOB.wire_color_directory)
		if("[device]" == wireset)	//I know... don't change it...
			var/message = "<p><b>[GLOB.wire_name_directory[device]]:</b>"
			for(var/Col in GLOB.wire_color_directory[device])
				var/wire_name = GLOB.wire_color_directory[device][Col]
				if(!findtext(wire_name, WIRE_DUD_PREFIX))	//don't show duds
					message += "<p><span style='color: [Col]'>[Col]</span>: [wire_name]</p>"
			message += "</p>"
			return message
	return ""

/obj/item/areaeditor/proc/edit_area()
	var/area/A = get_area(usr)
	var/prevname = "[A.name]"
	var/str = stripped_input(usr,"New area name:", "Area Creation", "", MAX_NAME_LEN)
	if(!str || !length(str) || str==prevname) //cancel
		return
	if(length(str) > 50)
		to_chat(usr, "<span class='warning'>The given name is too long. The area's name is unchanged.</span>")
		return

	A.rename_area(str)

	to_chat(usr, "<span class='notice'>You rename the '[prevname]' to '[str]'.</span>")
	log_game("[key_name(usr)] has renamed [prevname] to [str]")
	A.update_areasize()
	interact()
	return TRUE

//Blueprint Subtypes

/obj/item/areaeditor/blueprints/cyborg
	name = "construction schematics"
	desc = "A digital copy of the local blueprints and zoning permits stored in your memory."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "blueprints"
	fluffnotice = "Intellectual Property of Nanotrasen. For use in engineering cyborgs only. Wipe from memory upon departure from company ownership."

/area/proc/rename_area(new_name)
	var/prevname = "[name]"
	set_area_machinery_title(src, new_name, prevname)
	name = new_name
	sortTim(GLOB.sortedAreas, /proc/cmp_name_asc)
	return TRUE

/proc/set_area_machinery_title(area/A, title, oldtitle)
	if(!oldtitle) // or replacetext goes to infinite loop
		return
	for(var/obj/machinery/airalarm/M in A)
		M.name = replacetext(M.name,oldtitle,title)
	for(var/obj/machinery/power/apc/M in A)
		M.name = replacetext(M.name,oldtitle,title)
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/M in A)
		M.name = replacetext(M.name,oldtitle,title)
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/M in A)
		M.name = replacetext(M.name,oldtitle,title)
	for(var/obj/machinery/door/M in A)
		M.name = replacetext(M.name,oldtitle,title)
	for(var/obj/machinery/fax/M in A)
		M.fax_name = replacetext(M.fax_name,oldtitle,title)
	//TODO: much much more. Unnamed airlocks, cameras, etc.

/obj/item/areaeditor/shuttle
	name = "shuttle expansion permit"
	desc = "A set of paperwork which is used to expand flyable shuttles."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "blueprints"
	color = COLOR_ASSEMBLY_WHITE
	fluffnotice = "Not to be used for non-sanctioned shuttle construction and maintenance."
	var/obj/docking_port/mobile/target_shuttle

/obj/item/areaeditor/shuttle/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(istype(target, /obj/machinery/computer/helm))
		var/obj/machinery/computer/helm/H = target
		target_shuttle = H.current_ship.shuttle_port

/obj/item/areaeditor/shuttle/attack_self(mob/user)
	. = ..()
	var/datum/browser/popup = new(user, "blueprints", "[src]", 700, 500)
	popup.set_content(.)
	popup.open()
	onclose(user, "blueprints")

/obj/item/areaeditor/shuttle/Topic(href, href_list)
	if(!usr.canUseTopic(src) || usr != loc)
		usr << browse(null, "window=blueprints")
		return TRUE
	if(href_list["create_area"])
		if(in_use)
			return
		if(!target_shuttle)
			to_chat(usr, "<span class='warning'>You need to designate a shuttle to expand by linking the helm console to these plans.</span>")
			return
		var/area/A = get_area(usr)
		if(A.area_flags & NOTELEPORT)
			to_chat(usr, "<span class='warning'>You cannot edit restricted areas.</span>")
			return
		in_use = TRUE
		create_shuttle_area(usr)
		in_use = FALSE
	updateUsrDialog()

// Virtually a copy of create_area() with specialized behaviour
/obj/item/areaeditor/shuttle/proc/create_shuttle_area(mob/creator)
	// Passed into the above proc as list/break_if_found
	var/static/area_or_turf_fail_types = typecacheof(list(
		/turf/open/space,
		))
	// Ignore these areas and dont let people expand them. They can expand into them though
	var/static/blacklisted_areas = typecacheof(list(
		/area/space,
		))

	if(creator)
		if(creator.create_area_cooldown >= world.time)
			to_chat(creator, "<span class='warning'>You're trying to create a new area a little too fast.</span>")
			return
		creator.create_area_cooldown = world.time + 10

	var/list/turfs = detect_room(get_turf(creator), area_or_turf_fail_types, BP_MAX_ROOM_SIZE*2)
	if(!turfs)
		to_chat(creator, "<span class='warning'>The new area must be completely airtight.</span>")
		return
	if(turfs.len > BP_MAX_ROOM_SIZE)
		to_chat(creator, "<span class='warning'>The room you're in is too big. It is [turfs.len >= BP_MAX_ROOM_SIZE *2 ? "more than 100" : ((turfs.len / BP_MAX_ROOM_SIZE)-1)*100]% larger than allowed.</span>")
		return
	var/list/areas = list("New Area" = /area/ship)
	var/list/shuttle_coords = target_shuttle.return_coords()
	var/near_shuttle = FALSE
	for(var/i in 1 to turfs.len)
		var/area/place = get_area(turfs[i])
		if(blacklisted_areas[place.type])
			continue
		if(!place.requires_power || (place.area_flags & NOTELEPORT) || (place.area_flags & HIDDEN_AREA))
			continue // No expanding powerless rooms etc
		var/area/ship/underlying_area = target_shuttle?.underlying_turf_area[turfs[i]]
		if(istype(underlying_area) && underlying_area.mobile_port)
			to_chat(creator, "<span class='warning'>Shuttle expansion protocals are disabled while docked to another ship.</span>")
			return // While this could possibly work, it'll be a lot of effort to implement and will likely be a buggy mess
		var/area/ship/ship_place = place
		if(istype(ship_place) && ship_place.mobile_port != target_shuttle)
			to_chat(creator, "<span class='warning'>The new area must not be in or next to a different shuttle.</span>")
			return // No stealing other ship's areas please
		areas[place.name] = place

		// The following code checks to see if the tile is within one tile of the target shuttle
		if(near_shuttle)
			continue
		var/turf/T = turfs[i]
		if(T.z == target_shuttle.z)
			if(T.x >= (min(shuttle_coords[1], shuttle_coords[3]) - 1) && T.x <= (max(shuttle_coords[1], shuttle_coords[3]) + 1))
				if(T.y >= (min(shuttle_coords[2], shuttle_coords[4]) - 1) && T.y <= (max(shuttle_coords[2], shuttle_coords[4]) + 1))
					near_shuttle = TRUE
	if(!near_shuttle)
		to_chat(creator, "<span class='warning'>The new area must be next to the shuttle.</span>")
		return
	var/area_choice = input(creator, "Choose an area to expand or make a new area.", "Area Expansion") as null|anything in areas
	area_choice = areas[area_choice]

	if(!area_choice)
		to_chat(creator, "<span class='warning'>No choice selected. The area remains undefined.</span>")
		return
	var/area/ship/newA
	var/area/oldA = get_area(get_turf(creator))
	if(!isarea(area_choice))
		var/str = stripped_input(creator,"New area name:", "Blueprint Editing", "", MAX_NAME_LEN)
		if(!str || !length(str)) //cancel
			return
		if(length(str) > 50)
			to_chat(creator, "<span class='warning'>The given name is too long. The area remains undefined.</span>")
			return
		newA = new area_choice
		newA.setup(str)
		newA.set_dynamic_lighting()
		newA.has_gravity = oldA.has_gravity
	else
		newA = area_choice

	for(var/i in 1 to turfs.len)
		var/turf/thing = turfs[i]
		var/area/old_area = thing.loc
		if(!target_shuttle.shuttle_areas[old_area])
			target_shuttle.underlying_turf_area[thing] = old_area
		newA.contents += thing
		thing.change_area(old_area, newA)

		if(istype(thing, /turf/open/space))
			continue
		if(length(thing.baseturfs) < 2)
			continue
		if(/turf/baseturf_skipover/shuttle in thing.baseturfs)
			continue
		//Add the shuttle base shit to the shuttle
		var/list/sanity = thing.baseturfs.Copy()
		sanity.Insert(3, /turf/baseturf_skipover/shuttle)
		thing.baseturfs = baseturfs_string_list(sanity, thing)

	var/list/firedoors = oldA.firedoors
	for(var/door in firedoors)
		var/obj/machinery/door/firedoor/FD = door
		FD.CalculateAffectingAreas()

	target_shuttle.shuttle_areas[newA] = TRUE

	newA.connect_to_shuttle(target_shuttle, target_shuttle.docked)
	newA.mobile_port = target_shuttle
	for(var/atom/thing in newA)
		thing.connect_to_shuttle(target_shuttle, target_shuttle.docked)

	target_shuttle.recalculate_bounds()

	to_chat(creator, "<span class='notice'>You have created a new area, named [newA.name]. It is now weather proof, and constructing an APC will allow it to be powered.</span>")
	return TRUE

/obj/item/areaeditor/shuttle/cyborg
	name = "ship structure schematics"
	desc = "A digital copy of the local ship blueprints and zoning stored in your memory, used to expand flying shuttles."
	fluffnotice = "For use in engineering cyborgs only. Wipe from memory upon disabling."

// VERY EXPENSIVE (I think)
/obj/docking_port/mobile/proc/recalculate_bounds()
	if(!istype(src, /obj/docking_port/mobile))
		return FALSE
	//Heights is the distance away from the port
	//width is the distance perpendicular to the port
	var/minX = INFINITY
	var/maxX = 0
	var/minY = INFINITY
	var/maxY = 0
	for(var/area/A in shuttle_areas)
		for(var/turf/T in A)
			minX = min(T.x, minX)
			maxX = max(T.x, maxX)
			minY = min(T.y, minY)
			maxY = max(T.y, maxY)
	//Make sure shuttle was actually found.
	if(maxX == INFINITY || maxY == INFINITY)
		return FALSE
	minX--
	minY--
	var/new_width = maxX - minX
	var/new_height = maxY - minY
	var/offset_x = x - minX
	var/offset_y = y - minY
	switch(dir) //Source: code/datums/shuttles.dm line 77 (14/03/2020) :)
		if(NORTH)
			width = new_width
			height = new_height
			dwidth = offset_x - 1
			dheight = offset_y - 1
		if(EAST)
			width = new_height
			height = new_width
			dwidth = new_height - offset_y
			dheight = offset_x - 1
		if(SOUTH)
			width = new_width
			height = new_height
			dwidth = new_width - offset_x
			dheight = new_height - offset_y
		if(WEST)
			width = new_height
			height = new_width
			dwidth = offset_y - 1
			dheight = new_width - offset_x
	qdel(assigned_transit, TRUE)
	assigned_transit = null
