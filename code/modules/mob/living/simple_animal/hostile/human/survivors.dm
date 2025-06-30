/mob/living/simple_animal/hostile/human/hermit
	name = "Whitesands Inhabitant"
	desc = "If you can read this, yell at a coder!"
	icon_state = "survivor_base"
	icon_living = "survivor_base"
	atmos_requirements = list("min_oxy" = 1, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 999, "min_n2" = 0, "max_n2" = 0)
	loot = list()
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands
	footstep_type = FOOTSTEP_MOB_SHOE
	armor_base = /obj/item/clothing/suit/hooded/survivor

	speak_emote = list("breathes heavily.", "growls.", "sharply inhales.")
	emote_hear = list("murmers.","grumbles.","whimpers.")

	var/projectile_deflect_chance = 0

/mob/living/simple_animal/hostile/human/hermit/bullet_act(obj/projectile/Proj)
	if(prob(projectile_deflect_chance))
		visible_message(span_danger("[src] blocks [Proj] with its shield!"))
		return BULLET_ACT_BLOCK
	return ..()

/mob/living/simple_animal/hostile/human/hermit/survivor/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	..()


/mob/living/simple_animal/hostile/human/hermit/survivor
	name = "Hermit Wanderer"
	desc =" A wild-eyed figure, wearing tattered mining equipment and boasting a malformed body, twisted by the heavy metals and high background radiation of the sandworlds."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands/random
	r_hand = /obj/item/melee/knife/survival
	melee_damage_lower = 15
	melee_damage_upper = 15

/mob/living/simple_animal/hostile/human/hermit/survivor/chair
	name = "Hermit Lunatic"
	desc = "WIP"
	r_hand = /obj/item/chair/plastic
	melee_damage_lower = 7
	melee_damage_upper = 7

/mob/living/simple_animal/hostile/human/hermit/survivor/swordboard
	name = "Hermit Brawler"
	desc = "WIP"
	r_hand = /obj/item/melee/sword/mass
	l_hand = /obj/item/shield/riot/buckler
	projectile_deflect_chance = 15
	melee_damage_lower = 25
	melee_damage_upper = 25

/mob/living/simple_animal/hostile/human/hermit/ranged
	icon_state = "survivor_hunter"
	icon_living = "survivor_hunter"
	projectiletype = null
	casingtype = /obj/item/ammo_casing/a762_40
	projectilesound = 'sound/weapons/gun/rifle/shot.ogg'
	ranged = 1
	rapid_fire_delay = 6
	retreat_distance = 5
	minimum_distance = 5

/mob/living/simple_animal/hostile/human/hermit/ranged/hunter
	name = "Hermit Hunter"
	desc ="A wild-eyed figure. Watch out- he has a gun, and he remembers just enough of his old life to use it!"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands/random
	r_hand = /obj/item/gun/ballistic/rifle/polymer

/mob/living/simple_animal/hostile/human/hermit/ranged/shotgun
	name = "Hermit Pursuer"
	desc = "WIP"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands/random
	r_hand = /obj/item/gun/ballistic/shotgun/doublebarrel/improvised
	casingtype = /obj/item/ammo_casing/shotgun/improvised
	speed = 10
	retreat_distance = 3
	minimum_distance = 1
	shoot_point_blank = TRUE

/mob/living/simple_animal/hostile/human/hermit/ranged/gunslinger
	name = "Hermit Soldier"
	desc = "The miner's rebellion, though mostly underground, recieved a few good weapon shipments from an off-sector source. You should probably start running."
	icon_state = "survivor_gunslinger"
	icon_living = "survivor_gunslinger"
	projectilesound = 'sound/weapons/gun/smg/shot.ogg'
	speed = 10
	rapid = 3
	rapid_fire_delay = 3
	casingtype = /obj/item/ammo_casing/c46x30mm/recycled
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands/random
	r_hand = /obj/item/gun/ballistic/automatic/smg/skm_carbine

/mob/living/simple_animal/hostile/human/hermit/ranged/e11
	name = "Hermit Trooper"
	desc = "Quality weapons are hard to get by in the sandworlds, which forces many survivors to improvise with that they have. This one is hoping that an E-11 of all things will save their life."
	icon_state = "survivor_e11"
	icon_living = "survivor_e11"
	projectilesound = 'sound/weapons/gun/laser/e-fire.ogg'
	speed = 10
	rapid_fire_delay = 1
	casingtype = null
	projectiletype = /obj/projectile/beam/laser/eoehoma/hermit
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands/random
	r_hand = /obj/item/gun/energy/e_gun/e11

//survivor corpses

/obj/effect/mob_spawn/human/corpse/damaged/whitesands
	uniform = /obj/item/clothing/under/color/random
	belt = /obj/item/storage/belt/fannypack
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/hooded/survivor
	l_pocket = /obj/item/radio
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi

/obj/effect/mob_spawn/human/corpse/damaged/whitesands/random
	outfit = null

/obj/effect/mob_spawn/human/corpse/damaged/whitesands/random/Initialize()
	. = ..()
	if(prob(75))
		outfit = pick_weight(list(
			/datum/outfit/hermit = 24,
			/datum/outfit/hermit/brown = 24,
			/datum/outfit/hermit/yellow = 24,
			/datum/outfit/hermit/green = 24,
			/datum/outfit/hermit/jermit = 4,
			)
		)
	if(prob(25))
		suit = pick_weight(list(
			/obj/item/clothing/suit/hooded/explorer = 18,
			/obj/item/clothing/suit/hooded/cloak/goliath = 1
			)
		)
	if(prob(75))
		back = /obj/item/storage/backpack/explorer

/datum/outfit/hermit
	name = "Whitesands Survivor"
	uniform = /obj/item/clothing/under/color/random
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/hooded/survivor
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	gloves = /obj/item/clothing/gloves/color/black //randomize a bit
	head = /obj/item/clothing/head/hooded/survivor_hood

/datum/outfit/hermit/brown
	suit = /obj/item/clothing/suit/hooded/survivor/brown
	head = /obj/item/clothing/head/hooded/survivor_hood/brown

/datum/outfit/hermit/yellow
	suit = /obj/item/clothing/suit/hooded/survivor/yellow
	head = /obj/item/clothing/head/hooded/survivor_hood/yellow

/datum/outfit/hermit/green
	suit = /obj/item/clothing/suit/hooded/survivor/green
	head = /obj/item/clothing/head/hooded/survivor_hood/green

/datum/outfit/hermit/jermit
	suit = /obj/item/clothing/suit/hooded/survivor/jermit
	head = /obj/item/clothing/head/hooded/survivor_hood/jermit

//hold overs for any admin who may want to spawn their own survivor realmobs

/datum/outfit/whitesands
	name = "Whitesands Survivor"
	uniform = /obj/item/clothing/under/color/random
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/hooded/survivor
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	gloves = /obj/item/clothing/gloves/color/black //randomize a bit
