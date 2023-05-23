/datum/crew/ship
	var/datum/overmap/ship/controlled/ship

// Give a crew to an existing ship
/datum/crew/ship/New(datum/overmap/ship/controlled/_ship)
	..()
	ship = _ship
	class = _ship.source_template.short_name

	job_slots = ship.source_template.job_slots.Copy()
	base_job_slots = job_slots.Copy()
	species_whitelist = ship.source_template.species_whitelist
	for (var/datum/job/job in job_slots)
		species_whitelist_byjob[job] = job.species_whitelist

/datum/crew/ship/is_join_option()
	if (!..())
		return FALSE
	return (ship.shuttle_port)
