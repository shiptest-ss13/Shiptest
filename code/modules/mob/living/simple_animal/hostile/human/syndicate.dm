///////////////Base mob////////////
/obj/effect/light_emitter/red_energy_sword //used so there's a combination of both their head light and light coming off the energy sword
	set_luminosity = 2
	set_cap = 2.5
	light_color = COLOR_SOFT_RED


/mob/living/simple_animal/hostile/human/ramzi
	name = "Ramzi Clique Initiate"
	desc = "A deserter from the Gorlex Marauders turned pirate. Unfortunately for them, this one is unarmed."
	icon_state = "syndicate"
	icon_living = "syndicate"
	speak_chance = 0
	stat_attack = HARD_CRIT
	atmos_requirements = IMMUNE_ATMOS_REQS
	maxbodytemp = 400
	unsuitable_atmos_damage = 15
	faction = list(FACTION_RAMZI)
	loot = null
	check_friendly_fire = TRUE
	dodging = TRUE
	rapid_melee = 2
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi

	armor_base = /obj/item/clothing/suit/armor/vest/syndie

/mob/living/simple_animal/hostile/human/ramzi/space
	name = "Ramzi Clique Initiate"
	desc = "A deserter from the Gorlex Marauders turned pirate. Despite their armored hardsuit, this one is unarmed."
	icon_state = "syndicate_space"
	icon_living = "syndicate_space"
	minbodytemp = 0
	maxbodytemp = 1000
	speed = 1

	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space

	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi

/mob/living/simple_animal/hostile/human/ramzi/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/ramzi/space/soft
	name = "Ramzi Clique Initiate"
	desc = "A deserter from the Gorlex Marauders turned pirate wearing an armored softsuit. This one is unarmed."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space/soft
	armor_base = /obj/item/clothing/suit/space/syndicate/ramzi

/mob/living/simple_animal/hostile/human/ramzi/space/stormtrooper
	name = "Ramzi Clique Battlemaster"
	desc = "A silhouette of obsidian glass stalks into view, empty hands clutching into armored fists. They are unarmed, and this is nearly a fair fight."
	icon_state = "syndicate_stormtrooper"
	icon_living = "syndicate_stormtrooper"
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper

///////////////Melee////////////

/mob/living/simple_animal/hostile/human/ramzi/melee //dude with a knife and no shields
	name = "Ramzi Clique Close Combatant"
	desc = "A deserter from the Gorlex Marauders turned pirate. They hold a clean and razor-sharp knife with obvious training."
	icon_state = "syndicate_knife"
	icon_living = "syndicate_knife"
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	status_flags = 0

	l_hand =/obj/item/melee/knife/combat
	sharpness = SHARP_POINTY

	melee_damage_lower = 20
	melee_damage_upper = 20

	var/projectile_deflect_chance = 0

/mob/living/simple_animal/hostile/human/ramzi/melee/bullet_act(obj/projectile/Proj)
	if(prob(projectile_deflect_chance))
		visible_message(span_danger("[src] blocks [Proj] with its shield!"))
		return BULLET_ACT_BLOCK
	return ..()

/mob/living/simple_animal/hostile/human/ramzi/melee/machete
	name = "Ramzi Clique Pioneer"
	desc = "A deserter from the Gorlex Marauders turned pirate. They hold a long blade, flicking it in their wrist as a challenge to the world."
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"

	l_hand = /obj/item/melee/sword/mass
	sharpness = SHARP_EDGED

	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/simple_animal/hostile/human/ramzi/melee/sledge
	name = "Ramzi Clique Breaker"
	desc = "A deserter from the Gorlex Marauders turned pirate. Their palms are twisted around the shaft of a crimson-black sledgehammer."

	icon_state = "syndicate_sword"
	icon_living = "syndicate_sword"
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	attack_sound = 'sound/weapons/blade1.ogg'

	l_hand = /obj/item/melee/sledgehammer/gorlex
	sharpness = SHARP_NONE
	armour_penetration = 40
	melee_damage_lower = 30
	melee_damage_upper = 30

	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/weapons/genhit1.ogg'

	light_color = COLOR_SOFT_RED
	var/obj/effect/light_emitter/red_energy_sword/sord
	projectile_deflect_chance = 25

/mob/living/simple_animal/hostile/human/ramzi/melee/sledge/AttackingTarget()
	. = ..()
	if(isliving(target))
		var/mob/living/bonk = target
		if(!bonk.anchored)
			var/atom/throw_target = get_edge_target_turf(bonk, src.dir)
			bonk.throw_at(throw_target, rand(1,2), 2, src, gentle = TRUE)

/* Space Melee */

/mob/living/simple_animal/hostile/human/ramzi/melee/space
	name = "Ramzi Clique Infiltrator"
	desc = "A deserter from the Gorlex Marauders turned pirate. Rusted hardsuit gauntlets hold a shard of polished steel in an veteran's guard."
	icon_state = "syndicate_space_knife"
	icon_living = "syndicate_space_knife"
	minbodytemp = 0
	maxbodytemp = 1000
	speed = 1
	projectile_deflect_chance = 0

	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi

	l_hand =/obj/item/melee/knife/combat
	sharpness = SHARP_POINTY

	melee_damage_lower = 20
	melee_damage_upper = 20

/mob/living/simple_animal/hostile/human/ramzi/melee/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/ramzi/melee/space/machete
	name = "Ramzi Clique Bladesman"
	desc = "A deserter from the Gorlex Marauders turned pirate. Rust silhouttes a well-maintained machete, swinging around their hip."
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	l_hand =/obj/item/melee/sword/mass
	sharpness = SHARP_EDGED
	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/simple_animal/hostile/human/ramzi/melee/space/soft
	name = "Ramzi Clique Infiltrator"
	desc = "A deserter from the Gorlex Marauders turned pirate. A softsuit's gauntlets hold a shard of polished steel in an veteran's guard."
	l_hand = /obj/item/melee/knife/combat
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space/soft
	armor_base = /obj/item/clothing/suit/space/syndicate/ramzi

/mob/living/simple_animal/hostile/human/ramzi/melee/space/soft/machete
	name = "Ramzi Clique Bladesman"
	desc = "A deserter from the Gorlex Marauders turned pirate. Rust silhouttes a well-maintained machete, swinging around their hip."
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	l_hand = /obj/item/melee/sword/mass
	sharpness = SHARP_EDGED
	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/simple_animal/hostile/human/ramzi/melee/space/sledge
	name = "Ramzi Clique Hullsmasher"
	desc = "A deserter from the Gorlex Marauders turned pirate. Their decayed hardsuit still obeys as they raise their sledgehammer in challenge."
	icon_state = "syndicate_space_sword"
	icon_living = "syndicate_space_sword"
	armour_penetration = 40
	melee_damage_lower = 30
	melee_damage_upper = 30
	sharpness = SHARP_NONE

	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/weapons/genhit1.ogg'

	l_hand =/obj/item/melee/sledgehammer/gorlex
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi

/mob/living/simple_animal/hostile/human/ramzi/melee/space/sledge/AttackingTarget()
	. = ..()
	if(isliving(target))
		var/mob/living/bonk = target
		if(!bonk.anchored)
			var/atom/throw_target = get_edge_target_turf(bonk, src.dir)
			bonk.throw_at(throw_target, rand(1,2), 2, src, gentle = FALSE)

/* stormtroopers */

/mob/living/simple_animal/hostile/human/ramzi/melee/space/stormtrooper
	name = "Ramzi Clique Assassin"
	desc = "Wicked knifepoint tracks your every impulse. Clean, black-red armor plate glides across itself, bereft of all sound or resistance."
	icon_state = "syndicate_stormtrooper_knife"
	icon_living = "syndicate_stormtrooper_knife"
	name = "Ramzi Clique Stormtrooper"
	maxHealth = 250
	health = 250
	projectile_deflect_chance = 0
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper


/mob/living/simple_animal/hostile/human/ramzi/melee/space/stormtrooper/sledge
	name = "Ramzi Clique Supercollider"
	desc = "Rapid, practiced motions permeate the body underneath the crimson suit of this radiantly hateful being. Each one ripples to the surface, the eyes of a suit tracking you as it brings a sledgehammer to bear."
	icon_state = "syndicate_stormtrooper_sword"
	icon_living = "syndicate_stormtrooper_sword"
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	l_hand = /obj/item/melee/sledgehammer/gorlex
	sharpness = SHARP_NONE
	armour_penetration = 40
	melee_damage_lower = 30
	melee_damage_upper = 30
	rapid_melee = 2
	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/weapons/genhit1.ogg'

/mob/living/simple_animal/hostile/human/ramzi/melee/space/stormtrooper/sledge/AttackingTarget()
	. = ..()
	if(isliving(target))
		var/mob/living/bonk = target
		if(!bonk.anchored)
			var/atom/throw_target = get_edge_target_turf(bonk, src.dir)
			bonk.throw_at(throw_target, rand(1,3), 2, src, gentle = FALSE)

///////////////Guns////////////

/mob/living/simple_animal/hostile/human/ramzi/ranged
	name = "Ramzi Clique Operative"
	desc = "A deserter from the Gorlex Marauders turned pirate. They warily glance around, a compact sidearm held at the ready."
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	icon_state = "syndicate_pistol"
	icon_living = "syndicate_pistol"
	casingtype = /obj/item/ammo_casing/c10mm
	projectilesound = 'sound/weapons/gun/pistol/shot.ogg'
	rapid_melee = 1
	l_hand =/obj/item/gun/ballistic/automatic/pistol/ringneck

/mob/living/simple_animal/hostile/human/ramzi/ranged/smg
	name = "Ramzi Clique Commando"
	desc = "A deserter from the Gorlex Marauders turned pirate. They scan the room with their submachinegun held at eye level, sweeping every corner."
	rapid = 3
	icon_state = "syndicate_smg"
	icon_living = "syndicate_smg"
	casingtype = /obj/item/ammo_casing/c45
	projectilesound = 'sound/weapons/gun/smg/cobra.ogg'
	l_hand =/obj/item/gun/ballistic/automatic/smg/cobra

/mob/living/simple_animal/hostile/human/ramzi/ranged/shotgun
	name = "Ramzi Clique Breacher"
	desc = "A deserter from the Gorlex Marauders turned pirate. They move low and quickly, heavy combat shotgun at the ready."
	rapid = 2
	rapid_fire_delay = 6
	retreat_distance = 4
	minimum_distance = 3
	icon_state = "syndicate_shotgun"
	icon_living = "syndicate_shotgun"
	casingtype = /obj/item/ammo_casing/shotgun/buckshot //buckshot fired in a two-round burst. This will two-tap unarmored players.
	projectilesound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	l_hand =/obj/item/gun/ballistic/shotgun/automatic/bulldog
	shoot_point_blank = TRUE

/mob/living/simple_animal/hostile/human/ramzi/ranged/shotgun/incendiary
	name = "Ramzi Clique Firestarter"
	desc = "A deserter from the Gorlex Marauders turned pirate. Their finger twitches around the trigger of their combat shotgun."
	casingtype = /obj/item/ammo_casing/shotgun/incendiary
	rapid = 1

/mob/living/simple_animal/hostile/human/ramzi/ranged/sniper
	name = "Ramzi Clique Overwatch"
	desc = "A deserter from the Gorlex Marauders turned pirate. They turn their eyes to the horizon, always ready to pull the trigger."
	minimum_distance = 7
	vision_range = 12
	aggro_vision_range = 14
	icon_state = "syndicate_shotgun"
	icon_living = "syndicate_shotgun"
	casingtype = /obj/item/ammo_casing/a65clip
	projectilesound = 'sound/weapons/gun/sniper/cmf90.ogg'
	l_hand = /obj/item/gun/ballistic/automatic/marksman/boomslang

/* Space Ranged */

/mob/living/simple_animal/hostile/human/ramzi/ranged/space
	name = "Ramzi Clique Operative"
	desc = "A deserter from the Gorlex Marauders turned pirate. Rusty gauntlets clutches a modified machinepistol, scanning for threats."
	icon_state = "syndicate_space_pistol"
	icon_living = "syndicate_space_pistol"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1000
	speed = 1
	rapid = 2
	projectilesound = 'sound/weapons/gun/pistol/asp.ogg'
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space
	l_hand = /obj/item/gun/ballistic/automatic/pistol/rattlesnake/cottonmouth

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/soft
	name = "Ramzi Clique Operative"
	desc = "A deserter from the Gorlex Marauders turned pirate, wearing an armored softsuit. They clutch a pocket pistol, the added bulk of their wrappings giving it a rather undersized appearance."
	icon_state = "syndicate_space_pistol"
	icon_living = "syndicate_space_pistol"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1000
	speed = 1
	projectilesound = 'sound/weapons/gun/pistol/shot.ogg'
	rapid = 1
	l_hand = /obj/item/gun/ballistic/automatic/pistol/ringneck
	armor_base = /obj/item/clothing/suit/space/syndicate/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space/soft

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/soft/smg
	name = "Ramzi Clique Commando"
	desc = "A deserter from the Gorlex Marauders turned pirate. A painted skull grimaces on their helmet as they sweep their submachinegun across the room, scanning for threats."
	icon_state = "syndicate_space_smg"
	icon_living = "syndicate_space_smg"
	l_hand = /obj/item/gun/ballistic/automatic/smg/cobra
	projectilesound = 'sound/weapons/gun/smg/cobra.ogg'
	rapid = 3
	casingtype = /obj/item/ammo_casing/c45

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/smg
	name = "Ramzi Clique Commando"
	desc = "A deserter from the Gorlex Marauders turned pirate. Green hardsuit optics glint as they sweep their submachinegun across the room, scanning for threats."
	icon_state = "syndicate_space_smg"
	icon_living = "syndicate_space_smg"
	l_hand = /obj/item/gun/ballistic/automatic/smg/cobra
	projectilesound = 'sound/weapons/gun/smg/cobra.ogg'
	rapid = 3
	casingtype = /obj/item/ammo_casing/c45

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/shotgun
	name = "Ramzi Clique Breacher"
	desc = "A deserter from the Gorlex Marauders turned pirate. The unmistakeable bulk of a Bulldog shotgun graces the wrapped, patched hands of their aging hardsuit."
	icon_state = "syndicate_space_shotgun"
	icon_living = "syndicate_space_shotgun"
	name = "Ramzi Clique Commando"
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	l_hand = /obj/item/gun/ballistic/shotgun/automatic/bulldog
	projectilesound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	rapid = 2
	rapid_fire_delay = 6
	retreat_distance = 2
	minimum_distance = 2
	shoot_point_blank = TRUE

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/sniper
	name = "Ramzi Clique Deadeye"
	desc = "A deserter from the Gorlex Marauders turned pirate. The cold expressionless helmet betrays nothing but contempt as they await their next target."
	minimum_distance = 7
	vision_range = 12
	aggro_vision_range = 14
	icon_state = "syndicate_space_shotgun"
	icon_living = "syndicate__space_shotgun"
	casingtype = /obj/item/ammo_casing/a65clip
	l_hand = /obj/item/gun/ballistic/automatic/marksman/boomslang
	projectilesound = 'sound/weapons/gun/sniper/cmf90.ogg'

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/shotgun/incendiary
	name = "Ramzi Clique Boiler"
	desc = "A deserter from the Gorlex Marauders turned pirate. The hateful eyes of a hardsuit stare down the sight of a Bulldog shotgun, elegance in its movements."
	rapid = 1
	casingtype = /obj/item/ammo_casing/shotgun/incendiary

/* ranged stormtroopers */

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/stormtrooper
	name = "Ramzi Clique Pistolmaster" //I can't think of something better, sue me
	desc = "Obsidian armor cradles a machinepistol with sculptural grace. Its snub muzzle follows you before you even think to move."
	icon_state = "syndicate_stormtrooper_pistol"
	icon_living = "syndicate_stormtrooper_pistol"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	l_hand = /obj/item/gun/ballistic/automatic/pistol/rattlesnake/cottonmouth
	projectilesound = 'sound/weapons/gun/pistol/asp.ogg'
	rapid = 2
	rapid_fire_delay = 2

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/stormtrooper/smg
	name = "Ramzi Clique Shock Trooper"
	desc = "Night-black armor traces the silhouette of a soldier equaled by precious few. Their Sidewinder tracks you perfectly, a staccato bark of 5.7 already in its throat."
	icon_state = "syndicate_stormtrooper_smg"
	icon_living = "syndicate_stormtrooper_smg"
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	l_hand = /obj/item/gun/ballistic/automatic/smg/sidewinder
	rapid = 4
	rapid_fire_delay = 1.5
	casingtype = /obj/item/ammo_casing/c57x39mm
	projectilesound = 'sound/weapons/gun/smg/sidewinder.ogg'

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/stormtrooper/shotgun
	name = "Ramzi Clique Executioner"
	desc = "Ink and black glass poured into the shape of an armored commando, dripping menace with every step. Their combat shotgun follows you with lethal intent, promising a blizzard of buckshot in less than a blink."
	icon_state = "syndicate_stormtrooper_shotgun"
	icon_living = "syndicate_stormtrooper_shotgun"
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	l_hand = /obj/item/gun/ballistic/shotgun/automatic/bulldog
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	projectilesound = 'sound/weapons/gun/shotgun/bulldog.ogg'
	rapid = 3
	rapid_fire_delay = 5
	retreat_distance = 2
	minimum_distance = 2
	shoot_point_blank = TRUE

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/stormtrooper/shotgun/incendiary
	name = "Ramzi Clique Incinerator"
	desc = "Crimson and darkness fill the mold of an armored commando, eyes rapidly switching targets as it strides. Its combat shotgun is raised, ready to let loose a roar that shall not be forgotten."
	casingtype = /obj/item/ammo_casing/shotgun/dragonsbreath
	rapid = 2
	rapid_fire_delay = 7

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/stormtrooper/sniper
	name = "Ramzi Clique Cleaner"
	desc = "Black and red, black and red, and you're dead all over. They've already seen you, and are training their next shot with practiced distaste."
	minimum_distance = 7
	vision_range = 20
	aggro_vision_range = 14
	icon_state = "syndicate_shotgun"
	icon_living = "syndicate_shotgun"
	casingtype = /obj/item/ammo_casing/p50
	l_hand = /obj/item/gun/ballistic/automatic/marksman/taipan
	projectilesound = 'sound/weapons/gun/sniper/shot.ogg'

///////////////Misc////////////

/mob/living/simple_animal/hostile/human/ramzi/civilian
	name = "Ramzi Clique Technician"
	desc = "A deserter from the Gorlex Marauders turned pirate. This one is not only unarmed, but a coward as well."
	minimum_distance = 10
	retreat_distance = 10
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/simple_animal/hostile/human/ramzi/civilian/Aggro()
	..()
	summon_backup(15)
	say("GUARDS!!")

/mob/living/simple_animal/hostile/human/ramzi/civilian/space
	name = "Ramzi Clique Technician"
	desc = "A deserter from the Gorlex Marauders turned pirate, wearing a flimsy softsuit. This one is not only unarmed, but a coward as well."
	minimum_distance = 10
	retreat_distance = 10
	obj_damage = 0
	armor_base = /obj/item/clothing/suit/space/syndicate/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space/soft/surplus
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/simple_animal/hostile/viscerator
	name = "viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations."
	icon_state = "viscerator_attack"
	icon_living = "viscerator_attack"
	pass_flags = PASSTABLE | PASSMOB
	a_intent = INTENT_HARM
	mob_biotypes = MOB_ROBOTIC
	health = 25
	maxHealth = 25
	melee_damage_lower = 15
	melee_damage_upper = 15
	wound_bonus = -10
	bare_wound_bonus = 20
	sharpness = SHARP_EDGED
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list(FACTION_RAMZI)
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1000
	mob_size = MOB_SIZE_TINY
	is_flying_animal = TRUE
	limb_destroyer = 1
	speak_emote = list("states")
	bubble_icon = "syndibot"
	del_on_death = 1
	deathmessage = "is smashed into pieces!"

/mob/living/simple_animal/hostile/viscerator/Initialize()
	. = ..()
	AddComponent(/datum/component/swarming)
