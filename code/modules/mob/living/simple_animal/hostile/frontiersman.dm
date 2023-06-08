/mob/living/simple_animal/hostile/frontier
	name = "Frontiersman"
	desc = "A frontiersman! A terrorist that would probably kill everyone without mercy."
	icon = 'icons/mob/simple_human.dmi'
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
				/obj/item/kitchen/knife)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("frontiersman")
	status_flags = CANPUSH
	del_on_death = 1

	footstep_type = FOOTSTEP_MOB_SHOE


/mob/living/simple_animal/hostile/frontier/ranged
	icon_state = "frontiersmanranged"
	icon_living = "frontiersmanranged"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged,
				/obj/item/gun/ballistic/revolver/nagant)
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	projectilesound = 'sound/weapons/gun/revolver/shot.ogg'
	casingtype = /obj/item/ammo_casing/n762


/mob/living/simple_animal/hostile/frontier/ranged/mosin
	icon_state = "frontiersmanrangedrifle"
	icon_living = "frontiersmanrangedrifle"
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged,
				/obj/item/gun/ballistic/rifle/boltaction)
	casingtype = /obj/item/ammo_casing/a762
	projectilesound = 'sound/weapons/gun/rifle/mosin.ogg'

/mob/living/simple_animal/hostile/frontier/ranged/trooper
	icon_state = "frontiersmanrangedelite"
	icon_living = "frontiersmanrangedelite"
	maxHealth = 170
	health = 170
	projectilesound = 'sound/weapons/gun/shotgun/shot.ogg'
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/gun/ballistic/shotgun/lethal)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/ak47
	icon_state = "frontiersmanrangedak47"
	icon_living = "frontiersmanrangedak47"
	projectilesound = 'sound/weapons/gun/rifle/ak47.ogg'
	rapid = 4
	rapid_fire_delay = 3
	casingtype = /obj/item/ammo_casing/a762_39
	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/gun/ballistic/automatic/assualt/ak47)

/mob/living/simple_animal/hostile/frontier/ranged/trooper/rifle
	icon_state = "frontiersmanrangedmosin"
	icon_living = "frontiersmanrangedmosin"

	loot = list(/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper,
				/obj/item/gun/ballistic/rifle/boltaction)
	casingtype = /obj/item/ammo_casing/a762
	projectilesound = 'sound/weapons/gun/rifle/mosin.ogg'

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

/mob/living/simple_animal/hostile/frontier/ranged/officer/Aggro()
	..()
	summon_backup(15)
	say(pick("Help!!", "They're right here!!", "Don't let me die!!"))
