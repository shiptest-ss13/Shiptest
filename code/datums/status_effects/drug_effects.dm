/datum/status_effect/stoned
	id = "stoned"
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/stoned
	status_type = STATUS_EFFECT_REFRESH

/datum/status_effect/stoned/on_apply()
	if(!ishuman(owner))
		CRASH("[type] status effect added to non-human owner: [owner ? owner.type : "null owner"]")
	var/mob/living/carbon/human/human_owner = owner
	human_owner.add_movespeed_modifier(/datum/movespeed_modifier/reagent/cannabis)
	ADD_TRAIT(human_owner, TRAIT_BLOODSHOT_EYES, type)
	ADD_TRAIT(human_owner, TRAIT_CLUMSY, type)
	SEND_SIGNAL(human_owner, COMSIG_ADD_MOOD_EVENT, "stoned", /datum/mood_event/stoned) //improves mood
	human_owner.sound_environment_override = SOUND_ENVIRONMENT_DRUGGED
	return TRUE

/datum/status_effect/stoned/on_remove()
	if(!ishuman(owner))
		stack_trace("[type] status effect being removed from non-human owner: [owner ? owner.type : "null owner"]")
	var/mob/living/carbon/human/human_owner = owner
	human_owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/cannabis)
	REMOVE_TRAIT(human_owner, TRAIT_BLOODSHOT_EYES, type)
	REMOVE_TRAIT(human_owner, TRAIT_CLUMSY, type)
	SEND_SIGNAL(human_owner, COMSIG_CLEAR_MOOD_EVENT, "stoned")
	human_owner.sound_environment_override = SOUND_ENVIRONMENT_NONE

/atom/movable/screen/alert/status_effect/stoned
	name = "Stoned"
	desc = "Cannabis is impairing your speed, motor skills, and mental cognition."
	icon_state = "stoned"
