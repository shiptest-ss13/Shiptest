/obj/effect/spawner/random/twentypercentpucespawn
	name = "20% puce spawn chance"
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "puce"
	loot = list(
			/obj/structure/flora/ash/puce = 5,
		)

/obj/effect/spawner/random/twentypercentpucespawn/Initialize(mapload)
	if(prob(20))
		return ..()
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/random/fiftycavefern
	name = "50% cave fern spawn chance"
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "cavefern" //needs new sprites.
	loot = list(
			/obj/structure/flora/ash/fern = 5,
		)

/obj/effect/spawner/random/fiftycavefern/Initialize(mapload)
	if(prob(50))
		return ..()
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/random/fourtywsfauna
	name = "40% whitesands fauna spawn chance"
	loot = list(
			/mob/living/simple_animal/hostile/asteroid/goliath/beast/whitesands/random = 15,
			/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 20,
			/mob/living/simple_animal/hostile/human/hermit/survivor/random = 5,
		)

	icon = 'icons/mob/lavaland/lavaland_monsters_wide.dmi'
	icon_state = "ws_goliath"

/obj/effect/spawner/random/fourtywsfauna/Initialize(mapload)
	if(prob(40))
		return ..()
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/random/seventyrock
	name = "70% rock spawn chance"
	icon = 'icons/obj/flora/rocks.dmi'
	icon_state = "basalt1"
	loot = list(
			/obj/structure/flora/rock = 5,
		)

/obj/effect/spawner/random/seventyrock/Initialize(mapload)
	if(prob(70))
		return ..()
	return INITIALIZE_HINT_QDEL
