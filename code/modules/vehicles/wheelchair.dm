/obj/vehicle/ridden/wheelchair //ported from Hippiestation (by Jujumatic)
	name = "wheelchair"
	desc = "A chair with big wheels. It looks like you can move in this on your own."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "wheelchair"
	layer = OBJ_LAYER
	max_integrity = 100
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 30)	//Wheelchairs aren't super tough yo
	legs_required = 0	//You'll probably be using this if you don't have legs
	canmove = TRUE
	density = FALSE		//Thought I couldn't fix this one easily, phew
	// Run speed delay is multiplied with this for vehicle move delay.
	var/delay_multiplier = 6.7
	///Determines the typepath of what the object folds into
	var/foldabletype = /obj/item/wheelchair

/obj/vehicle/ridden/wheelchair/Initialize()
	. = ..()
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.vehicle_move_delay = 0
	D.set_vehicle_dir_layer(SOUTH, OBJ_LAYER)
	D.set_vehicle_dir_layer(NORTH, ABOVE_MOB_LAYER)
	D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
	D.set_vehicle_dir_layer(WEST, OBJ_LAYER)

/obj/vehicle/ridden/wheelchair/ComponentInitialize()	//Since it's technically a chair I want it to have chair properties
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE, CALLBACK(src, PROC_REF(can_user_rotate)),CALLBACK(src, PROC_REF(can_be_rotated)),null)

/obj/vehicle/ridden/wheelchair/obj_destruction(damage_flag)
	new /obj/item/stack/rods(drop_location(), 1)
	new /obj/item/stack/sheet/metal(drop_location(), 1)
	..()

/obj/vehicle/ridden/wheelchair/Destroy()
	if(has_buckled_mobs())
		var/mob/living/carbon/H = buckled_mobs[1]
		unbuckle_mob(H)
	return ..()

/obj/vehicle/ridden/wheelchair/driver_move(mob/living/user, direction)
	if(istype(user))
		if(canmove && (user.usable_hands < arms_required))
			to_chat(user, "<span class='warning'>You don't have enough arms to operate the wheels!</span>")
			canmove = FALSE
			addtimer(VARSET_CALLBACK(src, canmove, TRUE), 20)
			return FALSE
		set_move_delay(user)
	return ..()

/obj/vehicle/ridden/wheelchair/proc/set_move_delay(mob/living/user)
	var/datum/component/riding/D = GetComponent(/datum/component/riding)
	//1.5 (movespeed as of this change) multiplied by 6.7 gets ABOUT 10 (rounded), the old constant for the wheelchair that gets divided by how many arms they have
	//if that made no sense this simply makes the wheelchair speed change along with movement speed delay
	D.vehicle_move_delay = round(CONFIG_GET(number/movedelay/run_delay) * delay_multiplier) / clamp(user.usable_hands, 1, 2)

/obj/vehicle/ridden/wheelchair/Moved()
	. = ..()
	cut_overlays()
	playsound(src, 'sound/effects/roll.ogg', 75, TRUE)
	if(has_buckled_mobs())
		handle_rotation_overlayed()


/obj/vehicle/ridden/wheelchair/post_buckle_mob(mob/living/user)
	. = ..()
	handle_rotation_overlayed()

/obj/vehicle/ridden/wheelchair/post_unbuckle_mob()
	. = ..()
	cut_overlays()

/obj/vehicle/ridden/wheelchair/setDir(newdir)
	..()
	handle_rotation(newdir)

/obj/vehicle/ridden/wheelchair/wrench_act(mob/living/user, obj/item/I)	//Attackby should stop it attacking the wheelchair after moving away during decon
	..()
	to_chat(user, "<span class='notice'>You begin to detach the wheels...</span>")
	if(I.use_tool(src, user, 40, volume=50))
		to_chat(user, "<span class='notice'>You detach the wheels and deconstruct the chair.</span>")
		new /obj/item/stack/rods(drop_location(), 6)
		new /obj/item/stack/sheet/metal(drop_location(), 4)
		qdel(src)
	return TRUE

/obj/vehicle/ridden/wheelchair/proc/handle_rotation(direction)
	if(has_buckled_mobs())
		handle_rotation_overlayed()
		for(var/m in buckled_mobs)
			var/mob/living/buckled_mob = m
			buckled_mob.setDir(direction)

/obj/vehicle/ridden/wheelchair/proc/handle_rotation_overlayed()
	cut_overlays()
	var/image/V = image(icon = icon, icon_state = "wheelchair_overlay", layer = FLY_LAYER, dir = src.dir)
	add_overlay(V)



/obj/vehicle/ridden/wheelchair/proc/can_be_rotated(mob/living/user)
	return TRUE

/obj/vehicle/ridden/wheelchair/proc/can_user_rotate(mob/living/user)
	var/mob/living/L = user
	if(istype(L))
		if(user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
			return TRUE
	if(isobserver(user) && CONFIG_GET(flag/ghost_interaction))
		return TRUE
	return FALSE

/obj/item/wheelchair
	name = "wheelchair"
	desc = "A collapsed wheelchair that can be carried around."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "wheelchair_folded"
	base_icon_state = "wheelchair_folded"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	force = 8 //Force is same as a chair
	var/unfolded_type = /obj/vehicle/ridden/wheelchair

/obj/vehicle/ridden/wheelchair/MouseDrop(over_object, src_location, over_location)  //Lets you collapse wheelchair
	. = ..()
	if(over_object != usr || !Adjacent(usr) || !foldabletype || !ishuman(usr) || has_buckled_mobs())
		return FALSE
	usr.visible_message("<span class='notice'>[usr] begins to collapse [src].</span>", "<span class='notice'>You begin to collapse [src].</span>")
	if(!do_after(usr, 3 SECONDS, target = src))
		return FALSE
	usr.visible_message("<span class='notice'>[usr] collapses [src].</span>", "<span class='notice'>You collapse [src].</span>")
	var/obj/vehicle/ridden/wheelchair/wheelchair_folded = new foldabletype(get_turf(src))
	usr.put_in_hands(wheelchair_folded)
	qdel(src)

/obj/item/wheelchair/attack_self(mob/user)  //Deploys wheelchair on in-hand use
	deploy_wheelchair(user, user.loc)

/obj/item/wheelchair/proc/deploy_wheelchair(mob/user, atom/location)
	usr.visible_message("<span class='notice'>[usr] begins to unfold [src].</span>", "<span class='notice'>You begin to unfold [src].</span>")
	if(!do_after(usr, 3 SECONDS, target = src))
		return FALSE
	usr.visible_message("<span class='notice'>[usr] deploys [src].</span>", "<span class='notice'>You deploy [src].</span>")
	var/obj/vehicle/ridden/wheelchair/wheelchair_unfolded = new unfolded_type(location)
	wheelchair_unfolded.add_fingerprint(user)
	qdel(src)
