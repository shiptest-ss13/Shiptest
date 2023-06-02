
/obj/effect/anomaly/hallucination
	name = "hallucination anomaly"
	icon_state = "hallucination"
	aSignal = /obj/item/assembly/signaler/anomaly/hallucination
	/// Time passed since the last effect, increased by delta_time of the SSobj
	var/ticks = 0
	/// How many seconds between each small hallucination pulses
	pulse_delay = 5

/obj/effect/anomaly/hallucination/anomalyEffect(delta_time)
	. = ..()
	ticks += delta_time
	if(ticks < pulse_delay)
		return
	ticks -= pulse_delay
	var/turf/open/our_turf = get_turf(src)
	if(istype(our_turf))
		hallucination_pulse(our_turf, 5)

/obj/effect/anomaly/hallucination/detonate()
	var/turf/open/our_turf = get_turf(src)
	if(istype(our_turf))
		hallucination_pulse(our_turf, 10)
	. = ..()

/obj/effect/anomaly/hallucination/proc/hallucination_pulse(turf/open/location, range)
	for(var/mob/living/carbon/human/near in view(location, range))
		// If they are immune to hallucinations.
		if (HAS_TRAIT(near, SEE_TURFS) || (near.mind && HAS_TRAIT(near.mind, SEE_TURFS)))
			continue

		// Blind people don't get hallucinations.
		if (near.is_blind())
			continue

		// Everyone else gets hallucinations.
		var/dist = sqrt(1 / max(1, get_dist(near, location)))
		near.hallucination += 50 * dist
		near.hallucination = clamp(near.hallucination, 0, 150)
		var/list/messages = list(
			"You feel your conscious mind fall apart!",
			"Reality warps around you!",
			"Something's wispering around you!",
			"You are going insane!",
		)
		to_chat(near, span_warning(pick(messages)))

/obj/effect/anomaly/hallucination/planetary
	immortal = TRUE
	immobile = TRUE
