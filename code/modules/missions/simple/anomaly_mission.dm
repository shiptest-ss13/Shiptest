/datum/mission/simple/anomaly
	name = "Anomaly core requested"
	desc = "%MISSION_AUTHOR has requested that a ship locate an anomaly core for research. \
			They've offered to pay well, so we're relaying this mission to you."
	weight = 8
	value = 3000
	duration = 80 MINUTES
	dur_mod_range = 0.2
	container_type = /obj/item/storage/box/anomaly
	objective_type = /obj/item/assembly/signaler/anomaly
	num_wanted = 1

/datum/mission/simple/anomaly/generate_mission_details()
	. = ..()
	researcher_name = SSmissions.get_researcher_name()
