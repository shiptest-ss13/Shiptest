
/obj/effect/anomaly/bioscrambler
	name = "bioscrambler anomaly"
	icon_state = "bioscrambler"
	aSignal = /obj/item/assembly/signaler/anomaly/bioscrambler
	immortal = TRUE
	/// Cooldown for every anomaly pulse
	COOLDOWN_DECLARE(pulse_cooldown)
	/// How many seconds between each anomaly pulses
	var/pulse_delay = 15 SECONDS
	/// Range of the anomaly pulse
	var/range = 6

/obj/effect/anomaly/bioscrambler/anomalyEffect(seconds_per_tick)
	. = ..()
	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)
	for(var/mob/living/carbon/nearby in range(range, src))
		nearby.bioscramble(name)
		if (nearby.run_armor_check(attack_flag = "bio") >= 100)
			nearby.apply_damage(10, CLONE, spread_damage = TRUE)

/obj/effect/anomaly/bioscrambler/big
	pulse_delay = 10
	range = 10

/obj/effect/anomaly/bioscrambler/big/Initialize(mapload, new_lifespan, drops_core)
	. = ..()

	transform *= 3
