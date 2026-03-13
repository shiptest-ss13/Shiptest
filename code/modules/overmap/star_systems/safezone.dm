/datum/overmap_star_system/safezone
	name = "safezone"
	has_outpost = TRUE

	//main colors, used for dockable terrestrials, and background
	primary_color = "#ffffdf"
	secondary_color = "#828282"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#a2b210"
	hazard_secondary_color = "#5757c5"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#fbaa51"
	secondary_structure_color = "#fb1010"

	override_object_colors = TRUE
	overmap_icon_state = "overmap"

	//dont want ruinhunters in the safe sector...
	max_overmap_dynamic_events = 0

/datum/overmap_star_system/safezone/agni
	name = "Gorlex Controlled - Value of Public Works"
	starname = "Ecbatana"
	startype = /datum/overmap/star/dwarf
	default_outpost_type = /datum/overmap/outpost/ngr_rock

	//main colors, used for dockable terrestrials, and background
	primary_color = "#d9ad82"
	secondary_color = "#c48c60"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#c13623"
	hazard_secondary_color = "#943a43"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#83db2b"
	secondary_structure_color = "#21a52e"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_dark"

/datum/overmap_star_system/safezone/arrowsong
	name = "CLIP Controlled - High-Pier"
	starname = "Chana"
	startype = /datum/overmap/star/dwarf/orange
	default_outpost_type = /datum/overmap/outpost/clip_ocean

	//main colors, used for dockable terrestrials, and background
	primary_color = "#6fa8de"
	secondary_color = "#96b6d4"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#d5e3f0"
	hazard_secondary_color = "#96a6b5"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#97dfe8"
	secondary_structure_color = "#6fa8de"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_dark"

/datum/overmap_star_system/safezone/trifuge
	name = "Independent - Minya"
	starname = "Aubaine"
	startype = /datum/overmap/star/medium
	default_outpost_type = /datum/overmap/outpost/indie_space

	//main colors, used for dockable terrestrials, and background
	primary_color = "#5e5e5e"
	secondary_color = "#242424"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#b56060"
	hazard_secondary_color = "#824242"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#ffffff"
	secondary_structure_color = "#ffffff"

	override_object_colors = TRUE
	overmap_icon_state = "overmap"

/datum/overmap_star_system/safezone/yebiri
	name = "Nanotrasen Controlled - Persei-277"
	starname = "Persei-277"
	startype = /datum/overmap/star/medium
	default_outpost_type = /datum/overmap/outpost/nanotrasen_ice

	//main colors, used for dockable terrestrials, and background
	primary_color = "#7e8cd9"
	secondary_color = "#33324a"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#ededed"
	hazard_secondary_color = "#7f7db0"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#4272db"
	secondary_structure_color = "#38a0eb"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_dark"

/datum/overmap_star_system/safezone/thousand_eyes
	name = "Cybersun - Kapche-Legnica"
	starname = "Kapche-Legnica"
	startype = /datum/overmap/star/binary
	default_outpost_type = /datum/overmap/outpost/cybersun_gas_giant

	primary_color = "#00eaff"
	secondary_color = "#4d140f"

	hazard_primary_color = "#972241"
	hazard_secondary_color = "#71a1a9"

	primary_structure_color = "#ffffff"
	secondary_structure_color = "#ffffff"

	override_object_colors = TRUE
	overmap_icon_state = "overmap"

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

	//meant for example purposes, dont actually load this during a live round
	can_be_selected_randomly = FALSE

	//has jump point helpers in here
	can_jump_to = FALSE

	//the json file itself, you can change the directory of this if '_maps/sectors/*_starsystem.json' isn't a good enough naming scheme
	json = '_maps/sectors/teagarden_starsystem.json'

	//to avoid loading shit on top of hte map, and to copy the system information from the file
	generator_type = OVERMAP_GENERATOR_JSON
