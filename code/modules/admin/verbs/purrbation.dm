/proc/mass_purrbation()
	for(var/M in GLOB.mob_list)
		if(ishuman(M))
			purrbation_apply(M)
		CHECK_TICK

/proc/mass_remove_purrbation()
	for(var/M in GLOB.mob_list)
		if(ishuman(M))
			purrbation_remove(M)
		CHECK_TICK

/proc/purrbation_toggle(mob/living/carbon/human/H, silent = FALSE)
	if(!ishumanbasic(H))
		return
	purrbation_remove(H, silent)
	. = FALSE

/proc/purrbation_apply(mob/living/carbon/human/H, silent = FALSE)
	if(!ishuman(H))
		return
	var/obj/item/organ/ears/cat/kitty_ears = new
	var/obj/item/organ/tail/cat/kitty_tail = new
	kitty_ears.Insert(H, TRUE, FALSE) //Gives nonhumans cat tail and ears
	kitty_tail.Insert(H, TRUE, FALSE)
	if(!silent)
		to_chat(H, "<span class='boldnotice'>Something is nya~t right.</span>")
		playsound(get_turf(H), 'sound/effects/meow1.ogg', 50, TRUE, -1)

/proc/purrbation_remove(mob/living/carbon/human/H, silent = FALSE)
	if(ishuman(H) && !ishumanbasic(H))
		var/datum/species/target_species = H.dna.species
		var/organs = H.internal_organs
		for(var/obj/item/organ/current_organ in organs)
			if(istype(current_organ, /obj/item/organ/tail/cat))
				current_organ.Remove(H, TRUE)
				var/obj/item/organ/tail/new_tail = locate(/obj/item/organ/tail) in target_species.mutant_organs
				if(new_tail)
					new_tail = new new_tail()
					new_tail.Insert(H, TRUE, FALSE)
			if(istype(current_organ, /obj/item/organ/ears/cat))
				var/obj/item/organ/new_ears = new target_species.mutantears
				new_ears.Insert(H, TRUE, FALSE)
	if(!silent)
		to_chat(H, "<span class='boldnotice'>You are no longer a cat.</span>")
