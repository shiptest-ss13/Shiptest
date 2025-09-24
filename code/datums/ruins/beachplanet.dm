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
	ruin_mission_types = list(/datum/mission/ruin/signaled/kill/frontiersmen)

/datum/map_template/ruin/beachplanet/frontie_moat
	name = "Frontiersman Moat"
	id = "beach_frontie_moat"
	description = "A frontiersman-built moat village. Not the worst place to live."
	suffix = "beach_frontie_moat.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)
	ruin_mission_types = list(/datum/mission/ruin/minutecorpse)

/datum/mission/ruin/minutecorpse
	name = "Bro's gone."
	desc = "One of my pals, great person, recently enlisted into the minutemen as some vehicle dude or whatever. Said they were going on some scouting mission here, haven't heard a response from them in about a week. Think you could find out what happened, and get something for their family?"
	value = 2250
	mission_limit = 1
	author = "A friend."
	faction = /datum/faction/clip
	setpiece_item = /mob/living/carbon/human

/datum/map_template/ruin/beachplanet/gunsmith
	name = "Cave Gunsmith"
	id = "beach_gunsmith"
	description = "A decadent gunsmithing den jointly owned by an outfit of the Ramzi Clique and a corrupt NGR official. Hidden within a cave."
	suffix = "beach_gunsmith.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)
	ruin_mission_types = list(
		/datum/mission/ruin/ngrdocs,
	)

/datum/mission/ruin/ngrdocs
	name = "Investigate Suspicious Site"
	desc = "The New Gorlex Republic is suspicious of a nearby site, many missing Scarborough surplus shipments has been traced back to what is suspected to be a Ramzi Clique hideout. Find any manifests and secure them at the local outpost. Expect entrenched resistance, few in number."
	author = "New Gorlex Republic Customs"
	faction = /datum/faction/syndicate/ngr
	value = 1250
	mission_limit = 1
	setpiece_item = /obj/item/documents/syndicate/ngr

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
