/**
  * # Mob Holder
  *
  * Generic system for picking up mobs.
  *
  * Currently works for head and hands.
  * Relays any container_resist_act() calls made by the mob.
  * As a sanity check, any proc refering to held_mob should qdel(src) if the result is null
  */
/obj/item/clothing/head/mob_holder
	name = "bugged mob"
	desc = "Yell at coderbrush."
	icon = null
	icon_state = ""
	slot_flags = NONE
	moth_edible = FALSE
	w_class = 20 // so that only one can fit in a duffel bag
	/// Mob being contained within the holder
	var/mob/living/held_mob

/obj/item/clothing/head/mob_holder/Initialize(mapload, mob/living/held_target, worn_state, head_icon, lh_icon, rh_icon, worn_slot_flags = NONE)
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
	deposit(held_target)

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
	if(!held_mob)
		qdel(src)
	return held_mob.examine(user)

/**
  * Sets the given mob to the container.
  *
  * Called on Initialize(). Sets the container values to match the mobs.
  * * held_target - Mob to be held
  */
/obj/item/clothing/head/mob_holder/proc/deposit(mob/living/held_target)
	if(!istype(held_target))
		return FALSE
	held_target.setDir(SOUTH)
	held_mob = held_target
	update_visuals(held_target)
	held_target.forceMove(src)
	name = held_target.name
	return TRUE

/**
  * Updates the holder visuals to match the held mob.
  *
  * Deletes the holder if no mob is being held.
  */
/obj/item/clothing/head/mob_holder/proc/update_visuals()
	if(!held_mob)
		qdel(src)
	appearance = held_mob.appearance

/obj/item/clothing/head/mob_holder/dropped()
	..()
	if(!held_mob)
		qdel(src)
	else if(isturf(loc))
		release()

/**
  * Safely ejects the held mob and deletes this instance
  *
  * Also called by Destroy() so the class "should" be safe to qdel without getting the mob stuck.
  * Arguments:
  * * announce - enables messages to chat when TRUE
  */
/obj/item/clothing/head/mob_holder/proc/release(announce=TRUE)
	if(!held_mob)
		qdel(src)
		return
	if(isliving(loc))
		var/mob/living/L = loc
		if(announce)
			to_chat(L, "<span class='warning'>[held_mob] wriggles free!</span>")
		L.dropItemToGround(src)
		return
	held_mob.forceMove(get_turf(held_mob))
	held_mob.reset_perspective()
	held_mob.setDir(SOUTH)
	if(announce)
		held_mob.visible_message("<span class='warning'>[held_mob] uncurls!</span>")
	held_mob = null
	qdel(src)

/obj/item/clothing/head/mob_holder/relaymove(mob/living/user, direction)
	container_resist_act()

/obj/item/clothing/head/mob_holder/container_resist_act()
	if(ismovable(loc)) //If the mob is put into a real container that needs breaking out of
		held_mob.changeNext_move(CLICK_CD_BREAKOUT)
		held_mob.last_special = world.time + CLICK_CD_BREAKOUT
		var/atom/movable/AM = loc
		AM.relay_container_resist_act(held_mob, src)
		return
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
