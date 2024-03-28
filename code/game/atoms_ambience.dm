/// Procs to manage ambience on atoms. To set an ambience onto something just call `set_ambience()`.

/atom/proc/add_ambience(passed_ambience)
	return

/atom/proc/remove_ambience(passed_ambience)
	return

/atom/proc/set_ambience(new_ambience)
	ambience = new_ambience

/atom/movable/set_ambience(new_ambience)
	if(ambience)
		loc.remove_ambience(ambience)
	ambience = new_ambience
	if(ambience)
		loc.add_ambience(ambience)

/turf/add_ambience(passed_ambience)
	LAZYINITLIST(ambience_list)
	ambience_list += passed_ambience

/turf/remove_ambience(passed_ambience)
	ambience_list -= passed_ambience
	UNSETEMPTY(ambience_list)
