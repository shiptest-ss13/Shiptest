/mob/living/simple_animal/hostile/asteroid/whitesands
	name = "Whitesands Inhabitant"
	desc = "If you can read this, yell at a coder!"
	icon = 'whitesands/icons/mob/simple_human.dmi'
	icon_state = "survivor_base"
	icon_living = "survivor_base"
	icon_dead = null
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC
	minbodytemp = 180
	unsuitable_atmos_damage = 15
	atmos_requirements = list("min_oxy" = 1, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 999, "min_n2" = 0, "max_n2" = 0)
	speak_chance = 20
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
		"The sun... The sun...",
		"You'll do...",
		"All mine...",
		"Gg..free..",
		"Drink.. need drink...",
		"I can smell... you..",
		"G-g...",
		"Taste..the salt.",
	)
	loot = list(
		/obj/effect/mob_spawn/human/corpse/whitesands/survivor,
		/obj/effect/spawner/lootdrop/whitesands/survivor
	)
	del_on_death = 1
	faction = list("mining")

/mob/living/simple_animal/hostile/asteroid/whitesands/survivor/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	..(gibbed)
	if(prob(15))
		new /obj/item/crusher_trophy/shiny(loc)

/mob/living/simple_animal/hostile/asteroid/whitesands/survivor
	name = "Hermit Wanderer"
	desc =" A wild-eyed figure, wearing tattered mining equipment and boasting a malformed body, twisted by the heavy metals and high background radiation of the sandworlds."

/mob/living/simple_animal/hostile/asteroid/whitesands/survivor/random/Initialize()
	. = ..()
	if(prob(35))
		new /mob/living/simple_animal/hostile/asteroid/whitesands/ranged/hunter(loc)
	if(prob(10))
		new /mob/living/simple_animal/hostile/asteroid/whitesands/ranged/gunslinger(loc)
		return INITIALIZE_HINT_QDEL

/mob/living/simple_animal/hostile/asteroid/whitesands/ranged
	icon_state = "survivor_hunter"
	icon_living = "survivor_hunter"
	projectiletype = null
	casingtype = /obj/item/ammo_casing/ballistic/aac_300blk/recycled
	projectilesound = 'sound/weapons/gun/rifle/shot.ogg'
	ranged = 1
	rapid_fire_delay = 6
	retreat_distance = 5
	minimum_distance = 5

/mob/living/simple_animal/hostile/asteroid/whitesands/ranged/hunter
	name = "Hermit Hunter"
	desc ="A wild-eyed figure. Watch out- he has a gun, and he remembers just enough of his old life to use it!"
	loot = list(
		/obj/effect/mob_spawn/human/corpse/whitesands/survivor/hunter,
		/obj/effect/spawner/lootdrop/whitesands/survivor/hunter
	)

/mob/living/simple_animal/hostile/asteroid/whitesands/ranged/gunslinger
	name = "Hermit Soldier"
	desc = "The miner's rebellion, though mostly underground, recieved a few good weapon shipments from an off-sector source. You should probably start running."
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
