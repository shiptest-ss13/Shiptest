/obj/machinery/hand_press
	name = "\improper pill press"
	desc = "A press operated by hand to produce pills in a variety of forms."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "juicer1"
	pass_flags = PASSTABLE
	layer = BELOW_OBJ_LAYER
	resistance_flags = FIRE_PROOF | ACID_PROOF


	var/obj/item/reagent_containers/beaker = null
	var/obj/item/storage/pill_bottle/bottle = null
	var/min_volume = 5
	var/max_volume = 30
	var/current_volume = 10
	var/list/possible_volumes = list(5,10,15,20,25,30)
	var/press_time = 15
	var/pill_style = 1
	var/pill_name = null

/obj/machinery/hand_press/Initialize()
	. = ..()
	beaker = new /obj/item/reagent_containers/glass/beaker/large(src)

/obj/machinery/hand_press/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!beaker)
		to_chat(user, "<span class='notice'>There's no container in [src]!.</span>")
		return FALSE
	if(beaker.reagents.total_volume == 0)
		to_chat(user, "<span class='warning'>The [beaker] is empty!")
		return FALSE
	if(do_after(user, press_time, target = src))
		var/obj/item/reagent_containers/pill/P
		if(bottle && bottle.contents.len < bottle.GetComponent(/datum/component/storage).max_items)
			P = new/obj/item/reagent_containers/pill(bottle)
		else
			P = new/obj/item/reagent_containers/pill(drop_location())
		P.name = "pill"
		P.icon_state = "pill[pill_style]"
		beaker.reagents.trans_to(P, current_volume, transfered_by = user)
	return TRUE

/obj/machinery/hand_press/attackby(obj/item/I, mob/living/user, params)
	if(user.a_intent == INTENT_HARM)
		return ..()
	if(default_unfasten_wrench(user, I))
		return
	//shamelessly yoinked from reagentgrinder.dm
	else if (istype(I, /obj/item/reagent_containers) && !(I.item_flags & ABSTRACT) && I.is_open_container())
		var/obj/item/reagent_containers/B = I
		. = TRUE //no afterattack
		if(!user.transferItemToLoc(B, src))
			return
		replace_beaker(user, B)
		to_chat(user, "<span class='notice'>You add [B] to [src].</span>")
		update_icon()
		return TRUE //no afterattack
	//another shameless yoink from chem_master.dm
	else if(istype(I, /obj/item/storage/pill_bottle))
		if(bottle)
			to_chat(user, "<span class='warning'>A pill bottle is already loaded into [src]!</span>")
			return
		if(!user.transferItemToLoc(I, src))
			return
		bottle = I
		to_chat(user, "<span class='notice'>You add [I] into the output slot.</span>")
	else if(I.tool_behaviour == TOOL_SCREWDRIVER)
		var/i=0
		for(var/A in possible_volumes)
			i++
			if(A == current_volume)
				if(i<possible_volumes.len)
					current_volume = possible_volumes[i+1]
				else
					current_volume = possible_volumes[1]
				to_chat(user, "<span class='notice'>You adjust the press to produce [current_volume]u pills.</span>")
				return
	return ..()

/obj/machinery/hand_press/AltClick(mob/living/user)
	. = ..()
	if(!can_interact(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	if(beaker)
		replace_beaker(user)
	else if (bottle)
		replace_bottle(user)

/obj/machinery/hand_press/proc/replace_beaker(mob/living/user, obj/item/reagent_containers/new_beaker)
	if(!user || !can_interact(user))
		return FALSE
	if(beaker)
		if(Adjacent(src, user) && !issiliconoradminghost(user))
			user.put_in_hands(beaker)
		else
			beaker.forceMove(get_turf(src))
		beaker = null
	if(new_beaker)
		beaker = new_beaker
	update_icon()
	return TRUE

/obj/machinery/hand_press/proc/replace_bottle(mob/living/user, obj/item/storage/pill_bottle/new_bottle)
	if(!user || !can_interact(user))
		return FALSE
	if(bottle)
		if(Adjacent(src, user) && !issiliconoradminghost(user))
			user.put_in_hands(bottle)
		else
			bottle.forceMove(get_turf(src))
		bottle = null
	if(new_bottle)
		bottle = new_bottle
	update_icon()
	return TRUE
