/obj/effect/mob_spawn/human/corpse/ramzi/commando/pristine
	name = "Ramzi Clique Pristine Commando"
	id_job = "Operative"
	outfit = /datum/outfit/ramzi/commando/pristine
	mob_gender = FEMALE

/datum/outfit/ramzi/commando/pristine
	name = "Ramzi Clique Pristine Commando"
	head = /obj/item/clothing/head/helmet/space/hardsuit/syndi
	suit = /obj/item/clothing/suit/space/hardsuit/syndi

/mob/living/basic/human/ramzi/ranged/space/pristine/hydra
	name = "Lieutenant Ophilia"
	desc = "An imposing deserter from the Gorlex Marauders turned pirate. Dressed in Ruby-Red that shines in your eyes, almost too brightly to see the raising of her assault rifle."
	burst_shots = 5
	icon_state = "syndicate_stormtrooper_shotgun"
	casing_type = /obj/item/ammo_casing/a556_42
	l_hand = /obj/item/gun/ballistic/automatic/assault/hydra
	projectile_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/commando/pristine
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi

	engage_distance = 2
	burst_interval = 6
	retreat_distance = 2
	vision_range = 12
	weapon_drop_chance = 100

/mob/living/basic/human/ramzi/melee/atmos_tech
	name = "Ramzi Clique Atmospheric Technician"
	desc = "An imposing deserter from the Gorlex Marauders turned pirate. This one has a axe, and appears very very unhappy to see you."
	l_hand = /obj/item/melee/axe/fire
	weapon_drop_chance = 100
	sharpness = SHARP_EDGED // an axe, not a knife like the rest of the Ramzi melee
	attack_verb_continuous = "chops"
	attack_verb_simple = "chop"

