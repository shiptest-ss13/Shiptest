#define ATMOS_CATEGORY 0
#define DISPOSALS_CATEGORY 1
#define TRANSIT_CATEGORY 2


/obj/machinery/pipedispenser
	name = "pipe dispenser"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "pipe_d"
	desc = "Dispenses countless types of pipes. Very useful if you need pipes."
	layer = GATEWAY_UNDERLAY_LAYER //so it renders underneath dispensed disposals
	density = TRUE
	circuit = /obj/item/circuitboard/machine/pipedispenser
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN_SILICON | INTERACT_MACHINE_OFFLINE
	var/delay = 0
	var/busy = FALSE
	var/p_dir = NORTH
	var/p_flipped = FALSE
	var/category = ATMOS_CATEGORY
	var/piping_layer = PIPING_LAYER_DEFAULT
	var/ducting_layer = DUCT_LAYER_DEFAULT
	var/datum/pipe_info/recipe
	var/paint_color = "grey"
	var/static/datum/pipe_info/first_atmos
	var/static/datum/pipe_info/first_disposal
	var/static/datum/pipe_info/first_transit

/obj/machinery/pipedispenser/Initialize()
	. = ..()
	if(!first_atmos)
		first_atmos = GLOB.atmos_pipe_recipes[GLOB.atmos_pipe_recipes[1]][1]
	if(!first_disposal)
		first_disposal = GLOB.disposal_pipe_recipes[GLOB.disposal_pipe_recipes[1]][1]
	if(!first_transit)
		first_transit = GLOB.transit_tube_recipes[GLOB.transit_tube_recipes[1]][1]

	recipe = first_atmos

/obj/machinery/pipedispenser/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/pipes),
	)

/obj/machinery/pipedispenser/attack_paw(mob/user)
	return attack_hand(user)

/obj/machinery/pipedispenser/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PipeDispenser", name)
		ui.open()

/obj/machinery/pipedispenser/ui_data(mob/user)
	var/list/data = list(
		"category" = category,
		"piping_layer" = piping_layer,
		"ducting_layer" = ducting_layer,
		"preview_rows" = recipe.get_preview(p_dir),
		"categories" = list(),
		"selected_color" = paint_color,
		"paint_colors" = GLOB.pipe_paint_colors
	)

	var/list/recipes
	switch(category)
		if(ATMOS_CATEGORY)
			recipes = GLOB.atmos_pipe_recipes
		if(DISPOSALS_CATEGORY)
			recipes = GLOB.disposal_pipe_recipes
		if(TRANSIT_CATEGORY)
			recipes = GLOB.transit_tube_recipes
	for(var/c in recipes)
		var/list/cat = recipes[c]
		var/list/r = list()
		for(var/i in 1 to cat.len)
			var/datum/pipe_info/info = cat[i]
			r += list(list("pipe_name" = info.name, "pipe_index" = i, "selected" = (info == recipe), "all_layers" = info.all_layers))
		data["categories"] += list(list("cat_name" = c, "recipes" = r))

	return data

/obj/machinery/pipedispenser/ui_act(action, params)
	. = ..()
	if(.)
		return

	if(!usr.canUseTopic(src, BE_CLOSE))
		return
	switch(action)
		if("color")
			paint_color = params["paint_color"]
		if("category")
			category = text2num(params["category"])
			switch(category)
				if(DISPOSALS_CATEGORY)
					recipe = first_disposal
				if(ATMOS_CATEGORY)
					recipe = first_atmos
				if(TRANSIT_CATEGORY)
					recipe = first_transit
			p_dir = NORTH
		if("print")
			make_pipe()
		if("piping_layer")
			piping_layer = text2num(params["piping_layer"])
		if("ducting_layer")
			ducting_layer = text2num(params["ducting_layer"])
		if("pipe_type")
			var/static/list/recipes
			if(!recipes)
				recipes = GLOB.disposal_pipe_recipes + GLOB.atmos_pipe_recipes + GLOB.transit_tube_recipes
			recipe = recipes[params["category"]][text2num(params["pipe_type"])]
			p_dir = NORTH
		if("setdir")
			p_dir = text2dir(params["dir"])
			p_flipped = text2num(params["flipped"])
	return TRUE

/obj/machinery/pipedispenser/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if (istype(W, /obj/item/pipe) || istype(W, /obj/item/pipe_meter))
		to_chat(usr, "<span class='notice'>You put [W] back into [src].</span>")
		qdel(W)
		return
	else
		return ..()

/obj/machinery/pipedispenser/wrench_act(mob/living/user, obj/item/I)
	..()
	if(default_unfasten_wrench(user, I, 40))
		user << browse(null, "window=pipedispenser")

	return TRUE

/obj/machinery/pipedispenser/screwdriver_act(mob/user, obj/item/I)
	panel_open = !panel_open
	I.play_tool_sound(src)
	to_chat(user, "<span class='notice'>You [panel_open?"open":"close"] the panel on [src].</span>")
	return TRUE

/obj/machinery/pipedispenser/crowbar_act(mob/living/user, obj/item/I)
	default_deconstruction_crowbar(I)
	return TRUE

//Allow you to drag-drop disposal pipes and transit tubes into it
/obj/machinery/pipedispenser/MouseDrop_T(obj/structure/pipe, mob/usr)
	if(usr.incapacitated())
		return

	if(!istype(pipe, /obj/structure/disposalconstruct) && !istype(pipe, /obj/structure/c_transit_tube) && !istype(pipe, /obj/structure/c_transit_tube_pod))
		return

	if(get_dist(usr, src) > 1 || get_dist(src,pipe) > 1)
		return

	if(pipe.anchored)
		return

	qdel(pipe)

/obj/machinery/pipedispenser/proc/make_pipe(mob/user)
	if(busy)
		src.visible_message(span_warning("[src] is busy."))
		return
	var/queued_p_type = recipe.id
	var/queued_p_dir = p_dir
	var/queued_p_flipped = p_flipped
	switch(category)
		if(ATMOS_CATEGORY)
			if(recipe.type == /datum/pipe_info/meter)
				new /obj/item/pipe_meter(loc)
				on_make_pipe()
			else
				if(recipe.all_layers == FALSE && (piping_layer == 1 || piping_layer == 5))
					src.visible_message(span_warning("[src] can't print this object on the layer..."))
					return
				var/obj/machinery/atmospherics/path = queued_p_type
				var/pipe_item_type = initial(path.construction_type) || /obj/item/pipe
				var/obj/item/pipe/P = new pipe_item_type(loc, queued_p_type, queued_p_dir)
				on_make_pipe()

				if(queued_p_flipped && istype(P, /obj/item/pipe/trinary/flippable))
					var/obj/item/pipe/trinary/flippable/F = P
					F.flipped = queued_p_flipped

				P.update()
				P.setPipingLayer(piping_layer)
				if(ispath(path, /obj/machinery/atmospherics/pipe) && !findtext("[queued_p_type]", "layer_manifold"))
					P.add_atom_colour(GLOB.pipe_paint_colors[paint_color], FIXED_COLOUR_PRIORITY)

		if(DISPOSALS_CATEGORY) //Making disposals pipes
			new /obj/structure/disposalconstruct(loc, queued_p_type, queued_p_dir, queued_p_flipped)
			on_make_pipe()
			return

		if(TRANSIT_CATEGORY) //Making transit tubes
			if(istype(queued_p_type, /obj/structure/c_transit_tube_pod))
				new /obj/structure/c_transit_tube_pod(loc)
				on_make_pipe()
			else
				var/obj/structure/c_transit_tube/tube = new queued_p_type(loc)
				on_make_pipe()
				tube.setDir(queued_p_dir)

				if(queued_p_flipped)
					tube.setDir(turn(queued_p_dir, 45))
					tube.simple_rotate_flip()

/obj/machinery/pipedispenser/proc/on_make_pipe()
	busy = TRUE
	delay = addtimer(CALLBACK(src, PROC_REF(reset_busy)), 5)

/obj/machinery/pipedispenser/proc/reset_busy()
	busy = FALSE

#undef ATMOS_CATEGORY
#undef DISPOSALS_CATEGORY
#undef TRANSIT_CATEGORY
