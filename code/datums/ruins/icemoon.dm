// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/icemoon
	prefix = "_maps/RandomRuins/IceRuins/"
	ruin_type = RUINTYPE_ICE

/datum/map_template/ruin/icemoon/hydroponicslab
	name = "Hydroponics Lab"
	id = "hydroponicslab"
	description = "An abandoned hydroponics research facility containing hostile plant fauna."
	suffix = "icemoon_hydroponics_lab.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_SHELTER)
	dynamic_mission_types = list(/datum/mission/dynamic/data_reterival)

/datum/map_template/ruin/icemoon/abandonedvillage
	name = "Abandoned Village"
	id = "abandonedvillage"
	description = "Who knows what lies within?"
	suffix = "icemoon_underground_abandoned_village.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_INHOSPITABLE)
	dynamic_mission_types = list(
		/datum/mission/dynamic/data_reterival,
		/datum/mission/dynamic/signaled/drill
	)

/datum/map_template/ruin/icemoon/brazillian_lab
	name = "Barricaded Compound"
	id = "brazillian-lab"
	description = "A conspicuous compound in the middle of the cold wasteland. What goodies are inside?"
	suffix = "icemoon_underground_brazillianlab.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_INHOSPITABLE)
	dynamic_mission_types = list(/datum/mission/dynamic/data_reterival)

/datum/map_template/ruin/icemoon/crashed_holemaker
	name = "Crashed Holemaker"
	id = "crashed_holemaker"
	description = "Safety records for early Nanotrasen Spaceworks vessels were, and always have been, top of their class. Absolutely no multi-billion credit projects have been painstakingly erased from history. (Citation Needed)"
	suffix = "icemoon_crashed_holemaker.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_SHELTER)
	dynamic_mission_types = list(/datum/mission/dynamic/data_reterival)

/datum/map_template/ruin/icemoon/ice_lodge
	name = "Ice Lodge"
	id = "ice_lodge"
	description = "Records show this settlement as belonging to the SRM, but no one has heard from them as of late. I wonder what happened?"
	suffix = "icemoon_ice_lodge.dmm"
	ruin_tags = list(RUIN_TAG_HARD_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)
	dynamic_mission_types = list(/datum/mission/dynamic/fallen_montagne)

/datum/mission/dynamic/fallen_montagne
	name = "dark signal investigation"
	desc = "We've lost contact with one of our lodges but there signal has gone dark. We suspect they may have been assulted by a hostile faction. If they are KIA please retrive the Montagne's body."
	mission_reward = /obj/structure/fermenting_barrel/trickwine
	faction = /datum/faction/srm
	setpiece_item = /mob/living/carbon/human
