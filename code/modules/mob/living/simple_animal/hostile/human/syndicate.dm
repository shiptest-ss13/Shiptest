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
	faction = list(FACTION_ANTAG_SYNDICATE)
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

/mob/living/simple_animal/hostile/human/ramzi/space/stormtrooper
	name = "Ramzi Clique Battlemaster"
	desc = "A silhouette of obsidian glass stalks into view, empty hands clutching into armored fists. They are unarmed, and this is nearly a fair fight."
	icon_state = "syndicate_stormtrooper"
	icon_living = "syndicate_stormtrooper"
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi
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

	r_hand = /obj/item/melee/knife/combat

	melee_damage_lower = 20
	melee_damage_upper = 20

	var/projectile_deflect_chance = 0

/mob/living/simple_animal/hostile/human/ramzi/melee/bullet_act(obj/projectile/Proj)
	if(prob(projectile_deflect_chance))
		visible_message("<span class='danger'>[src] blocks [Proj] with its shield!</span>")
		return BULLET_ACT_BLOCK
	return ..()

/mob/living/simple_animal/hostile/human/ramzi/melee/machete
	name = "Ramzi Clique Pioneer"
	desc = "A deserter from the Gorlex Marauders turned pirate. They hold a long blade, flicking it in their wrist as a challenge to the world."
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"

	r_hand = /obj/item/melee/sword/mass

	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/simple_animal/hostile/human/ramzi/melee/sword
	name = "Ramzi Clique Duelist"
	desc = "A deserter from the Gorlex Marauders turned pirate. They hold a glaring energy sword at half-guard."

	icon_state = "syndicate_sword"
	icon_living = "syndicate_sword"
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	attack_sound = 'sound/weapons/blade1.ogg'

	r_hand = /obj/item/melee/energy/sword/active
	armour_penetration = 35
	melee_damage_lower = 30
	melee_damage_upper = 30


	light_color = COLOR_SOFT_RED
	var/obj/effect/light_emitter/red_energy_sword/sord
	projectile_deflect_chance = 25

/mob/living/simple_animal/hostile/human/ramzi/melee/sword/Initialize()
	. = ..()
	set_light(2)

/mob/living/simple_animal/hostile/human/ramzi/melee/sword/Destroy()
	QDEL_NULL(sord)
	return ..()

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

	r_hand = /obj/item/melee/knife/combat

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
	r_hand = /obj/item/melee/sword/mass
	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/simple_animal/hostile/human/ramzi/melee/space/sword
	name = "Ramzi Clique Duelist"
	desc = "A deserter from the Gorlex Marauders turned pirate. Their decayed hardsuit still obeys as they hold their energy sword in counterpoint to your approach."
	icon_state = "syndicate_space_sword"
	icon_living = "syndicate_space_sword"
	light_color = COLOR_SOFT_RED
	var/obj/effect/light_emitter/red_energy_sword/sord
	projectile_deflect_chance = 25
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi

/mob/living/simple_animal/hostile/human/ramzi/melee/space/sword/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	sord = new(src)
	set_light(4)

/mob/living/simple_animal/hostile/human/ramzi/melee/space/sword/Destroy()
	QDEL_NULL(sord)
	return ..()

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
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper

//these typepaths hurt

/mob/living/simple_animal/hostile/human/ramzi/melee/space/stormtrooper/sword
	name = "Ramzi Clique Blademaster"
	desc = "Carmine bladelight glares furiously off the contours of a sleek, black-red armored suit. Their body betrays precious little as they glide in perfect conservation of motion from one stance to the next."
	icon_state = "syndicate_stormtrooper_sword"
	icon_living = "syndicate_stormtrooper_sword"
	projectile_deflect_chance = 50
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi
	light_color = COLOR_SOFT_RED
	var/obj/effect/light_emitter/red_energy_sword/sord
	projectile_deflect_chance = 25

/mob/living/simple_animal/hostile/human/ramzi/melee/space/stormtrooper/sword/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	sord = new(src)
	set_light(4)

/mob/living/simple_animal/hostile/human/ramzi/melee/space/stormtrooper/sword/Destroy()
	QDEL_NULL(sord)
	return ..()

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
	r_hand = /obj/item/gun/ballistic/automatic/pistol/ringneck

/mob/living/simple_animal/hostile/human/ramzi/ranged/smg
	name = "Ramzi Clique Commando"
	desc = "A deserter from the Gorlex Marauders turned pirate. They scan the room with their submachinegun held at eye level, sweeping every corner."
	rapid = 3
	icon_state = "syndicate_smg"
	icon_living = "syndicate_smg"
	casingtype = /obj/item/ammo_casing/c45
	projectilesound = 'sound/weapons/gun/smg/shot.ogg'
	r_hand = /obj/item/gun/ballistic/automatic/smg/cobra

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
	r_hand = /obj/item/gun/ballistic/shotgun/automatic/bulldog
	shoot_point_blank = TRUE

/mob/living/simple_animal/hostile/human/ramzi/ranged/sniper
	name = "Ramzi Clique Overwatch"
	desc = "A deserter from the Gorlex Marauders turned pirate. They keep their eyes to the horizon, always ready to pull the trigger."
	minimum_distance = 7
	vision_range = 12
	aggro_vision_range = 12
	icon_state = "syndicate_shotgun"
	icon_living = "syndicate_shotgun"
	casingtype = /obj/item/ammo_casing/a65clip
	r_hand = /obj/item/gun/ballistic/automatic/marksman/boomslang

/* Space Ranged */

/mob/living/simple_animal/hostile/human/ramzi/ranged/space
	name = "Ramzi Clique Operative"
	desc = "A deserter from the Gorlex Marauders turned pirate. Rusty gauntlets clutch a pocket pistol, the added bulk of their wrappings giving it a rather undersized appearance."
	icon_state = "syndicate_space_pistol"
	icon_living = "syndicate_space_pistol"
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1000
	speed = 1
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/space

/mob/living/simple_animal/hostile/human/syndicate/ranged/space/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	set_light(4)

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/smg
	name = "Ramzi Clique Commando"
	desc = "A deserter from the Gorlex Marauders turned pirate. Green hardsuit optics glint as they sweep their submachinegun across the room, scanning for threats."
	icon_state = "syndicate_space_smg"
	icon_living = "syndicate_space_smg"
	rapid = 3
	casingtype = /obj/item/ammo_casing/c45


/mob/living/simple_animal/hostile/human/ramzi/ranged/space/shotgun
	name = "Ramzi Clique Breacher"
	desc = "A deserter from the Gorlex Marauders turned pirate. The unmistakeable bulk of a Bulldog shotgun graces the wrapped, patched hands of their aging hardsuit."
	icon_state = "syndicate_space_shotgun"
	icon_living = "syndicate_space_shotgun"
	name = "Ramzi Clique Commando"
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	r_hand = /obj/item/gun/ballistic/shotgun/automatic/bulldog
	rapid = 2
	rapid_fire_delay = 6
	retreat_distance = 2
	minimum_distance = 4
	shoot_point_blank = TRUE

/* ranged stormtroopers */

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/stormtrooper
	name = "Ramzi Clique Pistolmaster" //I can't think of something better, sue me
	desc = "Obsidian armor cradles a machinepistol with sculptural grace. Its snub muzzle follows you before you even think to move."
	icon_state = "syndicate_stormtrooper_pistol"
	icon_living = "syndicate_stormtrooper_pistol"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi
	r_hand = /obj/item/gun/ballistic/automatic/pistol/rattlesnake
	rapid = 3
	rapid_fire_delay = 2

/mob/living/simple_animal/hostile/human/ramzi/ranged/space/stormtrooper/smg
	name = "Ramzi Clique Shock Trooper"
	desc = "Night-black armor traces the silhouette of a soldier equaled by precious few. Their Sidewinder tracks you perfectly, a staccato bark of .45 already in its throat."
	icon_state = "syndicate_stormtrooper_smg"
	icon_living = "syndicate_stormtrooper_smg"
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi
	r_hand = /obj/item/gun/ballistic/automatic/smg/sidewinder
	rapid = 4
	rapid_fire_delay = 1.5
	casingtype = /obj/item/ammo_casing/c57x39mm


/mob/living/simple_animal/hostile/human/ramzi/ranged/space/stormtrooper/shotgun
	name = "Ramzi Clique Executioner"
	desc = "Ink and black glass poured into the shape of an armored commando, dripping menace with every step. Their combat shotgun follows you with lethal intent, promising a blizzard of buckshot in less than a blink."
	icon_state = "syndicate_stormtrooper_shotgun"
	icon_living = "syndicate_stormtrooper_shotgun"
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi
	r_hand = /obj/item/gun/ballistic/shotgun/automatic/bulldog
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	rapid = 3
	rapid_fire_delay = 5
	retreat_distance = 2
	minimum_distance = 4
	shoot_point_blank = TRUE

///////////////Misc////////////

/mob/living/simple_animal/hostile/human/syndicate/civilian
	name = "Ramzi Clique Technician"
	desc = "A deserter from the Gorlex Marauders turned pirate. This one is not only unarmed, but a coward as well."
	minimum_distance = 10
	retreat_distance = 10
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

/mob/living/simple_animal/hostile/human/syndicate/civilian/Aggro()
	..()
	summon_backup(15)
	say("GUARDS!!")


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
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list(ROLE_SYNDICATE)
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1000
	mob_size = MOB_SIZE_TINY
	movement_type = FLYING
	limb_destroyer = 1
	speak_emote = list("states")
	bubble_icon = "syndibot"
	del_on_death = 1
	deathmessage = "is smashed into pieces!"

/mob/living/simple_animal/hostile/viscerator/Initialize()
	. = ..()
	AddComponent(/datum/component/swarming)
