/obj/effect/radiation
	name = "background radiation"
	icon = 'icons/effects/effects.dmi'
	icon_state = "radiation"
	invisibility = INVISIBILITY_ABSTRACT
	var/rad_power = 33
	var/rad_range = 1 // !Range mod = rad dropoff speed
	var/rad_spread = 6 // Range of nearby atoms to radiate
	var/rad_prob = 10
	COOLDOWN_DECLARE(pulse_cooldown)
	var/rad_delay = 2 SECONDS

/obj/effect/radiation/Initialize()
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/effect/radiation/process()
	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return ..()

	var/player_in_range = FALSE
	for(var/mob/living/L in range(rad_spread))
		if(L.client)
			player_in_range = TRUE
			break
	if(!player_in_range)
		return ..()
	COOLDOWN_START(src, pulse_cooldown, rad_delay)
	for(var/obj/O in range(rad_spread, src))
		if(prob(rad_prob))
			radiation_pulse(O, rad_power, rad_range)

	..()

/obj/effect/radiation/waste
	rad_power = 33
	rad_delay = 4 SECONDS
	rad_prob = 20
	rad_spread = 3

/obj/effect/radiation/waste/intense //3.6 roetgen. Not bad. Not good.
	rad_power = 120
	rad_delay = 8 SECONDS
	rad_prob = 10
