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
	faction = list(FACTION_ANTAG_HERMITS)

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
	desc = "A wild-eyed figure, wearing tattered mining equipment and boasting a malformed body, twisted by the heavy metals and high background radiation of the sandworlds."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands
	r_hand = /obj/item/melee/knife/survival
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	melee_damage_lower = 15
	melee_damage_upper = 15

/mob/living/simple_animal/hostile/human/hermit/survivor/passive
	name = "Hermit Villager"
	desc = "A panicked, wild figure, wearing tattered mining equipment and frozen in fear. They regard you with caution, shrinking away as to not be seen."
	r_hand = null
	melee_damage_lower = 5
	melee_damage_upper = 5
	faction = list(FACTION_ANTAG_HERMITS, FACTION_NEUTRAL)

/mob/living/simple_animal/hostile/human/hermit/survivor/lunatic
	name = "Hermit Lunatic"
	desc= "A wild-eyed figure clad in tattered mining equipment wielding a plastic chair. They move erratically, eyes darting about frantically."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands
	r_hand = /obj/item/chair/plastic
	attack_verb_continuous = "bashes"
	attack_verb_simple = "bashed"
	attack_sound = 'sound/items/trayhit1.ogg'
	melee_damage_lower = 5
	melee_damage_upper = 5
	speed = 15

/mob/living/simple_animal/hostile/human/hermit/survivor/lunatic/Aggro()
	..()
	summon_backup(15)
	say("HAAAAHAAAHAAAAA!!")

/mob/living/simple_animal/hostile/human/hermit/survivor/brawler
	name = "Hermit Brawler"
	desc = "A stanced figure sheltered behind a shoddy, makeshift wooden buckler. A jagged machete is held within their clutch."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands
	r_hand = /obj/item/melee/sword/mass
	l_hand = /obj/item/shield/riot/buckler
	projectile_deflect_chance = 25

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
	desc ="A wild-eyed figure. Watch out- he has a shotgun, and he remembers just enough of his old life to use it!"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands
	r_hand = /obj/item/gun/ballistic/rifle/polymer

/mob/living/simple_animal/hostile/human/hermit/ranged/hunter/sentry
	name = "Hermit Sentry"
	vision_range = 10
	aggro_vision_range = 10
	minimum_distance = 10
	stop_automated_movement = 1
	wander = 0
	retreat_distance = 0
	environment_smash = 0

/mob/living/simple_animal/hostile/human/hermit/ranged/shotgun
	name = "Hermit Pursuer"
	desc ="A wild-eyed figure wielding a makeshift shotgun. The expression through their cloudy visor is fierce, and they're poised to sprint."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands
	r_hand = /obj/item/gun/ballistic/shotgun/doublebarrel/improvised
	casingtype = /obj/item/ammo_casing/shotgun/improvised
	projectilesound = 'sound/weapons/gun/shotgun/shot.ogg'
	retreat_distance = 3
	minimum_distance = 3
	speed = 10

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
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands
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
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands
	r_hand = /obj/item/gun/energy/e_gun/e11

/mob/living/simple_animal/hostile/human/hermit/ranged/tesla_rifle
	name = "Hermit Guardsman"
	desc = "Out in the wilderness of the frontier, desperation can easily become innovation. This hermit is wielding the product of such ventures. Electrical crackles and a rifle ready to roar."
	icon_state = "survivor_gunslinger"
	icon_living = "survivor_gunslinger"
	projectilesound = 'sound/weapons/zapbang.ogg'
	rapid = 2
	rapid_fire_delay = 2
	casingtype = /obj/item/ammo_casing/c46x30mm/tesla
	r_hand = /obj/item/gun/ballistic/automatic/smg/skm_carbine
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands

//survivor corpses

/obj/effect/mob_spawn/human/corpse/damaged/whitesands
	outfit = /datum/outfit/hermit

// this shit sucks man

/obj/effect/mob_spawn/human/corpse/damaged/whitesands/Initialize() //everything here should equal out to 100 for the sake of my sanity.
	mob_species = pick_weight(list(
			/datum/species/human = 50,
			/datum/species/lizard = 20,
			/datum/species/elzuose = 10,
			/datum/species/moth = 10,
			/datum/species/spider = 10,
		)
	)

	outfit = pick_weight(list(
			/datum/outfit/hermit = 24,
			/datum/outfit/hermit/brown = 24,
			/datum/outfit/hermit/green = 24,
			/datum/outfit/hermit/yellow = 24,
			/datum/outfit/hermit/jermit = 4,
			)
	)
	//gloves are a tossup
	gloves = pick_weight(list(
			/obj/item/clothing/gloves/color/black = 60,
			/obj/item/clothing/gloves/explorer = 30,
			/obj/item/clothing/gloves/explorer/old = 10
			)
		)

	belt = pick_weight(list(
			/obj/item/storage/belt/mining = 30,
			/obj/item/storage/belt/bandolier = 30,
			/obj/item/storage/belt/military = 5,
			/obj/item/storage/belt/fannypack = 15,
			/obj/item/storage/belt/mining/alt = 15,
			/obj/item/storage/belt/mining/primitive = 5
			)
		)

	//bags are semi-random.
	back = pick_weight(list(
			/obj/item/storage/backpack = 20,
			/obj/item/storage/backpack/explorer = 20,
			/obj/item/storage/backpack/satchel = 20,
			/obj/item/storage/backpack/satchel/explorer = 20,
			/obj/item/storage/backpack/messenger = 20
			)
		)

	//as are bag contents
	backpack_contents = list()
	if(prob(70))
		backpack_contents += pick_weight(list( //these could stand to be expanded, right now they're just mildly modified miner ones, and I don't know how to plus that up.
			/obj/item/soap = 10,
			/obj/item/stack/marker_beacon/ten = 15,
			/obj/item/mining_scanner = 5,
			/obj/item/extinguisher/mini = 10,
			/obj/item/melee/knife/combat = 5,
			/obj/item/flashlight/seclite = 10,
			/obj/item/stack/sheet/sinew = 10,
			/obj/item/stack/sheet/bone = 5,
			/obj/item/stack/sheet/animalhide/goliath_hide = 10,
			/obj/item/stack/sheet/bone = 8,
			/obj/item/reagent_containers/food/drinks/waterbottle = 10,
			/obj/item/reagent_containers/food/drinks/waterbottle/empty = 2,
			)
		)
	if(prob(70))
		backpack_contents += pick_weight(list(
			/obj/item/stack/sheet/animalhide/goliath_hide = 20,
			/obj/item/stack/marker_beacon/ten = 10,
			/obj/item/mining_scanner = 20,
			/obj/item/extinguisher/mini = 10,
			/obj/item/melee/knife/survival = 10,
			/obj/item/flashlight/seclite = 10,
			/obj/item/stack/sheet/sinew = 10,
			/obj/item/stack/sheet/bone = 10
			)
		)
	if(prob(70))
		backpack_contents += pick_weight(list(
			/obj/item/stack/sheet/animalhide/goliath_hide = 5,
			/obj/item/stack/marker_beacon/ten = 5,
			/obj/item/mining_scanner = 5,
			/obj/item/extinguisher/mini = 10,
			/obj/item/melee/knife/survival = 12,
			/obj/item/flashlight/seclite = 10,
			/obj/item/stack/sheet/sinew = 5,
			/obj/item/stack/sheet/bone = 5,
			/obj/item/melee/knife/combat = 3,
			/obj/item/storage/ration/shredded_beef = 30
			)
		)
	if (prob(15)) //mayhaps a medkit
		backpack_contents += pick_weight(list(
			/obj/item/storage/firstaid/regular = 50,
			/obj/item/storage/firstaid/brute = 15,
			/obj/item/storage/firstaid/medical = 15,
			/obj/item/storage/firstaid/fire = 10,
			/obj/item/storage/firstaid/advanced = 5,
			/obj/item/storage/firstaid/ancient = 5
			)
		)
	if(prob(30)) //some pens maybe?
		backpack_contents += /obj/item/reagent_containers/hypospray/medipen/survival
	if(prob(5))
		backpack_contents += /obj/item/reagent_containers/hypospray/medipen/combat_drug

	//masks
	mask = pick_weight(list(
		/obj/item/clothing/mask/gas = 40,
		/obj/item/clothing/mask/gas/explorer = 20,
		/obj/item/clothing/mask/gas/syndicate = 20,
		)
	)

	//the eyes are the window into the soul.
	if(prob(70))
		glasses = pick_weight(list(
			/obj/item/clothing/glasses/heat = 20,
			/obj/item/clothing/glasses/cold = 20,
			/obj/item/clothing/glasses/meson = 40,
			/obj/item/clothing/glasses = 20
			)
		)

	//and of course, ears.
	if(prob(1)) //oh my god they can't hear the sandstorm coming they've got airpods in
		ears = /obj/item/instrument/piano_synth/headphones/spacepods
	else
		ears = pick_weight(list(
			/obj/item/radio/headset = 50,
			/obj/item/radio/headset/alt = 50
			)
		)
	. = ..()

/datum/outfit/hermit
	name = "Whitesands Survivor"
	uniform = /obj/item/clothing/under/color/random
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/hooded/survivor
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/hooded/survivor_hood

/mob/living/simple_animal/hostile/human/hermit/mayor
	name = "The Mayor"
	desc = "A blood-red silhouette leveling a wicked battle rifle in your direction. Their suit is worn and damaged, yet still armored. Their stance is trained and alert, unlike many of the wanderers nearby."
	rapid = 4
	rapid_fire_delay = 3
	ranged = 1
	retreat_distance = 4
	minimum_distance = 7
	icon_state = "syndicate_hydra"
	casingtype = /obj/item/ammo_casing/a308
	l_hand = /obj/item/gun/ballistic/automatic/assault/invictus/old
	projectilesound = 'sound/weapons/gun/hmg/hmg.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/mayor
	armor_base = /obj/item/clothing/suit/space/hardsuit/syndi/old
	weapon_drop_chance = 100

/mob/living/simple_animal/hostile/human/hermit/mayor/Aggro()
	..()
	summon_backup(15)
	say("TO ME!!")

/datum/outfit/mayor
	name = "The Mayor"

	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/old
	head = /obj/item/clothing/head/helmet/space/hardsuit/syndi/old
	mask = /obj/item/clothing/mask/breath/facemask
	glasses = /obj/item/clothing/glasses/safety
	belt = /obj/item/storage/belt/security/military/frontiersmen
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	back = /obj/item/storage/backpack
	ears = /obj/item/radio/headset/alt

/obj/effect/mob_spawn/human/corpse/damaged/mayor
	name = "The Mayor"
	outfit = /datum/outfit/mayor

/datum/outfit/hermit/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_ANTAG_HERMITS)

/datum/outfit/hermit/brown
	name = "Whitesands Survivor Brown"
	suit = /obj/item/clothing/suit/hooded/survivor/brown
	head = /obj/item/clothing/head/hooded/survivor_hood/brown

/datum/outfit/hermit/yellow
	name = "Whitesands Survivor Yellow"
	suit = /obj/item/clothing/suit/hooded/survivor/yellow
	head = /obj/item/clothing/head/hooded/survivor_hood/yellow

/datum/outfit/hermit/green
	name = "Whitesands Survivor Green"
	suit = /obj/item/clothing/suit/hooded/survivor/green
	head = /obj/item/clothing/head/hooded/survivor_hood/green

/datum/outfit/hermit/jermit
	name = "Whitesands Survivor Jermit"
	suit = /obj/item/clothing/suit/hooded/survivor/jermit
	head = /obj/item/clothing/head/hooded/survivor_hood/jermit
