//not meant to be seen normally: this shows the eventing/storytelling potential of json overmaps
//while unable to add sectors to punchards yet, this could be a good sample punchcard map, not in the main overmap but in its own enviroment
/datum/overmap_star_system/sunset_example
	name = "Abandoned - New Dawn"
	can_jump_to = FALSE
	json = '_maps/sectors/sunset_starsystem.json'
	generator_type = OVERMAP_GENERATOR_JSON

//example of json loading 'static star systems', AKA premapped beforehand
/datum/overmap_star_system/safezone/json_example
	name = "Independent - Lymantria Teagarden Memorial"

	//overridden by the json file, but probably useful to have this here as an example
	dynamic_probabilities = list(\
		DYNAMIC_WORLD_BEACHPLANET = 10,
		DYNAMIC_WORLD_SPACERUIN = 5,
		DYNAMIC_WORLD_MOON = 20,
		)

	//json loading spawns the outpost during loading, no need to spawn it with this var
	has_outpost = FALSE

	//has jump point helpers in here
	can_jump_to = FALSE

	//the json file itself, you can change the directory of this if '_maps/sectors/*_starsystem.json' isn't a good enough naming scheme
	json = '_maps/sectors/teagarden_starsystem.json'

	//to avoid loading shit on top of hte map, and to copy the system information from the file
	generator_type = OVERMAP_GENERATOR_JSON
