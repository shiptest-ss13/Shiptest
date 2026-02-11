/* Medicines that interface with wounds first and foremost
**
*/

/datum/reagent/medicine/bonefixingjuice
	name = "C4L-Z1UM Agent"
	description = "A peculiar substance capable of instantly regenerating live tissue."
	taste_description = "milk"
	metabolization_rate = 0

/datum/reagent/medicine/bonefixingjuice/on_mob_life(mob/living/M)
	var/mob/living/carbon/C = M
	switch(current_cycle)
		if(1 to 10)
			if(C.drowsyness < 10)
				C.drowsyness += 2
		if(11 to 30)
			C.adjustStaminaLoss(5)
		if(31 to INFINITY)
			C.AdjustSleeping(40)
			//formerly everything-fixing juice
			for(var/datum/wound/blunt/bone/broken_bone in C.all_wounds)
				broken_bone.remove_wound()
			for(var/obj/item/organ/O in C.internal_organs)
				O.damage = 0
			holder.remove_reagent(/datum/reagent/medicine/bonefixingjuice, 10)
	..()
