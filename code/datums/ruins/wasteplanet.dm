// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/wasteplanet
	prefix = "_maps/RandomRuins/WasteRuins/"
	ruin_type = RUINTYPE_WASTE

/datum/map_template/ruin/wasteplanet/weaponstest
	name = "Weapons testing facility"
	id = "guntested"
	description = "A abandoned Nanotrasen weapons facility, presumably the place where the X-01 was manufactured."
	suffix = "wasteplanet_lab.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/wasteplanet/pandora
	id = "pandora_arena"
	suffix = "wasteplanet_pandora.dmm"
	name = "Pandora Arena"
	description = "Some... thing has settled here."
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_MEGAFAUNA, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/wasteplanet/radiation
	name = "Honorable deeds storage"
	id = "wasteplanet_radiation"
	description = "A dumping ground for nuclear waste."
	suffix = "wasteplanet_unhonorable.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/wasteplanet/abandoned_mechbay
	name = "Abandoned Exosuit Bay"
	description = "A military base formerly used for staging 4 exosuits and crew. God knows what's in it now."
	id = "abandoned_mechbay"
	suffix = "wasteplanet_abandoned_mechbay.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/wasteplanet/tradepost
	name = "Ruined Tradepost"
	description = "Formerly a functioning, if not thriving tradepost. Now a graveyard of Inteq soldiers and hivebots."
	id = "wasteplanet_tradepost"
	suffix = "wasteplanet_tradepost.dmm"

/datum/map_template/ruin/wasteplanet/yard
	name = "Abandoned Miskilamo salvage yard"
	description = "An abandonded shipbreaking yard."
	id = "wasteplanet_yard"
	suffix = "wasteplanet_yard.dmm"

	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)
