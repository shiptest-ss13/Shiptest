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
		/mob/living/simple_animal/hostile/alien = 3,
		/mob/living/simple_animal/hostile/alien/drone = 2,
		/mob/living/simple_animal/hostile/alien/sentinel = 3,
		/obj/effect/spawner/random/xenoqueenspawner = 1
	)

/obj/effect/spawner/random/xenoqueenspawner
	name = "xenomorph queen spawner"
	loot = list(
		/mob/living/simple_animal/hostile/alien/queen = 2, //regular queen mob isn't actually that strong
		/mob/living/simple_animal/hostile/alien/queen/large = 8
	)

/obj/effect/spawner/random/hivebotspawner
	name = "Hivebot spawner"
	loot = list(
		/mob/living/basic/hivebot/strong,
		/mob/living/basic/hivebot,
	)

/obj/effect/spawner/random/spiderspawner
	name = "Spider spawner"
	loot = list(
		/mob/living/simple_animal/hostile/poison/giant_spider,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper,
	)

/obj/effect/spawner/random/hermit
	name = "hermit spawner"
	loot = list(
		/mob/living/simple_animal/hostile/human/hermit/survivor = 35,
		/mob/living/simple_animal/hostile/human/hermit/ranged/hunter = 25,
		/mob/living/simple_animal/hostile/human/hermit/survivor/brawler = 10,
		/mob/living/simple_animal/hostile/human/hermit/ranged/shotgun = 10,
		/mob/living/simple_animal/hostile/human/hermit/survivor/lunatic = 5,
		/mob/living/simple_animal/hostile/human/hermit/ranged/gunslinger = 10,
		/mob/living/simple_animal/hostile/human/hermit/ranged/e11 = 5
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

/obj/effect/spawner/random/polar_bear
	name = "bear spawner"
	loot = list(
		/mob/living/basic/bear/polar = 85,
		/mob/living/basic/bear/polar/warrior = 15
	)

/obj/effect/spawner/random/snow_monkey_pack
	loot = list(
		/mob/living/basic/snow_monkey
	)
	spawn_loot_count = null
	spawn_loot_double = TRUE

/obj/effect/spawner/random/snow_monkey_pack/spawn_loot(lootcount_override)
	if(!spawn_loot_count)
		spawn_loot_count = rand(2,5)
	. = ..()
