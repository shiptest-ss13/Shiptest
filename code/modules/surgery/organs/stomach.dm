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

	low_threshold_passed = "<span class='info'>Your stomach flashes with pain before subsiding. Food doesn't seem like a good idea right now.</span>"
	high_threshold_passed = "<span class='warning'>Your stomach flares up with constant pain- you can hardly stomach the idea of food right now!</span>"
	high_threshold_cleared = "<span class='info'>The pain in your stomach dies down for now, but food still seems unappealing.</span>"
	low_threshold_cleared = "<span class='info'>The last bouts of pain in your stomach have died out.</span>"

	var/disgust_metabolism = 1
	var/metabolism_efficiency = 0.1 // the lowest we should go is 0.05

/obj/item/organ/stomach/on_life(delta_time, times_fired)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/datum/reagent/Nutri

	..()
	if(istype(H))
		if(!(organ_flags & ORGAN_FAILING))
			handle_hunger(H, delta_time, times_fired)
		handle_disgust(H)

	if(damage < low_threshold)
		return

	Nutri = locate(/datum/reagent/consumable/nutriment) in H.reagents.reagent_list

	if(Nutri)
		if(prob((damage/40) * Nutri.volume * Nutri.volume))
			H.vomit(damage)
			to_chat(H, "<span class='warning'>Your stomach reels in pain as you're incapable of holding down all that food!</span>")

	else if(Nutri && damage > high_threshold)
		if(prob((damage/10) * Nutri.volume * Nutri.volume))
			H.vomit(damage)
			to_chat(H, "<span class='warning'>Your stomach reels in pain as you're incapable of holding down all that food!</span>")

/obj/item/organ/stomach/proc/handle_hunger(mob/living/carbon/human/human)
	if(HAS_TRAIT(human, TRAIT_NOHUNGER))
		return //hunger is for BABIES

	//The fucking TRAIT_FAT mutation is the dumbest shit ever. It makes the code so difficult to work with
	if(HAS_TRAIT_FROM(human, TRAIT_FAT, OBESITY))//I share your pain, past coder.
		if(human.overeatduration < (200 SECONDS))
			to_chat(human, span_notice("You feel fit again!"))
			REMOVE_TRAIT(human, TRAIT_FAT, OBESITY)
			human.remove_movespeed_modifier(/datum/movespeed_modifier/obesity)
			human.update_inv_w_uniform()
			human.update_inv_wear_suit()
	else
		if(human.overeatduration >= (200 SECONDS))
			to_chat(human, span_danger("You suddenly feel blubbery!"))
			ADD_TRAIT(human, TRAIT_FAT, OBESITY)
			human.add_movespeed_modifier(/datum/movespeed_modifier/obesity)
			human.update_inv_w_uniform()
			human.update_inv_wear_suit()

	// nutrition decrease and satiety
	if (human.nutrition > 0 && human.stat != DEAD)
		// THEY HUNGER
		var/hunger_rate = HUNGER_FACTOR
		var/datum/component/mood/mood = human.GetComponent(/datum/component/mood)
		if(mood && mood.sanity > SANITY_DISTURBED)
			hunger_rate *= max(1 - 0.002 * mood.sanity, 0.5) //0.85 to 0.75
		// Whether we cap off our satiety or move it towards 0
		if(human.satiety > MAX_SATIETY)
			human.satiety = MAX_SATIETY
		else if(human.satiety > 0)
			human.satiety--
		else if(human.satiety < -MAX_SATIETY)
			human.satiety = -MAX_SATIETY
		else if(human.satiety < 0)
			human.satiety++
			if(prob(round(-human.satiety/77)))
				human.Jitter(5)
			hunger_rate = 3 * HUNGER_FACTOR
		hunger_rate *= human.physiology.hunger_mod
		human.adjust_nutrition(-hunger_rate)

	if(human.nutrition > NUTRITION_LEVEL_FULL)
		if(human.overeatduration < 20 MINUTES) //capped so people don't take forever to unfat
			human.overeatduration = min(human.overeatduration + (1 SECONDS), 20 MINUTES)
	else
		if(human.overeatduration > 0)
			human.overeatduration = max(human.overeatduration - (2 SECONDS), 0) //doubled the unfat rate

	//metabolism change
	if(human.nutrition > NUTRITION_LEVEL_FAT)
		human.metabolism_efficiency = 1
	else if(human.nutrition > NUTRITION_LEVEL_FED && human.satiety > 80)
		if(human.metabolism_efficiency != 1.25)
			to_chat(human, span_notice("You feel vigorous."))
			human.metabolism_efficiency = 1.25
	else if(human.nutrition < NUTRITION_LEVEL_STARVING + 50)
		if(human.metabolism_efficiency != 0.8)
			to_chat(human, span_notice("You feel sluggish."))
		human.metabolism_efficiency = 0.8
	else
		if(human.metabolism_efficiency == 1.25)
			to_chat(human, span_notice("You no longer feel vigorous."))
		human.metabolism_efficiency = 1

	//Hunger slowdown for if mood isn't enabled
	if(CONFIG_GET(flag/disable_human_mood))
		handle_hunger_slowdown(human)

	switch(human.nutrition)
		if(NUTRITION_LEVEL_FULL to INFINITY)
			human.throw_alert("nutrition", /atom/movable/screen/alert/fat)
		if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FULL)
			human.clear_alert("nutrition")
		if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
			human.throw_alert("nutrition", /atom/movable/screen/alert/hungry)
		if(0 to NUTRITION_LEVEL_STARVING)
			human.throw_alert("nutrition", /atom/movable/screen/alert/starving)

///for when mood is disabled and hunger should handle slowdowns
/obj/item/organ/stomach/proc/handle_hunger_slowdown(mob/living/carbon/human/human)
	var/hungry = (500 - human.nutrition) / 5 //So overeat would be 100 and default level would be 80
	if(hungry >= 70)
		human.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/hunger, multiplicative_slowdown = (hungry / 50))
	else
		human.remove_movespeed_modifier(/datum/movespeed_modifier/hunger)

/obj/item/organ/stomach/get_availability(datum/species/S)
	return !(NOSTOMACH in S.species_traits)

/obj/item/organ/stomach/proc/handle_disgust(mob/living/carbon/human/H)
	if(H.disgust)
		var/pukeprob = 5 + 0.05 * H.disgust
		if(H.disgust >= DISGUST_LEVEL_GROSS)
			if(prob(10))
				H.stuttering += 1
				H.confused += 2
			if(prob(10) && !H.stat)
				to_chat(H, "<span class='warning'>You feel kind of iffy...</span>")
			H.jitteriness = max(H.jitteriness - 3, 0)
		if(H.disgust >= DISGUST_LEVEL_VERYGROSS)
			if(prob(pukeprob)) //iT hAndLeS mOrE ThaN PukInG
				H.confused += 2.5
				H.stuttering += 1
				H.vomit(10, 0, 1, 0, 1, 0)
			H.Dizzy(5)
		if(H.disgust >= DISGUST_LEVEL_DISGUSTED)
			if(prob(25))
				H.blur_eyes(3) //We need to add more shit down here

		H.adjust_disgust(-0.5 * disgust_metabolism)
	switch(H.disgust)
		if(0 to DISGUST_LEVEL_GROSS)
			H.clear_alert("disgust")
			SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "disgust")
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			H.throw_alert("disgust", /atom/movable/screen/alert/gross)
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/gross)
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			H.throw_alert("disgust", /atom/movable/screen/alert/verygross)
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/verygross)
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			H.throw_alert("disgust", /atom/movable/screen/alert/disgusted)
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/disgusted)

/obj/item/organ/stomach/Remove(mob/living/carbon/M, special = 0)
	var/mob/living/carbon/human/H = owner
	if(istype(H))
		H.clear_alert("disgust")
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "disgust")
	..()

/obj/item/organ/stomach/lizard
	name = "sarathi stomach"
	icon_state = "lizstomach"
	desc = "It's blue PH"
	metabolism_efficiency = 0.07

/obj/item/organ/stomach/lizard/handle_hunger(mob/living/carbon/human/human, delta_time, times_fired)
	. = ..()
	if(human.nutrition > NUTRITION_LEVEL_WELL_FED && human.nutrition < NUTRITION_LEVEL_FULL)
		human.adjustBruteLoss(-0.5 * delta_time)

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
	desc = "A crystal-like organ that stores the electric charge of ethereals."
	var/crystal_charge = ETHEREAL_CHARGE_FULL

/obj/item/organ/stomach/ethereal/on_life()
	..()
	adjust_charge(-ETHEREAL_CHARGE_FACTOR)

/obj/item/organ/stomach/ethereal/Insert(mob/living/carbon/M, special = 0)
	..()
	RegisterSignal(owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, .proc/charge)
	RegisterSignal(owner, COMSIG_LIVING_ELECTROCUTE_ACT, .proc/on_electrocute)

/obj/item/organ/stomach/ethereal/Remove(mob/living/carbon/M, special = 0)
	UnregisterSignal(owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT)
	UnregisterSignal(owner, COMSIG_LIVING_ELECTROCUTE_ACT)
	..()

/obj/item/organ/stomach/ethereal/proc/charge(datum/source, amount, repairs)
	adjust_charge((amount * ETHEREAL_CHARGE_SCALING_MULTIPLIER) / 70)      //WS Edit -- Ethereal Charge Scaling

/obj/item/organ/stomach/ethereal/proc/on_electrocute(datum/source, shock_damage, siemens_coeff = 1, flags = NONE)
	if(flags & SHOCK_ILLUSION)
		return
	adjust_charge(shock_damage * siemens_coeff * 2)
	to_chat(owner, "<span class='notice'>You absorb some of the shock into your body!</span>")

/obj/item/organ/stomach/ethereal/proc/adjust_charge(amount)
	crystal_charge = clamp(crystal_charge + amount, ETHEREAL_CHARGE_NONE, ETHEREAL_CHARGE_DANGEROUS)

/obj/item/organ/stomach/cybernetic
	name = "basic cybernetic stomach"
	icon_state = "stomach-c"
	desc = "A basic device designed to mimic the functions of a human stomach"
	organ_flags = ORGAN_SYNTHETIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5
	var/emp_vulnerability = 80 //Chance of permanent effects if emp-ed.

/obj/item/organ/stomach/cybernetic/tier2
	name = "cybernetic stomach"
	icon_state = "stomach-c-u"
	desc = "An electronic device designed to mimic the functions of a human stomach. Handles disgusting food a bit better."
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	disgust_metabolism = 2
	emp_vulnerability = 40

/obj/item/organ/stomach/cybernetic/tier3
	name = "upgraded cybernetic stomach"
	icon_state = "stomach-c-u2"
	desc = "An upgraded version of the cybernetic stomach, designed to improve further upon organic stomachs. Handles disgusting food very well."
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	disgust_metabolism = 3
	emp_vulnerability = 20

/obj/item/organ/stomach/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		owner.vomit(stun = FALSE)
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)
	if(prob(emp_vulnerability/severity)) //Chance of permanent effects
		organ_flags |= ORGAN_SYNTHETIC_EMP //Starts organ faliure - gonna need replacing soon.

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
			to_chat(owner, "<span class='warning'>Alert: Heavy EMP Detected. Rebooting power cell to prevent damage.</span>")
		if(2)
			owner.nutrition = 250
			to_chat(owner, "<span class='warning'>Alert: EMP Detected. Cycling battery.</span>")

//WS End
