#define DEFAULT_SHELF_CAPACITY 3
#define DEFAULT_SHELF_USE_DELAY 10

/obj/structure/crate_shelf
	icon = 'icons/obj/structures.dmi'
	icon_state = "rwindow"

	var/capacity = DEFAULT_SHELF_CAPACITY
	var/useDelay = DEFAULT_SHELF_USE_DELAY
	var/list/shelf_contents

/obj/structure/crate_shelf/Initialize()
	. = ..()
	shelf_contents = new/list(capacity)

/obj/structure/crate_shelf/MouseDrop_T(obj/structure/closet/crate/crate, mob/user)
	if(!isliving(user))
		return
	if(crate.opened)
		if(!crate.close())
			return
	var/next_free = shelf_contents.Find(null)
	if(next_free)
		if(do_after(user, useDelay, target = crate))
			shelf_contents[next_free] = crate
			var/crate_index = shelf_contents.Find(crate)
			crate.forceMove(src)
			crate.pixel_y = 8 * (crate_index - 1)
			crate.layer += 0.01 * (crate_index - 1)
			handle_visuals()
	else
		balloon_alert(user, "shelf full!")
	return

/obj/structure/crate_shelf/proc/handle_visuals()
	src.vis_contents = src.contents
	return
