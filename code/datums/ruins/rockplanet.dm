// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/rockplanet
	prefix = "_maps/RandomRuins/RockRuins/"

	ruin_type = RUINTYPE_ROCK

/datum/map_template/ruin/rockplanet/harmfactory
	name = "Harm Factory"
	description = "A factory made for HARM and AGONY."
	id = "rockplanet_harmfactory"
	suffix = "rockplanet_harmfactory.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/rockplanet/budgetcuts
	name = "Budgetcuts"
	description = "Nanotrasen's gotta lay off some personnel, and this facility hasn't been worth the effort so far"
	id = "rockplanet_budgetcuts"
	suffix = "rockplanet_budgetcuts.dmm"
	ruin_tags = list(RUIN_TAG_HARD_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/rockplanet/shippingdock
	name = "Abandoned Shipping Dock"
	description = "An abandoned shipping dock used by small cargo freighters and smugglers alike. Some malicious group seems to have trapped the place to eliminate scavengers."
	id = "rockplanet_shippingdock"
	suffix = "rockplanet_shippingdock.dmm"

/datum/map_template/ruin/rockplanet/nomadcrash
	name = "Nomad Crash"
	description = "A Crashed Arrow & Axe Interceptor. A long forgotten Crew. They tried their best to survive..."
	id = "rockplanet_nomadcrash"
	suffix = "rockplanet_nomadcrash.dmm"

/datum/map_template/ruin/rockplanet/distillery
	name = "Frontiersman Distillery"
	description = "A former pre-ICW era Nanotrasen outpost converted into a moonshine distillery by Frontiersman bootleggers."
	id = "rockplanet_distillery"
	suffix = "rockplanet_distillery.dmm"

/datum/map_template/ruin/rockplanet/mining_base
	name = "N+S Mining Installation"
	description = "A N+S mining installation recently fallen prey to a band of Ramzi pirates."
	id = "rockplanet_mining_base"
	suffix = "rockplanet_mining_installation.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)
