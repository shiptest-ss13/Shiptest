#define DEFAULT_SHELF_CAPACITY 3 // Default capacity of the shelf
#define DEFAULT_SHELF_USE_DELAY 10 // Default interaction delay of the shelf
#define DEFAULT_SHELF_VERTICAL_OFFSET 10 // Vertical pixel offset of shelving-related things. Set to 10 by default due to this leaving more of the crate on-screen to be clicked.

/obj/structure/crate_shelf
	name = "crate shelf"
	desc = "It's a shelf! For storing crates!"
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
	shelf_contents = new/list(capacity) // Initialize our shelf's contents list, this will be used later in MouseDrop_T().
	var/stack_layer // This is used to generate the sprite layering of the shelf pieces.
	var/stack_offset // This is used to generate the vertical offset of the shelf pieces.
	for(var/i in 1 to (capacity - 1))
		stack_layer  = BELOW_OBJ_LAYER + (0.02 * i) - 0.01 // Make each shelf piece render above the last, but below the crate that should be on it.
		stack_offset = DEFAULT_SHELF_VERTICAL_OFFSET * i // Make each shelf piece physically above the last.
		overlays += image(icon = 'icons/obj/objects.dmi', icon_state = "shelf_stack", layer = stack_layer, pixel_y = stack_offset)
	return

/obj/structure/crate_shelf/Destroy()
	var/turf/dump_turf = drop_location()
	for(var/obj/structure/closet/crate/crate in shelf_contents)
		crate.layer = BELOW_OBJ_LAYER // Reset the crates back to default visual state
		crate.pixel_y = 0
		crate.forceMove(dump_turf)
		step(crate, pick(GLOB.alldirs)) // Shuffle the crates around as though they've fallen down.
		crate.SpinAnimation(rand(4,7), 1) // Spin the crates around a little as they fall. Randomness is applied so it doesn't look weird.
		if(prob(10))
			if(crate.open()) // Break some open, cause a little chaos
				crate.visible_message("<span class='warning'>[crate]'s lid falls open!</span>")
	shelf_contents.Cut()
	return ..()

/obj/structure/crate_shelf/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There are some <b>bolts</b> holding [src] together.</span>"
	if(contents.len)
		. += "<span class='notice'>It contains:</span>"
		for(var/obj/structure/closet/crate/crate in shelf_contents)
			. += "	[icon2html(crate, user)] [crate]"

/obj/structure/crate_shelf/MouseDrop_T(obj/structure/closet/crate/crate, mob/user)
	if(!istype(crate, /obj/structure/closet/crate))
		return FALSE // If it's not a crate, don't put it in!
	if(!src.Adjacent(crate))
		return FALSE // If it's not next to the shelf, don't put it in!
	if(!isliving(user))
		return FALSE // While haunted shelves sound funny, they are quite dangerous in practice. Prevent ghosts from loading into shelves.
	if(crate.opened) // If the crate is open, try to close it.
		if(!crate.close())
			return FALSE // If we fail to close it, don't load it into the shelf.
	return load(crate, user) // Try to load the crate into the shelf.

/obj/structure/crate_shelf/proc/handle_visuals()
	vis_contents = contents // It really do be that shrimple.
	return

/obj/structure/crate_shelf/proc/load(obj/structure/closet/crate/crate, mob/user)
	var/next_free = shelf_contents.Find(null) // Find the first empty slot in the shelf.
	if(!next_free) // If we don't find an empty slot, return early.
		balloon_alert(user, "shelf full!")
		return FALSE
	if(do_after(user, use_delay, target = crate))
		shelf_contents[next_free] = crate // Insert a reference to the crate into the free slot.
		crate.forceMove(src) // Insert the crate into the shelf.
		crate.pixel_y = DEFAULT_SHELF_VERTICAL_OFFSET * (next_free - 1) // Adjust the vertical offset of the crate to look like it's on the shelf.
		crate.layer = BELOW_OBJ_LAYER + 0.02 * (next_free - 1) // Adjust the layer of the crate to look like it's in the shelf.
		handle_visuals()
		return TRUE
	return FALSE // If the do_after() is interrupted, return FALSE!

/obj/structure/crate_shelf/proc/unload(obj/structure/closet/crate/crate, mob/user)
	var/turf/unload_turf = get_turf(get_step(user, user.dir)) // We'll unload the crate onto the turf directly in front of the user.
	if(get_turf(src) == unload_turf) // If we're going to just drop it back onto the shelf, don't!
		balloon_alert(user, "no room!")
		return FALSE
	if(!unload_turf.Adjacent(src))
		balloon_alert(user, "too far!")
		return FALSE
	if(!unload_turf.Enter(crate, no_side_effects = TRUE)) // If moving the crate from the shelf to the desired turf would bump, don't do it! Thanks Kapu1178 for the help here. - Generic DM
		balloon_alert(user, "no room!")
		return FALSE
	if(do_after(user, use_delay, target = crate))
		crate.layer = BELOW_OBJ_LAYER // Reset the crate back to having the default layer, otherwise we might get strange interactions.
		crate.pixel_y = 0 // Reset the crate back to having no offset, otherwise it will be floating.
		crate.forceMove(unload_turf)
		shelf_contents[shelf_contents.Find(crate)] = null // We do this instead of removing it from the list to preserve the order of the shelf.
		handle_visuals()
		return TRUE

/obj/item/rack_parts/shelf
	name = "shelf parts"
	desc = "Parts of a shelf."
	construction_type = /obj/structure/crate_shelf
