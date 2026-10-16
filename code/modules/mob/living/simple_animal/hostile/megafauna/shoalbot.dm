/*

The Shoalbot (placeholder name)

Shoalbot attacks:
AI attacks
- Shoot 2 beams in quick succession, 4 beams when at half health with warning like Tortoise
- Make a square of tiles that will be compressed (gravity attack); stand in them too long, take damage
- Make a cross of tiles that will also be compressed
- Teleport near target, make small gravity blast around destination

- When in melee range the bot will either: directly crush the target with gravity (melee attack), or release an expanding blast of gravity
*/

/mob/living/simple_animal/hostile/megafauna/shoalbot
	name = "\"Watcher\" Ancient Machinemind"
	desc = "A large, alien sphere stares down at you with an intimidating eye. A constantly shifting mess of wires trails down as it gently floats in the air. \
	The floating objects near the main 'body' of the machine seem to track your movements with eerie accuracy."
	health = 1500
	maxHealth = 1500
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	attack_verb_continuous = "crushes"
	attack_verb_simple = "crush"
	attack_sound = 'sound/weapons/resonator_blast.ogg'
	icon_state = "shoalbot"
	icon_living = "shoalbot"
	icon_dead = "shoalbot"

	health_doll_icon = "shoalbot"
	friendly_verb_continuous = "gently pushes"
	friendly_verb_simple = "gently push"
	icon = 'icons/mob/lavaland/64x64megafauna.dmi'
	faction = list("boss")
	speak_emote = list("states")
	on_aggro_say = list("INFILTRATOR/INTRUDER/INTERLOPER DETECTED. REMOVING.", "YAAHKRAW-KIIRAW. NEW TARGET AQUIRED. REMOVING.", "KITITI KRICHA KRIKI. INITIATING.")
	aggro_say_chance = 100

	armour_penetration = 50
	melee_damage_lower = 25
	melee_damage_upper = 25

	retreat_distance = 0
	minimum_distance = 1
	rapid_melee = 2
	is_flying_animal = FALSE

	ranged = TRUE
	projectiletype = null
	casingtype = /obj/item/ammo_casing/energy/pgf/assault
	spread = 7
	rapid_fire_delay = 3
	var/blast_wind_up = 12
	stat_attack = SOFT_CRIT

	speed = 10
	move_to_delay = 10
	ranged_cooldown_time = 30
	mob_trophy = /obj/item/mob_trophy/obol
	wander = FALSE
	gps_name = "Glitchy Signal"
	deathsound = 'sound/magic/repulse.ogg'
	attack_action_types = list(
		/datum/action/innate/megafauna_attack/blink,
		/datum/action/innate/megafauna_attack/cross_blasts,
		/datum/action/innate/megafauna_attack/double_blast,
		/datum/action/innate/megafauna_attack/expanding_blast)

	pixel_x = -16
	base_pixel_x = -16

	var/burst_range = 3 //range on burst aoe
	var/beam_range = 2 //range on cross blast beams
	var/major_attack_cooldown = 50 //base cooldown for major attacks
	var/blinking = FALSE //if we're doing something that requires us to stand still and not attack
	var/list/unaggro_phrases = list("THREAT/INTRUDER/NUISANCE REMOVED.", "ENTITY/OBJECT/DATA REMOVED.", "KII KRIRA KHIKI. PREVENTED AQUIRE.", "CHIHAAH KEH KKIRA WKTIKRA. DENIED.")

// Actions

/datum/action/innate/megafauna_attack/blink
	name = "Blink To Target"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"
	chosen_message = span_colossus("You are now blinking to your target.")
	chosen_attack_num = 1

/datum/action/innate/megafauna_attack/cross_blasts
	name = "Cross Blasts"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "shoalbot_blast_indefinite"
	chosen_message = span_colossus("You are now firing cross blasts at your target.")
	chosen_attack_num = 2

/datum/action/innate/megafauna_attack/double_blast
	name = "Double Blast"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "etherbor_laser_kill"
	chosen_message = span_colossus("You are now firing two laser blasts at your target.")
	chosen_attack_num = 3

/datum/action/innate/megafauna_attack/expanding_blast
	name = "Expanding Blast"
	icon_icon = 'icons/effects/effects.dmi'
	button_icon_state = "shoalbot_squares_indefinite"
	chosen_message = span_colossus("You are now firing an expanding blast from yourself.")
	chosen_attack_num = 4

/mob/living/simple_animal/hostile/megafauna/shoalbot/OpenFire()
	if(blinking)
		return

	calculate_rage()
	var/blink_counter = 1 + round(anger_modifier * 0.08)
	var/cross_counter = 1 + round(anger_modifier * 0.12)

	ranged_cooldown = world.time + max(5, ranged_cooldown_time - anger_modifier * 0.75) //scale cooldown lower with high anger.

	if(client)
		switch(chosen_attack)
			if(1)
				blink(target)
			if(2)
				cross_blast_spam(blink_counter, cross_counter)
			if(3)
				doubleblast()
			if(4)
				INVOKE_ASYNC(src, PROC_REF(burst), get_turf(src), 0.25)
		return

	// On a low chance + how angry we are AND if we have more than one cross attack available, then we spam
	if(prob(20 + anger_modifier && cross_counter > 1))
		cross_blast_spam(blink_counter, cross_counter)
	else
		if(prob(50))
			if(prob(50))
				playsound(src,'sound/effects/gravityblast.ogg', 200, TRUE)
				INVOKE_ASYNC(src, PROC_REF(blasts), target, GLOB.cardinals)
			else
				playsound(src,'sound/effects/gravityblast.ogg', 200, TRUE)
				INVOKE_ASYNC(src, PROC_REF(blasts), target, GLOB.diagonals)
		else if(prob(50))
			playsound(src,'sound/effects/gravityblast.ogg', 200, TRUE)
			blink(target)
		else if(prob(50))
			playsound(src,'sound/effects/gravityblast.ogg', 200, TRUE)
			melee_blast(target)
		else
			doubleblast()

/mob/living/simple_animal/hostile/megafauna/shoalbot/Aggro()
	. = ..()
	icon_state = "shoalbot_aggro"
	icon_living = "shoalbot_aggro"
	icon_dead = "shoalbot_aggro"

/mob/living/simple_animal/hostile/megafauna/shoalbot/LoseAggro()
	. = ..()
	icon_state = "shoalbot"
	icon_living = "shoalbot"
	icon_dead = "shoalbot"
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, say), "[pick(unaggro_phrases)]")


/mob/living/simple_animal/hostile/megafauna/shoalbot/proc/cross_blast_spam(blink_counter, cross_counter)
	ranged_cooldown = world.time + max(5, major_attack_cooldown - anger_modifier * 0.75)
	blinking = TRUE
	var/oldcolor = color
	animate(src, color = "#83c3ff", time = 6)
	SLEEP_CHECK_DEATH(6)
	while(!QDELETED(target) && cross_counter)
		cross_counter--
		if(prob(60))
			INVOKE_ASYNC(src, PROC_REF(blasts), target, GLOB.cardinals)
		else
			INVOKE_ASYNC(src, PROC_REF(blasts), target, GLOB.diagonals)
		SLEEP_CHECK_DEATH(6)
	animate(src, color = oldcolor, time = 8)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, update_atom_colour)), 8)
	SLEEP_CHECK_DEATH(8)
	blinking = FALSE

/mob/living/simple_animal/hostile/megafauna/shoalbot/proc/blasts(mob/victim, list/directions = GLOB.cardinals) //fires cross blasts with a delay
	var/turf/T = get_turf(victim)
	new /obj/effect/temp_visual/shoalbot/blast(T, src, FALSE)
	for(var/d in directions)
		INVOKE_ASYNC(src, PROC_REF(blast_wall), T, d)

/mob/living/simple_animal/hostile/megafauna/shoalbot/proc/blink(mob/victim) //blink to a target
	if(blinking || !victim)
		return
	var/turf/T = get_turf(victim)
	var/turf/source = get_turf(src)
	playsound(T,'sound/magic/wand_teleport.ogg', 200, TRUE)
	playsound(source,'sound/machines/airlockopen.ogg', 200, TRUE)
	blinking = TRUE
	SLEEP_CHECK_DEATH(2) //short delay before we start...
	for(var/t in RANGE_TURFS(1, T))
		var/obj/effect/temp_visual/shoalbot/blast/B = new(t, src, FALSE)
		B.damage = 30
	for(var/t in RANGE_TURFS(1, source))
		var/obj/effect/temp_visual/shoalbot/blast/B = new(t, src, FALSE)
		B.damage = 30
	animate(src, alpha = 0, time = 2, easing = EASE_OUT) //fade out
	SLEEP_CHECK_DEATH(1)
	density = FALSE
	SLEEP_CHECK_DEATH(2)
	forceMove(T)
	SLEEP_CHECK_DEATH(1)
	animate(src, alpha = 255, time = 2, easing = EASE_IN) //fade IN
	SLEEP_CHECK_DEATH(1)
	density = TRUE
	SLEEP_CHECK_DEATH(1) //at this point the blasts we made detonate
	blinking = FALSE

/mob/living/simple_animal/hostile/megafauna/shoalbot/proc/doubleblast() // shoot 2 or 4 blasts in quick succession depending on current health
	var/num_shots = 2
	if(health < maxHealth/2)
		num_shots = 4
	wind_up_visual()
	SLEEP_CHECK_DEATH(blast_wind_up)
	var/datum/callback/fire = CALLBACK(src, PROC_REF(shoot_projectile), get_turf(target))
	for(var/i in 1 to num_shots)
		addtimer(fire, (i - 1)*rapid_fire_delay)

/mob/living/simple_animal/hostile/megafauna/shoalbot/proc/wind_up_visual()
	playsound(src, 'sound/machines/synth_yes.ogg', 200, TRUE, 3, frequency = 6120)
	visible_message(span_danger("\The [src] charges up it's lasers!"))
	new /obj/effect/temp_visual/shoalbot/laser(loc,src)


/mob/living/simple_animal/hostile/megafauna/shoalbot/proc/melee_blast(mob/victim) //make a 3x3 blast around a target
	if(!victim)
		return
	var/turf/T = get_turf(victim)
	if(!T)
		return
	SLEEP_CHECK_DEATH(2)
	for(var/t in RANGE_TURFS(1, T))
		new /obj/effect/temp_visual/shoalbot/blast(t, src, FALSE)

/mob/living/simple_animal/hostile/megafauna/shoalbot/proc/blast_wall(turf/T, set_dir) //make a wall of blasts beam_range tiles long
	var/range = beam_range
	var/turf/previousturf = T
	var/turf/J = get_step(previousturf, set_dir)
	for(var/i in 1 to range)
		new /obj/effect/temp_visual/shoalbot/blast(J, src, FALSE)
		previousturf = J
		J = get_step(previousturf, set_dir)

//expanding square
/proc/shoalbot_burst(mob/caster, turf/original, burst_range, spread_speed = 0.5)
	playsound(original,'sound/machines/airlockopen.ogg', 200, TRUE)
	var/last_dist = 0
	for(var/t in spiral_range_turfs(burst_range, original))
		var/turf/T = t
		if(!T)
			continue
		var/dist = get_dist(original, T)
		if(dist > last_dist)
			last_dist = dist
			sleep(1 + min(burst_range - last_dist, 12) * spread_speed) //gets faster as it gets further out
		new /obj/effect/temp_visual/shoalbot/blast(T, caster, FALSE)

/mob/living/simple_animal/hostile/megafauna/shoalbot/proc/burst(turf/original, spread_speed)
	shoalbot_burst(src, original, burst_range, spread_speed)

/mob/living/simple_animal/hostile/megafauna/shoalbot/death(gibbed, list/force_grant)
	. = ..()
	shoalbot_burst(null, get_turf(src), 7)
	visible_message(span_danger("\The [src] releases a shrill alarm as it suddenly begins to collapse in on itself!"))
	playsound(src,'sound/machines/alarm.ogg',200,FALSE,2)
	Shake(5,5, 13 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(self_destruct)), 13 SECONDS)

/mob/living/simple_animal/hostile/megafauna/shoalbot/proc/self_destruct()
	visible_message("A sphere shoots out from the collapsing shoalbot - just before the shoalbot disappears into nothingness!")
	qdel_self()

/mob/living/simple_animal/hostile/megafauna/shoalbot/Life()
	. = ..()
	if(health < maxHealth/2)
		if(!particles)
			particles = new /particles/smoke/steam/vent
	else if(particles)
		particles = null

/mob/living/simple_animal/hostile/megafauna/shoalbot/CanAttack(atom/the_target)
	. = ..()
	if(istype(the_target, /mob/living/simple_animal/hostile/asteroid/hivelordbrood)) //ignore temporary targets in favor of more permanent targets
		return FALSE

/mob/living/simple_animal/hostile/megafauna/shoalbot/AttackingTarget()
	if(!blinking)
		if(target && isliving(target))
			var/mob/living/L = target
			if(L.stat != DEAD)
				if(prob(50))
					INVOKE_ASYNC(src, PROC_REF(burst), get_turf(src), 0.25)
				else
					..()
		else
			return ..()

/mob/living/simple_animal/hostile/megafauna/shoalbot/DestroySurroundings()
	if(!blinking)
		..()

/mob/living/simple_animal/hostile/megafauna/shoalbot/Move()
	if(!blinking)
		. = ..()

/mob/living/simple_animal/hostile/megafauna/shoalbot/Goto(target, delay, minimum_distance)
	if(!blinking)
		..()

/mob/living/simple_animal/hostile/megafauna/shoalbot/proc/calculate_rage() //how angry we are overall
	anger_modifier = clamp(((maxHealth - health) / 42),0,50)
	burst_range = initial(burst_range) + round(anger_modifier * 0.08)
	beam_range = initial(beam_range) + round(anger_modifier * 0.12)

//shoalbot overlays
/obj/effect/temp_visual/shoalbot
	name = "vortex energy"
	layer = BELOW_MOB_LAYER
	var/mob/living/caster //who made this, anyway

/obj/effect/temp_visual/shoalbot/Initialize(mapload, new_caster)
	. = ..()
	if(new_caster)
		caster = new_caster

/obj/effect/temp_visual/shoalbot/laser
	name = ""
	icon = 'icons/mob/lavaland/64x64megafauna.dmi'
	icon_state = "laser_indicator_shoal"
	duration = 10
	pixel_x = -16
	base_pixel_x = -16
	layer = FLY_LAYER
	var/target

/obj/effect/temp_visual/shoalbot/laser/Initialize(mapload, new_target)
	. = ..()
	target = new_target
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, orbit), target, 0, FALSE, 0, 0, FALSE, TRUE)

/obj/effect/temp_visual/shoalbot/squares
	icon_state = "shoalbot_squares"
	duration = 3
	light_range = MINIMUM_USEFUL_LIGHT_RANGE
	randomdir = FALSE

/obj/effect/temp_visual/shoalbot/squares/Initialize(mapload, new_caster)
	. = ..()
	if(ismineralturf(loc))
		var/turf/closed/mineral/M = loc
		M.gets_drilled(caster)

/obj/effect/temp_visual/shoalbot/blast
	icon_state = "shoalbot_blast"
	name = "gravitic blast"
	light_range = 2
	light_power = 2
	desc = "Get out of the way!"
	duration = 9
	var/damage = 10 //how much damage do we do?
	var/monster_damage_boost = TRUE //do we deal extra damage to monsters? Used by the boss
	var/list/hit_things = list() //we hit these already, ignore them
	var/friendly_fire_check = FALSE
	var/bursting = FALSE //if we're bursting and need to hit anyone crossing us

/obj/effect/temp_visual/shoalbot/blast/Initialize(mapload, new_caster, friendly_fire)
	. = ..()
	friendly_fire_check = friendly_fire
	if(new_caster)
		hit_things += new_caster
	if(ismineralturf(loc)) //drill mineral turfs
		var/turf/closed/mineral/M = loc
		M.gets_drilled(caster)
	INVOKE_ASYNC(src, PROC_REF(blast))
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/temp_visual/shoalbot/blast/proc/blast()
	var/turf/T = get_turf(src)
	if(!T)
		return
	sleep(6) //wait a little
	bursting = TRUE
	do_damage(T) //do damage and mark us as bursting
	sleep(1.3) //slightly forgiving; the burst animation is 1.5 deciseconds
	bursting = FALSE //we no longer damage crossers

/obj/effect/temp_visual/shoalbot/blast/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(bursting)
		do_damage(get_turf(src))

/obj/effect/temp_visual/shoalbot/blast/proc/do_damage(turf/T)
	if(!damage)
		return
	for(var/mob/living/L in T.contents - hit_things) //find and damage mobs...
		hit_things += L
		if((friendly_fire_check && caster && caster.faction_check_mob(L)) || L.stat == DEAD)
			continue
		if(L.client)
			flash_color(L.client, "#83c3ff", 1)
		playsound(L,'sound/weapons/resonator_blast.ogg', 50, TRUE, -4)
		to_chat(L, span_userdanger("You're struck by a [name]!"))
		var/limb_to_hit = L.get_bodypart(pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
		var/armor = L.run_armor_check(limb_to_hit, "melee", 50, FALSE, "Your armor absorbs [src]!", "Your armor blocks part of [src]!", "Your armor was penetrated by [src]!")
		L.apply_damage(damage, BRUTE, limb_to_hit, armor)
		if(ishostile(L))
			var/mob/living/simple_animal/hostile/H = L //mobs find and damage you...
			if(H.stat == CONSCIOUS && !H.target && H.AIStatus != AI_OFF && !H.client)
				if(!QDELETED(caster))
					if(get_dist(H, caster) <= H.aggro_vision_range)
						H.FindTarget(list(caster), 1)
					else
						H.Goto(get_turf(caster), H.move_to_delay, 3)
		if(monster_damage_boost && (ismegafauna(L) || istype(L, /mob/living/simple_animal/hostile/asteroid)))
			L.adjustBruteLoss(damage)
		if(caster)
			log_combat(caster, L, "struck with a [name]")
	for(var/obj/mecha/M in T.contents - hit_things) //also damage mechs.
		hit_things += M
		if(M.occupant)
			if(friendly_fire_check && caster && caster.faction_check_mob(M.occupant))
				continue
			to_chat(M.occupant, span_userdanger("Your [M.name] is struck by a [name]!"))
		playsound(M,'sound/weapons/resonator_blast.ogg', 50, TRUE, -4)
		M.take_damage(damage, BRUTE, 0, 0)
