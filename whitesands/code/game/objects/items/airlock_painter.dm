
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
	icon = 'icons/obj/objects.dmi'
	icon_state = "decal_sprayer"
	item_state = "decalsprayer"
	desc = "An airlock painter, reprogramed to use a different style of paint in order to apply decals for floor tiles. Decals break when the floor tiles are removed. Use it inhand to change the design."
	custom_materials = list(/datum/material/iron=2000, /datum/material/glass=500)

	var/decal_icon
	var/decal_state = "loadingarea"
	var/decal_dir = SOUTH
	var/decal_color = "#FFFFFF"

	var/list/allowed_directions = list("north", "east", "south", "west")

	var/list/allowed_states = list(
	"loadingarea","delivery","warning","warningcorner","warningcee","warningfulltile","warningfull","box_corners","box","caution","stand_clear",
	"arrows","overstripe","overstripecorner","overstripefull","overstripecee","stripe","stripecorner","stripefull","stripecee","stripefulltile",
	"danger","dangercorner","dangerfull","dangercee",
	"chapel", "outline", "spline_fancy",
	"spline_fancy_corner","spline_fancy_cee","spline_fancy_full","spline_plain","pline_plain_cee",
	"spline_plain_full","solarpanel","shutoff","traction","manydot",
	"techfloor_edges","techfloor_corners","techfloororange_edges","techfloororange_corners",
	"manydot_tiled","pryhole","corner_white","corner_oldtile","corner_kafel",
	"corner_techfloor_gray","corner_techfloor_grid","steel_grid","steel_decals1","steel_decals2",
	"steel_decals3","steel_decals4","steel_decals5","steel_decals6","steel_decals7",
	"steel_decals8","steel_decals9","steel_decals10","steel_decals_central1","steel_decals_central2",
	"steel_decals_central3","steel_decals_central4","steel_decals_central5","steel_decals_central_6","steel_decals_central7",
	"bordercolor","bordercolorcorner","bordercolorcorner2","bordercolorfull","bordercolorcee",
	"bordercolorhalf","bordercolormonofull","borderfloor_white","borderfloorfull_white","borderfloorcee_white","borderfloorcorner_white","borderfloorcorner2_white",
	"siding_line","siding_corner","siding_end","siding_thinplating_line","siding_thinplating_end",
	"siding_thinplating_corner","siding_wideplating_line","siding_wideplating_end","siding_wideplating_corner","siding_wood_line",
	"siding_wood_corner","siding_wood_end","trimline","trimline_corner","trimline_end","trimline_box","trimline_arrow_cw","trimline_arrow_ccw","trimline_fill",
	"trimline_corner_fill","trimline_end_fill","trimline_box_fill","trimline_arrow_cw_fill","trimline_arrow_ccw_fill",
	"trimline_shrink_cw","trimline_shrink_ccw","trimline_warn", "trimline_warn_fill"
	)

	var/list/color_disallowed = list(
	"loadingarea","chapel","solarpanel","techfloor_edges",
	"techfloororange_edges","techfloor_corners","techfloororange_corners",
	"techfloor_hole_left","techfloor_hole_right","corner_techfloor_gray",
	"corner_techfloor_grid","steel_grid","warning","warningcorner","warningfull","warningcee",
	"warningfulltile","danger","dangercorner","dangerfull","dangercee"
	)

	var/list/decal_no_dirs = list(
	"delivery","warningfull","box","warningfulltile","overstripefull",
	"stripefull","stripefulltile","outline","spline_fancy_full","spline_plain_full",
	"solarpanel","traction","manydot","manydot_tiled","dangerfull","bordercolorfull",
	"bordercolormonofull","trimline_box","trimline_box_fill","borderfloorfull_white"
	)

	var/list/decal_eight_dirs = list(
	"warning","stripe","spline_fancy","spline_plain","danger","techfloor_edges",
	"techfloororange_edges","steel_decals1","steel_decals3","steel_decals4",
	"steel_decals6","steel_decals7","steel_decals10","bordercolor","bordercolorcorner2",
	"borderfloor_white","siding_line","siding_thinplating_line","siding_wideplating_line",
	"siding_wood_line","trimline","trimline_fill","trimline_arrow_cw","trimline_arrow_ccw",
	"trimline_arrow_cw_fill","trimline_arrow_ccw_fill","trimline_warn","trimline_warn_fill"
	)

/obj/item/decal_painter/afterattack(var/atom/A, var/mob/user, proximity, params)
	if(!proximity)
		return

	var/turf/open/floor/F = A
	if(!istype(F))
		to_chat(user, "<span class='warning'>\The [src] can only be used on flooring.</span>")
		return
	if(color_disallowed.Find(decal_state))
		F.AddComponent(/datum/component/decal, 'whitesands/icons/turf/decals.dmi', decal_state, decal_dir, CLEAN_TYPE_PAINT, color, null, null, alpha)
	else
		F.AddComponent(/datum/component/decal, 'whitesands/icons/turf/decals.dmi', decal_state, decal_dir, CLEAN_TYPE_PAINT, decal_color, null, null, alpha)
	playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)

/obj/item/decal_painter/attack_self(var/mob/user)
	if(!user)
		return FALSE
	user.set_machine(src)
	interact(user)
	return TRUE

/obj/item/decal_painter/interact(mob/user as mob) //TODO: Make TGUI for this because ouch
	if(!decal_icon)
		decal_icon = icon('whitesands/icons/turf/decals.dmi', decal_state, decal_dir)
	user << browse_rsc(decal_icon, "floor.png")
	var/dat = {"
		<center>
			<img style="-ms-interpolation-mode: nearest-neighbor;" src="floor.png" width=128 height=128 border=4>
		</center>
		<center>
			<a href="?src=[UID()];cycleleft=1">&lt;-</a>
			<a href="?src=[UID()];choose_state=1">Choose Style</a>
			<a href="?src=[UID()];cycleright=1">-&gt;</a>
		</center>
		<div class='statusDisplay'>Style: [decal_state]</div>
		<center>
			<a href="?src=[UID()];cycledirleft=1">&lt;-</a>
			<a href="?src=[UID()];choose_dir=1">Choose Direction</a>
			<a href="?src=[UID()];cycledirright=1">-&gt;</a>
		</center>
		<div class='statusDisplay'>Direction: [dir2text(decal_dir)]</div>
		<center>
			<a href="?src=[UID()];choose_color=1">Choose Color</a>
		</center>
	"}

	var/datum/browser/popup = new(user, "decal_painter", name, 225, 310)
	popup.set_content(dat)
	popup.open()

/obj/item/decal_painter/Topic(href, href_list)
	if(..())
		return

	if(href_list["choose_state"])
		var/state = input("Please select a style", "[src]") as null|anything in allowed_states
		if(state)
			decal_state = state
			check_directional_tile()
	if(href_list["choose_dir"])
		var/seldir = input("Please select a direction", "[src]") as null|anything in allowed_directions
		if(seldir)
			decal_dir = text2dir(seldir)
	if(href_list["cycledirleft"])
		var/index = allowed_directions.Find(dir2text(decal_dir))
		index--
		if(index < 1)
			index = allowed_directions.len
		decal_dir = text2dir(allowed_directions[index])
	if(href_list["cycledirright"])
		var/index = allowed_directions.Find(dir2text(decal_dir))
		index++
		if(index > allowed_directions.len)
			index = 1
		decal_dir = text2dir(allowed_directions[index])
	if(href_list["cycleleft"])
		var/index = allowed_states.Find(decal_state)
		index--
		if(index < 1)
			index = allowed_states.len
		decal_state = allowed_states[index]
		check_directional_tile()
	if(href_list["cycleright"])
		var/index = allowed_states.Find(decal_state)
		index++
		if(index > allowed_states.len)
			index = 1
		decal_state = allowed_states[index]
		check_directional_tile()
	if(href_list["choose_color"])
		if(!(color_disallowed.Find(decal_state)))
			var/chosen_colour = input(usr, "", "Choose Color", decal_color) as color|null
			if (!isnull(chosen_colour) && usr.canUseTopic(src, BE_CLOSE, ismonkey(usr)))
				decal_color = chosen_colour


	decal_icon = icon('whitesands/icons/turf/decals.dmi', decal_state, decal_dir)
	if(usr)
		attack_self(usr)

/obj/item/decal_painter/proc/check_directional_tile()
	if(decal_eight_dirs.Find(decal_state))
		allowed_directions = list("north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest")
	else
		if(decal_no_dirs.Find(decal_state))
			allowed_directions = list("south")
		else
			allowed_directions = list("north", "east", "south", "west")

	if(!(dir2text(decal_dir) in allowed_directions))
		decal_dir = SOUTH
