///Alcohol
/datum/addiction/alcohol
	name = "alcohol"
	withdrawal_stage_messages = list("I could use a drink...", "Maybe the bar is still open?..", "God I need a drink!")

/datum/addiction/alcohol/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_timed_status_effect(5 SECONDS * seconds_per_tick, /datum/status_effect/jitter, only_if_higher = TRUE)

/datum/addiction/alcohol/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_timed_status_effect(10 SECONDS * seconds_per_tick, /datum/status_effect/jitter, only_if_higher = TRUE)
	affected_carbon.hallucination = max(5 SECONDS, affected_carbon.hallucination)

/datum/addiction/alcohol/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_timed_status_effect(15 SECONDS * seconds_per_tick, /datum/status_effect/jitter, only_if_higher = TRUE)
	affected_carbon.hallucination = max(5 SECONDS, affected_carbon.hallucination)
	if(SPT_PROB(4, seconds_per_tick))
		if(!HAS_TRAIT(affected_carbon, TRAIT_ANTICONVULSANT))
			affected_carbon.apply_status_effect(STATUS_EFFECT_SEIZURE)
