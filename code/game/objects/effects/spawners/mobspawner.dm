/obj/effect/spawner/random/randomthreat
	var/static/mob_category = rand(1, 3)

/obj/effect/spawner/random/randomthreat/Initialize(mapload)
	switch(mob_category)
		if(1)
			loot = list(
				/obj/effect/spawner/random/hivebotspawner
			)
		if(2)
			loot = list(
				/mob/living/simple_animal/hostile/carp
			)
		if(3)
			loot = list(
				/obj/effect/spawner/random/spiderspawner
			)
	return ..()

/obj/effect/spawner/random/xenospawner
	name = "Xenomorph spawner"

	loot = list(
		/mob/living/simple_animal/hostile/alien = 0.3,
		/mob/living/simple_animal/hostile/alien/drone = 0.2,
		/mob/living/simple_animal/hostile/alien/sentinel = 0.3,
		/obj/effect/spawner/random/xenoqueenspawner = 0.1
	)

/obj/effect/spawner/random/xenoqueenspawner
	name = "xenomorph queen spawner"
	loot = list(
		/mob/living/simple_animal/hostile/alien/queen = 0.2, //regular queen mob isn't actually that strong
		/mob/living/simple_animal/hostile/alien/queen/large = 0.8
	)

/obj/effect/spawner/random/hivebotspawner
	name = "Hivebot spawner"

	loot = list(
		/mob/living/simple_animal/hostile/hivebot/strong,
		/mob/living/simple_animal/hostile/hivebot,
	)

/obj/effect/spawner/random/spiderspawner
	name = "Spider spawner"

	loot = list(
		/mob/living/simple_animal/hostile/poison/giant_spider,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper,
	)

/obj/effect/spawner/random/thirtyfive_percent_borerspawner
	name = "35 percent neutered borer spawner"

	loot = list(
		/mob/living/simple_animal/borer/sterile = 0.35,
		/obj/effect/spawner/random/maintenance = 0.65,
	)

/obj/effect/spawner/random/chicken
	name = "chicken spawner"
	loot = list(
		/mob/living/simple_animal/chicken
	)

/obj/effect/spawner/random/chicken/jungle
	name = "jungle chicken spawner"
	loot = list(
		/mob/living/simple_animal/hostile/retaliate/chicken
	)

/obj/effect/spawner/random/chicken/jungle/flock
	loot = list(
		/mob/living/simple_animal/hostile/retaliate/chicken
	)
	spawn_loot_count = 7
	spawn_loot_double = TRUE
