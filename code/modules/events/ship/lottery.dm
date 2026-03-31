/datum/round_event_control/ship/ship_lottery
	name = "Lottery"
	typepath = /datum/round_event/ship/lottery
	weight = 2
	earliest_start = 20 MINUTES
	min_players = 10
	max_occurrences = 1

/datum/round_event/ship/lottery
	var/creds_won = 0
	var/datum/overmap/outpost/target_outpost
	announce_when = 5

/datum/round_event/ship/lottery/setup()
	if(!..())
		return FALSE
	target_outpost = pick(SSovermap.outposts)

	creds_won = cubic_random(100, 10000)

/datum/round_event/ship/lottery/start()
	if(!target_ship)
		return
	if(target_ship.ship_account)
		target_ship.ship_account.adjust_money(creds_won, "deposit")

/datum/round_event/ship/lottery/announce(fake)
	if(fake)
		creds_won = 1000000000
	priority_announce("Congratulations to the [target_ship.name]! They've won a prize of [creds_won] credits!",
		null,
		null,
		"Sweepstakes lottery!",
		sender_override = "[target_outpost] Communications",
	)


