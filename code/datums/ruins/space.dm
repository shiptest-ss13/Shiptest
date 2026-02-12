// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/space
	prefix = "_maps/RandomRuins/SpaceRuins/"
	cost = 1
	allow_duplicates = FALSE
	ruin_type = RUINTYPE_SPACE

/datum/map_template/ruin/space/singularitylab
	id = "singularitylab"
	suffix = "singularity_lab.dmm"
	name = "Singularity Lab"
	description = "An overgrown facility, home to an inactive singularity and many plants"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/space/spacemall
	id = "spacemall"
	suffix = "spacemall.dmm"
	name = "Space Mall"
	description = "An old shopping centre, owned by a former member of Nanotrasen's board of directors.."
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/space/scrapstation
	id = "scrapstation"
	suffix = "scrapstation.dmm"
	name = "Ramzi Scrapping Station"
	description = "A Syndicate FOB dating back to the ICW, now home to the Ramzi Clique and their latest haul."
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/space/deepstorage
	id = "VI deepstorage"
	suffix = "vi_deepstorage.dmm"
	name = "Vigilitas Deepstorage"
	description = "A Vigilitas blacksite for holding important and suspicious cargo."
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/space/onefull
	id = "onehalftwo"
	suffix = "onehalftwo.dmm"
	name = "Nanotrasen Refueling Station"
	description = "An abandoned Nanotrasen refueling post evacuated after an attempted ACLF plasmaflood. Since then, hivebots and a small Ramzi Clique salvage team have attempted to claim the station."
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)
