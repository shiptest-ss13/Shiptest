// DEBUG: test AI-interact-mode adminghost interaction with all elevator devices
// DEBUG: hell, actual AIs should probably also be able to interact. god this is all such a pain in the ass

/*
	Per-floor call buttons
*/

/obj/machinery/elevator_call_button
	name = "elevator call button"
	desc = "A simple set of buttons for calling an elevator."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "elevator"
	// don't break this either. it's kinda necessary
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	max_integrity = 200 // sturdy
	resistance_flags = LAVA_PROOF | FIRE_PROOF

	// DEBUG: actually, this should probably be 0-power? i don't really want it clogging up SSmachines even more
	processing_flags = START_PROCESSING_ON_INIT // DEBUG: unnecessary; added so that can be set to 0-power successfully
	power_channel = AREA_USAGE_ENVIRON // same as airlocks
	use_power = IDLE_POWER_USE
	idle_power_usage = 2

	var/datum/floor/my_floor

/obj/machinery/elevator_call_button/Destroy()
	if(my_floor)
		my_floor.button = null
	. = ..()

/obj/machinery/elevator_call_button/update_overlays()
	. = ..()
	luminosity = 0
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(!my_floor || machine_stat & (NOPOWER | BROKEN))
		return
	luminosity = 1
	var/calls = my_floor.calls
	// DEBUG: are two calls needed here? unsure
	if(calls & UP)
		SSvis_overlays.add_vis_overlay(src, icon, "elevator-up", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "elevator-up", layer, plane, dir, alpha)
	if(calls & DOWN)
		SSvis_overlays.add_vis_overlay(src, icon, "elevator-down", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "elevator-down", layer, plane, dir, alpha)

// DEBUG: should be ui_interact? see reagentgrinder.dm
/obj/machinery/elevator_call_button/interact(mob/user)
	. = ..()
	// DEBUG: test bottom- and top-floor behavior
	if(!my_floor || !my_floor.master)
		return
	var/floor_num = my_floor.master.floor_list.Find(my_floor)
	var/list/opts = list()

	if(floor_num < length(my_floor.master.floor_list))
		var/up_arrow = my_floor.calls & UP ? "green_arrow" : "red_arrow"
		opts["Up"] = image(icon = 'icons/misc/arrows.dmi', icon_state = up_arrow, dir = NORTH)
	if(floor_num > 1)
		var/down_arrow = my_floor.calls & DOWN ? "green_arrow" : "red_arrow"
		opts["Down"] = image(icon = 'icons/misc/arrows.dmi', icon_state = down_arrow, dir = SOUTH)

	var/result = show_radial_menu(user, src, opts, custom_check = CALLBACK(src, .proc/check_menu, user), require_near = !issilicon(user), tooltips = TRUE)
	if(!result || !my_floor || !my_floor.master)
		return
	switch(result)
		if("Up")
			// it just sets the flag. no backsies
			my_floor.master.add_call_on_floor(my_floor, UP)
		if("Down")
			my_floor.master.add_call_on_floor(my_floor, DOWN)

// DEBUG: i hate that this is defined fo rso much shit that usese radial menus. is it ACTUALLY necessary? i'm not 100% sure
/obj/machinery/elevator_call_button/proc/check_menu(mob/user)
	if(!my_floor) // DEBUG: technically unnecessary? all the calling procs check for this (rightly)
		return FALSE
	if(!isliving(user) && !isAdminGhostAI(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/*
	Elevator car destination panel
*/

/obj/machinery/elevator_floor_button
	name = "elevator floor panel"
	desc = "A set of buttons for controlling an elevator."
	icon = 'icons/obj/stationobjs.dmi'
	// DEBUG: more complicated icon_state? emissives?
	icon_state = "doorctrl"
	// yeah you still can't fucking break these.
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	max_integrity = 200 // sturdy
	resistance_flags = LAVA_PROOF | FIRE_PROOF

	// DEBUG: actually, this should probably be 0-power? i don't really want it clogging up SSmachines even more
	processing_flags = START_PROCESSING_ON_INIT // DEBUG: unnecessary; added so that can be set to 0-power successfully
	power_channel = AREA_USAGE_ENVIRON // same as airlocks
	use_power = IDLE_POWER_USE
	idle_power_usage = 2

	var/datum/elevator_master/master

/obj/machinery/elevator_floor_button/Initialize()
	..()
	// technically machines do this already, but i want to make it clear what's going on
	return INITIALIZE_HINT_LATELOAD

// so, the elevator floor button needs to hook itself into the master datum
// this is done by getting the elevator platform on the same turf as the button and getting its master datum
// but this requires the elevator platform to have definitely initialized, which isn't true during Initialize() if maploading
// however, it IS always true during LateInitialize
/obj/machinery/elevator_floor_button/LateInitialize()
	. = ..()
	var/obj/structure/elevator_platform/plat = locate() in get_turf(src)
	master = plat.master_datum
	plat.master_datum.button = src

/obj/machinery/elevator_floor_button/Destroy()
	if(master)
		master.button = null
	. = ..()

/obj/machinery/elevator_floor_button/ui_interact(mob/living/user, datum/tgui/ui)
	if(!master)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ElevatorButtons", name)
		ui.open()

// DEBUG: if nonphysical outposts have elevators, disable first floor somehow
/obj/machinery/elevator_floor_button/ui_data(mob/user)
	if(!master)
		return

	var/list/data = list()
	var/list/floors = list()
	data["floors"] = floors

	for(var/i = 1, i <= length(master.floor_list), i++)
		floors += list(list(
			num = i,
			is_dest = master.floor_list[i].is_dest,
			ref = REF(master.floor_list[i]),
		))

	return data

/obj/machinery/elevator_floor_button/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(. || !master)
		return

	switch(action)
		if("set_dest")
			var/datum/floor/added_floor = locate(params["ref"])
			if(!added_floor || !(added_floor in master.floor_list))
				return
			master.set_dest_on_floor(added_floor)

		if("open_doors")
			// DEBUG: should probably do something
			return
		if("close_doors")
			// DEBUG: doesn't do shit. just like real life! haha!
			return

/*
	Elevator car status display
*/

/obj/machinery/status_display/elevator
	name = "elevator display"
	desc = "An elevator's status screen, displaying movement direction and current floor."

	// you can vandalize and break these. you monster

	// DEBUG: consider power usage of this guy, too. ALTHOUGH it still needs to process

	var/datum/elevator_master/master

/obj/machinery/status_display/elevator/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

// see comments in /obj/machinery/elevator_floor_button/LateInitialize() for an explanation of why we do this
/obj/machinery/status_display/elevator/LateInitialize()
	. = ..()
	var/obj/structure/elevator_platform/plat = locate() in get_turf(src)
	master = plat.master_datum
	plat.master_datum.display = src

// DEBUG: can be replaced with signals, tbh?
/obj/machinery/status_display/elevator/Destroy()
	if(master)
		master.display = null
	. = ..()
