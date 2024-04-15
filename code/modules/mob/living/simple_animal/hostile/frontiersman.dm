/mob/living/simple_animal/hostile/frontier
	name = "Frontiersman"
	desc = "A frontiersman! A terrorist that would probably kill everyone without mercy."
	icon = 'icons/mob/simple_frontiersman.dmi'
	icon_state = "frontiersmanmelee"
	icon_living = "frontiersmanmelee"
	icon_dead = "frontiersmanmelee_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	speed = 0
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier,
				/obj/item/kitchen/knife/combat/survival)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list(FACTION_ANTAG_FRONTIERSMEN)
	status_flags = CANPUSH
	del_on_death = 1

	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/frontier/internals
	icon_state = "frontiersmanmelee_mask"
	icon_living = "frontiersmanmelee_mask"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier,
				/obj/item/clothing/mask/gas/sechailer,
				/obj/item/tank/internals/emergency_oxygen/engi)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0


/mob/living/simple_animal/hostile/frontier/ranged
	icon_state = "frontiersmanranged"
	icon_living = "frontiersmanranged"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged,
				/obj/item/gun/ballistic/revolver)
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	projectilesound = 'sound/weapons/gun/revolver/shot.ogg'
	casingtype = /obj/item/ammo_casing/a357

/mob/living/simple_animal/hostile/frontier/ranged/internals
	icon_state = "frontiersmanranged_mask"
	icon_living = "frontiersmanranged_mask"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged,
				/obj/item/gun/ballistic/revolver,
				/obj/item/clothing/mask/gas/sechailer,
				/obj/item/tank/internals/emergency_oxygen/engi)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0

/mob/living/simple_animal/hostile/frontier/ranged/internals/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged,
				/obj/item/clothing/mask/gas/sechailer,
				/obj/item/tank/internals/emergency_oxygen/engi)

/mob/living/simple_animal/hostile/frontier/ranged/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged)

/mob/living/simple_animal/hostile/frontier/ranged/mosin
	icon_state = "frontiersmanrangedrifle"
	icon_living = "frontiersmanrangedrifle"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged,
				/obj/item/gun/ballistic/rifle/illestren)
	casingtype = /obj/item/ammo_casing/a8_50r
	projectilesound = 'sound/weapons/gun/rifle/mosin.ogg'

/mob/living/simple_animal/hostile/frontier/ranged/mosin/internals
	icon_state = "frontiersmanrangedrifle_mask"
	icon_living = "frontiersmanrangedrifle_mask"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged,
				/obj/item/gun/ballistic/rifle/illestren,
				/obj/item/clothing/mask/gas/sechailer,
				/obj/item/tank/internals/emergency_oxygen/engi)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0

/mob/living/simple_animal/hostile/frontier/ranged/mosin/internals/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged,
				/obj/item/clothing/mask/gas/sechailer,
				/obj/item/tank/internals/emergency_oxygen/engi)

/mob/living/simple_animal/hostile/frontier/ranged/mosin/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged)

/mob/living/simple_animal/hostile/frontier/ranged/trooper
	icon_state = "frontiersmanrangedelite"
	icon_living = "frontiersmanrangedelite"
	maxHealth = 170
	health = 170
	projectilesound = 'sound/weapons/gun/shotgun/shot.ogg'
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/gun/ballistic/shotgun/brimstone)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/internals
	icon_state = "frontiersmanrangedelite_mask"
	icon_living = "frontiersmanrangedelite_mask"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/gun/ballistic/shotgun/brimstone,
				/obj/item/clothing/mask/gas,
				/obj/item/tank/internals/emergency_oxygen/engi)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0

/mob/living/simple_animal/hostile/frontier/ranged/trooper/internals/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/clothing/mask/gas,
				/obj/item/tank/internals/emergency_oxygen/engi)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/skm
	icon_state = "frontiersmanrangedak47"
	icon_living = "frontiersmanrangedak47"
	projectilesound = 'sound/weapons/gun/rifle/skm.ogg'
	rapid = 4
	rapid_fire_delay = 3
	casingtype = /obj/item/ammo_casing/a762_40
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/gun/ballistic/automatic/assault/skm)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/internals
	icon_state = "frontiersmanrangedak47_mask"
	icon_living = "frontiersmanrangedak47_mask"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/gun/ballistic/automatic/assault/skm,
				/obj/item/clothing/mask/gas,
				/obj/item/tank/internals/emergency_oxygen/engi)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0

/mob/living/simple_animal/hostile/frontier/ranged/trooper/internals/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/clothing/mask/gas,
				/obj/item/tank/internals/emergency_oxygen/engi)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/skm/neutured
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/rifle
	icon_state = "frontiersmanrangedmosin"
	icon_living = "frontiersmanrangedmosin"

	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/gun/ballistic/rifle/illestren)
	casingtype = /obj/item/ammo_casing/a8_50r
	projectilesound = 'sound/weapons/gun/rifle/mosin.ogg'

/mob/living/simple_animal/hostile/frontier/ranged/trooper/rifle/internals
	icon_state = "frontiersmanrangedmosin_mask"
	icon_living = "frontiersmanrangedmosin_mask"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/gun/ballistic/rifle/illestren,
				/obj/item/clothing/mask/gas,
				/obj/item/tank/internals/emergency_oxygen/engi)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0

/mob/living/simple_animal/hostile/frontier/ranged/trooper/rifle/internals/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/clothing/mask/gas,
				/obj/item/tank/internals/emergency_oxygen/engi)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/rifle/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/heavy
	icon_state = "frontiersmanrangedminigun"
	icon_living = "frontiersmanrangedminigun"
	projectilesound = 'sound/weapons/laser4.ogg'
	maxHealth = 260
	health = 260
	rapid = 6
	rapid_fire_delay = 1.5
	casingtype = null
	projectiletype = /obj/projectile/beam/weak/penetrator
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/heavy/internals
	icon_state = "frontiersmanrangedminigun_mask"
	icon_living = "frontiersmanrangedminigun_mask"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy,
				/obj/item/clothing/mask/gas,
				/obj/item/tank/internals/emergency_oxygen/engi)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0


/mob/living/simple_animal/hostile/frontier/ranged/trooper/heavy/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy/gunless,
				/obj/item/clothing/mask/gas,
				/obj/item/tank/internals/emergency_oxygen/engi)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/heavy/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy/gunless)

/mob/living/simple_animal/hostile/frontier/ranged/officer
	name = "Frontiersman Officer"
	icon_state = "frontiersmanofficer"
	icon_living = "frontiersmanofficer"
	maxHealth = 65
	health = 65
	rapid = 3
	casingtype = /obj/item/ammo_casing/c9mm
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/officer,
				/obj/item/gun/ballistic/automatic/pistol/APS)

/mob/living/simple_animal/hostile/frontier/ranged/officer/internals
	icon_state = "frontiersmanofficer_mask"
	icon_living = "frontiersmanofficer_mask"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/officer,
				/obj/item/gun/ballistic/automatic/pistol/APS,
				/obj/item/clothing/mask/gas,
				/obj/item/tank/internals/emergency_oxygen/engi)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0

/mob/living/simple_animal/hostile/frontier/ranged/officer/internals/neutered
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/officer,
				/obj/item/clothing/mask/gas,
				/obj/item/tank/internals/emergency_oxygen/engi)

/mob/living/simple_animal/hostile/frontier/ranged/officer/neutured
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/officer)
