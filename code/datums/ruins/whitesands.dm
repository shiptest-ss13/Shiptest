// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/whitesands
	prefix = "_maps/RandomRuins/SandRuins/"
	ruin_type = RUINTYPE_SAND

/datum/map_template/ruin/whitesands/pubbyslopcrash
	name = "Pubby Slop Crash"
	id = "ws-pubbyslopcrash"
	description = "A failed attempt of the Nanotrasen nutrional replacement program"
	suffix = "whitesands_surface_pubbyslopcrash.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/whitesands/cave_base
	name = "Abandoned Cave Base"
	id = "cave_base"
	description = "The former home of a poor sod on observation duty. Now a cunning trap."
	suffix = "whitesands_cave_base.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)
/*	ruin_mission_types = list(
		/datum/mission/ruin/radiological,
	)
*/

/datum/mission/ruin/radiological
	name = "Radiological Signature"
	desc = "We've been picking up some sort of radiological signature inconsistent with normal planetary emissions. Observational staff have informed us that the pattern matches a low-yield fusion warhead in an unshielded environment. Investigate the site and retrieve the source so that we may dispose of it."
	author = "Outpost Authority"
	mission_limit = 1
	setpiece_item = /obj/machinery/syndicatebomb
	value = 3500

//////////OUTSIDE SETTLEMENTS/RUINS//////////
/datum/map_template/ruin/whitesands/survivors/saloon
	name = "Hermit Saloon"
	id = "ws-saloon"
	description = "A western style saloon, most popular spot for the hermits to gather planetside"
	suffix = "whitesands_surface_camp_saloon.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/whitesands/survivors/combination //combined extra large ruin of several other whitesands survivor ruins
	name = "Wasteland Survivor Village"
	id = "ws-combination"
	description = "A small encampment of nomadic survivors of the First Colony, and their descendants. By all accounts, feral and without allegance to anyone but themselves."
	suffix = "whitesands_surface_camp_combination.dmm"
	allow_duplicates = FALSE
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/whitesands/e11_manufactory
	name = "E-11 Manufacturing Plant"
	id = "ws-e11manufactory"
	description = "An old Eoehoma Firearms manufacturing plant dedicated to assembly of the beloved-by-many E-11 rifle."
	suffix = "whitesands_surface_e11_manufactory.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_HAZARDOUS)
	ruin_mission_types = list(/datum/mission/ruin/multiple/e11_stash)

/datum/mission/ruin/multiple/e11_stash
	name = "recover a stash of Eoehoma weapons"
	desc = "My first mate found an Eoehoma document detailing a production plant for energy weapons in the sector, we'll pay well if you can recover and deliver 6 guns back to us."
	faction = /datum/faction/independent
	value = 2750
	mission_limit = 1
	setpiece_item = /obj/item/gun/energy/e_gun/e11
	required_count = 6
	requires_poi = FALSE

/datum/mission/ruin/multiple/e11_stash/can_turn_in(atom/movable/item_to_check)
	if(istype(item_to_check, /obj/item/gun))
		var/obj/item/gun/eoehoma_gun = item_to_check
		if(eoehoma_gun.manufacturer == MANUFACTURER_EOEHOMA)
			return TRUE

/datum/map_template/ruin/whitesands/brazillian_lab
	name = "Hermit Weapons-Testing Compound"
	id = "brazillian-lab"
	description = "A conspicuous compound in the middle of the sandy wasteland. What goodies are inside?"
	suffix = "whitesands_brazillianlab.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/whitesands/nomads_stop
	name = "Nomad's Stop"
	id = "nomad-stop"
	description = "A set of structures born of ancient prefabs and quick-pour cement, turned into a place for trade on the planet's surface."
	suffix = "whitesands_nomads_stop.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_HAZARDOUS, RUIN_TAG_SHELTER)
