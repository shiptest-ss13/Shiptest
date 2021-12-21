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
	loot = list(/obj/item/claymore/cursed, /obj/item/clothing/suit/space/hardsuit/cult/enchanted)
	crusher_loot = list(/obj/item/claymore/cursed, /obj/item/clothing/suit/space/hardsuit/cult/enchanted, /obj/item/upgradescroll)
	wander = FALSE
	del_on_death = TRUE
	gps_name = "Robotic Signal"
	deathmessage = "Seizes up, and glows a ominus red."
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
	var/allow_self_destruct = FALSE
	var/charging = TRUE

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

/datum/action/innate/megafauna_attack/pulse_fire
	name = "Pulse Fire"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_defense_mode_on"
	chosen_message = "<span class='colossus'>You now fire a extremely telegraphed pulse laser.</span>"
	chosen_attack_num = 6

/datum/action/innate/megafauna_attack/self_destuct
	name = "Self Destruct"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_eject"
	chosen_message = "<span class='colossus'>You will now explode in a maxcap sized explosion, after 20 seconds.</span>"
	chosen_attack_num = 7

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/Move()
	if(charging)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/OpenFire()
	adjust_health_difficulty() //checks the health, and adjusts the diffculty of the boss acordingly

	if(client) //checks if the boss is player controlled
		switch(chosen_attack) //if so, checks which attack they selected
//			if(1)
//				drill_dash(target)
//			if(2)
//				missle_barrage(target)
//			if(3)
//				laser_barrage(target)
			if(4)
				flamethrower(target)
			if(5)
				pulse_fire(target)
			if(6)
				pulse_fire(target)
			if(7)
				self_destuct()
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
		attack_count = initial(attack_count) //attacks will repeat 3 times with the exception of drill dash
		speed_mod = initial(speed_mod) //attacks will be telegraphed normally
		allow_self_destruct = TRUE //rare chance of happening, you better watch out

/mob/living/simple_animal/hostile/megafauna/cult_templar/proc/blood_dash(target)
	if(charging)
		return
	dash_cooldown = world.time + (initial(dash_cooldown) * dash_mod)
	charging = TRUE
	var/dir_to_target = get_dir(get_turf(src), get_turf(target))
	var/turf/T = get_step(get_turf(src), dir_to_target)
	for(var/i in 1 to dash_num)
		new /obj/effect/temp_visual/target(T)
		T = get_step(T, dir_to_target)
	addtimer(CALLBACK(src, .proc/blood_dash_2, dir_to_target, 0), (5 * dash_mod))
	playsound(src,'sound/effects/meteorimpact.ogg', 200, 1)

/mob/living/simple_animal/hostile/megafauna/cult_templar/proc/blood_dash_2(move_dir, times_ran)
	if(times_ran >= dash_num)
		charging = FALSE
		return
	var/turf/T = get_step(get_turf(src), move_dir)
	if(ismineralturf(T))
		var/turf/closed/mineral/M = T
		M.gets_drilled()
	if(T.density)
		charging = FALSE
		return
	for(var/obj/structure/window/W in T.contents)
		charging = FALSE
		return
	for(var/obj/machinery/door/D in T.contents)
		if(D.density)
			charging = FALSE
			return
	forceMove(T)
	playsound(src,'sound/mecha/mechstep.ogg', 200, 1)
	for(var/mob/living/L in T.contents - src)
		visible_message("<span class='boldwarning'>[src] runs through [L]!</span>")
		to_chat(L, "<span class='userdanger'>[src] pierces you with a drill!</span>")
		shake_camera(L, 4, 3)
		L.adjustBruteLoss(30)
		playsound(L,"sound/misc/desceration-[pick(1,2,3)].ogg", 200, 1)
	addtimer(CALLBACK(src, .proc/blood_dash_2, move_dir, (times_ran + 1)), (1.5 * dash_mod))

/mob/living/simple_animal/hostile/megafauna/ripley_lobster/proc/flamethrower(atom/at = target) //literally copied and pasted from ashdrake
	if(charging)
		return FALSE
	for(var/i = 0, i < attack_count, i++)
		playsound(get_turf(src),'sound/magic/fireball.ogg', 200, TRUE)
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
