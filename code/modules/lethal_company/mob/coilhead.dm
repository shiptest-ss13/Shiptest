/mob/living/simple_animal/hostile/statue/coilhead
	name = "coilhead"
	desc = "A withered humanoid statue of concrete, lacking arms and sporting a neck made of a single big loud coil. Multiple nails are puncturing into the statue."

	icon = 'coilhead.dmi'
	icon_state = "coilhead"
	icon_living = "coilhead"
	icon_dead = "coilhead"

	var/coilhead_sound_ready = TRUE

	animate_movement = FORWARD_STEPS

	melee_damage_lower = 90
	melee_damage_upper = 90

	attack_verb_continuous = "coils"
	attack_verb_simple = "coil"

	move_to_delay = 0 // Very fast

	search_objects = 0

	faction = list("coilhead")

	pixel_x = 6

// springy sproingy SFX
/mob/living/simple_animal/hostile/statue/coilhead/Move(turf/NewLoc)
	if(can_be_seen() && coilhead_sound_ready)
		src.coilhead_sound_ready = FALSE
		playsound(src, 'spring.ogg', 300, TRUE, use_reverb = TRUE)
	else if(!can_be_seen())
		src.coilhead_sound_ready = TRUE
	..()

/mob/living/simple_animal/hostile/statue/coilhead/sir_coils_your_brains
	name = "Sir Coils-Your-Brains"
	melee_damage_upper = 1000
	melee_damage_lower = 1000
	icon_state = "sir"
	icon_living = "sir"
	icon_dead = "sir"
