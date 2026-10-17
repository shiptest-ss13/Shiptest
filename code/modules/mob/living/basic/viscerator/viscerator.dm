/mob/living/basic/viscerator
	name = "viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations."
	icon = 'icons/mob/animal.dmi'
	icon_state = "viscerator_attack"
	icon_living = "viscerator_attack"
	gender = NEUTER
	pass_flags = PASSTABLE | PASSMOB
	a_intent = INTENT_HARM
	mob_biotypes = MOB_ROBOTIC
	basic_mob_flags = DEL_ON_DEATH
	health = 25
	maxHealth = 25
	// about as quick as the simplemob, which chased at 0.3 seconds a tile
	speed = 3
	melee_damage_lower = 15
	melee_damage_upper = 15
	wound_bonus = -10
	bare_wound_bonus = 20
	sharpness = SHARP_EDGED
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list(FACTION_RAMZI)
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	mob_size = MOB_SIZE_TINY
	limb_destroyer = 1
	speak_emote = list("states")
	bubble_icon = "syndibot"
	ai_controller = /datum/ai_controller/basic_controller/viscerator

/mob/living/basic/viscerator/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_MOVE_FLYING, ROUNDSTART_TRAIT)
	AddComponent(/datum/component/swarming)
	AddElement(/datum/element/ai_reacts_to_harm)
	AddElement(/datum/element/ai_hears_gunfire)

/mob/living/basic/viscerator/death(gibbed)
	if(stat != DEAD)
		visible_message(span_danger("[src] is smashed into pieces!"))
	return ..()

/datum/ai_controller/basic_controller/viscerator
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
	)
	interrupt_keys = list(
		BB_BASIC_MOB_CURRENT_TARGET,
		BB_BASIC_MOB_TARGET_IN_SIGHT,
		BB_BASIC_MOB_LAST_SHOT_TIME,
	)
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/idle_random_walk
	sensors = list(
		/datum/ai_sensor/update_combat_targets,
		/datum/ai_sensor/track_target,
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/return_home,
		/datum/ai_planning_subtree/search_lost_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
