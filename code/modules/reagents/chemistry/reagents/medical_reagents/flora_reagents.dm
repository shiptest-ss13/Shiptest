/*
** reagents that come from plants
*/

/datum/reagent/medicine/polypyr  //This is intended to be an ingredient in advanced chems.
	name = "Polypyrylium Oligomers"
	description = "A purple mixture of short polyelectrolyte chains not easily synthesized in the laboratory. It is valued as an intermediate in the synthesis of the cutting edge pharmaceuticals."
	reagent_state = SOLID
	color = "#9423FF"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM
	overdose_threshold = 50
	taste_description = "numbing bitterness"
	/// While this reagent is in our bloodstream, we reduce all bleeding by this factor
	var/passive_bleed_modifier = 0.55
	/// For tracking when we tell the person we're no longer bleeding
	var/was_working

/datum/reagent/medicine/polypyr/on_mob_metabolize(mob/living/M)
	ADD_TRAIT(M, TRAIT_COAGULATING, /datum/reagent/medicine/polypyr)
	if(!ishuman(M))
		return

	var/mob/living/carbon/human/blood_boy = M
	blood_boy.physiology?.bleed_mod /= passive_bleed_modifier
	return ..()

/datum/reagent/medicine/polypyr/on_mob_end_metabolize(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_COAGULATING, /datum/reagent/medicine/polypyr)
	//should probably generic proc this at a later point. I'm probably gonna use it a bit
	if(was_working)
		to_chat(M, span_warning("The medicine thickening your blood loses its effect!"))
	if(!ishuman(M))
		return

	var/mob/living/carbon/human/blood_boy = M
	blood_boy.physiology?.bleed_mod /= passive_bleed_modifier

	return ..()


/datum/reagent/medicine/polypyr/on_mob_life(mob/living/carbon/M) //I wanted a collection of small positive effects, this is as hard to obtain as coniine after all.
	M.adjustOrganLoss(ORGAN_SLOT_LUNGS, -0.25)
	M.adjustBruteLoss(-0.5, 0)
	..()
	. = 1

/datum/reagent/medicine/polypyr/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH || method == VAPOR)
		if(M && ishuman(M) && reac_volume >= 0.5)
			var/mob/living/carbon/human/H = M
			H.hair_color = "92f"
			H.facial_hair_color = "92f"
			H.update_hair()

/datum/reagent/medicine/polypyr/overdose_process(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_LUNGS, 0.5)
	..()
	. = 1


/datum/reagent/medicine/puce_essence
	name = "Pucetylline Essence"
	description = "Ground essence of puce crystals."
	reagent_state = SOLID
	color = "#CC8899"
	metabolization_rate = 2.5 * REAGENTS_METABOLISM
	overdose_threshold = 30

/datum/reagent/medicine/puce_essence/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustToxLoss(-1*REM, 0)
	else
		M.adjustCloneLoss(-1*REM, 0)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type, 0.25)
	if(holder.has_reagent(/datum/reagent/medicine/soulus))				// No, you can't chemstack with soulus dust
		holder.remove_reagent(/datum/reagent/medicine/soulus, 5)
	M.add_atom_colour(color, TEMPORARY_COLOUR_PRIORITY)		// Changes color to puce
	..()

/datum/reagent/medicine/puce_essence/expose_atom(atom/A, volume)
	if(!iscarbon(A))
		A.add_atom_colour(color, WASHABLE_COLOUR_PRIORITY)
	..()

/datum/reagent/medicine/puce_essence/on_mob_end_metabolize(mob/living/M)
	M.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, color)		// Removes temporary (not permanent) puce

/datum/reagent/medicine/puce_essence/overdose_process(mob/living/M)
	M.add_atom_colour(color, FIXED_COLOUR_PRIORITY)		// Eternal puce

/datum/reagent/medicine/chartreuse		// C H A R T R E U S E
	name = "Chartreuse Solution"
	description = "Refined essence of puce crystals."
	reagent_state = SOLID
	color = "#DFFF00"
	metabolization_rate = 2.5 * REAGENTS_METABOLISM
	overdose_threshold = 30

/datum/reagent/medicine/chartreuse/on_mob_life(mob/living/carbon/M)		// Yes, you can chemstack with soulus dust
	if(prob(80))
		M.adjustToxLoss(-2*REM, 0)
		M.adjustCloneLoss(-1*REM, 0)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type, 1)
	M.add_atom_colour(color, TEMPORARY_COLOUR_PRIORITY)		// Changes color to chartreuse
	..()

/datum/reagent/medicine/chartreuse/expose_atom(atom/A, volume)
	if(!iscarbon(A))
		A.add_atom_colour(color, WASHABLE_COLOUR_PRIORITY)
	..()

/datum/reagent/medicine/chartreuse/on_mob_end_metabolize(mob/living/M)
	M.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, color)		// Removes temporary (not permanent) chartreuse

/datum/reagent/medicine/chartreuse/overdose_process(mob/living/M)
	M.add_atom_colour(color, FIXED_COLOUR_PRIORITY)		// Eternal chartreuse
	M.set_drugginess(15)		// Also druggy
	..()


/datum/reagent/medicine/earthsblood //Created by ambrosia gaia plants
	name = "Earthsblood"
	description = "Ichor from an extremely powerful plant. Great for restoring wounds, but it's a little heavy on the brain. For some strange reason, it also induces temporary pacifism in those who imbibe it and semi-permanent pacifism in those who overdose on it."
	color = "#FFAF00"
	metabolization_rate = 0.4 //Math is based on specific metab rate so we want this to be static AKA if define or medicine metab rate changes, we want this to stay until we can rework calculations.
	overdose_threshold = 25

/datum/reagent/medicine/earthsblood/on_mob_life(mob/living/carbon/M)
	if(current_cycle <= 25) //10u has to be processed before u get into THE FUN ZONE
		M.adjustBruteLoss(-1 * REM, 0)
		M.adjustFireLoss(-1 * REM, 0)
		M.adjustOxyLoss(-0.5 * REM, 0)
		M.adjustToxLoss(-0.5 * REM, 0)
		M.adjustCloneLoss(-0.1 * REM, 0)
		M.adjustStaminaLoss(-0.5 * REM, 0)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1 * REM, 150) //This does, after all, come from ambrosia, and the most powerful ambrosia in existence, at that!
	else
		M.adjustBruteLoss(-5 * REM, 0) //slow to start, but very quick healing once it gets going
		M.adjustFireLoss(-5 * REM, 0)
		M.adjustOxyLoss(-3 * REM, 0)
		M.adjustToxLoss(-3 * REM, 0)
		M.adjustCloneLoss(-1 * REM, 0)
		M.adjustStaminaLoss(-3 * REM, 0)
		M.adjust_timed_status_effect(3 SECONDS, /datum/status_effect/jitter, 30 SECONDS)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2 * REM, 150)
	M.druggy = min(max(0, M.druggy + 10), 15) //See above
	..()
	. = 1

/datum/reagent/medicine/earthsblood/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_PACIFISM, type)

/datum/reagent/medicine/earthsblood/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_PACIFISM, type)
	..()

/datum/reagent/medicine/earthsblood/overdose_process(mob/living/M)
	M.hallucination = min(max(0, M.hallucination + 5), 60)
	if(current_cycle > 25)
		M.adjustToxLoss(4 * REM, 0)
		if(current_cycle > 100) //podpeople get out reeeeeeeeeeeeeeeeeeeee
			M.adjustToxLoss(6 * REM, 0)
	if(iscarbon(M))
		var/mob/living/carbon/hippie = M
		hippie.gain_trauma(/datum/brain_trauma/severe/pacifism)
	..()
	. = 1

//Earthsblood is still a wonderdrug. Just... don't expect to be able to mutate something that makes plants so healthy.
/datum/reagent/medicine/earthsblood/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 1))
		mytray.adjustPests(-rand(1,3))
		mytray.adjustWeeds (-rand(1,3))
		if(myseed)
			myseed.adjust_instability(-round(chems.get_reagent_amount(type) * 1.3))
			myseed.adjust_potency(round(chems.get_reagent_amount(type)))
			myseed.adjust_yield(round(chems.get_reagent_amount(type)))
			myseed.adjust_endurance(round(chems.get_reagent_amount(type) * 0.5))
			myseed.adjust_production(-round(chems.get_reagent_amount(type) * 0.5))

/datum/reagent/medicine/neoxanthin
	name = "Neoxanthin"
	description = "A naturally occuring carotenoid found in several varieties of plants. Has mild antioxidant properties."
	reagent_state = SOLID
	color = "#CC8899"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM
	overdose_threshold = 30

/datum/reagent/medicine/neoxanthin/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustToxLoss(-1*REM, 0)
	..()

/datum/reagent/medicine/neoxanthin/overdose_process(mob/living/carbon/M)
	if(prob(30))
		M.vomit()
	..()
