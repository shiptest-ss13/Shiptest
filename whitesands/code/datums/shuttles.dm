/datum/map_template/shuttle/emergency/syndicate
	file_name = "emergency_syndicate"
	name = "Syndicate GM Battlecruiser"
	credit_cost = 20000
	description = "Manufactured by the Gorlex Marauders, this cruiser has been specially designed with high occupancy in mind, while remaining robust in combat situations. Features a fully stocked EVA storage, armory, medbay, and bar!"
	admin_notes = "An emag exclusive, stocked with syndicate equipment and turrets that will target any simplemob."

/datum/map_template/shuttle/emergency/syndicate/prerequisites_met()
	if(SHUTTLE_UNLOCK_EMAGGED in SSshuttle.shuttle_purchase_requirements_met)
		return TRUE
	return FALSE

/datum/map_template/shuttle/emergency/packed
	file_name = "emergency_packed"
	name = "Packedstation emergency shuttle"
	credit_cost = 1000
	description = "Despite the name, this shuttle has a more open central seating area, and still complete with a brig and medbay."

/datum/map_template/shuttle/emergency/midway
	file_name = "emergency_midway"
	name = "Midwaystation emergency shuttle"
	credit_cost = 1000
	description = "This shuttle is long and made with a long open area with chairs on the side."

// Mining ship
/datum/map_template/shuttle/shiptest/mining_ship
	file_name = "mining_ship_all"
	name = "Mining Ship"

// Skeld
/datum/map_template/shuttle/shiptest/amogus
	file_name = "amogus_sus"
	name = "Skeld"

// Diner ship
/datum/map_template/shuttle/shiptest/diner
	file_name = "bar_ship"
	name = "Bar Ship"

// Engi ship
/datum/map_template/shuttle/shiptest/moth
	file_name = "engi_moth"
	name = "Engi"

/datum/map_template/shuttle/shiptest/skipper
	file_name = "ntsv_skipper"
	name = "Skipper"

/datum/map_template/shuttle/shiptest/radio
	file_name = "radio_funny"
	name = "Radio"

//Ruins
/datum/map_template/shuttle/ruin/solgov_exploration_pod
	file_name = "ruin_solgov_exploration_pod"
	name = "SolGov Exploration Pod"
