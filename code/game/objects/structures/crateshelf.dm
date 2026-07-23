#define DEFAULT_SHELF_CAPACITY 3 // Default capacity of the shelf
#define DEFAULT_SHELF_MAX_CAPACITY 4
#define DEFAULT_SHELF_USE_DELAY 1 SECONDS // Default interaction delay of the shelf
#define DEFAULT_SHELF_VERTICAL_OFFSET 10 // Vertical pixel offset of shelving-related things. Set to 10 by default due to this leaving more of the crate on-screen to be clicked.

/obj/structure/crate_shelf
	name = "crate shelf"
	desc = "It's a shelf! For storing crates!"
	icon = 'icons/obj/objects.dmi'
	icon_state = "shelf_base"
	density = TRUE
	anchored = TRUE
	max_integrity = 50 // Not hard to break
	buckle_lying = 90 // Pinned mobs lie under the toppled shelf.
	max_buckled_mobs = 1

	var/capacity = DEFAULT_SHELF_CAPACITY
	var/max_capacity = DEFAULT_SHELF_MAX_CAPACITY
	var/use_delay = DEFAULT_SHELF_USE_DELAY
	var/pickup_crates = TRUE
	var/list/shelf_contents
	var/tilted = FALSE
	var/tiltable = TRUE
	var/osha_violation = FALSE // Have the bolts been loosened by some DEVIOUS FIEND?
	var/squish_damage = 20 // Damage dealt to mobs caught beneath a toppling shelf.

/obj/structure/crate_shelf/built
	capacity = 1

/obj/structure/crate_shelf/debug
	capacity = 12

/obj/structure/crate_shelf/Initialize(mapload)
	. = ..()

	if (mapload && pickup_crates)
		. = INITIALIZE_HINT_LATELOAD

	shelf_contents = new/list(capacity) // Initialize our shelf's contents list, this will be used later.
	var/stack_layer // This is used to generate the sprite layering of the shelf pieces.
	var/stack_offset // This is used to generate the vertical offset of the shelf pieces.
	for(var/i in 1 to (capacity - 1))
		if(i >= 3) // If we're at or above three, we'll be on the way to going off the tile we're on. This allows mobs to be below the shelf when this happens.
			stack_layer = ABOVE_MOB_LAYER + (0.02 * i) - 0.01
		else
			stack_layer  = BELOW_OBJ_LAYER + (0.02 * i) - 0.01 // Make each shelf piece render above the last, but below the crate that should be on it.
		stack_offset = DEFAULT_SHELF_VERTICAL_OFFSET * i // Make each shelf piece physically above the last.
		overlays += image(icon = 'icons/obj/objects.dmi', icon_state = "shelf_stack", layer = stack_layer, pixel_y = stack_offset)
	return

/obj/structure/crate_shelf/LateInitialize()
	load_crates(src)
	return ..()

/obj/structure/crate_shelf/Destroy()
	unbuckle_all_mobs(force = TRUE)
	QDEL_LIST(shelf_contents)
	return ..()

/obj/structure/crate_shelf/examine(mob/user)
	. = ..()
	if(tilted)
		. += span_warning("It's been knocked over! You could <b>right it back up</b> with your hands.")
		return
	if(capacity < max_capacity)
		. += span_notice("You could <b>add another shelf</b> with <b> 2 sheets of metal</b>.")
	. += span_notice("There are some <b>bolts</b> holding [src] together.")
	if(osha_violation)
		. += span_warning("Its bolts have been loosened. It looks dangerously unstable.")
	if(shelf_contents.Find(null)) // If there's an empty space in the shelf, let the examiner know.
		. += span_notice("You could <b>drag and drop</b> a crate into [src].")
	if(contents.len) // If there are any crates in the shelf, let the examiner know.
		. += span_notice("You could <b>drag and drop</b> a crate out of [src].")
		. += span_notice("[src] contains:")
		for(var/obj/structure/closet/crate/crate in shelf_contents)
			. += "	[icon2html(crate, user)] [crate]"

/obj/structure/crate_shelf/proc/add_shelf(num)
	if(capacity + num > max_capacity)
		return FALSE
	var/stack_layer // This is used to generate the sprite layering of the shelf pieces.
	var/stack_offset // This is used to generate the vertical offset of the shelf pieces.
	var/prev_capacity = capacity
	capacity += num
	shelf_contents.len = capacity
	for(var/i in prev_capacity to (capacity - 1))
		if(i >= 3) // If we're at or above three, we'll be on the way to going off the tile we're on. This allows mobs to be below the shelf when this happens.
			stack_layer = ABOVE_MOB_LAYER + (0.02 * i) - 0.01
		else
			stack_layer  = BELOW_OBJ_LAYER + (0.02 * i) - 0.01 // Make each shelf piece render above the last, but below the crate that should be on it.
		stack_offset = DEFAULT_SHELF_VERTICAL_OFFSET * i // Make each shelf piece physically above the last.
		overlays += image(icon = 'icons/obj/objects.dmi', icon_state = "shelf_stack", layer = stack_layer, pixel_y = stack_offset)

/obj/structure/crate_shelf/attackby(obj/item/item, mob/living/user, params)
	if (item.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1))
		item.play_tool_sound(src)
		if(do_after(user, 3 SECONDS, src))
			deconstruct(TRUE)
			return TRUE
	if(item.tool_behaviour == TOOL_SCREWDRIVER && !tilted)
		item.play_tool_sound(src)
		osha_violation = !osha_violation
		user.visible_message(
			span_notice("[user] [osha_violation ? "loosens" : "tightens"] the bolts on [src]."),
			span_notice("You [osha_violation ? "loosen" : "tighten"] the bolts on [src]."),
		)
		return TRUE
	if(istype(item, /obj/item/stack/sheet/metal))
		if(capacity < max_capacity)
			var/obj/item/stack/sheet/metal/our_sheet = item
			if(our_sheet.get_amount() >= 2)
				balloon_alert(user, "adding additional shelf to rack")
				if(do_after(user, 3 SECONDS, src))
					add_shelf(1)
					our_sheet.use(2)
					return TRUE
				to_chat(user, span_notice("Adding a shelf to [src] requires more metal."))
				return FALSE
		to_chat(user, span_notice("[src] cannot be built any higher!"))
	return ..()

/obj/structure/crate_shelf/relay_container_resist_act(mob/living/user, obj/structure/closet/crate)
	to_chat(user, span_notice("You begin attempting to knock [crate] out of [src]"))
	if(do_after(user, 30 SECONDS, target = crate))
		if(!user || user.stat != CONSCIOUS || user.loc != crate || crate.loc != src)
			return // If the user is in a strange condition, return early.
		visible_message(span_warning("[crate] falls off of [src]!"),
						span_notice("You manage to knock [crate] free of [src]"),
						span_notice("You hear a thud."))
		crate.forceMove(drop_location()) // Drop the crate onto the shelf,
		step_rand(crate, 1) // Then try to push it somewhere.
		crate.layer = initial(crate.layer) // Reset the crate back to having the default layer, otherwise we might get strange interactions.
		crate.pixel_y = initial(crate.pixel_y) // Reset the crate back to having no offset, otherwise it will be floating.
		shelf_contents[shelf_contents.Find(crate)] = null // Remove the reference to the crate from the list.
		handle_visuals()

/obj/structure/crate_shelf/proc/handle_visuals()
	vis_contents = contents // It really do be that shrimple.
	return

/obj/structure/crate_shelf/proc/load(obj/structure/closet/crate/crate, mob/user)
	if(tilted)
		if(ismob(user))
			balloon_alert(user, "shelf is toppled!")
		return FALSE
	var/next_free = shelf_contents.Find(null) // Find the first empty slot in the shelf.
	if(!next_free) // If we don't find an empty slot, return early.
		if(ismob(user))
			balloon_alert(user, "shelf full!")
		return FALSE
	if(!user || do_after(user, use_delay, target = crate)) // Skip do_after if called with no mob
		if(shelf_contents[next_free] != null)
			return FALSE // Something has been added to the shelf while we were waiting, abort!
		if(crate.opened) // If the crate is open, try to close it.
			if(!crate.close())
				return FALSE // If we fail to close it, don't load it into the shelf.
		shelf_contents[next_free] = crate // Insert a reference to the crate into the free slot.
		crate.forceMove(src) // Insert the crate into the shelf.
		crate.pixel_y = DEFAULT_SHELF_VERTICAL_OFFSET * (next_free - 1) // Adjust the vertical offset of the crate to look like it's on the shelf.
		if(next_free >= 3) // If we're at or above three, we'll be on the way to going off the tile we're on. This allows mobs to be below the crate when this happens.
			crate.layer = ABOVE_MOB_LAYER + 0.02 * (next_free - 1)
		else
			crate.layer = BELOW_OBJ_LAYER + 0.02 * (next_free - 1) // Adjust the layer of the crate to look like it's in the shelf.
		handle_visuals()
		return TRUE
	return FALSE // If the do_after() is interrupted, return FALSE!

/obj/structure/crate_shelf/proc/unload(obj/structure/closet/crate/crate, mob/user, turf/unload_turf)
	if(!unload_turf)
		unload_turf = get_turf(user) // If a turf somehow isn't passed into the proc, put it at the user's feet.
	if(!unload_turf.Enter(crate, no_side_effects = TRUE)) // If moving the crate from the shelf to the desired turf would bump, don't do it! Thanks Kapu1178 for the help here. - Generic DM
		unload_turf.balloon_alert(user, "no room!")
		return FALSE
	if(do_after(user, use_delay, target = crate))
		if(!shelf_contents.Find(crate))
			return FALSE // If something has happened to the crate while we were waiting, abort!
		crate.layer = initial(crate.layer) // Reset the crate back to having the default layer, otherwise we might get strange interactions.
		crate.pixel_y = initial(crate.pixel_y) // Reset the crate back to having no offset, otherwise it will be floating.
		crate.forceMove(unload_turf)
		shelf_contents[shelf_contents.Find(crate)] = null // We do this instead of removing it from the list to preserve the order of the shelf.
		handle_visuals()
		return TRUE
	return FALSE  // If the do_after() is interrupted, return FALSE!

/obj/structure/crate_shelf/deconstruct(disassembled = TRUE)
	var/turf/dump_turf = drop_location()
	for(var/obj/structure/closet/crate/crate in shelf_contents)
		crate.layer = initial(crate.layer) // Reset the crates back to default visual state
		crate.pixel_y = initial(crate.pixel_y)
		crate.forceMove(dump_turf)
		step(crate, pick(GLOB.alldirs)) // Shuffle the crates around as though they've fallen down.
		crate.SpinAnimation(rand(4,7), 1) // Spin the crates around a little as they fall. Randomness is applied so it doesn't look weird.
		switch(pick(1, 1, 1, 1, 2, 2, 3)) // Randomly pick whether to do nothing, open the crate, or break it open.
			if(1) // Believe it or not, this does nothing.
				EMPTY_BLOCK_GUARD
			if(2) // Open the crate!
				if(crate.open()) // Break some open, cause a little chaos.
					crate.visible_message(span_warning("[crate]'s lid falls open!"))
				else // If we somehow fail to open the crate, just break it instead!
					crate.visible_message(span_warning("[crate] falls apart!"))
					crate.deconstruct()
			if(3) // Break that crate!
				crate.visible_message(span_warning("[crate] falls apart!"))
				crate.deconstruct()
		shelf_contents[shelf_contents.Find(crate)] = null
	if(!(flags_1&NODECONSTRUCT_1))
		density = FALSE
		var/obj/item/rack_parts/shelf/new_parts = new(loc)
		if(capacity >= 2)
			var/obj/item/stack/sheet/metal/new_metal = new(loc)
			new_metal.amount = (capacity-1)*2
			transfer_fingerprints_to(new_metal)
		transfer_fingerprints_to(new_parts)
	return ..()

/obj/structure/crate_shelf/proc/load_crates(atom/movable/holder)
	for(var/obj/structure/closet/crate/crate in loc)
		if(!load(crate))
			log_mapping("[src] failed to shelve a crate at [AREACOORD(src)]")
			break

// Tipping mechanic. Bumping, throwing things, or detonating explosives near the shelf may shake it badly enough to topple onto an adjacent tile.
// Dumps crates, scatters loot, and crushes anyone unlucky enough to be standing in its path. Loosened bolts double the danger.
/obj/structure/crate_shelf/Bumped(atom/movable/AM)
	. = ..()
	if(tilted || !tiltable)
		return
	var/bump_power = 0
	if(istype(AM, /obj/projectile))
		bump_power = 1
	else if(istype(AM, /obj/vehicle))
		bump_power = 3
	else if(isitem(AM))
		var/obj/item/bumper = AM
		switch(bumper.w_class)
			if(WEIGHT_CLASS_TINY, WEIGHT_CLASS_SMALL)
				bump_power = 1
			if(WEIGHT_CLASS_NORMAL)
				bump_power = 2
			if(WEIGHT_CLASS_BULKY, WEIGHT_CLASS_HUGE, WEIGHT_CLASS_GIGANTIC)
				bump_power = 3
	else if(isliving(AM))
		var/mob/living/bumper = AM
		bump_power = HAS_TRAIT(bumper, TRAIT_HULK) ? 3 : 1
	if(bump_power)
		wobble(bump_power, AM)

/obj/structure/crate_shelf/ex_act(severity, target)
	if(tilted || !tiltable)
		return ..()
	switch(severity)
		if(EXPLODE_DEVASTATE)
			deconstruct(FALSE)
			return
		if(EXPLODE_HEAVY)
			if(prob(50))
				deconstruct(FALSE)
				return
			wobble(4)
			return
		if(EXPLODE_LIGHT)
			wobble(3)
			return
	return ..()

// Wobble: shake the shelf by `power`. High-power wobbles tip the shelf over in the direction of the wobbler (or a random adjacent tile if there is none).
// Loosened bolts (osha_violation) double the effective power.
//   1: bumped by a mob or hit by something tiny
//   2: hit by a normal-weight item
//   3: hit by a bulky item, vehicle, or hulk
//   4: blast wave
/obj/structure/crate_shelf/proc/wobble(power, atom/movable/wobbler = null)
	if(tilted || !tiltable)
		return
	var/effective_power = power * (osha_violation ? 2 : 1)
	var/wobble_amount = clamp(rand(1, effective_power * 25), 0, 100) / 5
	var/wobble_dir = wobbler ? get_dir(src, wobbler) : pick(GLOB.alldirs)
	var/wobble_x = 0
	var/wobble_y = 0
	switch(wobble_dir)
		if(NORTH)
			wobble_y = -wobble_amount
		if(SOUTH)
			wobble_y = wobble_amount
		if(EAST)
			wobble_x = -wobble_amount
		if(WEST)
			wobble_x = wobble_amount
		if(NORTHEAST)
			wobble_x = -wobble_amount * 0.5
			wobble_y = -wobble_amount * 0.5
		if(NORTHWEST)
			wobble_x = wobble_amount * 0.5
			wobble_y = -wobble_amount * 0.5
		if(SOUTHEAST)
			wobble_x = -wobble_amount * 0.5
			wobble_y = wobble_amount * 0.5
		if(SOUTHWEST)
			wobble_x = wobble_amount * 0.5
			wobble_y = wobble_amount * 0.5
	animate(src, pixel_x = pixel_x + wobble_x, pixel_y = pixel_y + wobble_y, time = 0.2 SECONDS)
	animate(pixel_x = initial(pixel_x), pixel_y = initial(pixel_y), time = 0.2 SECONDS)
	if(wobble_amount > 5)
		tip_over(wobble_dir)

/obj/structure/crate_shelf/proc/tip_over(fall_dir)
	if(tilted)
		return
	if(!fall_dir)
		fall_dir = pick(GLOB.cardinals)
	var/turf/fall_turf = get_step(src, fall_dir)
	if(!fall_turf || fall_turf.density)
		// Try the opposite direction if blocked.
		fall_dir = REVERSE_DIR(fall_dir)
		fall_turf = get_step(src, fall_dir)
		if(!fall_turf || fall_turf.density)
			return // Wedged in - can't fall.

	tilted = TRUE
	visible_message(span_danger("[src] topples over!"))
	playsound(src, 'sound/effects/bang.ogg', 60, TRUE)

	// Spill every crate out of the shelf onto the landing tile.
	for(var/obj/structure/closet/crate/crate as anything in shelf_contents)
		if(!crate)
			continue
		crate.layer = initial(crate.layer)
		crate.pixel_y = initial(crate.pixel_y)
		crate.forceMove(fall_turf)
		step(crate, pick(GLOB.alldirs))
		crate.SpinAnimation(rand(4, 7), 1)
		if(prob(50))
			if(crate.open())
				crate.visible_message(span_warning("[crate]'s lid falls open!"))
			else
				crate.visible_message(span_warning("[crate] falls apart!"))
				crate.deconstruct()
		shelf_contents[shelf_contents.Find(crate)] = null
	handle_visuals()

	// Move the shelf onto the fall tile and swap to the wreck sprite.
	forceMove(fall_turf)
	layer = ABOVE_MOB_LAYER
	overlays.Cut() // The stacked-shelf overlays don't belong on a wrecked shelf.
	icon_state = "shelf_wreck"

	// Crush anyone caught beneath. Buckling pins them lying down until the shelf is righted.
	for(var/mob/living/victim in fall_turf)
		if(victim.buckled)
			continue
		victim.visible_message(
			span_danger("[src] crashes down onto [victim]!"),
			span_userdanger("[src] crashes down onto you, pinning you to the floor!"),
			span_warning("You hear a heavy crash."),
		)
		victim.apply_damage(squish_damage, BRUTE, spread_damage = TRUE)
		victim.Paralyze(4 SECONDS)
		if(victim.stat == CONSCIOUS)
			victim.emote("scream")
		buckle_mob(victim, force = TRUE, check_loc = FALSE)

// Once toppled the shelf is wrecked - the only way to "right" it is to clear
// the debris, which yields salvageable shelf parts (and metal) at the cleaner's
// feet so they can rebuild it.
/obj/structure/crate_shelf/proc/clear_wreckage(mob/user)
	if(!tilted)
		return
	user.visible_message(
		span_notice("[user] clears the wreckage of [src]."),
		span_notice("You clear the wreckage of [src]."),
	)
	unbuckle_all_mobs(force = TRUE)
	var/turf/drop_turf = get_turf(user)
	if(!(flags_1 & NODECONSTRUCT_1))
		var/obj/item/rack_parts/shelf/new_parts = new(drop_turf)
		transfer_fingerprints_to(new_parts)
		if(capacity >= 2)
			var/obj/item/stack/sheet/metal/new_metal = new(drop_turf)
			new_metal.amount = (capacity - 1) * 2
			transfer_fingerprints_to(new_metal)
	qdel(src)

/obj/structure/crate_shelf/attack_hand(mob/living/user, list/modifiers)
	if(tilted)
		to_chat(user, span_notice("You start clearing the wreckage of [src]..."))
		if(do_after(user, 5 SECONDS, target = src))
			clear_wreckage(user)
		return TRUE
	return ..()

// While tilted, victims can't simply stand up; they need someone to lift the shelf off them (or have to resist their way out the hard way).
/obj/structure/crate_shelf/unbuckle_mob(mob/living/buckled_mob, force = FALSE)
	if(tilted && !force)
		return
	return ..()

/obj/item/rack_parts/shelf
	name = "crate shelf parts"
	desc = "Parts of a shelf."
	construction_type = /obj/structure/crate_shelf/built
