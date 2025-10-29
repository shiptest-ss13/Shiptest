///Nicotine
/datum/addiction/nicotine
	name = "nicotine"
	withdrawal_stage_messages = list("Feel like having a smoke...", "Getting antsy. Really need a smoke now.", "I can't take it! Need a smoke NOW!")

/datum/addiction/nicotine/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_timed_status_effect(5 SECONDS * seconds_per_tick, /datum/status_effect/jitter, only_if_higher = TRUE)

/datum/addiction/nicotine/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_timed_status_effect(10 SECONDS * seconds_per_tick, /datum/status_effect/jitter, only_if_higher = TRUE)
	SEND_SIGNAL(affected_carbon, COMSIG_ADD_MOOD_EVENT, "nicotine_withdrawal_moderate", /datum/mood_event/nicotine_withdrawal_moderate)
	if(SPT_PROB(10, seconds_per_tick))
		affected_carbon.emote("cough")

/datum/addiction/nicotine/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_timed_status_effect(15 SECONDS * seconds_per_tick, /datum/status_effect/jitter, only_if_higher = TRUE)
	SEND_SIGNAL(affected_carbon, COMSIG_ADD_MOOD_EVENT, "nicotine_withdrawal_severe", /datum/mood_event/nicotine_withdrawal_severe)
	if(SPT_PROB(15, seconds_per_tick))
		affected_carbon.emote("cough")
