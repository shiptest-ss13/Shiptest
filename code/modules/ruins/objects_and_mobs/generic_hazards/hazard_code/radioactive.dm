/*
Radioactive hazards for ruins
Was grandfathered and reworked into /hazard types, so they're a little different.
*/
/obj/structure/hazard/radioactive
	name = "nuclear waste barrel"
	desc = "An old container of radioactive biproducts."
	icon_state = "barrel"
	anchored = FALSE
	cooldown = 2 SECONDS
	resistance_flags = null
	var/rad_power = 100
	var/rad_range = 1 // !Range mod = rad dropoff speed

/obj/structure/hazard/radioactive/Initialize()
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/hazard/radioactive/process()
	for(var/mob/living/L in range(5, src))
		if(L.client)
			Nuke()
			break
	..()

/obj/structure/hazard/radioactive/attacked()
	Nuke()

/obj/structure/hazard/radioactive/contact()
	Nuke()

/obj/structure/hazard/radioactive/proc/Nuke(atom/movable/AM)
	if(!COOLDOWN_FINISHED(src, cooldown))
		return

	COOLDOWN_START(src, cooldown, cooldown_time)
	radiation_pulse(src, rad_power, rad_range)
//other barrels moved to radioactive_barrels.dm in hazards folder
