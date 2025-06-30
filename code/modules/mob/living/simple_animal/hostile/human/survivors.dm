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
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands/survivor
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
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands/hunter
	r_hand = /obj/item/gun/ballistic/rifle/polymer

/mob/living/simple_animal/hostile/human/hermit/ranged/shotgun
	name = "Hermit Pursuer"
	desc = "WIP"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands/shotgun
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
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands/gunslinger
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
	mob_spawner = /obj/effect/mob_spawn/human/corpse/damaged/whitesands/e11
	r_hand = /obj/item/gun/energy/e_gun/e11

//survivor corpses

/obj/effect/mob_spawn/human/corpse/damaged/whitesands
	uniform = /obj/item/clothing/under/color/random
	belt = /obj/item/storage/belt/fannypack
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/hooded/survivor
	l_pocket = /obj/item/radio
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	var/survivor_type //room for alternatives inside the fuckoff grade init.

/datum/outfit/job/hermit/random
	name = "Hermit Random"

	head = null
	mask = null
	suit = null
	suit_store = null
	back = null
	belt = null
	gloves = null

	l_pocket = null
	r_pocket = /obj/item/radio

	backpack_contents = list()

	box = null
	backpack = null
	courierbag = null
	satchel = null
	duffelbag = null

/datum/outfit/job/hermit/random/pre_equip(mob/living/carbon/human/H, visualsOnly, client/preference_source)
	. = ..()
	if(visualsOnly)
		return

	if(prob(90))
		head = pick_weight(list(
		/obj/item/clothing/head/beret/sec/frontier = 10,
		/obj/item/clothing/head/helmet/bulletproof/x11/frontier = 5,
		/obj/item/reagent_containers/glass/bucket = 1))

	if(prob(60))
		suit = pick_weight(list(
		/obj/item/clothing/suit/armor/vest = 5,
		/obj/item/clothing/suit/armor/vest/bulletproof/frontier = 5,
		/obj/item/clothing/suit/armor/vest/scrap = 1))

	if(prob(50))
		mask = pick_weight(list(
		/obj/item/clothing/mask/gas/frontiersmen = 12,
		/obj/item/clothing/mask/balaclava = 10,
		/obj/item/clothing/mask/breath = 7,
		/obj/item/clothing/mask/whistle = 3))

	if(prob(90))
		back = pick_weight(list(
		/obj/item/storage/backpack = 20,
		/obj/item/storage/backpack/satchel = 20,
		/obj/item/storage/backpack/messenger = 20,
		/obj/item/melee/baton/cattleprod/loaded = 5,
		/obj/item/deployable_turret_folded = 4,
		/obj/item/gun/ballistic/automatic/hmg/skm_lmg/extended = 3,
		))

	if(prob(90))
		shoes = pick_weight(list(
		/obj/item/clothing/shoes/jackboots = 10,
		/obj/item/clothing/shoes/sneakers = 5,
		))

	var/extra_class = pick(list("Doctor", "Breacher", "Ammo Carrier"))
	switch(extra_class)
		if("Doctor")
			backpack_contents += list(/obj/item/storage/firstaid/medical = 1)
			gloves = /obj/item/clothing/gloves/color/latex
			suit = /obj/item/clothing/suit/frontiersmen
			head = /obj/item/clothing/head/frontier
			if(prob(50))
				belt = /obj/item/storage/belt/medical/webbing/frontiersmen/combat
			if(prob(30))
				glasses = /obj/item/clothing/glasses/hud/health
		if("Breacher")
			backpack_contents += list(/obj/item/grenade/c4 = 2, /obj/item/grenade/smokebomb = 3)
			if(prob(60))
				belt = /obj/item/storage/belt/grenade/full
		if("Ammo Carrier")
			var/loops = rand(1,3)
			for(var/i in 1 to loops)
				var/ammotype = pick(list(
					/obj/item/storage/box/ammo/a8_50r,
					/obj/item/storage/box/ammo/c45,
					/obj/item/storage/box/ammo/a357,
					/obj/item/storage/box/ammo/c45,
					/obj/item/storage/box/ammo/a4570,
					/obj/item/stock_parts/cell/gun/mini))
				if(istype(back, /obj/item/storage/backpack))
					backpack_contents += ammotype
				else
					H.put_in_hands(ammotype, FALSE)

	gloves = pick_weight(list(
			/obj/item/clothing/gloves/color/black = 60,
			/obj/item/clothing/gloves/explorer = 30,
			/obj/item/clothing/gloves/explorer/old = 10
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
		/obj/item/clothing/mask/gas/explorer/old = 20,
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
	//now for the fun stuff
	switch(survivor_type)
		if("survivor")
			//uniforms are random to show varied backgrounds, but similar goal
			uniform = pick_weight(list(
				/obj/item/clothing/under/color/random = 65,
				/obj/item/clothing/under/rank/cargo/miner/lavaland = 10,
				/obj/item/clothing/under/rank/prisoner = 10,
				/obj/item/clothing/under/rank/cargo/miner/lavaland/old = 5,
				/obj/item/clothing/under/rank/cargo/miner = 5
				)
			)
			//storage is semi-randomized, giving some variety
			belt = 	pick_weight(list(
				/obj/item/storage/belt/fannypack = 40,
				/obj/item/storage/belt/mining = 20,
				/obj/item/storage/belt/mining/alt = 15,
				/obj/item/storage/belt/utility = 10,
				/obj/item/storage/belt/bandolier = 9,
				/obj/item/storage/belt/utility/full = 5,
				/obj/item/storage/belt/chameleon= 1,
				)
			)
			if(prob(30))
				l_pocket = /obj/item/food/meat/slab/goliath
			if(prob(20))
				r_pocket = /obj/item/spacecash/bundle/smallrand

		if("hunter")
			uniform = pick_weight(list(
				/obj/item/clothing/under/color/random = 50,
				/obj/item/clothing/under/rank/cargo/miner/lavaland = 25,
				/obj/item/clothing/under/rank/cargo/miner/lavaland/old = 15,
				/obj/item/clothing/under/rank/security/officer/camo = 5,
				/obj/item/clothing/under/utility = 5
				)
			)
			belt = 	pick_weight(list(
				/obj/item/storage/belt/mining = 30,
				/obj/item/storage/belt/fannypack = 20,
				/obj/item/storage/belt/mining/alt = 15,
				/obj/item/storage/belt/mining/primitive = 15,
				/obj/item/storage/belt/bandolier = 10,
				/obj/item/storage/belt/military = 7,
				/obj/item/storage/belt/mining/vendor = 3,
				)
			)
			if(prob(20))
				l_pocket = /obj/item/food/meat/slab/goliath
			else if(prob(60))
				l_pocket = /obj/item/ammo_box/a762_stripper
			if(prob(20))
				new /obj/item/gun/ballistic/rifle/polymer(loc)
			else
				visible_message(span_warning("The hermit's weapon shatters as they impact the ground!"))

		if("gunslinger")
			uniform = pick_weight(list(
				/obj/item/clothing/under/rank/cargo/miner/lavaland = 35,
				/obj/item/clothing/under/color/random = 25,
				/obj/item/clothing/under/rank/cargo/miner/lavaland/old = 15,
				/obj/item/clothing/under/rank/security/officer/camo = 10,
				/obj/item/clothing/under/syndicate/camo = 10,
				/obj/item/clothing/under/syndicate/combat = 5
				)
			)
			belt = pick_weight(list(
				/obj/item/storage/belt/mining = 30,
				/obj/item/storage/belt/bandolier = 30,
				/obj/item/storage/belt/military = 20,
				/obj/item/storage/belt/fannypack = 15,
				/obj/item/storage/belt/mining/alt = 5,
				/obj/item/storage/belt/mining/primitive = 5
				)
			)
			if(prob(30))
				shoes = /obj/item/clothing/shoes/combat //sometimes there are nicer shoes
			if(prob(50))
				l_pocket = /obj/item/ammo_box/magazine/skm_46_30/recycled
			if(prob(20))
				new /obj/item/gun/ballistic/automatic/smg/skm_carbine(loc)
			else
				visible_message(span_warning("The hermit's weapon shatters as they impact the ground!"))

		if("e11")
			uniform = pick_weight(list(
				/obj/item/clothing/under/rank/cargo/miner = 65,
				/obj/item/clothing/under/color/random = 25,
				/obj/item/clothing/under/rank/cargo/miner/lavaland/old = 10,
				)
			)
			belt = pick_weight(list(
				/obj/item/storage/belt/utility = 25,
				/obj/item/storage/belt/mining = 15,
				/obj/item/storage/belt/fannypack = 15,
				/obj/item/storage/belt/mining/alt = 5,
				)
			)
			shoes = /obj/item/clothing/shoes/workboots
			if(prob(40)) // Hilarious, ain't it?
				new /obj/item/gun/energy/e_gun/e11 (loc)
			else
				visible_message(span_warning("The trooper's weapon shatters as they impact the ground!"))
		if("shotgun")
			uniform = pick_weight(list(
				/obj/item/clothing/under/color/random = 50,
				/obj/item/clothing/under/rank/cargo/miner/lavaland = 25,
				/obj/item/clothing/under/rank/cargo/miner/lavaland/old = 15,
				/obj/item/clothing/under/rank/security/officer/camo = 5,
				/obj/item/clothing/under/utility = 5
				)
			)
			belt = 	pick_weight(list(
				/obj/item/storage/belt/mining = 30,
				/obj/item/storage/belt/fannypack = 20,
				/obj/item/storage/belt/mining/alt = 15,
				/obj/item/storage/belt/mining/primitive = 15,
				/obj/item/storage/belt/bandolier = 10,
				/obj/item/storage/belt/military = 7,
				/obj/item/storage/belt/mining/vendor = 3,
				)
			)
			if(prob(60))
				l_pocket = /obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/improvised
			if(prob(20))
				new /obj/item/gun/ballistic/shotgun/doublebarrel/improvised(loc)
			else
				visible_message(span_warning("The hermit's weapon shatters as they impact the ground!"))
	. = ..()


/obj/effect/mob_spawn/human/corpse/damaged/whitesands/survivor
	survivor_type = "survivor"

/obj/effect/mob_spawn/human/corpse/damaged/whitesands/hunter
	survivor_type = "hunter"

/obj/effect/mob_spawn/human/corpse/damaged/whitesands/shotgun
	survivor_type = "shotgun"

/obj/effect/mob_spawn/human/corpse/damaged/whitesands/gunslinger
	survivor_type = "gunslinger"

/obj/effect/mob_spawn/human/corpse/damaged/whitesands/e11
	survivor_type = "e11"

//hold overs for any admin who may want to spawn their own survivor realmobs

/datum/outfit/whitesands
	name = "Whitesands Survivor"
	uniform = /obj/item/clothing/under/color/random
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/hooded/survivor
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	gloves = /obj/item/clothing/gloves/color/black //randomize a bit
