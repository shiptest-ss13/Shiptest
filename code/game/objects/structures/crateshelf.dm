#define DEFAULT_SHELF_CAPACITY 3
#define DEFAULT_SHELF_USE_DELAY 10

/obj/structure/crate_shelf
	icon = 'icons/obj/structures.dmi'
	icon_state = "rwindow"

	var/capacity = DEFAULT_SHELF_CAPACITY
	var/useDelay = DEFAULT_SHELF_USE_DELAY

/obj/structure/crate_shelf/MouseDrop_T(obj/structure/closet/crate/crate, mob/user)
	if(!isliving(user))
		return
	if(src.contents.len < capacity)
		if(do_after(user, useDelay, target = crate))
			crate.forceMove(src)
			crate.pixel_y = 8 * (src.contents.len - 1)
			handle_visuals()
	else
		balloon_alert(user, "shelf full!")
	return

/obj/structure/crate_shelf/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(src.contents)
		for(var/obj/structure/closet/crate/crate in src.contents)
			crate.forceMove(src.loc)
			crate.pixel_y = 0
		handle_visuals()

	return

/obj/structure/crate_shelf/proc/handle_visuals()
	src.vis_contents = src.contents
	return
