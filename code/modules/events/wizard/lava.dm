/datum/round_event_control/wizard/lava //THE LEGEND NEVER DIES
	name = "The Floor Is LAVA!"
	weight = 2
	typepath = /datum/round_event/wizard/lava
	max_occurrences = 3
	earliest_start = 0 MINUTES

/datum/round_event/wizard/lava
	endWhen = 0
	var/started = FALSE

/datum/round_event/wizard/lava/start()
	/// Should point to a central mapzone.weather_controller, one doesn't exist in shiptest
	WARNING("Wizard Floor is Lava event is not implemented.")
	return
