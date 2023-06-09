/obj/effect/anomaly/pulsar
	name = "pulsar"
	icon_state = "pulsar"
	desc = "A mysterious anomaly, endless electromagnetic disturbances roll out from it"
	density = TRUE
	aSignal = /obj/item/assembly/signaler/anomaly/pulsar
	effectrange = 4
	pulse_delay = 15 SECONDS


/obj/effect/anomaly/pulsar/anomalyEffect()
	..()

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)
	var/turf/spot = locate(rand(src.x-effectrange/2, src.x+effectrange/2), rand(src.y-effectrange/2, src.y+effectrange/2), src.z)
	empulse(spot, effectrange/2, effectrange) //yeah it's not a thrilling effect. I think it's fine though.


/obj/effect/anomaly/pulsar/Bumped(atom/movable/AM)
	empulse(loc, effectrange/2, effectrange)

/obj/effect/anomaly/pulsar/detonate()
	empulse(loc, effectrange, effectrange*2)
	. = ..()


/obj/effect/anomaly/pulsar/planetary
	immortal = TRUE
	immobile = TRUE
