SUBSYSTEM_DEF(missions)
	name = "Missions"
	flags = SS_NO_INIT|SS_NO_FIRE
	priority = FIRE_PRIORITY_MISSIONS
	wait = 10 SECONDS

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
		"Cybersun Biodynamics",
		"Cybersun Virtual Solutions",
		"CLIP-GOLD Frontier Investigations Office",
		"CLIP-LAND Frontier Development Office",
		"Nanotrasen Frontier Studies Division",
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
