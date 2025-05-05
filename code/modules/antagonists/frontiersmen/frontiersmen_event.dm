/datum/round_event_control/team/frontiersmen
	name = "Spawn Frontiersmen"
	typepath = /datum/round_event/ghost_role/frontiersmen
	weight = 0
	earliest_start = 60 MINUTES
	max_occurrences = 1
	min_players = 30

/datum/round_event/ghost_role/frontiersmen
	role_name = ROLE_FRONTIERSMEN

/datum/round_event/ghost_role/frontiersmen/announce()
	priority_announce("A Frontiersmen vessel has been spotted entering this sector.", "[station_name()] Early Warning Systems")

/datum/round_event/ghost_role/frontiersmen/spawn_role()
	return makeERT(/datum/ert/frontier)

