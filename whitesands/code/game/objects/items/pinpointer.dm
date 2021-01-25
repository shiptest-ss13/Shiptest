/obj/item/pinpointer/deepcore
	name = "deep core pinpointer"
	desc = "A handheld dowsing utility for locating material deep beneath the surface."
	icon = 'whitesands/icons/obj/mining.dmi'
	icon_state = "miningpinpointing"
	custom_price = 300
	custom_premium_price = 300
	icon_suffix = "_mining"

/obj/item/pinpointer/deepcore/attack_self(mob/living/user)
	if(active)
		toggle_on()
		user.visible_message("<span class='notice'>[user] deactivates [user.p_their()] pinpointer.</span>", "<span class='notice'>You deactivate your pinpointer.</span>")
		return

	var/vein = LocateVein(user)
	if(!vein)
		user.visible_message("<span class='notice'>[user]'s pinpointer fails to detect any material.</span>", "<span class='notice'>Your pinpointer fails to detect any material.</span>")
		return

	target = vein
	toggle_on()
	user.visible_message("<span class='notice'>[user] activates [user.p_their()] pinpointer.</span>", "<span class='notice'>You activate your pinpointer.</span>")

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
	name = "advanced deep core pinpointer"
	desc = "A sophisticated dowsing utility for locating specific materials at any depth."
	icon_state = "miningadvpinpointing"
	custom_price = 600
	custom_premium_price = 600

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
