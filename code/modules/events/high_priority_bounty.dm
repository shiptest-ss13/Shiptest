/datum/round_event_control/high_priority_bounty
	name = "High Priority Bounty"
	typepath = /datum/round_event/high_priority_bounty
	max_occurrences = 3
	weight = 20
	earliest_start = 5 MINUTES

/datum/round_event_control/high_priority_bountyy/can_spawn_event(players_amt, gamemode)
	if(!(length(SSovermap.outposts)))
		return FALSE
	return ..()

/datum/round_event/high_priority_bounty
	var/datum/export/priority_bounty
	var/datum/overmap/outpost/target_outpost

/datum/round_event/high_priority_bounty/announce()
	priority_announce("We have issued a high-priority bounty for [priority_bounty.unit_name]. The Value has been doubled due to high demand.", "[target_outpost] Bounty Program", null, sender_override = "[target_outpost] Communications")

/datum/round_event/high_priority_bounty/setup()
	target_outpost = pick(SSovermap.outposts)
	priority_bounty = pick(GLOB.outpost_exports)

/datum/round_event/high_priority_bounty/start()
	if(priority_bounty)
		priority_bounty.true_cost = priority_bounty.cost * 2
