////////////////////////////////////////////////////////////////////////////////
/// Food.
////////////////////////////////////////////////////////////////////////////////
/// Note: When adding food items with dummy parents, make sure to add
/// the parent to the exclusion list in code/__HELPERS/unsorted.dm's
/// get_random_food proc.
////////////////////////////////////////////////////////////////////////////////

/obj/item/reagent_containers/food
	possible_transfer_amounts = list()
	volume = 50	//Sets the default container amount for all food items.
	reagent_flags = INJECTABLE
	resistance_flags = FLAMMABLE
	var/foodtype = NONE
	var/last_check_time
	var/in_container = FALSE //currently just stops "was bitten X times!" messages on canned food

/obj/item/reagent_containers/food/Initialize(mapload)
	. = ..()
	if(!mapload)
		pixel_x = rand(-5, 5)
		pixel_y = rand(-5, 5)

/obj/item/reagent_containers/food/proc/checkLiked(fraction, mob/eater)
	if(last_check_time + 50 < world.time)
		if(ishuman(eater))
			var/mob/living/carbon/human/human_eater = eater
			if(!HAS_TRAIT(human_eater, TRAIT_AGEUSIA))
				if(foodtype & human_eater.dna.species.toxic_food)
					to_chat(human_eater,span_warning("What the hell was that thing?!"))
					human_eater.adjust_disgust(25 + 30 * fraction)
					SEND_SIGNAL(human_eater, COMSIG_ADD_MOOD_EVENT, "toxic_food", /datum/mood_event/disgusting_food)
				else if(foodtype & human_eater.dna.species.disliked_food)
					to_chat(human_eater,span_notice("That didn't taste very good..."))
					human_eater.adjust_disgust(11 + 15 * fraction)
					SEND_SIGNAL(human_eater, COMSIG_ADD_MOOD_EVENT, "gross_food", /datum/mood_event/gross_food)
				else if(foodtype & human_eater.dna.species.liked_food)
					to_chat(human_eater,span_notice("I love this taste!"))
					human_eater.adjust_disgust(-5 + -2.5 * fraction)
					SEND_SIGNAL(human_eater, COMSIG_ADD_MOOD_EVENT, "fav_food", /datum/mood_event/favorite_food)
			else
				if(foodtype & human_eater.dna.species.toxic_food)
					to_chat(human_eater, span_warning("You don't feel so good..."))
					human_eater.adjust_disgust(25 + 30 * fraction)
			if((foodtype & BREAKFAST) && human_eater.has_status_effect(STATUS_EFFECT_BREAKFAST))
				SEND_SIGNAL(human_eater, COMSIG_ADD_MOOD_EVENT, "breakfast", /datum/mood_event/breakfast)
			last_check_time = world.time
