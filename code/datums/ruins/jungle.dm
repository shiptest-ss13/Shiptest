// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/jungle
	prefix = "_maps/RandomRuins/JungleRuins/"
	ruin_type = RUINTYPE_JUNGLE

/datum/map_template/ruin/jungle/syndicate
	name = "Jungle ICW-era Bunker"
	id = "syndicatebunkerjungle"
	description = "An ICW-era nuclear bunker formerly operated by the Gorlex Marauders, now inhabited by the Ramzi Clique."
	suffix = "jungle_syndicate.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/interceptor
	name = "Old Crashed Interceptor"
	id = "crashedcondor"
	description = "An overgrown crashed Condor Class, a forgotten remnant of the Corporate Wars."
	suffix = "jungle_interceptor.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/paradise
	name = "Hidden paradise"
	id = "paradise"
	description = "a crashed shuttle, and a hidden beautiful lake."
	suffix = "jungle_paradise.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/jungle/airbase
	name = "Abandoned Airbase"
	id = "airbase"
	description = "An abandoned airbase dating back to the ICW, partially scuttled, and moved right back into by the Ramzi Clique."
	suffix = "jungle_bombed_starport.dmm"
	ruin_tags = list(RUIN_TAG_HARD_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_HAZARDOUS, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/cavecrew
	name = "Frontiersmen Cave"
	id = "cavecrew"
	description = "A frontiersmen base, hidden within a cave. They don't seem friendly"
	suffix = "jungle_cavecrew.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_HAZARDOUS, RUIN_TAG_LIVEABLE, RUIN_TAG_MAJOR_LOOT)

/datum/map_template/ruin/jungle/serene_hunts
	name = "Serene Hunts"
	id = "serene-hunts"
	description = "Serene Outdoor's premier hunting resort and outlet. Well, it was until all the animals got out anyways."
	suffix = "jungle_serene_hunts.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE, RUIN_TAG_HAZARDOUS)
