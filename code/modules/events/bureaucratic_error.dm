/datum/round_event_control/bureaucratic_error
	name = "Bureaucratic Error"
	typepath = /datum/round_event/bureaucratic_error
	max_occurrences = 1
	weight = 5
	min_players = 10 //WS Edit - Bureaucracy Nerf

/datum/round_event/bureaucratic_error
	announceWhen = 1
	//WS Start - Bureaucracy Nerf
	//these jobs can't be reopened, and AI can't have multiple latejoins anyway, so the error will not close them
	var/list/blacklisted = list(
		"AI",
		"Assistant",
		"Cyborg",
		"Captain",
		"Head of Personnel",
		"Head of Security",
		"Chief Engineer",
		"Research Director",
		"Chief Medical Officer") //WS End

/datum/round_event/bureaucratic_error/announce(fake)
	priority_announce("A recent bureaucratic error in the Organic Resources Department may result in personnel shortages in some departments and redundant staffing in others.", "Paperwork Mishap Alert")

/datum/round_event/bureaucratic_error/start()
	var/list/jobs = SSjob.occupations.Copy()
	if(prob(5))	// Only allows latejoining as a single role. Add latejoin AI bluespace pods for fun later. WS Edit - Bureaucracy Nerf
		var/datum/job/overflow = pick_n_take(jobs)
		overflow.spawn_positions = -1
		overflow.total_positions = -1 // Ensures infinite slots as this role. Assistant will still be open for those that cant play it.
		for(var/job in jobs)
			var/datum/job/current = job
			if(!current.allow_bureaucratic_error)
				continue
			current.total_positions = 0
	else	// Adds/removes a random amount of job slots from all jobs.
		for(var/job in jobs)
			var/datum/job/current = job
			if(!current.allow_bureaucratic_error || (current.title in blacklisted) || current.title == SSjob.overflow_role)
				continue
			var/ran = rand(-2,4)
			current.total_positions = max(current.total_positions + ran, 0)
