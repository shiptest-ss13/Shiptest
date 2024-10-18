SUBSYSTEM_DEF(missions)
	name = "Missions"
	flags = SS_NO_INIT
	priority = FIRE_PRIORITY_MISSIONS
	var/list/obj/effect/landmark/mission_poi/unallocated_pois = list()
	var/list/datum/mission/dynamic/inactive_missions = list()
	var/list/datum/mission/dynamic/active_missions = list()

/datum/controller/subsystem/missions/stat_entry(msg)
	var/unallocated = unallocated_pois.len
	var/inactive_count = inactive_missions.len
	var/active_count = active_missions.len
	msg = "missions:A[active_count]|I:[inactive_count]|pois:[unallocated]"
	return ..()

/datum/controller/subsystem/missions/fire(resumed)
	if(active_missions.len < CONFIG_GET(number/max_dynamic_missions))
		if(inactive_missions.len)
			//Has the pleasnt result of grabbing the most recent mission, idealy this means a freshly created planet
			var/datum/mission/dynamic/mission_to_start = inactive_missions[inactive_missions.len]
			mission_to_start.start_mission()
