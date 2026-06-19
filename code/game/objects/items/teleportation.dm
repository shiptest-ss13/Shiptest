#define SOURCE_PORTAL 1
#define DESTINATION_PORTAL 2

/* Teleportation devices.
 * Contains:
 *		Locator
 *		Hand-tele
 */

/*
 * Locator
 */
/obj/item/locator
	name = "bluespace locator"
	desc = "Used to track portable teleportation beacons and targets with embedded tracking implants."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"
	var/temp = null
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_SMALL
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=400)
	var/tracking_range = 20

/obj/item/locator/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BluespaceLocator", name)
		ui.open()

/obj/item/locator/ui_data(mob/user)
	var/list/data = list()

	data["trackingrange"] = tracking_range;

	// Get our current turf location.
	var/turf/sr = get_turf(src)

	if (sr)
		// Check every teleport beacon.
		var/list/tele_beacons = list()
		for(var/obj/item/beacon/W in GLOB.teleportbeacons)

			// Get the tracking beacon's turf location.
			var/turf/tr = get_turf(W)

			// Make sure it's on a turf and that its Z-level matches the tracker's Z-level
			if (tr && tr.virtual_z() == sr.virtual_z())
				// Get the distance between the beacon's turf and our turf
				var/distance = max(abs(tr.x - sr.x), abs(tr.y - sr.y))

				// If the target is too far away, skip over this beacon.
				if(distance > tracking_range)
					continue

				var/beacon_name

				if(W.renamed)
					beacon_name = W.name
				else
					var/area/A = get_area(W)
					beacon_name = A.name

				var/D =  dir2text(get_dir(sr, tr))
				tele_beacons += list(list(name = beacon_name, direction = D, distance = distance))

		data["telebeacons"] = tele_beacons

		var/list/track_implants = list()

		for (var/obj/item/implant/tracking/W in GLOB.tracked_implants)
			if (!W.imp_in || !isliving(W.loc))
				continue
			else
				var/mob/living/M = W.loc
				if (M.stat == DEAD)
					if (M.timeofdeath + W.lifespan_postmortem < world.time)
						continue
			var/turf/tr = get_turf(W)
			var/distance = max(abs(tr.x - sr.x), abs(tr.y - sr.y))

			if(distance > tracking_range)
				continue

			var/D =  dir2text(get_dir(sr, tr))
			track_implants += list(list(name = W.imp_in.name, direction = D, distance = distance))
		data["trackimplants"] = track_implants
	return data

/*
 * Hand-tele
 */
/obj/item/hand_tele
	name = "hand tele"
	desc = "A portable item using blue-space technology."
	icon = 'icons/obj/device.dmi'
	icon_state = "hand_tele"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=10000)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/list/active_portal_pairs
	var/max_portal_pairs = 3
	var/atmos_link_override

/obj/item/hand_tele/Initialize()
	. = ..()
	active_portal_pairs = list()

/obj/item/hand_tele/pre_attack(atom/target, mob/user, params)
	if(try_dispel_portal(target, user))
		return TRUE
	return ..()

/obj/item/hand_tele/proc/try_dispel_portal(atom/target, mob/user)
	if(is_parent_of_portal(target))
		qdel(target)
		to_chat(user, span_notice("You dispel [target] with \the [src]!"))
		return TRUE
	return FALSE

/obj/item/hand_tele/afterattack(atom/target, mob/user)
	try_dispel_portal(target, user)
	. = ..()

/obj/item/hand_tele/attack_self(mob/user)
	var/turf/current_location = get_turf(user)//What turf is the user on?
	var/area/current_area = current_location.loc
	if(!current_location || (current_area.area_flags & NOTELEPORT) || is_away_level(current_location) || !isturf(user.loc))//If turf was not found or they're on z level 2 or >7 which does not currently exist. or if user is not located on a turf
		to_chat(user, span_notice("\The [src] is malfunctioning."))
		return
	var/list/L = list()
	for(var/obj/machinery/computer/teleporter/com in GLOB.machines)
		if(com.target)
			var/area/A = get_area(com.target)
			if(!A || (A.area_flags & NOTELEPORT))
				continue
			if(com.power_station && com.power_station.teleporter_hub && com.power_station.engaged)
				L["[get_area(com.target)] (Active)"] = com.target
			else
				L["[get_area(com.target)] (Inactive)"] = com.target
	var/list/turfs = list()
	var/current_z_level = user.virtual_z()
	for(var/turf/T in urange(10, orange=1))
		if(T.x>world.maxx-8 || T.x<8)
			continue	//putting them at the edge is dumb
		if(T.y>world.maxy-8 || T.y<8)
			continue
		if(T.virtual_z() != current_z_level)
			continue
		var/area/A = T.loc
		if(A.area_flags & NOTELEPORT)
			continue
		turfs += T
	if(turfs.len)
		L["None (Dangerous)"] = pick(turfs)
	var/t1 = input(user, "Please select a teleporter to lock in on.", "Hand Teleporter") as null|anything in L
	if (!t1 || user.get_active_held_item() != src || user.incapacitated())
		return
	if(active_portal_pairs.len >= max_portal_pairs)
		user.show_message(span_notice("\The [src] is recharging!"))
		return
	var/atom/T = L[t1]
	var/area/A = get_area(T)
	if(A.area_flags & NOTELEPORT)
		to_chat(user, span_notice("\The [src] is malfunctioning."))
		return
	current_location = get_turf(user)	//Recheck.
	current_area = current_location.loc
	if(!current_location || (current_area.area_flags & NOTELEPORT) || is_away_level(current_location) || !isturf(user.loc))//If turf was not found or they're on z level 2 or >7 which does not currently exist. or if user is not located on a turf
		to_chat(user, span_notice("\The [src] is malfunctioning."))
		return
	user.show_message(span_notice("Locked In."), MSG_AUDIBLE)
	var/list/obj/effect/portal/created = create_portal_pair(current_location, get_teleport_turf(current_location, get_turf(T), 0, FALSE), 300, 1, null, atmos_link_override)
	if(!(LAZYLEN(created) == 2))
		return
	RegisterSignal(created[1], COMSIG_QDELETING, PROC_REF(on_portal_destroy)) //Gosh darn it kevinz.
	RegisterSignal(created[2], COMSIG_QDELETING, PROC_REF(on_portal_destroy))
	var/obj/effect/portal/c1 = created[1]
	var/obj/effect/portal/c2 = created[2]
	var/turf/check_turf = get_turf(get_step(user, user.dir))
	if(check_turf.CanPass(user, get_dir(check_turf, user)))
		c1.forceMove(check_turf)
	active_portal_pairs[created[1]] = created[2]
	investigate_log("was used by [key_name(user)] at [AREACOORD(user)] to create a portal pair with destinations [AREACOORD(c1)] and [AREACOORD(c2)].", INVESTIGATE_PORTAL)
	add_fingerprint(user)

/obj/item/hand_tele/proc/on_portal_destroy(obj/effect/portal/P)
	SIGNAL_HANDLER

	active_portal_pairs -= P	//If this portal pair is made by us it'll be erased along with the other portal by the portal.

/obj/item/hand_tele/proc/is_parent_of_portal(obj/effect/portal/P)
	if(!istype(P))
		return FALSE
	if(active_portal_pairs[P])
		return SOURCE_PORTAL
	for(var/i in active_portal_pairs)
		if(active_portal_pairs[i] == P)
			return DESTINATION_PORTAL
	return FALSE
