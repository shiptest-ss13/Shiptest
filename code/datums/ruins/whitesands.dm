// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/whitesands
	prefix = "_maps/RandomRuins/SandRuins/"
	ruin_type = RUINTYPE_SAND

/datum/map_template/ruin/whitesands/starfury_crash
	name = "Starfury Crash"
	id = "starfurycrash"
	description = "The remains of an unidentified syndicate battleship has crashed here."
	suffix = "whitesands_surface_starfurycrash.dmm"
	allow_duplicates = FALSE
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_ANTAG_GEAR, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/whitesands/medipen_plant
	name = "Abandoned Medipen Factory"
	id = "medipenplant"
	description = "A once prosperous autoinjector manufacturing plant."
	suffix = "whitesands_surface_medipen_plant.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/whitesands/assaultpodcrash
	name = "Crashed Syndicate Assault Drop Pod"
	id = "ws-assaultpodcrash"
	description = "The fauna of desert planets can be deadly even to equipped Syndicate Operatives."
	suffix = "whitesands_surface_assaultpodcrash.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/whitesands/conveniencestore
	name = "Conveniently Abandoned Convenience Store"
	id = "ws-conveniencestore"
	description = "Pretty convenient that they have a convenience store out here, huh?"
	suffix = "whitesands_surface_conveniencestore.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/whitesands/onlyaspoonful
	name = "Abandoned Spoon Factory"
	id = "ws-onlyaspoonful"
	description = "Literally a fucking spoon factory"
	suffix = "whitesands_surface_onlyaspoonful.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_ANTAG_GEAR, RUIN_TAG_SHELTER)

/datum/map_template/ruin/whitesands/chokepoint
	name = "Chokepoint"
	id = "ws-chokepoint"
	description = "Some sort of survivors, brandishing old nanotrasen security gear."
	suffix = "whitesands_surface_chokepoint.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/whitesands/pubbyslopcrash
	name = "Pubby Slop Crash"
	id = "ws-pubbyslopcrash"
	description = "A failed attempt of the Nanotrasen nutrional replacement program"
	suffix = "whitesands_surface_pubbyslopcrash.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)

//////////OUTSIDE SETTLEMENTS/RUINS//////////
/datum/map_template/ruin/whitesands/survivors/drugstore
	name = "Abandoned Store"
	id = "ws-drugstore"
	description = "A store that once sold a variety of items and equipment."
	suffix = "whitesands_surface_camp_drugstore.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/whitesands/survivors/saloon
	name = "Hermit Saloon"
	id = "ws-saloon"
	description = "A western style saloon, most popular spot for the hermits to gather planetside"
	suffix = "whitesands_surface_camp_saloon.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/whitesands/survivors/combination //combined extra large ruin of several other whitesands survivor ruins (excludes the drugstore)
	name = "Wasteland Survivor Village"
	id = "ws-combination"
	description = "A small encampment of nomadic survivors of the First Colony, and their descendants. By all accounts, feral and without allegance to anyone but themselves."
	suffix = "whitesands_surface_camp_combination.dmm"
	allow_duplicates = FALSE
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE, RUIN_TAG_HAZARDOUS)

