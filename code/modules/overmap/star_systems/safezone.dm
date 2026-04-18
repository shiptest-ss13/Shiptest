/datum/overmap_star_system/safezone
	name = "Default Sector"
	has_outpost = TRUE
	faction = /datum/faction/independent

	override_object_colors = TRUE
	overmap_icon_state = "overmap"

	primary_color = "#5e5e5e"
	secondary_color = "#242424"

	hazard_primary_color = "#b56060"
	hazard_secondary_color = "#824242"

	primary_structure_color = "#ffffff"
	secondary_structure_color = "#ffffff"

	max_overmap_dynamic_events = 0

	size = 20

	//this matters less for static outposts but it is a nice fallback.
	event_probabilities = list(
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/electric/minor = 45,
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/meteor/minor = 45,
		/datum/overmap/event/meteor = 40,
		/datum/overmap/event/meteor/dust = 50,
	)

	entry_quotes = list("This is a fallback quote")

/datum/overmap_star_system/safezone/agni
	name = "Value of Public Works"
	starname = "Ecbatana"
	startype = /datum/overmap/star/dwarf
	default_outpost_type = /datum/overmap/outpost/ngr_rock
	faction = /datum/faction/syndicate/ngr

	primary_color = "#d9ad82"
	secondary_color = "#c48c60"

	hazard_primary_color = "#c13623"
	hazard_secondary_color = "#943a43"

	primary_structure_color = "#83db2b"
	secondary_structure_color = "#21a52e"

	overmap_icon_state = "overmap_dark"

	entry_quotes = list(
		"Agni's open to visitors. Feel free to make an approach.",
		"The 2nd Battlegroup is protecting this sector. You're safe.",
		"Welcome brothers and sisters. Safe travels I hope.",
		"Careful on your approach, there's a storm coming in.",
	)



/datum/overmap_star_system/safezone/arrowsong
	name = "High-Pier"
	starname = "Chana"
	startype = /datum/overmap/star/dwarf/orange
	default_outpost_type = /datum/overmap/outpost/clip_ocean
	faction = /datum/faction/clip

	primary_color = "#6fa8de"
	secondary_color = "#96b6d4"

	hazard_primary_color = "#d5e3f0"
	hazard_secondary_color = "#96a6b5"

	primary_structure_color = "#97dfe8"
	secondary_structure_color = "#6fa8de"

	overmap_icon_state = "overmap_dark"
	entry_quotes = list(
		"Arrowsong is monitoring your approach.",
		"Incoming vessel follow flight plan as designated.",
		"Good mark on bluespace wake. Welcome to High-Pier",
		"Tide's out. Come on in.",
		"All vessels refrain from docking at the Supergiant."
	)

	json = '_maps/sectors/chana_starsystem.json'
	generator_type = OVERMAP_GENERATOR_JSON
	has_outpost = FALSE

/datum/overmap_star_system/safezone/trifuge
	name = "Minya"
	starname = "Aubaine"
	startype = /datum/overmap/star/medium
	default_outpost_type = /datum/overmap/outpost/indie_space
	faction = /datum/faction/independent

	primary_color = "#5e5e5e"
	secondary_color = "#242424"

	hazard_primary_color = "#b56060"
	hazard_secondary_color = "#824242"

	primary_structure_color = "#ffffff"
	secondary_structure_color = "#ffffff"

	overmap_icon_state = "overmap"

	entry_quotes = list(
		"Welcome to the Minya League.",
		"Installation Trifuge recieving... welcome home.",
		"Bluespace wake registered. Welcome back.",
		"Watch the skies. Aubaine's bright today.",
		"Someone just lost a bet.",
	)

	json = '_maps/sectors/aubaine_starsystem.json'
	generator_type = OVERMAP_GENERATOR_JSON
	has_outpost = FALSE

/datum/overmap_star_system/safezone/yebiri
	name = "Persei-277"
	starname = "Persei-277"
	startype = /datum/overmap/star/medium
	default_outpost_type = /datum/overmap/outpost/warra_ice
	faction = /datum/faction/warra

	primary_color = "#7e8cd9"
	secondary_color = "#33324a"

	hazard_primary_color = "#ededed"
	hazard_secondary_color = "#7f7db0"

	primary_structure_color = "#4272db"
	secondary_structure_color = "#38a0eb"

	overmap_icon_state = "overmap_dark"

	//these ones need to be better
	entry_quotes = list(
		"Wake detected. Welcome to Persei-277",
		"This area of space is protected by Vigilitas Interstellar",
		"Best value this side of Lanchester",
		"Makosso-Warra extends its greetings",
	)



/datum/overmap_star_system/safezone/thousand_eyes
	name = "Kapche-Legnica"
	starname = "Kapche-Legnica"
	startype = /datum/overmap/star/binary
	default_outpost_type = /datum/overmap/outpost/cybersun_gas_giant

	primary_color = "#00eaff"
	secondary_color = "#4d140f"

	hazard_primary_color = "#972241"
	hazard_secondary_color = "#71a1a9"

	primary_structure_color = "#ffffff"
	secondary_structure_color = "#ffffff"

	entry_quotes = list(
		"One Thousand Eyes watch over you.",
		"Cybersun is not liable for damage caused by stellar objects in-system.",
		"Weather on the Perch is safe for now.",
		"Follow the buoys. Don't get lost.",
		"The Watcher's gaze is on you. Welcome back."
	)

	json = '_maps/sectors/kapche_starsystem.json'
	generator_type = OVERMAP_GENERATOR_JSON
	has_outpost = FALSE

	fun_facts = list(
		"Do not enter the nebula, follow the buoys."
	)

