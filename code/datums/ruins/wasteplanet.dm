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
	ruin_mission_types = list(
		/datum/mission/ruin/data_retrieval,
		/datum/mission/ruin/my_mech
	)

/datum/mission/ruin/my_mech
	name = "Lucky #2"
	desc = "Lemme tell you a quick lil story - back when the ICW was winding down, I was stationed out in a waste world, ready to scramble out with the rest of my lance at a moment's notice. Word never came, and eventually, we all went home. But. I still have that longing to pilot in me. Can you go check these coords, and see if my suit, Lucky #2, is still there? If she is, I want her back."
	author = "Bernard Lytton"
	value = 15000
	setpiece_item = /obj/mecha/combat/gygax/dark

/datum/map_template/ruin/wasteplanet/tradepost
	name = "Ruined Tradepost"
	description = "Formerly a functioning, if not thriving tradepost. Now a graveyard of Inteq soldiers and hivebots."
	id = "wasteplanet_tradepost"
	suffix = "wasteplanet_tradepost.dmm"
	ruin_mission_types = list(
		/datum/mission/ruin/dead_vanguard
	)

/datum/mission/ruin/dead_vanguard
	name = "Retrieve Fallen Vanguard"
	desc = "The IRMG has lost contact with one of it's contractees, and the associated Vanguard. All IRMG persons in the area are either already on-assignment, or unavailable. The IRMG is willing to contract out the retrieval of Vanguard Kavur's corpse to any entity in system."
	faction = /datum/faction/inteq
	value = 6000
	setpiece_item = /mob/living/carbon/human

/datum/map_template/ruin/wasteplanet/yard
	name = "Abandoned Miskilamo salvage yard"
	description = "An abandonded shipbreaking yard."
	id = "wasteplanet_yard"
	suffix = "wasteplanet_yard.dmm"

	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/wasteplanet/icwbase
	name = "ICW Era Comms and Medical base."
	description = "A former Syndicate Coalition base during the ICW, left to waste. It seems it has some new residents.."
	id = "wasteplanet_icwbase"
	suffix = "wasteplanet_icwbase.dmm"

	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)
