/*
steam and smoke effects! mostly for show

types
/obj/effect/particle_effect/smoke //safe smoke, blocks view
/obj/effect/particle_effect/smoke/bad_smoke //forcedrops items, blocks view. use sparingly
/obj/effect/particle_effect/smoke/hazard_smoke //oxyloss, blocks view, feels most like deadly smoke
/obj/effect/particle_effect/smoke/transparent //doesn't block view, feels most like steam
 */


/obj/structure/hazard/steam
	name = "steam hazard"
	desc = "tell a maptainer if you see this. FWSSSH!"
	icon_state = "hazardg"
	//how far the smoke spreads, effectively the radius.
	var/range = 2
	//type of smoke emited, check effects_smoke.dm for all of them, or the short list at the top of this file.
	var/smoke_type = /obj/effect/particle_effect/smoke/transparent

	//randomly emits smoke between random_min and random_max time
	var/random_steam = FALSE
	//emits smoke when bumped or walked over, can have cooldown_time set.
	var/contact_steam = FALSE

/obj/structure/hazard/steam/Initialize()
	if(contact_steam)
		enter_activated = TRUE
	if(random_steam)
		random_effect = TRUE
	. = ..()

/obj/structure/hazard/steam/proc/steam()
	do_smoke(range, src, smoke_type)

/obj/structure/hazard/steam/do_random_effect()
	steam()

/obj/structure/hazard/steam/contact(target)
	if(contact_steam)
		contact_steam()

/obj/structure/hazard/steam/proc/contact_steam()
	if(!COOLDOWN_FINISHED(src, cooldown))
		return
	COOLDOWN_START(src, cooldown, cooldown_time)
	steam()
