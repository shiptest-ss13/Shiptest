/mob/living/simple_animal/hostile/megafauna/claw
	name = "Trooper \"Claw\""
	desc = "This is Trooper \"Claw\".\
	They are holding a armblade in their right hand."
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
	pixel_x = 0

	crusher_loot = list(/obj/item/card/id/ert/deathsquad, /obj/item/documents/nanotrasen)
	loot = list(/obj/item/card/id/ert/deathsquad, /obj/item/documents/nanotrasen)
	wander = FALSE
	blood_volume = BLOOD_VOLUME_NORMAL
	gps_name = "NTAF-V"
	deathmessage = "stops moving..."
	deathsound = "bodyfall"
	footstep_type = FOOTSTEP_MOB_HEAVY
	attack_action_types = list(/datum/action/innate/megafauna_attack/swift_dash,
								/datum/action/innate/megafauna_attack/swift_dash_long)
	pixel_x = -16
	var/shoudnt_move = FALSE
	var/dash_num_short = 4
	var/dash_num_long = 18
	var/dash_cooldown = 0
	var/dash_cooldown_time = 4 // cooldown_time * distance:
	// 4 * 4 = 16 (1.6 seconds)
	// 4 * 18 = 72 (7.2 seconds)
	var/phase = 1 //at about 25% hp, they will "die", and then come back with even more attacks

/mob/living/simple_animal/hostile/megafauna/claw/phase2
	icon_state = "claw-phase2"
	icon_living = "claw-phase2"
	gps_name = "F453C619AE278"
	deathsound = "bodyfall"
	speed = 5
	move_to_delay = 5
	speak_emote = list("verbalizes")
	crusher_loot = list(/obj/effect/spawner/clawloot)
	loot = list(/obj/effect/spawner/clawloot/crusher)
	health = 2250
	maxHealth = 2250
	shoudnt_move = TRUE //we want to show the transforming animation
	phase = 2

/obj/effect/spawner/clawloot/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/spawn_loot), 5 SECONDS) //this is because it dies violently exploding, so we dont want to destroy the goodies, you know?

/obj/effect/spawner/clawloot/proc/spawn_loot()
	new /obj/item/gun/energy/pulse/pistol(get_turf(src))
	qdel(src)

/obj/effect/spawner/clawloot/crusher/spawn_loot()
	new /obj/item/nullrod/armblade/tentacle(get_turf(src)) //idk what to put here, memed is the loot person
	return ..()
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

/datum/action/innate/megafauna_attack/pulse_rifle
	name = "Tentacle"
	icon_icon = 'icons/obj/guns/energy.dmi'
	button_icon_state = "pulse"
	chosen_message = "<span class='colossus'>You will now stop, and telegraph a attack that will shoot either: Pulse lasers, electrodes, or regular lasers depending on health.</span>"
	chosen_attack_num = 6

/datum/action/innate/megafauna_attack/string_attack
	name = "Sting shotgun"
	icon_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "sting_cryo"
	chosen_message = "<span class='colossus'>You stop, and telegraph a shotgun of stings.</span>"
	chosen_attack_num = 7

/mob/living/simple_animal/hostile/megafauna/claw/phase2/Initialize()
	. = ..()
	flick("claw-phase2_transform",src) //plays the transforming animation
	addtimer(CALLBACK(src, .proc/unlock_phase2), 4.4 SECONDS)

/mob/living/simple_animal/hostile/megafauna/claw/Move()
	if(shoudnt_move)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/megafauna/claw/OpenFire()
	if(client)
		if(shoudnt_move)
			return
		switch(chosen_attack)
			if(1) //these SHOULDNT fire during phase 2, but if they do have fun with the extra attacks
				swift_dash(target, dash_num_short, 5)
			if(2)
				swift_dash(target, dash_num_long, 15)
			if(3) //only should fire duing phase 2
				emp_pulse()
			if(4)
				tentacle()
			if(5)
				summon_creatures()
			if(6)
				pulse_rifle()
			if(7)
		return

	Goto(target, move_to_delay, minimum_distance)
	if(phase == 1)
		if(get_dist(src, target) >= 3 && dash_cooldown <= world.time && !shoudnt_move)
			swift_dash(target, dash_num_short, 5)
		if(get_dist(src, target) > 5 && dash_cooldown <= world.time && !shoudnt_move)
			swift_dash(target, dash_num_long, 15)
//to be implmented

/mob/living/simple_animal/hostile/megafauna/claw/proc/swift_dash(target, distance, wait_time)
	if(dash_cooldown > world.time)
		return
	dash_cooldown = world.time + (dash_cooldown_time * distance)
	shoudnt_move = TRUE
	var/dir_to_target = get_dir(get_turf(src), get_turf(target))
	var/turf/T = get_step(get_turf(src), dir_to_target)
	for(var/i in 1 to distance)
		new /obj/effect/temp_visual/cult/sparks(T)
		T = get_step(T, dir_to_target)
	addtimer(CALLBACK(src, .proc/swift_dash2, dir_to_target, 0, distance), wait_time)
	playsound(src, 'sound/creatures/claw_prepare.ogg', 100, 1)

/mob/living/simple_animal/hostile/megafauna/claw/proc/swift_dash2(move_dir, times_ran, distance_run)
	if(times_ran > distance_run)
		shoudnt_move = FALSE
		return
	var/turf/T = get_step(get_turf(src), move_dir)
	new /obj/effect/temp_visual/small_smoke/halfsecond(T)
	forceMove(T)
	playsound(src,'sound/creatures/claw_move.ogg', 50, 1)
	for(var/mob/living/L in T.contents - src)
		L.Knockdown(15)
		L.attack_animal(src)
//		new /obj/effect/temp_visual/cleave(L.loc)
	addtimer(CALLBACK(src, .proc/swift_dash2, move_dir, (times_ran + 1), distance_run), 0.7)

/mob/living/simple_animal/hostile/megafauna/claw/proc/emp_pulse()
	shake_animation(0.5)
	visible_message("<span class='danger'> [src] stops and shudders for a moment... </span>")
	shoudnt_move = TRUE
	addtimer(CALLBACK(src, .proc/emp_pulse2), 1 SECONDS)

/mob/living/simple_animal/hostile/megafauna/claw/proc/emp_pulse2()
	shake_animation(2)
	playsound(src, 'sound/voice/vox/vox_scream_1.ogg', 300, 1, 8, 8)
	empulse(src, 2, 4)
	shoudnt_move = FALSE

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
	shoudnt_move = FALSE
	empulse(src, 3, 10) //changling's emp scream, right?
	explosion(src, 0, 0, 5) //dramatic
	playsound(src, 'sound/voice/vox/vox_scream_1.ogg', 300, 1, 8, 8) //jumpscare
	shake_animation(2)
	new /obj/effect/gibspawner/human(get_turf(src))
	name = "The CLAW"
	desc = "You aren't sure what this is and you are afraid to know."

/mob/living/simple_animal/hostile/megafauna/claw/proc/phase2_dramatic()
	explosion(src, 0, 5, 10)
	empulse(src, 5, 8)
	new /obj/effect/gibspawner/human(get_turf(src))
	qdel(src)

