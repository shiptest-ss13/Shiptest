/datum/brain_trauma/mild/concussion/on_life(delta_time, times_fired)
	. = ..()
	if(DT_PROB(1, delta_time))
		owner.cause_pain(BODY_ZONE_HEAD, 10)
