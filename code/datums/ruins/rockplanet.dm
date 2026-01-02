// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/rockplanet
	prefix = "_maps/RandomRuins/RockRuins/"

	ruin_type = RUINTYPE_ROCK

/datum/map_template/ruin/rockplanet/shippingdock
	name = "Abandoned Shipping Dock"
	description = "An abandoned shipping dock used by small cargo freighters and smugglers alike. Some malicious group seems to have trapped the place to eliminate scavengers."
	id = "rockplanet_shippingdock"
	suffix = "rockplanet_shippingdock.dmm"

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

/datum/map_template/ruin/rockplanet/rust_base
	name = "ISV Rust Base"
	description = "A crashed Ramzi Clique vessel that has since become an isolated pirate outpost."
	id = "rockplanet_rustbase"
	suffix = "rockplanet_rustbase.dmm"

/datum/map_template/ruin/rockplanet/river_valley_stash
	name = "River Valley Stash"
	description = "A frontiersman drug stash in the midst of being buried."
	id = "rockplanet_river_valley_stash"
	suffix = "rockplanet_river_valley_stash.dmm"

/datum/map_template/ruin/rockplanet/somme
	name = "Frontiersman Trench Complex"
	description = "Frontiersmen have dug in like ticks to the planet's surface."
	id = "rockplanet_somme"
	suffix = "rockplanet_somme.dmm"
