/obj/effect/spawner/random/twentypercentpucespawn
	name = "20% puce spawn chance"
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "puce"
	loot = list(/obj/structure/flora/ash/puce)
	spawn_loot_chance = 20

/obj/effect/spawner/random/fiftycavefern
	name = "50% cave fern spawn chance"
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "cavefern" //needs new sprites.
	loot = list(/obj/structure/flora/ash/fern)
	spawn_loot_chance = 50

/obj/effect/spawner/random/fourtywsfauna
	name = "40% whitesands fauna spawn chance"
	icon = 'icons/mob/lavaland/lavaland_monsters_wide.dmi'
	icon_state = "ws_goliath"
	loot = list(
			/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/random = 15,
			/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 20,
			/obj/effect/spawner/random/hermit = 5,
		)
	spawn_loot_chance = 40

/obj/effect/spawner/random/seventyrock
	name = "70% rock spawn chance"
	icon = 'icons/obj/flora/rocks.dmi'
	icon_state = "basalt1"
	loot = list(
			/obj/structure/flora/rock = 5,
		)
	spawn_loot_chance = 70
