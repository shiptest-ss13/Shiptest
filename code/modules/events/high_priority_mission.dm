/datum/round_event_control/high_priority_mission
	name = "High Priority Mission"
	typepath = /datum/round_event/high_priority_mission
	max_occurrences = 3
	weight = 20
	earliest_start = 5 MINUTES

/datum/round_event_control/high_priority_missiony/can_spawn_event(players_amt, gamemode)
	if(!(length(SSovermap.outposts)))
		return FALSE
	return ..()

/datum/round_event/high_priority_mission
	var/datum/mission/priority_mission
	var/datum/overmap/outpost/target_outpost

/datum/round_event/high_priority_mission/announce()
	priority_announce("We have issued a high-priority mission. Details have been sent to all consoles.", "[target_outpost] Mission Program", null, sender_override = "[target_outpost] Communications")

/datum/round_event/high_priority_mission/setup()
	target_outpost = pick(SSovermap.outposts)
	var/list/pickable_missions = list()
	for(var/datum/mission/ruin/active_mission in SSmissions.active_ruin_missions)
		if(active_mission.dibs_string)
			continue
		pickable_missions.Add(active_mission)
	for(var/datum/mission/ruin/inactive_mission in SSmissions.inactive_ruin_missions)
		pickable_missions.Add(inactive_mission)
	if(pickable_missions.len)
		priority_mission = pick(pickable_missions)
		if(priority_mission.active != TRUE)
			priority_mission.start_mission()
		message_admins("[priority_mission][ADMIN_VV(priority_mission)] has been selected for [src]")

/datum/round_event/high_priority_mission/start()
	if(priority_mission)
		notify_ghosts("[priority_mission] value has been doubled")
		priority_mission.name = "HIGH PRIORITY - [priority_mission.name]"
		priority_mission.value = priority_mission.value * 2
