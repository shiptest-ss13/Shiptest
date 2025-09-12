// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/icemoon
	prefix = "_maps/RandomRuins/IceRuins/"
	ruin_type = RUINTYPE_ICE

/datum/map_template/ruin/icemoon/abandonedvillage
	name = "Abandoned Village"
	id = "abandonedvillage"
	description = "Who knows what lies within?"
	suffix = "icemoon_underground_abandoned_village.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_INHOSPITABLE)
	ruin_mission_types = list(
		/datum/mission/ruin/data_retrieval,
		/datum/mission/ruin/signaled/drill
	)

/datum/map_template/ruin/icemoon/crashed_holemaker
	name = "Crashed Holemaker"
	id = "crashed_holemaker"
	description = "Safety records for early Nanotrasen Spaceworks vessels were, and always have been, top of their class. Absolutely no multi-billion credit projects have been painstakingly erased from history. (Citation Needed)"
	suffix = "icemoon_crashed_holemaker.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_SHELTER)
	ruin_mission_types = list(/datum/mission/ruin/data_retrieval)

/datum/map_template/ruin/icemoon/ice_lodge
	name = "Ice Lodge"
	id = "ice_lodge"
	description = "Records show this settlement as belonging to the SRM, but no one has heard from them as of late. I wonder what happened?"
	suffix = "icemoon_ice_lodge.dmm"
	ruin_tags = list(RUIN_TAG_HARD_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)
//	ruin_mission_types = list(/datum/mission/ruin/fallen_montagne)

/datum/mission/ruin/fallen_montagne
	name = "dark signal investigation"
	desc = "A hunting lodge located on an ice-world in system has recently ceased communication. We suspect they may have been assulted by pirates. If this is the case, and they have fallen, bring the Montague's corpse, so they may be buried properly."
	value = 3000
	mission_limit = 1
	mission_reward = /obj/structure/fermenting_barrel/trickwine
	faction = /datum/faction/srm
	setpiece_item = /mob/living/carbon/human

/datum/map_template/ruin/icemoon/tesla_lab
	name = "CLIP Research Lab"
	id = "tesla_lab"
	description = "CLIP has recently lost contact with one of it's Anomaly Research Labs. Reports suggest the frontiersmen may have been behind it."
	suffix = "icemoon_tesla_lab.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)
/*	ruin_mission_types = list(
		/datum/mission/ruin/blackbox,
		/datum/mission/ruin/daughter
	)
*/

/datum/mission/ruin/daughter
	name = "find our daughter!"
	desc = "Our daughter was recently deployed out to the Frontier - and we haven't heard from her, or the Minutemen - or anyone in weeks! Please find her and make sure she's okay..."
	value = 2000
	mission_limit = 1
	author = "Concerned Parents"
	faction = /datum/faction/clip
	mission_reward = /obj/item/gun/ballistic/automatic/smg/cm5/compact
	setpiece_item = /mob/living/carbon/human

/datum/map_template/ruin/icemoon/training_facility
	name = "Ramzi-controlled Training Facility"
	id = "training_facility"
	description = "An abandoned training facility located on this ice-world dating back to the early days of the ICW. Strangely, it still seems to be inhabited."
	suffix = "icemoon_training_center.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS, RUIN_TAG_LAVA)

