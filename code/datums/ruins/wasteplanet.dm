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
	value = 4000
	mission_limit = 1
	setpiece_item = /obj/structure/mecha_wreckage/gygax/dark

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
	value = 2500
	mission_limit = 1
	setpiece_item = /mob/living/carbon/human

/datum/map_template/ruin/wasteplanet/yard
	name = "Abandoned Miskilamo salvage yard"
	description = "An abandonded shipbreaking yard."
	id = "wasteplanet_yard"
	suffix = "wasteplanet_yard.dmm"

	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/wasteplanet/icwbase
	name = "ICW Era Comms and Medical base"
	description = "A former Syndicate Coalition base during the ICW, left to waste. It seems it has some new residents.."
	id = "wasteplanet_icwbase"
	suffix = "wasteplanet_icwbase.dmm"

	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)
/*	ruin_mission_types = list(
		/datum/mission/ruin/multiple/notes,
		/datum/mission/ruin/signaled/kill/kitt
	)
*/

/* Aurora wrote these */

/datum/mission/ruin/multiple/notes
	name = "recover research notes"
	desc = "Hello, on behalf of Cybersun Biodynamics, we are offering an active bounty on the return of the research notes of Dr. Margret Kithin, located in a former base of operations of which we lost contact with in recent years. Last we saw, the facility had been claimed by pirate elements, who seemed keen on desecrating the facility. We only care about our research being returned."
	faction = /datum/faction/syndicate/cybersun
	value = 4000
	mission_limit = 1
	setpiece_item = /obj/item/documents/syndicate/cybersun/biodynamics
	required_count = 2

/datum/mission/ruin/signaled/kill/kitt
	name = "Kill Her"
	desc = "What do you do when a normal person wrongs you? You get revenge. What do you do when a fellow pirate wrongs you? You spent months tracking them, watching them from the shadows and even beneath their own fucking nose, alright? Her name is Kitt. I want her stupid bitch face buried ten feet in the ground and some proof, and the payment is yours. Call me spiteful, but I lost a good friend to her. Make her pay."
	author = "Not Important"
	faction = /datum/faction/independent
	value = 2500
	mission_limit = 1
	registered_type = /mob/living/simple_animal/hostile/human/frontier/ranged/trooper/skm/internals/neutered

/datum/map_template/ruin/wasteplanet/facility
	name = "Salvage Facility"
	description = "A salvage collection & processing facility which was abandoned by its sole proprietor, following a corporate dissolution."
	id = "wasteplanet_facility"
	suffix = "wasteplanet_facility.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/wasteplanet/recycling
	name = "Recycling Facility"
	description = "A rusty salvaging and recycling base made to supply some unsavory people."
	id = "wasteplanet_recyclebay"
	suffix = "wasteplanet_recyclebay.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

