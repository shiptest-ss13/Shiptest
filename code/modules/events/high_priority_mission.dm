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
	priority_announce("[target_outpost.main_template.outpost_administrator] has issued a series of high priority missions. Details are available at [target_outpost].", "[target_outpost] Mission Program", null, sender_override = "[target_outpost] Communications")

/datum/round_event/high_priority_mission/setup()
	target_outpost = pick(SSovermap.outposts)
	for(var/i = 0, i<3, i++)
		var/high_priority = SSmissions.get_weighted_mission_type()
		var/datum/mission/M = new high_priority(target_outpost)

		LAZYADD(target_outpost.missions, M)
		M.value *= 2
		M.name = "HIGH PRIORITY - [M.name]"
		M.high_priority = TRUE
		log_game("[priority_mission][ADMIN_VV(priority_mission)] was selected for [src]")

/datum/round_event/high_priority_mission/start()
	notify_ghosts("High priority missions are being announced by the [target_outpost]!")

