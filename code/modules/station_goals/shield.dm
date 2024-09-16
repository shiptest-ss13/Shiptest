//It'd be cool if these:
// required a charge to fire

/obj/machinery/meteor_shield
	name = "\improper meteor defense grid"
	desc = ""
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_lethal"
	anchored = TRUE
	density = TRUE
	use_power = FALSE
	processing_flags = START_PROCESSING_MANUALLY
	subsystem_type = /datum/controller/subsystem/processing/fastprocess
	idle_power_usage = 100
	active_power_usage = 1000
	var/id = ""
	var/active = TRUE
	var/kill_range = 6
	var/fire_delay = 7 SECONDS
	COOLDOWN_DECLARE(fire_timer)

/obj/machinery/meteor_shield/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	id = "[REF(port)][id]"

/obj/machinery/meteor_shield/interact(mob/user)
	. = ..()
	if(.)
		return
	if (active)
		user.visible_message(
			span_notice("[user] deactivated \the [src]."), \
			span_notice("You deactivate \the [src]."")", \
			span_hear("The chirps of [src] fade out as it powers down.")))
		active = FALSE
		STOP_PROCESSING(SSfastprocess, src)
	else
		if(anchored)
			user.visible_message(
				span_notice("[user] activated \the [src]."), \
				span_notice("You activate \the [src]."), \
				span_hear("You hear heavy droning."))
			active = TRUE
			START_PROCESSING(SSfastprocess, src)

		else
			to_chat(user, span_warning("[src] must first be secured to the floor!"))
	return

/obj/machinery/meteor_shield/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WRENCH)
		if(!anchored && !isinspace())
			W.play_tool_sound(src, 100)
			if (W.use_tool(src, user, 20))
				to_chat(user, span_notice("You secure \the [src] to the floor!"))
				set_anchored(TRUE)
		else if(anchored)
			W.play_tool_sound(src, 100)
			if (W.use_tool(src, user, 20))
				to_chat(user, span_notice("You unsecure \the [src] from the floor!"))
				if(active)
					to_chat(user, span_notice("\The [src] shuts off!"))
				set_anchored(FALSE)
	if(W.tool_behaviour == TOOL_MULTITOOL)
		var/a = stripped_input(usr, "Please enter desired ID.", name, id, 20)
		if (!a)
			return
		id = a
		. = TRUE

/obj/machinery/meteor_shield/proc/toggle(mob/user)
	if(!anchored)
		if(user)
			to_chat(user, span_warning("You can only activate [src] while it's secured!."))

	if(user)
		to_chat(user, span_notice("You [active ? "deactivate": "activate"] [src]."))
	set_anchored(!anchored)

/obj/machinery/meteor_shield/update_icon_state()
	. = ..()
	icon_state = active ? "syndie_lethal" : "syndie_off"

/obj/machinery/meteor_shield/proc/los(meteor)
	for(var/turf/T in getline(src,meteor))
		return TRUE

/obj/machinery/meteor_shield/process()
	if(!active)
		return
	if(COOLDOWN_FINISHED(src, fire_timer))
	for(var/obj/effect/meteor/M in GLOB.meteor_list)
		if(M.virtual_z() != virtual_z())
			continue
		if(get_dist(M,src) > kill_range)
			continue
		if(!(obj_flags & EMAGGED) && los(M))
			Beam(get_turf(M),icon_state="sat_beam",time=5,maxdistance=kill_range)
			dir = get_dir(src, M)
			explosion(M, 0,0,1,5,TRUE,FALSE,3,FALSE,TRUE)
			qdel(M)
			COOLDOWN_START(src, fire_timer, fire_delay)

/obj/machinery/meteor_shield/cargo
	anchored = FALSE
	active = FALSE

/obj/machinery/computer/meteor_shield
	name = "Meteor Defense Grid Controller"
	desc = "Used to control the satellite network."
	circuit = /obj/item/circuitboard/computer/meteor_shield
	var/notice

/obj/machinery/computer/meteor_shield/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SatelliteControl", name)
		ui.open()

/obj/machinery/computer/meteor_shield/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toggle")
			toggle(text2num(params["id"]))
			. = TRUE

/obj/machinery/computer/meteor_shield/proc/toggle(id)
	for(var/obj/machinery/meteor_shield/S in GLOB.machines)
		if(S.id == id && S.virtual_z() == virtual_z())
			S.toggle()

/obj/machinery/computer/meteor_shield/ui_data()
	var/list/data = list()

	data["satellites"] = list()
	for(var/obj/machinery/meteor_shield/S in GLOB.machines)
		data["satellites"] += list(list(
			"id" = S.id,
			"active" = S.active,
			"Ready To Fire" = !S.charging
		))
	data["notice"] = notice

	return data
