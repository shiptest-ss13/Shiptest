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
	var/obj/item/organ/tail/cat/kitty_tail = new
	kitty_ears.Insert(src, special = TRUE, drop_if_replaced = FALSE) //Gives nonhumans cat tail and ears
	kitty_tail.Insert(src, special = TRUE, drop_if_replaced = FALSE)
	if(!silent)
		to_chat(src, "<span class='boldnotice'>Something is nya~t right.</span>")
		SEND_SOUND(src, 'sound/effects/meow1.ogg')

/mob/living/carbon/human/proc/purrbation_remove(silent = FALSE)
	var/obj/item/organ/tail/cat/cat_tail = locate() in internal_organs
	var/obj/item/organ/ears/cat/cat_ears = locate() in internal_organs
	if(cat_tail)
		cat_tail.Remove(src, TRUE)
		var/obj/item/organ/tail/new_tail
		for(var/organ in dna.species.mutant_organs) //Yes, there's no other way.
			if(ispath(organ, /obj/item/organ/tail))
				new_tail = organ
		if(new_tail)
			new_tail = new new_tail()
			new_tail.Insert(src, TRUE, FALSE)
	if(cat_ears)
		var/obj/item/organ/new_ears = new dna.species.mutantears
		new_ears.Insert(src, TRUE, FALSE)
	if(!silent)
		to_chat(src, "<span class='boldnotice'>You are no longer a cat.</span>")
