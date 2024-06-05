/datum/round_event_control/ship_lottery
	name = "lottery"
	typepath = /datum/round_event/ship/lottery
	weight = 10
	earliest_start = 0
	min_players = 1
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
		priority_announce("[target_ship] has won a sweep stakes for [creds_won] creds!", null, null, "Priority")


