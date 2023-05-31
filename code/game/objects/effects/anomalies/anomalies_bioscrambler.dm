
/obj/effect/anomaly/bioscrambler
	name = "bioscrambler anomaly"
	icon_state = "bioscrambler"
	aSignal = /obj/item/assembly/signaler/anomaly/bioscrambler
	immortal = TRUE
	range = 4

/obj/effect/anomaly/bioscrambler/anomalyEffect(seconds_per_tick)
	. = ..()
	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)
	for(var/mob/living/carbon/nearby in range(range, src))
		if (nearby.run_armor_check(attack_flag = "bio") <= 100)
			nearby.apply_damage(10, CLONE)
			nearby.apply_effects(stutter = 3, eyeblur = 5, drowsy = 1,)
		for(nearby in range(range/2, src))
			nearby.bioscramble(name)

/obj/effect/anomaly/bioscrambler/big
	pulse_delay = 10
	range = 6

/obj/effect/anomaly/bioscrambler/big/Initialize(mapload, new_lifespan, drops_core)
	. = ..()

	transform *= 1.5

/obj/effect/anomaly/bioscrambler/planetary
	immortal = TRUE
	immobile = TRUE

/obj/effect/anomaly/bioscrambler/big/planetary
	immortal = TRUE
	immobile = TRUE
