///starlight

/datum/addiction/starlight
	name = "starlight"
	withdrawal_stage_messages = list("I can't focus my eyes!", "I wish these stars would go away!", "...It's full of stars...")

/datum/addiction/stimulants/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.blur_eyes(5 SECONDS)

/datum/addiction/stimulants/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(STATUS_EFFECT_WOOZY)

/datum/addiction/stimulants/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.add_movespeed_modifier(/datum/movespeed_modifier/stimulants)

/datum/addiction/stimulants/lose_addiction(datum/mind/victim_mind)
	. = ..()
	victim_mind.current.remove_actionspeed_modifier(ACTIONSPEED_ID_STIMULANTS)
	victim_mind.current.remove_status_effect(STATUS_EFFECT_WOOZY)
	victim_mind.current.remove_movespeed_modifier(MOVESPEED_ID_STIMULANTS)
