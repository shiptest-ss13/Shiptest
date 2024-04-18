/obj/item/organ/moth_wings
	name = "moth wings"
	desc = "A severed pair of moth wings. A moth somewhere is now slightly more useless."
	var/wing_type = "Plain"
	icon_state = "severedwings"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_WINGS

/obj/item/organ/moth_wings/examine(mob/user)
	. = ..()
	. += "They appear to be of the [wing_type] variety."

/obj/item/organ/moth_wings/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
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
		H.dna.species.mutant_bodyparts -= "moth_wings"
		wing_type = H.dna.features["moth_wings"]
		H.update_body()
