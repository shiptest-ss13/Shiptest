//Taste defines
#define NO_TASTE_SENSITIVITY -1
#define DEFAULT_TASTE_SENSITIVITY 15

/mob/living
	var/last_taste_time
	var/last_taste_text

/mob/living/proc/get_taste_sensitivity()
	return DEFAULT_TASTE_SENSITIVITY

/mob/living/carbon/get_taste_sensitivity()
	var/obj/item/organ/tongue/tongue = getorganslot(ORGAN_SLOT_TONGUE)
	if(istype(tongue) && !HAS_TRAIT(src, TRAIT_AGEUSIA))
		. = tongue.taste_sensitivity
	else
		. = NO_TASTE_SENSITIVITY // can't taste anything without a tongue

/**
 * Non-destructively tastes a reagent container
 * and gives feedback to the user.
 * Arguments:
 * * datum/reagents/from - Reagent holder to taste from.
 **/
/mob/living/proc/taste_container(datum/reagents/from)
	if(check_tasting_blocks())
		return

	var/taste_sensitivity = get_taste_sensitivity()
	var/text_output = from.generate_taste_message(src, taste_sensitivity)
	send_taste_message(text_output)

/**
 * Non-destructively tastes a reagent list
 * and gives feedback to the user.
 * Arguments:
 * * list/from - List of reagents to taste from.
 **/
/mob/living/proc/taste_list(list/from)
	if(check_tasting_blocks())
		return

	var/taste_sensitivity = get_taste_sensitivity()
	var/text_output = generate_reagents_taste_message(from, src, taste_sensitivity)
	send_taste_message(text_output)

/**
 * Check for anything blocking/overriding our tasting.
 * Returns TRUE on a block, FALSE if not.
 **/
/mob/living/proc/check_tasting_blocks()
	if(HAS_TRAIT(src, TRAIT_AGEUSIA))
		return TRUE
	if(last_taste_time + 50 >= world.time)
		return TRUE

	// Sometimes, try send a replacement message if we're hallucinating
	if(hallucination > 40 && prob(25))
		var/text_output = pick("spiders","dreams","nightmares","the future","the past","victory",\
			"defeat","pain","bliss","revenge","poison","time","space","death","life","truth","lies","justice","memory",\
			"regrets","your soul","suffering","music","noise","blood","hunger","the gezenan way")
		send_taste_message(text_output)
		return TRUE

	return FALSE

/**
 * Attempt to send a taste message using given tastes text.
 **/
/mob/living/proc/send_taste_message(tastes_text)
	if(tastes_text == last_taste_text && last_taste_time + 100 >= world.time)
		return

	to_chat(src, span_notice("You can taste [tastes_text]."))
	// "something indescribable" -> too many tastes, not enough flavor.

	last_taste_time = world.time
	last_taste_text = tastes_text

#undef DEFAULT_TASTE_SENSITIVITY
