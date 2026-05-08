/proc/mass_purrbation()
	for(var/mob/living/carbon/human/target as anything in GLOB.human_list)
		target.purrbation_apply()
		CHECK_TICK

/proc/mass_remove_purrbation()
	for(var/mob/living/carbon/human/target as anything in GLOB.human_list)
		target.purrbation_remove()
		CHECK_TICK

/proc/purrbation_toggle(mob/living/carbon/human/target, silent = FALSE)
	target.purrbation_remove(silent)
	. = FALSE

/mob/living/carbon/human/proc/purrbation_apply(silent = FALSE)
	var/obj/item/organ/ears/cat/kitty_ears = new
	var/obj/item/bodypart/tail/human/cat/kitty_tail = new
	kitty_ears.Insert(src, special = TRUE, drop_if_replaced = FALSE) //Gives nonhumans cat tail and ears
	kitty_tail.replace_limb(src, TRUE, TRUE)
	if(!silent)
		to_chat(src, span_boldnotice("Something is nya~t right."))
		SEND_SOUND(src, 'sound/effects/meow1.ogg')

/mob/living/carbon/human/proc/purrbation_remove(silent = FALSE)
	var/obj/item/bodypart/tail/human/cat/cat_tail = get_bodypart(BODY_ZONE_TAIL)
	var/obj/item/organ/ears/cat/cat_ears = locate() in internal_organs
	if(cat_tail)
		cat_tail.drop_limb(TRUE, FALSE)
		regenerate_limb(BODY_ZONE_TAIL, robotic = fbp)
	if(cat_ears)
		var/obj/item/organ/new_ears = new dna.species.species_organs[ORGAN_SLOT_EARS]
		new_ears.Insert(src, TRUE, FALSE)
	if(!silent)
		to_chat(src, span_boldnotice("You are no longer a cat."))
