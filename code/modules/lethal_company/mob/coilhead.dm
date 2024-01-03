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
	attack_sound = 'kill.ogg'

	move_to_delay = 0 // Very fast

	search_objects = 1

	faction = list("coilhead")

	pixel_x = 6

// springy sproingy SFX
/mob/living/simple_animal/hostile/statue/coilhead/Move(turf/NewLoc)
	var/any_mob_facing = FALSE
	if(can_be_seen())
		for(var/mob/living/M in view(src))
			if(is_A_facing_B(M, src))
				any_mob_facing = TRUE
				break

	if(any_mob_facing && coilhead_sound_ready)
		src.coilhead_sound_ready = FALSE
		playsound(src, 'spring.ogg', 300, TRUE, use_reverb = TRUE)
		return 0
	else if(!any_mob_facing)
		src.coilhead_sound_ready = TRUE

	return ..()


/mob/living/simple_animal/hostile/statue/coilhead/sir_coils_your_brains
	name = "Sir Coils-Your-Brains"
	desc = "A withered humanoid statue of concrete, lacking arms and sporting a neck made of a single big loud coil. Multiple nails are puncturing into the statue. For some unknown reason, this one seems to don fancy attire, and there's some yorkshire tea dribbling out of the mouth"
	melee_damage_upper = 1000
	melee_damage_lower = 1000
	icon_state = "sir"
	icon_living = "sir"
	icon_dead = "sir"

