///starlight

/datum/addiction/starlight
	name = "starlight"
	withdrawal_stage_messages = list("I can't focus my eyes!", "I wish these stars would go away!", "...It's full of stars...")

/datum/addiction/stimulants/withdrawal_stage_1_process(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.blur_eyes(5)

/datum/addiction/stimulants/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(STATUS_EFFECT_WOOZY)

/datum/addiction/stimulants/withdrawal_stage_2_process(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(STATUS_EFFECT_WOOZY)
	affected_carbon.blur_eyes(10)


/datum/addiction/stimulants/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.blur_eyes(20)


/datum/addiction/stimulants/lose_addiction(datum/mind/victim_mind)
	. = ..()
	victim_mind.current.remove_status_effect(STATUS_EFFECT_WOOZY)
