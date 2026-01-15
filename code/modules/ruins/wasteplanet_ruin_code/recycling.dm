/obj/effect/mob_spawn/human/corpse/ramzi/commando/pristine
	name = "Ramzi Clique Pristine Commando"
	id_job = "Operative"
	outfit = /datum/outfit/ramzi/commando/pristine
	mob_gender = FEMALE

/datum/outfit/ramzi/commando/pristine
	name = "Ramzi Clique Pristine Commando"
	head = /obj/item/clothing/head/helmet/space/hardsuit/syndi
	suit = /obj/item/clothing/suit/space/hardsuit/syndi

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/pristine/hydra
	name = "Lieutenant Ophilia"
	desc = "An imposing deserter from the Gorlex Marauders turned pirate. Dressed in Ruby-Red that shines in your eyes, almost too brightly to see the raising of her assault rifle."
	rapid = 5
	icon_state = "syndicate_stormtrooper_shotgun"
	casingtype = /obj/item/ammo_casing/a556_42
	l_hand = /obj/item/gun/ballistic/automatic/assault/hydra
	projectilesound = 'sound/weapons/gun/rifle/hydra.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/commando/pristine
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi

	minimum_distance = 2
	rapid_fire_delay = 6
	retreat_distance = 2
	shoot_point_blank = TRUE
	vision_range = 12
	aggro_vision_range = 14
	weapon_drop_chance = 100

/mob/living/simple_animal/hostile/human/ramzi/melee/atmos_tech
	name = "Ramzi Clique Atmospheric Technician"
	desc = "An imposing deserter from the Gorlex Marauders turned pirate. This one has a axe, and appears very very unhappy to see you."
	l_hand = /obj/item/melee/axe/fire
	weapon_drop_chance = 100

