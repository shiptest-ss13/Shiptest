/datum/map_template/ruin/reebe
	prefix = "_maps/RandomRuins/ReebeRuins/"
	allow_duplicates = FALSE
	cost = 5
	ruin_type = RUINTYPE_YELLOW

/datum/map_template/ruin/reebe/clockwork_arena
	name = "Clockcult Arena"
	id = "clockcultarena"
	description = "A abandoned base, once belonging to clock cultists."
	suffix = "reebe_arena.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/reebe/swarmers
	name = "Swarmer Island"
	id = "swarmers"
	description = "Looks like someone has occupied Reebe in the cultists' absence."
	suffix = "reebe_swarmers.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/reebe/island
	name = "Island Cache"
	id = "islandcache"
	description = "Reebe is full of these things. Something is hidden within here."
	suffix = "reebe_floating_island.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/reebe/sm
	name = "Decayed Supermatter"
	id = "smdecay"
	description = "It seems whoever left here was so nice they left very vauluable items behind. How thoughtful."
	suffix = "reebe_decayed_sm.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE, RUIN_TAG_HAZARDOUS)
