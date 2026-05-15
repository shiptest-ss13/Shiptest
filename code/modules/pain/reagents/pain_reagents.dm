


// Ibuprofen. Best at headaches, best at fevers, less good at everything else.
// Use for treating head pain primarily.
/datum/reagent/medicine/painkiller/ibuprofen // Also known as Advil
	name = "Ibuprofen"
	description = "A medication that combats mild pain, headaches, and fever. Causes mild nausea and dizziness in higher dosages. Overdosing causes sickness, drowsiness, dizziness, and mild pain."
	reagent_state = LIQUID
	color = "#e695ff"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30
	pain_modifier = 0.6

/datum/reagent/medicine/painkiller/ibuprofen/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// Really good at treating headaches.
	M.adjustBruteLoss(-0.05 * REM * delta_time, FALSE)
	M.adjustToxLoss(-0.1 * REM * delta_time, FALSE)
	// Heals pain, numbers seem low but our metabolism is very slow
	M.cause_pain(BODY_ZONE_HEAD, -0.08 * REM * delta_time)
	M.cause_pain(BODY_ZONE_CHEST, -0.04 * REM * delta_time)
	M.cause_pain(BODY_ZONES_LIMBS, -0.02 * REM * delta_time)
	// Causes flat liver damage.
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 0.25 * REM * delta_time)
	// Really good at treating fevers.
	M.adjust_bodytemperature(-25 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * delta_time, M.get_body_temp_normal())
	// Causes more disgust the longer it's in someone...
	if(M.disgust < DISGUST_LEVEL_VERYGROSS && SPT_PROB(66 * max(1 - creation_purity, 0.5), delta_time))
		M.adjust_disgust(min(current_cycle * 0.02, 2.4) * REM * delta_time)
	// ...and dizziness.
	if(current_cycle >= 25 && SPT_PROB(30 * max(1 - creation_purity, 0.5), delta_time))
		M.dizziness = clamp(M.dizziness + (1 * REM * delta_time), 0, 5)

	..()
	return TRUE

/datum/reagent/medicine/painkiller/ibuprofen/overdose_process(mob/living/carbon/M, delta_time, times_fired)
	if(!istype(M))
		return

	// On overdose, causes liver damage and chest pain...
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 1.5 * REM * delta_time)
	M.cause_pain(BODY_ZONE_CHEST, 0.24 * REM * delta_time)
	// Sickness...
	if(M.disgust < 100 && SPT_PROB(100 * max(1 - creation_purity, 0.5), delta_time))
		M.adjust_disgust(3 * REM * delta_time)
	// ...Drowsyness...
	if(SPT_PROB(75 * max(1 - creation_purity, 0.5), delta_time))
		M.drowsyness += 1 * REM * delta_time
	// ...And dizziness
	if(SPT_PROB(85 * max(1 - creation_purity, 0.5), delta_time))
		M.dizziness += 2 * REM * delta_time

	return ..()

// Combination drug of other painkillers. It's a real thing. Less side effects, heals pain generally, mildly toxic in high doses.
// Upgrade to paracetamol and aspirin if you go through the effort to get coffee.
/datum/reagent/medicine/painkiller/aspirin_para_coffee
	name = "aspirin/paracetamol/caffeine"
	description = "A combination drug that effectively treats moderate pain with low side effects when used in low dosage. Toxic in higher dosages."
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	color = "#e695ff"
	metabolization_rate = REAGENTS_METABOLISM
	pain_modifier = 0.75
	harmful = TRUE

/datum/reagent/medicine/painkiller/aspirin_para_coffee/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// Heals all pain a bit if in low dosage.
	if(volume <= 10)
		// Number looks high, compared to other painkillers,
		// but we have a comparatively much higher metabolism than them.
		M.cause_pain(BODY_ZONES_ALL, -0.8 * REM * delta_time)
	// Mildly toxic in higher dosages.
	else if(SPT_PROB(volume * 3, delta_time))
		M.apply_damage(3 * REM * delta_time, TOX)
		. = TRUE

	..()

// Future painkiller ideas:
// - Real world stuff
// Tramadol
// Fentanyl (Rework) (Also a potential anesthetic)
// Hydrocodone (And its combination drugs)
// Dihydromorphine
// Pethidine
// - Space stuff (Suffix: -fen)



// Libital, but helps pain: ib-alti-fen
// Heals lots of pain for bruise pain, otherwise lower
/datum/reagent/medicine/painkiller/specialized/ibaltifen
	name = "Ibaltifen"
	description = "A painkiller designed to combat pain caused by broken limbs and bruises."
	reagent_state = LIQUID
	color = "#feffae"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	pain_modifier = 0.75
	pain_type_to_look_for = BRUTE
	wound_type_to_look_for = /datum/wound/blunt

/datum/reagent/medicine/painkiller/specialized/ibaltifen/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// a bit of libital influence
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 0.5 * REM * delta_time)
	M.adjustBruteLoss(-0.5 * REM * normalise_creation_purity() * delta_time)
	..()
	return TRUE

// Aiuri, but helps pain: an-uri-fen
// Heals lots of pain for burn pain, otherwise lower
/datum/reagent/medicine/painkiller/specialized/anurifen
	name = "Anurifen"
	description = "A painkiller designed to combat pain caused by burns."
	reagent_state = LIQUID
	color = "#c4aeff"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	pain_modifier = 0.75
	pain_type_to_look_for = BURN
	wound_type_to_look_for = /datum/wound/burn

/datum/reagent/medicine/painkiller/specialized/anurifen/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// a bit of aiuri influence
	M.adjustOrganLoss(ORGAN_SLOT_EYES, 0.4 * REM * delta_time)
	M.adjustFireLoss(-0.5 * REM * normalise_creation_purity() * delta_time)
	..()
	return TRUE
