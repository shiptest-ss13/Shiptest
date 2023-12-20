/obj/structure/flippedtable
	name = "flipped table"
	desc = "A flipped table."
	icon = 'icons/obj/flipped_tables.dmi'
	icon_state = "metal-flipped"
	anchored = TRUE
	density = TRUE
	layer = ABOVE_MOB_LAYER
	opacity = FALSE
	var/table_type = /obj/structure/table

/obj/structure/flippedtable/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = .proc/on_exit,
	)

	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/flippedtable/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	var/attempted_dir = get_dir(loc, target)
	if(table_type == /obj/structure/table/glass) //Glass table, jolly ranchers pass
		if(istype(mover) && (mover.pass_flags & PASSGLASS))
			return TRUE
	if(istype(mover, /obj/projectile))
		var/obj/projectile/proj_obj = mover
		//Lets through bullets shot from behind the cover of the table
		if(proj_obj.trajectory && angle2dir_cardinal(proj_obj.trajectory.angle) == dir)
			return TRUE
		return FALSE
	return attempted_dir != dir

/obj/structure/flippedtable/proc/on_exit(datum/source, atom/movable/exiter, direction)
	SIGNAL_HANDLER

	if(exiter == src)
		return // Let's not block ourselves.

	if(table_type == /obj/structure/table/glass) //Glass table, jolly ranchers pass
		if(istype(exiter) && (exiter.pass_flags & PASSGLASS))
			return
	if(istype(exiter, /obj/projectile))
		return
	if(direction == dir)
		exiter.Bump(src)
		return COMPONENT_ATOM_BLOCK_EXIT
	return

/obj/structure/flippedtable/CtrlShiftClick(mob/user)
	. = ..()
	if(!istype(user) || !user.can_interact_with(src))
		return FALSE
	user.visible_message("<span class='danger'>[user] starts flipping [src]!</span>", "<span class='notice'>You start flipping over the [src]!</span>")
	if(do_after(user, max_integrity/4))
		var/obj/structure/table/table_unflip = new table_type(src.loc)
		table_unflip.obj_integrity = obj_integrity
		user.visible_message("<span class='danger'>[user] flips over the [src]!</span>", "<span class='notice'>You flip over the [src]!</span>")
		playsound(src, 'sound/items/trayhit2.ogg', 100)
		qdel(src)
