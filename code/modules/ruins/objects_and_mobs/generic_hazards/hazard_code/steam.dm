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
	var/range = 2
	var/smoke_type = /obj/effect/particle_effect/smoke/transparent

	var/random_steam = FALSE
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
