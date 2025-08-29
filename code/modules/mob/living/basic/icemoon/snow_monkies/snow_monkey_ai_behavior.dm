/datum/ai_behavior/find_hunt_target/harvest_garden

/datum/ai_behavior/find_hunt_target/harvest_garden/valid_dinner(mob/living/source, obj/structure/flora/ash/garden/yummers, radius)
	if(!yummers.harvested)
		return TRUE
