/datum/map_generator/cave_generator/rockplanet
	open_turf_types = list(/turf/open/floor/plating/asteroid = 50,
						/turf/open/floor/plating/rust/rockplanet = 10,
						/turf/open/floor/plating/rockplanet = 5)

	closed_turf_types =  list(/turf/closed/mineral/random/asteroid/rockplanet = 45,
							/turf/closed/wall/rust = 10,)

	mob_spawn_chance = 3
	flora_spawn_chance = 6

	mob_spawn_list = list(
		//'regular' fauna, not too difficult
		/mob/living/simple_animal/hostile/netherworld/asteroid = 50,
		/mob/living/simple_animal/hostile/asteroid/fugu/asteroid = 50,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 40, //mariuce
		//crystal mobs, very difficult
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal = 1,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten = 1,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/crystal = 1,
		//bots, are hostile
		/mob/living/simple_animal/bot/medbot/rockplanet = 15,
		/mob/living/simple_animal/bot/firebot/rockplanet = 15,
		/mob/living/simple_animal/bot/secbot/ed209/rockplanet = 5,
		/mob/living/simple_animal/hostile/abandoned_minebot = 15,
		/mob/living/simple_animal/bot/floorbot/rockplanet = 15)

	flora_spawn_list = list(/obj/structure/mecha_wreckage/ripley = 5,
		/obj/structure/mecha_wreckage/ripley/firefighter = 3,
		/obj/structure/mecha_wreckage/ripley/mkii = 3,
		/obj/structure/reagent_dispensers/fueltank = 30,
		/obj/structure/girder = 30,
		/obj/item/stack/ore/slag = 10,
		/obj/item/stack/rods = 10,
		/obj/item/shard = 10,
		/obj/item/stack/cable_coil/cut = 10,
		/obj/effect/spawner/lootdrop/maintenance = 30,
		/obj/effect/decal/cleanable/greenglow = 20,
		/obj/structure/closet/crate/secure/loot = 1,
		/obj/machinery/portable_atmospherics/canister/toxins = 1,
		/obj/machinery/portable_atmospherics/canister/miasma = 1,
		/obj/machinery/portable_atmospherics/canister/carbon_dioxide = 1,
		/obj/structure/radioactive = 2,
		/obj/structure/radioactive/stack = 2,
		/obj/structure/radioactive/waste = 2)
	feature_spawn_list = list(/obj/structure/geyser/random = 1, /obj/effect/mine/shrapnel/human_only = 1)

	initial_closed_chance = 45
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3

/turf/closed/mineral/random/asteroid/rockplanet
	name = "iron rock"
	icon = 'icons/turf/mining.dmi'
	icon_state = "redrock"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	base_icon_state = "red_wall"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	turf_type = /turf/open/floor/plating/asteroid
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 7, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 7, /obj/item/stack/ore/plasma = 15, /obj/item/stack/ore/iron = 55, /obj/item/stack/ore/titanium = 6,
		/turf/closed/mineral/gibtonite/rockplanet = 4, /obj/item/stack/ore/bluespace_crystal = 1)
	mineralChance = 30

/turf/closed/mineral/gibtonite/rockplanet
	name = "iron rock"
	icon = 'icons/turf/mining.dmi'
	icon_state = "redrock"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	base_icon_state = "red_wall"


/turf/open/floor/plating/rockplanet
	baseturfs = /turf/open/floor/plating/asteroid

/turf/open/floor/plating/rust/rockplanet
	baseturfs = /turf/open/floor/plating/asteroid

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
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
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
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/effect/spawner/lootdrop/minebot)
	projectiletype = /obj/projectile/kinetic/miner/weak


/obj/projectile/kinetic/miner/weak
	damage = 15

/obj/effect/spawner/lootdrop/minebot
	loot = list(/obj/item/borg/upgrade/modkit/minebot_passthrough = 15,
				/obj/item/borg/upgrade/modkit/chassis_mod = 15,
				/obj/item/borg/upgrade/modkit/tracer = 15,
				/obj/item/borg/upgrade/modkit/cooldown = 6,
				/obj/item/borg/upgrade/modkit/damage = 6,
				/obj/item/borg/upgrade/modkit/range = 6,
				/obj/item/borg/upgrade/modkit/aoe/mobs = 6,
				/obj/item/borg/upgrade/modkit/aoe/turfs = 6,
				/obj/item/borg/upgrade/modkit/trigger_guard = 6)
