/turf/open/space/transit
	name = "\proper hyperspace"
	icon_state = "black"
	dir = SOUTH
	baseturfs = /turf/open/space/transit
	flags_1 = NOJAUNT_1 //This line goes out to every wizard that ever managed to escape the den. I'm sorry.
	explosion_block = INFINITY

/turf/open/space/transit/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	. = ..()
	underlay_appearance.icon_state = "speedspace_ns_[get_transit_state(asking_turf)]"
	underlay_appearance.transform = turn(matrix(), get_transit_angle(asking_turf))

/turf/open/space/transit/south
	dir = SOUTH

/turf/open/space/transit/north
	dir = NORTH

/turf/open/space/transit/horizontal
	dir = WEST

/turf/open/space/transit/west
	dir = WEST

/turf/open/space/transit/east
	dir = EAST

/turf/open/space/transit/Entered(atom/movable/AM, atom/OldLoc)
	..()
	if(!locate(/obj/structure/lattice) in src)
		throw_atom_into_space(AM)

/atom/proc/throw_atom_into_space(atom/movable/AM)
	set waitfor = FALSE
	if(!AM || istype(AM, /obj/docking_port))
		return
	if(AM.loc != src) 	// Multi-tile objects are "in" multiple locs but its loc is it's true placement.
		return			// Don't move multi tile objects if their origin isnt in transit
	if(iseffect(AM))
		return
	if(isliving(AM))
		var/mob/living/poor_soul = AM			// This may not seem like much, but if you toss someone out
		poor_soul.apply_damage_type(50, BRUTE)	// and they go through like four tiles, they're goners
	qdel(AM)

/turf/open/space/transit/CanBuildHere()
	return SSshuttle.is_in_shuttle_bounds(src)


/turf/open/space/transit/Initialize()
	. = ..()
	update_icon()
	for(var/atom/movable/AM in src)
		throw_atom_into_space(AM)

/turf/open/space/transit/update_icon()
	. = ..()
	transform = turn(matrix(), get_transit_angle(src))

/turf/open/space/transit/update_icon_state()
	icon_state = "speedspace_ns_[get_transit_state(src)]"

/proc/get_transit_state(turf/T)
	var/p = 9
	. = 1
	switch(T.dir)
		if(NORTH)
			. = ((-p*T.x+T.y) % 15) + 1
			if(. < 1)
				. += 15
		if(EAST)
			. = ((T.x+p*T.y) % 15) + 1
		if(WEST)
			. = ((T.x-p*T.y) % 15) + 1
			if(. < 1)
				. += 15
		else
			. = ((p*T.x+T.y) % 15) + 1

/proc/get_transit_angle(turf/T)
	. = 0
	switch(T.dir)
		if(NORTH)
			. = 180
		if(EAST)
			. = 90
		if(WEST)
			. = -90
