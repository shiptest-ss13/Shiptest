/obj/structure/headpike
	name = "spooky head on a spear"
	desc = "When you really want to send a message."
	icon = 'icons/obj/structures.dmi'
	icon_state = "headpike"
	density = FALSE
	anchored = TRUE
	var/bonespear = FALSE
	var/obj/item/spear/spear
	var/obj/item/bodypart/head/victim

/obj/structure/headpike/bone //for bone spears
	icon_state = "headpike-bone"
	bonespear = TRUE

/obj/structure/headpike/CheckParts(list/parts_list)
	..()
	victim = locate(/obj/item/bodypart/head) in parts_list
	update_appearance()
	if(bonespear)
		spear = locate(/obj/item/spear/bonespear) in parts_list
	else
		spear = locate(/obj/item/spear) in parts_list

/obj/structure/headpike/Initialize()
	. = ..()
	pixel_x = rand(-8, 8)

/obj/structure/headpike/Destroy()
	QDEL_NULL(victim)
	QDEL_NULL(spear)
	return ..()

/obj/structure/headpike/update_overlays()
	. = ..()
	var/obj/item/bodypart/head/H = locate() in contents
	if(H)
		var/mutable_appearance/MA = new()
		MA.copy_overlays(H)
		MA.pixel_y = 12
		. += H

/obj/structure/headpike/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	to_chat(user, "<span class='notice'>You take down [src].</span>")
	if(victim)
		victim.forceMove(drop_location())
		victim = null
	spear.forceMove(drop_location())
	spear = null
	qdel(src)

/obj/structure/headpike/update_name()
	name = "[victim.real_name] on a [spear]"
	return ..()

/obj/structure/headpike/update_overlays()
	. = ..()
	if(!victim)
		return
	var/mutable_appearance/MA = new()
	MA.copy_overlays(victim)
	MA.pixel_y = 12
	MA.pixel_x = pixel_x
	. += victim
