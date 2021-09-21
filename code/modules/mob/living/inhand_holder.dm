//Generic system for picking up mobs.
//Currently works for head and hands.
/obj/item/clothing/head/mob_holder
	name = "bugged mob"
	desc = "Yell at coderbrush."
	icon = null
	icon_state = ""
	slot_flags = NONE
	moth_edible = FALSE
	w_class = 20 // so that only one can fit in a duffel bag
	var/mob/living/held_mob

/obj/item/clothing/head/mob_holder/Initialize(mapload, mob/living/M, worn_state, head_icon, lh_icon, rh_icon, worn_slot_flags = NONE)
	. = ..()
	if(head_icon)
		mob_overlay_icon = head_icon
	if(worn_state)
		item_state = worn_state
	if(lh_icon)
		lefthand_file = lh_icon
	if(rh_icon)
		righthand_file = rh_icon
	if(worn_slot_flags)
		slot_flags = worn_slot_flags
	deposit(M)

/obj/item/clothing/head/mob_holder/Destroy()
	if(held_mob)
		release()
	return ..()

/obj/item/clothing/head/mob_holder/on_thrown(mob/living/carbon/user, atom/target)
	. = held_mob // so the mob gets thrown
	release()

/obj/item/clothing/head/mob_holder/equipped(mob/user, slot)
	. = ..()
	if(!held_mob)
		qdel(src)
	if(slot != ITEM_SLOT_HANDS)
		update_visuals(held_mob)

/obj/item/clothing/head/mob_holder/examine(mob/user)
	return held_mob.examine(user)

/obj/item/clothing/head/mob_holder/proc/deposit(mob/living/L)
	if(!istype(L))
		return FALSE
	L.setDir(SOUTH)
	held_mob = L
	update_visuals(L)
	L.forceMove(src)
	name = L.name
	return TRUE

/obj/item/clothing/head/mob_holder/proc/update_visuals()
	if(!held_mob)
		qdel(src)
	appearance = held_mob.appearance

/obj/item/clothing/head/mob_holder/dropped()
	..()
	if(held_mob && isturf(loc))
		release()

/obj/item/clothing/head/mob_holder/proc/release()
	if(!held_mob)
		qdel(src)
		return
	if(isliving(loc))
		var/mob/living/L = loc
		to_chat(L, "<span class='warning'>[held_mob] wriggles free!</span>")
		L.dropItemToGround(src)
		return
	held_mob.forceMove(get_turf(held_mob))
	held_mob.reset_perspective()
	held_mob.setDir(SOUTH)
	held_mob.visible_message("<span class='warning'>[held_mob] uncurls!</span>")
	held_mob = null
	qdel(src)

/obj/item/clothing/head/mob_holder/relaymove(mob/living/user, direction)
	release()

/obj/item/clothing/head/mob_holder/container_resist_act()
	release()

/obj/item/clothing/head/mob_holder/drone/deposit(mob/living/L)
	. = ..()
	if(!isdrone(L))
		qdel(src)
	name = "drone (hiding)"
	desc = "This drone is scared and has curled up into a ball!"

/obj/item/clothing/head/mob_holder/drone/update_visuals()
	var/mob/living/simple_animal/drone/D = held_mob
	icon = 'icons/mob/drone.dmi'
	icon_state = "[D.visualAppearance]_hat"
