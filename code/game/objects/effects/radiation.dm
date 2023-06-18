/obj/effect/radiation
	name = "background radiation"
	icon = 'icons/effects/effects.dmi'
	icon_state = "radiation"
	invisibility = INVISIBILITY_ABSTRACT
	var/rad_power = 33
	var/rad_range = 1 // !Range mod = rad dropoff speed
	var/rad_spread = 6 // Range of nearby atoms to radiate
	var/rad_delay = 20
	var/rad_prob = 10
	var/_pulse = 0 // Holds the world.time interval in process

/obj/effect/radiation/Initialize()
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/effect/radiation/process()
	if(world.time > _pulse)
		for(var/obj/O in range(rad_spread, src))
			if(prob(rad_prob))
				radiation_pulse(O, rad_power, rad_range)
		_pulse = world.time + rad_delay
	..()

/obj/effect/radiation/waste
	rad_power = 33
	rad_delay = 40
	rad_prob = 20
	rad_spread = 3

/obj/effect/radiation/waste/intense //3.6 roetgen. Not bad. Not good.
	rad_power = 120
	rad_delay = 80
	rad_prob = 10
