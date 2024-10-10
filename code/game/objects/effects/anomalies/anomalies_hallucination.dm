
/obj/effect/anomaly/hallucination
	name = "hallucination anomaly"
	icon_state = "hallucination"
	desc = "A shimmering mirage suspended above the ground, never in the same place as it was a second ago."
	core = /obj/item/assembly/signaler/anomaly/hallucination
	/// Time passed since the last effect, increased by delta_time of the SSobj
	var/ticks = 0
	/// How many seconds between each small hallucination pulses
	pulse_delay = 5 SECONDS
	effectrange = 5

/obj/effect/anomaly/hallucination/anomalyEffect(delta_time)
	. = ..()
	ticks += delta_time
	if(ticks < pulse_delay)
		return
	ticks -= pulse_delay
	var/turf/open/our_turf = get_turf(src)
	if(istype(our_turf))
		hallucination_pulse(our_turf, 5)
	pixel_x = pixel_x + clamp(rand(-5, 5), -16, 16)
	pixel_y = pixel_y + clamp(rand(-5, 5), -16, 16)

/obj/effect/anomaly/hallucination/detonate()
	var/turf/open/our_turf = get_turf(src)
	if(istype(our_turf))
		hallucination_pulse(our_turf, 10)
	. = ..()

/obj/effect/anomaly/hallucination/proc/hallucination_pulse(turf/open/location, effectrange)
	for(var/mob/living/carbon/human/user in view(location, effectrange))
		// If they are immune to the anomaly
		if (user.research_scanner)
			continue

		// Blind people don't get hallucinations.
		if (user.is_blind())
			continue

		// Everyone else gets hallucinations.
		var/dist = sqrt(1 / max(1, get_dist(user, location)))
		user.hallucination += 50 * dist
		user.hallucination = clamp(user.hallucination, 0, 150)
		var/list/messages = list(
			"You feel your conscious mind fall apart!",
			"Reality warps around you!",
			"Something's wispering around you!",
			"You are going insane!",
		)
		to_chat(user, span_warning(pick(messages)))

/obj/effect/anomaly/hallucination/planetary
	immortal = TRUE
	immobile = TRUE
