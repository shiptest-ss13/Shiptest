/datum/round_event_control/ship_lottery
	name = "Lottery"
	typepath = /datum/round_event/ship/lottery
	weight = 2
	earliest_start = 20 MINUTES
	min_players = 10
	max_occurrences = 1

/datum/round_event_control/ship_lottery/canSpawnEvent(players, allow_magic = FALSE)
	if(!(length(SSovermap.controlled_ships)))
		return FALSE
	return ..()

/datum/round_event/ship/lottery
	var/creds_won = 0
	announceWhen = 5

/datum/round_event/ship/lottery/start()
	if(!target_ship)
		return
	if(target_ship.ship_account)
		creds_won = rand(1, 100) * 250
		target_ship.ship_account.adjust_money(creds_won, "deposit")

/datum/round_event/ship/lottery/announce(fake)
	if(prob(announceChance) || fake)
		if(fake)
			creds_won = 1000000000
		priority_announce("congracts to [target_ship] who has won a sweep stakes for [creds_won] creds!",
			null,
			null,
			"Sweep stakes!",
			sender_override = "Outpost Communications",
		)


