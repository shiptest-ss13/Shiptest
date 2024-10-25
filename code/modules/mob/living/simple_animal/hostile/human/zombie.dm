/mob/living/simple_animal/hostile/human/zombie
	name = "Shambling Corpse"
	desc = "When there is no more room in hell, the dead will walk in outer space."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "zombie"
	icon_living = "zombie"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	stat_attack = HARD_CRIT //braains
	harm_intent_damage = 5
	melee_damage_lower = 21
	melee_damage_upper = 21
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	status_flags = CANPUSH
	loot = list()
	del_on_death = 1
	var/zombiejob = "Medical Doctor"
	var/infection_chance = 0
	var/obj/effect/mob_spawn/human/corpse/delayed/corpse

/mob/living/simple_animal/hostile/human/zombie/Initialize(mapload)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(setup_visuals))

/mob/living/simple_animal/hostile/human/zombie/proc/setup_visuals()
	var/datum/preferences/dummy_prefs = new
	dummy_prefs.pref_species = new /datum/species/zombie
	dummy_prefs.randomise[RANDOM_BODY] = TRUE
	if(zombiejob)
		var/datum/job/J = GLOB.name_occupations[zombiejob]
		var/datum/outfit/O
		if(J.outfit)
			O = new J.outfit
			//They have claws now.
			O.r_hand = null
			O.l_hand = null
			armor_base = O.suit

		var/icon/P = get_flat_human_icon("zombie_[zombiejob]", J , dummy_prefs, "zombie", outfit_override = O)
		icon = P
		corpse = new(src)
		corpse.outfit = O
		corpse.mob_species = /datum/species/zombie
		corpse.mob_name = name

/mob/living/simple_animal/hostile/human/zombie/AttackingTarget()
	. = ..()
	if(. && ishuman(target) && prob(infection_chance))
		try_to_zombie_infect(target)

/mob/living/simple_animal/hostile/human/zombie/drop_loot()
	. = ..()
	corpse.forceMove(drop_location())
	corpse.create()

/mob/living/simple_animal/hostile/human/zombie/kudzu
	name = "shambling bramble"
	desc = "A shambling mass of vibrant vines and rotting flesh. "
	melee_damage_lower = 15
	melee_damage_upper = 25
	attack_verb_continuous = "lashes"
	attack_verb_simple = "lash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
