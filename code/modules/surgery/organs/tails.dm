// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.

/obj/item/organ/tail
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	icon_state = "severedtail"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	var/tail_type = "None"

/obj/item/organ/tail/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(H && H.dna && H.dna.species)
		H.dna.species.stop_wagging_tail(H)

/obj/item/organ/tail/cat
	name = "cat tail"
	desc = "A severed cat tail. Who's wagging now?"
	tail_type = "Cat"

/obj/item/organ/tail/cat/slime
	name = "slimy cat tail"
	desc = "A slimy looking severed cat tail."
	tail_type = "Slimecat"
	alpha = 150

/obj/item/organ/tail/cat/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		if(!("tail_human" in H.dna.species.mutant_bodyparts))
			H.dna.species.mutant_bodyparts |= "tail_human"
			H.dna.features["tail_human"] = tail_type
			H.update_body()

/obj/item/organ/tail/cat/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(istype(H))
		H.dna.features["tail_human"] = "None"
		H.dna.species.mutant_bodyparts -= "tail_human"
		color = H.hair_color
		H.update_body()

/obj/item/organ/tail/lizard
	name = "\improper Sarathi tail"
	desc = "A severed Sarathi's tail. Can't they regrow these...?"
	icon_state = "severedlizard"
	color = "#116611"
	tail_type = "Smooth"
	var/spines = "None"

/obj/item/organ/tail/lizard/Initialize()
	. = ..()
	color = "#"+ random_color()

/obj/item/organ/tail/lizard/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		// Checks here are necessary so it wouldn't overwrite the tail of a lizard it spawned in
		if(!("tail_lizard" in H.dna.species.mutant_bodyparts))
			if(!H.dna.features["tail_lizard"])
				H.dna.features["tail_lizard"] = tail_type
				H.dna.species.mutant_bodyparts |= "tail_lizard"
			else
				H.dna.species.mutant_bodyparts["tail_lizard"] = H.dna.features["tail_lizard"]

		if(!("spines" in H.dna.species.mutant_bodyparts))
			if(!H.dna.features["spines"])
				H.dna.features["spines"] = spines
				H.dna.species.mutant_bodyparts |= "spines"
			else
				H.dna.species.mutant_bodyparts["spines"] = H.dna.features["spines"]
		H.update_body()

/obj/item/organ/tail/lizard/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(istype(H))
		H.dna.species.mutant_bodyparts -= "tail_lizard"
		H.dna.species.mutant_bodyparts -= "spines"
		color = "#" + H.dna.features["mcolor"]
		tail_type = H.dna.features["tail_lizard"]
		spines = H.dna.features["spines"]
		H.update_body()

/obj/item/organ/tail/lizard/fake
	name = "fabricated lizard tail"
	desc = "A fabricated severed lizard tail. This one's made of synthflesh. Probably not usable for lizard wine."

/obj/item/organ/tail/elzu
	name = "\improper Elzuose tail"
	desc = "A detached Elzuose's tail. You probably shouldn't plant this."
	color = "#d3e8e9"
	tail_type = "Long"

/obj/item/organ/tail/elzu/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		// Checks here are necessary so it wouldn't overwrite the tail of an elzu it spawned in
		if(!("tail_elzu" in H.dna.species.mutant_bodyparts))
			if(!H.dna.features["tail_elzu"])
				H.dna.features["tail_elzu"] = tail_type
				H.dna.species.mutant_bodyparts |= "tail_elzu"
			else
				H.dna.species.mutant_bodyparts["tail_elzu"] = H.dna.features["tail_elzu"]

/obj/item/organ/tail/elzu/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(istype(H))
		H.dna.species.mutant_bodyparts -= "tail_elzu"
		color = "#" + H.dna.features["mcolor"]
		tail_type = H.dna.features["tail_elzu"]
		H.update_body()

/obj/item/organ/tail/fox
	name = "fox tail"
	desc = "A severed fox tail. Sad."
	icon_state = "severedfox"
	tail_type = "Fox"

/obj/item/organ/tail/fox/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		if(!("tail_human" in H.dna.species.mutant_bodyparts))
			H.dna.species.mutant_bodyparts |= "tail_human"
			H.dna.features["tail_human"] = tail_type
			H.update_body()

/obj/item/organ/tail/fox/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(istype(H))
		H.dna.features["tail_human"] = "None"
		H.dna.species.mutant_bodyparts -= "tail_human"
		color = H.hair_color
		H.update_body()

/obj/item/organ/tail/fox/alt
	name = "fox tail"
	desc = "A severed fox tail. Sad."
	tail_type = "Fox 2"

/obj/item/organ/tail/cat/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		if(!("tail_human" in H.dna.species.mutant_bodyparts))
			H.dna.species.mutant_bodyparts |= "tail_human"
			H.dna.features["tail_human"] = tail_type
			H.update_body()

/obj/item/organ/tail/cat/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(istype(H))
		H.dna.features["tail_human"] = "None"
		H.dna.species.mutant_bodyparts -= "tail_human"
		color = H.hair_color
		H.update_body()
