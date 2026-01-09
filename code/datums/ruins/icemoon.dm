// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/icemoon
	prefix = "_maps/RandomRuins/IceRuins/"
	ruin_type = RUINTYPE_ICE

/datum/map_template/ruin/icemoon/ice_lodge
	name = "Ice Lodge"
	id = "ice_lodge"
	description = "Records show this settlement as belonging to the SRM, but no one has heard from them as of late. I wonder what happened?"
	suffix = "icemoon_ice_lodge.dmm"
	ruin_tags = list(RUIN_TAG_HARD_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/icemoon/tesla_lab
	name = "CLIP Research Lab"
	id = "tesla_lab"
	description = "CLIP has recently lost contact with one of it's Anomaly Research Labs. Reports suggest the frontiersmen may have been behind it."
	suffix = "icemoon_tesla_lab.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/icemoon/training_facility
	name = "Ramzi-controlled Training Facility"
	id = "training_facility"
	description = "An abandoned training facility located on this ice-world dating back to the early days of the ICW. Strangely, it still seems to be inhabited."
	suffix = "icemoon_training_center.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS, RUIN_TAG_LAVA)

/datum/map_template/ruin/icemoon/downed_transport
	name = "Downed Transport"
	id = "downed_transport"
	description = "There's been reports of a number of unmarked structures on a nearby ice world and what's more, a Gezenan transport just went missing in orbit."
	suffix = "icemoon_downed_transport.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)
