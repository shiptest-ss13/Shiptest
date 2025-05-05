SUBSYSTEM_DEF(missions)
	name = "Missions"
	flags = SS_NO_INIT
	priority = FIRE_PRIORITY_MISSIONS
	wait = 10 SECONDS
	var/default_mission_count = 5
	var/list/obj/effect/landmark/mission_poi/unallocated_pois = list()
	var/list/datum/mission/ruin/inactive_ruin_missions = list()
	var/list/datum/mission/ruin/active_ruin_missions = list()

/datum/controller/subsystem/missions/stat_entry(msg)
	var/unallocated = unallocated_pois.len
	var/inactive_count = inactive_ruin_missions.len
	var/active_count = active_ruin_missions.len
	msg = "missions:A[active_count]|I:[inactive_count]|pois:[unallocated]"
	return ..()

/datum/controller/subsystem/missions/fire(resumed)
	for(var/datum/mission/ruin/mission_to_start in inactive_ruin_missions)
		if(MC_TICK_CHECK)
			return

		//Make sure we dont ONLY take the one of the top.
		if(prob(50))
			continue

		if(!(active_ruin_missions.len < default_mission_count + (SSovermap.controlled_ships.len * CONFIG_GET(number/max_dynamic_missions))))
			break

		if(mission_to_start.mission_limit)
			var/existing_count = 0
			for(var/datum/mission/ruin/mission_to_count in active_ruin_missions)
				if(mission_to_start.type == mission_to_count.type)
					existing_count++
			if(existing_count >= mission_to_start.mission_limit)
				//testing("skipping [mission_to_start][ADMIN_VV(mission_to_start)] because too many matching types exist already.")
				continue

		mission_to_start.start_mission()

//In case of emergency, pull lever
/datum/controller/subsystem/missions/proc/kill_active_missions()
	message_admins("All active missions have been deleted.")
	QDEL_LIST(active_ruin_missions)
	return TRUE

// should probably come up with a better solution for this
// hierarchical weighting? would need to distinguish between "real" and "fake" missions
/datum/controller/subsystem/missions/proc/get_weighted_mission_type()
	var/static/list/weighted_missions
	if(!weighted_missions)
		weighted_missions = list()
		var/list/mission_types = subtypesof(/datum/mission)
		for(var/datum/mission/mis_type as anything in mission_types)
			if(!(mis_type::acceptable))
				continue
			if(mis_type::weight > 0)
				weighted_missions[mis_type] = mis_type::weight
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
