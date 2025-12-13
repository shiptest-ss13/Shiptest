/* reagents that primarily interface with organ damage.
** Things like oculine, incausiate
*/


/datum/reagent/medicine/oculine
	name = "Oculine"
	description = "Quickly restores eye damage, cures nearsightedness, and has a chance to restore vision to the blind."
	reagent_state = LIQUID
	color = "#404040" //oculine is dark grey,
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "dull toxin"

/datum/reagent/medicine/oculine/on_mob_life(mob/living/carbon/M)
	var/obj/item/organ/eyes/eyes = M.getorganslot(ORGAN_SLOT_EYES)
	if (!eyes)
		return
	eyes.applyOrganDamage(-2)
	if(HAS_TRAIT_FROM(M, TRAIT_BLIND, EYE_DAMAGE))
		if(prob(20))
			to_chat(M, span_warning("Your vision slowly returns..."))
			M.cure_blind(EYE_DAMAGE)
			M.cure_nearsighted(EYE_DAMAGE)
			M.blur_eyes(35)

	else if(HAS_TRAIT_FROM(M, TRAIT_NEARSIGHT, EYE_DAMAGE))
		to_chat(M, span_warning("The blackness in your peripheral vision fades."))
		M.cure_nearsighted(EYE_DAMAGE)
		M.blur_eyes(10)
	else if(M.eye_blind || M.eye_blurry)
		M.set_blindness(0)
		M.set_blurriness(0)
	..()

/datum/reagent/medicine/inacusiate
	name = "Inacusiate"
	description = "Rapidly restores hearing to a patient, assuming the loss of hearing is not chronic."
	color = "#606060" //inacusiate is light grey

/datum/reagent/medicine/inacusiate/on_mob_life(mob/living/carbon/M)
	var/obj/item/organ/ears/ears = M.getorganslot(ORGAN_SLOT_EARS)
	if(!ears)
		return
	ears.adjustEarDamage(-4 * REM)
	return ..()

/datum/reagent/medicine/mannitol
	name = "Mannitol"
	description = "Efficiently restores brain damage."
	color = "#A0A0A0" //mannitol is light grey, neurine is lighter grey

/datum/reagent/medicine/mannitol/on_mob_life(mob/living/carbon/C)
	C.adjustOrganLoss(ORGAN_SLOT_BRAIN, -2*REM)
	..()

/datum/reagent/medicine/neurine
	name = "Neurine"
	description = "Reacts with neural tissue, helping reform damaged connections. Can cure minor traumas."
	color = "#C0C0C0" //ditto

/datum/reagent/medicine/neurine/on_mob_life(mob/living/carbon/C)
	if(holder.has_reagent(/datum/reagent/consumable/ethanol/neurotoxin))
		holder.remove_reagent(/datum/reagent/consumable/ethanol/neurotoxin, 5)
	if(prob(15))
		C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)
	..()

/datum/reagent/medicine/corazone
	// Heart attack code will not do damage if corazone is present
	// because it's SPACE MAGIC ASPIRIN
	name = "Corazone"
	description = "A medication used to treat pain, fever, and inflammation, along with heart attacks. Can also be used to stabilize livers."
	color = "#F49797"
	self_consuming = TRUE

/datum/reagent/medicine/corazone/on_mob_metabolize(mob/living/M)
	..()
	ADD_TRAIT(M, TRAIT_PAIN_RESIST, type)
	ADD_TRAIT(M, TRAIT_STABLEHEART, type)
	ADD_TRAIT(M, TRAIT_STABLELIVER, type)

/datum/reagent/medicine/corazone/on_mob_end_metabolize(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_PAIN_RESIST, type)
	REMOVE_TRAIT(M, TRAIT_STABLEHEART, type)
	REMOVE_TRAIT(M, TRAIT_STABLELIVER, type)

/datum/reagent/medicine/silibinin
	name = "Silibinin"
	description = "A thistle derrived hepatoprotective flavolignan mixture that help reverse damage to the liver."
	reagent_state = SOLID
	color = "#FFFFD0"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/silibinin/expose_mob(mob/living/carbon/M, method=INJECT, reac_volume)
	if(method != INJECT)
		return

	M.adjustOrganLoss(ORGAN_SLOT_LIVER, -1)  //on injection, will heal the liver. This will (hopefully) fix dead livers.

	..()

/datum/reagent/medicine/silibinin/on_mob_life(mob/living/carbon/M)
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, -2)//Add a chance to cure liver trauma once implemented.
	..()
	. = 1



/*
*How this medicine works:
*Penthrite if you are not in crit only stabilizes your heart.
*As soon as you pass crit threshold it's special effects kick in. Penthrite forces your heart to beat preventing you from entering
*soft and hard crit, but there is a catch. During this you will be healed and you will sustain
*heart damage that will not imapct you as long as penthrite is in your system.
*If you reach the threshold of -60 HP penthrite stops working and you get a heart attack, penthrite is flushed from your system in that very moment,
*causing you to loose your soft crit, hard crit and heart stabilization effects.
*Overdosing on penthrite also causes a heart failure.
*/

/datum/reagent/medicine/penthrite
	name = "Penthrite"
	description = "An expensive medicine that aids with pumping blood around the body even without a heart, and prevents the heart from slowing down. It reacts violently with other emergency medication."
	color = "#F5F5F5"
	overdose_threshold = 50


/datum/reagent/medicine/penthrite/on_mob_add(mob/living/M)
	. = ..()
	to_chat(M,"<span class='notice'>Your heart begins to beat with great force!")
	ADD_TRAIT(M, TRAIT_STABLEHEART, type)
	ADD_TRAIT(M, TRAIT_NOHARDCRIT,type)
	ADD_TRAIT(M, TRAIT_NOSOFTCRIT,type)
	M.crit_threshold = M.crit_threshold + HEALTH_THRESHOLD_FULLCRIT*2 //your heart is still pumping!


/datum/reagent/medicine/penthrite/on_mob_life(mob/living/carbon/human/H)
	H.adjustOrganLoss(ORGAN_SLOT_STOMACH,0.25)
	if(H.health <= HEALTH_THRESHOLD_CRIT && H.health > H.crit_threshold) //we cannot save someone above our raised crit threshold.

		H.adjustToxLoss(-2 * REM, 0)
		H.adjustBruteLoss(-2 * REM, 0)
		H.adjustFireLoss(-2 * REM, 0)
		H.adjustOxyLoss(-6 * REM, 0)

		H.losebreath = 0

		H.adjustOrganLoss(ORGAN_SLOT_HEART,max(1,volume/10)) // your heart is barely keeping up!

		H.set_timed_status_effect(rand(0 SECONDS, 4 SECONDS) * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		H.set_timed_status_effect(rand(0 SECONDS, 4 SECONDS) * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)


		if(prob(33))
			to_chat(H,span_danger("Your body is trying to give up, but your heart is still beating!"))

	if(H.health <= H.crit_threshold) //certain death above this threshold
		REMOVE_TRAIT(H, TRAIT_STABLEHEART, type) //we have to remove the stable heart before we give him heart attack
		to_chat(H,span_danger("You feel something rupturing inside your chest!"))
		H.force_scream()
		H.set_heartattack(TRUE)
		volume = 0
	. = ..()

/datum/reagent/medicine/penthrite/on_mob_end_metabolize(mob/living/M)
	M.crit_threshold = M.crit_threshold - HEALTH_THRESHOLD_FULLCRIT*2 //your heart is still pumping!
	REMOVE_TRAIT(M, TRAIT_STABLEHEART, type)
	REMOVE_TRAIT(M, TRAIT_NOHARDCRIT,type)
	REMOVE_TRAIT(M, TRAIT_NOSOFTCRIT,type)
	. = ..()

/datum/reagent/medicine/penthrite/overdose_process(mob/living/carbon/human/H)
	REMOVE_TRAIT(H, TRAIT_STABLEHEART, type)
	H.adjustStaminaLoss(10)
	H.adjustOrganLoss(ORGAN_SLOT_HEART,10)
	H.set_heartattack(TRUE)
