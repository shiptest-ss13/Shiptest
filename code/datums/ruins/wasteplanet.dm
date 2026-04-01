// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/wasteplanet
	prefix = "_maps/RandomRuins/WasteRuins/"
	ruin_type = RUINTYPE_WASTE

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

/datum/map_template/ruin/wasteplanet/icwbase
	name = "ICW Era Comms and Medical base"
	description = "A former Syndicate Coalition base during the ICW, left to waste. It seems it has some new residents.."
	id = "wasteplanet_icwbase"
	suffix = "wasteplanet_icwbase.dmm"

	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/wasteplanet/facility
	name = "Salvage Facility"
	description = "A salvage collection & processing facility which was abandoned by its sole proprietor, following a corporate dissolution."
	id = "wasteplanet_facility"
	suffix = "wasteplanet_facility.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/wasteplanet/recycling
	name = "Recycling Facility"
	description = "A rusty salvaging and recycling base made to supply some unsavory people."
	id = "wasteplanet_recyclebay"
	suffix = "wasteplanet_recyclebay.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

