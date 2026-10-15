/mob/living/basic/human/frontier
	name = "Frontiersman Shank"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one clutches a wicked-looking knife in nimble fingers, eager to relieve you of your innards."
	icon_state = "frontiersmanmelee"
	icon = 'icons/mob/simple_frontiersman.dmi'
	melee_damage_lower = 15
	melee_damage_upper = 15
	stat_attack = UNCONSCIOUS
	habitable_atmos = NORMAL_ATMOS_REQS
	faction = list(FACTION_ANTAG_FRONTIERSMEN)
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier
	r_hand = /obj/item/melee/knife/survival
	dodging = TRUE
	callout_set = /datum/ai_callout_set/human/frontier

/mob/living/basic/human/frontier/civilian
	noncombatant = TRUE
	callout_set = /datum/ai_callout_set/noncombatant // they shout for help, and plead when cornered
	on_aggro_say = list("GUARDS!!")
	aggro_say_chance = 100
	name = "Frontiersman Doorguard"
	desc = "A new recruit to the brutal Frontiersman terrorist fleet. This one is too new or stupid to even be assigned a knife."
	engage_distance = 10
	retreat_distance = 10
	obj_damage = 0
	r_hand = null
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/basic/human/frontier/internals
	icon_state = "frontiersmanmelee_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/internals

/mob/living/basic/human/frontier/mace
	name = "Frontiersman Bludgeon"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one clutches a terrifying metallic mace, eager to shatter your ribs."
	icon_state = "frontiersmanmelee"
	icon = 'icons/mob/simple_frontiersman.dmi'
	melee_damage_lower = 25
	melee_damage_upper = 25
	armour_penetration = 20
	r_hand = /obj/item/melee/trench_club
	sharpness = SHARP_NONE
	dodging = TRUE

/mob/living/basic/human/frontier/mace/internals
	icon_state = "frontiersmanmelee_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/internals

/mob/living/basic/human/frontier/junkie
	name = "Frontiersman Junkie"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one froths at the mouth, loaded with combat stimulants and pale hands as they clench a pair of brass knuckles."
	icon_state = "frontiersmanmelee"
	icon = 'icons/mob/simple_frontiersman.dmi'
	melee_damage_lower = 15
	melee_damage_upper = 15
	rapid_melee = 3
	l_hand = /obj/item/brass_knuckles
	r_hand = null
	sharpness = SHARP_NONE
	dodging = TRUE

/mob/living/basic/human/frontier/junkie/internals
	icon_state = "frontiersmanmelee_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/internals

/mob/living/basic/human/frontier/axe
	name = "Frontiersman Chopper"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one clutches bulky combat axe, riveting the idea of turning your innards to gore."
	icon_state = "frontiersmanmelee"
	icon = 'icons/mob/simple_frontiersman.dmi'
	melee_damage_lower = 25
	melee_damage_upper = 25
	armour_penetration = 10
	r_hand = /obj/item/melee/boarding_axe

/mob/living/basic/human/frontier/axe/internals
	icon_state = "frontiersmanmelee_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/internals

/mob/living/basic/human/frontier/hullpiercer
	on_aggro_say = list("IN OUR HEARTS AND IN OUR BLOOD, I'LL KILL UNTIL OUR FREEDOM'S WON!!")
	aggro_say_chance = 100
	in_hardsuit = TRUE
	name = "Frontiersman Hullpiercer"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one wields a massive hullpiercing axe wrapped designed specifically to slice apart ship hulls and to butcher the poor souls in them. You hear them growling as they spit bits and pieces of wholly incomprehensible poetry."
	icon_state = "frontiersmanmeleehullpiercer"
	icon_living = "frontiersmanmeleehullpiercer"
	melee_damage_lower = 35
	melee_damage_upper = 35
	armour_penetration = 20
	maxHealth = 175
	health = 175
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier
	attack_verb_continuous = "cleaved"
	attack_verb_simple = "chopped"
	attack_sound = list('sound/weapons/melee/heavyaxe_hit1.ogg', 'sound/weapons/melee/heavyaxe_hit2.ogg')
	stat_attack = HARD_CRIT
	rapid_melee = 2
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	habitable_atmos = IMMUNE_ATMOS_REQS
	l_hand = /obj/item/melee/axe/frontiersmen_axe
	r_hand = null
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/hullpiercer

/mob/living/basic/human/frontier/ranged
	name = "Frontiersman Quickdraw"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one thumbs a slender pistol, stained chrome and a malicious smile glinting in the light."
	icon_state = "frontiersmanranged"
	burst_interval = 1.5 SECONDS
	retreat_distance = 5
	engage_distance = 5
	projectile_sound = 'sound/weapons/gun/pistol/mauler.ogg'
	casing_type = /obj/item/ammo_casing/c9mm
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged
	r_hand = /obj/item/gun/ballistic/automatic/pistol/mauler/regular

/mob/living/basic/human/frontier/ranged/space
	in_hardsuit = TRUE
	icon_state = "frontiersmanranged_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/basic/human/frontier/ranged/internals
	icon_state = "frontiersmanranged_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/internals

/mob/living/basic/human/frontier/ranged/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/wasp
	name = "Frontiersman Searer"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one's trigger finger itches, ready to dump their entire laser SMG cell into an unlucky person."
	icon_state = "frontiersmanranged"
	retreat_distance = 2
	engage_distance = 1
	projectile_sound = 'sound/weapons/laser4.ogg'
	burst_shots = 2
	casing_type = null
	projectile_type = /obj/projectile/beam/laser/eoehoma/wasp
	burst_interval = 0.18 SECONDS
	r_hand = /obj/item/gun/energy/laser/wasp
	spread = 12

/mob/living/basic/human/frontier/ranged/wasp/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/wasp/internals
	icon_state = "frontiersmanranged_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/internals

/mob/living/basic/human/frontier/ranged/wasp/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/pounder
	name = "Frontiersman Slammer"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one gingerly stares forward, eager to pull the trigger on their antiquidated SMG."
	icon_state = "frontiersmanranged"
	retreat_distance = 3
	engage_distance = 2
	burst_shots = 10
	burst_interval = 1
	projectile_sound = 'sound/weapons/gun/smg/pounder.ogg'
	casing_type = /obj/item/ammo_casing/c22lr
	r_hand = /obj/item/gun/ballistic/automatic/smg/pounder

/mob/living/basic/human/frontier/ranged/pounder/internals
	icon_state = "frontiersmanranged_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/internals

/mob/living/basic/human/frontier/ranged/pounder/space
	icon_state = "frontiersmanranged_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	icon_state = "frontiersmanpounder"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/basic/human/frontier/ranged/surgeon
	name = "Frontiersman Sawbones"
	desc = "A member of the brutal Frontiersman terrorist fleet! They appear to be a \"doctor\" of some sort, nervously swinging about some kind of makeshift syringe launcher."
	icon_state = "frontiersmansurgeon"
	icon_living = "frontiersmansurgeon"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/surgeon
	l_hand = /obj/item/melee/knife/survival
	r_hand = /obj/item/gun/syringe
	engage_distance = 1
	retreat_distance = null
	projectile_type = /obj/projectile/bullet/dart/tranq
	projectile_sound = 'sound/items/syringeproj.ogg'
	casing_type = null
	ranged_cooldown = 30
	armor_base = /obj/item/clothing/suit/frontiersmen

/mob/living/basic/human/frontier/ranged/surgeon/neuter
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/surgeon/internals
	icon_state = "frontiersmansurgeon_mask"
	icon_living = "frontiersmansurgeon_mask"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/surgeon/internals

/mob/living/basic/human/frontier/ranged/surgeon/internals/neuter
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/mosin
	name = "Frontiersman Sharpshot"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one confidently mills about with a long rifle slung over their shoulder."
	icon_state = "frontiersmanrangedrifle"
	casing_type = /obj/item/ammo_casing/a8_50r
	projectile_sound = 'sound/weapons/gun/rifle/mosin.ogg'
	r_hand = /obj/item/gun/ballistic/rifle/illestren

/mob/living/basic/human/frontier/ranged/mosin/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/mosin/neutered/sentry
	name = "Frontiersman Sentry"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one waits patiently, their finger on the trigger, as the glint of their scope in the sun catches your eye."
	vision_range = 14
	engage_distance = 14
	wander = FALSE
	retreat_distance = 0
	environment_smash = 0

/mob/living/basic/human/frontier/ranged/mosin/space
	in_hardsuit = TRUE
	icon_state = "frontiersmanrangedrifle_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	icon_state = "frontiersmanrangedrifle_space"
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/basic/human/frontier/ranged/mosin/space/sentry
	wander = FALSE
	retreat_distance = 0
	environment_smash = 0

/mob/living/basic/human/frontier/ranged/mosin/internals
	icon_state = "frontiersmanrangedrifle_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/internals

/mob/living/basic/human/frontier/ranged/mosin/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/mosin/internals/neutered/sentry
	name = "Frontiersman Sentry"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one waits patiently, their finger on the trigger, as the glint of their scope in the sun catches your eye."
	vision_range = 14
	engage_distance = 14
	wander = FALSE
	retreat_distance = 0
	environment_smash = 0

/mob/living/basic/human/frontier/ranged/trooper
	name = "Frontiersman Doorkicker"
	desc = "A member of the brutal Frontiersman terrorist fleet! Bedecked in military-grade armor, they swagger their shotgun about with a boldness uncommon even among other Frontiersmen."
	icon_state = "frontiersmanrangedelite"
	projectile_sound = 'sound/weapons/gun/shotgun/brimstone.ogg'
	casing_type = /obj/item/ammo_casing/shotgun/buckshot
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper
	r_hand = /obj/item/gun/ballistic/shotgun/automatic/slammer
	armor_base = /obj/item/clothing/suit/armor/vest/frontier

/mob/living/basic/human/frontier/ranged/trooper/internals
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals

/mob/living/basic/human/frontier/ranged/trooper/spitter
	name = "Frontiersman Runner"
	desc = "A quick-footed member of the brutal Frontiersman terrorist fleet! This one wields a boxy submachine gun in one hand."
	burst_shots = 8
	burst_interval = 1
	retreat_distance = 4
	engage_distance = 4
	projectile_sound = 'sound/weapons/gun/smg/spitter.ogg'
	casing_type = /obj/item/ammo_casing/c9mm
	r_hand = /obj/item/gun/ballistic/automatic/pistol/spitter

/mob/living/basic/human/frontier/ranged/trooper/spitter/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/spitter/internals
	icon_state = "frontiersmanrangedelite_mask"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0

/mob/living/basic/human/frontier/ranged/trooper/spitter/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/space
	in_hardsuit = TRUE
	icon_state = "frontiersmanrangedelite_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	icon_state = "frontiersmenrangedelite_space"
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/basic/human/frontier/ranged/trooper/space/spitter
	name = "Frontiersman Runner"
	desc = "A quick-footed member of the brutal Frontiersmen terrorist fleet! This one clutches a boxy submachine gun with the bulky gauntlets of their grey hardsuit."
	burst_shots = 8
	burst_interval = 1
	retreat_distance = 4
	engage_distance = 4
	projectile_sound = 'sound/weapons/gun/smg/spitter.ogg'
	casing_type = /obj/item/ammo_casing/c9mm
	r_hand = /obj/item/gun/ballistic/automatic/pistol/spitter

/mob/living/basic/human/frontier/ranged/trooper/space/spitter/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/f3
	name = "Frontiersman Marksman"
	desc = "A member of the brutal Frontiersman terrorist fleet! Bedecked in military-grade armor, they steadily hold their aging DMR in your direction."
	icon_state = "frontiersmanrangedmosin"
	projectile_sound = 'sound/weapons/gun/rifle/f4.ogg'
	burst_shots = 2
	burst_interval = 5
	casing_type = /obj/item/ammo_casing/a308
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper
	r_hand = /obj/item/gun/ballistic/automatic/marksman/f4/indie
	armor_base = /obj/item/clothing/suit/armor/vest/frontier

/mob/living/basic/human/frontier/ranged/trooper/f3/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/f3/internals
	icon_state = "frontiersmanrangedmosin_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals

/mob/living/basic/human/frontier/ranged/trooper/f3/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/f3/sentry
	vision_range = 14
	engage_distance = 14
	wander = FALSE
	retreat_distance = 0
	environment_smash = 0

/mob/living/basic/human/frontier/ranged/trooper/f3/sentry/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/f3/sentry/internals
	icon_state = "frontiersmanrangedmosin_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals

/mob/living/basic/human/frontier/ranged/trooper/f3/sentry/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/wasp
	name = "Frontiersman Stinger"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one is well protected with their laser SMG, ready to scorch anyone who stands in their way."
	icon_state = "frontiersmanrangedak47"
	retreat_distance = 2
	engage_distance = 1
	projectile_sound = 'sound/weapons/laser4.ogg'
	burst_shots = 3
	spread = 12
	casing_type = null
	projectile_type = /obj/projectile/beam/laser/eoehoma/wasp
	burst_interval = 0.1 SECONDS
	r_hand = /obj/item/gun/energy/laser/wasp

/mob/living/basic/human/frontier/ranged/wasp/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/wasp/internals
	icon_state = "frontiersmanrangedak47_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals

/mob/living/basic/human/frontier/ranged/trooper/wasp/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/flame
	fires_flames = TRUE
	name = "Frontiersman Scorcher"
	desc = "An ashen revenant wades through a sea of flames, mummified under twenty pounds of blackened asbestos fabric. Mirrored lenses glare inscrutably as they swing their instrument of destruction towards you. You should probably run."
	icon_state = "frontiersmanflametrooper"
	icon_living = "frontiersmanflametrooper"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/flame
	r_hand = /obj/item/flamethrower
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000

	engage_distance = 1
	retreat_distance = null
	projectile_type = null
	projectile_sound = 'sound/weapons/gun/flamethrower/flamethrower1.ogg'
	casing_type = null
	armor_base = /obj/item/clothing/suit/armor/frontier/fireproof

/mob/living/basic/human/frontier/ranged/trooper/flame/neuter
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/skm
	name = "Frontiersman Gunner"
	desc = "A member of the brutal Frontiersman terrorist fleet! This one could almost be mistaken for a real soldier by their assault rifle and armor, if it weren't for their swaggering demeanor."
	icon_state = "frontiersmanrangedak47"
	projectile_sound = 'sound/weapons/gun/rifle/skm.ogg'
	burst_shots = 4
	burst_interval = 3
	casing_type = /obj/item/ammo_casing/a762_40
	armor_base = /obj/item/clothing/suit/armor/vest/frontier
	r_hand = /obj/item/gun/ballistic/automatic/assault/skm

/mob/living/basic/human/frontier/ranged/trooper/skm/space
	in_hardsuit = TRUE
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	icon_state = "frontiersmanrangedak47_space"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

/mob/living/basic/human/frontier/ranged/trooper/skm/internals
	icon_state = "frontiersmanrangedak47_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals
	r_hand = /obj/item/gun/ballistic/automatic/assault/skm

/mob/living/basic/human/frontier/ranged/trooper/skm/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/skm/neutured
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/rifle
	name = "Frontiersman Crackshot"
	desc = "A member of the brutal Frontiersman terrorist fleet! Compared to their allies, they stand a little straighter, laugh a little colder. Their long rifle has a regular series of scratches on the receiver."
	icon_state = "frontiersmanrangedmosin"
	casing_type = /obj/item/ammo_casing/a8_50r
	projectile_sound = 'sound/weapons/gun/rifle/mosin.ogg'
	armor_base = /obj/item/clothing/suit/armor/vest/frontier
	r_hand = /obj/item/gun/ballistic/rifle/illestren

/mob/living/basic/human/frontier/ranged/trooper/rifle/internals
	icon_state = "frontiersmanrangedmosin_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/internals

/mob/living/basic/human/frontier/ranged/trooper/rifle/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/rifle/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/heavy
	name = "Frontiersman Sweeper"
	desc = "A horrifically still mass of plasteel and flesh. Its motions are filled with a deliberate and exacting malice. Its weapon is raised, and it prepares to pull the trigger."
	icon_state = "frontiersmanrangedminigun"
	projectile_sound = 'sound/weapons/gun/hmg/shredder.ogg'
	burst_shots = 5
	burst_interval = 2
	casing_type = /obj/item/ammo_casing/shotgun
	r_hand = /obj/item/gun/ballistic/automatic/hmg/shredder
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy
	armor_base = /obj/item/clothing/suit/armor/vest/marine/frontier

/mob/living/basic/human/frontier/ranged/trooper/heavy/space
	icon_state = "frontiersmanranged_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	icon_state = "frontiersmanrangedminigun_space"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/space

/mob/living/basic/human/frontier/ranged/trooper/heavy/internals
	icon_state = "frontiersmanrangedminigun_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy/internals

/mob/living/basic/human/frontier/ranged/trooper/heavy/internals/buckshot
	casing_type = /obj/item/ammo_casing/shotgun/buckshot

/mob/living/basic/human/frontier/ranged/trooper/heavy/internals/buckshot/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/heavy/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/heavy/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/heavy/space/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/trooper/heavy/buckshot
	casing_type = /obj/item/ammo_casing/shotgun/buckshot

/mob/living/basic/human/frontier/ranged/trooper/heavy/buckshot/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/officer
	name = "Frontiersman Boss"
	desc = "This Frontiersman moves with what could almost pass for discipline among the infamously ragtag terrorists. They leer at their underlings, one hand resting consciously over the machine pistol at their hip."
	icon_state = "frontiersmanofficer"
	burst_shots = 6
	burst_interval = 1
	projectile_sound = 'sound/weapons/gun/pistol/mauler.ogg'
	casing_type = /obj/item/ammo_casing/c9mm
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/officer
	r_hand = /obj/item/gun/ballistic/automatic/pistol/mauler
	armor_base = /obj/item/clothing/suit/armor/frontier

/mob/living/basic/human/frontier/ranged/officer/neutured
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/officer/cm15
	name = "Frontiersman Boss"
	desc = "This Frontiersman moves with what could almost pass for discipline among the infamously ragtag terrorists. They leer at their underlings, a chrome combat shotgun within their hands."
	burst_shots = 2
	burst_interval = 7
	retreat_distance = 4
	engage_distance = 3
	casing_type = /obj/item/ammo_casing/shotgun/buckshot
	projectile_sound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	r_hand = /obj/item/gun/ballistic/shotgun/automatic/cm15
	weapon_drop_chance = 100

/mob/living/basic/human/frontier/ranged/officer/f4
	name = "Frontiersman Shot-Caller"
	desc = "This Frontiersman moves with what could almost pass for discipline among the infamously ragtag terrorists. Their eyes pan across the horizon, chrome marksman rifle leant on one shoulder."
	burst_shots = 3
	burst_interval = 8
	casing_type = /obj/item/ammo_casing/a762_40
	projectile_sound = 'sound/weapons/gun/rifle/f4.ogg'
	r_hand = /obj/item/gun/ballistic/automatic/marksman/f4
	weapon_drop_chance = 100
	vision_range = 16
	engage_distance = 16
	wander = FALSE
	retreat_distance = 0
	environment_smash = 0

/mob/living/basic/human/frontier/ranged/officer/rifle
	name = "Frontiersman Commander"
	desc = "This Frontiersman sways through the world with a deliberate cadence. Their eyes stay up as they search for a target, rubbing at the bolt of their rifle."
	casing_type = /obj/item/ammo_casing/a8_50r/match
	projectile_sound = 'sound/weapons/gun/rifle/mosin.ogg'
	r_hand = /obj/item/gun/ballistic/rifle/illestren
	burst_shots = 2
	burst_interval = 10

/mob/living/basic/human/frontier/ranged/officer/rifle/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/officer/internals
	icon_state = "frontiersmanofficer_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/officer/internals

/mob/living/basic/human/frontier/ranged/officer/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/officer/rifle/internals
	icon_state = "frontiersmanofficer_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/officer/internals

/mob/living/basic/human/frontier/ranged/officer/rifle/internals/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/officer/wasp
	name = "Frontiersman Captain"
	desc = "This Frontiersman stands with a pride that the lesser Frontiersmen lack. They look with haughty superiority at their surroundings, right hand clutching a wasp with the surety of its use."
	retreat_distance = 2
	engage_distance = 1
	projectile_sound = 'sound/weapons/laser4.ogg'
	burst_shots = 4
	spread = 16
	casing_type = null
	projectile_type = /obj/projectile/beam/laser/eoehoma/wasp
	burst_interval = 0.1 SECONDS
	r_hand = /obj/item/gun/energy/laser/wasp

/mob/living/basic/human/frontier/ranged/officer/wasp/neutered
	weapon_drop_chance = 0

/mob/living/basic/human/frontier/ranged/officer/wasp/internals
	icon_state = "frontiersmanofficer_mask"
	habitable_atmos = IMMUNE_ATMOS_REQS
	minimum_survivable_temperature = 0
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ranged/officer/internals

/mob/living/basic/human/frontier/ranged/officer/wasp/internals/neutered
	weapon_drop_chance = 0

/**
 * What the New Frontiersmen say in a fight. A patchwork of pirate crews, desperate salvagers and hardened soldiers out of the Shoal.
 * Loyal to their own crew rather than to the Frontiersmen, and ruthless as a means to an end, plunder or payback, rather than for the fun of it.
 * Only the true believers and the "poor suckers" go on about keeping the frontier free, so those lines are the rare ones
 */
/datum/ai_callout_set/human/frontier
	lines = list(
		AI_CALLOUT_SPOTTED = list("We got company!", "Hostiles! Get 'em!", "Somebody's poking around!"),
		AI_CALLOUT_TAKING_FIRE = list("Taking fire!", "Where's that coming from?!"),
		AI_CALLOUT_HURT = list("Argh!", "I'm hit!"),
		AI_CALLOUT_TARGET_DOWN = list("Got one!", "They're down!"),
		AI_CALLOUT_TARGET_KILLED = list("Scratch one.", "Check 'em for anything good later.", "Shouldn't have got in the way."),
		AI_CALLOUT_ALLY_DOWN = list("They got one of ours!", "Crew down!", "They'll pay for that!"),
		AI_CALLOUT_LOST_THEM = list("Where'd they go?", "Lost 'em!"),
		AI_CALLOUT_FLANKING = list("I'll get behind 'em!", "Going around!"),
		AI_CALLOUT_HOLDING = list("Hold here!", "Dig in!"),
		AI_CALLOUT_SUPPRESSING = list("Keep 'em pinned!", "Keep their heads down!"),
		AI_CALLOUT_DEATH_RATTLE = list("Tell the crew... I..." = 3, "Wasn't... worth the cut..." = 3, "Should've... stayed a salvager..." = 3, "Free... Frontier..." = 1),
		AI_CALLOUT_RELOADING = list("Reloading!", "Cover me!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots fired! Go check it!", "You hear that? Someone's here."),
		AI_CALLOUT_PUSHING = list("Rush 'em!", "Move up!"),
		AI_CALLOUT_FALLING_BACK = list("Fall back!", "Back up, back up!"),
		AI_CALLOUT_WARY = list("Careful, they got teeth!", "Keep your head down, nobody else is dying today!"),
		AI_CALLOUT_EMBOLDENED = list("They're running! After 'em!", "We got 'em now!"),
		AI_CALLOUT_TAUNT = list("Wrong place, wrong time!" = 3, "Nothing personal, you're just in the way!" = 3, "Nowhere to run!" = 3, "Keep the Frontier free!" = 1),
		AI_CALLOUT_MELEE = list("Should've run!", "Down you go!", "That's for the crew!"),
		AI_CALLOUT_BROKEN = list("Pull back! Grab the wounded!", "We can't hold 'em! Get the crew out!", "Fall back, nobody gets left behind!"),
		AI_CALLOUT_RALLIED = list("Alright, crew, form up!", "Everyone here? Good. Let's go again."),
	)
	morale_lines = list(
		AI_MORALE_BROKEN = list(
			AI_CALLOUT_HURT = list("I'm hit! Don't leave me!", "Somebody drag me out!"),
			AI_CALLOUT_RELOADING = list("I'm out! Somebody cover me!"),
			AI_CALLOUT_ALLY_DOWN = list("We're losing people! Go, go!", "Get 'em out of there, we're leaving!"),
		),
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("Who's next?!", "Should've stayed home!"),
		),
	)
