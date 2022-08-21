#define FAST_INFLATE_TIME 0.3 SECONDS
/// Time it takes for the inflatable to inflate.
#define FAST_DEFLATE_TIME 1 SECONDS
/// Time it takes for the inflatable to quickly deflate, e.g. by manual usage
#define SLOW_DEFLATE_TIME 5 SECONDS
/// Time it takes for the inflatable to slowly deflate, e.g. by puncturing
#define DEPLOY_DELAY 2 SECONDS
/// The delay before the inflatable deploys it's structural variant
#define WALL_DEFLATED_SCALE_X 0.55
/// Width scale of the wall structure, to match the item
#define WALL_DEFLATED_SCALE_Y 0.4
/// Height scale of the wall structure, to match the item
#define WALL_SPRITE_MARGIN -4
/// How big the margin on all sides of the sprites are, solve for (-)MARGIN/2
/// Example: If the sprite is 40x40, the margin is 8 pixels in both directions (4 on each side), negate it, presto.
// This is primarily a micro-optimization, to avoid having to calculate it for each instance.
// Does it matter? I don't know.
#define SUICIDE_INFLATION_PROBABILITY 100
/// How likely it is to become a balloon animal if suiciding

// Custom broken plastic decal
/obj/effect/decal/cleanable/plastic/inflatables
	name = "rubber shreds"
	color = "#e9d285"

/obj/item/inflatable
	name = "perfectly generic inflatable"
	desc = "You probably shouldn't be seeing this."
	icon = 'icons/obj/item/inflatables.dmi'
	icon_state = "folded"
	w_class = WEIGHT_CLASS_NORMAL
	var/deploy_structure = /obj/structure/inflatable

/obj/item/inflatable/Initialize()
	. = ..()
	src.desc = "[src.desc]\nThere is a warning in big bold letters below the instructions, \"[span_warning("WARNING: RETIRE IMMEDIATELY AFTER PULLING TAB. DO NOT HOLD. STAND BACK UNTIL INFLATED.")]\""

/obj/item/inflatable/attack_self(mob/user, modifiers)
	if(!pre_inflate(user))
		return

	to_chat(user, span_notice("You pull on \the [src]'s expand tab."))

	if(do_after(user, 0.50 SECONDS, src))
		// We put it on the floor, and quickly pulled on the tab
		addtimer(CALLBACK(src, .proc/inflate, user), DEPLOY_DELAY)
	else
		// We just drop it to the ground cause we somehow couldn't pull on the tab quick enough.
		to_chat(user, span_notice("You lost your grip on the tab!"))
		user.dropItemToGround(src)

/obj/item/inflatable/suicide_act(mob/user)
	user.visible_message(
		span_suicide("[user] stuffs \the [src] into [user.p_their()] mouth and is pulling on the tab! It looks like [user.p_theyre()] trying to commit balloon art!")
	)

	if(prob(SUICIDE_INFLATION_PROBABILITY) && iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		carbon_user.inflate_gib()

	src.inflate(user, is_suiciding = TRUE)
	return BRUTELOSS

/obj/item/inflatable/proc/pre_inflate(mob/user)
	if(!deploy_structure)
		return
	if(locate(/obj/structure/inflatable) in get_turf(user))
		to_chat(user, span_warning("There is already an inflatable here!"))
		return

	playsound(loc, 'sound/items/zip.ogg', vol=70, vary=TRUE)
	return TRUE

/obj/item/inflatable/proc/inflate(mob/user, is_suiciding = FALSE)
	var/location = get_turf(src)

	if(user.get_held_index_of_item(src))
		location = user.loc
		if(!is_suiciding)
			user.throw_at(get_edge_target_turf(get_turf(src), pick(GLOB.alldirs)), 1, 2)

	var/obj/structure/inflatable/new_inflatable = new deploy_structure(location)
	new_inflatable.deployer_item = src.type
	transfer_fingerprints_to(new_inflatable)
	new_inflatable.add_fingerprint(user)
	qdel(src)

/obj/item/inflatable/wall
	name = "inflatable wall"
	desc = "A neatly folded package of a rubber-like material, with a re-usable pulltab sticking out from it. Rapidly expands into a cuboid shape on activation."
	deploy_structure = /obj/structure/inflatable

/obj/item/inflatable/door
	name = "inflatable door"
	desc = "A neatly folded package of a rubber-like material, with a re-usable pulltab sticking out from it. Rapidly expands into a simple, airtight door on activation."
	deploy_structure = /obj/structure/inflatable/door
	icon_state = "folded_door"


/// A weak structure that can be deployed by using an item
/// Will deflate after being pierced or on CtrlClick.
/obj/structure/inflatable
	name = "inflatable wall"
	desc = "An inflated membrane. Do not puncture."
	icon = 'icons/obj/item/inflatables.dmi'
	icon_state = "wall"
	density = TRUE
	anchored = TRUE
	max_integrity = 50
	CanAtmosPass = ATMOS_PASS_DENSITY
	// These are made for SPAAACE
	resistance_flags = FLAMMABLE | FREEZE_PROOF
	var/deflating = FALSE
	var/deployer_item = /obj/item/inflatable/wall

/obj/structure/inflatable/Initialize()
	. = ..()
	air_update_turf(TRUE, TRUE)
	playsound(loc, 'sound/effects/smoke.ogg', vol=70, vary=TRUE, frequency=1.5)

/obj/structure/inflatable/deconstruct(disassembled)
	SEND_SIGNAL(src, COMSIG_OBJ_DECONSTRUCT, disassembled)
	deflate(by_user = disassembled)

/obj/structure/inflatable/CtrlClick(mob/living/user, list/modifiers)
	if(deflating)
		return ..()

	. = ..()

	deconstruct(TRUE)

/obj/structure/inflatable/hitby(atom/movable/thrown_thing, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(deflating)
		return ..()

	if(thrown_thing.throwforce >= 20)
		deflate(violent = TRUE)
		return

	if(isitem(thrown_thing))
		var/obj/item/thrown_item = thrown_thing
		if(thrown_item.sharpness > 0 && thrown_item.force >= 8)
			deflate(violent = TRUE)
			return

	. = ..()

/obj/structure/inflatable/bullet_act(obj/projectile/projectile)
	if(deflating)
		return ..()

	. = ..()
	// Make sure the projectile is of damage_type BRUTE or BURN
	// AND that it's damage is above the inflatable's current integrity
	if((projectile.damage_type == BRUTE || projectile.damage_type == BURN) && ((src.obj_integrity - projectile.damage) <= 0))
		deflate(violent = TRUE)
		return

/obj/structure/inflatable/attackby(obj/item/item, mob/living/user, params)
	// We're already deflating, no real point doing anything special
	if(deflating)
		return ..()

	// Yes we are shadowing the original integrity and caching it here
	var/integrity = src.obj_integrity
	var/violently_deflate = FALSE

	// Check if we should pop it immediately
	if(integrity <= (max_integrity * 0.8))
		// We have a relatively sharp item or something quite deadly
		if(item.sharpness > NONE && item.force >= 8)
			violently_deflate = TRUE

		// We have something quite deadly and the inflatable might get popped by it
		if(item.force >= 20 && integrity - item.force <= 0)
			violently_deflate = TRUE

	if(violently_deflate)
		deflate(violent = TRUE)
		return

	return ..()

/// Causes our structure to deflate
/// by_user - Is a user manually deflating it in a controlled manner?
/// violent - Is the deflating caused by a violent action?
/obj/structure/inflatable/proc/deflate(by_user = FALSE, violent = FALSE)
	if(QDELETED(src) || deflating)
		return

	if(violent)
		playsound(loc, 'sound/effects/snap.ogg', vol = 95, vary = TRUE, frequency = 0.6, falloff_distance = 2)
		new /obj/effect/decal/cleanable/plastic/inflatables(get_turf(src))
		qdel(src)
		air_update_turf(TRUE, TRUE)
		return

	var/deflate_time = by_user ? FAST_DEFLATE_TIME : SLOW_DEFLATE_TIME
	var/matrix/matrix = new
	matrix.Scale(WALL_DEFLATED_SCALE_X, WALL_DEFLATED_SCALE_Y)

	deflating = TRUE
	playsound(loc, 'sound/effects/smoke.ogg', vol=70, vary=TRUE)
	animate(src, deflate_time, transform = matrix)
	density = FALSE
	air_update_turf(TRUE, TRUE)
	addtimer(CALLBACK(src, .proc/post_deflate), deflate_time)

/obj/structure/inflatable/proc/post_deflate()
	if(QDELETED(src))
		return
	var/obj/item/inflatable/inflatable_item = new deployer_item(src.loc)
	transfer_fingerprints_to(inflatable_item)
	qdel(src)

/obj/structure/inflatable/door
	name = "inflatable door"
	icon_state = "door_closed"
	deployer_item = /obj/item/inflatable/door
	var/is_open = FALSE
	var/busy = FALSE

/obj/structure/inflatable/door/attack_hand(mob/user)
	toggle(user)

/obj/structure/inflatable/door/attack_robot(mob/user)
	if(user.Adjacent(src))
		toggle(user)

/obj/structure/inflatable/door/proc/toggle(mob/user)
	if(busy)
		return

	add_fingerprint(user)
	if(is_open)
		close()

	else
		open()

	air_update_turf(TRUE, TRUE)

/obj/structure/inflatable/door/proc/open()
	busy = 1
	flick("door_opening",src)
	sleep(5)
	density = 0
	is_open = 1
	update_icon()
	busy = 0

/obj/structure/inflatable/door/proc/close()
	busy = 1
	flick("door_closing",src)
	sleep(5)
	density = 1
	is_open = 0
	update_icon()
	busy = 0

/obj/structure/inflatable/door/update_icon()
	icon_state = "door_[is_open ? "open" : "closed"]"

#undef FAST_DEFLATE_TIME
#undef SLOW_DEFLATE_TIME
#undef DEPLOY_DELAY
#undef WALL_DEFLATED_SCALE_X
#undef WALL_DEFLATED_SCALE_Y
#undef WALL_SPRITE_MARGIN
#undef SUICIDE_INFLATION_PROBABILITY

///INFLATABLES DISPENSER
#define MODE_WALL 0
#define MODE_DOOR 1

/obj/item/inflatable_dispenser
	name = "inflatables dispenser"
	desc = "A hand-held device which allows rapid deployment and removal of inflatable structures."
	icon = 'icons/obj/storage.dmi'
	icon_state = "inf_deployer"
	w_class = WEIGHT_CLASS_NORMAL
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 8

	var/list/stored_walls = list()
	var/list/stored_doors = list()
	var/max_walls = 4
	var/max_doors = 3
	var/list/allowed_types = list(/obj/item/inflatable)
	var/mode = MODE_WALL

/obj/item/inflatable_dispenser/New()
	..()
	for(var/i = 0 to max(max_walls,max_doors))
		if(stored_walls.len < max_walls)
			stored_walls += new /obj/item/inflatable/wall(src)
		if(stored_doors.len < max_doors)
			stored_doors += new /obj/item/inflatable/door(src)

/obj/item/inflatable_dispenser/Destroy()
	stored_walls = null
	stored_doors = null
	..()

/obj/item/inflatable_dispenser/borg
	w_class = WEIGHT_CLASS_HUGE
	max_walls = 10
	max_doors = 5

/obj/item/inflatable_dispenser/examine(mob/user)
	..()
	to_chat(user, "It has [stored_walls.len] wall segment\s and [stored_doors.len] door segment\s stored, and is set to deploy [mode ? "doors" : "walls"].")

/obj/item/inflatable_dispenser/attack_self()
	mode = !mode
	to_chat(usr, "You set \the [src] to deploy [mode ? "doors" : "walls"].")

/obj/item/inflatable_dispenser/attackby(var/obj/item/O, var/mob/user)
	if(O.type in allowed_types)
		pick_up(O, user)
		return
	..()

/obj/item/inflatable_dispenser/afterattack(var/atom/A, var/mob/user)
	..(A, user)
	if(!user)
		return
	if(!user.Adjacent(A))
		return
	if(istype(A, /turf))
		try_deploy(A, user)
	if(istype(A, /obj/item/inflatable) || istype(A, /obj/structure/inflatable))
		pick_up(A, user)

/obj/item/inflatable_dispenser/proc/try_deploy(var/turf/T, var/mob/living/user)
	if(!istype(T))
		return
	if(T.density)
		return

	var/obj/item/inflatable/I
	if(mode == MODE_WALL)
		if(!stored_walls.len)
			to_chat(user, "\The [src] is out of walls!")
			return

		I = stored_walls[1]
		stored_walls -= I

	if(mode == MODE_DOOR)
		if(!stored_doors.len)
			to_chat(user, "\The [src] is out of doors!")
			return

		I = stored_doors[1]
		stored_doors -= I

	I.forceMove(T)
	I.pre_inflate()
	user.visible_message("<span class='danger'>[user] deploy an inflatable [mode ? "door" : "wall"].</span>", \
	"<span class='notice'>You deploy an inflatable [mode ? "door" : "wall"].</span>")

/obj/item/inflatable_dispenser/proc/pick_up(var/obj/A, var/mob/living/user)
	if(istype(A, /obj/structure/inflatable))
		var/obj/structure/inflatable/I = A
		I.deflate(0,5)
		return 1
	if(A.type in allowed_types)
		var/obj/item/inflatable/I = A
		if(istype(I, /obj/item/inflatable/wall))
			if(stored_walls.len >= max_walls)
				to_chat(user, "\The [src] can't hold more walls.")
				return 0
			stored_walls += I
		else if(istype(I, /obj/item/inflatable/door))
			if(stored_doors.len >= max_doors)
				to_chat(usr, "\The [src] can't hold more doors.")
				return 0
			stored_doors += I
		if(istype(I.loc, /obj/item/storage))
			var/found_item = FALSE
			var/items_added = 0
			var/obj/item/storage/S = I.loc
			for(var/obj/item/O in S.contents)
				if(istype(O, /obj/item/inflatable/wall))
					found_item = TRUE
					if(stored_walls.len >= max_walls)
						break
				stored_walls += O
				items_added++

				if(istype(O, /obj/item/inflatable/door))
					found_item = TRUE
					if(stored_doors.len >= max_doors)
						break
				stored_doors += O
				items_added++

			if(!found_item)
				to_chat(user, "<span class = 'warning'>\The [S] contains no inflatables.</span>")
				return 0

			if(!items_added && src.stored_walls == max_walls || src.stored_doors == max_doors)
				to_chat(user, "<span class='warning'>\The [src] is full!</span>")
				return 0

			to_chat(user, "<span class='notice'>You fill \the [src] with inflatables from \the [S]. " + "It has [src.stored_walls.len] wall segment\s and [src.stored_doors.len] door segment\s stored." + "</span>")
/*
		else if(istype(I.loc, /mob))
			var/mob/M = I.loc
			if(!M.drop_item(I,src))
				to_chat(user, "<span class='notice'>You can't let go of \the [I]!</span>")
				stored_doors -= I
				stored_walls -= I
				return 0*/
		//user.delayNextAttack(8)
		visible_message("\The [user] picks up \the [A] with \the [src]!")
		A.forceMove(src)
		return 1

#undef MODE_WALL
#undef MODE_DOOR
