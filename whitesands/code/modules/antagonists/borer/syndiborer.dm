/mob/living/simple_animal/borer/syndi_borer
	var/mob/owner = null
	is_team_borer = FALSE
	borer_alert = "Serve as a syndicate cortical borer? (Warning, You can no longer be cloned!)"

/mob/living/simple_animal/borer/syndi_borer/Initialize(mapload, gen=1)
	..()
	real_name = "Syndicate Borer [rand(1000,9999)]"
	truename = "[borer_names[min(generation, borer_names.len)]] [rand(1000,9999)]"

	GrantBorerActions()
	make_larvae_action.Remove(src)

/mob/living/simple_animal/borer/syndi_borer/GrantControlActions()
	talk_to_brain_action.Grant(victim)
	give_back_control_action.Grant(victim)

/mob/living/simple_animal/borer/syndi_borer/RemoveControlActions()
	talk_to_brain_action.Remove(victim)
	give_back_control_action.Remove(victim)

//Syndicate borer objective, relies on their owner getting a greentext, no matter if they themselves did anything really.
/datum/objective/syndi_borer
	explanation_text = "You are a modified syndicate cortical borer, assist your owner with their objectives."
	martyr_compatible = 1

/datum/objective/syndi_borer/check_completion()
	if(target)
		for(var/datum/objective/objective in target.objectives)
			if(!objective.check_completion())
				return 0
		return 1
	else
		return 1 //Not sure if we should greentext if we somehow don't even have an owner.
