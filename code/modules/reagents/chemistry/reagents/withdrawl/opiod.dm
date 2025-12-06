///opioids
/datum/addiction/opioids
	name = "opiod"
	withdrawal_stage_messages = list("I feel aches in my bodies..", "I need some pain relief...", "It aches all over...I need some opioids!")

/datum/addiction/opioids/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(SPT_PROB(10, seconds_per_tick))
		affected_carbon.emote("yawn")

/datum/addiction/opioids/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(STATUS_EFFECT_HIGHBLOODPRESSURE)

/datum/addiction/opioids/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(affected_carbon.disgust < DISGUST_LEVEL_DISGUSTED && SPT_PROB(7.5, seconds_per_tick))
		affected_carbon.adjust_disgust(12.5 * seconds_per_tick)

/datum/addiction/opioids/end_withdrawal(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.remove_status_effect(/datum/status_effect/high_blood_pressure)
	affected_carbon.set_disgust(affected_carbon.disgust * 0.5) //half their disgust to help
