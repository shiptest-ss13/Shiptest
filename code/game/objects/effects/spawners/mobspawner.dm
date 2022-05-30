/obj/effect/spawner/lootdrop/randomthreat
	var/static/mob_category = rand(1, 3)

/obj/effect/spawner/lootdrop/randomthreat/Initialize(mapload)
	switch(mob_category)
		if(1)
			loot = list(
				/obj/effect/spawner/lootdrop/hivebotspawner
			)
		if(2)
			loot = list(
				/obj/effect/spawner/lootdrop/carpspawner
			)
		if(3)
			loot = list(
				/obj/effect/spawner/lootdrop/spiderspawner
			)
	. = ..()

/obj/effect/spawner/lootdrop/xenospawner
	name = "Improper xenomorph spawner"

	loot = list(
		/mob/living/simple_animal/hostile/alien = 0.3,
		/mob/living/simple_animal/hostile/alien/drone = 0.2,
		/mob/living/simple_animal/hostile/alien/sentinel = 0.3,
		/obj/effect/spawner/lootdrop/xenoqueenspawner = 0.1
	)

/obj/effect/spawner/lootdrop/xenoqueenspawner
	name = "Improper xenomorph queen spawner"
	loot = list(
		/mob/living/simple_animal/hostile/alien/queen = 0.999, //regular queen mob isn't actually that strong
		/mob/living/simple_animal/hostile/alien/queen/large = 0.001
	)

/obj/effect/spawner/lootdrop/hivebotspawner
	name = "Improper hivebot spawner"

	loot = list(
		/mob/living/simple_animal/hostile/hivebot/strong,
		/mob/living/simple_animal/hostile/hivebot,
	)

/obj/effect/spawner/lootdrop/spiderspawner
	name = "Improper spider spawner"

	loot = list(
		/mob/living/simple_animal/hostile/poison/giant_spider,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper,
	)

/obj/effect/spawner/lootdrop/carpspawner
	name = "Improper carp spawner"

	loot = list(
		/mob/living/simple_animal/hostile/carp,
	)

/obj/effect/spawner/lootdrop/eighty_percent_borerspawner
	name = "Improper 80 percent neutered borer spawner"

	loot = list(
		/mob/living/simple_animal/borer/sterile = 0.8, // leave people guessing
		/obj/effect/spawner/lootdrop/maintenance = 0.2,
	)

/obj/effect/spawner/lootdrop/thirtyfive_percent_borerspawner
	name = "Improper 35 percent neutered borer spawner"

	loot = list(
		/mob/living/simple_animal/borer/sterile = 0.35,
		/obj/effect/spawner/lootdrop/maintenance = 0.65,
	)
