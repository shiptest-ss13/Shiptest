/mob/living/simple_animal/hostile/human/skeleton
	name = "reanimated skeleton"
	desc = "A real bonefied skeleton, doesn't seem like it wants to socialize."
	icon_state = "skeleton"
	icon_living = "skeleton"
	icon_dead = "skeleton"
	gender = NEUTER
	mob_biotypes = MOB_UNDEAD|MOB_HUMANOID
	speak_emote = list("rattles")
	emote_see = list("rattles")
	maxHealth = 40
	health = 40
	speed = 1
	melee_damage_lower = 15
	melee_damage_upper = 15
	minbodytemp = 0
	maxbodytemp = 1500
	healable = 0 //they're skeletons how would bruise packs help them??
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 10
	stat_attack = HARD_CRIT
	faction = list("skeleton")
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	deathmessage = "collapses into a pile of bones!"
	loot = list(/obj/effect/decal/remains/human)
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/human/skeleton/templar
	name = "undead templar"
	desc = "The reanimated remains of a holy templar knight."
	icon_state = "templar"
	icon_living = "templar"
	icon_dead = "templar_dead"
	maxHealth = 150
	health = 150
	weather_immunities = list("snow")
	speed = 2
	speak_chance = 1
	speak = list("THE GODS WILL IT!","DEUS VULT!","REMOVE KABAB!")
	force_threshold = 10 //trying to simulate actually having armor
	obj_damage = 50
	melee_damage_lower = 25
	melee_damage_upper = 30
	deathmessage = "collapses into a pile of bones, its gear clanging as it hits the ground!"
	loot = list(/obj/effect/decal/remains/human,
				/obj/item/clothing/suit/armor/witchhunter,
				/obj/item/melee/sword/claymore{name = "holy sword"})

/mob/living/simple_animal/hostile/human/skeleton/ice
	name = "ice skeleton"
	desc = "A reanimated skeleton protected by a thick sheet of natural ice armor. Looks slow, though."
	speed = 5
	maxHealth = 75
	health = 75
	weather_immunities = list("snow")
	color = rgb(114,228,250)
	loot = list(/obj/effect/decal/remains/human{color = rgb(114,228,250)})

/mob/living/simple_animal/hostile/human/skeleton/plasmaminer
	name = "shambling miner"
	desc = "A plasma-soaked miner, their exposed limbs turned into a grossly incandescent bone seemingly made of plasma."
	icon_state = "plasma_miner"
	icon_living = "plasma_miner"
	icon_dead = "plasma_miner"
	maxHealth = 150
	health = 150
	harm_intent_damage = 10
	melee_damage_lower = 15
	melee_damage_upper = 20
	light_color = LIGHT_COLOR_PURPLE
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	deathmessage = "collapses into a pile of bones, their suit dissolving among the plasma!"
	loot = list(/obj/effect/decal/remains/plasma)

/mob/living/simple_animal/hostile/human/skeleton/plasmaminer/jackhammer
	desc = "A plasma-soaked miner, their exposed limbs turned into a grossly incandescent bone seemingly made of plasma. They seem to still have their mining tool in their hand, gripping tightly."
	icon_state = "plasma_miner_tool"
	icon_living = "plasma_miner_tool"
	icon_dead = "plasma_miner_tool"
	maxHealth = 185
	health = 185
	harm_intent_damage = 15
	melee_damage_lower = 20
	melee_damage_upper = 25
	attack_verb_continuous = "blasts"
	attack_verb_simple = "blast"
	attack_sound = 'sound/weapons/sonic_jackhammer.ogg'
	loot = list(/obj/effect/decal/remains/plasma, /obj/item/pickaxe/drill/jackhammer)

/mob/living/simple_animal/hostile/human/skeleton/plasmaminer/Initialize()
	. = ..()
	set_light(2)
