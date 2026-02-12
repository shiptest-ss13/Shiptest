// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/beachplanet
	prefix = "_maps/RandomRuins/BeachRuins/"
	ruin_type = RUINTYPE_BEACH

/datum/map_template/ruin/beachplanet/ancient
	name = "Ancient Danger"
	id = "beach_ancient"
	description = "As you draw near the ancient wall, a sense of foreboding overcomes you. You aren't sure why, but you feel this dusty structure may contain great dangers."
	suffix = "beach_ancient_ruin.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/beachplanet/treasurecove
	name = "Treasure Cove"
	id = "beach_treasure_cove"
	description = "A abandoned colony. It seems that this colony was abandoned, for a reason or another"
	suffix = "beach_treasure_cove.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/beachplanet/frontie_moat
	name = "Frontiersman Moat"
	id = "beach_frontie_moat"
	description = "A frontiersman-built moat village. Not the worst place to live."
	suffix = "beach_frontie_moat.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/beachplanet/gunsmith
	name = "Cave Gunsmith"
	id = "beach_gunsmith"
	description = "A decadent gunsmithing den jointly owned by an outfit of the Ramzi Clique and a corrupt NGR official. Hidden within a cave."
	suffix = "beach_gunsmith.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/beachplanet/frontiersmen_depot
	name = "Frontiersmen Depot"
	id = "beach_bunkers"
	description = "A poorly constructed jumble of bunkers, currently held by the Frontiersmen Fleet for usage as a supply depot."
	suffix = "beach_bunkers.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)
