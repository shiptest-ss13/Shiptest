
/obj/item/bodybag
	name = "body bag"
	desc = "A folded bag designed for the storage and transportation of cadavers."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "bodybag_folded"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/plastic = 4000)
	var/unfoldedbag_path = /obj/structure/closet/body_bag

/obj/item/bodybag/attack_self(mob/user)
	if(user in contents)
		return
	deploy_bodybag(user, user.loc)

/obj/item/bodybag/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(proximity)
		if(isopenturf(target))
			deploy_bodybag(user, target)

/obj/item/bodybag/attack_hand(mob/user)
	if(user in contents)
		to_chat(user, span_warning("You cannot use [src] from the inside!"))
		return
	return ..()

/obj/item/bodybag/proc/deploy_bodybag(mob/user, atom/location)
	var/obj/structure/closet/body_bag/R = new unfoldedbag_path(location)
	R.open(user)
	R.add_fingerprint(user)
	R.foldedbag_instance = src
	moveToNullspace()

// Bluespace bodybag

/obj/item/bodybag/bluespace
	name = "bluespace body bag"
	desc = "A folded bluespace body bag designed for the storage and transportation of cadavers."
	icon = 'icons/obj/bodybag.dmi'
	icon_state = "bluebodybag_folded"
	unfoldedbag_path = /obj/structure/closet/body_bag/bluespace
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NO_MAT_REDEMPTION

/obj/item/bodybag/bluespace/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_CANREACH, PROC_REF(CanReachReact))

/obj/item/bodybag/bluespace/examine(mob/user)
	. = ..()
	if(contents.len)
		var/s = contents.len == 1 ? "" : "s"
		. += span_notice("You can make out the shape[s] of [contents.len] object[s] through the fabric.")

/obj/item/bodybag/bluespace/Destroy()
	for(var/atom/movable/A in contents)
		A.forceMove(get_turf(src))
		if(isliving(A))
			to_chat(A, span_notice("You suddenly feel the space around you torn apart! You're free!"))
	return ..()

/obj/item/bodybag/bluespace/proc/CanReachReact(atom/movable/source, list/next)
	return COMPONENT_BLOCK_REACH

/obj/item/bodybag/bluespace/deploy_bodybag(mob/user, atom/location)
	var/obj/structure/closet/body_bag/R = new unfoldedbag_path(location)
	for(var/atom/movable/A in contents)
		A.forceMove(R)
		if(isliving(A))
			to_chat(A, span_notice("You suddenly feel air around you! You're free!"))
	R.open(user)
	R.add_fingerprint(user)
	R.foldedbag_instance = src
	moveToNullspace()

/obj/item/bodybag/bluespace/container_resist_act(mob/living/user)
	if(user.incapacitated())
		to_chat(user, span_warning("You can't get out while you're restrained like this!"))
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	to_chat(user, span_notice("You claw at the fabric of [src], trying to tear it open..."))
	to_chat(loc, span_warning("Someone starts trying to break free of [src]!"))
	if(!do_after(user, 200, target = src))
		to_chat(loc, span_warning("The pressure subsides. It seems that they've stopped resisting..."))
		return
	loc.visible_message(span_warning("[user] suddenly appears in front of [loc]!"), span_userdanger("[user] breaks free of [src]!"))
	qdel(src)
