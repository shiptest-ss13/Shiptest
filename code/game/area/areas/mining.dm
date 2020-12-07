/**********************Mine areas**************************/

/area/mine
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	lighting_colour_tube = "#ffe8d2"
	lighting_colour_bulb = "#ffdcb7"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED

/area/mine/explored
	name = "Mine"
	icon_state = "explored"
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	flags_1 = NONE
	ambientsounds = MINING
	area_flags = VALID_TERRITORY | UNIQUE_AREA
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/mine/unexplored
	name = "Mine"
	icon_state = "unexplored"
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	flags_1 = NONE
	ambientsounds = MINING
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED | CAVES_ALLOWED

/area/mine/lobby
	name = "Mining Station"
	icon_state = "mining_lobby"

/area/mine/storage
	name = "Mining Station Storage"
	icon_state = "mining_storage"

/area/mine/production
	name = "Mining Station Starboard Wing"
	icon_state = "mining_production"

/area/mine/abandoned
	name = "Abandoned Mining Station"

/area/mine/living_quarters
	name = "Mining Station Port Wing"
	icon_state = "mining_living"

/area/mine/eva
	name = "Mining Station EVA"
	icon_state = "mining_eva"

/area/mine/maintenance
	name = "Mining Station Communications"
	lighting_colour_tube = "#edfdff"
	lighting_colour_bulb = "#dafffd"

/area/mine/cafeteria
	name = "Mining Station Cafeteria"
	icon_state = "mining_labor_cafe"

/area/mine/hydroponics
	name = "Mining Station Hydroponics"
	icon_state = "mining_labor_hydro"

/area/mine/sleeper
	name = "Mining Station Emergency Sleeper"

/area/mine/laborcamp
	name = "Labor Camp"
	icon_state = "mining_labor"

/area/mine/laborcamp/security
	name = "Labor Camp Security"
	icon_state = "security"
	ambientsounds = HIGHSEC




/**********************Lavaland Areas**************************/

/area/lavaland
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_AREA_LAVALAND

/area/lavaland/surface
	name = "Lavaland"
	icon_state = "explored"
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING

/area/lavaland/underground
	name = "Lavaland Caves"
	icon_state = "unexplored"
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambientsounds = MINING


/area/lavaland/surface/outdoors
	name = "Lavaland Wastes"
	outdoors = TRUE

/area/lavaland/surface/outdoors/unexplored //monsters and ruins spawn here
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/lavaland

/area/lavaland/surface/outdoors/unexplored/danger //megafauna will also spawn here
	icon_state = "danger"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED

/area/lavaland/surface/outdoors/explored
	name = "Lavaland Labor Camp"
	area_flags = VALID_TERRITORY | UNIQUE_AREA



/**********************Ice Moon Areas**************************/

/area/icemoon
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_AREA_ICEMOON

/area/icemoon/surface
	name = "Icemoon"
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED

/area/icemoon/surface/outdoors // weather happens here
	name = "Icemoon Wastes"
	outdoors = TRUE

/area/icemoon/surface/outdoors/labor_camp
	name = "Icemoon Labor Camp"
	poweralm = FALSE
	area_flags = UNIQUE_AREA

/area/icemoon/surface/outdoors/unexplored //monsters and ruins spawn here
	icon_state = "unexplored"
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | CAVES_ALLOWED
	map_generator = /datum/map_generator/cave_generator/icemoon/surface

/area/icemoon/surface/outdoors/unexplored/danger
	icon_state = "unexplored"
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | CAVES_ALLOWED

/area/icemoon/surface/outdoors/unexplored/rivers // rivers spawn here
	icon_state = "danger"

/area/icemoon/surface/outdoors/unexplored/rivers/no_monsters
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED | CAVES_ALLOWED

/area/icemoon/underground
	name = "Icemoon Caves"
	outdoors = TRUE
	always_unpowered = TRUE
	requires_power = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambientsounds = MINING
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	map_generator = /datum/map_generator/cave_generator/icemoon

/area/icemoon/underground/unexplored // mobs and megafauna and ruins spawn here
	name = "Icemoon Caves"
	icon_state = "danger"
	poweralm = FALSE
	area_flags = CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED

/area/icemoon/underground/explored // ruins can't spawn here
	name = "Icemoon Underground"
	poweralm = FALSE
	area_flags = UNIQUE_AREA



/**********************Whitesands Areas**************************/

/area/whitesands
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED

/area/whitesands/colony
	name = "Whitesands Colony"

/area/whitesands/colony/guard
	name = "Whitesands Colony Guard Post"
	icon_state = "security"

/area/whitesands/colony/dormitory
	name = "Whitesands Colony Dormitory"
	icon_state = "mining_living"
/area/whitesands/colony/dormitory/one
	name = "Whitesands Colony Dormitory One"

/area/whitesands/colony/dormitory/two
	name = "Whitesands Colony Dormitory Two"

/area/whitesands/colony/greenhouse
	name = "Whitesands Colony Greenhouse"
	icon_state = "mining_labor_hydro"

/area/whitesands/colony/production
	name = "Whitesands Colony Ore Refinement Plant"
	icon_state = "mining_production"

/area/whitesands/colony/maintenance
	name = "Whitesands Colony Communications"

/area/whitesands/colony/shuttle_consoles
	name = "Whitesands Colony Shuttle Landing Zone"

/area/whitesands/surface
	name = "Whitesands"
	icon_state = "explored"
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING
	dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	map_generator = /datum/map_generator/cave_generator/whitesands

/area/whitesands/surface/outdoors // weather happens here
	name = "Whitesands Dunes"
	outdoors = TRUE

/area/whitesands/surface/outdoors/explored
	icon_state = "explored"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED | MOB_SPAWN_ALLOWED

/area/whitesands/surface/outdoors/unexplored //monsters and ruins spawn here
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED

/area/whitesands/surface/outdoors/unexplored/danger //megafauna will also spawn here
	icon_state = "danger"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED
