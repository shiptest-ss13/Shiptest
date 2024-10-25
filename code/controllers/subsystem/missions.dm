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
		for(var/i in 1 to inactive_missions.len)
			//Make sure we dont ONLY take the one of the top.
			if(prob(50))
				//Has the pleasnt result of grabbing the most recent mission, idealy this means a freshly created planet
				var/datum/mission/dynamic/mission_to_start = inactive_missions[inactive_missions.len - (i - 1)]
				mission_to_start.start_mission()
				break


// should probably come up with a better solution for this
// hierarchical weighting? would need to distinguish between "real" and "fake" missions
/datum/controller/subsystem/missions/proc/get_weighted_mission_type()
	var/static/list/weighted_missions
	if(!weighted_missions)
		weighted_missions = list()
		var/list/mission_types = subtypesof(/datum/mission)
		for(var/datum/mission/mis_type as anything in mission_types)
			if(initial(mis_type.weight) > 0)
				weighted_missions[mis_type] = initial(mis_type.weight)
	return pickweight_float(weighted_missions)

/datum/controller/subsystem/missions/proc/get_researcher_name()
	var/group = pick(list(
		"Cybersun Industries",
		"CMM-GOLD",
		"Nanotrasen Anomalous Studies Division",
		"The Naturalienwissenschaftlicher Studentenverbindungs-Verband",
		"The Central Solarian Anomaly Research Agency",
		"DeForest Medical R&D",
		"A strange sarathi on the outpost"
	))
	return group
