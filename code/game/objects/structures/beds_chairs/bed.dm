/* Beds... get your mind out of the gutter, they're for sleeping!
 * Contains:
 * 		Beds
 *		Roller beds
 */

/*
 * Beds
 */
/obj/structure/bed
	name = "bed"
	desc = "This is used to lie in, sleep in or strap on."
	icon_state = "bed"
	icon = 'icons/obj/objects.dmi'
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 90
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 0.35

	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2
	var/bolts = TRUE

	/// Whether the bed changes its buckle_lying direction
	/// (and accordingly the direction in which mobs lie down) based on its current direction.
	var/swap_lying_with_dir = TRUE
	/// If non-null, some items (bedsheets) which can be tucked into beds
	/// will set their layer to this value when they are tucked in, until they are picked up again.
	var/suggested_tuck_layer = null
	/// The amount added to the pixel_x value of a tucked-in item.
	var/tucked_x_shift = 0
	/// The amount added to the pixel_y value of a tucked-in item.
	var/tucked_y_shift = 0

/obj/structure/bed/Initialize(...)
	. = ..()
	if(swap_lying_with_dir)
		buckle_lying = get_buckle_angle_from_dir(dir)

/obj/structure/bed/setDir(newdir)
	. = ..()
	if(swap_lying_with_dir)
		buckle_lying = get_buckle_angle_from_dir(newdir)
		// shuttle rotation etc... ugh.
		if(has_buckled_mobs())
			for(var/mob/living/M as anything in buckled_mobs)
				// this proc already checks to see if the new angle is different from the old one,
				// so this shouldn't cause any duplicate work or unnecessary animations.
				M.set_lying_angle(buckle_lying)

/obj/structure/bed/proc/get_buckle_angle_from_dir(some_dir)
	if(some_dir & (SOUTH|WEST))
		return 90
	else
		return 270

/obj/structure/bed/examine(mob/user)
	. = ..()
	if(bolts)
		. += span_notice("It's held together by a couple of <b>bolts</b>.")

/obj/structure/bed/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
	..()

/obj/structure/bed/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/bed/deconstruct_act(mob/living/user, obj/item/tool)
	if(..())
		return TRUE
	tool.play_tool_sound(src)
	deconstruct(TRUE)
	return TRUE

/obj/structure/bed/wrench_act(mob/living/user, obj/item/tool)
	if(..() || (flags_1 & NODECONSTRUCT_1))
		return TRUE
	tool.play_tool_sound(src)
	deconstruct(TRUE)
	return TRUE

/*
 * Roller beds
 */
/obj/structure/bed/roller
	name = "roller bed"
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "down"
	anchored = FALSE
	resistance_flags = NONE

	// no dir states
	swap_lying_with_dir = FALSE
	var/foldabletype = /obj/item/roller

/obj/structure/bed/roller/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/roller/robo))
		var/obj/item/roller/robo/R = W
		if(R.loaded)
			to_chat(user, span_warning("You already have a roller bed docked!"))
			return

		if(has_buckled_mobs())
			if(buckled_mobs.len > 1)
				unbuckle_all_mobs()
				user.visible_message(span_notice("[user] unbuckles all creatures from [src]."))
			else
				user_unbuckle_mob(buckled_mobs[1],user)
		else
			R.loaded = src
			forceMove(R)
			user.visible_message(span_notice("[user] collects [src]."), span_notice("You collect [src]."))
		return 1
	else
		return ..()

/obj/structure/bed/roller/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr))
		if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE))
			return 0
		if(has_buckled_mobs())
			return 0
		usr.visible_message(span_notice("[usr] collapses \the [src.name]."), span_notice("You collapse \the [src.name]."))
		var/obj/structure/bed/roller/B = new foldabletype(get_turf(src))
		usr.put_in_hands(B)
		qdel(src)

/obj/structure/bed/roller/post_buckle_mob(mob/living/M)
	density = TRUE
	icon_state = "up"
	M.pixel_y = M.base_pixel_y

/obj/structure/bed/roller/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 100, TRUE)


/obj/structure/bed/roller/post_unbuckle_mob(mob/living/M)
	density = FALSE
	icon_state = "down"
	M.pixel_x = M.base_pixel_y + M.get_standard_pixel_x_offset(M.body_position == LYING_DOWN)
	M.pixel_y = M.base_pixel_y + M.get_standard_pixel_y_offset(M.body_position == LYING_DOWN)


/obj/item/roller
	name = "roller bed"
	desc = "A collapsed roller bed that can be carried around."
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "folded"
	w_class = WEIGHT_CLASS_NORMAL // No more excuses, stop getting blood everywhere

/obj/item/roller/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/roller/robo))
		var/obj/item/roller/robo/R = I
		if(R.loaded)
			to_chat(user, span_warning("[R] already has a roller bed loaded!"))
			return
		user.visible_message(span_notice("[user] loads [src]."), span_notice("You load [src] into [R]."))
		R.loaded = new/obj/structure/bed/roller(R)
		qdel(src) //"Load"
		return
	else
		return ..()

/obj/item/roller/attack_self(mob/user)
	deploy_roller(user, user.loc)

/obj/item/roller/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!proximity)
		return
	if(isopenturf(target))
		deploy_roller(user, target)

/obj/item/roller/proc/deploy_roller(mob/user, atom/location)
	var/obj/structure/bed/roller/R = new /obj/structure/bed/roller(location)
	R.add_fingerprint(user)
	qdel(src)

/obj/item/roller/robo //ROLLER ROBO DA!
	name = "roller bed dock"
	desc = "A collapsed roller bed that can be ejected for emergency use. Must be collected or replaced after use."
	var/obj/structure/bed/roller/loaded = null

/obj/item/roller/robo/Initialize()
	. = ..()
	loaded = new(src)

/obj/item/roller/robo/examine(mob/user)
	. = ..()
	. += "The dock is [loaded ? "loaded" : "empty"]."

/obj/item/roller/robo/deploy_roller(mob/user, atom/location)
	if(loaded)
		loaded.forceMove(location)
		user.visible_message(span_notice("[user] deploys [loaded]."), span_notice("You deploy [loaded]."))
		loaded = null
	else
		to_chat(user, span_warning("The dock is empty!"))

/*
 * "Dog" beds
 */
/obj/structure/bed/dogbed
	name = "dog bed"
	icon_state = "dogbed"
	desc = "A comfy-looking dog bed. You can even strap your pet in, in case the gravity turns off."
	anchored = TRUE
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 10

	// no dir states
	swap_lying_with_dir = FALSE
	var/mob/living/owner = null

/obj/structure/bed/dogbed/ian
	desc = "Ian's bed! Looks comfy."
	name = "Ian's bed"

/obj/structure/bed/dogbed/cayenne
	desc = "Seems kind of... fishy."
	name = "Cayenne's bed"

/obj/structure/bed/dogbed/renault
	desc = "Renault's bed! Looks comfy. A foxy person needs a foxy pet."
	name = "Renault's bed"

/obj/structure/bed/dogbed/runtime
	desc = "A comfy-looking cat bed. You can even strap your pet in, in case the gravity turns off."
	name = "Runtime's bed"

/obj/structure/bed/dogbed/proc/update_owner(mob/living/M)
	if(owner)
		UnregisterSignal(owner, COMSIG_QDELETING)
	owner = M
	RegisterSignal(owner, COMSIG_QDELETING, PROC_REF(owner_deleted))
	name = "[M]'s bed"
	desc = "[M]'s bed! Looks comfy."

/obj/structure/bed/dogbed/proc/owner_deleted()
	UnregisterSignal(owner, COMSIG_QDELETING)
	owner = null
	name = initial(name)
	desc = initial(desc)

/obj/structure/bed/dogbed/buckle_mob(mob/living/M, force, check_loc)
	. = ..()
	update_owner(M)

/*
 * Double beds, for luxurious sleeping, i.e. the captain and maybe heads - no quirky refrence here. Move along
 */
/obj/structure/bed/double
	name = "double bed"
	desc = "A luxurious double bed, for those too important for small dreams."
	icon_state = "bed_double"
	buildstackamount = 4
	max_buckled_mobs = 2
	///The mob who buckled to this bed second, to avoid other mobs getting pixel-shifted before they unbuckles.
	var/mob/living/goldilocks

/obj/structure/bed/double/post_buckle_mob(mob/living/M)
	if(buckled_mobs.len > 1 && !goldilocks) //Push the second buckled mob a bit higher from the normal lying position, also, if someone can figure out the same thing for plushes, i'll be really glad to know how to
		M.pixel_y = initial(M.pixel_y) + 6
		goldilocks = M
		RegisterSignal(goldilocks, COMSIG_QDELETING, PROC_REF(goldilocks_deleted))

//Called when the signal is raised, removes the reference
//preventing the hard delete.
/obj/structure/bed/double/proc/goldilocks_deleted(datum/source, force)
	UnregisterSignal(goldilocks, COMSIG_QDELETING)
	goldilocks = null

/obj/structure/bed/double/maint
	name = "double dirty mattress"
	desc = "An old grubby king sized mattress. You really try to not think about what could be the cause of those stains."
	icon_state = "dirty_mattress_double"

/*
 * Bunk beds. Comes with an /obj/effect spawner that lets mappers place them down easily.
 * The base type is the bottom bunk, with the top bunk as a derived type.
 * Like other beds, the pillow may be on the left or right depending on the direction.
 */
/obj/structure/bed/bunk
	name = "bottom bunk"
	desc = "The oft-maligned bottom bunk of a compact bunk bed. Heavy sleepers only."
	icon_state = "bottom_bunk"
	// just below the top bunk's main layer
	suggested_tuck_layer = LYING_MOB_LAYER + 0.005
	/// The amount added to the pixel_y value of mobs lying down, relative to the default shift for that position.
	var/mob_y_shift = -1
	// i think it looks best without shifting the bedsheet down, even though the mob gets shifted down some

// alter their pixel offset when they lie down...
/obj/structure/bed/bunk/post_buckle_mob(mob/living/M)
	// we shift the lying mob a little so that they line up better with the pillow, but the shift direction changes
	// depending on the direction they lie down in, controlled by buckle_lying
	// (which is in turn based on our direction, but we don't need to worry about that directly)
	var/horz_offset
	if(buckle_lying == 90)
		horz_offset = 2
	else
		horz_offset = -2

	M.pixel_x = M.get_standard_pixel_x_offset(M.body_position == LYING_DOWN) + horz_offset
	M.pixel_y = M.get_standard_pixel_y_offset(M.body_position == LYING_DOWN) + mob_y_shift

// ...and reset it when they get off
/obj/structure/bed/bunk/post_unbuckle_mob(mob/living/M)
	M.pixel_x = M.get_standard_pixel_x_offset(M.body_position == LYING_DOWN)
	M.pixel_y = M.get_standard_pixel_y_offset(M.body_position == LYING_DOWN)


/obj/structure/bed/bunk/top
	name = "top bunk"
	desc = "The top bunk of a compact bunk bed. Few other sleeping accommodations can match its luxury."
	icon_state = "top_bunk"

	// higher layer, so that it renders on top of people on the bottom bunk
	layer = LYING_MOB_LAYER + 0.01
	mob_y_shift = 13

	// above the lying mob, but below the ladder
	suggested_tuck_layer = LYING_MOB_LAYER + 0.025
	tucked_y_shift = 14

/obj/structure/bed/bunk/top/Initialize(...)
	. = ..()
	// the ladder needs to render above the mob
	overlays += image(icon = 'icons/obj/objects.dmi', icon_state = "top_bunk_ladder", layer = LYING_MOB_LAYER + 0.03)
	// and the posts need to render below the bottom bunk
	overlays += image(icon = 'icons/obj/objects.dmi', icon_state = "top_bunk_posts", layer = TABLE_LAYER)

/obj/structure/bed/bunk/top/post_buckle_mob(mob/living/M)
	. = ..()
	M.layer = LYING_MOB_LAYER + 0.02

/obj/structure/bed/bunk/top/post_unbuckle_mob(mob/living/M)
	. = ..()
	// honestly not really confident in this, but since standing up takes a do_after
	// (and thus happens afterwards, resetting the layer), it should be fine...
	// i'm more worried about altering layers via + and -, since if you figured out ways
	// of stacking those you could layer yourself under, like, the floor.
	M.layer = LYING_MOB_LAYER


// the spawner
/obj/effect/spawner/bunk_bed
	name = "bunk bed spawner"
	icon_state = "bunk_bed_spawner"

/obj/effect/spawner/bunk_bed/Initialize(...)
	. = ..()
	var/obj/structure/bed/bunk/bottom_bunk = new(loc)
	var/obj/structure/bed/bunk/top/top_bunk = new(loc)

	bottom_bunk.setDir(dir)
	top_bunk.setDir(dir)
