/mob/living/simple_animal/hostile/megafauna/claw
	name = "Trooper \"Claw\""
	desc = "This is Trooper \"Claw\".\nThey are holding a armblade in their right hand."
	health = 750
	maxHealth = 750
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	attack_sound = 'sound/creatures/claw_attack.ogg'
	icon_state = "claw-phase1"
	icon_living = "claw-phase1"
	icon = 'icons/mob/broadMobs.dmi'
	health_doll_icon = "miner"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	light_color = COLOR_LIGHT_GRAYISH_RED
	light_range = 5
	movement_type = GROUND
	speak_emote = list("says")
	armour_penetration = 30
	melee_damage_lower = 20
	melee_damage_upper = 20
	ranged = TRUE
	speed = 4
	move_to_delay = 4
	crusher_loot = list(/obj/item/card/id/ert/deathsquad, /obj/item/documents/nanotrasen)
	loot = list(/obj/item/card/id/ert/deathsquad, /obj/item/documents/nanotrasen)
	wander = FALSE
	blood_volume = BLOOD_VOLUME_NORMAL
	gps_name = "NTAF-V"
	deathmessage = "stops moving..."
	deathsound = "bodyfall"
	footstep_type = FOOTSTEP_MOB_HEAVY
	attack_action_types = list(
		/datum/action/innate/megafauna_attack/swift_dash,
		/datum/action/innate/megafauna_attack/swift_dash_long,
	)
	pixel_x = -16
	var/shouldnt_move = FALSE
	var/dash_num_short = 4
	var/dash_num_long = 7
	var/dash_cooldown = 0
	var/dash_cooldown_time = 4 // cooldown_time * distance:
	// 4 * 4 = 16 (1.6 seconds)
	// 4 * 18 = 72 (7.2 seconds)
	var/phase = 1 //at about 25% hp, they will "die", and then come back with even more attacks

/mob/living/simple_animal/hostile/megafauna/claw/phase2 //75% of the health this thing has is here
	icon_state = "claw-phase2"
	icon_living = "claw-phase2"
	gps_name = "F453C619AE278"
	deathsound = "bodyfall"
	attack_action_types = list(
		/datum/action/innate/megafauna_attack/swift_dash,
		/datum/action/innate/megafauna_attack/swift_dash_long,
		/datum/action/innate/megafauna_attack/emp_pulse,
		/datum/action/innate/megafauna_attack/tentacle,
		/datum/action/innate/megafauna_attack/summon_creatures,
		/datum/action/innate/megafauna_attack/sting_attack,
	)
	speed = 5
	move_to_delay = 5
	speak_emote = list("verbalizes")
	crusher_loot = list(/obj/effect/spawner/clawloot)
	loot = list(/obj/effect/spawner/clawloot/crusher)
	health = 2250
	maxHealth = 2250
	shouldnt_move = TRUE //we want to show the transforming animation
	phase = 2
	status_flags = CANPUSH | GODMODE //this is so during the animation you cant beat it up

///LOOT
/obj/effect/spawner/clawloot/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/spawn_loot), 5 SECONDS) //this is because it dies violently exploding, so we dont want to destroy the goodies, you know?

/obj/effect/spawner/clawloot/proc/spawn_loot()
	new /obj/item/gun/energy/pulse/pistol(get_turf(src))
	qdel(src)

/obj/effect/spawner/clawloot/crusher/spawn_loot()
	new /obj/item/nullrod/armblade/tentacle(get_turf(src)) //idk what to put here, memed is the loot person
	return ..()
///LOOT END

//PHASE ONE
/datum/action/innate/megafauna_attack/swift_dash
	name = "Swift Dash"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "rift"
	chosen_message = "<span class='colossus'>You will now dash forward for a short distance.</span>"
	chosen_attack_num = 1

/datum/action/innate/megafauna_attack/swift_dash_long
	name = "Long Dash"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "plasmasoul"
	chosen_message = "<span class='colossus'>You will now dash forward for a long distance.</span>"
	chosen_attack_num = 2
//PHASE TWO
/datum/action/innate/megafauna_attack/emp_pulse
	name = "Dissonant Shriek"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "emppulse"
	chosen_message = "<span class='colossus'>You will now create a EMP pulse.</span>"
	chosen_attack_num = 3

/datum/action/innate/megafauna_attack/tentacle
	name = "Tentacle"
	icon_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "tentacle"
	chosen_message = "<span class='colossus'>You will now shoot your tentacle, bringing mobs ever so closer.</span>"
	chosen_attack_num = 4

/datum/action/innate/megafauna_attack/summon_creatures
	name = "Lie Spider"
	icon_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "plasmasoul"
	chosen_message = "<span class='colossus'>You will now summon a weak spider.</span>"
	chosen_attack_num = 5

/datum/action/innate/megafauna_attack/sting_attack
	name = "Sting shotgun"
	icon_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "sting_cryo"
	chosen_message = "<span class='colossus'>You stop, and telegraph a shotgun of stings.</span>"
	chosen_attack_num = 6

/mob/living/simple_animal/hostile/megafauna/claw/phase2/Initialize()
	. = ..()
	flick("claw-phase2_transform",src) //plays the transforming animation
	addtimer(CALLBACK(src, .proc/unlock_phase2), 4.4 SECONDS)

/mob/living/simple_animal/hostile/megafauna/claw/Move()
	if(shouldnt_move)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/megafauna/claw/OpenFire()
	if(client)
		if(shouldnt_move)
			return
		switch(chosen_attack)
			if(1) //these SHOULDNT fire during phase 2, but if they do have fun with the extra attacks
				swift_dash(target, dash_num_short, 5)
			if(2)
				swift_dash(target, dash_num_long, 15)
			if(3) //only should fire duing phase 2
				emp_pulse()
			if(4)
				tentacle(target)
			if(5)
				summon_creatures()
			if(6)
				sting_attack(target)
		return

	Goto(target, move_to_delay, minimum_distance)
	if(phase == 1)
		if(get_dist(src, target) >= 3 && dash_cooldown <= world.time && !shouldnt_move)
			swift_dash(target, dash_num_short, 5)
		if(get_dist(src, target) > 5 && dash_cooldown <= world.time && !shouldnt_move)
			swift_dash(target, dash_num_long, 15)
	else
		if((get_dist(src, target) >= 4) && ((get_dist(src, target)) <= 8) && !shouldnt_move)
			if(prob(60))
				tentacle(target)
				return
			else if(prob(40))
				sting_attack(target)
				return
			else
				swift_dash(target, dash_num_long, 7)
				return

		else if(prob(30))
			sting_attack(target)
			return
		else if(prob(20))
			emp_pulse()
			return
		else
			swift_dash(target, dash_num_short, 5)

/////PROJECTILE SHOOTING
/mob/living/simple_animal/hostile/megafauna/claw/proc/shoot_projectile(angle)
	var/obj/projectile/shot_proj = new projectiletype(get_turf(src))
	playsound(src, projectilesound, 100, TRUE)
	shot_proj.preparePixelProjectile(get_step(src, pick(GLOB.alldirs)), get_turf(src))
	shot_proj.firer = src
	shot_proj.fire(angle)


/////DASH ATTACK
/mob/living/simple_animal/hostile/megafauna/claw/proc/swift_dash(target, distance, wait_time)
	if(dash_cooldown > world.time)
		return
	dash_cooldown = world.time + (dash_cooldown_time * distance)
	shouldnt_move = TRUE
	var/dir_to_target = get_dir(get_turf(src), get_turf(target))
	var/turf/next_turf = get_step(get_turf(src), dir_to_target)
	for(var/i in 1 to distance)
		new /obj/effect/temp_visual/cult/sparks(next_turf)
		next_turf = get_step(next_turf, dir_to_target)
	addtimer(CALLBACK(src, .proc/swift_dash2, dir_to_target, 0, distance), wait_time)
	playsound(src, 'sound/creatures/claw_prepare.ogg', 100, 1)

/mob/living/simple_animal/hostile/megafauna/claw/proc/swift_dash2(move_dir, times_ran, distance_run)
	if(times_ran > distance_run)
		shouldnt_move = FALSE
		return
	var/turf/next_turf = get_step(get_turf(src), move_dir)
	new /obj/effect/temp_visual/small_smoke/halfsecond(next_turf)
	forceMove(next_turf)
	playsound(src,'sound/creatures/claw_move.ogg', 50, 1)
	for(var/mob/living/hit_mob in next_turf.contents - src)
		hit_mob.Knockdown(15)
		hit_mob.attack_animal(src)
	addtimer(CALLBACK(src, .proc/swift_dash2, move_dir, (times_ran + 1), distance_run), 0.7)
/////DASH ATTACK END

/////DISSONANT SHREK
/mob/living/simple_animal/hostile/megafauna/claw/proc/emp_pulse()
	shake_animation(0.5)
	visible_message("<span class='danger'>[src] stops and shudders for a moment... </span>")
	shouldnt_move = TRUE
	addtimer(CALLBACK(src, .proc/emp_pulse2), 1 SECONDS)

/mob/living/simple_animal/hostile/megafauna/claw/proc/emp_pulse2()
	shake_animation(2)
	playsound(src, 'sound/voice/vox/vox_scream_1.ogg', 300, 1, 8, 8)
	empulse(src, 2, 4)
	shouldnt_move = FALSE

/////TENTACLE
/mob/living/simple_animal/hostile/megafauna/claw/proc/tentacle(target)
	shake_animation(2)
	projectiletype = /obj/projectile/tentacle
	projectilesound = 'sound/effects/splat.ogg'
	Shoot(target)

/////TENTACLE END

/////STING ATTACK
/mob/living/simple_animal/hostile/megafauna/claw/proc/sting_attack(target)
	shouldnt_move = TRUE
	visible_message("<span class='danger'>[src] stops suddenly and spikes apear all over it's body!</span>")
	icon_state = "claw-phase2_sting_attack"
	flick("claw-phase2_sting_attack_transform", src)
	projectiletype = /obj/projectile/claw_projectille
	projectilesound = 'sound/effects/splat.ogg'
	addtimer(CALLBACK(src, .proc/sting_attack2, target), 2 SECONDS)

/mob/living/simple_animal/hostile/megafauna/claw/proc/sting_attack2(target)
	visible_message("<span class='danger'>[src] shoots all the spikes!</span>")
	icon_state = "claw-phase2"
	shoot_projectile(Get_Angle(src,target) + 10)
	shoot_projectile(Get_Angle(src,target) + 5)
	shoot_projectile(Get_Angle(src,target))
	shoot_projectile(Get_Angle(src,target) - 5)
	shoot_projectile(Get_Angle(src,target) - 10)
	shouldnt_move = FALSE

/obj/projectile/claw_projectille
	name = "claw's spike"
	icon_state = "crystal_shard"
	damage = 15
	armour_penetration = 25
	damage_type = BRUTE
	speed = 4

/////STING ATTACK END

/////LIE SPIDER
/mob/living/simple_animal/hostile/megafauna/claw/proc/summon_creatures()
	shake_animation(20)
	visible_message("<span class='danger'>[src] shudders violently and starts to split a flesh spider from it's body!</span>")
	shouldnt_move = TRUE
	addtimer(CALLBACK(src, .proc/summon_creatures2), 2 SECONDS)

/mob/living/simple_animal/hostile/megafauna/claw/proc/summon_creatures2()
	shake_animation(5)
	var/mob/living/summoned_spider = new /mob/living/simple_animal/hostile/poison/giant_spider/hunter(get_turf(src))
	visible_message("<span class='danger'>[summoned_spider] violently tears apart from [src]!</span>")
	shouldnt_move = FALSE

/////LIE SPIDER END

/////PHASE SHIFT STUFF
/mob/living/simple_animal/hostile/megafauna/claw/death()
	. = ..()
	on_death() //this is because both stages have unique behavior on death, inlcuding stage one not dying

/mob/living/simple_animal/hostile/megafauna/claw/proc/on_death()
	flick("claw-phase1_transform",src) //woho you won... or did you?
	addtimer(CALLBACK(src, .proc/create_phase2), 30 SECONDS)

/mob/living/simple_animal/hostile/megafauna/claw/phase2/on_death()
	icon_state = "claw-phase2_dying"
	flick("claw-phase2_to_dying_anim",src)
	playsound(src, 'sound/voice/vox/vox_scream_1.ogg', 300, 1, 8, 8)
	addtimer(CALLBACK(src, .proc/phase2_dramatic, src), 3 SECONDS)
	return

/mob/living/simple_animal/hostile/megafauna/claw/proc/create_phase2() //this only exists so the timer can callback to this proc
	new /mob/living/simple_animal/hostile/megafauna/claw/phase2(get_turf(src))

/mob/living/simple_animal/hostile/megafauna/claw/proc/unlock_phase2()
	shouldnt_move = FALSE
	empulse(src, 3, 10) //changling's emp scream, right?
	explosion(src, 0, 0, 5) //dramatic
	playsound(src, 'sound/voice/vox/vox_scream_1.ogg', 300, 1, 8, 8) //jumpscare
	shake_animation(2)
	new /obj/effect/gibspawner/human(get_turf(src))
	name = "The CLAW"
	desc = "You aren't sure what this is and you are afraid to know."
	status_flags &= ~GODMODE

/mob/living/simple_animal/hostile/megafauna/claw/proc/phase2_dramatic()
	explosion(src, 0, 5, 10)
	empulse(src, 5, 8)
	new /obj/effect/gibspawner/human(get_turf(src))
	qdel(src)
