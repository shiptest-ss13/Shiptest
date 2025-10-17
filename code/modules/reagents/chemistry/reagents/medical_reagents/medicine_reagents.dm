/* For chems that primarily interface with damage
** I.E. healing chems
** organized
** >brute
** >burn
** >tox
** >oxygen
** >multi
** >misc
*/



/// BRUTE CHEMS ///

/datum/reagent/medicine/indomide
	name = "Indomide"
	description = "An anti-inflammatory initially isolated from a Kalixcian cave fungus. Thins the blood, and causes bruises and cuts to slowly heal. Overdose can cause sores to open along the body."
	reagent_state = LIQUID
	color = "#FFFF6B"
	overdose_threshold = 30
	var/passive_bleed_modifier = 1.2

/datum/reagent/medicine/indomide/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-1.5*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/indomide/on_mob_metabolize(mob/living/L)
	. = ..()
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/normal_guy = L
	normal_guy.physiology?.bleed_mod *= passive_bleed_modifier

/datum/reagent/medicine/indomide/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/normal_guy = L
	normal_guy.physiology?.bleed_mod /= passive_bleed_modifier


/datum/reagent/medicine/indomide/overdose_start(mob/living/M)
	. = ..()
	ADD_TRAIT(M, TRAIT_BLOODY_MESS, /datum/reagent/medicine/indomide)

/datum/reagent/medicine/indomide/overdose_process(mob/living/M)
	. = ..()
	M.adjustBruteLoss(0.2*REM, 0)

	if(!iscarbon(M))
		return

	var/mob/living/carbon/victim = M

	if(prob(5))
		var/obj/item/bodypart/open_sore = pick(victim.bodyparts)
		if(IS_ORGANIC_LIMB(open_sore))
			open_sore.force_wound_upwards(/datum/wound/slash/moderate)
		M.emote("gasps")

/datum/reagent/medicine/indomide/on_mob_end_metabolize(mob/living/L)
	. = ..()
	REMOVE_TRAIT(L, TRAIT_BLOODY_MESS, /datum/reagent/medicine/indomide)

/datum/reagent/medicine/indomide/on_transfer(atom/A, method=INGEST, trans_volume)
	if(method != INGEST || !istype(A, /obj/item/organ/stomach))
		return

	A.reagents.remove_reagent(/datum/reagent/medicine/indomide, trans_volume * 0.05)
	A.reagents.add_reagent(/datum/reagent/medicine/metafactor, trans_volume * 0.25)

	..()

/datum/reagent/medicine/metafactor
	name = "Mitogen Metabolism Factor"
	description = "This enzyme catalyzes the conversion of nutricious food into healing peptides."
	//slow metabolism rate so the patient can self heal with food even after the troph has metabolized away for amazing reagent efficency.
	metabolization_rate = 0.0625  * REAGENTS_METABOLISM
	reagent_state = SOLID
	color = "#FFBE00"
	overdose_threshold = 10

/datum/reagent/medicine/metafactor/overdose_start(mob/living/carbon/M)
	metabolization_rate = 2  * REAGENTS_METABOLISM

/datum/reagent/medicine/metafactor/overdose_process(mob/living/carbon/M)
	if(prob(25))
		M.vomit()
	..()


/datum/reagent/medicine/hadrakine
	name = "Hadrakine Powder"
	description = "An aluminum based styptic that rapidly seals flesh wounds upon administration, and lingers in the blood stream, causing slightly reduced blood flow, and stimulating healing of further, minor injuries. Overdose causes blood clotting, shortness of breath, and potential brain damage."
	reagent_state = LIQUID
	color = "#FF9696"
	overdose_threshold = 45
	var/passive_bleed_modifier = 0.9
	var/overdose_bleed_modifier = 0.3
	var/brute_damage_modifier = 1.5

/datum/reagent/medicine/hadrakine/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, VAPOR, INJECT))
			M.adjustToxLoss(0.5*reac_volume)
			if(show_message)
				to_chat(M, span_warning("You don't feel so good..."))
		else if(M.getBruteLoss())
			M.adjustBruteLoss(-reac_volume)
			var/pain_points = M.adjustStaminaLoss(reac_volume*4)
			M.force_pain_noise(pain_points)
			if(show_message && !HAS_TRAIT(M, TRAIT_ANALGESIA))
				to_chat(M, span_danger("You feel your bruises healing! It stings like hell!"))
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
			else
				to_chat(M, span_notice("You feel your bruises throbbing."))
	..()


/datum/reagent/medicine/hadrakine/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-2*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/hadrakine/on_mob_metabolize(mob/living/L)
	. = ..()
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/normal_guy = L
	normal_guy.physiology?.bleed_mod *= passive_bleed_modifier

/datum/reagent/medicine/hadrakine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/normal_guy = L
	normal_guy.physiology?.bleed_mod /= passive_bleed_modifier
	if(overdosed)
		normal_guy.physiology?.bleed_mod /= overdose_bleed_modifier
		normal_guy.physiology?.brute_mod /= brute_damage_modifier

/datum/reagent/medicine/hadrakine/overdose_start(mob/living/M)
	. = ..()

	if(!ishuman(M))
		return

	var/mob/living/carbon/human/overdose_victim = M
	overdose_victim.physiology?.bleed_mod *= overdose_bleed_modifier
	overdose_victim.physiology?.brute_mod *= brute_damage_modifier

/datum/reagent/medicine/hadrakine/overdose_process(mob/living/M)
	M.adjustBruteLoss(0.5*REM, 0)
	M.adjustToxLoss(0.5, 0)
	if(prob(25))
		M.losebreath++
	if(prob(10))
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2*REM)
	..()
	. = 1

/datum/reagent/medicine/silfrine
	name = "Silfrine"
	description = "An extremely aggressive silver-based compound suited best for catalyzing rapid platlet movement, and sealing of wounds. This is an extremely painful process. Overdose causes shortness of breath, and brute damage, as the body tries to seal non-existent wounds."
	reagent_state = LIQUID
	color = "#725cfd"
	overdose_threshold = 20

/datum/reagent/medicine/silfrine/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		var/mob/living/carbon/paper_cut_victim = M
		if(method in list(INGEST, INJECT, PATCH))
			if(!HAS_TRAIT(M, TRAIT_ANALGESIA))
				to_chat(M, span_boldwarning("Your body ignites in pain as nerves are rapidly reformed, and flesh is freshly knit!"))
				M.force_pain_noise(reac_volume*6)
				M.adjustStaminaLoss(reac_volume*4)
			for(var/owie in paper_cut_victim.all_wounds)
				var/datum/wound/paper_cut = owie
				paper_cut.on_silfrine(reac_volume)
	..()

/datum/reagent/medicine/silfrine/on_mob_life(mob/living/carbon/M)
	var/effectiveness_multiplier = clamp(M.getBruteLoss()/75, 0.3, 1.5)
	var/brute_heal = effectiveness_multiplier * REM * -8
	M.adjustBruteLoss(brute_heal, 0)
	..()
	. = 1

/datum/reagent/medicine/silfrine/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/silfrine)
	if(!HAS_TRAIT(L, TRAIT_ANALGESIA))
		SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)

/datum/reagent/medicine/silfrine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/silfrine)

/datum/reagent/medicine/silfrine/overdose_start(mob/living/M)
	. = ..()
	M.add_movespeed_modifier(/datum/movespeed_modifier/reagent/silfrine_od)
	M.force_pain_noise(200)


/datum/reagent/medicine/silfrine/overdose_process(mob/living/M)
	if(prob(10))
		if(!HAS_TRAIT(M, TRAIT_ANALGESIA))
			to_chat(M, span_danger("You feel your flesh twisting as it tries to grow around non-existent wounds!"))
		else
			to_chat(M, span_danger("You feel points of pressure all across your body starting to throb uncomfortably."))
		M.force_pain_noise(40)
		M.adjustStaminaLoss(40*REM, 0)
		M.adjustBruteLoss(5*REM, 0)
	if(prob(25))
		M.losebreath++
	..()
	. = 1


/// BURN REAGENTS ///

/datum/reagent/medicine/leporazine
	name = "Leporazine"
	description = "Leporazine will effectively regulate a patient's body temperature, ensuring it never leaves safe levels."
	color = "#DB90C6"

/datum/reagent/medicine/leporazine/on_mob_life(mob/living/carbon/M)
	if(M.bodytemperature > M.get_body_temp_normal(apply_change=FALSE))
		M.adjust_bodytemperature(-4 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal(apply_change=FALSE))
	else if(M.bodytemperature < (M.get_body_temp_normal(apply_change=FALSE) + 1))
		M.adjust_bodytemperature(4 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal(apply_change=FALSE))
	..()

/datum/reagent/medicine/alvitane
	name = "Alvitane"
	description = "A moderate intensity burn medication derived from chemicals specializing in dermal regeneration. Ideal application is exposing it to the flesh, as it allows burns to rapidly reknit themselves. Overdose weakens the user's ability to resist burns, and causes minor toxic effects."
	reagent_state = LIQUID
	color = "#F7FFA5"
	overdose_threshold = 30
	var/burn_damage_modifier = 1.3

/datum/reagent/medicine/alvitane/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-1*REM, 0)
	M.adjust_bodytemperature(-0.6 * TEMPERATURE_DAMAGE_COEFFICIENT, M.dna.species.bodytemp_normal)
	..()
	. = 1

/datum/reagent/medicine/alvitane/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	M.adjustFireLoss(-reac_volume/2)
	M.force_pain_noise(reac_volume/2)
	M.adjustStaminaLoss(reac_volume/2)
	if(iscarbon(M) && M.stat != DEAD)
		var/mob/living/carbon/burn_ward_attendee = M
		for(var/owie in burn_ward_attendee.all_wounds)
			var/datum/wound/burn = owie
			burn.on_tane(reac_volume/4)
	if(show_message && !HAS_TRAIT(M, TRAIT_ANALGESIA))
		to_chat(M, span_danger("You feel your burns regenerating! Your nerves are burning!"))
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
	else
		to_chat(M, span_notice("You feel your burns twisting."))
	..()

/datum/reagent/medicine/alvitane/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(!ishuman(L))
		return

	if(overdosed)
		var/mob/living/carbon/human/normal_guy = L
		normal_guy.physiology?.burn_mod /= burn_damage_modifier

/datum/reagent/medicine/alvitane/overdose_start(mob/living/M)
	. = ..()

	if(!ishuman(M))
		return

	var/mob/living/carbon/human/overdose_victim = M
	overdose_victim.physiology?.burn_mod *= burn_damage_modifier

/datum/reagent/medicine/alvitane/overdose_process(mob/living/carbon/M)
	M.adjustToxLoss(0.5*REM, 0)
	M.set_timed_status_effect(5 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	..()


/datum/reagent/medicine/quardexane
	name = "Quardexane"
	description = "A third-generation burn medication originating from the Shoal. Injection allows it to rapidly re-knit burns, while vaporous application acts as an cooling agent and sanitizing substance. Overdose causes new burns to form on the user's body."
	reagent_state = LIQUID
	color = "#4ab1ba"
	overdose_threshold = 25
	reagent_weight = 0.6

/datum/reagent/medicine/quardexane/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-2*REM, 0)
	M.adjust_bodytemperature(-0.6 * TEMPERATURE_DAMAGE_COEFFICIENT, M.dna.species.bodytemp_normal)
	..()
	. = 1

/datum/reagent/medicine/quardexane/expose_mob(mob/living/carbon/M, method=VAPOR, reac_volume)
	if(method == VAPOR || TOUCH)
		M.adjust_bodytemperature(-reac_volume * TEMPERATURE_DAMAGE_COEFFICIENT * 0.5, 200)
		M.adjust_fire_stacks(-reac_volume / 2)
		if(reac_volume >= metabolization_rate)
			M.ExtinguishMob()

	if(method == INJECT)
		M.adjustFireLoss(-2*reac_volume, 0)
		if(!HAS_TRAIT(M, TRAIT_ANALGESIA))
			to_chat(M, span_danger("You feel your burns regenerating! Your nerves are burning!"))
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
		else
			to_chat(M, span_danger("Your burns start to throb, before subsiding!"))

	if(iscarbon(M) && M.stat != DEAD && (method in list(VAPOR, INJECT, TOUCH)))
		var/mob/living/carbon/burn_ward_attendee = M
		for(var/owie in burn_ward_attendee.all_wounds)
			var/datum/wound/burn = owie
			burn.on_tane(reac_volume/2)

	..()

/datum/reagent/medicine/quardexane/overdose_process(mob/living/carbon/M)
	M.adjustFireLoss(3*REM, 0.)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, 50)
	..()

/datum/reagent/medicine/ysiltane
	name = "Ysiltane"
	description = "A burn treatment derived from plasma. Application by injection or ingestion causes burns to rapidly repair themselves. The intensity of application causes the user's system to temporarily crash. Overdose causes a toxic crisis within the user's system, and can damage organs."
	reagent_state = LIQUID
	color = "#862929"
	overdose_threshold = 21
	reagent_weight = 2

/datum/reagent/medicine/ysiltane/on_mob_life(mob/living/carbon/M)
	if(current_cycle > 2 && current_cycle <= 6)
		M.adjustFireLoss(-10*REM, 0)
	M.adjustFireLoss(-2*REM, 0)
	M.adjustStaminaLoss(1*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/ysiltane/expose_mob(mob/living/carbon/M, method=VAPOR, reac_volume)
	if(method in list(INJECT, INGEST))
		M.adjustFireLoss(-reac_volume*2)
		M.adjustStaminaLoss(reac_volume*6)
		if(!HAS_TRAIT(M, TRAIT_ANALGESIA))
			to_chat(M, span_boldwarning("Your nerves ignite in pain as burns start to rapidly regenerate!"))
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
		else
			to_chat(M, span_warning("You feel your burns twisting."))

		if(iscarbon(M) && M.stat != DEAD)
			var/mob/living/carbon/burn_ward_attendee = M
			for(var/owie in burn_ward_attendee.all_wounds)
				var/datum/wound/burn = owie
				burn.on_tane(reac_volume)

	..()

/datum/reagent/medicine/ysiltane/overdose_process(mob/living/carbon/M)
	M.adjustFireLoss(3*REM, 0.)
	M.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT, 330)
	..()


/// TOXIN REAGENTS ///


/datum/reagent/medicine/calomel
	name = "Calomel"
	description = "Quickly purges the body of all chemicals. Toxin damage is dealt if the patient is in good condition."
	reagent_state = LIQUID
	color = "#8CDF24" // heavy saturation to make the color blend better
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "acid"

/datum/reagent/medicine/calomel/on_mob_life(mob/living/carbon/M)
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.type,3)
	if(M.health > 20)
		M.adjustToxLoss(1*REM, 0)
		. = 1
	..()

/datum/reagent/medicine/charcoal
	name = "Charcoal"
	description = "Heals toxin damage as well as slowly removing any other chemicals the patient has in their bloodstream. Administer orally"
	reagent_state = SOLID
	color = "#101a13"
	metabolization_rate = 0.75 * REAGENTS_METABOLISM
	overdose_threshold = 20

/datum/reagent/medicine/charcoal/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-1*REM, 0)
	. = 1
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.type,1)
	..()

/datum/reagent/medicine/charcoal/on_transfer(atom/A, method=TOUCH, volume)
	if(method == INGEST || !istype(A, /obj/item/organ/stomach))
		return
	A.reagents.remove_reagent(/datum/reagent/medicine/charcoal, volume) //We really should not be injecting an insoluble granular material.
	A.reagents.add_reagent(/datum/reagent/carbon, volume) // Its pores would get clogged with gunk anyway.
	..()

//its seiver. i ran out of ideas + seiver was a good one
/datum/reagent/medicine/pancrazine
	name = "Pancrazine"
	description = "A second generation Tecetian research chemical developed as the byproduct of the terraforming process. Injection of the substance while cold causes the body to regenerate radiation damage, while heating it causes rapid purging of toxic effects."
	color = "#c3915d"
	var/radbonustemp = (T0C - 100) //being below this number gives you 10% off rads.

/datum/reagent/medicine/pancrazine/on_mob_metabolize(mob/living/carbon/human/M)
	. = ..()
	radbonustemp = rand(radbonustemp - 50, radbonustemp + 50) // Basically this means 50K and below will always give the percent heal, and upto 150K could. Calculated once.

/datum/reagent/medicine/pancrazine/on_mob_life(mob/living/carbon/human/M)
	var/chemtemp = min(holder.chem_temp, 1000)
	chemtemp = chemtemp ? chemtemp : 273 //why do you have null sweaty
	var/healypoints = 0 //5 healypoints = 1 heart damage; 5 rads = 1 tox damage healed for the purpose of healypoints

	//you're hot
	var/toxcalc = min(round((chemtemp-1000)/175+5,0.1),5) //max 2.5 tox healing a tick
	if(toxcalc > 0)
		M.adjustToxLoss(toxcalc*-0.5)
		healypoints += toxcalc

	//and you're cold
	var/radcalc = round((T0C-chemtemp)/6,0.1) //max ~45 rad loss unless you've hit below 0K. if so, wow.
	if(radcalc > 0)
		//no cost percent healing if you are SUPER cold (on top of cost healing)
		if(chemtemp < radbonustemp*0.1) //if you're super chilly, it takes off 25% of your current rads
			M.radiation = round(M.radiation * 0.75)
		else if(chemtemp < radbonustemp)//else if you're under the chill-zone, it takes off 10% of your current rads
			M.radiation = round(M.radiation * 0.9)
		M.radiation -= radcalc
		healypoints += (radcalc/5)


	//you're yes and... oh no!
	healypoints = round(healypoints,0.1)
	M.adjustOrganLoss(ORGAN_SLOT_HEART, healypoints/5)
	..()
	return TRUE

/datum/reagent/medicine/pancrazine/overdose_process(mob/living/M)
	. = ..()
	if(prob(50))
		M.set_timed_status_effect(5 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
		M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	if(prob(10))
		M.adjust_disgust(33)

/datum/reagent/medicine/gjalrazine
	name = "Gjalrazine"
	description = "A plasma-derieved syrum that stimulates the body's natural defenses against toxins. Injection forces the body to start purging toxins, at cost of a rising sense of disgust. Overdose causes the substance to start binding to blood cells, causing blood toxicity."
	reagent_state = LIQUID
	color = "#8CDF24"
	metabolization_rate = 0.75 * REAGENTS_METABOLISM
	overdose_threshold = 12

/datum/reagent/medicine/gjalrazine/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-3*REM, 0)
	if(prob(25))
		M.adjust_disgust(1)
	. = 1
	..()

/datum/reagent/medicine/gjalrazine/expose_mob(mob/living/M, method, reac_volume, show_message, touch_protection)
	. = ..()
	if((method in list(TOUCH, PATCH, INGEST, INJECT)) && M.stat != DEAD)
		if(method == INGEST)
			M.adjustOrganLoss(ORGAN_SLOT_STOMACH, reac_volume)
			to_chat(M, "Your stomach cramps!")
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
		M.adjustToxLoss(-reac_volume*4)
		M.set_disgust(30)
		M.set_timed_status_effect(5 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)

/datum/reagent/medicine/gjalrazine/overdose_process(mob/living/M)
	. = ..()
	M.set_timed_status_effect(30 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	M.adjust_disgust(30)
	M.adjustToxLoss(2*REM, 0)

/// OXYGEN REAGENTS ///

// oxygen has good reason to be less complicated because it's major causes are suffocating and blood loss
// blood loss has treatment methods aside from these meds
// and suffocation shouldn't be a major affair

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

/datum/reagent/medicine/salbutamol
	name = "Salbutamol"
	description = "Rapidly restores oxygen deprivation as well as preventing more of it to an extent."
	reagent_state = LIQUID
	color = "#00FFFF"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM

/datum/reagent/medicine/salbutamol/on_mob_life(mob/living/carbon/M)
	M.adjustOxyLoss(-3*REM, 0)
	if(M.losebreath >= 4)
		M.losebreath -= 2
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

/// RADIATION REAGENTS ///

/datum/reagent/medicine/anti_rad
	name = "Emergency Radiation Purgant" //taking real names
	description = "Rapidly purges radiation from the body."
	reagent_state = LIQUID
	color = "#E6FFF0"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/anti_rad/on_mob_metabolize(mob/living/L)
	to_chat(L, span_warning("Your stomach starts to churn and cramp!"))
	. = ..()

/datum/reagent/medicine/anti_rad/on_mob_life(mob/living/carbon/M)
	M.radiation -= M.radiation - rand(50,150)
	M.adjust_disgust(4*REM)
	..()
	. = 1

/datum/reagent/medicine/potass_iodide
	name = "Potassium Iodide"
	description = "Efficiently restores low radiation damage."
	reagent_state = LIQUID
	color = "#BAA15D"
	metabolization_rate = 2 * REAGENTS_METABOLISM

/datum/reagent/medicine/potass_iodide/on_mob_life(mob/living/carbon/M)
	if(M.radiation > 0)
		M.radiation -= min(M.radiation, 8)
	..()

/datum/reagent/medicine/pen_acid
	name = "Pentetic Acid"
	description = "Reduces massive amounts of radiation and toxin damage while purging other chemicals from the body."
	reagent_state = LIQUID
	color = "#E6FFF0"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/pen_acid/on_mob_life(mob/living/carbon/M)
	M.radiation -= max(M.radiation-RAD_MOB_SAFE, 0)/50
	M.adjustToxLoss(-2*REM, 0)
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.type,2)
	..()
	. = 1

/// MULTI-DAMAGE REAGENTS ///


/datum/reagent/medicine/synthflesh
	name = "Synthflesh"
	description = "Has a 100% chance of instantly healing brute and burn damage. One unit of the chemical will heal one point of damage. Touch application only."
	reagent_state = LIQUID
	color = "#FFEBEB"

/datum/reagent/medicine/synthflesh/expose_mob(mob/living/M, method=TOUCH, reac_volume,show_message = 1)
	if(iscarbon(M))
		var/mob/living/carbon/carbies = M
		if (carbies.stat == DEAD)
			show_message = 0
		if(method in list(PATCH, TOUCH, SMOKE))
			var/harmies = min(carbies.getBruteLoss(),carbies.adjustBruteLoss(-1.25 * reac_volume)*-1)
			var/burnies = min(carbies.getFireLoss(),carbies.adjustFireLoss(-1.25 * reac_volume)*-1)
			for(var/i in carbies.all_wounds)
				var/datum/wound/iter_wound = i
				iter_wound.on_synthflesh(reac_volume)
			carbies.adjustToxLoss((harmies+burnies)*0.66)
			if(show_message)
				to_chat(carbies, span_danger("You feel your burns and bruises healing! It stings like hell!"))
			SEND_SIGNAL(carbies, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
			if(HAS_TRAIT_FROM(M, TRAIT_HUSK, "burn") && carbies.getFireLoss() < THRESHOLD_UNHUSK && (carbies.reagents.get_reagent_amount(/datum/reagent/medicine/synthflesh) + reac_volume >= 100))
				carbies.cure_husk("burn")
				carbies.visible_message("<span class='nicegreen'>A rubbery liquid coats [carbies]'s burns. [carbies] looks a lot healthier!") //we're avoiding using the phrases "burnt flesh" and "burnt skin" here because carbies could be a skeleton or something
	..()
	return TRUE

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

/datum/reagent/medicine/hunter_extract
	name = "Hunter's Extract"
	description = "An extract of floral compounds and exotic frontier bacteria. Heals the user in small doses, but is extremely toxic otherwise."
	color = "#6B372E" //dark and red like lavaland
	metabolization_rate = REAGENTS_METABOLISM * 0.5
	overdose_threshold = 10

/datum/reagent/medicine/hunter_extract/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	ADD_TRAIT(M, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	..()

/datum/reagent/medicine/hunter_extract/on_mob_end_metabolize(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	..()

/datum/reagent/medicine/hunter_extract/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-1*REM, 0)
	M.adjustBruteLoss(-1*REM, 0)
	M.adjustToxLoss(-1*REM, 0)
	if(M.health <= M.crit_threshold)
		M.adjustOxyLoss(-1*REM, 0)
	..()
	return TRUE

/datum/reagent/medicine/hunter_extract/overdose_process(mob/living/M)		// Thanks to actioninja
	if(prob(2) && iscarbon(M))
		var/selected_part = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		var/obj/item/bodypart/bp = M.get_bodypart(selected_part)
		if(bp)
			M.visible_message(span_warning("[M] feels a spike of pain!!"), span_danger("You feel a spike of pain!!"))
			bp.receive_damage(0, 0, 200)
		else	//SUCH A LUST FOR REVENGE!!!
			to_chat(M, span_warning("A phantom limb hurts!"))
	return ..()


/datum/reagent/medicine/panacea
	name = "Panacea"
	description = "One of the developments of the frontier, Panacea is a term for a variety of mildly-anomalous substances usually found within Frontier space. Despite disparate origins, they all share a similar effect of slowly healing the body. Overdosing on them causes this effect to reverse."
	reagent_state = LIQUID
	color = "#DCDCDC"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30
	var/healing = 1

/datum/reagent/medicine/panacea/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-healing*REM, 0)
	M.adjustOxyLoss(-healing*REM, 0)
	M.adjustBruteLoss(-healing*REM, 0)
	M.adjustFireLoss(-healing*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/panacea/overdose_process(mob/living/M)
	M.adjustToxLoss(1.5*REM, 0)
	M.adjustOxyLoss(1.5*REM, 0)
	M.adjustBruteLoss(1.5*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
	M.adjustFireLoss(1.5*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
	..()
	. = 1

/datum/reagent/medicine/panacea/effluvial
	name = "Effluvial Panacea"
	description = "A waste product of industrial processes to synthesize Panacea, or more often, an impure form, Effluvial Panacea has the same effects as true panacea, simply reduced in effectiveness."
	color = "#d8c7b7"
	healing = 0.2

/datum/reagent/medicine/panacea/effluvial/on_mob_life(mob/living/carbon/M)
	if(prob(25))
		M.adjustOrganLoss(ORGAN_SLOT_HEART, 0.5)
	..()
	. = 1

/datum/reagent/medicine/stimulants
	name = "Indoril Stimulant"
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

/datum/reagent/medicine/cureall
	name = "Cureall Solution"
	description = "A diluted solution created from plasmatic binding of Alvitane, Indomide, and charcoal. Slowly restores all types of damage."
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "still water"
	overdose_threshold = 30

/datum/reagent/medicine/cureall/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-0.3*REM, 0)
	M.adjustFireLoss(-0.3*REM, 0)
	M.adjustToxLoss(-0.3*REM, 0)
	. = 1
	..()

/datum/reagent/medicine/cureall/overdose_process(mob/living/M)
	if(prob(50))
		M.adjustBruteLoss(0.5*REM, 0)
		M.adjustFireLoss(0.5*REM, 0)
		M.adjustToxLoss(0.5*REM, 0)
		. = 1
	..()

/// CRIT REAGENTS ///

/datum/reagent/medicine/epinephrine
	name = "Epinephrine"
	description = "Very minor boost to stun resistance. Slowly heals damage if a patient is in critical condition, as well as regulating oxygen loss. Overdose causes weakness and toxin damage."
	reagent_state = LIQUID
	color = "#D2FFFA"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30

/datum/reagent/medicine/epinephrine/on_mob_metabolize(mob/living/carbon/M)
	..()
	ADD_TRAIT(M, TRAIT_NOCRITDAMAGE, type)

/datum/reagent/medicine/epinephrine/on_mob_end_metabolize(mob/living/carbon/M)
	REMOVE_TRAIT(M, TRAIT_NOCRITDAMAGE, type)
	..()

/datum/reagent/medicine/epinephrine/on_mob_life(mob/living/carbon/M)
	if(M.health <= M.crit_threshold)
		M.adjustToxLoss(-0.5*REM, 0)
		M.adjustBruteLoss(-0.5*REM, 0)
		M.adjustFireLoss(-0.5*REM, 0)
		M.adjustOxyLoss(-0.5*REM, 0)
	if(M.losebreath >= 4)
		M.losebreath -= 2
	if(M.losebreath < 0)
		M.losebreath = 0
	M.adjustStaminaLoss(-0.5*REM, 0)
	. = 1
	if(prob(20))
		M.AdjustAllImmobility(-20)
	..()

/datum/reagent/medicine/epinephrine/overdose_process(mob/living/M)
	if(prob(33))
		M.adjustStaminaLoss(2.5*REM, 0)
		M.adjustToxLoss(1*REM, 0)
		M.losebreath++
		. = 1
	..()

/datum/reagent/medicine/atropine
	name = "Atropine"
	description = "If a patient is in critical condition, rapidly heals all damage types as well as regulating oxygen in the body. Excellent for stabilizing wounded patients."
	reagent_state = LIQUID
	color = "#1D3535" //slightly more blue, like epinephrine
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 35

/datum/reagent/medicine/atropine/on_mob_life(mob/living/carbon/M)
	if(M.health <= M.crit_threshold)
		M.adjustToxLoss(-2*REM, 0)
		M.adjustBruteLoss(-2*REM, 0)
		M.adjustFireLoss(-2*REM, 0)
		M.adjustOxyLoss(-5*REM, 0)
		. = 1
	M.losebreath = 0
	if(prob(20))
		M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/atropine/overdose_process(mob/living/M)
	M.adjustToxLoss(0.5*REM, 0)
	. = 1
	M.set_timed_status_effect(2 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	M.adjust_timed_status_effect(2 SECONDS * REM, /datum/status_effect/dizziness, max_duration = 20 SECONDS)
	..()

