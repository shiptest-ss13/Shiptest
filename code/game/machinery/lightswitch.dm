/// The light switch. Can have multiple per area.
/obj/machinery/light_switch
	name = "light switch"
	icon = 'icons/obj/power.dmi'
	icon_state = "light1"
	base_icon_state = "light"
	desc = "Make dark."
	power_channel = AREA_USAGE_LIGHT
	/// Set this to a string, path, or area instance to control that area
	/// instead of the switch's location.
	var/area/area = null

	FASTDMM_PROP(\
		set_instance_vars(\
			pixel_x = dir & EAST ? 23 : (dir & WEST  ? -23 : INSTANCE_VAR_DEFAULT),\
			pixel_y = dir & NORTH ? 23 : (dir & SOUTH ? -23 : INSTANCE_VAR_DEFAULT)\
		),\
		dir_amount = 8\
	)

/obj/machinery/light_switch/Initialize(mapload, ndir, building = FALSE)
	. = ..()
	if(istext(area))
		area = text2path(area)
	if(ispath(area))
		area = GLOB.areas_by_type[area]
	if(!area)
		area = get_area(src)
	if(!name)
		name = "light switch ([area.name])"

	if(building)
		setDir(ndir)
		switch(dir) //Not great, but necessary as with buttons. Otherwise requires altering a ton of files.
			if(NORTH)
				pixel_y = -18 //Yes, NORTH is actually the south-facing mount.
			if(SOUTH)
				pixel_y = 20
			if(EAST)
				pixel_x = -20
			if(WEST)
				pixel_x = 20

	update_appearance()

/obj/machinery/light_switch/update_appearance(updates=ALL)
	. = ..()
	luminosity = (machine_stat & NOPOWER) ? 0 : 1

/obj/machinery/light_switch/update_icon_state()
	if(machine_stat & NOPOWER)
		icon_state = "[base_icon_state]-p"
		return ..()
	icon_state = "[base_icon_state][area.lightswitch ? 1 : 0]"
	return ..()

/obj/machinery/light_switch/update_overlays()
	. = ..()
	if(!(machine_stat & NOPOWER))
		SSvis_overlays.add_vis_overlay(src, icon, "[base_icon_state]-glow", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)

/obj/machinery/light_switch/examine(mob/user)
	. = ..()
	. += "It is [area.lightswitch ? "on" : "off"]."

/obj/machinery/light_switch/interact(mob/user)
	. = ..()

	area.lightswitch = !area.lightswitch
	play_click_sound("button")
	area.update_appearance()

	for(var/obj/machinery/light_switch/L in area)
		L.update_appearance()

	area.power_change()

/obj/machinery/light_switch/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER || I.tool_behaviour == TOOL_CROWBAR)
		var/action_description = I.tool_behaviour == TOOL_SCREWDRIVER ? "unscrew" : "pry"
		to_chat(user, span_notice("You start [action_description]ing \the [src]..."))

		if(I.use_tool(src, user, 15, volume=60))
			user.visible_message(
				span_notice("[user] [action_description == "pry" ? "pries" : "unscrews"] [src] from its socket."),
				span_notice("You [action_description] [src] from its socket.")
			)
			var/obj/item/wallframe/light_switch/frame = new /obj/item/wallframe/light_switch()
			try_put_in_hand(frame, user)
			I.play_tool_sound(src)
			qdel(src)
		return
	else
		return ..()

/obj/machinery/light_switch/power_change()
	SHOULD_CALL_PARENT(0)
	if(area == get_area(src))
		return ..()

/obj/machinery/light_switch/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	if(!(machine_stat & (BROKEN|NOPOWER)))
		power_change()

/obj/item/wallframe/light_switch
	name = "lightswitch frame"
	desc = "A ready-to-go light switch. Just slap it on a wall!"
	icon_state = "button"
	result_path = /obj/machinery/light_switch
	inverse = FALSE
	custom_materials = list(/datum/material/iron = 75)
