/datum/mission/acquire/crystal_critter
	name = "Crystal Infection Study"
	desc = ""
	value = 8000
	weight = 1
	container_type = /obj/structure/closet/mob_capture
	objective_type = /mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal
	num_wanted = 1
	count_stacks = FALSE

/datum/mission/acquire/crystal_critter/New(...)
	if(!name)
		name = "Crystal Infection Study"
	if(!desc)
		desc = "[SSmissions.get_researcher_name()] have requested the capture of an anomalous crystal lifeform for the sake of research into the phenomena. \
				Take care in capturing it, as entities infected by crystals tend to have enhanced protections for themselves. A lifeform capture unit will be provided for safety's sake."
	. = ..()


/datum/mission/acquire/crystal_critter/atom_effective_count(atom/movable/target)
	if(is_type_in_list(target, list(
			/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal, \
			/mob/living/simple_animal/hostile/asteroid/hivelord/legion/crystal, \
			/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten \
			)))
		return 1
	return 0
