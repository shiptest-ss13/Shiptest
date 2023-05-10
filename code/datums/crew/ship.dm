/datum/crew/ship
	var/datum/overmap/ship/controlled/ship

/datum/crew/ship/New(position, var/datum/map_template/shuttle/template)
	..()
	job_slots = template.job_slots
	base_job_slots = job_slots
	ship = new(position, template)
	ship.crew = src

/datum/crew/ship/join_crew(mob/M, datum/job/job)
	..()
	M.forceMove(pick(ship.shuttle_port.spawn_points))

/datum/crew/ship/is_join_option()
	if (!..())
		return FALSE
	return (ship.shuttle_port && length(ship.shuttle_port.spawn_points) >= 1)
