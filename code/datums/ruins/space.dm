// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/space
	prefix = "_maps/RandomRuins/SpaceRuins/"
	cost = 1
	allow_duplicates = FALSE
	ruin_type = RUINTYPE_SPACE

/datum/map_template/ruin/space/corporate_mining
	id = "corporate_mining"
	suffix = "corporate_mining.dmm"
	name = "Corporate Mining Module"
	description = "An old and rusty mining facility, with big ore potential."
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/space/bigderelict1
	id = "bigderelict1"
	suffix = "bigderelict1.dmm"
	name = "Derelict Tradepost"
	description = "A once-bustling tradestation that handled imports and exports from nearby stations now lays eerily dormant. \
	The last received message was a distress call from one of the on-board officers, but we had no success in making contact again."
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/space/onehalf
	id = "onehalf"
	suffix = "onehalf.dmm"
	name = "DK Excavator 453"
	description = "Formerly a thriving planetary mining outpost, now a bit of an exploded mess. One has to wonder how it got here"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/space/power_puzzle
	id = "power_puzzle"
	suffix = "power_puzzle.dmm"
	name = "Power Puzzle"
	description = "an abandoned secure storage location. there is no power left in the batteries and the former ocupants locked it pretty tight before leaving.\
	You will have to power areas to raise the bolts on the doors. look out for secrets."
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/space/astraeus
	id = "astraeus"
	suffix = "astraeus.dmm"
	name = "Astraeus Ruin"
	description = "This vessel served a lengthy period in the Nanotrasen fleet, before an accident in the munitions bay caused to to be destroyed while in active combat."
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/space/singularitylab
	id = "singularitylab"
	suffix = "singularity_lab.dmm"
	name = "Singularity Lab"
	description = "An overgrown facility, home to an unstarted singularity and many plants"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/space/spacemall
	id = "spacemall"
	suffix = "spacemall.dmm"
	name = "Space Mall"
	description = "An old shopping centre, owned by a former member of Nanotrasen's board of directors.."
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER)
