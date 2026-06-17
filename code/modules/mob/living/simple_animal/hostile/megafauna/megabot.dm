#define APPROACH_AGGRESSIVE "aggress"
#define APPROACH_RANGED "ranged"

/mob/living/simple_animal/hostile/megafauna/megabot
	name = "Marcus Dewey"
	desc = "Smile! You're about to be Intraleak Content."
	health = 1500
	maxHealth = 1500
	attack_verb_continuous = "batters"
	attack_verb_simple = "batter"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	icon_state = "megabot"
	icon_living = "megabot"
	icon_dead = ""
	mob_biotypes = MOB_ROBOTIC|MOB_SPECIAL

	health_doll_icon = "bubblegum"
	friendly_verb_continuous = "scans"
	friendly_verb_simple = "scan"
	icon = 'icons/mob/lavaland/64x64megafauna.dmi'
	speak_emote = list("buzzes")
	armour_penetration = 40
	melee_damage_lower = 50
	melee_damage_upper = 50

	speed = 5
	move_to_delay = 5
	footstep_type = FOOTSTEP_MOB_HEAVY

	retreat_distance = 0
	minimum_distance = 1
	rapid_melee = 1
	is_flying_animal = FALSE

	ranged = TRUE
	projectiletype = null
	casingtype = /obj/item/ammo_casing/energy/laser/assault/sharplite/megabot
	spread = 5
	rapid_fire_delay = 4

	pixel_x = -16
	base_pixel_x = -16
	del_on_death = TRUE
	loot = list(/obj/structure/closet/crate/necropolis/bubblegum)
	blood_volume = 0 //robor
	var/charging = FALSE
	var/revving_charge = FALSE
	var/approach = APPROACH_RANGED
	var/change_approach_chance = 100
	gps_name = "Glitchy Signal"
	achievement_type = /datum/award/achievement/boss/bubblegum_kill
	crusher_achievement_type = /datum/award/achievement/boss/bubblegum_crusher
	score_achievement_type = /datum/award/score/bubblegum_score

	deathmessage = "self destructs, leaving behind a power core."
	deathsound = 'sound/magic/enter_blood.ogg'
	attack_action_types = list(
		/datum/action/innate/megafauna_attack/burst_shot,
		/datum/action/innate/megafauna_attack/spread_shot,
		/datum/action/innate/megafauna_attack/shoot_n_charge,
		/datum/action/innate/megafauna_attack/mine)
	small_sprite_type = /datum/action/small_sprite/megafauna/bubblegum

/obj/item/ammo_casing/energy/laser/assault/sharplite/megabot
	projectile_type = /obj/projectile/beam/laser/assault/sharplite/megabot

/obj/projectile/beam/laser/assault/sharplite/megabot
	speed = 0.8

/obj/item/ammo_casing/energy/laser/assault/sharplite/megabot/burst
	pellets = 3
	variance = 25


/datum/action/innate/megafauna_attack/burst_shot
	name = "Burst Shot"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "laser_burst"
	chosen_message = span_colossus("You are now firing in bursts.")
	chosen_attack_num = 1

/datum/action/innate/megafauna_attack/spread_shot
	name = "Spread Shot"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "laser_burst"
	chosen_message = span_colossus("You are now firing shotgun blasts.")
	chosen_attack_num = 2

/datum/action/innate/megafauna_attack/shoot_n_charge
	name = "Shoot and Charge"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "laser_burst"
	chosen_message = span_colossus("You are now firing in a burst and then charging.")
	chosen_attack_num = 3

/datum/action/innate/megafauna_attack/mine
	name = "Plant Mine"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "laser_burst"
	chosen_message = span_colossus("You are now planting a mine.")
	chosen_attack_num = 4

/mob/living/simple_animal/hostile/megafauna/megabot/OpenFire()
	anger_modifier = clamp(((maxHealth - health)/50),0,20)
	ranged_cooldown = world.time + 120

	if(client)
		switch(chosen_attack)
			if(1)
				burst_shot()
			if(2)
				spread_shot()
			if(3)
				shoot_n_charge()
			if(4)
				plant_mine()
		return
	// else
	// 	if(prob(change_approach_chance))
	// 		approach = pick(APPROACH_AGGRESSIVE,APPROACH_RANGED)
	// 		update_stategy()
	// 		change_approach_chance = 0
	// 	else
	// 		change_approach_chance += 10


	if(prob(20+anger_modifier)) //Major attack
		if(prob(50))
			plant_mine()
		shoot_n_charge()
	else
		if(prob(50))
			burst_shot()
		else
			spread_shot()
		if(prob(20))
			plant_mine()

/mob/living/simple_animal/hostile/megafauna/megabot/proc/burst_shot()
	casingtype = /obj/item/ammo_casing/energy/laser/assault/sharplite/megabot
	var/num_shots = 3
	if(health < maxHealth/3)
		num_shots = 5
	var/datum/callback/fire = CALLBACK(src, PROC_REF(shoot_projectile), get_turf(target))
	for(var/i in 1 to num_shots)
		addtimer(fire, (i - 1)*rapid_fire_delay)

/mob/living/simple_animal/hostile/megafauna/megabot/proc/spread_shot()
	casingtype = /obj/item/ammo_casing/energy/laser/assault/sharplite/megabot/burst
	shoot_projectile(get_turf(target))

/mob/living/simple_animal/hostile/megafauna/megabot/proc/shoot_n_charge()
	burst_shot()
	SLEEP_CHECK_DEATH(3)
	charge()

/mob/living/simple_animal/hostile/megafauna/megabot/proc/charge(atom/chargeat = target, delay = 6, chargepast = 2)
	if(!chargeat)
		return
	var/chargeturf = get_turf(chargeat)
	if(!chargeturf)
		return
	var/dir = get_dir(src, chargeturf)
	var/turf/T = get_ranged_target_turf(chargeturf, dir, chargepast)
	if(!T)
		return
	new /obj/effect/temp_visual/dragon_swoop/bubblegum(T)
	charging = TRUE
	revving_charge = TRUE
	DestroySurroundings()
	walk(src, 0)
	setDir(dir)
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(loc,src)
	animate(D, alpha = 0, color = "#FF0000", transform = matrix()*2, time = 3)
	SLEEP_CHECK_DEATH(delay)
	revving_charge = FALSE
	var/movespeed = 0.7
	walk_towards(src, T, movespeed)
	SLEEP_CHECK_DEATH(get_dist(src, T) * movespeed)
	walk(src, 0) // cancel the movement
	charging = FALSE

/mob/living/simple_animal/hostile/megafauna/megabot/proc/plant_mine()
	new /obj/item/mine/proximity/explosive/sting/live(loc)

/mob/living/simple_animal/hostile/megafauna/megabot/proc/update_stategy()
	switch(approach)
		if(APPROACH_AGGRESSIVE)
			retreat_distance = 0
			minimum_distance = 0
		if(APPROACH_RANGED)
			retreat_distance = 5
			minimum_distance = 5

/mob/living/simple_animal/hostile/megafauna/megabot/AttackingTarget()
	if(!charging)
		. = ..()

/mob/living/simple_animal/hostile/megafauna/megabot/do_attack_animation(atom/A, visual_effect_icon)
	if(!charging)
		..()

/mob/living/simple_animal/hostile/megafauna/megabot/Goto(target, delay, minimum_distance)
	if(!charging)
		..()

/mob/living/simple_animal/hostile/megafauna/megabot/MoveToTarget(list/possible_targets)
	if(!charging)
		..()

/mob/living/simple_animal/hostile/megafauna/megabot/Move()
	if(revving_charge)
		return FALSE
	if(charging)
		new /obj/effect/temp_visual/decoy/fading(loc,src)
	..()

/mob/living/simple_animal/hostile/megafauna/megabot/Bump(atom/A)
	var/atom/throw_target = get_edge_target_turf(A, dir)
	if(charging)
		if(iswallturf(A))
			var/turf/closed/wall/crushed = A
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
			visible_message(span_danger("[src] smashes through [A]"))
			crushed.dismantle_wall(TRUE)
		if(isobj(A))
			var/obj/object = A
			object.attack_animal(src)
			if(!(object.resistance_flags & INDESTRUCTIBLE) && !QDELETED(object))
				object.throw_at(throw_target, 4, 3)
			visible_message(span_danger("[src] crashes into [A]!"))
			playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		if(isliving(A))
			var/mob/living/pancake = A
			visible_message(span_danger("[src] slams into \the [pancake], sending [pancake.p_them()] flying!"))
			playsound(pancake, 'sound/effects/bang.ogg', 100, FALSE, -1)
			pancake.Knockdown(10)
			pancake.adjustStaminaLoss(30)
			pancake.apply_damage(rand(40,60), BRUTE)
			pancake.throw_at(throw_target,4,3)
	..()


#undef APPROACH_AGGRESSIVE
#undef APPROACH_RANGED
