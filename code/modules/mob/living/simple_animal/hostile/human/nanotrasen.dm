/mob/living/simple_animal/hostile/human/nanotrasen
	name = "\improper Vigilitas Security Officer"
	desc = "A member of Vigilitas Interstellar, vacantly staring into the distance, hands near their weapons."
	icon_state = "nanotrasen"
	icon_living = "nanotrasen"
	speak_chance = 0
	stat_attack = HARD_CRIT
	melee_damage_lower = 15
	melee_damage_upper = 15
	atmos_requirements = IMMUNE_ATMOS_REQS
	faction = list(ROLE_DEATHSQUAD)
	check_friendly_fire = TRUE
	loot = list()
	dodging = TRUE
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_private
	armor_base = /obj/item/clothing/suit/armor/nanotrasen

/* ranged guys */

/mob/living/simple_animal/hostile/human/nanotrasen/ranged
	desc = "A member of Vigilitas Interstellar, vacantly staring into the distance. Their hands are wrapped around the familiarity of a Commander."
	icon_state = "nanotrasenranged"
	icon_living = "nanotrasenranged"
	ranged = 1
	retreat_distance = 3
	minimum_distance = 5
	casingtype = /obj/item/ammo_casing/c9mm
	rapid = 2
	r_hand = /obj/item/gun/ballistic/automatic/pistol/challenger
	projectilesound = 'sound/weapons/gun/pistol/rattlesnake.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/smg
	name = "\improper Vigilitas Watch"
	desc = "A member of Vigilitas Interstellar, their eyes scan the horizon for motion, tracking flutters of the world with a Resolution PDW."
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	rapid = 3
	casingtype = /obj/item/ammo_casing/c46x30mm
	r_hand = /obj/item/gun/ballistic/automatic/smg/resolution
	projectilesound = 'sound/weapons/gun/smg/resolution.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/shotgun
	name = "\improper Vigilitas Pointman"
	desc = "A member of Vigilitas Interstellar, posture low to the ground. Their palms tightly grip onto the body of a Negotiator shotgun, ready to fire."
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	r_hand = /obj/item/gun/ballistic/shotgun/automatic/negotiator
	rapid = 1
	projectilesound = 'sound/weapons/gun/shotgun/shot.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/laser
	name = "\improper Vigilitas Defender"
	desc = "A member of Vigilitas Interstellar, their hands are locked around a laser rifle, actively aiming it at potential threats."
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	rapid = 2
	rapid_fire_delay = 7
	casingtype = null
	projectiletype = /obj/projectile/beam/laser/sharplite
	r_hand = /obj/item/gun/energy/sharplite/l201/l204
	projectilesound = 'sound/weapons/gun/laser/nt-fire.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/laser/space
	minbodytemp = 0
	maxbodytemp = 1000
	icon_state = "nanotrasen_laserspace"
	armor_base = /obj/item/clothing/suit/space/hardsuit/security
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_space

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/laser/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/* Assault trooper guys */

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper
	name = "Vigilitas Trooper"
	desc = "A Vigilitas Assault Officer. Their hands are cradled around a Commander Pistol, ready to bring their aim onto a target."
	icon_state = "nanotrasenrangedassault"
	icon_living = "nanotrasenrangedassault"
	icon_dead = null
	icon_gib = "syndicate_gib"
	rapid_melee = 2
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_trooper

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper/smg
	name = "Vigilitas SMG Trooper"
	desc = "A member of Vigilitas Interstellar. Eyes track motion as they saunter confidently, energy SMG at alert."
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	rapid = 5
	rapid_fire_delay = 2
	casingtype = null
	projectiletype = /obj/projectile/beam/weak/sharplite
	r_hand = /obj/item/gun/energy/sharplite/l305
	projectilesound = 'sound/weapons/gun/laser/nt-fire.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper/shotgun
	name = "\improper Vigilitas Pointman"
	desc = "A member of Vigilitas Interstellar, with their chin high up. They confidently aim around their shotgun, ready to burn away any trespassers."
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	casingtype = /obj/item/ammo_casing/energy/laser/shotgun/sharplite
	r_hand = /obj/item/gun/energy/sharplite/x46
	rapid = 2
	rapid_fire_delay = 5
	retreat_distance = 0
	minimum_distance = 1
	shoot_point_blank = TRUE
	projectilesound = 'sound/weapons/gun/laser/nt-fire.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper/shotgun/space
	name = "\improper Vigilitas Pointman"
	desc = "A member of Vigilitas Interstellar, clad in white-striped hardsuit. They confidently aim around their shotgun, ready to burn away any trespassers."
	icon_state = "nanotrasen_shotgun"
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/hos
	minbodytemp = 0
	maxbodytemp = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_hos

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper/shotgun/space/Initialize()

	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper/smg/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security
	minbodytemp = 0
	maxbodytemp = 1000
	icon_state = "nanotrasen_etar"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_space

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper/smg/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper/rifle
	name = "\improper Vigilitas Rifleman"
	desc = "A well-armed member of Vigilitas Interstellar. They stand at the ready with a Hades energy rifle, smirking underneath their gas mask."
	rapid = 4
	rapid_fire_delay = 4
	casingtype = null
	projectiletype = /obj/projectile/beam/laser/assault/sharplite
	r_hand = /obj/item/gun/energy/sharplite/al655
	projectilesound = 'sound/weapons/gun/laser/e40_las.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper/rifle/space
	name = "Vigilitas Trooper"
	desc = "A member of Vigilitas Interstellar. White stripes painted red with every shot of their rifle, they aim around cautiously."
	icon_state = "nanotrasen_hades"
	icon_living = "nanotrasen_hades"
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/hos
	minbodytemp = 0
	maxbodytemp = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_hos

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper/rifle/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/* the elite guy */

/mob/living/simple_animal/hostile/human/nanotrasen/elite
	name = "Vigilitas Response Team"
	desc = "A hardened member of Vigilitas Interstellar, clad in well made alloys slathered in red. Their helmet turns, their rifle raises, and they start to move with practiced precision."
	ranged = TRUE
	rapid = 3
	rapid_fire_delay = 4
	rapid_melee = 3
	retreat_distance = 0
	minimum_distance = 1
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	projectiletype = /obj/projectile/beam/laser/assault/sharplite
	projectilesound = 'sound/weapons/gun/laser/e40_las.ogg'
	faction = list(ROLE_DEATHSQUAD)
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_elite
	armor_base = /obj/item/clothing/suit/space/hardsuit/ert/sec
	r_hand = /obj/item/gun/energy/sharplite/al655

/mob/living/simple_animal/hostile/human/nanotrasen/elite/shotgun
	name = "Vigilitas Response Team"
	desc = "A hardened member of Vigilitas Interstellar, clad in well made alloys slathered in red. Their helmet turns, Their shotgun blinks, and they glare coldly into your eyes."
	ranged = TRUE
	rapid = 2
	rapid_fire_delay = 4
	rapid_melee = 3
	retreat_distance = 0
	minimum_distance = 1
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	casingtype = /obj/item/ammo_casing/energy/laser/shotgun/sharplite
	projectiletype = null
	projectilesound = 'sound/weapons/gun/laser/nt-fire_light.ogg'
	r_hand = /obj/item/gun/energy/sharplite/x46
