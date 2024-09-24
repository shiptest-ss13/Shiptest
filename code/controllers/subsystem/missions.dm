SUBSYSTEM_DEF(missions)
	name = "Missions"
	flags = SS_NO_INIT
	priority = FIRE_PRIORITY_MISSIONS
	var/list/obj/effect/landmark/mission_poi/unallocated_pois = list()
	var/list/datum/dynamic_mission/inactive_missions = list()
	var/list/datum/dynamic_mission/active_missions = list()

	var/max_active_missions = 5

/datum/controller/subsystem/missions/stat_entry(msg)
	var/unallocated = unallocated_pois.len
	var/inactive_count = inactive_missions.len
	var/active_count = active_missions.len
	msg = "missions:A[active_count]|I:[inactive_count]|pois:[unallocated]"
	return ..()

/datum/controller/subsystem/missions/fire(resumed)
	if(active_missions.len < max_active_missions)
		if(inactive_missions.len)
			var/datum/dynamic_mission/mission_to_start = inactive_missions[inactive_missions.len]
			mission_to_start.start_mission()


