#define APPROACH_AGGRESSIVE "aggress"
#define APPROACH_RANGED "ranged"

/mob/living/simple_animal/hostile/megafauna/megabot
	name = "Marcus Dewey"
	desc = "Smile! You're about to be Intraleak Content."
	health = 1500
	maxHealth = 1500
	attack_verb_continuous = "batters"
	attack_verb_simple = "batter"
	attack_sound = 'sound/effects/meteorimpact.ogg'
	icon_state = "megabot"
	icon_living = "megabot"
	icon_dead = "megabot"
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
	move_to_delay = 3.5
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
	//loot = list(/obj/item/mob_trophy/megabot_reactor)
	blood_volume = 0 //robor
	var/charging = FALSE
	var/revving_charge = FALSE
	var/approach = APPROACH_RANGED
	var/change_approach_chance = 100
	gps_name = "Glitchy Signal"
	achievement_type = /datum/award/achievement/boss/bubblegum_kill
	crusher_achievement_type = /datum/award/achievement/boss/bubblegum_crusher
	score_achievement_type = /datum/award/score/bubblegum_score

	//deathmessage = "self destructs, leaving behind a power core."
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
	name = "Charge"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "laser_burst"
	chosen_message = span_colossus("You are now charging")
	chosen_attack_num = 3

/datum/action/innate/megafauna_attack/mine
	name = "Plant Mine"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "laser_burst"
	chosen_message = span_colossus("You are now planting a mine.")
	chosen_attack_num = 4

/mob/living/simple_animal/hostile/megafauna/megabot/OpenFire()
	anger_modifier = clamp(((maxHealth - health)/50),0,40)
	ranged_cooldown = world.time + max(40, (60 - anger_modifier)) //attacks faster as it loses health

	if(client)
		switch(chosen_attack)
			if(1)
				burst_shot()
			if(2)
				spread_shot()
			if(3)
				charge()
			if(4)
				plant_mine()
		return
	// else
	// 	if(prob(change_approach_chance))
	// 		approach = pick(APPROACH_AGGRESSIVE,APPROACH_RANGED)
	// 		update_stategy()
	// 		change_approach_chance = 0
	// 	else
	// 		change_approach_chance += 5


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
	wind_up_visual(TRUE)
	SLEEP_CHECK_DEATH(12)
	var/datum/callback/fire = CALLBACK(src, PROC_REF(shoot_projectile), get_turf(target))
	for(var/i in 1 to num_shots)
		addtimer(fire, (i - 1)*rapid_fire_delay)

/mob/living/simple_animal/hostile/megafauna/megabot/proc/spread_shot()
	casingtype = /obj/item/ammo_casing/energy/laser/assault/sharplite/megabot/burst
	wind_up_visual(TRUE)
	SLEEP_CHECK_DEATH(12)
	shoot_projectile(get_turf(target))

/mob/living/simple_animal/hostile/megafauna/megabot/proc/shoot_n_charge()
	charge()
	if(health < maxHealth/3)
		if(prob(50))
			charge(delay = 6)
		else
			burst_shot()

/mob/living/simple_animal/hostile/megafauna/megabot/proc/wind_up_visual(ranged = TRUE, silent = FALSE)
	if(!silent)
		playsound(src, 'sound/machines/synth_yes.ogg', 200, TRUE, 3, frequency = 6120)
		visible_message(span_danger("The [src] [ranged ? "charges up it's laser!" : "prepares to charge!"]"))
	if(ranged)
		new /obj/effect/temp_visual/megabot/laser(loc,src)
	else
		new /obj/effect/temp_visual/megabot/charge(loc,src)
		Shake(5, 5, 1 SECONDS)

/mob/living/simple_animal/hostile/megafauna/megabot/proc/charge(atom/chargeat = target, delay = 12, chargepast = 3, silent = FALSE)
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
	wind_up_visual(FALSE)
	walk(src, 0)
	setDir(dir)
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(loc,src)
	animate(D, alpha = 0, color = "#605959", transform = matrix()*2, time = 3)
	new /obj/effect/temp_visual/megabot/charge(loc,src)
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
		new /obj/effect/temp_visual/small_smoke/halfsecond(loc)
	playsound(src, 'sound/effects/meteorimpact.ogg', 200, TRUE, 2, TRUE)
	..()

/mob/living/simple_animal/hostile/megafauna/megabot/Bump(atom/A)
	var/atom/throw_target = get_edge_target_turf(A, dir)
	if(charging)
		if(iswallturf(A))
			var/turf/closed/wall/crushed = A
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
			visible_message(span_danger("[src] smashes through [A]!"))
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

/mob/living/simple_animal/hostile/megafauna/megabot/death(gibbed, list/force_grant)
	. = ..()
	visible_message(span_danger("The [src]'s reactor begins to overload! It's gonna blow!"))
	playsound(src,'sound/machines/alarm.ogg',200,FALSE,2)
	Shake(5,5, 13 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(self_destruct)), 13 SECONDS)

/mob/living/simple_animal/hostile/megafauna/megabot/proc/self_destruct()
	explosion(src,0,1,5,5, flame_range = 5, light_dam = 20, light_item_dam = 0, heavy_dam = 40, heavy_item_dam = 0)
	new /obj/item/mob_trophy/megabot_reactor(loc)
	qdel_self()


/obj/effect/temp_visual/megabot
	icon = 'icons/mob/lavaland/64x64megafauna.dmi'
	icon_state = "laser_indicator"
	duration = 10
	pixel_x = -16
	base_pixel_x = -16
	layer = FLY_LAYER
	var/target

/obj/effect/temp_visual/megabot/Initialize(mapload, new_target)
	. = ..()
	target = new_target
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, orbit), target, 0, FALSE, 0, 0, FALSE, TRUE)

/obj/effect/temp_visual/megabot/laser
	icon_state = "laser_indicator"

/obj/effect/temp_visual/megabot/charge
	icon_state = "charge_indicator"

#undef APPROACH_AGGRESSIVE
#undef APPROACH_RANGED
