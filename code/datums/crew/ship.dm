/datum/crew/ship
	var/datum/overmap/ship/controlled/ship

// Give a crew to an existing ship
/datum/crew/ship/New(datum/overmap/ship/controlled/_ship)
	..()
	ship = _ship
	class = _ship.source_template.short_name
	name = _ship.name

	job_slots = ship.source_template.job_slots
	base_job_slots = job_slots

/datum/crew/ship/join_crew(mob/M, datum/job/job)
	..()
	pick(ship.shuttle_port.spawn_points).JoinPlayerHere(M, TRUE)

/datum/crew/ship/is_join_option()
	if (!..())
		return FALSE
	return (ship.shuttle_port && length(ship.shuttle_port.spawn_points) >= 1)
