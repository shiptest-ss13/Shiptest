/mob/living/simple_animal/hostile/asteroid/antlion
	name = "antlion"
	desc = "A large insectoid creature."
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "antlion"
	icon_living = "antlion"
	icon_dead = "antlion_dead"
	speak_emote = list("clicks")
	emote_hear = list("clicks its mandibles")
	emote_see = list("shakes the sand off itself")

	health = 65
	maxHealth = 65

	melee_damage_lower = 10
	melee_damage_upper = 10
	//sharpness = SHARP_EDGED
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	//attack_vis_effect = ATTACK_EFFECT_BITE

	//Their "ranged" ability is burrowing
	ranged = TRUE
	ranged_cooldown_time = 15 SECONDS

	/// Whether we are burrowed or not
	var/burrowed = FALSE
	/// How much health we regen per Life() when burrowed
	var/heal_amount = 10

/mob/living/simple_animal/hostile/asteroid/antlion/Life()
	. = ..()
	if(burrowed)
		health = min(maxHealth, health+heal_amount)

/mob/living/simple_animal/hostile/asteroid/antlion/OpenFire()
	if(!burrowed && prob(70))
		burrow()

/mob/living/simple_animal/hostile/asteroid/antlion/proc/burrow()
	ranged_cooldown = world.time + ranged_cooldown_time
	var/turf/my_turf = get_turf(src)
	playsound(my_turf, 'sound/effects/bamf.ogg', 50, 0)
	visible_message("<span class='notice'>\The [src] burrows into \the [my_turf]!</span>")
	burrowed = TRUE
	invisibility = INVISIBILITY_MAXIMUM
	AIStatus = AI_OFF
	mob_size = MOB_SIZE_TINY
	new /obj/effect/temp_visual/burrow_sand_splash(my_turf)
	addtimer(CALLBACK(src, .proc/diggy), 4 SECONDS)

/mob/living/simple_animal/hostile/asteroid/antlion/proc/diggy()
	var/list/turf_targets = list()
	if(target)
		for(var/turf/T in range(1, get_turf(target)))
			if(!isopenturf(T))
				continue
			turf_targets += T
	else
		for(var/turf/T in view(5, src))
			if(!isopenturf(T))
				continue
			turf_targets += T
	if(length(turf_targets))
		forceMove(pick(turf_targets))

	addtimer(CALLBACK(src, .proc/emerge), 2 SECONDS)

/mob/living/simple_animal/hostile/asteroid/antlion/proc/emerge()
	var/turf/my_turf = get_turf(src)
	visible_message("<span class='danger'>\The [src] erupts from \the [my_turf]!</span>")
	invisibility = 0
	burrowed = FALSE
	AIStatus = AI_ON
	mob_size = initial(mob_size)
	playsound(my_turf, 'sound/effects/bamf.ogg', 50, 0)
	new /obj/effect/temp_visual/burrow_sand_splash(my_turf)
	for(var/mob/living/carbon/human/H in my_turf)
		attack_hand(H)
		visible_message("<span class='danger'>\The [src] tears into \the [H] from below!</span>")

/mob/living/simple_animal/hostile/asteroid/antlion/mega
	name = "antlion queen"
	desc = "A huge antlion. It looks displeased."
	icon_state = "queen"
	icon_living = "queen"
	icon_dead = "queen_dead"
	mob_size = MOB_SIZE_LARGE
	health = 275
	maxHealth = 275
	melee_damage_lower = 25
	melee_damage_upper = 25

	heal_amount = 20

/mob/living/simple_animal/hostile/asteroid/antlion/mega/Initialize()
	. = ..()
	transform = transform.Scale(2, 2)
	transform = transform.Translate(0, 16)

/obj/effect/temp_visual/burrow_sand_splash
	icon = 'icons/effects/effects.dmi'
	icon_state = "splash"
	color = "#dbc56b"
