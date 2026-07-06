/datum/buildmode_mode/artillerycontrol
	key = "artillerycontrol"
	///The shell we fire
	var/obj/item/mortal_shell/shellholder = null
	var/obj/machinery/artillery/piece_to_fire = null
	///The list of arguments for the procedure. They may not be. They are selected in the same way in the game, and can be a datum, and other types.
	var/list/proc_args = null

/datum/buildmode_mode/artillerycontrol/show_help(client/target_client)
	to_chat(target_client, span_purple(boxed_message(
		"[span_bold("Choose shell to fire")] -> Right Mouse Button on buildmode button\n\
		[span_bold("Choose artillerypiece to fire")] -> Right Mouse Button on a /obj/machinery/artillery\n\
		[span_bold("Fire to turf")] -> Left Mouse Button on turf"))
	)

/datum/buildmode_mode/artillerycontrol/change_settings(client/target_client)
	if(!check_rights_for(target_client, R_DEBUG))
		return
	var/atom/temp_path
	var/target_path = input(target_client, "Enter typepath:", "Typepath", "/obj/item/mortal_shell/")
	temp_path = text2path(target_path)
	if(!ispath(temp_path))
		temp_path = pick_closest_path(target_path)
		if(!temp_path)
			alert("No path was selected")
			return
		if(!ispath(temp_path, /obj/item/mortal_shell))
			alert("Not a /obj/item/mortal_shell!")
			return
	shellholder = temp_path
	BM.preview_selected_item(shellholder)

/datum/buildmode_mode/artillerycontrol/handle_click(client/target_client, params, datum/object as null|area|mob|obj|turf)
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if(!piece_to_fire || !shellholder)
			to_chat(target_client, span_warning("Select a shell type or artillery piece first!"))
			return
		//get coords
		var/turf/targloc = get_turf(object)

		var/datum/virtual_level/our_vlevel = targloc.get_virtual_level()
		if(!our_vlevel)
			return
		var/list/coords = our_vlevel.get_relative_coords(targloc)

		piece_to_fire.target_x = coords[1]
		piece_to_fire.target_y = coords[2]

		if(get_dist(piece_to_fire, targloc) < piece_to_fire.minimum_range)
			to_chat(target_client, span_danger("The target is too close to the gun."))
			return
		if(!isturf(targloc) || isindestructiblewall(targloc))
			to_chat(target_client, span_danger("You cannot fire the gun to this target. (Indestructable wall or invalid turf)"))
			return
		if(!targloc.virtual_z() == piece_to_fire.virtual_z())
			to_chat(target_client, span_danger("You cannot fire the gun to this target. (Not same virtual Z)"))
			return

		//spawn the shell then fire, tada
		var/obj/item/mortal_shell/temp_shell = new shellholder(get_turf(piece_to_fire))
		piece_to_fire.pre_fire(temp_shell, target_client)

	else if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(!istype(object, /obj/machinery/artillery))
			to_chat(target_client, span_warning("Not a /obj/machinery/artillery!"))
			return
		piece_to_fire = object
		to_chat(target_client, span_notice("[piece_to_fire::name] ([piece_to_fire::type]) selected."))



