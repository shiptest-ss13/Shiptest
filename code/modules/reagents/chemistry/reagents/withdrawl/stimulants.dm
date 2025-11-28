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

/datum/addiction/opioids/end_withdrawal(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.remove_status_effect(/datum/status_effect/high_blood_pressure)
	affected_carbon.set_disgust(affected_carbon.disgust * 0.5) //half their disgust to help
