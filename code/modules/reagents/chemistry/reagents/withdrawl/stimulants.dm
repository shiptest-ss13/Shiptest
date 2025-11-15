///Stimulants

/datum/addiction/stimulants
	name = "stimulant"
	withdrawal_stage_messages = list("You feel a bit tired...You could really use a pick me up.", "You are getting a bit woozy...", "So...Tired...")

/datum/addiction/stimulants/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.add_actionspeed_modifier(/datum/actionspeed_modifier/stimulants)

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
