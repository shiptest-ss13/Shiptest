// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/whitesands
	prefix = "_maps/RandomRuins/SandRuins/"
	ruin_type = RUINTYPE_SAND

/datum/map_template/ruin/whitesands/medipen_plant
	name = "Abandoned Medipen Factory"
	id = "medipenplant"
	description = "A once prosperous autoinjector manufacturing plant."
	suffix = "whitesands_surface_medipen_plant.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/whitesands/pubbyslopcrash
	name = "Pubby Slop Crash"
	id = "ws-pubbyslopcrash"
	description = "A failed attempt of the Nanotrasen nutrional replacement program"
	suffix = "whitesands_surface_pubbyslopcrash.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/whitesands/cave_base
	name = "Abandoned Cave Base"
	id = "cave_base"
	description = "The former home of a poor sod on observation duty. Now a cunning trap."
	suffix = "whitesands_cave_base.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)

//////////OUTSIDE SETTLEMENTS/RUINS//////////
/datum/map_template/ruin/whitesands/survivors/saloon
	name = "Hermit Saloon"
	id = "ws-saloon"
	description = "A western style saloon, most popular spot for the hermits to gather planetside"
	suffix = "whitesands_surface_camp_saloon.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/whitesands/survivors/combination //combined extra large ruin of several other whitesands survivor ruins
	name = "Wasteland Survivor Village"
	id = "ws-combination"
	description = "A small encampment of nomadic survivors of the First Colony, and their descendants. By all accounts, feral and without allegance to anyone but themselves."
	suffix = "whitesands_surface_camp_combination.dmm"
	allow_duplicates = FALSE
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/whitesands/e11_manufactory
	name = "E-11 Manufacturing Plant"
	id = "ws-e11manufactory"
	description = "An old Eoehoma Firearms manufacturing plant dedicated to assembly of the beloved-by-many E-11 rifle."
	suffix = "whitesands_surface_e11_manufactory.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_HAZARDOUS)
