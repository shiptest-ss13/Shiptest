///Willow Ptarmigan, aka Willow Grouse or "Awebo Bird." Code copied from junglefowl in farm_animals.dm

/mob/living/simple_animal/hostile/retaliate/chicken/awebo
	name = "\improper willow grouse"
	desc = "Also known as the Willow Ptarmigan, this small, white bird native to many cold planets is notorious for being extremely territorial and picking fights with creatures more than twice its size."
	gender = MALE ///males are the territorial ones
	icon_state = "awebo"
	icon_living = "awebo"
	icon_dead = "awebo_dead"
	speak = list("Awebo. Awebo.","Bupbupbupbupbup.","Bgow. Bgow. Bgow.", "EWEEE-EEH.")
	speak_emote = list("chirps", "growls")
	emote_hear = list("awebos.")
	emote_see = list("looks around...","hops and flaps its wings!")
	speak_chance = 4 ///yapper
	butcher_results = list(/obj/item/food/meat/slab/chicken = 2)
	egg_type = /obj/item/food/egg/small
	food_type = list(/obj/item/food/grown/wheat)
	wanted_objects = list(/obj/item/food/grown/oat, /obj/item/food/grown/berries, /obj/item/food/grown/bluecherries) ///all based off their irl diet
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "pecks"
	attack_verb_simple = "peck"
	health = 40
	maxHealth = 40
	icon_prefix = "awebo"
	feedMessages = list("It grunts happily.","It awebos happily.")
	layMessage = list("brushes away some snow. There's an egg here!") ///they're males.
	validColors = list("white", "brown")
	environment_smash = ENVIRONMENT_SMASH_NONE
	melee_damage_lower = 5
	melee_damage_upper = 10

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/hostile/retaliate/chicken/awebo/Initialize()
	. = ..()
	if(!body_color)
		body_color = pick(validColors)
	icon_state = "[icon_prefix]_[body_color]"
	icon_living = "[icon_prefix]_[body_color]"
	icon_dead = "[icon_prefix]_[body_color]_dead"
