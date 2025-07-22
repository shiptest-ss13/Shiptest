/* Reagents that primarily interface with blood and bleeding
** chitosan I guess
*/


// helps bleeding wounds clot faster
/datum/reagent/medicine/chitosan
	name = "chitosan"
	description = "Vastly improves the blood's natural ability to coagulate and stop bleeding by hightening platelet production and effectiveness. Overdosing will cause extreme blood clotting, resulting in potential brain damage."
	reagent_state = LIQUID
	color = "#bb2424"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 20
	/// The bloodiest wound that the patient has will have its blood_flow reduced by this much each tick
	var/clot_rate = 0.3
	/// While this reagent is in our bloodstream, we reduce all bleeding by this factor
	var/passive_bleed_modifier = 0.7
	/// For tracking when we tell the person we're no longer bleeding
	var/was_working

/datum/reagent/medicine/chitosan/on_mob_metabolize(mob/living/M)
	ADD_TRAIT(M, TRAIT_COAGULATING, /datum/reagent/medicine/chitosan)

	if(!ishuman(M))
		return

	var/mob/living/carbon/human/blood_boy = M
	blood_boy.physiology?.bleed_mod *= passive_bleed_modifier
	return ..()

/datum/reagent/medicine/chitosan/on_mob_end_metabolize(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_COAGULATING, /datum/reagent/medicine/chitosan)

	if(was_working)
		to_chat(M, span_warning("The medicine thickening your blood loses its effect!"))
	if(!ishuman(M))
		return

	var/mob/living/carbon/human/blood_boy = M
	blood_boy.physiology?.bleed_mod /= passive_bleed_modifier

	return ..()

/datum/reagent/medicine/chitosan/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(!M.blood_volume || !M.all_wounds)
		return

	var/datum/wound/bloodiest_wound

	for(var/i in M.all_wounds)
		var/datum/wound/iter_wound = i
		if(iter_wound.blood_flow)
			if(iter_wound.blood_flow > bloodiest_wound?.blood_flow)
				bloodiest_wound = iter_wound

	if(bloodiest_wound)
		if(!was_working)
			to_chat(M, span_green("You can feel your flowing blood start thickening!"))
			was_working = TRUE
		bloodiest_wound.blood_flow = max(0, bloodiest_wound.blood_flow - clot_rate)
	else if(was_working)
		was_working = FALSE

/datum/reagent/medicine/chitosan/overdose_process(mob/living/carbon/M)
	. = ..()
	if(!M.blood_volume)
		return

	if(prob(15))
		M.losebreath += rand(2,4)
		M.adjustOxyLoss(rand(1,3))
		if(prob(30))
			to_chat(M, span_danger("You can feel your blood clotting up in your veins!"))
		else if(prob(10))
			to_chat(M, span_userdanger("You feel like your blood has stopped moving!"))
			M.adjustOxyLoss(rand(3,4))

		if(prob(50))
			var/obj/item/organ/lungs/our_lungs = M.getorganslot(ORGAN_SLOT_LUNGS)
			our_lungs.applyOrganDamage(1)
		else if(prob(25))
			var/obj/item/organ/lungs/our_brain = M.getorganslot(ORGAN_SLOT_BRAIN)
			our_brain.applyOrganDamage(1)
		else
			var/obj/item/organ/heart/our_heart = M.getorganslot(ORGAN_SLOT_HEART)
			our_heart.applyOrganDamage(1)
