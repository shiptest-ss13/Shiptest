/mob/living/simple_animal/hostile/megafauna/ripley_lobster
	name = "\improper APLU MK-I \"Lobster\""
	desc = "A old abandoned powerloader, that was once used for warfare. Now it seeks out blood, with its many hidden weapons."
	health = 2000
	maxHealth = 2000
	icon_state = "hauler"
	icon_living = "hauler"
	icon = 'icons/mecha/mecha.dmi'
	mob_biotypes = MOB_ROBOTIC|MOB_EPIC
	movement_type = GROUND
	speak_emote = list("beeps")
	melee_damage_lower = 10
	melee_damage_upper = 10
	aggro_vision_range = 18 // semi bullet hell so large vision range
	speed = 6
	light_range = 20
	projectiletype = /obj/projectile/beam/hitscan/laser
	projectilesound = 'sound/weapons/laser.ogg'
	ranged = TRUE
	ranged_cooldown_time = 20
	move_to_delay = 4
	vision_range = 10
	loot = list(/obj/item/assembly/signaler/anomaly/bluespace, /obj/structure/mecha_wreckage/ripley) //well what else do I give them?
	crusher_loot = list(/obj/item/assembly/signaler/anomaly/bluespace, /obj/structure/mecha_wreckage/ripley, /obj/item/gun/ballistic/rocketlauncher/unrestricted) //seeing as killing things with a crusher is more impressive, ill give them a rpg.
	wander = FALSE
	del_on_death = TRUE
	gps_name = "Robotic Signal"
	deathmessage = "seizes up, and glows a ominus red, then goes silent."
	attack_sound = 'sound/weapons/sonic_jackhammer.ogg'
	footstep_type = FOOTSTEP_MOB_MECHA
	attack_action_types = list(/datum/action/innate/megafauna_attack/drill_dash,
								/datum/action/innate/megafauna_attack/missle_barrage,
								/datum/action/innate/megafauna_attack/laser_barrage,
								/datum/action/innate/megafauna_attack/flamethrower,
								/datum/action/innate/megafauna_attack/bolt_spiral,
								/datum/action/innate/megafauna_attack/pulse_fire,
								/datum/action/innate/megafauna_attack/self_destuct)
	move_force = MOVE_FORCE_NORMAL
	var/attack_count = 3 //how many attacks in a row?
	var/speed_mod = 1 //how much time it takes for a attack?
//	var/allow_self_destruct = FALSE //if lobster is allowed to proc "self destruct"
	var/charging = TRUE //if drill dash is happening

/datum/action/innate/megafauna_attack/drill_dash
	name = "Dril Dash"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_overload_on"
	chosen_message = "<span class='colossus'>You are now dashing through your target three times in a row, destroying any rock in the way.</span>"
	chosen_attack_num = 1

/datum/action/innate/megafauna_attack/missle_barrage
	name = "Missle Barrage"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_thrusters_on"
	chosen_message = "<span class='colossus'>You are now firing missles, hitting in the line of fire to the telegraphed target.</span>"
	chosen_attack_num = 2

/datum/action/innate/megafauna_attack/laser_barrage
	name = "Laser Barrage"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_zoom_on"
	chosen_message = "<span class='colossus'>You are now shooting hitscan lasers, hitting anybody in the line of fire of your telegraphed targets.</span>"
	chosen_attack_num = 3

/datum/action/innate/megafauna_attack/flamethrower
	name = "Flamethrower"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_damtype_fire"
	chosen_message = "<span class='colossus'>You are now firing a flamethrower, dealing no damage while setting a radius around the impact on fire.</span>"
	chosen_attack_num = 4

/datum/action/innate/megafauna_attack/bolt_spiral
	name = "Bolt Spiral"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_defense_mode_on"
	chosen_message = "<span class='colossus'>You firing a series of taser bolts around yourself.</span>"
	chosen_attack_num = 5

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/Move()
	if(charging)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/OpenFire()
	adjust_health_difficulty() //checks the health, and adjusts the diffculty of the boss acordingly

	if(client) //checks if the boss is player controlled
		switch(chosen_attack) //if so, checks which attack they selected
			if(1)
				drill_dash(target)
//			if(2)
//				missle_barrage(target)
//			if(3)
//				laser_barrage(target)
			if(4)
				flamethrower(target)
//			if(5)
//				bolt_spiral()
		return

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/proc/adjust_health_difficulty() //checks the health, and adjusts the diffculty of the boss acordingly
	if(health <= maxHealth*0.25) //start off easy peasy...
		speed = 4
		attack_count = 1 //multi-attacks with the exception of drill dash will only repeat once
		speed_mod = 2.5 //atacks are telegraphed for 2.5x as long
	else if(health <= maxHealth*0.5) // taking off the training wheels
		speed = 4.8
		attack_count = 1 //multi-attacks with the exception of drill dash will only repeat once
		speed_mod = 2 //atacks are telegraphed for 2x as long
	else if(health <= maxHealth*0.75) // you almost got them!
		speed = 5.4
		attack_count = 2 //multi-attacks with the exception of drill dash will only repeat twice
		speed_mod = 1.5 //atacks are telegraphed for 1.5x as long
	else if(health > maxHealth*0.75) // almost dead, almost there!
		speed = initial(speed)
		attack_count = initial(attack_count) //attacks will repeat 3 times
		speed_mod = initial(speed_mod) //attacks will be telegraphed normally
//		allow_self_destruct = TRUE //rare chance of happening, you better watch out

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/proc/drill_dash(target)
	charging = TRUE
	for(var/i = 0, i=<3, i++)
		charge(target)
	charging = FALSE

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/proc/charge(atom/chargeat = target, delay = 5, chargepast = 2)
	if(!chargeat)
		return
	var/chargeturf = get_turf(chargeat)
	if(!chargeturf)
		return
	var/dir = get_dir(src, chargeturf)
	var/turf/T = get_ranged_target_turf(chargeturf, dir, chargepast)
	if(!T)
		return
	revving_charge = TRUE
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

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/proc/flamethrower(atom/at = target) //literally copied and pasted from ashdrake
	if(charging)
		return FALSE
	for(var/i = 0, i < attack_count, i++)
		playsound(get_turf(src),'sound/magic/fireball.ogg', 200, TRUE) //todo, port turf fires some day
		SLEEP_CHECK_DEATH(0)
		var/range = 15
		var/list/turfs = list()
		turfs = line_target(rand(-20,20), range, at)
		INVOKE_ASYNC(src, .proc/fire_line, turfs)

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/proc/line_target(offset, range, atom/at = target) //same as above
	if(!at)
		return
	var/angle = ATAN2(at.x - src.x, at.y - src.y) + offset
	var/turf/T = get_turf(src)
	for(var/i in 1 to range)
		var/turf/check = locate(src.x + cos(angle) * i, src.y + sin(angle) * i, src.z)
		if(!check)
			break
		T = check
	return (getline(src, T) - get_turf(src))

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/proc/fire_line(var/list/turfs) //same as above
	SLEEP_CHECK_DEATH(0)
	dragon_fire_line(src, turfs)
