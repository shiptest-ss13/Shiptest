// Generates a list of numbered_display datums for the numerical display system.
/datum/component/storage/proc/_process_numerical_display()
	. = list()
	for(var/obj/item/I in accessible_items())
		if(QDELETED(I))
			continue
		if(!.[I.type])
			.[I.type] = new /datum/numbered_display(I, 1, src)
		else
			var/datum/numbered_display/ND = .[I.type]
			ND.number++

// Orients all objects in legacy mode, and returns the objects to show to the user.
/datum/component/storage/proc/orient2hud_legacy(mob/user, maxcolumns)
	. = list()
	var/list/accessible_contents = accessible_items()
	var/adjusted_contents = length(accessible_contents)
	var/atom/movable/screen/storage/close/ui_close
	var/atom/movable/screen/storage/boxes/ui_boxes

	//Numbered contents display
	var/list/datum/numbered_display/numbered_contents
	if(display_numerical_stacking)
		numbered_contents = _process_numerical_display()
		adjusted_contents = numbered_contents.len

	var/columns = limited_random_access_stack_position == 0 ? clamp(max_items, 1, maxcolumns ? maxcolumns : screen_max_columns) : clamp(limited_random_access_stack_position, 1, maxcolumns ? maxcolumns : screen_max_columns)
	var/rows = clamp(CEILING(adjusted_contents / columns, 1), 1, screen_max_rows)

	// First, boxes.
	ui_boxes = get_ui_boxes()
	ui_boxes.screen_loc = "[screen_start_x]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y] to [screen_start_x+columns-1]:[screen_pixel_x],[screen_start_y+rows-1]:[screen_pixel_y]"
	. += ui_boxes
	// Then, closer.
	ui_close = get_ui_close()
	ui_close.screen_loc = "[screen_start_x + columns]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y]"
	. += ui_close
	// Then orient the actual items.
	var/cx = screen_start_x
	var/cy = screen_start_y
	if(islist(numbered_contents))
		for(var/type in numbered_contents)
			var/datum/numbered_display/ND = numbered_contents[type]
			ND.sample_object.mouse_opacity = MOUSE_OPACITY_OPAQUE
			ND.sample_object.screen_loc = "[cx]:[screen_pixel_x],[cy]:[screen_pixel_y]"
			ND.sample_object.maptext = "<font color='white'>[(ND.number > 1)? "[ND.number]" : ""]</font>"
			ND.sample_object.layer = ABOVE_HUD_LAYER
			ND.sample_object.plane = ABOVE_HUD_PLANE
			. += ND.sample_object
			cx++
			if(cx - screen_start_x >= columns)
				cx = screen_start_x
				cy++
				if(cy - screen_start_y >= rows)
					break
	else
		for(var/obj/O in accessible_items())
			if(QDELETED(O))
				continue
			var/atom/movable/screen/storage/item_holder/D = new(null, src, O)
			D.mouse_opacity = MOUSE_OPACITY_OPAQUE //This is here so storage items that spawn with contents correctly have the "click around item to equip"
			D.screen_loc = "[cx]:[screen_pixel_x],[cy]:[screen_pixel_y]"
			O.maptext = ""
			O.layer = ABOVE_HUD_LAYER
			O.plane = ABOVE_HUD_PLANE
			. += D
			cx++
			if(cx - screen_start_x >= columns)
				cx = screen_start_x
				cy++
				if(cy - screen_start_y >= rows)
					break

// Orients all objects in .. volumetric mode. Does not support numerical display!
/datum/component/storage/proc/orient2hud_volumetric(mob/user, maxcolumns)
	. = list()
	var/atom/movable/screen/storage/left/ui_left
	var/atom/movable/screen/storage/continuous/ui_continuous
	var/atom/movable/screen/storage/close/ui_close

	// Generate ui_item_blocks for missing ones and render+orient.
	var/list/atom/contents = accessible_items()
	// our volume
	var/our_volume = get_max_volume()
	var/horizontal_pixels = (maxcolumns * world.icon_size) - (VOLUMETRIC_STORAGE_EDGE_PADDING * 2)
	var/max_horizontal_pixels = horizontal_pixels * screen_max_rows
	// sigh loopmania time
	var/used = 0
	// define outside for performance
	var/volume
	var/list/volume_by_item = list()
	var/list/percentage_by_item = list()
	for(var/obj/item/I in contents)
		if(QDELETED(I))
			continue
		volume = I.get_w_volume()
		used += volume
		volume_by_item[I] = volume
		percentage_by_item[I] = volume / get_max_volume()
	var/padding_pixels = ((length(percentage_by_item) - 1) * VOLUMETRIC_STORAGE_ITEM_PADDING) + VOLUMETRIC_STORAGE_EDGE_PADDING * 2
	var/min_pixels = (MINIMUM_PIXELS_PER_ITEM * length(percentage_by_item)) + padding_pixels
	// do the check for fallback for when someone has too much gamer gear
	if((min_pixels) > (max_horizontal_pixels + 4))	// 4 pixel grace zone
		to_chat(user, span_warning("[parent] was showed to you in legacy mode due to your items overrunning the three row limit! Consider not carrying too much or bugging a maintainer to raise this limit!"))
		return orient2hud_legacy(user, maxcolumns)
	// after this point we are sure we can somehow fit all items into our max number of rows.

	// determine rows
	var/rows = clamp(CEILING(min_pixels / horizontal_pixels, 1), 1, screen_max_rows)

	var/overrun = FALSE
	if(used > our_volume)
		// congratulations we are now in overrun mode. everything will be crammed to minimum storage pixels.
		to_chat(user, span_warning("[parent] rendered in overrun mode due to more items inside than the maximum volume supports."))
		overrun = TRUE

	// how much we are using
	var/using_horizontal_pixels = horizontal_pixels * rows

	// item padding
	using_horizontal_pixels -= padding_pixels

	// define outside for marginal performance boost
	var/obj/item/I
	// start at this pixel from screen_start_x.
	var/current_pixel = VOLUMETRIC_STORAGE_EDGE_PADDING
	var/first = TRUE
	var/row = 1

	for(var/i in percentage_by_item)
		I = i
		var/percent = percentage_by_item[I]
		var/atom/movable/screen/storage/volumetric_box/center/B = new /atom/movable/screen/storage/volumetric_box/center(null, src, I)
		// SNOWFLAKE: force it to icon until we unfuck storage/click passing
		I.mouse_opacity = MOUSE_OPACITY_ICON
		var/pixels_to_use = overrun? MINIMUM_PIXELS_PER_ITEM : max(using_horizontal_pixels * percent, MINIMUM_PIXELS_PER_ITEM)
		var/addrow = FALSE
		if(CEILING(pixels_to_use, 1) >= FLOOR(horizontal_pixels - current_pixel - VOLUMETRIC_STORAGE_EDGE_PADDING, 1))
			pixels_to_use = horizontal_pixels - current_pixel - VOLUMETRIC_STORAGE_EDGE_PADDING
			addrow = TRUE

		// now that we have pixels_to_use, place our thing and add it to the returned list.
		B.screen_loc = "[screen_start_x]:[round(current_pixel + (pixels_to_use * 0.5) + (first? 0 : VOLUMETRIC_STORAGE_ITEM_PADDING), 1)],[screen_start_y+row-1]:[screen_pixel_y]"
		// add the used pixels to pixel after we place the object
		current_pixel += pixels_to_use + (first? 0 : VOLUMETRIC_STORAGE_ITEM_PADDING)
		first = FALSE		//apply padding to everything after this

		// set various things
		B.set_pixel_size(pixels_to_use)
		B.name = I.name

		// finally add our things.
		. += B.on_screen_objects()

		// go up a row if needed
		if(addrow)
			row++
			first = TRUE		//first in the row, don't apply between-item padding.
			current_pixel = VOLUMETRIC_STORAGE_EDGE_PADDING

	// Then, continuous section.
	ui_continuous = get_ui_continuous()
	ui_continuous.screen_loc = "[screen_start_x]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y] to [screen_start_x+maxcolumns-1]:[screen_pixel_x],[screen_start_y+rows-1]:[screen_pixel_y]"
	. += ui_continuous
	// Then, left.
	ui_left = get_ui_left()
	ui_left.screen_loc = "[screen_start_x]:[screen_pixel_x - 2],[screen_start_y]:[screen_pixel_y] to [screen_start_x]:[screen_pixel_x - 2],[screen_start_y+rows-1]:[screen_pixel_y]"
	. += ui_left
	// Then, closer, which is also our right element.
	ui_close = get_ui_close()
	ui_close.screen_loc = "[screen_start_x + maxcolumns]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y] to [screen_start_x + maxcolumns]:[screen_pixel_x],[screen_start_y + row - 1]:[screen_pixel_y]"
	. += ui_close


// Shows our UI to a mob.
/datum/component/storage/proc/ui_show(mob/M)
	if(!M.client)
		return FALSE
	if(ui_by_mob[M] || LAZYFIND(is_using, M))
		// something went horribly wrong
		// hide first
		ui_hide(M)
	var/list/cview = getviewsize(M.client.view)
	// in tiles
	var/maxallowedscreensize = cview[1]-8
	// we got screen size, register signal
	RegisterSignal(M, COMSIG_QDELETING, PROC_REF(on_logout), override = TRUE)
	if(M.active_storage != src)
		if(M.active_storage)
			M.active_storage.ui_hide(M)
		M.active_storage = src
	LAZYOR(is_using, M)
	if(volumetric_ui())
		//new volumetric ui bay-style
		var/list/objects = orient2hud_volumetric(M, maxallowedscreensize)
		M.client.screen |= objects
		ui_by_mob[M] = objects
	else
		//old ui
		var/list/objects = orient2hud_legacy(M, maxallowedscreensize)
		M.client.screen |= objects
		ui_by_mob[M] = objects
	return TRUE

// VV hooked to ensure no lingering screen objects.
/datum/component/storage/vv_edit_var(var_name, var_value)
	var/list/old
	if(var_name == NAMEOF(src, storage_flags))
		old = is_using.Copy()
		for(var/i in is_using)
			ui_hide(i)
	. = ..()
	if(old)
		for(var/i in old)
			ui_show(i)

// Proc triggered by signal to ensure logging out clients don't linger.
/datum/component/storage/proc/on_logout(datum/source, client/C)
	ui_hide(source)

// Hides our UI from a mob
/datum/component/storage/proc/ui_hide(mob/M)
	if(!M.client)
		return TRUE
	UnregisterSignal(M, list(COMSIG_QDELETING))
	M.client.screen -= ui_by_mob[M]
	var/list/objects = ui_by_mob[M]
	QDEL_LIST(objects)
	if(M.active_storage == src)
		M.active_storage = null
	LAZYREMOVE(is_using, M)
	return TRUE

// Returns TRUE if we are using volumetric UI instead of box UI
/datum/component/storage/proc/volumetric_ui()
	var/atom/real_location = real_location()
	return (storage_flags & STORAGE_LIMIT_VOLUME) && (length(real_location.contents) <= MAXIMUM_VOLUMETRIC_ITEMS) && !display_numerical_stacking

// Gets our ui_boxes, making it if it doesn't exist.
/datum/component/storage/proc/get_ui_boxes()
	return new /atom/movable/screen/storage/boxes(null, src)

// Gets our ui_left, making it if it doesn't exist.
/datum/component/storage/proc/get_ui_left()
	return new /atom/movable/screen/storage/left(null, src)

// Gets our ui_close, making it if it doesn't exist.
/datum/component/storage/proc/get_ui_close()
	return new /atom/movable/screen/storage/close(null, src)

// Gets our ui_continuous, making it if it doesn't exist.
/datum/component/storage/proc/get_ui_continuous()
	return new /atom/movable/screen/storage/continuous(null, src)
