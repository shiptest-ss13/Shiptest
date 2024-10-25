/datum/mission/acquire/anomaly
	name = "Anomaly core requested"
	weight = 8
	value = 3000
	duration = 80 MINUTES
	dur_mod_range = 0.2
	container_type = /obj/item/storage/box/anomaly
	objective_type = /obj/item/assembly/signaler/anomaly
	num_wanted = 1
	var/researcher_name

/datum/mission/acquire/anomaly/New(...)
	researcher_name = get_researcher_name()
	desc = "[researcher_name] has requested that a ship [pick(list("procure", "grab", "acquire", "find", "locate"))] \
	an anomaly core for [pick(list("research", "analysis", "technical development", "closer inspection", "some reason"))]. \
	They've offered to pay well, so we're relaying this mission to you"
	. = ..()
