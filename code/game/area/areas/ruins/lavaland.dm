//Lavaland Ruins

// Beach

/area/ruin/powered/beach
	icon_state = "dk_yellow"

// Snow Biodome

/area/ruin/powered/snow_biodome
	icon_state = "dk_yellow"

//Gluttony

/area/ruin/powered/gluttony
	icon_state = "dk_yellow"

//Golem Ship

/area/ruin/powered/golem_ship
	name = "Free Golem Ship"
	icon_state = "dk_yellow"

//Hierophant Arena

/area/ruin/unpowered/hierophant
	name = "Hierophant's Arena"
	icon_state = "dk_yellow"

//Seed Vault

/area/ruin/powered/seedvault
	icon_state = "dk_yellow"

//Elephant Graveyard

/area/ruin/unpowered/elephant_graveyard
	name = "Elephant Graveyard"
	icon_state = "dk_yellow"

/area/ruin/powered/graveyard_shuttle
	name = "Elephant Graveyard"
	icon_state = "green"

//Syndicate Comms Outpost

/area/ruin/unpowered/syndicate_outpost
	name = "Syndicate Comm Outpost"
	icon_state = "dk_yellow"

//Syndicate Lava Base (I have no idea what this is)
/area/ruin/unpowered/syndicate_lava_base
	name = "Secret Base"
	icon_state = "dk_yellow"
	ambientsounds = HIGHSEC

//Cult Altar

/area/ruin/unpowered/cultaltar
	name = "Cult Altar"
	ambientsounds = SPOOKY

//Syndicate lavaland base

/area/ruin/unpowered/syndicate_lava_base/engineering
	name = "Syndicate Lavaland Engineering"

/area/ruin/unpowered/syndicate_lava_base/medbay
	name = "Syndicate Lavaland Medbay"

/area/ruin/unpowered/syndicate_lava_base/arrivals
	name = "Syndicate Lavaland Arrivals"

/area/ruin/unpowered/syndicate_lava_base/bar
	name = "Syndicate Lavaland Bar"

/area/ruin/unpowered/syndicate_lava_base/main
	name = "Syndicate Lavaland Primary Hallway"
	area_flags = HIDDEN_AREA | BLOBS_ALLOWED | UNIQUE_AREA // WS edit - Fix various startup runtimes

/area/ruin/unpowered/syndicate_lava_base/cargo
	name = "Syndicate Lavaland Cargo Bay"

/area/ruin/unpowered/syndicate_lava_base/chemistry
	name = "Syndicate Lavaland Chemistry"

/area/ruin/unpowered/syndicate_lava_base/virology
	name = "Syndicate Lavaland Virology"

/area/ruin/unpowered/syndicate_lava_base/testlab
	name = "Syndicate Lavaland Experimentation Lab"

/area/ruin/unpowered/syndicate_lava_base/dormitories
	name = "Syndicate Lavaland Dormitories"

/area/ruin/unpowered/syndicate_lava_base/telecomms
	name = "Syndicate Lavaland Telecommunications"

//Xeno Nest

/area/ruin/unpowered/xenonest
	name = "The Hive"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	poweralm = FALSE

// Crashed Pinnance

/area/ruin/unpowered/crashsite
	name = "Crash Site"
	icon_state = "green"

/area/ruin/unpowered/crashsite/pinnance
	name = "Pinnace Wreckage"
	icon_state = "dk_yellow"
	always_unpowered = TRUE

/area/ruin/unpowered/codelab
	name = "Nanotrasen Genetic Research Facility"
	icon_state = "bluenew"

/area/ruin/unpowered/codelab/exterior
	name = "Nanotrasen Genetic Research Facility Exterior"

/area/ruin/unpowered/codelab/reception
	name = "Nanotrasen Genetic Research Reception"
	icon_state = "green"

/area/ruin/unpowered/codelab/subjectrooms
	name = "Nanotrasen Genetic Research Test Subject Storage"
	icon_state = "Sleep"

/area/ruin/unpowered/codelab/storage
	name = "Nanotrasen Genetic Research Storage"
	icon_state = "cargo_bay"

/area/ruin/unpowered/codelab/laboratory
	name = "Nanotrasen Genetic Research Laboratory"
	icon_state = "bridge"

/area/ruin/unpowered/codelab/maintenance
	name = "Nanotrasen Genetic Research Maintenance"
	icon_state = "dk_yellow"
