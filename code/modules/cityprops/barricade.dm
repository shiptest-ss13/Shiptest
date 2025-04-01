//taken from tgmc
/obj/structure/barricade/concrete
	name = "concrete barricade"
	desc = "A short wall made of reinforced concrete. It looks like it can take a lot of punishment."
	icon = 'icons/obj/city/barricades.dmi'
	icon_state = "concrete_0"
	max_integrity = 500
	proj_pass_rate = 20
	hitsound_type = PROJECTILE_HITSOUND_NON_LIVING
	climbable = TRUE
	layer = BELOW_OBJ_LAYER
	var/barricade_type = "concrete"
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 20, "bio" = 50, "rad" = 50, "fire" = 50, "acid" = 10)

/obj/structure/barricade/concrete/Initialize()
	. = ..()
	update_appearance()

/obj/structure/barricade/concrete/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1)
	. = ..()
	if(.) //received damage
		update_appearance()

/obj/structure/barricade/concrete/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/hit_stone.ogg', 50, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/barricade/concrete/update_icon_state()
	. = ..()
	var/damage_state
	var/percentage = (obj_integrity / max_integrity) * 100
	switch(percentage)
		if(-INFINITY to 25)
			damage_state = 3
		if(25 to 50)
			damage_state = 2
		if(50 to 75)
			damage_state = 1
		if(75 to INFINITY)
			damage_state = 0

	icon_state = "[barricade_type]_[damage_state]"

	switch(dir)
		if(SOUTH)
			layer = ABOVE_MOB_LAYER
		else if(NORTH)
			layer = initial(layer) - 0.01
		else
			layer = initial(layer)

/obj/structure/barricade/concrete/setDir(newdir)
	. = ..()
	update_appearance()

/obj/structure/barricade/concrete/update_overlays()
	. = ..()
	cut_overlays()
	var/image/new_overlay = image(icon, src, "[icon_state]_overlay", dir == SOUTH ? BELOW_OBJ_LAYER : ABOVE_MOB_LAYER, dir)
	new_overlay.pixel_y = (dir == SOUTH ? -32 : 32)
	add_overlay(new_overlay)

/obj/structure/barricade/concrete/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_exit),
	)

	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/barricade/concrete/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(!. && istype(mover, /obj/projectile))
		return FALSE
	if(.)
		return TRUE

	if(border_dir == dir)
		return FALSE

	return TRUE

/*
/obj/structure/barricade/concrete/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir & dir)
		return . || mover.throwing || mover.movement_type & (FLYING | FLOATING)
	return TRUE
*/

/obj/structure/barricade/concrete/proc/on_exit(datum/source, atom/movable/exiter, direction)
	SIGNAL_HANDLER

	if(exiter == src)
		return // Let's not block ourselves.

	if(istype(exiter, /obj/projectile))
		return

	if(!(direction & dir))
		return

	if (exiter.movement_type & (PHASING | FLYING | FLOATING))
		return

	if (exiter.move_force >= MOVE_FORCE_EXTREMELY_STRONG)
		return

	if (!density)
		return

	if (exiter.throwing)
		return

	return COMPONENT_ATOM_BLOCK_EXIT
