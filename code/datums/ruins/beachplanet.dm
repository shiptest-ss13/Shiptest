// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/beachplanet
	prefix = "_maps/RandomRuins/BeachRuins/"
	ruin_type = RUINTYPE_BEACH

/datum/map_template/ruin/beachplanet/fishinghut
	name = "Fishing Hut"
	id = "fishinghut"
	description = "A small fishing hut floating on the ocean."
	suffix = "beach_fishing_hut.dmm"
	ruin_tags = list(RUIN_TAG_HARD_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/beachplanet/ancient
	name = "Ancient Danger"
	id = "beach_ancient"
	description = "As you draw near the ancient wall, a sense of foreboding overcomes you. You aren't sure why, but you feel this dusty structure may contain great dangers."
	suffix = "beach_ancient_ruin.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/beachplanet/town
	name = "Beachside Town"
	id = "beach_town"
	description = "A fresh town on a lovely coast, where its inhabitants are is unknown."
	suffix = "beach_ocean_town.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/beachplanet/scrapvillage
	name = "Pirate Village"
	id = "beach_pirate"
	description = "A small pirate outpost formed from the remains of a wrecked shuttle."
	suffix = "beach_pirate_crash.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/beachplanet/treasurecove
	name = "Treasure Cove"
	id = "beach_treasure_cove"
	description = "A abandoned colony. It seems that this colony was abandoned, for a reason or another"
	suffix = "beach_treasure_cove.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/beachplanet/crashedengie
	name = "Crashed Engineer Ship"
	id = "beach_crashed_engineer"
	description = "An abandoned camp built by a crashed engineer"
	suffix = "beach_crashed_engineer.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/beachplanet/floatresort
	name = "Floating Beach Resort"
	id = "beach_float_resort"
	description = "A hidden paradise on the beach"
	suffix = "beach_float_resort.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_LIVEABLE)
