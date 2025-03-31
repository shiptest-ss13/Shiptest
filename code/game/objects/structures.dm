/obj/structure
	icon = 'icons/obj/structures.dmi'
	pressure_resistance = 8
	max_integrity = 300
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT
	layer = BELOW_OBJ_LAYER
	flags_ricochet = RICOCHET_HARD
	ricochet_chance_mod = 0.5

	hitsound_type = PROJECTILE_HITSOUND_METAL

	var/climb_time = 2 SECONDS
	var/climbable = FALSE
	var/mob/living/structureclimber
	var/broken = 0 //similar to machinery's stat BROKEN

	///How long it takes to climb this object
	var/climb_delay

/obj/structure/Initialize()
	if (!armor)
		armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	. = ..()
	if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)
		if(smoothing_flags & SMOOTH_CORNERS)
			icon_state = ""
	GLOB.cameranet.updateVisibility(src)

/obj/structure/Destroy()
	GLOB.cameranet.updateVisibility(src)
	if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH_NEIGHBORS(src)
	return ..()

/obj/structure/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(structureclimber && structureclimber != user)
		user.changeNext_move(CLICK_CD_MELEE)
		user.do_attack_animation(src)
		structureclimber.Paralyze(40)
		structureclimber.visible_message("<span class='warning'>[structureclimber] is knocked off [src].</span>", "<span class='warning'>You're knocked off [src]!</span>", "<span class='warning'>You see [structureclimber] get knocked off [src].</span>")

/obj/structure/ui_act(action, params)
	add_fingerprint(usr)
	return ..()

/obj/structure/MouseDrop_T(atom/movable/O, mob/user)
	. = ..()
	if(user == O && isliving(O))
		var/mob/living/L = O
		if(isanimal(L))
			var/mob/living/simple_animal/A = L
			if (!A.dextrous)
				return
		if(L.mobility_flags & MOBILITY_MOVE)
			do_climb(user)
			return
	if(!istype(O, /obj/item) || user.get_active_held_item() != O)
		return
	if(iscyborg(user))
		return
	if(!user.dropItemToGround(O))
		return
	if (O.loc != src.loc)
		step(O, get_dir(O, src))

///Checks to see if a mob can climb onto, or over this object
/obj/structure/proc/can_climb(mob/living/user)
	if(!climbable || !can_interact(user))
		return

	var/turf/destination_turf = loc
	var/turf/user_turf = get_turf(user)
	if(!istype(destination_turf) || !istype(user_turf))
		return
	if(!user.Adjacent(src))
		return

	if((flags_1 & ON_BORDER_1))
		if(user_turf != destination_turf && user_turf != get_step(destination_turf, dir))
			to_chat(user, span_warning("You need to be up against [src] to leap over."))
			return
		if(user_turf == destination_turf)
			destination_turf = get_step(destination_turf, dir) //we're moving from the objects turf to the one its facing

	if(destination_turf.density)
		return

	for(var/obj/object in destination_turf.contents)
		if(isstructure(object))
			var/obj/structure/structure = object
			if(structure.density)
				continue
		if(object.density && (!(object.flags_1 & ON_BORDER_1) || object.dir & get_dir(src,user)))
			to_chat(user, span_warning("There's \a [object.name] in the way."))
			return

	for(var/obj/object in user_turf.contents)
		if(isstructure(object))
			var/obj/structure/structure = object
			if(structure.density)
				continue
		if(object.density && (object.flags_1 & ON_BORDER_1) && object.dir & get_dir(user, src))
			to_chat(user, span_warning("There's \a [object.name] in the way."))
			return

	return destination_turf

/obj/structure/proc/do_climb(mob/living/user)
	if(!can_climb(user))
		return

	user.visible_message(span_warning("[user] starts [flags_1 & ON_BORDER_1 ? "leaping over" : "climbing onto"] \the [src]!"))

	var/adjusted_climb_time = climb_delay
	//aliens are terrifyingly fast
	if(isalien(user))
		adjusted_climb_time *= 0.25
	//PARKOUR!!!
	if(HAS_TRAIT(user, TRAIT_FREERUNNING))
		adjusted_climb_time *= 0.8

	if(!do_after(user, adjusted_climb_time, src))
		return

	var/turf/destination_turf = can_climb(user)
	if(!istype(destination_turf))
		return

	for(var/m in user.buckled_mobs)
		user.unbuckle_mob(m)

	user.forceMove(destination_turf)
	user.visible_message(span_warning("[user] [flags_1 & ON_BORDER_1 ? "leaps over" : "climbs onto"] \the [src]!"))

/obj/structure/examine(mob/user)
	. = ..()
	if(!(resistance_flags & INDESTRUCTIBLE))
		if(resistance_flags & ON_FIRE)
			. += "<span class='warning'>It's on fire!</span>"
		if(broken)
			. += "<span class='notice'>It appears to be broken.</span>"
		var/examine_status = examine_status(user)
		if(examine_status)
			. += examine_status

/obj/structure/proc/examine_status(mob/user) //An overridable proc, mostly for falsewalls.
	var/healthpercent = (obj_integrity/max_integrity) * 100
	switch(healthpercent)
		if(50 to 99)
			return  "It looks slightly damaged."
		if(25 to 50)
			return  "It appears heavily damaged."
		if(0 to 25)
			if(!broken)
				return  "<span class='warning'>It's falling apart!</span>"
