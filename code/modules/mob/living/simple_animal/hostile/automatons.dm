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
	rapid = 3
	rapid_fire_delay = 3
	projectilesound = 'sound/weapons/gun/pistol/asp.ogg'
	casingtype = /obj/item/ammo_casing/c57x39mm
	faction = list(FACTION_HOSTILE)

/mob/living/simple_animal/hostile/automated/quadrotor/cybersun/friendly
	name = "Mr. Drone"
	desc = "A military drone manufactured by Cybersun primarily during the Inter-Corporate War. It whirrs happily in the air."
	faction = list(FACTION_CYBERSUN)

/mob/living/simple_animal/hostile/automated/quadrotor/cybersun/ramzi
	name = "Y-10-RC Drone"
	desc = "A military drone design adapted by Ramzi's Clique for reconnaissance and fast response. The ten-millimeter machinepistol on its gimbal mount tracks your movements."
	rapid = 2
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
	projectiletype = /obj/projectile/beam/laser/sharplite
	casingtype = null
	faction = list(ROLE_DEATHSQUAD)

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

//agrav

/mob/living/simple_animal/hostile/automated/agrav
	name = "'Verefasa' Combat Munition"
	desc = "An advanced form of loitering munition designed by Cybersun as the ICW came to a close, the Verefasa contains a barely-sentient combat AI for autonomous operations, a gravitic induction drive, and a microfusion heart. Often deployed en-masse to make reclaiming an area a pain, spacers tell horror stories of encountering hives of Verefasa active on salvage claims in deep space. This one doesn't seem fully equipped."
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

	move_to_delay = 5
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
