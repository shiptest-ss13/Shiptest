/obj/structure/flippedtable
	name = "flipped table"
	desc = "A flipped table."
	icon = 'icons/obj/flipped_tables.dmi'
	icon_state = "table"
	anchored = TRUE
	density = TRUE
	layer = ABOVE_MOB_LAYER
	opacity = FALSE
	pass_flags_self = LETPASSTHROW
	var/table_type = /obj/structure/table

/obj/structure/flippedtable/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_exit),
	)

	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/flippedtable/examine(mob/user)
	. = ..()
	. += span_notice("You could right the [name] by control shift-clicking it.")

/obj/structure/flippedtable/proc/check_dir()
	if(dir == NORTHEAST || dir == SOUTHEAST)
		return EAST
	if(dir == NORTHWEST || dir == SOUTHWEST)
		return WEST
	return dir

/obj/structure/flippedtable/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	var/table_dir = check_dir()
	var/attempted_dir = get_dir(loc, mover)
	if(table_type == /obj/structure/table/glass) //Glass table, lasers can pass
		if(istype(mover) && (mover.pass_flags & PASSGLASS))
			return TRUE
	if(istype(mover, /obj/projectile))
		var/obj/projectile/proj_obj = mover
		//Lets through bullets shot from behind the cover of the table
		if(proj_obj.trajectory && angle2dir_cardinal(proj_obj.trajectory.angle) == dir)
			return TRUE
		return FALSE
	return attempted_dir != table_dir

/obj/structure/flippedtable/proc/on_exit(datum/source, atom/movable/exiter, direction)
	SIGNAL_HANDLER
	var/table_dir = check_dir()
	if(exiter == src)
		return // Let's not block ourselves.

	if(table_type == /obj/structure/table/glass) //Glass table, lasers pass
		if(istype(exiter) && (exiter.pass_flags & PASSGLASS))
			return
	if(istype(exiter, /obj/projectile))
		return
	if(istype(exiter, /obj/item))
		return
	if(direction == table_dir)
		exiter.Bump(src)
		return COMPONENT_ATOM_BLOCK_EXIT
	return

/obj/structure/flippedtable/CtrlShiftClick(mob/user)
	. = ..()
	if(!istype(user) || !user.can_interact_with(src))
		return FALSE
	user.visible_message(span_danger("[user] starts flipping [src]!"), span_notice("You start flipping over the [src]!"))
	if(do_after(user, max_integrity/4))
		var/obj/structure/table/table_unflip = new table_type(src.loc)
		table_unflip.obj_integrity = obj_integrity
		user.visible_message(span_danger("[user] flips over the [src]!"), span_notice("You flip over the [src]!"))
		playsound(src, 'sound/items/trayhit2.ogg', 100)
		qdel(src)
