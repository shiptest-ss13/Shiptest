//The contant in the rate of reagent transfer on life ticks
#define STOMACH_METABOLISM_CONSTANT 0.5

/obj/item/organ/stomach
	name = "stomach"
	icon_state = "stomach"
	w_class = WEIGHT_CLASS_SMALL
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_STOMACH
	attack_verb = list("gored", "squished", "slapped", "digested")
	desc = "Onaka ga suite imasu."

	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = STANDARD_ORGAN_DECAY

	low_threshold_passed = span_info("Your stomach flashes with pain before subsiding. Food doesn't seem like a good idea right now.")
	high_threshold_passed = span_warning("Your stomach flares up with constant pain- you can hardly stomach the idea of food right now!")
	high_threshold_cleared = span_info("The pain in your stomach dies down for now, but food still seems unappealing.")
	low_threshold_cleared = span_info("The last bouts of pain in your stomach have died out.")

	//This is a reagent user and needs more then the 10u from edible component
	reagent_vol = 1000

	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue/stomach_lining = 5)

	///The rate that disgust decays
	var/disgust_metabolism = 1

	///The rate that the stomach will transfer reagents to the body
	var/metabolism_efficiency = 0.1 // the lowest we should go is 0.05

/obj/item/organ/stomach/Initialize()
	. = ..()
	//None edible organs do not get a reagent holder by default
	if(!reagents)
		create_reagents(reagent_vol)

/obj/item/organ/stomach/on_life()
	. = ..()
	//Manage species digestion
	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/humi = owner
		if(!(organ_flags & ORGAN_FAILING))
			humi.dna.species.handle_digestion(humi)

	var/mob/living/carbon/body = owner

	// digest food, sent all reagents that can metabolize to the body
	for(var/chunk in reagents.reagent_list)
		var/datum/reagent/bit = chunk

		// If the reagent does not metabolize then it will sit in the stomach
		// This has an effect on items like plastic causing them to take up space in the stomach
		if(!(bit.metabolization_rate > 0))
			continue

		//Ensure that the the minimum is equal to the metabolization_rate of the reagent if it is higher then the STOMACH_METABOLISM_CONSTANT
		var/amount_min = max(bit.metabolization_rate, STOMACH_METABOLISM_CONSTANT)
		//Do not transfer over more then we have
		var/amount_max = bit.volume

		//If the reagent is part of the food reagents for the organ
		//prevent all the reagents form being used leaving the food reagents
		var/amount_food = food_reagents[bit.type]
		if(amount_food)
			amount_max = max(amount_max - amount_food, 0)

		// Transfer the amount of reagents based on volume with a min amount of 1u
		var/amount = min(round(metabolism_efficiency * bit.volume, 0.1) + amount_min, amount_max)

		if(!(amount > 0))
			continue

		// transfer the reagents over to the body at the rate of the stomach metabolim
		// this way the body is where all reagents that are processed and react
		// the stomach manages how fast they are feed in a drip style
		reagents.trans_id_to(body, bit.type, amount=amount)

	//Handle disgust
	if(body)
		handle_disgust(body)

	//If the stomach is not damaged exit out
	if(damage < low_threshold)
		return

	//We are checking if we have nutriment in a damaged stomach.
	var/datum/reagent/nutri = locate(/datum/reagent/consumable/nutriment) in reagents.reagent_list
	//No nutriment found lets exit out
	if(!nutri)
		return

	//The stomach is damaged has nutriment but low on theshhold, low prob of vomit
	if(prob(damage * 0.025 * nutri.volume * nutri.volume))
		body.vomit(damage)
		to_chat(body, span_warning("Your stomach reels in pain as you're incapable of holding down all that food!"))
		return

	// the chance of vomitng is now high
	if(damage > high_threshold && prob(damage * 0.1 * nutri.volume * nutri.volume))
		body.vomit(damage)
		to_chat(body, span_warning("Your stomach reels in pain as you're incapable of holding down all that food!"))

/obj/item/organ/stomach/get_availability(datum/species/S)
	return !(NOSTOMACH in S.species_traits)

/obj/item/organ/stomach/proc/handle_disgust(mob/living/carbon/human/H)
	if(H.disgust)
		var/pukeprob = 5 + 0.05 * H.disgust
		switch(H.disgust)
			if(0 to DISGUST_LEVEL_GROSS)
				//throw alerts
				H.clear_alert("disgust")
				SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "disgust")
				//do our stupid bullshit
				if(prob(10))
					H.stuttering += 1
					H.confused += 2
					if(!H.stat)
						to_chat(H, span_warning("You feel queasy..."))
				H.adjust_timed_status_effect(-6 SECONDS * REM, /datum/status_effect/jitter)
			if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
				//throw alerts
				H.throw_alert("disgust", /atom/movable/screen/alert/gross)
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/gross)
				//do the nausea stuff
				if(prob(pukeprob)) //iT hAndLeS mOrE ThaN PukInG
					H.vomit(10, 0, 0, 0, 1, 0)
					H.confused += 2.5
					H.stuttering += 1
					owner.set_timed_status_effect(10 SECONDS, /datum/status_effect/dizziness, only_if_higher = TRUE)
			if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
				//do the thing
				H.throw_alert("disgust", /atom/movable/screen/alert/verygross)
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/verygross)
				//you're not gonna believe it we do the other thing too

				if(prob(pukeprob))
					H.blur_eyes(3)
					H.vomit(20, 0, 1, 1, 1, 0)
					H.confused += 2.5
					H.stuttering += 1
			if(DISGUST_LEVEL_DISGUSTED to DISGUST_LEVEL_MAXEDOUT)
				H.throw_alert("disgust", /atom/movable/screen/alert/disgusted)
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/disgusted)

				//profusely vomiting.
				if(prob(pukeprob))
					H.vomit(40, 0, 1, 1, 1, 0)

		H.adjust_disgust(-0.5 * disgust_metabolism)

/obj/item/organ/stomach/Remove(mob/living/carbon/M, special = 0)
	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = owner
		H.clear_alert("disgust")
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "disgust")

	return ..()

/obj/item/organ/stomach/fly
	name = "insectoid stomach"
	icon_state = "stomach-x" //xenomorph liver? It's just a black liver so it fits.
	desc = "A mutant stomach designed to handle the unique diet of a flyperson."

/obj/item/organ/stomach/plasmaman
	name = "digestive crystal"
	icon_state = "stomach-p"
	desc = "A strange crystal that is responsible for metabolizing the unseen energy force that feeds plasmamen."

/obj/item/organ/stomach/ethereal
	name = "biological battery"
	icon_state = "stomach-p" //Welp. At least it's more unique in functionaliy.
	desc = "A crystal-like organ that stores the electric charge of elzuosa."
	var/crystal_charge = ELZUOSE_CHARGE_FULL

/obj/item/organ/stomach/ethereal/on_life()
	..()
	adjust_charge(-ELZUOSE_CHARGE_FACTOR)

/obj/item/organ/stomach/ethereal/Insert(mob/living/carbon/organ_owner, special = 0)
	..()
	RegisterSignal(organ_owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, PROC_REF(charge))
	RegisterSignal(organ_owner, COMSIG_LIVING_ELECTROCUTE_ACT, PROC_REF(on_electrocute))
	RegisterSignal(organ_owner, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_item))

/obj/item/organ/stomach/ethereal/Remove(mob/living/carbon/organ_owner, special = 0)
	UnregisterSignal(organ_owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT)
	UnregisterSignal(organ_owner, COMSIG_LIVING_ELECTROCUTE_ACT)
	UnregisterSignal(organ_owner, COMSIG_MOB_GET_STATUS_TAB_ITEMS)
	..()

/obj/item/organ/stomach/ethereal/proc/get_status_tab_item(mob/living/carbon/source, list/items)
	SIGNAL_HANDLER
	items += "Crystal Charge: [round((crystal_charge / ELZUOSE_CHARGE_SCALING_MULTIPLIER), 0.1)]%"

/obj/item/organ/stomach/ethereal/proc/charge(datum/source, amount, repairs)
	adjust_charge((amount * ELZUOSE_CHARGE_SCALING_MULTIPLIER) / 70)      //WS Edit -- Ethereal Charge Scaling

/obj/item/organ/stomach/ethereal/proc/on_electrocute(datum/source, shock_damage, siemens_coeff = 1, flags = NONE)
	if(flags & SHOCK_ILLUSION)
		return
	adjust_charge(shock_damage * siemens_coeff * 2)
	to_chat(owner, span_notice("You absorb some of the shock into your body!"))

/obj/item/organ/stomach/ethereal/proc/adjust_charge(amount)
	crystal_charge = clamp(crystal_charge + amount, ELZUOSE_CHARGE_NONE, ELZUOSE_CHARGE_DANGEROUS)

/obj/item/organ/stomach/cybernetic
	name = "basic cybernetic stomach"
	icon_state = "stomach-c"
	desc = "A basic device designed to mimic the functions of a human stomach"
	organ_flags = ORGAN_SYNTHETIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5
	metabolism_efficiency = 0.7 // not as good at digestion
	var/emp_vulnerability = 80 //Chance of permanent effects if emp-ed.

/obj/item/organ/stomach/cybernetic/tier2
	name = "cybernetic stomach"
	icon_state = "stomach-c-u"
	desc = "An electronic device designed to mimic the functions of a human stomach. Handles disgusting food a bit better."
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	disgust_metabolism = 2
	emp_vulnerability = 40
	metabolism_efficiency = 0.14

/obj/item/organ/stomach/cybernetic/tier3
	name = "upgraded cybernetic stomach"
	icon_state = "stomach-c-u2"
	desc = "An upgraded version of the cybernetic stomach, designed to improve further upon organic stomachs. Handles disgusting food very well."
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	disgust_metabolism = 3
	emp_vulnerability = 20
	metabolism_efficiency = 0.2

/obj/item/organ/stomach/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		owner.vomit(stun = FALSE)
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)

//WS Begin - IPCs

/obj/item/organ/stomach/cell
	name = "micro-cell"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "microcell"
	w_class = WEIGHT_CLASS_NORMAL
	zone = "chest"
	slot = "stomach"
	attack_verb = list("assault and battery'd")
	desc = "A micro-cell, for IPC use only. Do not swallow."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/stomach/cell/emp_act(severity)
	switch(severity)
		if(1)
			owner.nutrition = 50
			to_chat(owner, span_warning("Alert: Heavy EMP Detected. Rebooting power cell to prevent damage."))
		if(2)
			owner.nutrition = 250
			to_chat(owner, span_warning("Alert: EMP Detected. Cycling battery."))

#undef STOMACH_METABOLISM_CONSTANT
