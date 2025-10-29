/datum/addiction/shoal
	name = "shoal fungus"
	withdrawal_stage_messages = list("My vision is so blurry...", "Need to keep moving.", "My heart won't stop!")

/datum/addiction/shoal/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.blur_eyes(5)

/datum/addiction/shoal/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_timed_status_effect(5 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	affected_carbon.hallucination = max(5 SECONDS, affected_carbon.hallucination)
	if(SPT_PROB(5, seconds_per_tick))
		var/obj/item/held_item = affected_carbon.get_active_held_item()
		if(held_item)
			affected_carbon.dropItemToGround(held_item)
			to_chat(affected_carbon, span_notice("Your hands flinch and you drop what you were holding!"))

/datum/addiction/shoal/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(STATUS_EFFECT_HIGHBLOODPRESSURE)

/datum/addiction/shoal/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()

	affected_carbon.set_timed_status_effect(5 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)

	if(SPT_PROB(10, seconds_per_tick))
		affected_carbon.playsound_local(affected_carbon, 'sound/effects/singlebeat.ogg', 100, 0)

	if(SPT_PROB(1, seconds_per_tick))
		if(!HAS_TRAIT(affected_carbon, TRAIT_BLOODY_MESS))
			var/datum/disease/D = new /datum/disease/heart_failure
			affected_carbon.ForceContractDisease(D)
			to_chat(affected_carbon, span_userdanger("You're pretty sure you just felt your heart stop for a second there..."))
			affected_carbon.playsound_local(affected_carbon, 'sound/effects/singlebeat.ogg', 100, 0)
