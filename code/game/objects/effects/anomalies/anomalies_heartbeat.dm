/obj/effect/anomaly/heartbeat
	name = "heartbeat"
	icon_state = "heartbeat"
	desc = "A throbbing vertex, spreading a cancer to the world around itself."
	density = TRUE
	core = /obj/item/assembly/signaler/anomaly/heartbeat
	effectrange = 3
	pulse_delay = 6 SECONDS
	var/reagent_amount = 5

/obj/effect/anomaly/heartbeat/anomalyEffect()
	..()

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)
	playsound(src, 'sound/health/slowbeat2.ogg', 100)
	radiation_pulse(src, 500, 2)


	if(!COOLDOWN_FINISHED(src, pulse_secondary_cooldown))
		return

	COOLDOWN_START(src, pulse_secondary_cooldown, pulse_delay*4)
	var/turf/spot = locate(rand(src.x-effectrange, src.x+effectrange), rand(src.y-effectrange, src.y+effectrange), src.z)
	if(!spot)
		return

	playsound(spot, 'sound/health/slowbeat2.ogg', 100)
	radiation_pulse(spot, 200, effectrange)
	for(var/mob/living/carbon/nearby in range(effectrange, spot))
		nearby.apply_damage(10, BURN)
		to_chat(nearby, "Radiation burns open on your body.")

/obj/effect/anomaly/heartbeat/Bumped(atom/movable/AM)
	var/turf/spot = locate(rand(src.x-effectrange, src.x+effectrange), rand(src.y-effectrange, src.y+effectrange), src.z)
	playsound(spot, 'sound/health/slowbeat2.ogg', 100)
	radiation_pulse(spot, 200, effectrange)

/obj/effect/anomaly/heartbeat/detonate()
	radiation_pulse(src, 5000, 2)
	playsound(src, 'sound/health/fastbeat2.ogg', 300)
	. = ..()

/obj/effect/anomaly/heartbeat/planetary
	immortal = TRUE
	immobile = TRUE
