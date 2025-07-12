
//A lone crazed Sonnensöldner, mostly to demenstrate that transforming weapons work visually
/mob/living/simple_animal/hostile/human/solgov
	name = "Silent Sonnensöldner"
	speak_chance = 0
	speak_emote = list(".....", "...")
	melee_damage_lower = 40
	melee_damage_upper = 40

	maxHealth = 200
	health = 200

	loot = list()
	atmos_requirements = NORMAL_ATMOS_REQS
	faction = list(FACTION_SOLCON)
	footstep_type = FOOTSTEP_MOB_SHOE
	mob_spawner = /obj/effect/mob_spawn/human/corpse/solgov/sonnensoldner
	l_hand = /obj/item/melee/duelenergy/halberd
	dodging = TRUE
