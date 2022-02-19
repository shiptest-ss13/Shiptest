/datum/round_event_control/grid_check
	name = "Grid Check"
	typepath = /datum/round_event/grid_check
	weight = 10
	max_occurrences = 3

/datum/round_event/grid_check
	announceWhen	= 1
	startWhen = 1

/datum/round_event/grid_check/announce(fake)
	priority_announce("Abnormal activity detected in [station_name()]'s power networks. As a precautionary measure, the sector's power will be remotely shut off for an indeterminate duration.", "Critical Power Failure", 'sound/ai/poweroff.ogg')

/datum/round_event/grid_check/start()
	power_fail(30, 120)
