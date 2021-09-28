
// Floor painter

/obj/item/floor_painter
	name = "floor painter"
	icon = 'whitesands/icons/obj/device.dmi'
	icon_state = "floor_sprayer"
	desc = "An airlock painter, reprogramed to use a different style of paint in order to apply decals for floor tiles as well, in addition to repainting doors. Decals break when the floor tiles are removed. Use it inhand to change the design, and Ctrl-Click to switch to decal-painting mode."

	var/floor_icon
	var/floor_state = "steel"
	var/floor_dir = SOUTH

	item_state = "electronic"

	var/list/allowed_directions = list("south")

	var/static/list/allowed_states = list(
		"steel", "dark", "white", "freezer", "tile_full", "cargo_one_full",
		"kafel_full", "steel_monofloor", "monotile", "grid", "ridged"
	)

/obj/item/floor_painter/afterattack(var/atom/A, var/mob/user, proximity, params)
	if(!proximity)
		return

	var/turf/open/floor/plasteel/F = A
	if(!istype(F) || istype(F, /turf/open/floor/plasteel/tech))
		to_chat(user, "<span class='warning'>\The [src] can only be used on plasteel flooring.</span>")
		return

	F.icon_state = floor_state
	F.base_icon_state = floor_state
	F.dir = floor_dir
	playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)

/obj/item/floor_painter/attack_self(var/mob/user)
	if(!user)
		return FALSE
	user.set_machine(src)
	interact(user)
	return TRUE

/obj/item/floor_painter/interact(mob/user as mob) //TODO: Make TGUI for this because ouch
	if(!floor_icon)
		floor_icon = icon('whitesands/icons/turf/floors/tiles.dmi', floor_state, floor_dir)
	user << browse_rsc(floor_icon, "floor.png")
	var/dat = {"
		<center>
			<img style="-ms-interpolation-mode: nearest-neighbor;" src="floor.png" width=128 height=128 border=4>
		</center>
		<center>
			<a href="?src=[UID()];cycleleft=1">&lt;-</a>
			<a href="?src=[UID()];choose_state=1">Choose Style</a>
			<a href="?src=[UID()];cycleright=1">-&gt;</a>
		</center>
		<div class='statusDisplay'>Style: [floor_state]</div>
		<center>
			<a href="?src=[UID()];cycledirleft=1">&lt;-</a>
			<a href="?src=[UID()];choose_dir=1">Choose Direction</a>
			<a href="?src=[UID()];cycledirright=1">-&gt;</a>
		</center>
		<div class='statusDisplay'>Direction: [dir2text(floor_dir)]</div>
	"}

	var/datum/browser/popup = new(user, "floor_painter", name, 225, 300)
	popup.set_content(dat)
	popup.open()

/obj/item/floor_painter/Topic(href, href_list)
	if(..())
		return

	if(href_list["choose_state"])
		var/state = input("Please select a style", "[src]") as null|anything in allowed_states
		if(state)
			floor_state = state
			check_directional_tile()
	if(href_list["choose_dir"])
		var/seldir = input("Please select a direction", "[src]") as null|anything in allowed_directions
		if(seldir)
			floor_dir = text2dir(seldir)
	if(href_list["cycledirleft"])
		var/index = allowed_directions.Find(dir2text(floor_dir))
		index--
		if(index < 1)
			index = allowed_directions.len
		floor_dir = text2dir(allowed_directions[index])
	if(href_list["cycledirright"])
		var/index = allowed_directions.Find(dir2text(floor_dir))
		index++
		if(index > allowed_directions.len)
			index = 1
		floor_dir = text2dir(allowed_directions[index])
	if(href_list["cycleleft"])
		var/index = allowed_states.Find(floor_state)
		index--
		if(index < 1)
			index = allowed_states.len
		floor_state = allowed_states[index]
		check_directional_tile()
	if(href_list["cycleright"])
		var/index = allowed_states.Find(floor_state)
		index++
		if(index > allowed_states.len)
			index = 1
		floor_state = allowed_states[index]
		check_directional_tile()

	floor_icon = icon('whitesands/icons/turf/floors/tiles.dmi', floor_state, floor_dir)
	if(usr)
		attack_self(usr)

/obj/item/floor_painter/proc/check_directional_tile()
	var/icon/current = icon('whitesands/icons/turf/floors/tiles.dmi', floor_state, NORTHWEST)
	if(current.GetPixel(1,1) != null)
		allowed_directions = GLOB.alldirs
	else
		current = icon('whitesands/icons/turf/floors/tiles.dmi', floor_state, WEST)
		if(current.GetPixel(1,1) != null)
			allowed_directions = GLOB.cardinals
		else
			allowed_directions = list("south")

	if(!(dir2text(floor_dir) in allowed_directions))
		floor_dir = SOUTH

// Decal painter

/obj/item/decal_painter
	name = "decal painter"
	desc = "An airlock painter, reprogramed to use a different style of paint in order to apply decals for floor tiles as well, in addition to repainting doors. Decals break when the floor tiles are removed. Alt-Click to change design." //WS Edit - Floor Painters
	icon = 'icons/obj/objects.dmi'
	icon_state = "decal_sprayer"
	item_state = "decalsprayer"
	custom_materials = list(/datum/material/iron=2000, /datum/material/glass=500)
	var/stored_dir = 2
	var/stored_color = ""
	var/stored_decal = "warningline"
	var/stored_decal_total = "warningline"
	var/color_list = list("","red","white")
	var/dir_list = list(1,2,4,8)
	var/decal_list = list(list("Warning Line","warningline"),
			list("Warning Line Corner","warninglinecorner"),
			list("Caution Label","caution"),
			list("Directional Arrows","arrows"),
			list("Stand Clear Label","stand_clear"),
			list("Box","box"),
			list("Box Corner","box_corners"),
			list("Delivery Marker","delivery"),
			list("Warning Box","warn_full"))

/obj/item/decal_painter/afterattack(atom/target, mob/user, proximity)
	. = ..()
	var/turf/open/floor/F = target
	if(!proximity)
		to_chat(user, "<span class='notice'>You need to get closer!</span>")
		return
	if(isturf(F))
		F.AddComponent(/datum/component/decal, 'icons/turf/decals.dmi', stored_decal_total, stored_dir, CLEAN_TYPE_PAINT, color, null, null, alpha)
		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)

/obj/item/decal_painter/AltClick(mob/user)
	. = ..()
	ui_interact(user)

/obj/item/decal_painter/proc/update_decal_path()
	var/yellow_fix = "" //This will have to do until someone refactors markings.dm
	if (stored_color)
		yellow_fix = "_"
	stored_decal_total = "[stored_decal][yellow_fix][stored_color]"
	return

/obj/item/decal_painter/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DecalPainter", name)
		ui.open()

/obj/item/decal_painter/ui_data(mob/user)
	var/list/data = list()
	data["decal_direction"] = stored_dir
	data["decal_color"] = stored_color
	data["decal_style"] = stored_decal
	data["decal_list"] = list()
	data["color_list"] = list()
	data["dir_list"] = list()

	for(var/i in decal_list)
		data["decal_list"] += list(list(
			"name" = i[1],
			"decal" = i[2]
		))
	for(var/j in color_list)
		data["color_list"] += list(list(
			"colors" = j
		))
	for(var/k in dir_list)
		data["dir_list"] += list(list(
			"dirs" = k
		))
	return data

/obj/item/decal_painter/ui_act(action,list/params)
	if(..())
		return
	switch(action)
		//Lists of decals and designs
		if("select decal")
			var/selected_decal = params["decals"]
			stored_decal = selected_decal
		if("select color")
			var/selected_color = params["colors"]
			stored_color = selected_color
		if("selected direction")
			var/selected_direction = text2num(params["dirs"])
			stored_dir = selected_direction
	update_decal_path()
	. = TRUE
