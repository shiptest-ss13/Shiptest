/mob/living/simple_animal/hostile/human/nanotrasen
	name = "\improper Nanotrasen Private Security Officer"
	desc = "An officer part of Nanotrasen's private security force, he seems rather unpleased to meet you."
	icon_state = "nanotrasen"
	icon_living = "nanotrasen"
	speak_chance = 0
	stat_attack = HARD_CRIT
	melee_damage_upper = 15
	loot = list(/obj/effect/mob_spawn/human/corpse/nanotrasensoldier)
	faction = list(ROLE_DEATHSQUAD)
	check_friendly_fire = TRUE
	dodging = TRUE
	armor_base = /obj/item/clothing/suit/armor/vest

/mob/living/simple_animal/hostile/human/nanotrasen/screaming
	icon_state = "nanotrasen"
	icon_living = "nanotrasen"

/mob/living/simple_animal/hostile/human/nanotrasen/screaming/Aggro()
	..()
	summon_backup(15)
	say("411 in progress, requesting backup!")


/mob/living/simple_animal/hostile/human/nanotrasen/ranged
	icon_state = "nanotrasenranged"
	icon_living = "nanotrasenranged"
	ranged = 1
	retreat_distance = 3
	minimum_distance = 5
	casingtype = /obj/item/ammo_casing/c45
	projectilesound = 'sound/weapons/gun/pistol/shot_alt.ogg'


/mob/living/simple_animal/hostile/human/nanotrasen/ranged/smg
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	rapid = 3
	casingtype = /obj/item/ammo_casing/c46x30mm
	projectilesound = 'sound/weapons/gun/smg/shot.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/assault
	name = "Nanotrasen Assault Officer"
	desc = "A Nanotrasen Assault Officer. Prepare to die, if you've been found near Syndicate property."
	icon_state = "nanotrasenrangedassault"
	icon_living = "nanotrasenrangedassault"
	icon_dead = null
	icon_gib = "syndicate_gib"
	ranged = TRUE
	rapid = 4
	rapid_fire_delay = 1
	rapid_melee = 1
	retreat_distance = 2
	minimum_distance = 4
	casingtype = /obj/item/ammo_casing/c46x30mm
	projectilesound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	loot = list(/obj/effect/mob_spawn/human/corpse/nanotrasenassaultsoldier)

/mob/living/simple_animal/hostile/human/nanotrasen/elite
	name = "Nanotrasen Elite Assault Officer"
	desc = "Pray for your life, syndicate. Run while you can."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "nanotrasen_ert"
	icon_living = "nanotrasen_ert"
	melee_damage_lower = 13
	melee_damage_upper = 18
	ranged = TRUE
	rapid = 3
	rapid_fire_delay = 5
	rapid_melee = 3
	retreat_distance = 0
	minimum_distance = 1
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	projectiletype = /obj/projectile/beam/laser
	projectilesound = 'sound/weapons/laser.ogg'
	loot = list(/obj/effect/gibspawner/human)
	faction = list(ROLE_DEATHSQUAD)
	armor_base = /obj/item/clothing/suit/space/hardsuit/ert/sec
