/mob/living/simple_animal/hostile/automated
	name = "Rover"
	desc = "A small unarmed rover. You shouldn't see this."
	gender = NEUTER
	icon = 'icons/mob/aibots.dmi'
	icon_state = "quadrotor_indie"
	status_flags = CANSTUN|CANKNOCKDOWN|CANPUSH
	mouse_opacity = MOUSE_OPACITY_ICON
	a_intent = INTENT_HARM
	robust_searching = TRUE
	stat_attack = UNCONSCIOUS
	shoot_point_blank = TRUE
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	move_to_delay = 10
	ranged = 1
	health = 20
	maxHealth = 20
	environment_smash = ENVIRONMENT_SMASH_NONE
	speak_emote = list("states")
	del_on_death = TRUE
	faction = list(FACTION_HOSTILE)
	loot = list(/obj/effect/decal/cleanable/robot_debris)
	speech_span = SPAN_ROBOT

/mob/living/simple_animal/hostile/automated/quadrotor
	name = "Quadrotor drone"
	desc = "A lightweight quadrotor drone design carrying a gimbal-mounted .45 pistol. Ubiquitous across the frontier for its ease of manufacture and set-and-forget nature."
	icon_state = "quadrotor_indie"
	health = 45
	maxHealth = 45
	move_to_delay = 5
	projectilesound = 'sound/weapons/gun/pistol/candor.ogg'
	retreat_distance = 3
	minimum_distance = 4
	casingtype = /obj/projectile/bullet/c45
	deathmessage = "falls to the ground, sparking as its rotors grind to a halt."
	is_flying_animal = TRUE

/mob/living/simple_animal/hostile/automated/quadrotor/frontiersman
	name = "Gremlin Drone"
	desc = "A cobbled together drone used by the Frontiersmen fleet for reconnaissance and cheap ranged support. An automatic nine-millimeter machinepistol hoisted underneath it mirrors your movements."
	rapid = 6
	rapid_fire_delay = 1.5
	spread = 12
	projectilesound = 'sound/weapons/gun/smg/spitter.ogg'
	casingtype = /obj/item/ammo_casing/c9mm
	faction = list(FACTION_ANTAG_FRONTIERSMEN)

/mob/living/simple_animal/hostile/automated/quadrotor/cybersun
	name = "Malfunctioning Y-09-CS Drone"
	desc = "A military drone manufactured by Cybersun. Used extensively during the Inter-Corporate War, a large number have found themselves in disrepair and malfunctioning in the years since. The 5.7x39mm pistol on its gimbal is still active, however."
	health = 60
	maxHealth = 60
	rapid = 1
	rapid_fire_delay = 3
	projectilesound = 'sound/weapons/gun/pistol/asp.ogg'
	casingtype = /obj/item/ammo_casing/c57x39mm
	faction = list(FACTION_HOSTILE)
	icon_state = "quadrotor_coalition"

/mob/living/simple_animal/hostile/automated/quadrotor/cybersun/friendly
	name = "Mr. Drone"
	desc = "A military drone manufactured by Cybersun primarily during the Inter-Corporate War. It whirrs happily in the air."
	faction = list(FACTION_CYBERSUN)

/mob/living/simple_animal/hostile/automated/quadrotor/cybersun/ramzi
	name = "Y-10-RC Drone"
	desc = "A military drone design adapted by Ramzi's Clique for reconnaissance and fast response. The ten-millimeter machinepistol on its gimbal mount tracks your movements."
	rapid = 1
	rapid_fire_delay = 3
	projectilesound = 'sound/weapons/gun/pistol/asp.ogg'
	casingtype = /obj/item/ammo_casing/c10mm
	faction = list(FACTION_RAMZI)

/mob/living/simple_animal/hostile/automated/quadrotor/makosso
	name = "Vigilitas Drone"
	desc = "A defensive drone manufactured by Sharplite."
	health = 60
	maxHealth = 60
	projectilesound = 'sound/weapons/gun/laser/sharplite-fire.ogg'
	projectiletype = /obj/projectile/beam/chaff
	rapid = 7
	rapid_fire_delay = 1
	casingtype = null
	faction = list(ROLE_DEATHSQUAD)
	icon_state = "quadrotor_warra"

//rovers

/mob/living/simple_animal/hostile/automated/rover
	name = "Vigilitas \"Scenthound\" defense rover"
	desc = "A scouting drone manufactured by Sharplite during the Inter-Corporate War. Commonly fielded in small forward groups ahead of Vigilitas teams, or placed in security checkpoints."
	health = 100
	maxHealth = 100
	armor = list("melee" = 20, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	icon_state = "warratread"
	projectilesound = 'sound/weapons/gun/smg/resolution.ogg'
	casingtype = /obj/item/ammo_casing/c46x30mm
	faction = list(ROLE_DEATHSQUAD)
	rapid = 3
	rapid_fire_delay = 3
	retreat_distance = 2
	minimum_distance = 3

/mob/living/simple_animal/hostile/automated/rover/coalition
	name = "\"Teemeres\" combat rover"
	desc = "A boxy drone manufactured by Cybersun during the Inter-Corporate War. Stylized to be as basic and armored as possible to mesh with marauder forces, the Teemeres garnered a positive reputation for being a reliable diversion against enemy forces."
	icon_state = "coalitiontread"
	projectilesound = 'sound/weapons/gun/pistol/asp.ogg'
	casingtype = /obj/item/ammo_casing/c57x39mm
	faction = list(FACTION_HOSTILE)
	retreat_distance = 3
	minimum_distance = 3

/mob/living/simple_animal/hostile/automated/rover/coalition/dmr
	name = "\"Temere-Lito\" combat rover"
	desc = "A boxy drone manufactured by Cybersun during the Inter-Corporate War. Stylized to be as basic and armored as possible to mesh with marauder forces, the Temere-Lito garnered a poor reputation for its tendency to misfire into advancing marauders."
	icon_state = "coalitiontread_range"
	projectilesound = 'sound/weapons/gun/rifle/hydra.ogg'
	casingtype = /obj/item/ammo_casing/a556_42
	faction = list(FACTION_HOSTILE)
	rapid = 2
	rapid_fire_delay = 3
	minimum_distance = 7
	vision_range = 12
	aggro_vision_range = 14

/mob/living/simple_animal/hostile/automated/rover/ngr
	name = "\"Teemeres\" defense rover"
	desc = "A boxy drone manufactured by the New Gorlex Republic. Effectively the same as the original Teemeres rover, with modern NGR IFF. The modern Teemeres has found itself a new role as a checkpoint security drone for NGR facilities."
	projectilesound = 'sound/weapons/gun/pistol/asp.ogg'
	icon_state = "ngrtread"
	casingtype = /obj/item/ammo_casing/c57x39mm
	faction = list(FACTION_NGR)
	retreat_distance = 3
	minimum_distance = 3

/mob/living/simple_animal/hostile/automated/rover/ngr/dmr
	name = "\"Temere-Lito\" defense rover"
	desc = "A boxy drone manufactured by the New Gorlex Republic. Effectively the same as the original Temere-Lito, albeit with improved IFF systems to help prevent friendly fire incidents. The modern Temere-Lito has found itself a new role as a scouting drone, occasionally fielded on planetary survey missions."
	icon_state = "ngrtread_range"
	projectilesound = 'sound/weapons/gun/rifle/hydra.ogg'
	casingtype = /obj/item/ammo_casing/a556_42
	faction = list(FACTION_NGR)
	rapid = 2
	rapid_fire_delay = 3
	minimum_distance = 7
	vision_range = 12
	aggro_vision_range = 14

/mob/living/simple_animal/hostile/automated/rover/coalition/ramzi
	name = "\"Teemeres\" combat rover"
	desc = "A boxy drone manufactured by Cybersun during the Inter-Corporate War. Stylized to be as basic and armored as possible to mesh with marauder forces, the Teemeres garnered a positive reputation for being a reliable diversion against enemy forces. This example has been heavily modified and reprogrammed by the Ramzi Clique, to the point where you aren't sure whether this is a wartime-era drone or a post-War replacement."
	faction = list(FACTION_RAMZI)

/mob/living/simple_animal/hostile/automated/rover/coalition/dmr/ramzi
	name = "\"Temere-Lito\" combat rover"
	desc = "A boxy drone manufactured by Cybersun during the Inter-Corporate War. Stylized to be as basic and armored as possible to mesh with marauder forces, the Temere-Lito garnered a poor reputation for its tendency to misfire into advancing marauders. This one, despite its reputation for friendly fire, has been dragged back into service by the Ramzi Clique; whether from a New Gorlex Republic stockpile or wartime graveyard, you can't say."
	faction = list(FACTION_RAMZI)

//agrav

/mob/living/simple_animal/hostile/automated/agrav
	name = "'Verefasa' Gravity Drone"
	desc = "An advanced form of loitering munition designed by Cybersun as the ICW came to a close. A major portion of the bots have been repurposed as simple worker drones for Cybersun and its associates after the ICW, this just so happens to be one for your sake."
	icon_state = "independent_agrav"
	var/glow_color = COLOR_BLUE_LIGHT

	health = 150
	maxHealth = 150
	armor = list("melee" = 10, "bullet" = 35, "laser" = 35, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)

	attack_verb_continuous = "bonks"
	attack_verb_simple = "bonk"
	armour_penetration = 0
	melee_damage_lower = 10
	melee_damage_upper = 10

	move_to_delay = 3
	is_flying_animal = TRUE
	ranged = FALSE
	faction = list(FACTION_NEUTRAL)

/mob/living/simple_animal/hostile/automated/agrav/Initialize(mob/living/source)
	. = ..()
	src.mob_light(2, 0.4, glow_color)

/mob/living/simple_animal/hostile/automated/agrav/cybersun
	name = "'Verefasa' Combat Munition"
	desc = "An advanced form of loitering munition designed by Cybersun as the ICW came to a close; the Verefasa contains a barely-sentient combat AI for autonomous operations, a gravitic induction drive, and a microfusion heart. Often deployed en-masse to make reclaiming an area a pain, spacers tell horror stories of encountering hives of Verefasa active on salvage claims in deep space."
	icon_state = "cybersun_agrav"
	glow_color = LIGHT_COLOR_FLARE

	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/blade1.ogg'
	armour_penetration = 60
	melee_damage_lower = 35
	melee_damage_upper = 35
	melee_damage_type = BURN
	rapid_melee = 2

	on_aggro_say = list("Unregistered entity detected. Removing.", "You're not supposed to be here.", "Code 5-11-7. This area is under claim. Please leave immediately.")
	aggro_say_chance = 70
	faction = list(FACTION_HOSTILE)

//bipedal

/mob/living/simple_animal/hostile/automated/bipedal
	name = "Bipedal Assault Platform"
	desc = "A lumbering automaton garbed in Coalition colors, with an integrated shotgun attached in place of a left arm. Driven by basic threat detection software the barrel of its shotgun steadies itself in your direction."
	icon_state = "coalition_bipedal"
	environment_smash = ENVIRONMENT_SMASH_WALLS
	mob_size = MOB_SIZE_LARGE
	health = 250
	maxHealth = 250
	armor = list("melee" = 10, "bullet" = 45, "laser" = 45, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	move_to_delay = 20
	speed = 5
	footstep_type = FOOTSTEP_MOB_HEAVY
	projectilesound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	stat_attack = HARD_CRIT
	deathmessage = "collapses as its visor goes dark."
	shoot_point_blank = FALSE
	armour_penetration = 20
	melee_damage_lower = 35
	melee_damage_upper = 35
	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/weapons/genhit1.ogg'

/mob/living/simple_animal/hostile/automated/bipedal/AttackingTarget()
	. = ..()
	if(isliving(target))
		var/mob/living/bonk = target
		if(!bonk.anchored)
			var/atom/throw_target = get_edge_target_turf(bonk, src.dir)
			bonk.throw_at(throw_target, rand(1,3), 2, src, gentle = TRUE)

/mob/living/simple_animal/hostile/automated/bipedal/makosso
	desc = "A lumbering automaton garbed in Tri-Corp titanium, with an integrated plasma rifle attached in place of a left arm. The simple algorithms driving its servos level the plasma rifle in your direction."
	icon_state = "makosso_bipedal"
	retreat_distance = 2
	minimum_distance = 4
	rapid = 2
	rapid_fire_delay = 3
	projectilesound = 'sound/weapons/gun/laser/sharplite-fire.ogg'
	projectiletype = /obj/projectile/beam/laser/assault/sharplite
	casingtype = null
	faction = list(ROLE_DEATHSQUAD)
//boxer

/mob/living/simple_animal/hostile/automated/boxer
	name = "B.A.P II 'Boxer'"
	desc = "A cheaper, easier to produce version of the Bipedal Assault Platform, the B.A.P II was made to focus on a brawling, frontline role. With some structure stripped down and its weaponry downgraded to a deterrent plasma stream, it is able to perform far more aggressively compared to its predecessor."
	icon_state = "boxer"
	environment_smash = ENVIRONMENT_SMASH_WALLS
	mob_size = MOB_SIZE_LARGE
	health = 200
	maxHealth = 200
	armor = list("melee" = 45, "bullet" = 45, "laser" = 45, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	move_to_delay = 4
	speed = 5
	footstep_type = FOOTSTEP_MOB_HEAVY
	projectilesound = 'sound/weapons/gun/laser/sharplite-fire.ogg'
	projectiletype = /obj/projectile/beam/chaff
	rapid = 6
	rapid_fire_delay = 1
	spread = 30
	stat_attack = HARD_CRIT
	deathmessage = "collapses as its visor goes dark."
	shoot_point_blank = FALSE
	armour_penetration = 20
	melee_damage_lower = 40
	melee_damage_upper = 40
	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/weapons/genhit1.ogg'
	faction = list(ROLE_DEATHSQUAD)
	on_aggro_say = list("Intruder detected. Suppressing.", "Aggressor is non-complaint, Engaging.", "Stop Resisting.")
	aggro_say_chance = 60

/mob/living/simple_animal/hostile/automated/boxer/AttackingTarget()
	. = ..()
	if(isliving(target))
		var/mob/living/bonk = target
		if(!bonk.anchored)
			var/atom/throw_target = get_edge_target_turf(bonk, src.dir)
			bonk.throw_at(throw_target, rand(1,3), 2, src, gentle = TRUE)

/mob/living/simple_animal/hostile/automated/walkmine
	name = "G-80W Walkmine"
	desc = "An unconventional modification of the traditional G-80P Bouncer. Famously dubbed, 'a proactive solution to unsavory intruders', use of the Walkmine was banned in most jurisdictions following the Inter-Corporate War."
	icon = 'icons/obj/landmine.dmi'
	icon_state = "mine_walker"
	light_color = "#D74722"
	del_on_death = FALSE
	ranged_cooldown_time = 0
	vision_range = 12
	rapid_fire_delay = 0 SECONDS
	wander = 0
	health = 45
	maxHealth = 45
	move_to_delay = 2
//Distance at which walkmine will be allowed to explode
	var/explode_distance = 2
//Delay after explosion is triggered
	var/blast_delay = 15 DECISECONDS
//Explosion ranges
	var/mine_devastation = 0
	var/mine_heavy = 1
	var/mine_light = 3
	var/mine_flame = 1 //this is funny but sort of evil
//Shrapnel
	var/shrapnel_magnitude = 1 //Amount of shrapnel. 0 = None.
	var/shrapnel_type = /obj/projectile/bullet/shrapnel/walkmine //potential for evil
//Used for manufacturer text.
	var/examine_text = null

/mob/living/simple_animal/hostile/automated/walkmine/examine(mob/user)
	. = ..()
	if(examine_text)
		. += examine_text

/mob/living/simple_animal/hostile/automated/walkmine/OpenFire(atom/victim)
	if(get_dist(src,victim) > explode_distance)
		return
	if(blast_delay >= 5 DECISECONDS)
		playsound(src, 'sound/items/mine_activate.ogg', 70, FALSE)
	else
		playsound(src, 'sound/items/mine_activate_short.ogg', 80, FALSE)
	Stun(-1) //forever stun brownie
	LoseTarget()
	icon_state = "mine_walker_explode"
	mob_light(3, 1, light_color)
	if(!blast_delay)
		death()
	else
		addtimer(CALLBACK(src, PROC_REF(death)), blast_delay)

/mob/living/simple_animal/hostile/automated/walkmine/death()
	. = ..()
	visible_message(span_warning("[src] explodes!"))
	explosion(get_turf(loc),mine_devastation,mine_heavy,mine_light,flame_range = mine_flame, adminlog = FALSE)
	if(shrapnel_magnitude > 0)
		AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_magnitude)
	SEND_SIGNAL(src, COMSIG_MOB_PELLETS)
	qdel(src)

/mob/living/simple_animal/hostile/automated/walkmine/Aggro()
	mob_light(2, 0.25, light_color)

/mob/living/simple_animal/hostile/automated/walkmine/makosso
	faction = list("Deathsquad")
	examine_text = span_notice("It has a <span class='boldnotice'>Makosso-Warra</span> logo printed on its outer plating.")

/mob/living/simple_animal/hostile/automated/walkmine/cybersun
	faction = list("hostile")
	examine_text = span_notice(" It has a <span class='boldnotice'>Cybersun Virtual Solutions</span> logo printed on its outer plating.")

/mob/living/simple_animal/hostile/automated/walkmine/frontiersman
	faction = list("Frontiersmen")

/mob/living/simple_animal/hostile/automated/walkmine/ramzi
	faction = list("Ramzi Clique")

// shotgun hoppers (To-do, make them "jump" around like the antlions do?)

/mob/living/simple_animal/hostile/automated/hopper
	name = "Al'sa CQB 'Hopper'"
	desc = "A specialized drone made by the Al'sa Guild for quick skirmishes at close range, nicknamed 'Hopper' for its way of running. Sought after by both Makosso-Warra and the Coalition during the ICW, many were sold off and produced locally in the frontier."
	health = 100
	maxHealth = 100
	armor = list("melee" = 15, "bullet" = 40, "laser" = 40, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	casingtype = /obj/item/ammo_casing/energy/laser/shotgun/drone
	projectiletype = null
	projectilesound = 'sound/weapons/gun/laser/e40_las.ogg'
	faction = list(FACTION_NEUTRAL)
	icon_state = "hopper"
	move_to_delay = 3
	armour_penetration = -10
	melee_damage_lower = 12
	melee_damage_upper = 12
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kicked"
	rapid = 1
	attack_sound = 'sound/weapons/genhit1.ogg'

/mob/living/simple_animal/hostile/automated/hopper/Initialize()
	. = ..()
	AddElement(/datum/element/waddling)

/mob/living/simple_animal/hostile/automated/hopper/warra
	name = "Al'sa CQB 'Hopper'"
	desc = "A specialized drone made by the Al'sa Guild for quick skirmishes at close range, nicknamed 'Hopper' for its way of running. Sought after by both Makosso-Warra and the Coalition during the ICW, many were sold off and produced locally in the frontier. This model is painted in the colors of Vigilitas Interstellar."
	faction = list(ROLE_DEATHSQUAD)
	icon_state = "hopper_warra"

/mob/living/simple_animal/hostile/automated/hopper/coalition
	name = "Al'sa CQB 'Hopper'"
	desc = "A specialized drone made by the Al'sa Guild for quick skirmishes at close range, nicknamed 'Hopper' for its way of running. Sought after by both Makosso-Warra and the Coalition during the ICW, many were sold off and produced locally in the frontier. This model is painted in the colors of the Syndicate Coalition"
	faction = list(FACTION_HOSTILE)
	icon_state = "hopper_coalition"

// tripods

/mob/living/simple_animal/hostile/automated/tripod
	name = "Sav'cla 'Helper'"
	desc = "Originally designed and manufactured by the Al'Sa Guild as a general 'Helper' drone, the Sav'Cla is unique thanks to its top of the line optical sensor suite. What made it a great helper around the home has made it a great war machine when rewired. Sye-Port Industrial has manufactured these conversions en masse for decades, making them a common sight on the Frontier."
	icon_state = "tripod"
	health = 100
	maxHealth = 100
	armor = list("melee" = 10, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 20, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	ranged = FALSE
	minimum_distance = 7
	vision_range = 12
	aggro_vision_range = 14
	move_to_delay = 8
	faction = list(FACTION_NEUTRAL)
	armour_penetration = -10
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "claws"
	attack_verb_simple = "clawed"
	attack_sound = 'sound/weapons/bladeslice.ogg'

/mob/living/simple_animal/hostile/automated/tripod/MoveToTarget(list/possible_targets)//Step 5, handle movement between us and our target. Edited to give firing a delay if the target is too far
	stop_automated_movement = 1
	if(!target || !CanAttack(target))
		LoseTarget()
		return 0
	var/atom/target_from = GET_TARGETS_FROM(src)
	if(target in possible_targets)
		var/turf/T = get_turf(src)
		if(target.virtual_z() != T.virtual_z())
			LoseTarget()
			return 0
		var/target_distance = get_dist(target_from,target)
		if(ranged) //We ranged? Shoot at em
			if(!target.Adjacent(target_from) && ranged_cooldown <= world.time) //But make sure they're not in range for a melee attack and our range attack is off cooldown
				if(target_distance > 7) // Only give a warning if they're a fair distance away, otherwise it's fairgame
					target.do_alert_animation() // We give the target MGS Alert! Warning, and add a 1.5 second delay to firing. Value should be adjusted through testing
					addtimer(CALLBACK(src, PROC_REF(OpenFire), target), 15, TIMER_STOPPABLE)
				else
					OpenFire(target)
		if(!Process_Spacemove()) //Drifting
			walk(src,0)
			return 1
		if(retreat_distance != null) //If we have a retreat distance, check if we need to run from our target
			if(target_distance <= retreat_distance) //If target's closer than our retreat distance, run
				walk_away(src,target,retreat_distance,move_to_delay)
			else
				Goto(target,move_to_delay,minimum_distance) //Otherwise, get to our minimum distance so we chase them
		else
			Goto(target,move_to_delay,minimum_distance)
		if(target)
			if(isturf(target_from.loc) && target.Adjacent(target_from)) //If they're next to us, attack
				if(ranged && shoot_point_blank && ranged_cooldown <= world.time)
					OpenFire(target)
				else
					MeleeAction()
			else
				if(rapid_melee > 1 && target_distance <= melee_queue_distance)
					MeleeAction(FALSE)
				in_melee = FALSE //If we're just preparing to strike do not enter sidestep mode
			return 1
		return 0
	LoseTarget()
	return 0

/mob/living/simple_animal/hostile/automated/tripod/pgf
	name = "Sav'sha'bore 'Beam Drone'"
	desc = "A Sye-Port Industrial converted Sav'cla drone sporting 'demilitarized' weaponry. Clad in PGF-colored plating, it turns its heavy beam rifle in your direction."
	icon_state = "tripod_pgf"
	ranged = TRUE
	armor = list("melee" = 25, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	casingtype = null
	projectiletype = /obj/projectile/beam/hitscan/kalix/pgf/sniper
	projectilesound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	faction = list(FACTION_HOSTILE)

/mob/living/simple_animal/hostile/automated/tripod/pgf/sentry
	vision_range = 14
	aggro_vision_range = 14
	minimum_distance = 14
	stop_automated_movement = 1
	wander = 0
	retreat_distance = 0
	environment_smash = 0

/mob/living/simple_animal/hostile/automated/tripod/warra
	name = "Sav'sha'kosso 'Plasma Drone'"
	desc = "A Sye-Port Industrial converted Sav'cla drone sporting 'demilitarized' weaponry. Clad in VI-colored plating, it turns its heavy plasma rifle in your direction."
	icon_state = "tripod_warra"
	ranged = TRUE
	armor = list("melee" = 25, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	casingtype = null
	projectiletype = /obj/projectile/beam/laser/sharplite/sniper
	projectilesound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	faction = list(ROLE_DEATHSQUAD)

/mob/living/simple_animal/hostile/automated/tripod/warra/sentry
	vision_range = 14
	aggro_vision_range = 14
	minimum_distance = 14
	stop_automated_movement = 1
	wander = 0
	retreat_distance = 0
	environment_smash = 0

/mob/living/simple_animal/hostile/automated/tripod/ramzi
	name = "Sav'sha'syn 'Gun Drone'"
	desc = "A Sye-Port Industrial converted Sav'cla drone. Its plating seems rusted and worn; its optical sensor suite flickers as it points its heavy rifle at you."
	icon_state = "tripod_ramzi"
	ranged = TRUE
	armor = list("melee" = 25, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	casingtype = /obj/item/ammo_casing/a65clip
	projectiletype = /obj/projectile/bullet/a65clip
	projectilesound = 'sound/weapons/gun/sniper/cmf90.ogg'
	faction = list(FACTION_RAMZI)

/mob/living/simple_animal/hostile/automated/tripod/ramzi/sentry
	vision_range = 14
	aggro_vision_range = 14
	minimum_distance = 14
	stop_automated_movement = 1
	wander = 0
	retreat_distance = 0
	environment_smash = 0

/mob/living/simple_animal/hostile/automated/tripod/ramzi/taipan
	desc = "A Sye-Port Industrial converted Sav'cla drone. Its plating seems rusted and worn; its motors loudly whine as it turns the huge rifle towards you."
	casingtype = /obj/item/ammo_casing/p50
	projectiletype = /obj/projectile/bullet/p50
	projectilesound = 'sound/weapons/gun/sniper/shot.ogg'
