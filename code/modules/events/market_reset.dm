/datum/round_event_control/market_reset
	name = "Market Reset"
	typepath = /datum/round_event/market_reset
	max_occurrences = 1
	weight = 10
	earliest_start = 90 MINUTES

/datum/round_event_control/market_reset/can_spawn_event(players_amt, gamemode)
	if(!(length(SSovermap.outposts)))
		return FALSE
	return ..()

/datum/round_event/market_reset
	var/datum/mission/priority_mission

/datum/round_event/market_reset/announce()
	priority_announce("[target_outpost.outpost_administrator] has announced a reset of market prices at [target_outpost] due to shifting trade conditions.", "[target_outpost] Trade Authority", null, sender_override = "[target_outpost] Communications")

/datum/round_event/market_reset/setup()
	target_outpost = pick(SSovermap.outposts)
	if(!target_outpost)
		//how
		return
	for(var/datum/export/target as anything in GLOB.outpost_exports)
		target.true_cost = cost

/datum/round_event/market_reset/start()
	notify_ghosts("The export market is resetting at [target_outpost]!")

