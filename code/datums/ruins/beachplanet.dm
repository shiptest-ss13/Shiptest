// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/beachplanet
	prefix = "_maps/RandomRuins/BeachRuins/"
	ruin_type = RUINTYPE_BEACH

/datum/map_template/ruin/beachplanet/crashedengie
	name = "Crashed Engineer Ship"
	id = "beach_crashed_engineer"
	description = "An abandoned camp built by a crashed engineer"
	suffix = "beach_crashed_engineer.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_HAZARDOUS)
	ruin_mission_types = list(/datum/mission/ruin/lost_axe)

/datum/mission/ruin/lost_axe
	name = "Axe Retrieval"
	desc = "I recently lost a heirloom axe - produced by a very fine Syebenaltch Guild. I was unable to retrieve it when my vessel crashed, and I was rescued. Please bring it home to me."
	mission_limit = 1
	value = 1000
	setpiece_item = /obj/item/melee/axe/fire

/datum/map_template/ruin/beachplanet/ancient
	name = "Ancient Danger"
	id = "beach_ancient"
	description = "As you draw near the ancient wall, a sense of foreboding overcomes you. You aren't sure why, but you feel this dusty structure may contain great dangers."
	suffix = "beach_ancient_ruin.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/beachplanet/scrapvillage
	name = "Pirate Village"
	id = "beach_pirate"
	description = "A small pirate outpost formed from the remains of a wrecked shuttle."
	suffix = "beach_pirate_crash.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)
	ruin_mission_types = list(/datum/mission/ruin/signaled/kill/frontiersmen)

/datum/map_template/ruin/beachplanet/treasurecove
	name = "Treasure Cove"
	id = "beach_treasure_cove"
	description = "A abandoned colony. It seems that this colony was abandoned, for a reason or another"
	suffix = "beach_treasure_cove.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)
	ruin_mission_types = list(/datum/mission/ruin/signaled/kill/frontiersmen)

/datum/map_template/ruin/beachplanet/frontiersmen_depot
	name = "Frontiersmen Depot"
	id = "beach_bunkers"
	description = "A poorly constructed jumble of bunkers, currently held by the Frontiersmen Fleet for usage as a supply depot."
	suffix = "beach_bunkers.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)
	ruin_mission_types = list(
		/datum/mission/ruin/data_retrieval,
		/datum/mission/ruin/signaled/kill/frontiersmen,
		/datum/mission/ruin/multiple/moonshine_crates
	)

/datum/mission/ruin/multiple/moonshine_crates
	name = "Retrieve Booze"
	desc = "So... Uh.. I'm looking for someone to go pick up the alcohol I bought from a local brewer. They said they deliver - but it's been like 3 weeks, and I really need this for a party... Can you go and pick it up from them? It should be in some sealed cases around my brewers's place..."
	author = "Guy Raelman"
	faction = /datum/faction/independent
	value = 1750
	mission_limit = 1
	setpiece_item = /obj/item/storage/bottles/moonshine/sealed
	specific_item = FALSE
	required_count = 3
