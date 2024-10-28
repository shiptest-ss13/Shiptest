/obj/effect/anomaly/sparkler
	name = "sparkler"
	icon_state = "sparkler"
	desc = "A series of shimmering sparks flying to and fro. They try to spread, yet fail."
	density = TRUE
	core = /obj/item/assembly/signaler/anomaly/sparkler
	effectrange = 4
	pulse_delay = 1 SECONDS

/obj/effect/anomaly/sparkler/anomalyEffect()
	..()

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)
	var/turf/spot = locate(rand(src.x-effectrange, src.x+effectrange), rand(src.y-effectrange, src.y+effectrange), src.z)
	new /obj/effect/particle_effect/sparks(spot)
	return


/obj/effect/anomaly/sparkler/Bumped(atom/movable/AM)
	tesla_zap(src, 2, 5000, ZAP_FUSION_FLAGS)

/obj/effect/anomaly/sparkler/detonate()
	var/i = 0
	while(i <= 5)
		tesla_zap(src, 3, 10000, ZAP_DEFAULT_FLAGS)
		anomalyEffect()
		anomalyEffect()
		anomalyEffect()
		i = i + 1
	. = ..()

/obj/effect/anomaly/sparkler/planetary
	immortal = TRUE
	immobile = TRUE
