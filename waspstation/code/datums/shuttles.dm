/datum/map_template/shuttle/emergency/syndicate
	suffix = "syndicate"
	name = "Syndicate GM Battlecruiser"
	credit_cost = 20000
	description = "Manufactured by the Gorlex Marauders, this cruiser has been specially designed with high occupancy in mind, while remaining robust in combat situations. Features a fully stocked EVA storage, armory, medbay, and bar!"
	admin_notes = "An emag exclusive, stocked with syndicate equipment and turrets that will target any simplemob."

/datum/map_template/shuttle/emergency/syndicate/prerequisites_met()
	if(SHUTTLE_UNLOCK_EMAGGED in SSshuttle.shuttle_purchase_requirements_met)
		return TRUE
	return FALSE

/datum/map_template/shuttle/emergency/packed
	suffix = "packed"
	name = "Packedstation emergency shuttle"
	credit_cost = 1000
	description = "Despite the name, this shuttle has a more open central seating area, and still complete with a brig and medbay."
