/mob/living/simple_animal/hostile/eyeball
	name = "eyeball"
	desc = "An odd looking creature, it won't stop staring..."
	icon = 'icons/mob/carp.dmi'
	icon_state = "eyeball"
	icon_living = "eyeball"
	icon_gib = ""
	maxHealth = 30
	health = 30
	harm_intent_damage = 15
	obj_damage = 10
	melee_damage_lower = 8
	melee_damage_upper = 12
	speed = 0
	gender = NEUTER
	mob_biotypes = MOB_ORGANIC
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("glares")
	taunt_chance = 25
	speak_emote = list("telepathically cries")
	turns_per_move = 5
	attack_verb_continuous = "blinks at"
	attack_verb_simple = "blink at"
	attack_sound = 'sound/weapons/pierce.ogg'
	is_flying_animal = TRUE
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list("spooky")
	del_on_death = 1
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	sight = SEE_SELF|SEE_MOBS|SEE_OBJS|SEE_TURFS

/mob/living/simple_animal/hostile/eyeball/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
