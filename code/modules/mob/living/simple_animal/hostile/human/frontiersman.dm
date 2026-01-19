/mob/living/simple_animal/hostile/human/frontier
	name = "Frontiersman Shank"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one clutches a wicked-looking knife in nimble fingers, eager to relieve you of your innards."
	icon_state = "frontiersmanmelee"
	icon = 'icons/mob/simple_frontiersman.dmi'
	speak_chance = 0
	melee_damage_lower = 15
	melee_damage_upper = 15
	loot = list()
	stat_attack = UNCONSCIOUS
	atmos_requirements = NORMAL_ATMOS_REQS
	faction = list(FACTION_ANTAG_FRONTIERSMEN)
	footstep_type = FOOTSTEP_MOB_SHOE
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier
	r_hand = /obj/item/melee/knife/survival
	dodging = TRUE

/mob/living/simple_animal/hostile/human/frontier/civilian
	name = "Frontiersman Doorguard"
	desc = "A new recruit to the brutal Frontiersman terrorist fleet. This one is too new or stupid to even be assigned a knife."
	minimum_distance = 10
	retreat_distance = 10
	obj_damage = 0
	r_hand = null
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/simple_animal/hostile/human/frontier/civilian/Aggro()
	..()
	say("GUARDS!!")

/mob/living/simple_animal/hostile/human/frontier/internals
	icon_state = "frontiersmanmelee_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/internals

/mob/living/simple_animal/hostile/human/frontier/axe
	name = "Frontiersman Chopper"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one clutches bulky combat axe, riveting the idea of turning your innards to gore."
	icon_state = "frontiersmanmelee"
	icon = 'icons/mob/simple_frontiersman.dmi'
	speak_chance = 0
	melee_damage_lower = 25
	melee_damage_upper = 25
	armour_penetration = 10
	loot = list()
	r_hand = /obj/item/melee/boarding_axe

/mob/living/simple_animal/hostile/human/frontier/axe/internals
	icon_state = "frontiersmanmelee_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/internals

/mob/living/simple_animal/hostile/human/frontier/ranged
	name = "Frontiersman Quickdraw"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one thumbs a slender pistol, stained chrome and a malicious smile glinting in the light."
	icon_state = "frontiersmanranged"
	ranged = 1
	rapid_fire_delay = 1.5 SECONDS
	retreat_distance = 5
	minimum_distance = 5
	projectilesound = 'sound/weapons/gun/pistol/mauler.ogg'
	casingtype = /obj/item/ammo_casing/c9mm
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged
	r_hand = /obj/item/gun/ballistic/automatic/pistol/mauler/regular

/mob/living/simple_animal/hostile/human/frontier/ranged/space
	icon_state = "frontiersmanranged_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/simple_animal/hostile/human/frontier/ranged/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/frontier/ranged/internals
	icon_state = "frontiersmanranged_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/wasp
	name = "Frontiersman Searer"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one's trigger finger itches, ready to dump their entire laser SMG cell into an unlucky person."
	icon_state = "frontiersmanranged"
	retreat_distance = 2
	minimum_distance = 1
	projectilesound = 'sound/weapons/laser4.ogg'
	rapid = 2
	casingtype = null
	projectiletype = /obj/projectile/beam/laser/eoehoma/wasp
	rapid_fire_delay = 0.18 SECONDS
	r_hand = /obj/item/gun/energy/laser/wasp
	spread = 12

/mob/living/simple_animal/hostile/human/frontier/ranged/wasp/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/wasp/internals
	icon_state = "frontiersmanranged_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/wasp/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/pounder
	name = "Frontiersman Slammer"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one gingerly stares forward, eager to pull the trigger on their antiquidated SMG."
	icon_state = "frontiersmanranged"
	retreat_distance = 3
	minimum_distance = 2
	rapid = 10
	rapid_fire_delay = 1
	projectilesound = 'sound/weapons/gun/smg/pounder.ogg'
	casingtype = /obj/item/ammo_casing/c22lr
	r_hand = /obj/item/gun/ballistic/automatic/smg/pounder

/mob/living/simple_animal/hostile/human/frontier/ranged/pounder/internals
	icon_state = "frontiersmanranged_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/pounder/space
	icon_state = "frontiersmanranged_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1000
	icon_state = "frontiersmanpounder"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/simple_animal/hostile/human/frontier/ranged/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/frontier/ranged/surgeon
	name = "Frontiersman Sawbones"
	desc = "A member of the brutal Frontiersman terrorist fleet! They appear to be a \"doctor\" of some sort, nervously swinging about some kind of makeshift syringe launcher."
	icon_state = "frontiersmansurgeon"
	icon_living = "frontiersmansurgeon"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/surgeon
	l_hand = /obj/item/melee/knife/survival
	r_hand = /obj/item/gun/syringe
	minimum_distance = 1
	retreat_distance = null
	projectiletype = /obj/projectile/bullet/dart/tranq
	projectilesound = 'sound/items/syringeproj.ogg'
	casingtype = null
	ranged_message = "fires the syringe gun at"
	ranged_cooldown_time = 30
	armor_base = /obj/item/clothing/suit/frontiersmen

/mob/living/simple_animal/hostile/human/frontier/ranged/surgeon/neuter
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/surgeon/internals
	icon_state = "frontiersmansurgeon_mask"
	icon_living = "frontiersmansurgeon_mask"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/surgeon/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/surgeon/internals/neuter
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin
	name = "Frontiersman Sharpshot"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one confidently mills about with a long rifle slung over their shoulder."
	icon_state = "frontiersmanrangedrifle"
	casingtype = /obj/item/ammo_casing/a8_50r
	projectilesound = 'sound/weapons/gun/rifle/mosin.ogg'
	r_hand = /obj/item/gun/ballistic/rifle/illestren

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/neutered/sentry
	name = "Frontiersman Sentry"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one waits patiently, their finger on the trigger, as the glint of their scope in the sun catches your eye."
	vision_range = 14
	aggro_vision_range = 14
	minimum_distance = 14
	stop_automated_movement = 1
	wander = 0
	retreat_distance = 0
	environment_smash = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/space
	icon_state = "frontiersmanrangedrifle_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	icon_state = "frontiersmanrangedrifle_space"
	minbodytemp = 0
	maxbodytemp = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/space/sentry
	stop_automated_movement = 1
	wander = 0
	retreat_distance = 0
	environment_smash = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/internals
	icon_state = "frontiersmanrangedrifle_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/internals/neutered/sentry
	name = "Frontiersman Sentry"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one waits patiently, their finger on the trigger, as the glint of their scope in the sun catches your eye."
	vision_range = 14
	aggro_vision_range = 14
	minimum_distance = 14
	stop_automated_movement = 1
	wander = 0
	retreat_distance = 0
	environment_smash = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper
	name = "Frontiersman Doorkicker"
	desc = "A member of the brutal Frontiersman terrorist fleet! Bedecked in military-grade armor, they swagger their shotgun about with a boldness uncommon even among other Frontiersmen."
	icon_state = "frontiersmanrangedelite"
	shoot_point_blank = TRUE
	projectilesound = 'sound/weapons/gun/shotgun/brimstone.ogg'
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper
	r_hand = /obj/item/gun/ballistic/shotgun/automatic/slammer
	armor_base = /obj/item/clothing/suit/armor/vest/frontier

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/internals
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/spitter
	name = "Frontiersman Runner"
	desc = "A quick-footed member of the brutal Frontiersman terrorist fleet! This one wields a boxy submachine gun in one hand."
	rapid = 8
	rapid_fire_delay = 1
	retreat_distance = 4
	minimum_distance = 4
	projectilesound = 'sound/weapons/gun/smg/spitter.ogg'
	casingtype = /obj/item/ammo_casing/c9mm
	r_hand = /obj/item/gun/ballistic/automatic/pistol/spitter

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/spitter/internals
	icon_state = "frontiersmanrangedelite_mask"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/spitter/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/space
	icon_state = "frontiersmanrangedelite_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	icon_state = "frontiersmenrangedelite_space"
	minbodytemp = 0
	maxbodytemp = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/space/spitter
	name = "Frontiersman Runner"
	desc = "A quick-footed member of the brutal Frontiersmen terrorist fleet! This one clutches a boxy submachine gun with the bulky gauntlets of their grey hardsuit."
	rapid = 8
	rapid_fire_delay = 1
	retreat_distance = 4
	minimum_distance = 4
	projectilesound = 'sound/weapons/gun/smg/spitter.ogg'
	casingtype = /obj/item/ammo_casing/c9mm
	r_hand = /obj/item/gun/ballistic/automatic/pistol/spitter

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/space/spitter/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/f3
	name = "Frontiersman Marksman"
	desc = "A member of the brutal Frontiersman terrorist fleet! Bedecked in military-grade armor, they steadily hold their aging DMR in your direction."
	icon_state = "frontiersmanrangedmosin"
	shoot_point_blank = TRUE
	projectilesound = 'sound/weapons/gun/rifle/f4.ogg'
	rapid = 2
	rapid_fire_delay = 5
	casingtype = /obj/item/ammo_casing/a308
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper
	r_hand = /obj/item/gun/ballistic/automatic/marksman/f4/indie
	armor_base = /obj/item/clothing/suit/armor/vest/frontier


/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/f3/sentry
	vision_range = 14
	aggro_vision_range = 14
	minimum_distance = 14
	stop_automated_movement = 1
	wander = 0
	retreat_distance = 0
	environment_smash = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/wasp
	name = "Frontiersman Stinger"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one is well protected with their laser SMG, ready to scorch anyone who stands in their way."
	icon_state = "frontiersmanrangedak47"
	retreat_distance = 2
	minimum_distance = 1
	projectilesound = 'sound/weapons/laser4.ogg'
	rapid = 3
	spread = 12
	casingtype = null
	projectiletype = /obj/projectile/beam/laser/eoehoma/wasp
	rapid_fire_delay = 0.1 SECONDS
	r_hand = /obj/item/gun/energy/laser/wasp

/mob/living/simple_animal/hostile/human/frontier/ranged/wasp/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/wasp/internals
	icon_state = "frontiersmanrangedak47_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/wasp/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/flame
	name = "Frontiersman Scorcher"
	desc = "An ashen revenant wades through a sea of flames, mummified under twenty pounds of blackened asbestos fabric. Mirrored lenses glare inscrutably as they swing their instrument of destruction towards you. You should probably run."
	icon_state = "frontiersmanflametrooper"
	icon_living = "frontiersmanflametrooper"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/flame
	r_hand = /obj/item/flamethrower
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1000

	minimum_distance = 1
	retreat_distance = null
	shoot_point_blank = TRUE
	projectiletype = null
	projectilesound = 'sound/weapons/gun/flamethrower/flamethrower1.ogg'
	casingtype = null
	armor_base = /obj/item/clothing/suit/armor/frontier/fireproof

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/flame/OpenFire()
	var/turf/T = get_ranged_target_turf_direct(src, target, 4)
	var/list/burn_turfs = getline(src, T) - get_turf(src)
	visible_message(span_danger("<b>[src]</b> [ranged_message] at [target.name]!"))
	playsound(src, projectilesound, 100, TRUE)
	fire_line(src, burn_turfs, "flamethrower", TRUE, 10)
	ranged_cooldown = world.time + ranged_cooldown_time

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/flame/neuter
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/skm
	name = "Frontiersman Gunner"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one could almost be mistaken for a real soldier by their assault rifle and armor, if it weren't for their swaggering demeanor."
	icon_state = "frontiersmanrangedak47"
	projectilesound = 'sound/weapons/gun/rifle/skm.ogg'
	rapid = 4
	rapid_fire_delay = 3
	casingtype = /obj/item/ammo_casing/a762_40
	armor_base = /obj/item/clothing/suit/armor/vest/frontier
	r_hand = /obj/item/gun/ballistic/automatic/assault/skm

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/skm/space
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1000
	icon_state = "frontiersmanrangedak47_space"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/skm/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/skm/internals
	icon_state = "frontiersmanrangedak47_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals
	r_hand = /obj/item/gun/ballistic/automatic/assault/skm

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/skm/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/skm/neutured
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/rifle
	name = "Frontiersman Crackshot"
	desc = "A member of the brutal Frontiersman terrorist fleet! Compared to their allies, they stand a little straighter, laugh a little colder. Their long rifle has a regular series of scratches on the receiver."
	icon_state = "frontiersmanrangedmosin"
	casingtype = /obj/item/ammo_casing/a8_50r
	projectilesound = 'sound/weapons/gun/rifle/mosin.ogg'
	armor_base = /obj/item/clothing/suit/armor/vest/frontier
	r_hand = /obj/item/gun/ballistic/rifle/illestren

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/rifle/internals
	icon_state = "frontiersmanrangedmosin_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/rifle/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/rifle/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy
	name = "Frontiersman Sweeper"
	desc = "A horrifically still mass of plasteel and flesh. Its motions are filled with a deliberate and exacting malice. Its weapon is raised, and it prepares to pull the trigger."
	icon_state = "frontiersmanrangedminigun"
	projectilesound = 'sound/weapons/gun/hmg/shredder.ogg'
	rapid = 5
	rapid_fire_delay = 2
	casingtype = /obj/item/ammo_casing/shotgun
	r_hand = /obj/item/gun/ballistic/automatic/hmg/shredder
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy
	armor_base = /obj/item/clothing/suit/armor/vest/marine/frontier

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/space
	icon_state = "frontiersmanranged_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1000
	icon_state = "frontiersmanrangedminigun_space"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space

/mob/living/simple_animal/hostile/human/frontier/ranged/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/internals
	icon_state = "frontiersmanrangedminigun_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/internals/buckshot
	casingtype = /obj/item/ammo_casing/shotgun/buckshot

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/internals/buckshot/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/space/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/buckshot
	casingtype = /obj/item/ammo_casing/shotgun/buckshot

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/buckshot/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/officer
	name = "Frontiersman Boss"
	desc = "This Frontiersman moves with what could almost pass for discipline among the infamously ragtag terrorists. They leer at their underlings, one hand resting consciously over the machine pistol at their hip."
	icon_state = "frontiersmanofficer"
	rapid = 6
	rapid_fire_delay = 1
	shoot_point_blank = TRUE
	projectilesound = 'sound/weapons/gun/pistol/mauler.ogg'
	casingtype = /obj/item/ammo_casing/c9mm
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/officer
	r_hand = /obj/item/gun/ballistic/automatic/pistol/mauler
	armor_base = /obj/item/clothing/suit/armor/frontier

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/neutured
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/cm15
	name = "Frontiersman Boss"
	desc = "This Frontiersman moves with what could almost pass for discipline among the infamously ragtag terrorists. They leer at their underlings, a chrome combat shotgun within their hands."
	rapid = 2
	rapid_fire_delay = 7
	retreat_distance = 4
	minimum_distance = 3
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	projectilesound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	shoot_point_blank = TRUE
	r_hand = /obj/item/gun/ballistic/shotgun/cm15
	weapon_drop_chance = 100

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/rifle
	name = "Frontiersman Commander"
	desc = "This Frontiersman sways through the world with a deliberate cadence. Their eyes stay up as they search for a target, rubbing at the bolt of their rifle."
	casingtype = /obj/item/ammo_casing/a8_50r/match
	projectilesound = 'sound/weapons/gun/rifle/mosin.ogg'
	r_hand = /obj/item/gun/ballistic/rifle/illestren
	rapid = 2
	rapid_fire_delay = 10

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/rifle/neutered
	weapon_drop_chance = 100

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/internals
	icon_state = "frontiersmanofficer_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/officer/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/rifle/internals
	icon_state = "frontiersmanofficer_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/officer/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/rifle/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/wasp
	name = "Frontiersman Captain"
	desc = "This Frontiersman stands with a pride that the lesser Frontiersmen lack. They look with haughty superiority at their surroundings, right hand clutching a wasp with the surety of its use."
	retreat_distance = 2
	minimum_distance = 1
	projectilesound = 'sound/weapons/laser4.ogg'
	rapid = 4
	spread = 16
	casingtype = null
	projectiletype = /obj/projectile/beam/laser/eoehoma/wasp
	rapid_fire_delay = 0.1 SECONDS
	r_hand = /obj/item/gun/energy/laser/wasp

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/wasp/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/wasp/internals
	icon_state = "frontiersmanofficer_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/officer/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/wasp/internals/neutered
	weapon_drop_chance = 0
