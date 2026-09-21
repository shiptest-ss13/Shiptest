/* Reagents that primarily interface with blood and bleeding
** chitosan I guess
*/


// helps bleeding wounds clot faster
/datum/reagent/medicine/chitosan
	name = "Chitosan"
	description = "Vastly improves the blood's natural ability to coagulate and stop bleeding by hightening platelet production and effectiveness. Overdosing will cause extreme blood clotting, resulting in potential brain damage."
	reagent_state = LIQUID
	color = "#bb2424"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 20
	/// The bloodiest wound that the patient has will have its blood_flow reduced by this much each second
	var/clot_rate = 0.15
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

/datum/reagent/medicine/chitosan/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
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
		bloodiest_wound.blood_flow = max(0, bloodiest_wound.blood_flow - (clot_rate * seconds_per_tick))
	else if(was_working)
		was_working = FALSE

/datum/reagent/medicine/chitosan/overdose_process(mob/living/carbon/M, seconds_per_tick, times_fired)
	. = ..()
	if(!M.blood_volume)
		return

	if(SPT_PROB(7.5, seconds_per_tick))
		M.losebreath += rand(1 * seconds_per_tick, 2 * seconds_per_tick)
		M.adjustOxyLoss(rand(0.5 * seconds_per_tick, 1.5 * seconds_per_tick))
		if(SPT_PROB(15, seconds_per_tick))
			to_chat(M, span_danger("You can feel your blood clotting up in your veins!"))
		else if(SPT_PROB(5, seconds_per_tick))
			to_chat(M, span_userdanger("You feel like your blood has stopped moving!"))
			M.adjustOxyLoss(rand(1 * seconds_per_tick, 2 * seconds_per_tick))

		if(SPT_PROB(30, seconds_per_tick))
			var/obj/item/organ/lungs/our_lungs = M.getorganslot(ORGAN_SLOT_LUNGS)
			our_lungs.applyOrganDamage(0.5 * seconds_per_tick)
		else if(SPT_PROB(13, seconds_per_tick))
			var/obj/item/organ/lungs/our_brain = M.getorganslot(ORGAN_SLOT_BRAIN)
			our_brain.applyOrganDamage(0.5 * seconds_per_tick)
		else
			var/obj/item/organ/heart/our_heart = M.getorganslot(ORGAN_SLOT_HEART)
			our_heart.applyOrganDamage(0.5 * seconds_per_tick)

/datum/reagent/medicine/salglu_solution
	name = "Saline-Glucose Solution"
	description = "Has a 33% chance per metabolism cycle to heal brute and burn damage. Can be used as a temporary blood substitute."
	reagent_state = LIQUID
	color = "#DCDCDC"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 60
	taste_description = "sweetness and salt"
	var/last_added = 0
	var/maximum_reachable = BLOOD_VOLUME_NORMAL - 10	//So that normal blood regeneration can continue with salglu active
	var/extra_regen = 0.125 // in addition to acting as temporary blood, also add this much to their actual blood per second

/datum/reagent/medicine/salglu_solution/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	if(last_added)
		M.blood_volume -= last_added
		last_added = 0
	if(M.blood_volume < maximum_reachable)	//Can only up to double your effective blood level.
		var/amount_to_add = min(M.blood_volume, volume*2.5*seconds_per_tick)
		var/new_blood_level = min(M.blood_volume + amount_to_add, maximum_reachable)
		last_added = new_blood_level - M.blood_volume
		M.blood_volume = new_blood_level + (extra_regen * seconds_per_tick)
	if(SPT_PROB(18, seconds_per_tick))
		M.adjustBruteLoss(-0.25 * REM * seconds_per_tick, 0)
		M.adjustFireLoss(-0.25 * REM * seconds_per_tick, 0)
		. = TRUE
	..()

/datum/reagent/medicine/salglu_solution/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	if(SPT_PROB(1.5, seconds_per_tick))
		to_chat(M, span_warning("You feel salty."))
		holder.add_reagent(/datum/reagent/consumable/sodiumchloride, 1)
		holder.remove_reagent(/datum/reagent/medicine/salglu_solution, 0.5)
	else if(SPT_PROB(1.5, seconds_per_tick))
		to_chat(M, span_warning("You feel sweet."))
		holder.add_reagent(/datum/reagent/consumable/sugar, 1)
		holder.remove_reagent(/datum/reagent/medicine/salglu_solution, 0.5)
	if(SPT_PROB(17, seconds_per_tick))
		M.adjustBruteLoss(0.25 * REM * seconds_per_tick, FALSE, FALSE, BODYTYPE_ORGANIC)
		M.adjustFireLoss(0.5 * REM * seconds_per_tick, FALSE, FALSE, BODYTYPE_ORGANIC)
		. = TRUE
	..()
