#define PERF_BASE_DAMAGE 0.5

//////////////////////////////////////////////////////////////////////////////////////////
					// MEDICINE REAGENTS
//////////////////////////////////////////////////////////////////////////////////////




/datum/reagent/medicine/cryoxadone
	name = "Cryoxadone"
	description = "A chemical mixture with almost magical healing powers. Its main limitation is that the patient's body temperature must be under 270K for it to metabolise correctly."
	color = "#0000C8"
	taste_description = "sludge"

/datum/reagent/medicine/cryoxadone/on_mob_life(mob/living/carbon/M)
	var/power = -0.00003 * (M.bodytemperature ** 2) + 3
	if(M.bodytemperature < T0C)
		M.adjustOxyLoss(-3 * power, 0)
		M.adjustBruteLoss(-power, 0)
		M.adjustFireLoss(-power, 0)
		M.adjustToxLoss(-power, 0, TRUE) //heals TOXINLOVERs
		M.adjustCloneLoss(-power, 0)
		for(var/i in M.all_wounds)
			var/datum/wound/iter_wound = i
			iter_wound.on_xadone(power)
		REMOVE_TRAIT(M, TRAIT_DISFIGURED, TRAIT_GENERIC) //fixes common causes for disfiguration
		. = 1
	metabolization_rate = REAGENTS_METABOLISM * (0.00001 * (M.bodytemperature ** 2) + 0.5)
	..()







/datum/reagent/medicine/ephedrine
	name = "Ephedrine"
	description = "Increases stun resistance and movement speed, giving you hand cramps. Overdose deals toxin damage and inhibits breathing."
	reagent_state = LIQUID
	color = "#D2FFFA"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 30
	addiction_threshold = 25

/datum/reagent/medicine/ephedrine/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/ephedrine)
	ADD_TRAIT(L, TRAIT_STUNRESISTANCE, type)

/datum/reagent/medicine/ephedrine/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/ephedrine)
	REMOVE_TRAIT(L, TRAIT_STUNRESISTANCE, type)
	..()

/datum/reagent/medicine/ephedrine/on_mob_life(mob/living/carbon/M)
	if(prob(20) && iscarbon(M))
		var/obj/item/I = M.get_active_held_item()
		if(I && M.dropItemToGround(I))
			to_chat(M, span_notice("Your hands spaz out and you drop what you were holding!"))
			M.set_timed_status_effect(20 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)

	M.AdjustAllImmobility(-20)
	M.adjustStaminaLoss(-1*REM, FALSE)
	..()
	return TRUE

/datum/reagent/medicine/ephedrine/overdose_process(mob/living/M)
	if(prob(2) && iscarbon(M))
		var/datum/disease/D = new /datum/disease/heart_failure
		M.ForceContractDisease(D)
		to_chat(M, span_userdanger("You're pretty sure you just felt your heart stop for a second there.."))
		M.playsound_local(M, 'sound/effects/singlebeat.ogg', 100, 0)

	if(prob(7))
		to_chat(M, span_notice("[pick("Your head pounds.", "You feel a tight pain in your chest.", "You find it hard to stay still.", "You feel your heart practically beating out of your chest.")]"))

	if(prob(33))
		M.adjustToxLoss(1*REM, 0)
		M.losebreath++
		. = 1
	return TRUE

/datum/reagent/medicine/ephedrine/addiction_act_stage1(mob/living/M)
	if(prob(3) && iscarbon(M))
		M.visible_message(span_danger("[M] starts having a seizure!"), span_userdanger("You have a seizure!"))
		M.Unconscious(100)
		M.set_timed_status_effect(120 SECONDS, /datum/status_effect/jitter)

	if(prob(33))
		M.adjustToxLoss(2*REM, 0)
		M.losebreath += 2
		. = 1
	..()

/datum/reagent/medicine/ephedrine/addiction_act_stage2(mob/living/M)
	if(prob(6) && iscarbon(M))
		M.visible_message(span_danger("[M] starts having a seizure!"), span_userdanger("You have a seizure!"))
		M.Unconscious(100)
		M.set_timed_status_effect(240 SECONDS, /datum/status_effect/jitter)

	if(prob(33))
		M.adjustToxLoss(3*REM, 0)
		M.losebreath += 3
		. = 1
	..()

/datum/reagent/medicine/ephedrine/addiction_act_stage3(mob/living/M)
	if(prob(12) && iscarbon(M))
		M.visible_message(span_danger("[M] starts having a seizure!"), span_userdanger("You have a seizure!"))
		M.Unconscious(100)
		M.set_timed_status_effect(300 SECONDS, /datum/status_effect/jitter)

	if(prob(33))
		M.adjustToxLoss(4*REM, 0)
		M.losebreath += 4
		. = 1
	..()

/datum/reagent/medicine/ephedrine/addiction_act_stage4(mob/living/M)
	if(prob(24) && iscarbon(M))
		M.visible_message(span_danger("[M] starts having a seizure!"), span_userdanger("You have a seizure!"))
		M.Unconscious(100)
		M.set_timed_status_effect(300 SECONDS, /datum/status_effect/jitter)

	if(prob(33))
		M.adjustToxLoss(5*REM, 0)
		M.losebreath += 5
		. = 1
	..()





/datum/reagent/medicine/stimulants
	name = "Indoril"
	description = "Increases stun resistance and movement speed in addition to restoring minor damage and weakness. Overdose causes weakness and toxin damage."
	color = "#78008C"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 60

/datum/reagent/medicine/stimulants/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)
	ADD_TRAIT(L, TRAIT_STUNRESISTANCE, type)

/datum/reagent/medicine/stimulants/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants)
	REMOVE_TRAIT(L, TRAIT_STUNRESISTANCE, type)
	..()

/datum/reagent/medicine/stimulants/on_mob_life(mob/living/carbon/M)
	if(M.health < 50 && M.health > 0)
		M.adjustOxyLoss(-1*REM, 0)
		M.adjustToxLoss(-1*REM, 0)
		M.adjustBruteLoss(-1*REM, 0)
		M.adjustFireLoss(-1*REM, 0)
	M.AdjustAllImmobility(-60)
	M.adjustStaminaLoss(-5*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/stimulants/overdose_process(mob/living/M)
	if(prob(33))
		M.adjustStaminaLoss(2.5*REM, 0)
		M.adjustToxLoss(1*REM, 0)
		M.losebreath++
		. = 1
	..()

/datum/reagent/medicine/insulin
	name = "Insulin"
	description = "Increases sugar depletion rates."
	reagent_state = LIQUID
	color = "#FFFFF0"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/insulin/on_mob_life(mob/living/carbon/M)
	if(M.AdjustSleeping(-20))
		. = 1
	M.reagents.remove_reagent(/datum/reagent/consumable/sugar, 3)
	..()


/datum/reagent/medicine/bicaridine/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-0.5*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/bicaridine/overdose_process(mob/living/M)
	M.adjustBruteLoss(2*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
	..()
	. = 1

/datum/reagent/medicine/bicaridinep
	name = "Bicaridine Plus"
	description = "Restores bruising and slowly stems bleeding. Overdose causes it instead. More effective than standardized Bicaridine."
	reagent_state = LIQUID
	color = "#bf0000"
	overdose_threshold = 25

/datum/reagent/medicine/bicaridinep/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-2*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/bicaridinep/overdose_process(mob/living/M)
	M.adjustBruteLoss(6*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
	..()
	. = 1

/datum/reagent/medicine/dexalin
	name = "Dexalin"
	description = "Restores oxygen loss. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#0080FF"
	overdose_threshold = 30

/datum/reagent/medicine/dexalin/on_mob_life(mob/living/carbon/M)
	M.adjustOxyLoss(-0.5*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/dexalin/overdose_process(mob/living/M)
	M.adjustOxyLoss(2*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/dexalinp
	name = "Dexalin Plus"
	description = "Restores oxygen loss and purges Lexorin. Overdose causes it instead. More effective than standardized Dexalin."
	reagent_state = LIQUID
	color = "#0040FF"
	overdose_threshold = 25

/datum/reagent/medicine/dexalinp/on_mob_life(mob/living/carbon/M)
	M.adjustOxyLoss(-2*REM, 0)
	if(ishuman(M) && M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume += 1
	if(holder.has_reagent(/datum/reagent/toxin/lexorin))
		holder.remove_reagent(/datum/reagent/toxin/lexorin, 3)
	..()
	. = 1

/datum/reagent/medicine/dexalinp/overdose_process(mob/living/M)
	M.adjustOxyLoss(6*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/kelotane
	name = "Kelotane"
	description = "Heals burn damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#FFa800"
	overdose_threshold = 30

/datum/reagent/medicine/kelotane/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-0.5*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/kelotane/overdose_process(mob/living/M)
	M.adjustFireLoss(2*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
	..()
	. = 1

/datum/reagent/medicine/dermaline
	name = "Dermaline"
	description = "Heals burn damage. Overdose causes it instead. Superior to standardized Kelotane in healing capacity."
	reagent_state = LIQUID
	color = "#FF8000"
	overdose_threshold = 25

/datum/reagent/medicine/dermaline/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-2*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/dermaline/overdose_process(mob/living/M)
	M.adjustFireLoss(6*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
	..()
	. = 1

/datum/reagent/medicine/antitoxin
	name = "Dylovene"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#00a000"
	overdose_threshold = 30
	taste_description = "a roll of gauze"

/datum/reagent/medicine/antitoxin/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-0.5*REM, 0)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,1)
	..()
	. = 1

/datum/reagent/medicine/antitoxin/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustToxic(-round(chems.get_reagent_amount(type) * 2))

/datum/reagent/medicine/antitoxin/overdose_process(mob/living/M)
	M.adjustToxLoss(2*REM, 0) // End result is 1.5 toxin loss taken, because it heals 0.5 and then removes 2.
	..()
	. = 1

/datum/reagent/medicine/inaprovaline
	name = "Inaprovaline"
	description = "Stabilizes the breathing of patients. Good for those in critical condition."
	reagent_state = LIQUID
	color = "#A4D8D8"

/datum/reagent/medicine/inaprovaline/on_mob_life(mob/living/carbon/M)
	if(M.losebreath >= 5)
		M.losebreath -= 5
	..()

/datum/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	description = "A weak dilutant that slowly heals brute, burn, and toxin damage."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "water that has been standing still in a glass on a counter overnight"

/datum/reagent/medicine/tricordrazine/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustBruteLoss(-0.25*REM, 0)
		M.adjustFireLoss(-0.25*REM, 0)
		M.adjustToxLoss(-0.25*REM, 0)
		. = 1
	..()
/datum/reagent/medicine/tetracordrazine //WS edit: Yes
	name = "Tetracordrazine"
	description = "A weak dilutant similar to Tricordrazine that slowly heals all damage types."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "bottled water that has been sitting out in the sun with a single chili flake in it"

/datum/reagent/medicine/tetracordrazine/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustBruteLoss(-0.25*REM, 0)
		M.adjustFireLoss(-0.25*REM, 0)
		M.adjustToxLoss(-0.25*REM, 0)
		M.adjustOxyLoss(-0.5*REM, 0)
		. = 1
	..()

/datum/reagent/medicine/regen_jelly
	name = "Regenerative Jelly"
	description = "Gradually regenerates all types of damage, without harming slime anatomy."
	reagent_state = LIQUID
	color = "#CC23FF"
	taste_description = "jelly"

/datum/reagent/medicine/regen_jelly/expose_mob(mob/living/M, reac_volume)
	if(M && ishuman(M) && reac_volume >= 0.5)
		var/mob/living/carbon/human/H = M
		H.hair_color = "C2F"
		H.facial_hair_color = "C2F"
		H.update_hair()

/datum/reagent/medicine/regen_jelly/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-1.5*REM, 0)
	M.adjustFireLoss(-1.5*REM, 0)
	M.adjustOxyLoss(-1.5*REM, 0)
	M.adjustToxLoss(-1.5*REM, 0, TRUE) //heals TOXINLOVERs
	..()
	. = 1

/datum/reagent/medicine/syndicate_nanites //Used exclusively by Syndicate medical cyborgs
	name = "Restorative Nanites"
	description = "Miniature medical robots that swiftly restore bodily damage."
	reagent_state = SOLID
	color = "#555555"
	overdose_threshold = 30
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs //WS Edit - IPCs

/datum/reagent/medicine/syndicate_nanites/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-5*REM, 0) //A ton of healing - this is a 50 telecrystal investment.
	M.adjustFireLoss(-5*REM, 0)
	M.adjustOxyLoss(-15, 0)
	M.adjustToxLoss(-5*REM, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -15*REM)
	M.adjustCloneLoss(-3*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/syndicate_nanites/overdose_process(mob/living/carbon/M) //wtb flavortext messages that hint that you're vomitting up robots
	if(prob(25))
		M.reagents.remove_reagent(type, metabolization_rate*15) // ~5 units at a rate of 0.4 but i wanted a nice number in code
		M.vomit(20) // nanite safety protocols make your body expel them to prevent harmies
	..()
	. = 1


/datum/reagent/medicine/haloperidol
	name = "Haloperidol"
	description = "Increases depletion rates for most stimulating/hallucinogenic drugs. Reduces druggy effects and jitteriness. Severe stamina regeneration penalty, causes drowsiness. Small chance of brain damage."
	reagent_state = LIQUID
	color = "#27870a"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM



/*	WS edit begin - Lavaland rework
/datum/reagent/medicine/lavaland_extract
	name = "Lavaland Extract"
	description = "An extract of lavaland atmospheric and mineral elements. Heals the user in small doses, but is extremely toxic otherwise."
	color = "#6B372E" //dark and red like lavaland
	overdose_threshold = 3 //To prevent people stacking massive amounts of a very strong healing reagent
	can_synth = FALSE

/datum/reagent/medicine/lavaland_extract/on_mob_life(mob/living/carbon/M)
	M.heal_bodypart_damage(5,5)
	..()
	return TRUE

/datum/reagent/medicine/lavaland_extract/overdose_process(mob/living/M)
	M.adjustBruteLoss(3*REM, 0, FALSE, BODYTYPE_ORGANIC)
	M.adjustFireLoss(3*REM, 0, FALSE, BODYTYPE_ORGANIC)
	M.adjustToxLoss(3*REM, 0)
	..()
	return TRUE
*/		//WS edit end

