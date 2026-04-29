/mob/living/simple_animal/hostile/human/clip
	name = "Colonial League Objector"
	desc = "A deserter from the Colonial League of Independent Planets turned Renegade. This one is unarmed."
	icon_state = "clip"
	icon_living = "clip"
	speak_chance = 0
	stat_attack = HARD_CRIT
	atmos_requirements = IMMUNE_ATMOS_REQS
	maxbodytemp = 400
	unsuitable_atmos_damage = 15
	faction = list(FACTION_ANTAG_DEFECTORS)
	loot = list()
	check_friendly_fire = TRUE
	dodging = TRUE
	rapid_melee = 2
	mob_spawner = /obj/effect/mob_spawn/human/corpse/ramzi

	armor_base = /obj/item/clothing/suit/armor/vest/syndie
