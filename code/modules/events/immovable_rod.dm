/*
Immovable rod random event.
The rod will spawn at some location outside the station, and travel in a straight line to the opposite side of the station
Everything solid in the way will be ex_act()'d
In my current plan for it, 'solid' will be defined as anything with density == 1

--NEOFite
*/

/datum/round_event_control/immovable_rod
	name = "Immovable Rod"
	typepath = /datum/round_event/immovable_rod
	min_players = 15
	max_occurrences = 5
	var/atom/special_target


/datum/round_event_control/immovable_rod/admin_setup()
	if(!check_rights(R_FUN))
		return

	var/aimed = alert("Aimed at current location?","Sniperod", "Yes", "No")
	if(aimed == "Yes")
		special_target = get_turf(usr)

/datum/round_event/immovable_rod
	announce_when = 5

/datum/round_event/immovable_rod/announce(fake)
	priority_announce("What the fuck was that?!", "General Alert")

/datum/round_event/immovable_rod/start()
	var/datum/round_event_control/immovable_rod/C = control
	var/startside = pick(GLOB.cardinals)
	var/datum/virtual_level/vlevel = pick(SSmapping.virtual_levels_by_trait(ZTRAIT_STATION))
	var/turf/startT = vlevel.get_side_turf(startside)
	var/turf/endT = vlevel.get_side_turf(REVERSE_DIR(startside))
	var/atom/rod = new /obj/effect/immovablerod(startT, endT, C.special_target)
	announce_to_ghosts(rod)

/obj/effect/immovablerod
	name = "immovable rod"
	desc = "What the fuck is that?"
	icon = 'icons/obj/objects.dmi'
	icon_state = "immrod"
	throwforce = 100
	move_force = INFINITY
	move_resist = INFINITY
	pull_force = INFINITY
	density = TRUE
	anchored = TRUE
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	var/mob/living/wizard
	var/z_original = 0
	var/destination
	var/notify = TRUE
	var/atom/special_target

/obj/effect/immovablerod/New(atom/start, atom/end, aimed_at)
	..()
	SSaugury.register_doom(src, 2000)
	z_original = z
	destination = end
	special_target = aimed_at
	SSpoints_of_interest.make_point_of_interest(src)

	var/special_target_valid = FALSE
	if(special_target)
		var/turf/T = get_turf(special_target)
		if(T.z == z_original)
			special_target_valid = TRUE
	if(special_target_valid)
		walk_towards(src, special_target, 1)
	else if(end && end.z==z_original)
		walk_towards(src, destination, 1)

/obj/effect/immovablerod/Topic(href, href_list)
	if(href_list["orbit"])
		var/mob/dead/observer/ghost = usr
		if(istype(ghost))
			ghost.ManualFollow(src)

/obj/effect/immovablerod/Destroy()
	SSpoints_of_interest.remove_point_of_interest(src)
	. = ..()

/obj/effect/immovablerod/Moved()
	if(!loc)
		return ..()
	if((z != z_original) || (loc == destination))
		qdel(src)
	if(special_target && loc == get_turf(special_target))
		complete_trajectory()
	return ..()

/obj/effect/immovablerod/proc/complete_trajectory()
	//We hit what we wanted to hit, time to go
	special_target = null
	destination = get_edge_target_turf(src, dir)
	walk(src,0)
	walk_towards(src, destination, 1)

/obj/effect/immovablerod/ex_act(severity, target)
	return 0

/obj/effect/immovablerod/singularity_act()
	return

/obj/effect/immovablerod/singularity_pull()
	return

/obj/effect/immovablerod/Bump(atom/clong)
	if(prob(10))
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		audible_message(span_danger("You hear a CLANG!"))

	if(clong && prob(25))
		x = clong.x
		y = clong.y

	if(special_target && clong == special_target)
		complete_trajectory()

	if(isturf(clong) || isobj(clong))
		if(clong.density)
			if(isturf(clong))
				SSexplosions.medturf += clong
			if(isobj(clong))
				SSexplosions.medobj += clong

	else if(isliving(clong))
		penetrate(clong)
	else if(istype(clong, type))
		var/obj/effect/immovablerod/other = clong
		visible_message(span_danger("[src] collides with [other]!"))
		var/datum/effect_system/smoke_spread/smoke = new
		smoke.set_up(2, get_turf(src))
		smoke.start()
		qdel(src)
		qdel(other)

/obj/effect/immovablerod/proc/penetrate(mob/living/L)
	L.visible_message(span_danger("[L] is penetrated by an immovable rod!") , span_userdanger("The rod penetrates you!") , span_danger("You hear a CLANG!"))
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.adjustBruteLoss(160)
	if(L && (L.density || prob(10)))
		L.ex_act(EXPLODE_HEAVY)

/obj/effect/immovablerod/attack_hand(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/U = user
		if(U.job in list("Research Director"))
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
			for(var/mob/M in urange(8, src))
				if(!M.stat)
					shake_camera(M, 2, 3)
			if(wizard)
				U.visible_message(span_boldwarning("[src] transforms into [wizard] as [U] suplexes them!"), span_warning("As you grab [src], it suddenly turns into [wizard] as you suplex them!"))
				to_chat(wizard, span_boldwarning("You're suddenly jolted out of rod-form as [U] somehow manages to grab you, slamming you into the ground!"))
				wizard.Stun(60)
				wizard.apply_damage(25, BRUTE)
				qdel(src)
			else
				U.client.give_award(/datum/award/achievement/misc/feat_of_strength, U) //rod-form wizards would probably make this a lot easier to get so keep it to regular rods only
				U.visible_message(span_boldwarning("[U] suplexes [src] into the ground!"), span_warning("You suplex [src] into the ground!"))
				new /obj/structure/festivus/anchored(drop_location())
				new /obj/effect/anomaly/flux(drop_location())
				qdel(src)
