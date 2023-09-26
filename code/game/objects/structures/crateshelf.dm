#define DEFAULT_SHELF_CAPACITY 3 // Default capacity of the shelf
#define DEFAULT_SHELF_USE_DELAY 10 // Default interaction delay of the shelf
#define DEFAULT_SHELF_VERTICAL_OFFSET 10 // Vertical pixel offset of shelving-related things. Set to 10 by default due to this leaving more of the crate on-screen to be clicked.

/obj/structure/crate_shelf
	icon = 'icons/obj/objects.dmi'
	icon_state = "shelf_base"
	density = TRUE
	anchored = TRUE

	var/capacity = DEFAULT_SHELF_CAPACITY
	var/use_delay = DEFAULT_SHELF_USE_DELAY
	var/list/shelf_contents

/obj/structure/crate_shelf/tall
	capacity = 12

/obj/structure/crate_shelf/Initialize()
	. = ..()
	shelf_contents = new/list(capacity) // Initialize our shelf's contents list, this will be used later in MouseDrop_T
	var/stack_layer
	var/stack_offset
	for(var/i in 1 to (capacity - 1))
		stack_layer  = BELOW_OBJ_LAYER + (0.02 * i) - 0.01
		stack_offset = DEFAULT_SHELF_VERTICAL_OFFSET * i
		overlays += image(icon = 'icons/obj/objects.dmi', icon_state = "shelf_stack", layer = stack_layer, pixel_y = stack_offset)
	return

/obj/structure/crate_shelf/MouseDrop_T(obj/structure/closet/crate/crate, mob/user)
	if(!istype(crate, /obj/structure/closet/crate))
		return
	if(!src.Adjacent(crate))
		return
	if(!isliving(user))
		return
	if(crate.opened) // If the crate is open, try to close it.
		if(!crate.close())
			return // If we fail to close it, don't load it into the shelf.
	return load(crate, user)

/obj/structure/crate_shelf/proc/handle_visuals()
	vis_contents = contents
	return

/obj/structure/crate_shelf/proc/load(obj/structure/closet/crate/crate, mob/user)
	var/next_free = shelf_contents.Find(null) // Find the first empty slot in the shelf
	if(!next_free) // If we don't find an empty slot, return early
		balloon_alert(user, "shelf full!")
		return FALSE
	if(do_after(user, use_delay, target = crate))
		shelf_contents[next_free] = crate // Insert a reference to the crate into the free slot
		crate.forceMove(src) // Insert the crate into the shelf
		crate.pixel_y = DEFAULT_SHELF_VERTICAL_OFFSET * (next_free - 1) // Adjust the vertical offset of the crate to look like it's on the shelf
		crate.layer = BELOW_OBJ_LAYER + 0.02 * (next_free - 1) // Adjust the layer of the crate to look like it's in the shelf
		handle_visuals()
		return TRUE
	return FALSE // If the do_after() is interrupted, return FALSE!

/obj/structure/crate_shelf/proc/unload(obj/structure/closet/crate/crate, mob/user)
	if(do_after(user, use_delay, target = crate))
		var/turf/unload_turf = get_turf(get_step(user, user.dir)) // We'll unload the crate onto the turf directly in front of the user
		if(get_turf(src) == unload_turf)
			return FALSE // If we're going to just drop it back onto the shelf, don't!
		if(!unload_turf.Adjacent(src))
			return FALSE
		if(!unload_turf.Enter(crate, no_side_effects = TRUE))
			return FALSE // If moving the crate from the shelf to the desired turf would bump, don't do it! Thanks Kapu1178 for the help here. - Generic DM
		crate.layer = BELOW_OBJ_LAYER // Reset the crate back to having the default layer, otherwise we might get strange interactions
		crate.pixel_y = 0 // Reset the crate back to having no offset, otherwise it will be floating
		crate.forceMove(unload_turf)
		shelf_contents[shelf_contents.Find(crate)] = null // We do this instead of removing it from the list to preserve the order of the shelf
		handle_visuals()
		return TRUE

/obj/item/rack_parts/shelf
	name = "shelf parts"
	desc = "Parts of a shelf."
	construction_type = /obj/structure/crate_shelf
