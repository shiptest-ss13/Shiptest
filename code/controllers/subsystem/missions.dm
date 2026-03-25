SUBSYSTEM_DEF(missions)
	name = "Missions"
	flags = SS_NO_INIT|SS_NO_FIRE
	priority = FIRE_PRIORITY_MISSIONS
	wait = 10 SECONDS

// should probably come up with a better solution for this
// hierarchical weighting? would need to distinguish between "real" and "fake" missions
/datum/controller/subsystem/missions/proc/get_weighted_mission_type(datum/overmap_star_system/system_to_check)
	if(!system_to_check)
		CRASH("get_weighted_mission_type called without target star system!")
	var/static/list/weighted_missions
	if(!weighted_missions)
		weighted_missions = list()
		var/list/mission_types = subtypesof(/datum/mission)
		for(var/datum/mission/mis_type as anything in mission_types)
			if(!(mis_type::acceptable))
				continue
			if(mis_type::weight > 0)
				weighted_missions[mis_type] = mis_type::weight

	return get_valid_mission(system_to_check, weighted_missions)

/datum/controller/subsystem/missions/proc/get_valid_mission(datum/overmap_star_system/system_to_check, list/valid_missions)
	var/datum/mission/target_mission = pick_weight(valid_missions)
	//if the mission has no location requirements, return it early
	if(!length(target_mission.required_locations))
		return target_mission
	//otherwise check the target overmap for an encounter that fulfills the mission's need
	for(var/encounter in system_to_check.dynamic_encounters)
		for(var/datum/overmap/dynamic/location in target_mission.required_locations)
			if(istype(encounter, location.planet))
				return target_mission
	//if we don't find one for this current mission, remove it from the list and try again with a new one.
	valid_missions -= target_mission
	if(!length(valid_missions))
		return null
	return get_valid_mission(system_to_check, valid_missions)

/datum/controller/subsystem/missions/proc/get_researcher_name()
	var/group = pick(list(
		"Cybersun Biodynamics",
		"Cybersun Virtual Solutions",
		"CLIP-GOLD Frontier Investigations Office",
		"CLIP-LAND Frontier Development Office",
		"Makosso-Warra Frontier Studies Division",
		"The N+S Survey Corps",
		"The Naturalienwissenschaftlicher Studentenverbindungs-Verband",
		"The Central Solarian Frontier Research Agency",
		"NGR Bureau of Expansion",
		"NGR Bureau of Industry",
		"A Gezenan newscaster",
		"PGFN representatives",
		"Tecetian researchers",
		"The representative of a Rachnid guild",
		"A strange sarathi on the outpost"
	))
	return group
