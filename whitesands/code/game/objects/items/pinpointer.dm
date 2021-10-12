#define SCANMODE_SURFACE 0
#define SCANMODE_DEEPCORE 1

/obj/item/pinpointer/deepcore
	name = "dual mining scanner"
	desc = "A handheld dowsing utility for locating material deep beneath the surface and on the surface. Alt-Click to change modes."
	icon = 'whitesands/icons/obj/mining.dmi'
	icon_state = "mining"
	custom_price = 300
	custom_premium_price = 300
	icon_suffix = "_mining"
	var/scanning_surface = FALSE
	var/cooldown = 50
	var/current_cooldown = 0
	var/range = 4
	var/scanmode = SCANMODE_SURFACE

/obj/item/pinpointer/deepcore/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It is currently set to [scanmode ? "scan underground " : "scan the surface"].</span>"

/obj/item/pinpointer/deepcore/AltClick(mob/user) //switching modes
	..()
	if(user.canUseTopic(src, BE_CLOSE))
		if(scanning_surface||active)
			to_chat(user, "<span class='warning'>You have to turn the [src] off first before switching modes!</span>")
		else
			scanmode = !scanmode
			to_chat(user, "<span class='notice'>You switch the [src] to [scanmode ? "scan underground " : "scan the surface"].</span>")

/obj/item/pinpointer/deepcore/attack_self(mob/living/user)
	switch(scanmode)
		if(SCANMODE_DEEPCORE)
			if(active)
				toggle_on()
				user.visible_message("<span class='notice'>[user] deactivates [user.p_their()] scanner.</span>", "<span class='notice'>You deactivate your scanner.</span>")
				return

			var/vein = LocateVein(user)
			if(!vein)
				user.visible_message("<span class='notice'>[user]'s scanner fails to detect any material.</span>", "<span class='notice'>Your scanner fails to detect any material.</span>")
				return

			target = vein
			toggle_on()
			user.visible_message("<span class='notice'>[user] activates [user.p_their()] scanner.</span>", "<span class='notice'>You activate your scanner.</span>")
			update_icon()

		if(SCANMODE_SURFACE)
			scanning_surface = !scanning_surface
			update_icon()
			if(scanning_surface)
				START_PROCESSING(SSobj, src)
				user.visible_message("<span class='notice'>[user] activates [user.p_their()] scanner.</span>", "<span class='notice'>You activate your scanner.</span>")
			else
				STOP_PROCESSING(SSobj, src)
				user.visible_message("<span class='notice'>[user] deactivates [user.p_their()] scanner.</span>", "<span class='notice'>You deactivate your scanner.</span>")
			playsound(src, 'sound/items/screwdriver2.ogg', 50, TRUE)


/obj/item/pinpointer/deepcore/process()
	. = ..()
	if(!scanning_surface)
		STOP_PROCESSING(SSobj, src)
		return null
	scan_minerals()

/obj/item/pinpointer/deepcore/proc/scan_minerals()
	if(current_cooldown <= world.time)
		current_cooldown = world.time + cooldown
		var/turf/t = get_turf(src)
		mineral_scan_pulse(t, range)

/obj/item/pinpointer/deepcore/update_overlays()
	. = ..()
	var/mutable_appearance/scan_mode_overlay
	switch(scanmode)
		if(SCANMODE_SURFACE)
			if(scanning_surface)
				scan_mode_overlay = mutable_appearance(icon, "on_overlay")
		if(SCANMODE_DEEPCORE)
			if(active)
				scan_mode_overlay = mutable_appearance(icon, "pinpointing_overlay")
		else
			scan_mode_overlay = mutable_appearance(icon, "null")
	. += scan_mode_overlay

/obj/item/pinpointer/deepcore/proc/LocateVein(mob/living/user)
	var/turf/here = get_turf(src)
	var/located_dist
	var/obj/effect/landmark/located_vein
	for(var/obj/effect/landmark/I in GLOB.ore_vein_landmarks)
		if(located_vein)
			var/new_dist = get_dist(here, get_turf(I))
			if(new_dist < located_dist)
				located_dist = new_dist
				located_vein = I
		else
			located_dist = get_dist(here, get_turf(I))
			located_vein = I
	return located_vein

/obj/item/pinpointer/deepcore/advanced
	name = "advanced dual mining scanner"
	desc = "A sophisticated dowsing utility for locating specific materials at any depth and has extendended range for scanning surface materials. Alt-Click to change modes"
	icon_state = "miningadv"
	custom_price = 600
	custom_premium_price = 600
	cooldown = 35
	range = 7

/obj/item/pinpointer/deepcore/advanced/LocateVein(mob/living/user)
	//Sorts vein artifacts by ore type
	var/viens_by_type = list()
	for(var/obj/effect/landmark/ore_vein/I in GLOB.ore_vein_landmarks)
		if(islist(viens_by_type[I.resource]))
			var/list/L = viens_by_type[I.resource]
			L += I
		else
			viens_by_type[I.resource] = list(I)
	var/A = input(user, "Type to locate", "DCM") in sortList(viens_by_type)
	if(!A || QDELETED(src) || !user || !user.is_holding(src) || user.incapacitated())
		return
	//Searches for nearest ore vein as usual
	var/turf/here = get_turf(src)
	var/located_dist
	var/obj/effect/landmark/located_vein
	for(var/obj/effect/landmark/I in viens_by_type[A])
		if(located_vein)
			var/new_dist = get_dist(here, get_turf(I))
			if(new_dist < located_dist)
				located_dist = new_dist
				located_vein = I
		else
			located_dist = get_dist(here, get_turf(I))
			located_vein = I
	return located_vein
