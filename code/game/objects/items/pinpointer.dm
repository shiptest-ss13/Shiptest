//Pinpointers are used to track atoms from a distance as long as they're on the same z-level. The captain and nuke ops have ones that track the nuclear authentication disk.
/obj/item/pinpointer
	name = "pinpointer"
	desc = "A handheld tracking device that locks onto certain signals."
	icon = 'icons/obj/device.dmi'
	icon_state = "pinpointer"
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	pickup_sound =  'sound/items/handling/device_pickup.ogg'
	drop_sound = 'sound/items/handling/device_drop.ogg'
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron = 500, /datum/material/glass = 250)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/active = FALSE
	var/atom/movable/target //The thing we're searching for
	var/minimum_range = 0 //at what range the pinpointer declares you to be at your destination
	var/alert = FALSE // TRUE to display things more seriously
	var/process_scan = TRUE // some pinpointers change target every time they scan, which means we can't have it change very process but instead when it turns on.
	var/icon_suffix = "" // for special pinpointer icons

/obj/item/pinpointer/Initialize()
	. = ..()
	GLOB.pinpointer_list += src

/obj/item/pinpointer/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	GLOB.pinpointer_list -= src
	target = null
	return ..()

/obj/item/pinpointer/attack_self(mob/living/user)
	if(!process_scan) //since it's not scanning on process, it scans here.
		scan_for_target()
	toggle_on()
	user.visible_message("<span class='notice'>[user] [active ? "" : "de"]activates [user.p_their()] pinpointer.</span>", "<span class='notice'>You [active ? "" : "de"]activate your pinpointer.</span>")

/obj/item/pinpointer/proc/toggle_on()
	active = !active
	playsound(src, 'sound/items/screwdriver2.ogg', 50, TRUE)
	if(active)
		START_PROCESSING(SSfastprocess, src)
	else
		target = null
		STOP_PROCESSING(SSfastprocess, src)
	update_icon()

/obj/item/pinpointer/process()
	if(!active)
		return PROCESS_KILL
	if(process_scan)
		scan_for_target()
	update_icon()

/obj/item/pinpointer/proc/scan_for_target()
	return

/obj/item/pinpointer/update_overlays()
	. = ..()
	if(!active)
		return
	if(!target)
		. += "pinon[alert ? "alert" : ""]null[icon_suffix]"
		return
	var/turf/here = get_turf(src)
	var/turf/there = get_turf(target)
	if(here.virtual_z() != there.virtual_z())
		. += "pinon[alert ? "alert" : ""]null[icon_suffix]"
		return
	. += get_direction_icon(here, there)

///Called by update_icon after sanity. There is a target
/obj/item/pinpointer/proc/get_direction_icon(here, there)
	if(get_dist_euclidian(here,there) <= minimum_range)
		return "pinon[alert ? "alert" : ""]direct[icon_suffix]"
	else
		setDir(get_dir(here, there))
		switch(get_dist(here, there))
			if(1 to 8)
				return "pinon[alert ? "alert" : "close"][icon_suffix]"
			if(9 to 16)
				return "pinon[alert ? "alert" : "medium"][icon_suffix]"
			if(16 to INFINITY)
				return "pinon[alert ? "alert" : "far"][icon_suffix]"

/obj/item/pinpointer/crew // A replacement for the old crew monitoring consoles
	name = "crew pinpointer"
	desc = "A handheld tracking device that points to crew suit sensors."
	icon_state = "pinpointer_crew"
	custom_price = 900
	custom_premium_price = 900
	var/has_owner = FALSE
	var/pinpointer_owner = null
	var/ignore_suit_sensor_level = FALSE /// Do we find people even if their suit sensors are turned off

/obj/item/pinpointer/crew/proc/trackable(mob/living/carbon/human/H)
	var/turf/here = get_turf(src)
	if((H.z == 0 || H.virtual_z() == here.virtual_z()) && istype(H.w_uniform, /obj/item/clothing/under))
		var/obj/item/clothing/under/U = H.w_uniform

		// Suit sensors must be on maximum.
		if(!U.has_sensor || (U.sensor_mode < SENSOR_COORDS && !ignore_suit_sensor_level))
			return FALSE

		var/turf/there = get_turf(H)
		return (H.z != 0 || (there && ((there.virtual_z() == here.virtual_z()))))

	return FALSE

/obj/item/pinpointer/crew/attack_self(mob/living/user)
	if(active)
		toggle_on()
		user.visible_message("<span class='notice'>[user] deactivates [user.p_their()] pinpointer.</span>", "<span class='notice'>You deactivate your pinpointer.</span>")
		return

	if (has_owner && !pinpointer_owner)
		pinpointer_owner = user

	if (pinpointer_owner && pinpointer_owner != user)
		to_chat(user, "<span class='notice'>The pinpointer doesn't respond. It seems to only recognise its owner.</span>")
		return

	var/list/name_counts = list()
	var/list/names = list()

	for(var/i in GLOB.human_list)
		var/mob/living/carbon/human/H = i
		if(!trackable(H))
			continue

		var/crewmember_name = "Unknown"
		if(H.wear_id)
			var/obj/item/card/id/I = H.wear_id.GetID()
			if(I && I.registered_name)
				crewmember_name = I.registered_name

		while(crewmember_name in name_counts)
			name_counts[crewmember_name]++
			crewmember_name = text("[] ([])", crewmember_name, name_counts[crewmember_name])
		names[crewmember_name] = H
		name_counts[crewmember_name] = 1

	if(!names.len)
		user.visible_message("<span class='notice'>[user]'s pinpointer fails to detect a signal.</span>", "<span class='notice'>Your pinpointer fails to detect a signal.</span>")
		return

	var/A = input(user, "Person to track", "Pinpoint") in sortList(names)
	if(!A || QDELETED(src) || !user || !user.is_holding(src) || user.incapacitated())
		return

	target = names[A]
	toggle_on()
	user.visible_message("<span class='notice'>[user] activates [user.p_their()] pinpointer.</span>", "<span class='notice'>You activate your pinpointer.</span>")

/obj/item/pinpointer/crew/scan_for_target()
	if(target)
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			if(!trackable(H))
				target = null
	if(!target) //target can be set to null from above code, or elsewhere
		active = FALSE

/obj/item/pinpointer/crew/prox //Weaker version of crew monitor primarily for EMT
	name = "proximity crew pinpointer"
	desc = "A handheld tracking device that displays its proximity to crew suit sensors."
	icon_state = "pinpointer_crewprox"
	custom_price = 300

/obj/item/pinpointer/crew/prox/get_direction_icon(here, there)
	var/size = ""
	if(here == there)
		size = "small"
	else
		switch(get_dist(here, there))
			if(1 to 4)
				size = "xtrlarge"
			if(5 to 16)
				size = "large"
			//17 through 28 use the normal pinion, "pinondirect"
			if(29 to INFINITY)
				size = "small"
	return "pinondirect[size]"

/obj/item/pinpointer/pair
	name = "pair pinpointer"
	desc = "A handheld tracking device that locks onto its other half of the matching pair."
	var/other_pair

/obj/item/pinpointer/pair/Destroy()
	other_pair = null
	. = ..()

/obj/item/pinpointer/pair/scan_for_target()
	target = other_pair

/obj/item/pinpointer/pair/examine(mob/user)
	. = ..()
	if(!active || !target)
		return
	var/mob/mob_holder = get(target, /mob)
	if(istype(mob_holder))
		. += "Its pair is being held by [mob_holder]."
		return

/obj/item/storage/box/pinpointer_pairs
	name = "pinpointer pair box"

/obj/item/storage/box/pinpointer_pairs/PopulateContents()
	var/obj/item/pinpointer/pair/A = new(src)
	var/obj/item/pinpointer/pair/B = new(src)

	A.other_pair = B
	B.other_pair = A

/obj/item/pinpointer/deepcore
	name = "dual mining scanner"
	desc = "A handheld dowsing utility for locating material deep beneath the surface and on the surface. Alt-Click to change modes."
	icon = 'icons/obj/mining.dmi'
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
	. += "<span class='notice'>It is currently set to [scanmode ? "scan underground" : "scan the surface"].</span>"

/obj/item/pinpointer/deepcore/AltClick(mob/user) //switching modes
	..()
	if(user.canUseTopic(src, BE_CLOSE))
		if(scanning_surface||active) //prevents swithcing modes when active
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
	switch(scanmode)
		if(SCANMODE_DEEPCORE)
			. = ..() //returns pinpointer code if its scanning for deepcore spots

		if(SCANMODE_SURFACE)
			if(!scanning_surface)
				STOP_PROCESSING(SSobj, src)
				return null
			scan_minerals()

/obj/item/pinpointer/deepcore/proc/scan_minerals() //used by the surface mining mode
	if(current_cooldown <= world.time)
		current_cooldown = world.time + cooldown
		var/turf/t = get_turf(src)
		mineral_scan_pulse(t, range)
		playsound(src, 'sound/effects/ping.ogg', 20)

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
