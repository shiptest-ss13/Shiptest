/mob/living/simple_animal/hostile/whitesands
	name = "Whitesands Inhabitant"
	desc = "If you can read this, yell at a coder!"
	icon = 'waspstation/icons/mob/simple_human.dmi'
	icon_state = "survivor_base"
	icon_living = "survivor_base"
	icon_dead = null
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	minbodytemp = 180
	unsuitable_atmos_damage = 15
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 999, "min_n2" = 0, "max_n2" = 0)
	speak_chance = 3
	turns_per_move = 5
	response_help_continuous = "pushes"
	response_help_simple = "push"
	speed = 0
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	unsuitable_atmos_damage = 15
	speak_emote = list(
		"Camping in the desert almost makes you wish for a nuclear winter.",
		"What I would give for a donk pocket right now...",
		"Hey you know what I don't miss? Clowns.",
		"There's something on the horizon. I hope it's not more goddamn Muad'dib.",
		"I am so fucking thirsty.",
		"Who the fuck took my goliath steak!?",
		"Even getting blackout on Pan Galactic Gargle-Blasters would be better than this.",
		"My feet hurt.",
	)
	loot = list(
		/obj/effect/mob_spawn/human/corpse/whitesands/survivor,
		/obj/effect/spawner/lootdrop/whitesands/survivor
	)
	del_on_death = 1
	faction = list() // Generated at runtime based on their camp ID

/mob/living/simple_animal/hostile/whitesands/survivor
	name = "Whitesands Survivor"
	desc = {"
	 This person might have once been a colonist, station crew, or even a tourist.
	 What they are now is something entirely different, as life on Whitesands has beat them into something new.
	"}

/mob/living/simple_animal/hostile/whitesands/ranged
	icon_state = "survivor_hunter"
	icon_living = "survivor_hunter"
	projectiletype = null
	casingtype = /obj/item/ammo_casing/ballistic/aac_300blk/recycled
	projectilesound = 'sound/weapons/gun/rifle/shot.ogg'
	ranged = 1
	rapid_fire_delay = 6
	retreat_distance = 5
	minimum_distance = 5

/mob/living/simple_animal/hostile/whitesands/ranged/hunter
	name = "Whitesands Hunter"
	desc = {"
	 One of the few survivors on the planet with working weaponry.
	 Hunting on Whitesands is dangerous, hard work, making a hunter still standing one to be feared.
	"}
	loot = list(
		/obj/effect/mob_spawn/human/corpse/whitesands/survivor/hunter,
		/obj/effect/spawner/lootdrop/whitesands/survivor/hunter
	)

/mob/living/simple_animal/hostile/whitesands/ranged/gunslinger
	name = "Whitesands Gunslinger"
	desc = {"
	 One of the few survivors on the planet with working weaponry.
	 While the weapon they wield is ancient compared to most modern firearms, it packs a hell of a punch.
	"}
	icon_state = "survivor_gunslinger"
	icon_living = "survivor_gunslinger"
	projectilesound = 'sound/weapons/gun/smg/shot.ogg'
	rapid = 4
	rapid_fire_delay = 3
	casingtype = /obj/item/ammo_casing/ballistic/a545_39/recycled
	loot = list(
		/obj/effect/mob_spawn/human/corpse/whitesands/survivor/gunslinger,
		/obj/effect/spawner/lootdrop/whitesands/survivor/gunslinger
	)
