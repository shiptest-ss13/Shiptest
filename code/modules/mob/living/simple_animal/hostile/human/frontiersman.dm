/mob/living/simple_animal/hostile/human/frontier
	name = "Frontiersman Shank"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one clutches a wicked-looking knife in nimble fingers, eager to relieve you of your innards."
	icon_state = "frontiersmanmelee"
	icon = 'icons/mob/simple_frontiersman.dmi'
	speak_chance = 0
	melee_damage_lower = 15
	melee_damage_upper = 15
	loot = list()
	atmos_requirements = NORMAL_ATMOS_REQS
	faction = list(FACTION_ANTAG_FRONTIERSMEN)
	footstep_type = FOOTSTEP_MOB_SHOE
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier
	r_hand = /obj/item/melee/knife/survival
	dodging = TRUE

/mob/living/simple_animal/hostile/human/frontier/internals
	icon_state = "frontiersmanmelee_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/internals

/mob/living/simple_animal/hostile/human/frontier/ranged
	name = "Frontiersman Quickdraw"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one thumbs a slender revolver, stained chrome and a malicious smile glinting in the light."
	icon_state = "frontiersmanranged"
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	projectilesound = 'sound/weapons/gun/revolver/cattleman.ogg'
	casingtype = /obj/item/ammo_casing/a44roum
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged
	r_hand = /obj/item/gun/ballistic/revolver/shadow

/mob/living/simple_animal/hostile/human/frontier/ranged/internals
	icon_state = "frontiersmanranged_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/neutered
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

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/internals
	icon_state = "frontiersmanrangedrifle_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/mosin/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper
	name = "Frontiersman Doorkicker"
	desc = "A member of the brutal Frontiersman terrorist fleet! Bedecked in military-grade armor, they swagger their shotgun about with a boldness uncommon even among other Frontiersmen."
	icon_state = "frontiersmanrangedelite"
	shoot_point_blank = TRUE
	projectilesound = 'sound/weapons/gun/shotgun/shot.ogg'
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper
	r_hand = /obj/item/gun/ballistic/shotgun/brimstone
	armor_base = /obj/item/clothing/suit/armor/vest/frontier

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/internals
	icon_state = "frontiersmanrangedelite_mask"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/neutered
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
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/internals
	icon_state = "frontiersmanrangedminigun_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/trooper/heavy/neutered
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

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/internals
	icon_state = "frontiersmanofficer_mask"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/officer/internals

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/internals/neutered
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/neutured
	weapon_drop_chance = 0

/mob/living/simple_animal/hostile/human/frontier/ranged/officer/rifle
	name = "Frontiersman Commander"
	desc = "This Frontiersman sways through the world with a deliberate cadence. Their eyes stay up as they search for a target, rubbing at the bolt of their rifle."
	casingtype = /obj/item/ammo_casing/a8_50r/match
	projectilesound = 'sound/weapons/gun/rifle/mosin.ogg'
	r_hand = /obj/item/gun/ballistic/rifle/illestren
	rapid = 2
	rapid_fire_delay = 10
