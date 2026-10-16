/mob/living/basic/human/warra
	name = "\improper Vigilitas Security Officer"
	desc = "A member of Vigilitas Interstellar, vacantly staring into the distance, hands near their weapons."
	icon_state = "warra"
	icon_living = "warra"
	stat_attack = HARD_CRIT
	melee_damage_lower = 15
	melee_damage_upper = 15
	habitable_atmos = IMMUNE_ATMOS_REQS
	faction = list(ROLE_DEATHSQUAD)
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_private
	armor_base = /obj/item/clothing/suit/armor/warra
	dodging = TRUE
	callout_set = /datum/ai_callout_set/human/vigilitas
	flashlight_chance = 50

/* ranged guys */

/mob/living/basic/human/warra/ranged
	desc = "A member of Vigilitas Interstellar, vacantly staring into the distance. Their hands are wrapped around the familiarity of a Commander."
	icon_state = "warraranged"
	icon_living = "warraranged"
	retreat_distance = 3
	engage_distance = 5
	casing_type = /obj/item/ammo_casing/c9mm
	burst_shots = 2
	r_hand = /obj/item/gun/ballistic/automatic/pistol/challenger
	projectile_sound = 'sound/weapons/gun/pistol/rattlesnake.ogg'

/mob/living/basic/human/warra/ranged/smg
	name = "\improper Vigilitas Watch"
	desc = "A member of Vigilitas Interstellar, their eyes scan the horizon for motion, tracking flutters of the world with a Resolution PDW."
	icon_state = "warrarangedsmg"
	icon_living = "warrarangedsmg"
	burst_shots = 3
	casing_type = /obj/item/ammo_casing/c46x30mm
	r_hand = /obj/item/gun/ballistic/automatic/smg/resolution
	projectile_sound = 'sound/weapons/gun/smg/resolution.ogg'

/mob/living/basic/human/warra/ranged/shotgun
	name = "\improper Vigilitas Pointman"
	desc = "A member of Vigilitas Interstellar, posture low to the ground. Their palms tightly grip onto the body of a Negotiator shotgun, ready to fire."
	icon_state = "warrarangedsmg"
	icon_living = "warrarangedsmg"
	casing_type = /obj/item/ammo_casing/shotgun/buckshot
	r_hand = /obj/item/gun/ballistic/shotgun/automatic/negotiator
	burst_shots = 1
	projectile_sound = 'sound/weapons/gun/shotgun/shot.ogg'

/mob/living/basic/human/warra/ranged/laser
	name = "\improper Vigilitas Defender"
	desc = "A member of Vigilitas Interstellar, their hands are locked around a laser rifle, actively aiming it at potential threats."
	icon_state = "warrarangedsmg"
	icon_living = "warrarangedsmg"
	burst_shots = 2
	burst_interval = 0.7 SECONDS
	casing_type = null
	projectile_type = /obj/projectile/beam/laser/sharplite
	r_hand = /obj/item/gun/energy/sharplite/surge/resistor
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire.ogg'

/mob/living/basic/human/warra/ranged/laser/space
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	icon_state = "warra_laserspace"
	armor_base = /obj/item/clothing/suit/space/hardsuit/security
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_space
	in_hardsuit = TRUE

/* Assault trooper guys */

/mob/living/basic/human/warra/ranged/trooper
	name = "Vigilitas Trooper"
	desc = "A Vigilitas Assault Officer. Their hands are cradled around a Commander Pistol, ready to bring their aim onto a target."
	icon_state = "warrarangedassault"
	icon_living = "warrarangedassault"
	rapid_melee = 2
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_trooper
	callout_set = /datum/ai_callout_set/human/vigilitas/crisis

/mob/living/basic/human/warra/ranged/trooper/smg
	name = "Vigilitas SMG Trooper"
	desc = "A member of Vigilitas Interstellar. Eyes track motion as they saunter confidently, energy SMG at alert."
	icon_state = "warrarangedsmg"
	icon_living = "warrarangedsmg"
	burst_shots = 5
	burst_interval = 0.2 SECONDS
	casing_type = null
	projectile_type = /obj/projectile/beam/weak/sharplite
	r_hand = /obj/item/gun/energy/sharplite/rush
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire.ogg'

/mob/living/basic/human/warra/ranged/trooper/smg/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	icon_state = "warra_etar"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_space
	in_hardsuit = TRUE

/mob/living/basic/human/warra/ranged/trooper/shotgun
	name = "\improper Vigilitas Pointman"
	desc = "A member of Vigilitas Interstellar, with their chin high up. They confidently aim around their shotgun, ready to burn away any trespassers."
	icon_state = "warrarangedsmg"
	icon_living = "warrarangedsmg"
	casing_type = /obj/item/ammo_casing/energy/laser/shotgun/sharplite
	r_hand = /obj/item/gun/energy/sharplite/amperage
	burst_shots = 2
	burst_interval = 0.5 SECONDS
	retreat_distance = 0
	engage_distance = 1
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire.ogg'

/mob/living/basic/human/warra/ranged/trooper/shotgun/space
	name = "\improper Vigilitas Pointman"
	desc = "A member of Vigilitas Interstellar, clad in white-striped hardsuit. They confidently aim around their shotgun, ready to burn away any trespassers."
	icon_state = "warra_shotgun"
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/hos
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_hos
	in_hardsuit = TRUE

/mob/living/basic/human/warra/ranged/trooper/rifle
	name = "\improper Vigilitas Rifleman"
	desc = "A well-armed member of Vigilitas Interstellar. They stand at the ready with a Hades energy rifle, smirking underneath their gas mask."
	burst_shots = 4
	burst_interval = 0.4 SECONDS
	casing_type = null
	projectile_type = /obj/projectile/beam/laser/assault/sharplite
	r_hand = /obj/item/gun/energy/sharplite/hades
	projectile_sound = 'sound/weapons/gun/laser/e40_las.ogg'

/mob/living/basic/human/warra/ranged/trooper/rifle/space
	name = "Vigilitas Trooper"
	desc = "A member of Vigilitas Interstellar. White stripes painted red with every shot of their rifle, they aim around cautiously."
	icon_state = "warra_hades"
	icon_living = "warra_hades"
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/hos
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_hos
	in_hardsuit = TRUE

/* the elite guy */

/mob/living/basic/human/warra/elite
	name = "Vigilitas Response Team"
	desc = "A hardened member of Vigilitas Interstellar, clad in well made alloys slathered in red. Their helmet turns, their rifle raises, and they start to move with practiced precision."
	burst_shots = 3
	burst_interval = 0.4 SECONDS
	rapid_melee = 3
	retreat_distance = 0
	engage_distance = 1
	minimum_survivable_temperature = 0
	projectile_type = /obj/projectile/beam/laser/assault/sharplite
	projectile_sound = 'sound/weapons/gun/laser/e40_las.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_elite
	armor_base = /obj/item/clothing/suit/space/hardsuit/ert/sec
	r_hand = /obj/item/gun/energy/sharplite/hades
	ai_controller = /datum/ai_controller/basic_controller/human/ranged/rusher // response teams push right in on whoever they're sent after
	morale_breaks = FALSE // professionals, paid to see it through
	callout_set = /datum/ai_callout_set/human/vigilitas/intervention

/mob/living/basic/human/warra/elite/shotgun
	desc = "A hardened member of Vigilitas Interstellar, clad in well made alloys slathered in red. Their helmet turns, Their shotgun blinks, and they glare coldly into your eyes."
	burst_shots = 2
	casing_type = /obj/item/ammo_casing/energy/laser/shotgun/sharplite
	projectile_type = null
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire_light.ogg'
	r_hand = /obj/item/gun/energy/sharplite/amperage
