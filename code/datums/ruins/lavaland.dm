// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/lavaland
	prefix = "_maps/RandomRuins/LavaRuins/"
	ruin_type = RUINTYPE_LAVA

/datum/map_template/ruin/lavaland/biodome/winter
	name = "Solarian Winter Biodome"
	id = "biodome-winter"
	description = "A Solarian frontier research facility created by the Pionierskompanien \
	This one seems to simulate the wintery climate of the northern provinces, including a sauna!"
	suffix = "lavaland_surface_biodome_winter.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/lavaland/buried_shrine
	name = "Buried Shrine"
	id = "buried_shrine"
	description = "An ancient temple belonging to some long-gone inhabitants, wrecked and buried by the volcanic activity of it's home planet."
	suffix = "lavaland_surface_buried_shrine.dmm"

/datum/map_template/ruin/lavaland/wrecked_factory
	name = "Wrecked Factory"
	id = "wreck_factory"
	description = "A Makosso-Warra processing facility, assaulted by a pirate raid that has killed most of the staff. The offices however, remain unbreached for now."
	suffix = "lavaland_surface_wrecked_factory.dmm"

/datum/map_template/ruin/lavaland/fallenstar
	name = "Crashed Starwalker"
	id = "crashed_star"
	description = "A crashed pirate ship. It would seem that it's crew died a while ago."
	suffix = "lavaland_crashed_starwalker.dmm"

/datum/map_template/ruin/lavaland/abandonedlisteningpost
	name = "Abandoned Listening Post"
	id = "abandonedlistening"
	description = "An abandoned Cybersun listening post. Seems like the Ramzi Clique has an interest in the site."
	suffix = "lavaland_abandonedlisteningpost.dmm"
	ruin_mission_types = list(
		/datum/mission/ruin/syndicate_docs,
		/datum/mission/ruin/blackbox
	)

/datum/mission/ruin/syndicate_docs
	name = "Virtual Solutions Asset Retrieval"
	author = "Cybersun Virtual Solutions"
	desc = "Several listening posts previously belonging to Coalition operations during the ICW went dark. We'd like you to retrieve any classified information within their secure data safe, and to do this quietly. We'll pay you well."
	faction = list(
		/datum/faction/nt,
		/datum/faction/syndicate/cybersun
	)
	value = 3500
	mission_limit = 1
	setpiece_item = /obj/item/documents/syndicate

/datum/mission/ruin/syndicate_docs/generate_mission_details()
	. = ..()
	if(faction == /datum/faction/makossowarra)
		name = "Vigilitas Data Collection"
		author = "Vigilitas Interstellar"
		desc = "We've been made aware of a listening post operating within this section of space that may contain information of interest to the Company. We'll pay you well if you bring them to us."
	if(faction == /datum/faction/syndicate/cybersun)
		name = "Virtual Solutions Asset Retrieval"
		author = "Cybersun Virtual Solutions"
		desc = "A recent audit has revealed the location of a Coalition listening post yet to be fully decommissioned. We'd like you to retrieve any classified information within their secure data safe, and to do this quietly. We'll pay you well."
