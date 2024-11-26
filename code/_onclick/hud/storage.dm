/atom/movable/screen/storage
	name = "storage"
	var/insertion_click = FALSE

/atom/movable/screen/storage/Initialize(mapload, new_master)
	. = ..()
	master = new_master

/atom/movable/screen/storage/Click(location, control, params)
	if(!insertion_click)
		return ..()
	if(hud?.mymob && (hud.mymob != usr))
		return
	// just redirect clicks
	if(master)
		var/obj/item/I = usr.get_active_held_item()
		if(I)
			master.attackby(null, I, usr, params)
	return TRUE

/atom/movable/screen/storage/boxes
	name = "storage"
	icon_state = "block"
	screen_loc = "7,7 to 10,8"
	layer = HUD_LAYER
	plane = HUD_PLANE
	insertion_click = TRUE

/atom/movable/screen/storage/close
	name = "close"
	layer = ABOVE_HUD_LAYER
	plane = ABOVE_HUD_PLANE
	icon_state = "backpack_close"

/atom/movable/screen/storage/close/Click()
	var/datum/component/storage/S = master
	S.close(usr)
	return TRUE

/atom/movable/screen/storage/left
	icon_state = "storage_start"
	insertion_click = TRUE

/atom/movable/screen/storage/right
	icon_state = "storage_end"
	insertion_click = TRUE

/atom/movable/screen/storage/continuous
	icon_state = "storage_continue"
	insertion_click = TRUE

/atom/movable/screen/storage/volumetric_box
	icon_state = "stored_continue"
	layer = VOLUMETRIC_STORAGE_BOX_LAYER
	plane = VOLUMETRIC_STORAGE_BOX_PLANE
	var/obj/item/our_item

/atom/movable/screen/storage/volumetric_box/Initialize(mapload, new_master, obj/item/our_item)
	src.our_item = our_item
	RegisterSignal(our_item, COMSIG_ITEM_MOUSE_ENTER, PROC_REF(on_item_mouse_enter))
	RegisterSignal(our_item, COMSIG_ITEM_MOUSE_EXIT, PROC_REF(on_item_mouse_exit))
	return ..()

/atom/movable/screen/storage/volumetric_box/Destroy()
	makeItemInactive()
	our_item = null
	return ..()

/atom/movable/screen/storage/volumetric_box/Click(location, control, params)
	return our_item.Click(location, control, params)

/atom/movable/screen/storage/volumetric_box/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	return our_item.MouseDrop(over, src_location, over_location, src_control, over_control, params)

/atom/movable/screen/storage/volumetric_box/MouseExited(location, control, params)
	makeItemInactive()

/atom/movable/screen/storage/volumetric_box/MouseEntered(location, control, params)
	. = ..()
	makeItemActive()

/atom/movable/screen/storage/volumetric_box/proc/on_item_mouse_enter()
	makeItemActive()

/atom/movable/screen/storage/volumetric_box/proc/on_item_mouse_exit()
	makeItemInactive()

/atom/movable/screen/storage/volumetric_box/proc/makeItemInactive()
	return

/atom/movable/screen/storage/volumetric_box/proc/makeItemActive()
	return

/atom/movable/screen/storage/volumetric_box/center
	icon_state = "stored_continue"
	var/atom/movable/screen/storage/volumetric_edge/stored_left/left
	var/atom/movable/screen/storage/volumetric_edge/stored_right/right
	var/atom/movable/screen/storage/item_holder/holder
	var/pixel_size

/atom/movable/screen/storage/volumetric_box/center/Initialize(mapload, new_master, our_item)
	left = new(null, src, our_item)
	right = new(null, src, our_item)
	return ..()

/atom/movable/screen/storage/volumetric_box/center/Destroy()
	QDEL_NULL(left)
	QDEL_NULL(right)
	vis_contents.Cut()
	if(holder)
		QDEL_NULL(holder)
	return ..()

/atom/movable/screen/storage/volumetric_box/center/proc/on_screen_objects()
	return list(src)


//Sets the size of this box screen object and regenerates its left/right borders. This includes the actual border's size!
/atom/movable/screen/storage/volumetric_box/center/proc/set_pixel_size(pixels)
	if(pixel_size == pixels)
		return
	pixel_size = pixels
	cut_overlays()
	vis_contents.Cut()
	//our icon size is 32 pixels.
	var/multiplier = (pixels - (VOLUMETRIC_STORAGE_BOX_BORDER_SIZE * 2)) / VOLUMETRIC_STORAGE_BOX_ICON_SIZE
	transform = matrix(multiplier, 0, 0, 0, 1, 0)
	if(our_item)
		if(holder)
			qdel(holder)
		holder = new(null, src, our_item)
		holder.transform = matrix(1 / multiplier, 0, 0, 0, 1, 0)
		holder.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		holder.appearance_flags &= ~RESET_TRANSFORM
		makeItemInactive()
	vis_contents += holder
	left.pixel_x = -((pixels - VOLUMETRIC_STORAGE_BOX_ICON_SIZE) * 0.5) - VOLUMETRIC_STORAGE_BOX_BORDER_SIZE
	right.pixel_x = ((pixels - VOLUMETRIC_STORAGE_BOX_ICON_SIZE) * 0.5) + VOLUMETRIC_STORAGE_BOX_BORDER_SIZE
	add_overlay(left)
	add_overlay(right)

/atom/movable/screen/storage/volumetric_box/center/makeItemInactive()
	if(!holder)
		return
	holder.layer = VOLUMETRIC_STORAGE_ITEM_LAYER
	holder.plane = VOLUMETRIC_STORAGE_ITEM_PLANE

/atom/movable/screen/storage/volumetric_box/center/makeItemActive()
	if(!holder)
		return
	holder.our_item.layer = VOLUMETRIC_STORAGE_ACTIVE_ITEM_LAYER		//make sure we display infront of the others!
	holder.our_item.plane = VOLUMETRIC_STORAGE_ACTIVE_ITEM_PLANE

/atom/movable/screen/storage/volumetric_edge
	layer = VOLUMETRIC_STORAGE_BOX_LAYER
	plane = VOLUMETRIC_STORAGE_BOX_PLANE

/atom/movable/screen/storage/volumetric_edge/Initialize(mapload, master, our_item)
	src.master = master
	return ..()

/atom/movable/screen/storage/volumetric_edge/Click(location, control, params)
	return master.Click(location, control, params)

/atom/movable/screen/storage/volumetric_edge/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	return master.MouseDrop(over, src_location, over_location, src_control, over_control, params)

/atom/movable/screen/storage/volumetric_edge/MouseExited(location, control, params)
	return master.MouseExited(location, control, params)

/atom/movable/screen/storage/volumetric_edge/MouseEntered(location, control, params)
	. = ..()
	return master.MouseEntered(location, control, params)

/atom/movable/screen/storage/volumetric_edge/stored_left
	icon_state = "stored_start"
	appearance_flags = APPEARANCE_UI | KEEP_APART | RESET_TRANSFORM // Yes I know RESET_TRANSFORM is in APPEARANCE_UI but we're hard-asserting this incase someone changes it.

/atom/movable/screen/storage/volumetric_edge/stored_right
	icon_state = "stored_end"
	appearance_flags = APPEARANCE_UI | KEEP_APART | RESET_TRANSFORM

/atom/movable/screen/storage/item_holder
	var/obj/item/our_item
	vis_flags = NONE

/atom/movable/screen/storage/item_holder/Initialize(mapload, new_master, obj/item/I)
	. = ..()
	our_item = I
	vis_contents += I

/atom/movable/screen/storage/item_holder/Destroy()
	vis_contents.Cut()
	our_item = null
	return ..()

/atom/movable/screen/storage/item_holder/Click(location, control, params)
	return our_item.Click(location, control, params)
