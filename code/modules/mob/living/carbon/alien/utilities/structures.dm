/* Alien shit!
 * Contains:
 *		structure/alien
 *		Resin
 *		Weeds
 *		Egg
 */


/obj/structure/alien
	icon = 'icons/mob/alien.dmi'
	max_integrity = 100

/obj/structure/alien/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == "melee")
		switch(damage_type)
			if(BRUTE)
				damage_amount *= 0.25
			if(BURN)
				damage_amount *= 2
	. = ..()

/obj/structure/alien/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/welder.ogg', 100, TRUE)

/*
 * Generic alien stuff, not related to the purple lizards but still alien-like
 */

/obj/structure/alien/gelpod
	name = "gelatinous mound"
	desc = "A mound of jelly-like substance encasing something inside."
	icon = 'icons/obj/fluff.dmi'
	icon_state = "gelmound"

/obj/structure/alien/gelpod/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new/obj/effect/mob_spawn/human/corpse/damaged(get_turf(src))
	qdel(src)

/*
 * Resin
 */
/obj/structure/alien/resin
	name = "resin"
	desc = "Looks like some kind of thick resin."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "resin_wall-0"
	base_icon_state = "resin_wall"
	density = TRUE
	opacity = TRUE
	anchored = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_ALIEN_RESIN)
	canSmoothWith = list(SMOOTH_GROUP_ALIEN_RESIN)
	max_integrity = 200
	var/resintype = null
	CanAtmosPass = ATMOS_PASS_DENSITY


/obj/structure/alien/resin/Initialize(mapload)
	. = ..()
	air_update_turf(TRUE)

/obj/structure/alien/resin/Move()
	var/turf/T = loc
	. = ..()
	move_update_air(T)

/obj/structure/alien/resin/wall
	name = "resin wall"
	desc = "Thick resin solidified into a wall."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "resin_wall-0"
	base_icon_state = "resin_wall"
	resintype = "wall"
	smoothing_groups = list(SMOOTH_GROUP_ALIEN_RESIN, SMOOTH_GROUP_ALIEN_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_ALIEN_WALLS)

/obj/structure/alien/resin/wall/BlockThermalConductivity()
	return 1

/obj/structure/alien/resin/membrane
	name = "resin membrane"
	desc = "Resin just thin enough to let light pass through."
	icon = 'icons/obj/smooth_structures/alien/resin_membrane.dmi'
	icon_state = "resin_membrane-0"
	base_icon_state = "resin_membrane"
	opacity = FALSE
	max_integrity = 160
	resintype = "membrane"
	smoothing_groups = list(SMOOTH_GROUP_ALIEN_RESIN, SMOOTH_GROUP_ALIEN_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_ALIEN_WALLS)

/obj/structure/alien/resin/attack_paw(mob/user)
	return attack_hand(user)

/*
 * Weeds
 */

#define NODERANGE 3

/obj/structure/alien/weeds
	gender = PLURAL
	name = "resin floor"
	desc = "A thick resin surface covers the floor."
	anchored = TRUE
	density = FALSE
	layer = TURF_LAYER
	plane = FLOOR_PLANE
	icon = 'icons/obj/smooth_structures/alien/weeds1.dmi'
	icon_state = "weeds1-0"
	base_icon_state = "weeds1"
	max_integrity = 15
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_ALIEN_RESIN, SMOOTH_GROUP_ALIEN_WEEDS)
	canSmoothWith = list(SMOOTH_GROUP_ALIEN_WEEDS, SMOOTH_GROUP_WALLS)
	///the range of the weeds going to be affected by the node
	var/node_range = NODERANGE
	///the parent node that will determine if we grow or die
	var/obj/structure/alien/weeds/node/parent_node
	///the list of turfs that the weeds will not be able to grow over
	var/static/list/blacklisted_turfs = list(
		/turf/open/space,
		/turf/open/chasm,
		/turf/open/lava,
		/turf/open/water,
		/turf/open/openspace,
	)


/obj/structure/alien/weeds/Initialize()
	//so the sprites line up right in the map editor
	pixel_x = -4
	pixel_y = -4

	. = ..()

	set_base_icon()

/obj/structure/alien/weeds/Destroy()
	if(parent_node)
		UnregisterSignal(parent_node, COMSIG_PARENT_QDELETING)
		parent_node = null
	return ..()

///Randomizes the weeds' starting icon, gets redefined by children for them not to share the behavior.
/obj/structure/alien/weeds/proc/set_base_icon()
	. = base_icon_state
	switch(rand(1,3))
		if(1)
			icon = 'icons/obj/smooth_structures/alien/weeds1.dmi'
			base_icon_state = "weeds1"
		if(2)
			icon = 'icons/obj/smooth_structures/alien/weeds2.dmi'
			base_icon_state = "weeds2"
		if(3)
			icon = 'icons/obj/smooth_structures/alien/weeds3.dmi'
			base_icon_state = "weeds3"
	set_smoothed_icon_state(smoothing_junction)


/**
 * Called when the node is trying to grow/expand
 */
/obj/structure/alien/weeds/proc/try_expand()
	//we cant grow without a parent node
	if(!parent_node)
		return
	//lets make sure we are still on a valid location
	var/turf/src_turf = get_turf(src)
	if(is_type_in_list(src_turf, blacklisted_turfs))
		qdel(src)
		return
	//lets try to grow in a direction
	for(var/turf/check_turf as anything in src_turf.get_atmos_adjacent_turfs())
		//we cannot grow on blacklisted turfs
		if(is_type_in_list(check_turf, blacklisted_turfs))
			continue

		var/obj/structure/alien/weeds/check_weed = locate() in check_turf
		//we cannot grow onto other weeds
		if(check_weed)
			continue
		//spawn a new one in the turf
		check_weed = new(check_turf)
		//set the new one's parent node to our parent node
		check_weed.parent_node = parent_node
		check_weed.RegisterSignal(parent_node, COMSIG_PARENT_QDELETING, PROC_REF(after_parent_destroyed))

/**
 * Called when the parent node is destroyed
 */
/obj/structure/alien/weeds/proc/after_parent_destroyed()
	if(!find_new_parent())
		var/random_time = rand(2 SECONDS, 8 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(do_qdel)), random_time)

/**
 * Called when trying to find a new parent after our previous parent died
 * Will return false if it can't find a new_parent
 * Will return the new parent if it can find one
 */
/obj/structure/alien/weeds/proc/find_new_parent()
	var/previous_node = parent_node
	parent_node = null
	for(var/obj/structure/alien/weeds/node/new_parent in range(node_range, src))
		if(new_parent == previous_node)
			continue

		parent_node = new_parent
		RegisterSignal(parent_node, COMSIG_PARENT_QDELETING, PROC_REF(after_parent_destroyed))
		return parent_node
	return FALSE

/**
 * Called to delete the weed
 */
/obj/structure/alien/weeds/proc/do_qdel()
	qdel(src)

/obj/structure/alien/weeds/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		take_damage(5, BURN, 0, 0)

/obj/structure/alien/weeds/node
	name = "glowing resin"
	desc = "Blue bioluminescence shines from beneath the surface."
	icon = 'icons/obj/smooth_structures/alien/weednode.dmi'
	icon_state = "weednode-0"
	base_icon_state = "weednode"
	light_color = LIGHT_COLOR_BLUE
	light_power = 0.5
	var/lon_range = 4
	///the minimum time it takes for another weed to spread from this one
	var/minimum_growtime = 5 SECONDS
	///the maximum time it takes for another weed to spread from this one
	var/maximum_growtime = 10 SECONDS
	//the cooldown between each growth
	COOLDOWN_DECLARE(growtime)


/obj/structure/alien/weeds/node/Initialize()
	. = ..()
	//give it light
	set_light(lon_range)
	//we are the parent node
	parent_node = src

	//destroy any non-node weeds on turf
	var/obj/structure/alien/weeds/check_weed = locate(/obj/structure/alien/weeds) in loc
	if(check_weed && check_weed != src)
		qdel(check_weed)

	//start the cooldown
	COOLDOWN_START(src, growtime, rand(minimum_growtime, maximum_growtime))

	//start processing
	START_PROCESSING(SSobj, src)

/obj/structure/alien/weeds/node/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/alien/weeds/node/process(seconds_per_tick)
	//we need to have a cooldown, so check and then add
	if(!COOLDOWN_FINISHED(src, growtime))
		return
	COOLDOWN_START(src, growtime, rand(minimum_growtime, maximum_growtime))
	//attempt to grow all weeds in range
	for(var/obj/structure/alien/weeds/growing_weed in range(node_range, src))
		growing_weed.try_expand()


/obj/structure/alien/weeds/node/set_base_icon()
	return //No icon randomization at init. The node's icon is already well defined.


#undef NODERANGE


/*
 * Egg
 */

//for the status var
#define BURST "burst"
#define GROWING "growing"
#define GROWN "grown"
#define GROWTH_TIME 2 MINUTES

/obj/structure/alien/egg
	name = "egg"
	desc = "A large mottled egg."
	var/base_icon = "egg"
	icon_state = "egg_growing"
	density = FALSE
	anchored = TRUE
	max_integrity = 100
	integrity_failure = 0.05
	var/status = GROWING	//can be GROWING, GROWN or BURST; all mutually exclusive
	layer = MOB_LAYER
	var/mob/living/simple_animal/hostile/facehugger/child
	///Proximity monitor associated with this atom, needed for proximity checks.
	var/datum/proximity_monitor/proximity_monitor

/obj/structure/alien/egg/Initialize(mapload)
	. = ..()
	update_appearance()
	if(status == GROWING || status == GROWN)
		child = new(src)
	if(status == GROWING)
		addtimer(CALLBACK(src, PROC_REF(Grow)), GROWTH_TIME)
	proximity_monitor = new(src, status == GROWN ? 1 : 0)
	if(status == BURST)
		atom_integrity = integrity_failure * max_integrity

/obj/structure/alien/egg/update_icon_state()
	switch(status)
		if(GROWING)
			icon_state = "[base_icon]_growing"
		if(GROWN)
			icon_state = "[base_icon]"
		if(BURST)
			icon_state = "[base_icon]_hatched"
	return ..()

/obj/structure/alien/egg/attack_paw(mob/living/user)
	return attack_hand(user)

/obj/structure/alien/egg/attack_alien(mob/living/carbon/alien/user)
	return attack_hand(user)

/obj/structure/alien/egg/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(user.getorgan(/obj/item/organ/alien/plasmavessel))
		switch(status)
			if(BURST)
				to_chat(user, span_notice("You clear the hatched egg."))
				playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
				qdel(src)
				return
			if(GROWING)
				to_chat(user, span_notice("The child is not developed yet."))
				return
			if(GROWN)
				to_chat(user, span_notice("You retrieve the child."))
				Burst(kill=FALSE)
				return
	else
		to_chat(user, span_notice("It feels slimy."))
		user.changeNext_move(CLICK_CD_MELEE)


/obj/structure/alien/egg/proc/Grow()
	status = GROWN
	update_appearance()
	proximity_monitor.set_range(1)

//drops and kills the hugger if any is remaining
/obj/structure/alien/egg/proc/Burst(kill = TRUE)
	if(status == GROWN || status == GROWING)
		status = BURST
		proximity_monitor.set_range(0)
		update_appearance()
		flick("egg_opening", src)
		addtimer(CALLBACK(src, PROC_REF(finish_bursting), kill), 15)

/obj/structure/alien/egg/proc/finish_bursting(kill = TRUE)
	if(child)
		child.forceMove(get_turf(src))
		// TECHNICALLY you could put non-facehuggers in the child var
		if(istype(child))
			if(kill)
				child.death()
			else
				for(var/mob/M in range(1,src))
					if(child.TryCoupling(M))
						break

/obj/structure/alien/egg/atom_break(damage_flag)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(status != BURST)
			Burst(kill=TRUE)
	. = ..()

/obj/structure/alien/egg/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 500)
		take_damage(5, BURN, 0, 0)


/obj/structure/alien/egg/HasProximity(atom/movable/AM)
	if(status != GROWN || !iscarbon(AM))
		return

	var/mob/living/carbon/potential_host = AM
	if(isalien(potential_host) || (potential_host.stat == CONSCIOUS && potential_host.getorgan(/obj/item/organ/body_egg/alien_embryo)))
		return

	Burst(kill=FALSE)

/obj/structure/alien/egg/grown
	status = GROWN
	icon_state = "egg"

/obj/structure/alien/egg/burst
	status = BURST
	icon_state = "egg_hatched"

#undef BURST
#undef GROWING
#undef GROWN
#undef GROWTH_TIME
