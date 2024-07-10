/datum/map_generator/planet_generator/shrouded
	mountain_height = 0.8
	perlin_zoom = 65

	primary_area_type = /area/overmap_encounter/planetoid/shrouded

	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_LOW_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert/shrouded
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_LOW_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert/shrouded
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_LOW_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert/shrouded
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_LOW_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert/shrouded
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_LOW_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert/shrouded,
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_LOW_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert/shrouded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert/shrouded
		)
	)

	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/shrouded
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/shrouded
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/shrouded
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/shrouded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/shrouded
		)
	)

/datum/biome/desert/shrouded
	open_turf_types = list(/turf/open/floor/plating/asteroid/shrouded = 1)
	flora_spawn_chance = 0
	mob_spawn_chance = 0

/datum/biome/cave/desert/shrouded
	open_turf_types = list(/turf/open/floor/plating/asteroid/shrouded = 1)
	closed_turf_types = list(/turf/closed/mineral/random/shrouded = 1)

	mob_spawn_chance = 3
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/royalcrab = 10,
	)

/mob/living/simple_animal/hostile/asteroid/royalcrab
	name = "cragenoy"
	desc = "It looks like a crustacean with an exceedingly hard carapace. Watch the pinchers!"
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "royalcrab"
	icon_living = "royalcrab"
	icon_dead = "royalcrab_dead"
	maxHealth = 150
	health = 150
	speed = 1
	speak_chance = 1
	emote_see = list("skitters","oozes liquid from its mouth", "scratches at the ground", "clicks its claws")

	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_verb_continuous = "pinched"
	attack_verb_simple = "pinch"
