/* Radioactive hazards for ruins */

/obj/structure/radioactive
	name = "nuclear waste barrel"
	desc = "An old container of radioactive biproducts."
	icon = 'icons/obj/hazard.dmi'
	icon_state = "barrel"
	density = TRUE
	var/rad_power = 100
	var/rad_range = 1 // !Range mod = rad dropoff speed
	COOLDOWN_DECLARE(pulse_cooldown)
	var/rad_delay = 2 SECONDS

/obj/structure/radioactive/Initialize()
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/radioactive/process()
	for(var/mob/living/L in range(5, src))
		if(L.client)
			Nuke()
			break
	..()

/obj/structure/radioactive/bullet_act(obj/projectile/P)
	Nuke()
	. = ..()

/obj/structure/radioactive/attack_tk(mob/user)
	Nuke()

/obj/structure/radioactive/attack_paw(mob/user)
	Nuke()

/obj/structure/radioactive/attack_alien(mob/living/carbon/alien/humanoid/user)
	Nuke()

/obj/structure/radioactive/attack_animal(mob/living/simple_animal/M)
	Nuke()

/obj/structure/radioactive/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	Nuke()

/obj/structure/radioactive/Bumped(atom/movable/AM)
	if(!iseffect(AM))
		Nuke()

/obj/structure/radioactive/proc/Nuke(atom/movable/AM)
	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, rad_delay)
	radiation_pulse(src, rad_power, rad_range)

/obj/structure/radioactive/waste
	name = "leaking waste barrel"
	desc = "It wasn't uncommon for early vessels to simply dump their waste like this out the airlock. However this proved to be a terrible long-term solution."
	icon_state = "barrel_tipped"
	anchored = TRUE
	rad_power = 150
	rad_range = 0.8
	rad_delay = 1 SECONDS

/obj/structure/radioactive/stack
	name = "stack of nuclear waste"
	desc = "Discarded nuclar waste. If enough of this builds up around a planet, radioactive toxins can poison the whole atmosphere."
	icon_state = "barrel_3"
	anchored = TRUE
	rad_power = 300
	rad_delay = 1 SECONDS

/obj/structure/radioactive/supermatter
	name = "decayed supermatter crystal"
	desc = "An abandoned supermatter crystal undergoing extreme nuclear decay as a result of poor maintenence and disposal."
	icon_state = "smdecay"
	anchored = TRUE
	rad_power = 1200
	rad_range = 0.2
	rad_delay = 0.5 SECONDS
