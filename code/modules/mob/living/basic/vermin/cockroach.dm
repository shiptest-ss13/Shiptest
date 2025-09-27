/mob/living/basic/cockroach
	name = "cockroach"
	desc = "This station is just crawling with bugs."
	icon_state = "cockroach"
	icon_dead = "cockroach" //Make this work
	density = FALSE
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	mob_size = MOB_SIZE_TINY
	health = 1
	maxHealth = 1
	speed = 1.25
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB

	verb_say = "chitters"
	verb_ask = "chitters inquisitively"
	verb_exclaim = "chitters loudly"
	verb_yell = "chitters loudly"
	response_disarm_continuous = "shoos"
	response_disarm_simple = "shoo"
	response_harm_continuous = "splats"
	response_harm_simple = "splat"
	speak_emote = list("chitters")

	basic_mob_flags = DEL_ON_DEATH
	faction = list(FACTION_HOSTILE)

	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 270
	maximum_survivable_temperature = INFINITY

	ai_controller = /datum/ai_controller/basic_controller/cockroach

/mob/living/basic/cockroach/Initialize()
	. = ..()
	AddElement(/datum/element/death_drops, list(/obj/effect/decal/cleanable/insectguts))
	AddComponent( \
		/datum/component/squashable, \
		squash_chance = 50, \
		squash_damage = 1, \
	)

/mob/living/basic/cockroach/ex_act() //Explosions are a terrible way to handle a cockroach.
	return FALSE


/datum/ai_controller/basic_controller/cockroach
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/cockroach,
		/datum/ai_planning_subtree/find_and_hunt_target/roach
	)

/obj/projectile/bullet/glockroach
	damage = 10 //same damage as a hivebot
	damage_type = BRUTE

/obj/item/ammo_casing/glockroach
	name = "0.9mm bullet casing"
	desc = "A... 0.9mm bullet casing? What?"
	caliber = "0.9mm"
	projectile_type = /obj/projectile/bullet/glockroach


/mob/living/basic/cockroach/glockroach
	name = "glockroach"
	desc = "HOLY SHIT, THAT COCKROACH HAS A GUN!"
	icon_state = "glockroach"
	melee_damage_lower = 2.5
	melee_damage_upper = 10
	obj_damage = 10
	faction = list(FACTION_HOSTILE)
	ai_controller = /datum/ai_controller/basic_controller/cockroach/glockroach
	///number of burst shots
	var/burst_shots
	///cooldown between attacks
	var/ranged_cooldown = 1 SECONDS

/mob/living/basic/cockroach/glockroach/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = /obj/item/ammo_casing/glockroach,\
		burst_shots = burst_shots,\
		cooldown_time = ranged_cooldown,\
	)

/datum/ai_controller/basic_controller/cockroach/glockroach
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/cockroach,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/glockroach, //If we are attacking someone, this will prevent us from hunting
		/datum/ai_planning_subtree/find_and_hunt_target/roach
	)

/datum/ai_planning_subtree/basic_ranged_attack_subtree/glockroach
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/glockroach

/datum/ai_behavior/basic_ranged_attack/glockroach
	action_cooldown = 1 SECONDS
