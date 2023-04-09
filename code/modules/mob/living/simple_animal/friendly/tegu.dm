/mob/living/simple_animal/hostile/retaliate/tegu
	name = "tegu"
	desc = "Thats a tegu."
	icon = 'icons/mob/pets.dmi'
	icon_state = "tegu"
	icon_living = "tegu"
	icon_dead ="tegu_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_emote = list("hisses")
	emote_hear = list("hisses.")
	emote_see = list("waits apprehensively.", "walks around.")
	speak_chance = 1
	turns_per_move = 5
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "rolls over"
	response_disarm_simple = "roll over"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	melee_damage_lower = 18
	melee_damage_upper = 22
	health = 75
	maxHealth = 75
	speed = 5
	footstep_type = FOOTSTEP_MOB_CLAW
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'

/mob/living/simple_animal/hostile/retaliate/tegu/atlas
	name = "Atlas"
	desc = "That's the captain's small, but mighty pet tegu. They might have the blood of greytiders on them."
	gender = MALE
	gold_core_spawnable = NO_SPAWN
