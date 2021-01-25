/mob/living/simple_animal/hostile/proc/set_camp_faction(tag)
	src.faction = list()
	if (length(initial(src.faction)) > 0)
		src.faction += initial(src.faction)
	src.faction += tag
