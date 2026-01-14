// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/whitesands
	prefix = "_maps/RandomRuins/SandRuins/"
	ruin_type = RUINTYPE_SAND

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

/datum/map_template/ruin/whitesands/e11_manufactory
	name = "E-11 Manufacturing Plant"
	id = "ws-e11manufactory"
	description = "An old Eoehoma Firearms manufacturing plant dedicated to assembly of the beloved-by-many E-11 rifle."
	suffix = "whitesands_surface_e11_manufactory.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/whitesands/brazillian_lab
	name = "Hermit Weapons-Testing Compound"
	id = "brazillian-lab"
	description = "A conspicuous compound in the middle of the sandy wasteland. What goodies are inside?"
	suffix = "whitesands_brazillianlab.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/whitesands/nomads_stop
	name = "Nomad's Stop"
	id = "nomad-stop"
	description = "A set of structures born of ancient prefabs and quick-pour cement, turned into a place for trade on the planet's surface."
	suffix = "whitesands_nomads_stop.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_HAZARDOUS, RUIN_TAG_SHELTER)

/datum/map_template/ruin/whitesands/settlement_raid
	name = "Settlement Raid"
	id = "settlement-raid"
	description = "A settlement leading a solitary salvaging life under the direction of a former Gorlex Marauder, now being raided by the brutal Frontiersmen Fleet."
	suffix = "whitesands_settlement_raid.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)

