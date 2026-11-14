/obj/item/organ/moth_wings
	name = "moth wings"
	desc = "A severed pair of moth wings. A moth somewhere is now slightly more useless."
	var/wing_type = "Plain"
	icon_state = "severedwings"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_WINGS

	///Store our original wings so we can restore them later
	var/original_wings

/obj/item/organ/moth_wings/examine(mob/user)
	. = ..()
	. += "They appear to be of the [wing_type] variety."

/obj/item/organ/moth_wings/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		RegisterSignal(H, COMSIG_HUMAN_BURNING, PROC_REF(try_burn_wings))
		// Checks here are necessary so it wouldn't overwrite the wings of a moth they spawned in
		if(!("moth_wings" in H.dna.species.mutant_bodyparts))
			if(!H.dna.features["moth_wings"])
				H.dna.features["moth_wings"] = wing_type
				H.dna.species.mutant_bodyparts |= "moth_wings"
			else
				H.dna.species.mutant_bodyparts["moth_wings"] = H.dna.features["moth_wings"]
		H.update_body()

/obj/item/organ/moth_wings/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(istype(H))
		UnregisterSignal(H, COMSIG_HUMAN_BURNING, PROC_REF(try_burn_wings))
		H.dna.species.mutant_bodyparts -= "moth_wings"
		wing_type = H.dna.features["moth_wings"]
		H.update_body()

/obj/item/organ/moth_wings/proc/try_burn_wings(mob/living/carbon/human/H, no_protection = FALSE)
	SIGNAL_HANDLER

	if(no_protection) //if the mob is immune to fire, don't burn wings off.
		return
	if(!("moth_wings" in H.dna.species.mutant_bodyparts)) //if they don't have wings, you can't burn em, can ye
		return
	if(H.dna.features["moth_wings"] != "Burnt Off" && H.bodytemperature >= 500 && H.fire_stacks > 0) //do not go into the extremely hot light. you will not survive
		to_chat(H, span_danger("Your precious wings start to char!"))
		burn_wings(H)
		H.dna.species.handle_mutant_bodyparts(H)
	else if(H.dna.features["moth_wings"] == "Burnt Off" && H.bodytemperature >= 800 && H.fire_stacks > 0) //do not go into the extremely hot light. you will not survive
		to_chat(H, span_danger("Your precious wings disintigrate into nothing!"))
		if(/obj/item/organ/moth_wings in H.internal_organs)
			qdel(H.getorganslot(ORGAN_SLOT_WINGS))

/obj/item/organ/moth_wings/proc/burn_wings(mob/living/carbon/human/H)
	original_wings = H.dna.features["moth_wings"]
	H.dna.features["moth_wings"] = "Burnt Off"
