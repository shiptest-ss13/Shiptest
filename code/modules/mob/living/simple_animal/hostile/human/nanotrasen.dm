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
	r_hand = /obj/item/gun/ballistic/automatic/pistol/commander
	projectilesound = 'sound/weapons/gun/pistol/rattlesnake.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/smg
	name = "\improper Vigilitas Watch"
	desc = "A member of Vigilitas Interstellar, their eyes scan the horizon for motion, tracking flutters of the world with a WT-550."
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	rapid = 3
	casingtype = /obj/item/ammo_casing/c46x30mm
	r_hand = /obj/item/gun/ballistic/automatic/smg/wt550
	projectilesound = 'sound/weapons/gun/smg/shot.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/shotgun
	name = "\improper Vigilitas Pointman"
	desc = "A member of Vigilitas Interstellar, posture low to the ground. Their palms tightly grip onto the body of an HP Hellfire, ready to slam-fire."
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	r_hand = /obj/item/gun/ballistic/shotgun/hellfire
	rapid = 1
	projectilesound = 'sound/weapons/gun/shotgun/shot.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/laser
	name = "\improper Vigilitas Defender"
	desc = "A member of Vigilitas Interstellar, their hands are locked around a laser rifle, actively aiming it at potential threats."
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	rapid = 2
	rapid_fire_delay = 7
	projectiletype = /obj/projectile/beam/laser/sharplite
	r_hand = /obj/item/gun/energy/laser
	projectilesound = 'sound/weapons/gun/smg/shot.ogg'

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
	rapid = 4
	rapid_fire_delay = 4
	projectiletype = /obj/projectile/beam/weak/sharplite
	r_hand = /obj/item/gun/energy/e_gun/smg
	projectilesound = 'sound/weapons/gun/laser/nt-fire.ogg'

/mob/living/simple_animal/hostile/human/nanotrasen/ranged/trooper/rifle
	name = "\improper Vigilitas Rifleman"
	desc = "A well-armed member of Vigilitas Interstellar. They stand at the ready with a Hades energy rifle, smirking underneath their gas mask."
	rapid = 4
	rapid_fire_delay = 4
	projectiletype = /obj/projectile/beam/laser/assault/sharplite
	r_hand = /obj/item/gun/energy/e_gun/hades
	projectilesound = 'sound/weapons/gun/laser/e40_las.ogg'

/* the elite guy */

/mob/living/simple_animal/hostile/human/nanotrasen/elite
	name = "Vigilitas Response Team"
	desc = "A hardened member of Vigilitas Interstellar, clad in well made alloys slathered in red. Their helmet turns, their rifle raises, and they start to move with practiced precision."
	ranged = TRUE
	rapid = 3
	rapid_fire_delay = 5
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
	r_hand = /obj/item/gun/energy/e_gun/hades
