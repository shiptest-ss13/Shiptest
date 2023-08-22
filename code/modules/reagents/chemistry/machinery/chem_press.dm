/obj/machinery/chem_press
	name = "pill press"
	desc = "A press operated by hand to produce pills in a variety of forms."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "press"
	pass_flags = PASSTABLE
	use_power = FALSE
	layer = BELOW_OBJ_LAYER
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/obj/item/reagent_containers/beaker = null
	var/obj/item/storage/pill_bottle/bottle = null
	var/image/beaker_overlay
	var/image/bottle_overlay
	var/current_volume = 10
	var/list/possible_volumes = list(5,10,15,20,25,30) // Usually the max would be 50, but ghetto should be worse.
	var/press_time = 15
	var/pill_style = 9 // White pills
	var/list/possible_styles = list(7,8,9,10,11,12) // These values only encompass the 'tablet' shaped pills.
	var/list/style_colors = list("7" = "yellow", // This list is exclusively used for the text description.
								"8" = "blue",
								"9" = "white",
								"10" = "violet",
								"11" = "green",
								"12" = "red")

/obj/machinery/chem_press/Initialize()
	. = ..()
	beaker = new /obj/item/reagent_containers/glass/beaker/large(src)
	beaker_overlay = image(icon = 'icons/obj/chemical.dmi', icon_state = "press_beaker")
	bottle_overlay = image(icon = 'icons/obj/chemical.dmi', icon_state = "press_bottle")

/obj/machinery/chem_press/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There's a <b>small screw</b> that can <b>help</b> to adjust the pill size.</span>"
	. += "<span class='notice'>There's a small dial you could <b>push</b> with a <b>screwdriver</b> to adjust the pill color.</span>"
	if(!bottle)
		. += "<span class='notice'>The <b>pill bottle</b> slot is empty.</span>"
	if(!beaker)
		. += "<span class='notice'>The <b>beaker</b> slot is empty.</span>"

/obj/machinery/chem_press/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!beaker)
		balloon_alert(user, "no container!")
		return FALSE
	if(!beaker.reagents.total_volume)
		balloon_alert(user, "[beaker] is empty!")
		return FALSE
	if(do_after(user, press_time, target = src))
		var/obj/item/reagent_containers/pill/pill
		// Check if there is a bottle that isn't full, then place a pill in the bottle. Otherwise, drop it on my tile.
		if(bottle && bottle.contents.len < bottle.GetComponent(/datum/component/storage).max_items)
			pill = new/obj/item/reagent_containers/pill(bottle)
		else
			pill = new/obj/item/reagent_containers/pill(drop_location())
		pill.name = "pill"
		pill.icon_state = "pill[pill_style]"
		beaker.reagents.trans_to(pill, current_volume, transfered_by = user)
		balloon_alert(user, "finished pressing")
	return TRUE

/obj/machinery/chem_press/attackby(obj/item/item, mob/living/user, params)
	if(user.a_intent == INTENT_HARM) // Hit the machine if we're on harm intent.
		return ..()
	if(default_unfasten_wrench(user, item))
		return
	else if (istype(item, /obj/item/reagent_containers) && !(item.item_flags & ABSTRACT) && item.is_open_container())
		. = TRUE //no afterattack
		if(!user.transferItemToLoc(item, src))
			return
		handle_container(user, item)
		balloon_alert(user, "added [item] to input")
		return TRUE //no afterattack
	else if(istype(item, /obj/item/storage/pill_bottle))
		if(!user.transferItemToLoc(item, src))
			return
		handle_container(user, item)
		balloon_alert(user, "added [item] to output")
		return TRUE
	else if(item.tool_behaviour == TOOL_SCREWDRIVER)
		if(user.a_intent == INTENT_HELP)
			var/i=0
			for(var/A in possible_volumes)
				i++
				if(A == current_volume)
					if(i<possible_volumes.len)
						current_volume = possible_volumes[i+1]
					else
						current_volume = possible_volumes[1]
					balloon_alert(user, "making [current_volume]u pills")
					return
		if(user.a_intent == INTENT_DISARM)
			var/i=0
			for(var/A in possible_styles)
				i++
				if(A == pill_style)
					if(i<possible_styles.len)
						pill_style = possible_styles[i+1]
					else
						pill_style = possible_styles[1]
					balloon_alert(user, "making [style_colors["[pill_style]"]] pills")
					return
	return ..()

/obj/machinery/chem_press/AltClick(mob/living/user)
	if(!can_interact(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	if(beaker || bottle) // If there's a container in the machine, eject it.
		handle_container(user)
		return
	else
		return ..() // Having ..() run only if all else fails prevents AltClick from showing the turf's contents when not wanted.

/*
This proc attempts to swap a container in the machine
or, if there is no container to swap with, eject the existing
container into the user's hands.
*/
/obj/machinery/chem_press/proc/handle_container(mob/living/user, obj/item/new_container)
	if(!user || !can_interact(user))
		return FALSE
	if(beaker)
		// If the container to handle is a beaker, try to swap it with the existing beaker.
		if(istype(new_container, /obj/item/reagent_containers) || !new_container)
			if(Adjacent(src, user) && !issiliconoradminghost(user))
				user.put_in_hands(beaker)
			else
				beaker.forceMove(get_turf(src))
			beaker = null
			if(!new_container)
				update_appearance()
				return TRUE
	if(istype(new_container, /obj/item/reagent_containers))
		beaker = new_container
	if(bottle)
		// If the container to handle is a bottle, try to swap it with the existing bottle.
		if(istype(new_container, /obj/item/storage/pill_bottle) || !new_container)
			if(Adjacent(src, user) && !issiliconoradminghost(user))
				user.put_in_hands(bottle)
			else
				bottle.forceMove(get_turf(src))
			bottle = null
			if(!new_container)
				update_appearance()
				return TRUE
	if(istype(new_container, /obj/item/storage/pill_bottle))
		bottle = new_container
	update_appearance()
	return TRUE

/obj/machinery/chem_press/update_overlays()
	. = ..()
	if(beaker)
		. += beaker_overlay
	if(bottle)
		. += bottle_overlay
