/mob/living/simple_animal/pet/mothroach
	name = "mothroach"
	desc = "This is the adorable by-product of multiple attempts at genetically mixing mothpeople with cockroaches."
	initial_language_holder = /datum/language_holder/moth
	icon_state = "mothroach"
	icon_living = "mothroach"
	icon_dead = "mothroach_dead"
	deathsound =  'sound/voice/moth/moth_a.ogg'
	held_state = "mothroach"
	head_icon = 'icons/mob/pets_held.dmi'
	worn_slot_flags = ITEM_SLOT_HEAD
	emote_hear = list("chitters", "flutters")
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/mothroach = 3, /obj/item/stack/sheet/animalhide/mothroach = 1)
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	mob_size = MOB_SIZE_SMALL
	ventcrawler = VENTCRAWLER_ALWAYS
	health = 25
	maxHealth = 25
	speed = 1.25
	verb_say = "flutters"
	verb_ask = "flutters inquisitively"
	verb_exclaim = "flutters loudly"
	verb_yell = "flutters loudly"
	response_disarm_continuous = "shoos"
	response_disarm_simple = "shoo"
	response_harm_continuous = "hits"
	response_harm_simple = "hit"
	response_help_continuous = "pats"
	response_help_simple = "pat"

/mob/living/simple_animal/pet/mothroach/Initialize()
	. = ..()
	add_verb(src, /mob/living/proc/update_resting)
	ADD_TRAIT(src, TRAIT_HOLDABLE, INNATE_TRAIT)

/mob/living/simple_animal/pet/mothroach/update_resting()
	. = ..()
	if(stat == DEAD)
		return
	if (resting)
		icon_state = "[icon_living]_rest"
	else
		icon_state = "[icon_living]"
	regenerate_icons()

/mob/living/simple_animal/pet/mothroach/attack_hand(mob/living/carbon/human/M)
	. = ..()
	if(stat == DEAD)
		return
	else
		switch(M.a_intent)
			if("help")
				new /obj/effect/temp_visual/heart(loc)
				manual_emote("chitters happily!")
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, src, /datum/mood_event/pet_animal, src)
			if("harm")
				playsound(loc, 'sound/voice/moth/scream_moth.ogg', 50, TRUE)

/mob/living/simple_animal/pet/mothroach/attackby(obj/item/I, mob/user, params)
	if(isclothing(I))
		to_chat(user, "<span class='notice'>You feed [I] to [src].</span>")
		visible_message("[src] chitters happily!")
		qdel(I) // this sucks
	else
		return ..()
