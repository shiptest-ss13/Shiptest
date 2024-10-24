//CUSTOM MOB
/mob/living/simple_animal/hostile/abandoned_minebot
	name = "\improper Abandoned minebot"
	desc = "The instructions printed on the side are faded, and the only thing that remains is mechanical bloodlust."
	gender = NEUTER
	icon = 'icons/mob/aibots.dmi'
	icon_state = "mining_drone"
	icon_living = "mining_drone"
	status_flags = CANSTUN|CANKNOCKDOWN|CANPUSH
	mouse_opacity = MOUSE_OPACITY_ICON
	a_intent = INTENT_HARM
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	move_to_delay = 10
	health = 70
	maxHealth = 70
	melee_damage_lower = 15
	melee_damage_upper = 15
	obj_damage = 10
	environment_smash = ENVIRONMENT_SMASH_NONE
	check_friendly_fire = TRUE
	stop_automated_movement_when_pulled = TRUE
	attack_verb_continuous = "drills"
	attack_verb_simple = "drill"
	attack_sound = 'sound/weapons/circsawhit.ogg'
	projectilesound = 'sound/weapons/kenetic_accel.ogg'
	custom_price = 800
	speak_emote = list("states")
	del_on_death = TRUE
	light_system = MOVABLE_LIGHT
	light_range = 6
	light_on = FALSE
	ranged = TRUE
	retreat_distance = 2
	minimum_distance = 1
	icon_state = "mining_drone_offense"
	faction = list("mining", "turret")
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/effect/spawner/random/minebot)
	projectiletype = /obj/projectile/kinetic/miner/weak


/obj/projectile/kinetic/miner/weak
	damage = 15

/obj/effect/spawner/random/minebot
	loot = list(/obj/item/borg/upgrade/modkit/minebot_passthrough = 15,
				/obj/item/borg/upgrade/modkit/chassis_mod = 15,
				/obj/item/borg/upgrade/modkit/tracer = 15,
				/obj/item/borg/upgrade/modkit/cooldown = 6,
				/obj/item/borg/upgrade/modkit/damage = 6,
				/obj/item/borg/upgrade/modkit/range = 6,
				/obj/item/borg/upgrade/modkit/aoe/mobs = 6,
				/obj/item/borg/upgrade/modkit/aoe/turfs = 6,
				/obj/item/borg/upgrade/modkit/trigger_guard = 6)
