#define DEFAULT_SHELF_CAPACITY 3
#define DEFAULT_SHELF_USE_DELAY 10

/obj/structure/crate_shelf
	icon = 'icons/obj/objects.dmi'
	icon_state = "shelf_base"
	density = TRUE
	anchored = TRUE

	var/capacity = DEFAULT_SHELF_CAPACITY
	var/useDelay = DEFAULT_SHELF_USE_DELAY
	var/list/shelf_contents

/obj/structure/crate_shelf/tall
	capacity = 12

/obj/structure/crate_shelf/Initialize()
	. = ..()
	shelf_contents = new/list(capacity)
	var/stack_layer = BELOW_OBJ_LAYER
	var/stack_offset
	for(var/i=1,i<capacity,i++)
		stack_layer += (0.02 * i) - 0.01
		stack_offset = i * 10
		overlays += image(icon = 'icons/obj/objects.dmi', icon_state = "shelf_stack", layer = stack_layer, pixel_y = stack_offset)
	return

/obj/structure/crate_shelf/MouseDrop_T(obj/structure/closet/crate/crate, mob/user)
	if(!src.Adjacent(user, mover = crate))
		return
	if(!isliving(user))
		return
	if(!crate.close())
		return
	var/next_free = shelf_contents.Find(null)
	if(next_free)
		if(do_after(user, useDelay, target = crate))
			shelf_contents[next_free] = crate
			crate.forceMove(src)
			crate.pixel_y = 10 * (next_free - 1)
			crate.layer = BELOW_OBJ_LAYER + 0.02 * (next_free - 1)
			handle_visuals()
	else
		balloon_alert(user, "shelf full!")
	return

/obj/structure/crate_shelf/proc/handle_visuals()
	src.vis_contents = src.contents
	return
