/datum/disease/cold
	name = "The Cold"
	max_stages = 3
	cure_text = "Rest & Spaceacillin"
	cures = list(/datum/reagent/medicine/spaceacillin)
	agent = "XY-rhinovirus"
	viable_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	permeability_mod = 0.5
	desc = "If left untreated the subject will contract the flu."
	severity = DISEASE_SEVERITY_NONTHREAT

/datum/disease/cold/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, "<span class='danger'>Your throat feels sore.</span>")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, "<span class='danger'>Mucous runs down the back of your throat.</span>")
			if((affected_mob.body_position == LYING_DOWN && SPT_PROB(23, seconds_per_tick)) || SPT_PROB(0.025, seconds_per_tick))  //changed FROM prob(10) until sleeping is fixed // Has sleeping been fixed yet?
				to_chat(affected_mob, "<span class='notice'>You feel better.</span>")
				cure()
				return FALSE
		if(3)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, "<span class='danger'>Your throat feels sore.</span>")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, "<span class='danger'>Mucous runs down the back of your throat.</span>")
			if(SPT_PROB(0.25, seconds_per_tick) && !LAZYFIND(affected_mob.disease_resistances, /datum/disease/flu))
				var/datum/disease/Flu = new /datum/disease/flu()
				affected_mob.ForceContractDisease(Flu, FALSE, TRUE)
				cure()
				return FALSE
			if((affected_mob.body_position == LYING_DOWN && SPT_PROB(12.5, seconds_per_tick)) || SPT_PROB(0.005, seconds_per_tick))  //changed FROM prob(5) until sleeping is fixed
				to_chat(affected_mob, "<span class='notice'>You feel better.</span>")
				cure()
				return FALSE
