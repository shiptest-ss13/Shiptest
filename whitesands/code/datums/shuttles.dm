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

/datum/map_template/shuttle/emergency/midway
	suffix = "midway"
	name = "Midwaystation emergency shuttle"
	credit_cost = 1000
	description = "This shuttle is long and made with a long open area with chairs on the side."

//Mining ship
/datum/map_template/shuttle/mining_ship
	port_id = "mining_ship"
	suffix = "all"

/datum/map_template/shuttle/amogus
	port_id = "amogus"
	suffix = "sus"

/datum/map_template/shuttle/diner
	port_id = "bar"
	suffix = "ship"

/datum/map_template/shuttle/moth
	port_id = "engi"
	suffix = "moth"

/datum/map_template/shuttle/radio
	port_id = "radio"
	suffix = "funny"

/datum/map_template/shuttle/minigalaxy
	port_id = "mining"
	suffix = "minigalaxy"

/datum/map_template/shuttle/ministarfury //"""mini"""
	port_id = "mining"
	suffix = "ministarfury"
	
/datum/map_template/shuttle/golemship 
	port_id = "mining"
	suffix = "golem"

//Ruins
/datum/map_template/shuttle/ruin/solgov_exploration_pod
	suffix = "solgov_exploration_pod"
	name = "SolGov Exploration Pod"
