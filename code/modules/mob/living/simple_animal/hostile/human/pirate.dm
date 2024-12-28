/mob/living/simple_animal/hostile/human/pirate
	name = "Pirate"
	desc = "Does what he wants cause a pirate is free."
	icon_state = "piratemelee"
	icon_living = "piratemelee"
	icon_dead = "pirate_dead"
	speak_chance = 0
	speak_emote = list("yarrs")
	loot = list(/obj/effect/mob_spawn/human/corpse/pirate,
			/obj/item/melee/energy/sword/saber/pirate)
	faction = list("pirate")

/mob/living/simple_animal/hostile/human/pirate/melee
	name = "Pirate Swashbuckler"
	icon_state = "piratemelee"
	icon_living = "piratemelee"
	icon_dead = "piratemelee_dead"
	melee_damage_lower = 30
	melee_damage_upper = 30
	armour_penetration = 35
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/blade1.ogg'
	var/obj/effect/light_emitter/red_energy_sword/sord

	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/human/pirate/melee/space
	name = "Space Pirate Swashbuckler"
	icon_state = "piratespace"
	icon_living = "piratespace"
	icon_dead = "piratespace_dead"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	speed = 1
	armor_base = /obj/item/clothing/suit/space

/mob/living/simple_animal/hostile/human/pirate/melee/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)

/mob/living/simple_animal/hostile/human/pirate/melee/Initialize()
	. = ..()
	sord = new(src)

/mob/living/simple_animal/hostile/human/pirate/melee/Destroy()
	QDEL_NULL(sord)
	return ..()

/mob/living/simple_animal/hostile/human/pirate/melee/Initialize()
	. = ..()
	set_light(2)

/mob/living/simple_animal/hostile/human/pirate/ranged
	name = "Pirate Gunner"
	icon_state = "pirateranged"
	icon_living = "pirateranged"
	icon_dead = "pirateranged_dead"
	projectilesound = 'sound/weapons/laser.ogg'
	ranged = 1
	rapid = 2
	rapid_fire_delay = 6
	retreat_distance = 5
	minimum_distance = 5
	projectiletype = /obj/projectile/beam/laser
	loot = list(/obj/effect/mob_spawn/human/corpse/pirate/ranged,
			/obj/item/gun/energy/laser)

/mob/living/simple_animal/hostile/human/pirate/ranged/space
	name = "Space Pirate Gunner"
	icon_state = "piratespaceranged"
	icon_living = "piratespaceranged"
	icon_dead = "piratespaceranged_dead"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	speed = 1
	armor_base = /obj/item/clothing/suit/space

/mob/living/simple_animal/hostile/human/pirate/ranged/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
