/mob/living/simple_animal/hostile/asteroid/ice_whelp
	name = "ice whelp"
	desc = "The offspring of an ice drake, weak in comparison but still terrifying."
	icon = 'icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "ice_whelp"
	icon_living = "ice_whelp"
	icon_dead = "ice_whelp_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	friendly_verb_continuous = "stares down"
	friendly_verb_simple = "stare down"
	speak_emote = list("roars")
	speed = 20
	move_to_delay = 20
	ranged = TRUE
	ranged_cooldown_time = 7 SECONDS
	maxHealth = 80
	health = 80
	armor = list("melee" = 40, "bullet" = 40, "laser" = 25, "energy" = 10, "bomb" = 50, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 10)
	obj_damage = 15
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "chomps"
	attack_verb_simple = "chomp"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	vision_range = 6
	aggro_vision_range = 7
	move_resist = MOVE_FORCE_VERY_STRONG
	butcher_results = list(/obj/item/stack/ore/diamond = 3, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/bone = 10, /obj/item/stack/sheet/animalhide/ashdrake = 1)
	loot = list()
	mob_trophy = /obj/item/mob_trophy/tail_spike
	deathmessage = "collapses on its side."
	deathsound = 'sound/magic/demon_dies.ogg'
	stat_attack = HARD_CRIT
	robust_searching = TRUE
	footstep_type = FOOTSTEP_MOB_CLAW
	/// How far the whelps fire can go
	var/fire_range = 3

/mob/living/simple_animal/hostile/asteroid/ice_whelp/OpenFire()
	shake_animation(1 SECONDS)
	playsound(loc, 'sound/magic/demon_dies.ogg', 100, TRUE, frequency = 2)
	addtimer(CALLBACK(src, PROC_REF(open_fire_2)), 2 SECONDS)

/mob/living/simple_animal/hostile/asteroid/ice_whelp/proc/open_fire_2()
	if(!target)
		return
	var/turf/T = get_ranged_target_turf_direct(src, target, fire_range)
	var/list/burn_turfs = getline(src, T) - get_turf(src)

	playsound(get_turf(src),'sound/magic/fireball.ogg', 200, TRUE)
	fire_line(src, burn_turfs)


/mob/living/simple_animal/hostile/asteroid/ice_whelp/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	if(prob(10))
		new /obj/item/gem/amber(loc)
	return ..()

