/datum/overmap_star_system/safezone
	name = "Lymantria Teagarden Memorial sector"
	has_outpost = TRUE

	primary_color = "#ffffdf"
	secondary_color = "#828282"

	hazard_primary_color = "#a2b210"
	hazard_secondary_color = "#5757c5"

	primary_structure_color = "#fbaa51"
	secondary_structure_color = "#fb1010"

	override_object_colors = TRUE
	overmap_icon_state = "overmap"

	max_overmap_dynamic_events = 0


/datum/overmap_star_system/safezone/agni
	name = "Gorlex Controlled - Value of Public Works"
	starname = "Ecbatana"
	startype = /datum/overmap/star/dwarf
	default_outpost_type = /datum/overmap/outpost/ngr_rock

	primary_color = "#d9ad82"
	secondary_color = "#c48c60"

	hazard_primary_color = "#c13623"
	hazard_secondary_color = "#943a43"

	primary_structure_color = "#83db2b"
	secondary_structure_color = "#21a52e"

	overmap_icon_state = "overmap_dark"

/datum/overmap_star_system/safezone/arrowsong
	name = "CLIP Controlled - High-Pier"
	starname = "Chana"
	startype = /datum/overmap/star/dwarf/orange
	default_outpost_type = /datum/overmap/outpost/clip_ocean

	primary_color = "#6fa8de"
	secondary_color = "#96b6d4"

	hazard_primary_color = "#d5e3f0"
	hazard_secondary_color = "#96a6b5"

	primary_structure_color = "#97dfe8"
	secondary_structure_color = "#6fa8de"

	overmap_icon_state = "overmap_dark"

/datum/overmap_star_system/safezone/trifuge
	name = "Independent - Minya"
	starname = "Aubaine"
	startype = /datum/overmap/star/medium
	default_outpost_type = /datum/overmap/outpost/indie_space

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

/datum/overmap_star_system/safezone/yebiri
	name = "Nanotrasen Controlled - Persei-277"
	starname = "Persei-277"
	startype = /datum/overmap/star/medium
	default_outpost_type = /datum/overmap/outpost/nanotrasen_ice

	primary_color = "#7e8cd9"
	secondary_color = "#33324a"

	hazard_primary_color = "#ededed"
	hazard_secondary_color = "#7f7db0"

	primary_structure_color = "#4272db"
	secondary_structure_color = "#38a0eb"

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

	entry_quotes = list(
		"One Thousand Eyes watch over you.",
		"Cybersun is not liable for damage caused by stellar objects in-system.",
		"Weather on the Perch is safe for now.",
		"Follow the buoys. Don't get lost.",
		"Cybersun welcomes you to Thousand Eyes Perch."
	)
