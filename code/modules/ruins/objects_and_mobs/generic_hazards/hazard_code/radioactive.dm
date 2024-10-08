/*
Radioactive hazards for ruins
Was grandfathered and reworked into /hazard types, so they're a little different.
*/
/obj/structure/hazard/radioactive
	name = "nuclear waste barrel"
	desc = "An old container of radioactive biproducts."
	icon_state = "barrel"
	anchored = FALSE
	resistance_flags = null
	max_integrity = 600
	requires_client_nearby = TRUE
	client_range = 5
	random_min = 2 SECONDS
	random_max = 2 SECONDS

	var/rad_power = 100
	var/rad_range = 1 // !Range mod = rad dropoff speed

/obj/structure/hazard/radioactive/attacked()
	Nuke()

/obj/structure/hazard/radioactive/contact()
	Nuke()

/obj/structure/hazard/radioactive/do_random_effect()
	Nuke()

/obj/structure/hazard/radioactive/proc/Nuke(atom/movable/AM)
	if(!COOLDOWN_FINISHED(src, cooldown))
		return

	COOLDOWN_START(src, cooldown, cooldown_time)
	radiation_pulse(src, rad_power, rad_range)
//other barrels moved to radioactive_barrels.dm in hazards folder
