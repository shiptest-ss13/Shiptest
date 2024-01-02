/mob/living/simple_animal/hostile/statue/coilhead
	name = "coilhead"
	desc = "A withered humanoid statue of concrete, lacking arms and sporting a neck made of a single big loud coil."
	// icon = 'coilhead.dmi'
	icon_state = "coilhead"
	icon_living = "coilhead"
	icon_dead = "coilhead"

	animate_movement = FORWARD_STEPS

	melee_damage_lower = 1
	melee_damage_upper = 99999

	attack_verb_continuous = "coils"
	attack_verb_simple = "coil"

	move_to_delay = 0 // Very fast

	search_objects = 0
