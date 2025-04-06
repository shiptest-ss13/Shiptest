/datum/round_event_control/high_priority_mission
	name = "High Priority Mission"
	typepath = /datum/round_event/high_priority_mission
	max_occurrences = 3
	weight = 20
	earliest_start = 0 //10 MINUTES

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
	if(prob(75))
		priority_mission = pick(SSmissions.active_ruin_missions)
	else
		priority_mission = pick(target_outpost.missions)

/datum/round_event/high_priority_mission/start()
	if(priority_mission)
		priority_mission.name = "HIGH PRIORITY - [priority_mission.name]"
		priority_mission.value = priority_mission.value * 3
