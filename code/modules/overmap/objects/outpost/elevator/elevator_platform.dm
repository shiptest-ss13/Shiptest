/obj/structure/elevator_platform
	name = "elevator platform"
	desc = "A lightweight elevator platform. It moves up and down."
	icon = 'icons/obj/smooth_structures/catwalk.dmi'
	icon_state = "catwalk-0"
	base_icon_state = "catwalk"

	density = FALSE
	anchored = TRUE
	// do not break these please
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	max_integrity = 200 // built like a brick shithouse, it it could move up and down
	resistance_flags = LAVA_PROOF | FIRE_PROOF

	layer = TURF_PLATING_DECAL_LAYER //under pipes
	plane = FLOOR_PLANE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_ELEVATOR)
	canSmoothWith = list(SMOOTH_GROUP_ELEVATOR)
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN

	/// The list of things to move when the platform does.
	/// I would love to handle this imperatively, i.e. by reading off of turf contents.
	/// Unfortunately, there are a million fucking edge cases that make that difficult.
	var/list/atom/movable/lift_load // things to move
	// handles behavior
	var/datum/elevator_master/master_datum

/obj/structure/elevator_platform/Initialize(mapload)
	. = ..()

	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = .proc/AddItemOnPlat,
		COMSIG_ATOM_CREATED = .proc/AddItemOnPlat,
		COMSIG_ATOM_EXITED = .proc/RemoveItemFromPlat
	)
	AddElement(/datum/element/connect_loc, connections)

	if(!master_datum)
		// if there are adjacent platforms with masters, reach them
		for(var/obj/structure/elevator_platform/plat as anything in get_adj_platforms())
			if(plat.master_datum)
				master_datum.add_platform(src)
				break
		if(!master_datum)
			// runs a flood-fill starting at src, adding reached platforms to the
			// new master. this ensures that contiguous maploaded platforms init
			// with only a single master_datum, regardless of init order
			master_datum = new(src)

/obj/structure/elevator_platform/Destroy()
	if(master_datum)
		master_datum.remove_platform(src)

	// industrial lifts had some (only semi-functional) code here for splitting
	// lifts into separate platforms on platform deletion. that's difficult to do well
	// and not all THAT necessary, so i didn't do it. laziness wins!
	return ..()

/obj/structure/elevator_platform/proc/AddItemOnPlat(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(AM in lift_load)
		return
	LAZYADD(lift_load, AM)
	RegisterSignal(AM, COMSIG_PARENT_QDELETING, .proc/RemoveItemFromPlat)

/obj/structure/elevator_platform/proc/RemoveItemFromPlat(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!(AM in lift_load))
		return
	LAZYREMOVE(lift_load, AM)
	UnregisterSignal(AM, COMSIG_PARENT_QDELETING)

/obj/structure/elevator_platform/proc/get_adj_platforms()
	. = list()
	for(var/direction in GLOB.cardinals)
		var/obj/structure/elevator_platform/plat = locate() in get_step(src, direction)
		if(!plat)
			continue
		. += plat

/obj/structure/elevator_platform/proc/travel(going, do_crush)
	// not strictly sure the copy is necessary here tbh; depends on gib behavior i guess?
	var/list/things2move = LAZYCOPY(lift_load)
	var/turf/destination
	if(!isturf(going))
		destination = get_step_multiz(src, going)
	else
		destination = going
	// has to happen before anything is moved, obviously
	// currently unused.
	if(do_crush)
		for(var/mob/living/crushed in destination.contents)
			crushed.visible_message("<span class='danger'>[src] crushes [crushed]!</span>", \
						"<span class='userdanger'>You are crushed by [src]!</span>")

			log_game("[src] ([REF(src)]) crushed [key_name(crushed)] at [AREACOORD(src)], user [usr].")
			message_admins("[src] crushed [ADMIN_LOOKUPFLW(crushed)] at [ADMIN_VERBOSEJMP(crushed)]!")

			crushed.gib(FALSE,FALSE,FALSE)//the nicest kind of gibbing, keeping everything intact.

	// checks in AddItemOnPlat / RemoveItemOnPlat ensure no duplicates are added to lift_load
	forceMove(destination)
	for(var/atom/movable/thing as anything in things2move)
		if(QDELETED(thing)) // if we let nulls stick around they fuck EVERYTHING
			lift_load -= thing
			continue
		thing.forceMove(destination)
