/mob/living/simple_animal/hostile/human
	name = "crazed human"
	desc = "A crazed human, they cannot be reasoned with"
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "survivor_base"
	icon_living = "survivor_base"
	icon_dead = null
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID

	speak_chance = 20
	speak_emote = list("groans")

	turns_per_move = 5
	speed = 0
	maxHealth = 100
	health = 100

	robust_searching = TRUE
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	response_help_continuous = "pushes"
	response_help_simple = "push"

	loot = list(/obj/effect/mob_spawn/human/corpse/damaged)
	del_on_death = TRUE

	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	minbodytemp = 180
	status_flags = CANPUSH
	del_on_death = TRUE

	footstep_type = FOOTSTEP_MOB_SHOE

	faction = list("hermit")
	/// Creates an armor item to compare 
	var/obj/item/clothing/armor_base = null

/mob/living/simple_animal/hostile/human/Initialize()
	. = ..()
	if(ispath(armor_base, /obj/item/clothing))
		armor_base = new armor_base()

/mob/living/simple_animal/hostile/human/getarmor(def_zone, type) //WE CLOWN IN THIS fake carbon/human. GET YOUR INTRINSIC ARMOR BACK TO /mob/living/simple_animal
	if(istype(armor_base))
		return armor_base.armor.getRating(type)
	return FALSE
