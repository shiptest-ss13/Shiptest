#define PERF_BASE_DAMAGE 0.5

//////////////////////////////////////////////////////////////////////////////////////////
					// MEDICINE REAGENTS
//////////////////////////////////////////////////////////////////////////////////////

// where all the reagents related to medicine go.

/datum/reagent/medicine
	name = "Medicine"
	taste_description = "bitterness"

/datum/reagent/medicine/on_mob_life(mob/living/carbon/M)
	current_cycle++
	holder.remove_reagent(type, metabolization_rate / M.metabolism_efficiency) //medicine reagents stay longer if you have a better metabolism

/datum/reagent/medicine/leporazine
	name = "Leporazine"
	description = "Leporazine will effectively regulate a patient's body temperature, ensuring it never leaves safe levels."
	color = "#DB90C6"

/datum/reagent/medicine/leporazine/on_mob_life(mob/living/carbon/M)
	if(M.bodytemperature > M.get_body_temp_normal(apply_change=FALSE))
		M.adjust_bodytemperature(-40 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal(apply_change=FALSE))
	else if(M.bodytemperature < (M.get_body_temp_normal(apply_change=FALSE) + 1))
		M.adjust_bodytemperature(40 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal(apply_change=FALSE))
	..()

/datum/reagent/medicine/adminordrazine //An OP chemical for admins
	name = "Adminordrazine"
	description = "It's magic. We don't have to explain it."
	color = "#E0BB00" //golden for the gods
	can_synth = FALSE
	taste_description = "badmins"

/datum/reagent/medicine/adminordrazine/on_mob_life(mob/living/carbon/M)
	M.reagents.remove_all_type(/datum/reagent/toxin, 5*REM, 0, 1)
	M.setCloneLoss(0, 0)
	M.setOxyLoss(0, 0)
	M.radiation = 0
	M.heal_bodypart_damage(5,5)
	M.adjustToxLoss(-5, 0, TRUE)
	M.hallucination = 0
	REMOVE_TRAITS_NOT_IN(M, list(SPECIES_TRAIT, ROUNDSTART_TRAIT, ORGAN_TRAIT))
	M.set_blurriness(0)
	M.set_blindness(0)
	M.SetKnockdown(0)
	M.SetStun(0)
	M.SetUnconscious(0)
	M.SetParalyzed(0)
	M.SetImmobilized(0)
	M.silent = FALSE
	M.dizziness = 0
	M.disgust = 0
	M.drowsyness = 0
	M.stuttering = 0
	M.slurring = 0
	M.confused = 0
	M.SetSleeping(0)
	M.jitteriness = 0
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = BLOOD_VOLUME_NORMAL

	M.cure_all_traumas(TRAUMA_RESILIENCE_MAGIC)
	for(var/organ in M.internal_organs)
		var/obj/item/organ/O = organ
		O.setOrganDamage(0)
	for(var/thing in M.diseases)
		var/datum/disease/D = thing
		if(D.severity == DISEASE_SEVERITY_POSITIVE)
			continue
		D.cure()
	..()
	. = 1

/datum/reagent/medicine/adminordrazine/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustWater(round(chems.get_reagent_amount(type) * 1))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 1))
		mytray.adjustPests(-rand(1,5))
		mytray.adjustWeeds(-rand(1,5))
	if(chems.has_reagent(type, 3))
		switch(rand(100))
			if(66 to 100)
				mytray.mutatespecie()
			if(33 to 65)
				mytray.mutateweed()
			if(1 to 32)
				mytray.mutatepest(user)
			else
				if(prob(20))
					mytray.visible_message("<span class='warning'>Nothing happens...</span>")

/datum/reagent/medicine/adminordrazine/quantum_heal
	name = "Quantum Medicine"
	description = "Rare and experimental particles, that apparently swap the user's body with one from an alternate dimension where it's completely healthy."
	taste_description = "science"

/datum/reagent/medicine/synaptizine
	name = "Synaptizine"
	description = "Increases resistance to stuns as well as reducing drowsiness and hallucinations."
	color = "#FF00FF"

/datum/reagent/medicine/synaptizine/on_mob_life(mob/living/carbon/M)
	M.drowsyness = max(M.drowsyness-5, 0)
	M.AdjustStun(-20)
	M.AdjustKnockdown(-20)
	M.AdjustUnconscious(-20)
	M.AdjustImmobilized(-20)
	M.AdjustParalyzed(-20)
	if(M.reagents.has_reagent(/datum/reagent/toxin/mindbreaker))
		M.reagents.remove_reagent(/datum/reagent/toxin/mindbreaker, 5)
	M.hallucination = max(0, M.hallucination - 10)
	if(prob(30))
		M.adjustToxLoss(1, 0)
		. = 1
	..()

/datum/reagent/medicine/synaphydramine
	name = "Diphen-Synaptizine"
	description = "Reduces drowsiness, hallucinations, and Histamine from body."
	color = "#EC536D" // rgb: 236, 83, 109

/datum/reagent/medicine/synaphydramine/on_mob_life(mob/living/carbon/M)
	M.drowsyness = max(M.drowsyness-5, 0)
	if(holder.has_reagent(/datum/reagent/toxin/mindbreaker))
		holder.remove_reagent(/datum/reagent/toxin/mindbreaker, 5)
	if(holder.has_reagent(/datum/reagent/toxin/histamine))
		holder.remove_reagent(/datum/reagent/toxin/histamine, 5)
	M.hallucination = max(0, M.hallucination - 10)
	if(prob(30))
		M.adjustToxLoss(1, 0)
		. = 1
	..()

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
		REMOVE_TRAIT(M, TRAIT_DISFIGURED, TRAIT_GENERIC) //fixes common causes for disfiguration
		. = 1
	metabolization_rate = REAGENTS_METABOLISM * (0.00001 * (M.bodytemperature ** 2) + 0.5)
	..()

/datum/reagent/medicine/clonexadone
	name = "Clonexadone"
	description = "A chemical that derives from Cryoxadone. It specializes in healing clone damage, but nothing else. Requires very cold temperatures to properly metabolize, and metabolizes quicker than cryoxadone."
	color = "#3D3DC6"
	taste_description = "muscle"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/clonexadone/on_mob_life(mob/living/carbon/M)
	if(M.bodytemperature < T0C)
		M.adjustCloneLoss(0.00006 * (M.bodytemperature ** 2) - 6, 0)
		REMOVE_TRAIT(M, TRAIT_DISFIGURED, TRAIT_GENERIC)
		. = 1
	metabolization_rate = REAGENTS_METABOLISM * (0.000015 * (M.bodytemperature ** 2) + 0.75)
	..()

/datum/reagent/medicine/pyroxadone
	name = "Pyroxadone"
	description = "A mixture of cryoxadone and slime jelly, that apparently inverses the requirement for its activation."
	color = "#f7832a"
	taste_description = "spicy jelly"

/datum/reagent/medicine/pyroxadone/on_mob_life(mob/living/carbon/M)
	. = ..()

	var/bodytemp = M.bodytemperature
	var/heatlimit = M.dna.species.bodytemp_heat_damage_limit

	if(bodytemp < heatlimit)
		return .

	var/power = 0

	if(bodytemp < 400)
		power = 2

	else if(bodytemp < 460)
		power = 3

	else
		power = 5

	if(M.on_fire)
		power *= 2

	M.adjustOxyLoss(-2 * power, 0)
	M.adjustBruteLoss(-power, 0)
	M.adjustFireLoss(-1.5 * power, 0)
	M.adjustToxLoss(-power, 0, TRUE)
	M.adjustCloneLoss(-power, 0)
	REMOVE_TRAIT(M, TRAIT_DISFIGURED, TRAIT_GENERIC)

/datum/reagent/medicine/rezadone
	name = "Rezadone"
	description = "A powder derived from fish toxin, Rezadone can effectively treat genetic damage as well as restoring minor wounds. Overdose will cause intense nausea and minor toxin damage."
	reagent_state = SOLID
	color = "#669900" // rgb: 102, 153, 0
	overdose_threshold = 30
	taste_description = "fish"

/datum/reagent/medicine/rezadone/on_mob_life(mob/living/carbon/M)
	M.setCloneLoss(0) //Rezadone is almost never used in favor of cryoxadone. Hopefully this will change that.
	M.heal_bodypart_damage(1,1)
	REMOVE_TRAIT(M, TRAIT_DISFIGURED, TRAIT_GENERIC)
	..()
	. = 1

/datum/reagent/medicine/rezadone/overdose_process(mob/living/M)
	M.adjustToxLoss(1, 0)
	M.Dizzy(5)
	M.Jitter(5)
	..()
	. = 1

/datum/reagent/medicine/rezadone/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	. = ..()
	if(iscarbon(M))
		var/mob/living/carbon/patient = M
		if(reac_volume >= 5 && HAS_TRAIT_FROM(patient, TRAIT_HUSK, "burn") && patient.getFireLoss() < THRESHOLD_UNHUSK) //One carp yields 12u rezadone.
			patient.cure_husk("burn")
			patient.visible_message("<span class='nicegreen'>[patient]'s body rapidly absorbs moisture from the enviroment, taking on a more healthy appearance.</span>")

/datum/reagent/medicine/spaceacillin
	name = "Spaceacillin"
	description = "Spaceacillin will prevent a patient from conventionally spreading any diseases they are currently infected with."
	color = "#E1F2E6"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM

//Goon Chems. Ported mainly from Goonstation. Easily mixable (or not so easily) and provide a variety of effects.
/datum/reagent/medicine/silver_sulfadiazine
	name = "Silver Sulfadiazine"
	description = "If used in touch-based applications, immediately restores burn wounds as well as restoring more over time. If ingested through other means or overdosed, deals minor toxin damage."
	reagent_state = LIQUID
	color = "#C8A5DC"
	overdose_threshold = 45

/datum/reagent/medicine/silver_sulfadiazine/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, VAPOR, INJECT))
			M.adjustToxLoss(0.5*reac_volume)
			if(show_message)
				to_chat(M, "<span class='warning'>You don't feel so good...</span>")
		else if(M.getFireLoss())
			M.adjustFireLoss(-reac_volume)
			if(show_message)
				to_chat(M, "<span class='danger'>You feel your burns healing! It stings like hell!</span>")
			M.emote("scream")
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
	..()

/datum/reagent/medicine/silver_sulfadiazine/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-2*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/silver_sulfadiazine/overdose_process(mob/living/M)
	M.adjustFireLoss(2.5*REM, 0)
	M.adjustToxLoss(0.5, 0)
	..()
	. = 1

/datum/reagent/medicine/oxandrolone
	name = "Oxandrolone"
	description = "Stimulates the healing of severe burns. Extremely rapidly heals severe burns and slowly heals minor ones. Overdose will worsen existing burns."
	reagent_state = LIQUID
	color = "#1E8BFF"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 25

/datum/reagent/medicine/oxandrolone/on_mob_life(mob/living/carbon/M)
	if(M.getFireLoss() > 25)
		M.adjustFireLoss(-4*REM, 0) //Twice as effective as AIURI for severe burns
	else
		M.adjustFireLoss(-0.5*REM, 0) //But only a quarter as effective for more minor ones
	..()
	. = 1

/datum/reagent/medicine/oxandrolone/overdose_process(mob/living/M)
	if(M.getFireLoss()) //It only makes existing burns worse
		M.adjustFireLoss(4.5*REM, FALSE, FALSE, BODYTYPE_ORGANIC) // it's going to be healing either 4 or 0.5
		. = 1
	..()

/datum/reagent/medicine/styptic_powder
	name = "Styptic Powder"
	description = "If used in touch-based applications, immediately restores bruising as well as restoring more over time. If ingested through other means or overdosed, deals minor toxin damage."
	reagent_state = LIQUID
	color = "#FF9696"
	overdose_threshold = 45

/datum/reagent/medicine/styptic_powder/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, VAPOR, INJECT))
			M.adjustToxLoss(0.5*reac_volume)
			if(show_message)
				to_chat(M, "<span class='warning'>You don't feel so good...</span>")
		else if(M.getBruteLoss())
			M.adjustBruteLoss(-reac_volume)
			if(show_message)
				to_chat(M, "<span class='danger'>You feel your bruises healing! It stings like hell!</span>")
			M.emote("scream")
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
	..()


/datum/reagent/medicine/styptic_powder/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-2*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/styptic_powder/overdose_process(mob/living/M)
	M.adjustBruteLoss(2.5*REM, 0)
	M.adjustToxLoss(0.5, 0)
	..()
	. = 1

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

/datum/reagent/medicine/salglu_solution/on_mob_life(mob/living/carbon/M)
	if(last_added)
		M.blood_volume -= last_added
		last_added = 0
	if(M.blood_volume < maximum_reachable)	//Can only up to double your effective blood level.
		var/amount_to_add = min(M.blood_volume, volume*5)
		var/new_blood_level = min(M.blood_volume + amount_to_add, maximum_reachable)
		last_added = new_blood_level - M.blood_volume
		M.blood_volume = new_blood_level
	if(prob(33))
		M.adjustBruteLoss(-0.5*REM, 0)
		M.adjustFireLoss(-0.5*REM, 0)
		. = TRUE
	..()

/datum/reagent/medicine/salglu_solution/overdose_process(mob/living/M)
	if(prob(3))
		to_chat(M, "<span class='warning'>You feel salty.</span>")
		holder.add_reagent(/datum/reagent/consumable/sodiumchloride, 1)
		holder.remove_reagent(/datum/reagent/medicine/salglu_solution, 0.5)
	else if(prob(3))
		to_chat(M, "<span class='warning'>You feel sweet.</span>")
		holder.add_reagent(/datum/reagent/consumable/sugar, 1)
		holder.remove_reagent(/datum/reagent/medicine/salglu_solution, 0.5)
	if(prob(33))
		M.adjustBruteLoss(0.5*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
		M.adjustFireLoss(0.5*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
		. = TRUE
	..()

/datum/reagent/medicine/mine_salve
	name = "Miner's Salve"
	description = "A powerful painkiller. Restores bruising and burns in addition to making the patient believe they are fully healed."
	reagent_state = LIQUID
	color = "#6D6374"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM

/datum/reagent/medicine/mine_salve/on_mob_life(mob/living/carbon/C)
	C.hal_screwyhud = SCREWYHUD_HEALTHY
	C.adjustBruteLoss(-0.25*REM, 0)
	C.adjustFireLoss(-0.25*REM, 0)
	..()
	return TRUE

/datum/reagent/medicine/mine_salve/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, VAPOR, INJECT))
			M.adjust_nutrition(-5)
			if(show_message)
				to_chat(M, "<span class='warning'>Your stomach feels empty and cramps!</span>")
		else
			var/mob/living/carbon/C = M
			for(var/s in C.surgeries)
				var/datum/surgery/S = s
				S.speed_modifier = max(0.1, S.speed_modifier)

			if(show_message)
				to_chat(M, "<span class='danger'>You feel your wounds fade away to nothing!</span>" )
	..()

/datum/reagent/medicine/mine_salve/on_mob_end_metabolize(mob/living/M)
	if(iscarbon(M))
		var/mob/living/carbon/N = M
		N.hal_screwyhud = SCREWYHUD_NONE
	..()

/datum/reagent/medicine/synthflesh
	name = "Synthflesh"
	description = "Has a 100% chance of instantly healing brute and burn damage. One unit of the chemical will heal one point of damage. Touch application only."
	reagent_state = LIQUID
	color = "#FFEBEB"

/datum/reagent/medicine/synthflesh/expose_mob(mob/living/M, method=TOUCH, reac_volume,show_message = 1)
	if(iscarbon(M))
		if (M.stat == DEAD)
			show_message = 0
		if(method in list(PATCH, TOUCH))
			M.adjustBruteLoss(-1.25 * reac_volume)
			M.adjustFireLoss(-1.25 * reac_volume)
			if(show_message)
				to_chat(M, "<span class='danger'>You feel your burns and bruises healing! It stings like hell!</span>")
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
			if(HAS_TRAIT_FROM(M, TRAIT_HUSK, "burn") && M.getFireLoss() < THRESHOLD_UNHUSK && (M.reagents.get_reagent_amount(/datum/reagent/medicine/synthflesh) + reac_volume >= 100))
				M.cure_husk("burn")
				M.visible_message("<span class='nicegreen'>A rubbery liquid coats [M]'s burns. [M] looks a lot healthier!")
	..()

/datum/reagent/medicine/charcoal
	name = "Charcoal"
	description = "Heals toxin damage as well as slowly removing any other chemicals the patient has in their bloodstream."
	reagent_state = LIQUID
	color = "#000000"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "ash"
	process_flags = ORGANIC //WS Edit - IPCs

/datum/reagent/medicine/charcoal/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-2*REM, 0)
	. = 1
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.type,1)
	..()

/datum/reagent/medicine/charcoal/on_transfer(atom/A, method=TOUCH, volume)
	if(method == INGEST || !iscarbon(A)) //the atom not the charcoal
		return
	A.reagents.remove_reagent(/datum/reagent/medicine/charcoal/, volume) //We really should not be injecting an insoluble granular material.
	A.reagents.add_reagent(/datum/reagent/carbon, volume) // Its pores would get clogged with gunk anyway.
	..()

/datum/reagent/medicine/system_cleaner
	name = "System Cleaner"
	description = "Neutralizes harmful chemical compounds inside synthetic systems."
	reagent_state = LIQUID
	color = "#F1C40F"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	process_flags = SYNTHETIC //WS Edit - IPCs

/datum/reagent/medicine/system_cleaner/on_mob_life(mob/living/M)
	M.adjustToxLoss(-2*REM, 0)
	. = 1
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.type,1)
	..()

/datum/reagent/medicine/liquid_solder
	name = "Liquid Solder"
	description = "Repairs brain damage in synthetics."
	color = "#727272"
	taste_description = "metallic"
	process_flags = SYNTHETIC //WS Edit - IPCs

/datum/reagent/medicine/liquid_solder/on_mob_life(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -3*REM)
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(prob(30) && C.has_trauma_type(BRAIN_TRAUMA_SPECIAL))
			C.cure_trauma_type(BRAIN_TRAUMA_SPECIAL)
		if(prob(10) && C.has_trauma_type(BRAIN_TRAUMA_MILD))
			C.cure_trauma_type(BRAIN_TRAUMA_MILD)
	..()

/datum/reagent/medicine/omnizine
	name = "Omnizine"
	description = "Slowly heals all damage types. Overdose will cause damage in all types instead."
	reagent_state = LIQUID
	color = "#DCDCDC"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30
	var/healing = 0.5

/datum/reagent/medicine/omnizine/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-healing*REM, 0)
	M.adjustOxyLoss(-healing*REM, 0)
	M.adjustBruteLoss(-healing*REM, 0)
	M.adjustFireLoss(-healing*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/omnizine/overdose_process(mob/living/M)
	M.adjustToxLoss(1.5*REM, 0)
	M.adjustOxyLoss(1.5*REM, 0)
	M.adjustBruteLoss(1.5*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
	M.adjustFireLoss(1.5*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
	..()
	. = 1

/datum/reagent/medicine/omnizine/protozine
	name = "Protozine"
	description = "A less environmentally friendly and somewhat weaker variant of omnizine."
	color = "#d8c7b7"
	healing = 0.2

/datum/reagent/medicine/calomel
	name = "Calomel"
	description = "Quickly purges the body of all chemicals. Toxin damage is dealt if the patient is in good condition."
	reagent_state = LIQUID
	color = "#19C832"
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

/datum/reagent/medicine/anti_rad
	name = "Emergency Radiation Purgant" //taking real names
	description = "Rapidly purges radiation from the body."
	reagent_state = LIQUID
	color = "#E6FFF0"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/anti_rad/on_mob_life(mob/living/carbon/M)
	M.radiation -= M.radiation - rand(50,150)
	M.adjust_disgust(7*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/sal_acid
	name = "Salicylic Acid"
	description = "Stimulates the healing of severe bruises. Extremely rapidly heals severe bruising and slowly heals minor ones. Overdose will worsen existing bruising."
	reagent_state = LIQUID
	color = "#D2D2D2"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 25

/datum/reagent/medicine/sal_acid/on_mob_life(mob/living/carbon/M)
	if(M.getBruteLoss() > 25)
		M.adjustBruteLoss(-4*REM, 0) //Twice as effective as styptic powder for severe bruising
	else
		M.adjustBruteLoss(-0.5*REM, 0) //But only a quarter as effective for more minor ones
	..()
	. = 1

/datum/reagent/medicine/sal_acid/overdose_process(mob/living/M)
	if(M.getBruteLoss()) //It only makes existing bruises worse
		M.adjustBruteLoss(4.5*REM, FALSE, FALSE, BODYTYPE_ORGANIC) // it's going to be healing either 4 or 0.5
		. = 1
	..()

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

/datum/reagent/medicine/perfluorodecalin
	name = "Perfluorodecalin"
	description = "Restores oxygen deprivation while producing a lesser amount of toxic byproducts. Both scale with exposure to the drug and current amount of oxygen deprivation. Overdose causes toxic byproducts regardless of oxygen deprivation."
	reagent_state = LIQUID
	color = "#FF6464"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 35 // at least 2 full syringes +some, this stuff is nasty if left in for long

/datum/reagent/medicine/perfluorodecalin/on_mob_life(mob/living/carbon/human/M)
	var/oxycalc = 2.5*REM*current_cycle
	if(!overdosed)
		oxycalc = min(oxycalc,M.getOxyLoss()+PERF_BASE_DAMAGE) //if NOT overdosing, we lower our toxdamage to only the damage we actually healed with a minimum of 0.5. IE if we only heal 10 oxygen damage but we COULD have healed 20, we will only take toxdamage for the 10. We would take the toxdamage for the extra 10 if we were overdosing.
	M.adjustOxyLoss(-oxycalc, 0)
	M.adjustToxLoss(oxycalc/2.5, 0)
	if(prob(current_cycle) && M.losebreath)
		M.losebreath--
	..()
	return TRUE

/datum/reagent/medicine/perfluorodecalin/overdose_process(mob/living/M)
	metabolization_rate += 1
	return ..()

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
			to_chat(M, "<span class='notice'>Your hands spaz out and you drop what you were holding!</span>")
			M.Jitter(10)

	M.AdjustAllImmobility(-20)
	M.adjustStaminaLoss(-1*REM, FALSE)
	..()
	return TRUE

/datum/reagent/medicine/ephedrine/overdose_process(mob/living/M)
	if(prob(2) && iscarbon(M))
		var/datum/disease/D = new /datum/disease/heart_failure
		M.ForceContractDisease(D)
		to_chat(M, "<span class='userdanger'>You're pretty sure you just felt your heart stop for a second there..</span>")
		M.playsound_local(M, 'sound/effects/singlebeat.ogg', 100, 0)

	if(prob(7))
		to_chat(M, "<span class='notice'>[pick("Your head pounds.", "You feel a tight pain in your chest.", "You find it hard to stay still.", "You feel your heart practically beating out of your chest.")]</span>")

	if(prob(33))
		M.adjustToxLoss(1*REM, 0)
		M.losebreath++
		. = 1
	return TRUE

/datum/reagent/medicine/ephedrine/addiction_act_stage1(mob/living/M)
	if(prob(3) && iscarbon(M))
		M.visible_message("<span class='danger'>[M] starts having a seizure!</span>", "<span class='userdanger'>You have a seizure!</span>")
		M.Unconscious(100)
		M.Jitter(350)

	if(prob(33))
		M.adjustToxLoss(2*REM, 0)
		M.losebreath += 2
		. = 1
	..()

/datum/reagent/medicine/ephedrine/addiction_act_stage2(mob/living/M)
	if(prob(6) && iscarbon(M))
		M.visible_message("<span class='danger'>[M] starts having a seizure!</span>", "<span class='userdanger'>You have a seizure!</span>")
		M.Unconscious(100)
		M.Jitter(350)

	if(prob(33))
		M.adjustToxLoss(3*REM, 0)
		M.losebreath += 3
		. = 1
	..()

/datum/reagent/medicine/ephedrine/addiction_act_stage3(mob/living/M)
	if(prob(12) && iscarbon(M))
		M.visible_message("<span class='danger'>[M] starts having a seizure!</span>", "<span class='userdanger'>You have a seizure!</span>")
		M.Unconscious(100)
		M.Jitter(350)

	if(prob(33))
		M.adjustToxLoss(4*REM, 0)
		M.losebreath += 4
		. = 1
	..()

/datum/reagent/medicine/ephedrine/addiction_act_stage4(mob/living/M)
	if(prob(24) && iscarbon(M))
		M.visible_message("<span class='danger'>[M] starts having a seizure!</span>", "<span class='userdanger'>You have a seizure!</span>")
		M.Unconscious(100)
		M.Jitter(350)

	if(prob(33))
		M.adjustToxLoss(5*REM, 0)
		M.losebreath += 5
		. = 1
	..()

/datum/reagent/medicine/diphenhydramine
	name = "Diphenhydramine"
	description = "Rapidly purges the body of Histamine and reduces jitteriness. Slight chance of causing drowsiness."
	reagent_state = LIQUID
	color = "#64FFE6"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/diphenhydramine/on_mob_life(mob/living/carbon/M)
	if(prob(10))
		M.drowsyness += 1
	M.jitteriness -= 1
	M.reagents.remove_reagent(/datum/reagent/toxin/histamine,3)
	..()

/datum/reagent/medicine/morphine
	name = "Morphine"
	description = "A painkiller that allows the patient to move at full speed even in bulky objects. Causes drowsiness and eventually unconsciousness in high doses. Overdose will cause a variety of effects, ranging from minor to lethal."
	reagent_state = LIQUID
	color = "#A9FBFB"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 30
	addiction_threshold = 25

/datum/reagent/medicine/morphine/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/morphine/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	..()

/datum/reagent/medicine/morphine/on_mob_life(mob/living/carbon/M)
	if(current_cycle >= 5)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_medium, name)
	switch(current_cycle)
		if(11)
			to_chat(M, "<span class='warning'>You start to feel tired...</span>" )
		if(12 to 24)
			M.drowsyness += 1
		if(24 to INFINITY)
			M.Sleeping(40)
			. = 1
	..()

/datum/reagent/medicine/morphine/overdose_process(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.Dizzy(2)
		M.Jitter(2)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage1(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.Jitter(2)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage2(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(1*REM, 0)
		. = 1
		M.Dizzy(3)
		M.Jitter(3)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage3(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(2*REM, 0)
		. = 1
		M.Dizzy(4)
		M.Jitter(4)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage4(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(3*REM, 0)
		. = 1
		M.Dizzy(5)
		M.Jitter(5)
	..()

/datum/reagent/medicine/oculine
	name = "Oculine"
	description = "Quickly restores eye damage, cures nearsightedness, and has a chance to restore vision to the blind."
	reagent_state = LIQUID
	color = "#404040" //oculine is dark grey, inacusiate is light grey
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "dull toxin"

/datum/reagent/medicine/oculine/on_mob_life(mob/living/carbon/M)
	var/obj/item/organ/eyes/eyes = M.getorganslot(ORGAN_SLOT_EYES)
	if (!eyes)
		return
	eyes.applyOrganDamage(-2)
	if(HAS_TRAIT_FROM(M, TRAIT_BLIND, EYE_DAMAGE))
		if(prob(20))
			to_chat(M, "<span class='warning'>Your vision slowly returns...</span>")
			M.cure_blind(EYE_DAMAGE)
			M.cure_nearsighted(EYE_DAMAGE)
			M.blur_eyes(35)

	else if(HAS_TRAIT_FROM(M, TRAIT_NEARSIGHT, EYE_DAMAGE))
		to_chat(M, "<span class='warning'>The blackness in your peripheral vision fades.</span>")
		M.cure_nearsighted(EYE_DAMAGE)
		M.blur_eyes(10)
	else if(M.eye_blind || M.eye_blurry)
		M.set_blindness(0)
		M.set_blurriness(0)
	..()

/datum/reagent/medicine/inacusiate
	name = "Inacusiate"
	description = "Instantly restores all hearing to the patient, but does not cure deafness."
	color = "#606060" // ditto

/datum/reagent/medicine/inacusiate/on_mob_life(mob/living/carbon/M)
	M.restoreEars()
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
		M.Dizzy(5)
		M.Jitter(5)
	..()

/datum/reagent/medicine/atropine/overdose_process(mob/living/M)
	M.adjustToxLoss(0.5*REM, 0)
	. = 1
	M.Dizzy(1)
	M.Jitter(1)
	..()

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

/datum/reagent/medicine/strange_reagent
	name = "Strange Reagent"
	description = "A miracle drug capable of bringing the dead back to life. Works topically unless anotamically complex, in which case works orally. Only works if the target has less than 200 total brute and burn damage and hasn't been husked and requires more reagent depending on damage inflicted. Causes damage to the living."
	reagent_state = LIQUID
	color = "#A0E85E"
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "magnets"
	harmful = TRUE

/datum/reagent/medicine/strange_reagent/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(M.stat != DEAD)
		return ..()
	if(M.hellbound) //they are never coming back
		M.visible_message("<span class='warning'>[M]'s body does not react...</span>")
		return
	if(iscarbon(M) && method != INGEST) //simplemobs can still be splashed
		return ..()
	var/amount_to_revive = round((M.getBruteLoss()+M.getFireLoss())/20)
	if(M.getBruteLoss()+M.getFireLoss() >= 200 || HAS_TRAIT(M, TRAIT_HUSK) || reac_volume < amount_to_revive) //body will die from brute+burn on revive or you haven't provided enough to revive.
		M.visible_message("<span class='warning'>[M]'s body convulses a bit, and then falls still once more.</span>")
		M.do_jitter_animation(10)
		return
	M.visible_message("<span class='warning'>[M]'s body starts convulsing!</span>")
	M.notify_ghost_cloning("Your body is being revived with Strange Reagent!")
	M.do_jitter_animation(10)
	var/excess_healing = 5*(reac_volume-amount_to_revive) //excess reagent will heal blood and organs across the board
	addtimer(CALLBACK(M, /mob/living/carbon.proc/do_jitter_animation, 10), 40) //jitter immediately, then again after 4 and 8 seconds
	addtimer(CALLBACK(M, /mob/living/carbon.proc/do_jitter_animation, 10), 80)
	addtimer(CALLBACK(M, /mob/living.proc/revive, FALSE, FALSE, excess_healing), 79)
	..()

/datum/reagent/medicine/strange_reagent/on_mob_life(mob/living/carbon/M)
	var/damage_at_random = rand(0,250)/100 //0 to 2.5
	M.adjustBruteLoss(damage_at_random*REM, FALSE)
	M.adjustFireLoss(damage_at_random*REM, FALSE)
	..()
	. = TRUE

/datum/reagent/medicine/strange_reagent/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 5))
		mytray.spawnplant()

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

/datum/reagent/medicine/mutadone
	name = "Mutadone"
	description = "Removes jitteriness and restores genetic defects."
	color = "#5096C8"
	taste_description = "acid"

/datum/reagent/medicine/mutadone/on_mob_life(mob/living/carbon/M)
	M.jitteriness = 0
	if(M.has_dna())
		M.dna.remove_all_mutations(list(MUT_NORMAL, MUT_EXTRA), TRUE)
	if(!QDELETED(M)) //We were a monkey, now a human
		..()

/datum/reagent/medicine/antihol
	name = "Antihol"
	description = "Purges alcoholic substance from the patient's body and eliminates its side effects."
	color = "#00B4C8"
	taste_description = "raw egg"

/datum/reagent/medicine/antihol/on_mob_life(mob/living/carbon/M)
	M.dizziness = 0
	M.drowsyness = 0
	M.slurring = 0
	M.confused = 0
	M.reagents.remove_all_type(/datum/reagent/consumable/ethanol, 3*REM, 0, 1)
	M.adjustToxLoss(-0.2*REM, 0)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.drunkenness = max(H.drunkenness - 10, 0)
	..()
	. = 1

/datum/reagent/medicine/stimulants
	name = "Stimulants"
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

//Trek Chems, simple to mix but weak as healing. Second tier trekchems will heal faster.
/datum/reagent/medicine/bicaridine
	name = "Bicaridine"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#bf0000"
	overdose_threshold = 30

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
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.bleed_rate = max(H.bleed_rate - 0.25, 0)
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
		M.jitteriness = min(max(0, M.jitteriness + 3), 30)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2 * REM, 150)
		if(prob(10))
			M.say(pick("Yeah, well, you know, that's just, like, uh, your opinion, man.", "Am I glad he's frozen in there and that we're out here, and that he's the sheriff and that we're frozen out here, and that we're in there, and I just remembered, we're out here. What I wanna know is: Where's the caveman?", "It ain't me, it ain't me...", "Make love, not war!", "Stop, hey, what's that sound? Everybody look what's going down...", "Do you believe in magic in a young girl's heart?"), forced = /datum/reagent/medicine/earthsblood)
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

/datum/reagent/medicine/haloperidol
	name = "Haloperidol"
	description = "Increases depletion rates for most stimulating/hallucinogenic drugs. Reduces druggy effects and jitteriness. Severe stamina regeneration penalty, causes drowsiness. Small chance of brain damage."
	reagent_state = LIQUID
	color = "#27870a"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM

/datum/reagent/medicine/haloperidol/on_mob_life(mob/living/carbon/M)
	for(var/datum/reagent/drug/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,5)
	M.drowsyness += 2
	if(M.jitteriness >= 3)
		M.jitteriness -= 3
	if (M.hallucination >= 5)
		M.hallucination -= 5
	if(prob(20))
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1*REM, 50)
	M.adjustStaminaLoss(2.5*REM, 0)
	..()
	return TRUE

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

//used for changeling's adrenaline power
/datum/reagent/medicine/changelingadrenaline
	name = "Changeling Adrenaline"
	description = "Reduces the duration of unconciousness, knockdown and stuns. Restores stamina, but deals toxin damage when overdosed."
	color = "#C1151D"
	overdose_threshold = 30

/datum/reagent/medicine/changelingadrenaline/on_mob_life(mob/living/carbon/M as mob)
	..()
	M.AdjustAllImmobility(-20)
	M.adjustStaminaLoss(-10, 0)
	M.Jitter(10)
	M.Dizzy(10)
	return TRUE

/datum/reagent/medicine/changelingadrenaline/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	ADD_TRAIT(L, TRAIT_STUNRESISTANCE, type)
	L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/changelingadrenaline/on_mob_end_metabolize(mob/living/L)
	..()
	REMOVE_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	REMOVE_TRAIT(L, TRAIT_STUNRESISTANCE, type)
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	L.Dizzy(0)
	L.Jitter(0)

/datum/reagent/medicine/changelingadrenaline/overdose_process(mob/living/M as mob)
	M.adjustToxLoss(1, 0)
	..()
	return TRUE

/datum/reagent/medicine/changelinghaste
	name = "Changeling Haste"
	description = "Drastically increases movement speed, but deals toxin damage."
	color = "#AE151D"
	metabolization_rate = 1

/datum/reagent/medicine/changelinghaste/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/changelinghaste)

/datum/reagent/medicine/changelinghaste/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/changelinghaste)
	..()

/datum/reagent/medicine/changelinghaste/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(2, 0)
	..()
	return TRUE

/datum/reagent/medicine/corazone
	// Heart attack code will not do damage if corazone is present
	// because it's SPACE MAGIC ASPIRIN
	name = "Corazone"
	description = "A medication used to treat pain, fever, and inflammation, along with heart attacks. Can also be used to stabilize livers."
	color = "#F49797"
	self_consuming = TRUE

/datum/reagent/medicine/corazone/on_mob_metabolize(mob/living/M)
	..()
	ADD_TRAIT(M, TRAIT_STABLEHEART, type)
	ADD_TRAIT(M, TRAIT_STABLELIVER, type)

/datum/reagent/medicine/corazone/on_mob_end_metabolize(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_STABLEHEART, type)
	REMOVE_TRAIT(M, TRAIT_STABLELIVER, type)

/datum/reagent/medicine/cordiolis_hepatico
	name = "Cordiolis Hepatico"
	description = "A strange, pitch-black reagent that seems to absorb all light. Effects unknown."
	color = "#000000"
	self_consuming = TRUE

/datum/reagent/medicine/cordiolis_hepatico/on_mob_add(mob/living/M)
	..()
	ADD_TRAIT(M, TRAIT_STABLELIVER, type)
	ADD_TRAIT(M, TRAIT_STABLEHEART, type)

/datum/reagent/medicine/cordiolis_hepatico/on_mob_end_metabolize(mob/living/M)
	..()
	REMOVE_TRAIT(M, TRAIT_STABLEHEART, type)
	REMOVE_TRAIT(M, TRAIT_STABLELIVER, type)

/datum/reagent/medicine/muscle_stimulant
	name = "Muscle Stimulant"
	description = "A potent chemical that allows someone under its influence to be at full physical ability even when under massive amounts of pain."

/datum/reagent/medicine/muscle_stimulant/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/muscle_stimulant/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/modafinil
	name = "Modafinil"
	description = "Long-lasting sleep suppressant that very slightly reduces stun and knockdown times. Overdosing has horrendous side effects and deals lethal oxygen damage, will knock you unconscious if not dealt with."
	reagent_state = LIQUID
	color = "#BEF7D8" // palish blue white
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 20 // with the random effects this might be awesome or might kill you at less than 10u (extensively tested)
	taste_description = "salt" // it actually does taste salty
	var/overdose_progress = 0 // to track overdose progress

/datum/reagent/medicine/modafinil/on_mob_metabolize(mob/living/M)
	ADD_TRAIT(M, TRAIT_SLEEPIMMUNE, type)
	..()

/datum/reagent/medicine/modafinil/on_mob_end_metabolize(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_SLEEPIMMUNE, type)
	..()

/datum/reagent/medicine/modafinil/on_mob_life(mob/living/carbon/M)
	if(!overdosed) // We do not want any effects on OD
		overdose_threshold = overdose_threshold + rand(-10,10)/10 // for extra fun
		M.AdjustAllImmobility(-5)
		M.adjustStaminaLoss(-0.5*REM, 0)
		M.Jitter(1)
		metabolization_rate = 0.01 * REAGENTS_METABOLISM * rand(5,20) // randomizes metabolism between 0.02 and 0.08 per tick
		. = TRUE
	..()

/datum/reagent/medicine/modafinil/overdose_start(mob/living/M)
	to_chat(M, "<span class='userdanger'>You feel awfully out of breath and jittery!</span>")
	metabolization_rate = 0.025 * REAGENTS_METABOLISM // sets metabolism to 0.01 per tick on overdose

/datum/reagent/medicine/modafinil/overdose_process(mob/living/M)
	overdose_progress++
	switch(overdose_progress)
		if(1 to 40)
			M.jitteriness = min(M.jitteriness+1, 10)
			M.stuttering = min(M.stuttering+1, 10)
			M.Dizzy(5)
			if(prob(50))
				M.losebreath++
		if(41 to 80)
			M.adjustOxyLoss(0.1*REM, 0)
			M.adjustStaminaLoss(0.1*REM, 0)
			M.jitteriness = min(M.jitteriness+1, 20)
			M.stuttering = min(M.stuttering+1, 20)
			M.Dizzy(10)
			if(prob(50))
				M.losebreath++
			if(prob(20))
				to_chat(M, "<span class='userdanger'>You have a sudden fit!</span>")
				M.emote("moan")
				M.Paralyze(20) // you should be in a bad spot at this point unless epipen has been used
		if(81)
			to_chat(M, "<span class='userdanger'>You feel too exhausted to continue!</span>") // at this point you will eventually die unless you get charcoal
			M.adjustOxyLoss(0.1*REM, 0)
			M.adjustStaminaLoss(0.1*REM, 0)
		if(82 to INFINITY)
			M.Sleeping(100)
			M.adjustOxyLoss(1.5*REM, 0)
			M.adjustStaminaLoss(1.5*REM, 0)
	..()
	return TRUE

/datum/reagent/medicine/psicodine
	name = "Psicodine"
	description = "Suppresses anxiety and other various forms of mental distress. Overdose causes hallucinations and minor toxin damage."
	reagent_state = LIQUID
	color = "#07E79E"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30

/datum/reagent/medicine/psicodine/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_FEARLESS, type)

/datum/reagent/medicine/psicodine/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_FEARLESS, type)
	..()

/datum/reagent/medicine/psicodine/on_mob_life(mob/living/carbon/M)
	M.jitteriness = max(0, M.jitteriness-6)
	M.dizziness = max(0, M.dizziness-6)
	M.confused = max(0, M.confused-6)
	M.disgust = max(0, M.disgust-6)
	var/datum/component/mood/mood = M.GetComponent(/datum/component/mood)
	if(mood.sanity <= SANITY_NEUTRAL) // only take effect if in negative sanity and then...
		mood.setSanity(min(mood.sanity+5, SANITY_NEUTRAL)) // set minimum to prevent unwanted spiking over neutral
	..()
	. = 1

/datum/reagent/medicine/psicodine/overdose_process(mob/living/M)
	M.hallucination = min(max(0, M.hallucination + 5), 60)
	M.adjustToxLoss(1, 0)
	..()
	. = 1

/datum/reagent/medicine/metafactor
	name = "Mitogen Metabolism Factor"
	description = "This enzyme catalyzes the conversion of nutricious food into healing peptides."
	metabolization_rate = 0.0625  * REAGENTS_METABOLISM //slow metabolism rate so the patient can self heal with food even after the troph has metabolized away for amazing reagent efficency.
	reagent_state = SOLID
	color = "#FFBE00"
	overdose_threshold = 10

/datum/reagent/medicine/metafactor/overdose_start(mob/living/carbon/M)
	metabolization_rate = 2  * REAGENTS_METABOLISM

/datum/reagent/medicine/metafactor/overdose_process(mob/living/carbon/M)
	if(prob(25))
		M.vomit()
	..()

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

/datum/reagent/medicine/polypyr  //This is intended to be an ingredient in advanced chems.
	name = "Polypyrylium Oligomers"
	description = "A purple mixture of short polyelectrolyte chains not easily synthesized in the laboratory. It is valued as an intermediate in the synthesis of the cutting edge pharmaceuticals."
	reagent_state = SOLID
	color = "#9423FF"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM
	overdose_threshold = 50
	taste_description = "numbing bitterness"

/datum/reagent/medicine/polypyr/on_mob_life(mob/living/carbon/M) //I wanted a collection of small positive effects, this is as hard to obtain as coniine after all.
	M.adjustOrganLoss(ORGAN_SLOT_LUNGS, -0.25)
	M.adjustBruteLoss(-0.5, 0)
	if(prob(50))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			H.bleed_rate = max(H.bleed_rate - 2, 0)
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

/datum/reagent/medicine/carthatoline
	name = "Carthatoline"
	description = "An evacuant that induces vomiting and purges toxins, as well as healing toxin damage. Superior to Dylovene. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#225722"
	overdose_threshold = 25

/datum/reagent/medicine/carthatoline/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-2*REM, 0)
	if(M.getToxLoss() && prob(10))
		M.vomit(1)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,2)
	..()
	. = 1

/datum/reagent/medicine/carthatoline/overdose_process(mob/living/M)
	M.adjustToxLoss(6*REM, 0) // End result is 4 toxin loss taken. Do your own math.
	..()
	. = 1

/* /datum/reagent/medicine/hepanephrodaxon	//WS edit: Temporary removal of overloaded chem
	name = "Hepanephrodaxon"
	description = "Used to repair the common tissues involved in filtration."
	taste_description = "glue"
	reagent_state = LIQUID
	color = "#D2691E"
	metabolization_rate = REM * 1.5
	overdose_threshold = 10

/datum/reagent/medicine/hepanephrodaxon/on_mob_life(mob/living/carbon/M)
	var/repair_strength = 1
	var/obj/item/organ/liver/L = M.getorganslot(ORGAN_SLOT_LIVER)
	if(L.damage > 0)
		L.damage = max(L.damage - 4 * repair_strength, 0)
		M.confused = (2)
	M.adjustToxLoss(-12)
	..()
	if(prob(30) && iscarbon(M))
		var/obj/item/I = M.get_active_held_item()
		if(I && M.dropItemToGround(I))
			to_chat(M, "<span class='notice'>Your hands spaz out and you drop what you were holding!</span>")
	M.adjustStaminaLoss(-10, 0)
	M.Jitter(10)
	M.Dizzy(15)

/datum/reagent/medicine/hepanephrodaxon/overdose_process(mob/living/M)
	var/obj/item/organ/liver/L = M.getorganslot(ORGAN_SLOT_LIVER)
	L.damage = max(L.damage + 4, 0)
	M.confused = (2)
	..()
	ADD_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	ADD_TRAIT(L, TRAIT_STUNRESISTANCE, type)
	M.add_movespeed_modifier(/datum/movespeed_modifier/reagent/hepanephrodaxon) */

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
			for(var/obj/item/bodypart/B in C.bodyparts)
				B.fix_bone()
			for(var/obj/item/organ/O in C.internal_organs)
				O.damage = 0
			holder.remove_reagent(/datum/reagent/medicine/bonefixingjuice, 10)
	..()

/datum/reagent/medicine/converbital
	name = "Converbital"
	description = "A substance capable of regenerating torn flesh, however, due to its extremely exothermic nature, use may result in burns"
	reagent_state = LIQUID
	taste_description = "burning"
	color = "#7a1f13"
	metabolization_rate = REM * 1
	overdose_threshold = 25

/datum/reagent/medicine/converbital/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, VAPOR, INJECT))
			M.adjustFireLoss(0.5*reac_volume)
			if(show_message)
				to_chat(M, "<span class='warning'>You feel a slight burning sensation...</span>")
		else if(M.getBruteLoss())
			M.adjustBruteLoss(-reac_volume)
			M.adjustFireLoss(reac_volume)
			if(show_message)
				to_chat(M, "<span class='danger'>You feel your skin bubble and burn as your flesh knits itself together!</span>")
			M.emote("scream")
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
	..()

/datum/reagent/medicine/converbital/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(0.25*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/converbital/overdose_process(mob/living/M)
	M.adjustFireLoss(2.5*REM, 0)
	M.adjustToxLoss(0.5, 0)
	..()
	. = 1

/datum/reagent/medicine/convuri
	name = "Convuri"
	description = "A substance capable of regenerating burnt skin with ease, however, the speed at which it does this has been known to cause muscular tearing"
	reagent_state = SOLID
	taste_description = "white-hot pain"
	color = "#b85505"
	metabolization_rate = REM * 1
	overdose_threshold = 25

/datum/reagent/medicine/convuri/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, VAPOR, INJECT))
			M.adjustBruteLoss(0.5*reac_volume)
			if(show_message)
				to_chat(M, "<span class='warning'>You feel a slight tearing sensation...</span>")
		else if(M.getBruteLoss())
			M.adjustFireLoss(-reac_volume)
			M.adjustBruteLoss(reac_volume)
			if(show_message)
				to_chat(M, "<span class='danger'>You feel your flesh tear as your skin rapidly regenerates!</span>")
			M.emote("scream")
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
	..()

/datum/reagent/medicine/convuri/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(0.25*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/convuri/overdose_process(mob/living/M)
	M.adjustBruteLoss(2.5*REM, 0)
	M.adjustToxLoss(0.5, 0)
	..()
	. = 1

/datum/reagent/medicine/trophazole
	name = "Trophazole"
	description = "Orginally developed as fitness supplement, this chemical accelerates wound healing and if ingested turns nutriment into healing peptides"
	reagent_state = LIQUID
	color = "#FFFF6B"
	overdose_threshold = 20

/datum/reagent/medicine/trophazole/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-1.5*REM, 0.) // heals 3 brute & 0.5 burn if taken with food. compared to 2.5 brute from bicard + nutriment
	..()
	. = 1

/datum/reagent/medicine/trophazole/overdose_process(mob/living/M)
	M.adjustBruteLoss(3*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/trophazole/on_transfer(atom/A, method=INGEST, trans_volume)
	if(method != INGEST || !iscarbon(A))
		return

	A.reagents.remove_reagent(/datum/reagent/medicine/trophazole, trans_volume * 0.05)
	A.reagents.add_reagent(/datum/reagent/medicine/metafactor, trans_volume * 0.25)

	..()


/datum/reagent/medicine/rhigoxane
	name = "Rhigoxane"
	description = "A second generation burn treatment agent exhibiting a cooling effect that is especially pronounced when deployed as a spray. Its high halogen content helps extinguish fires."
	reagent_state = LIQUID
	color = "#F7FFA5"
	overdose_threshold = 25
	reagent_weight = 0.6

/datum/reagent/medicine/rhigoxane/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-2*REM, 0.)
	M.adjust_bodytemperature(-20 * TEMPERATURE_DAMAGE_COEFFICIENT, M.dna.species.bodytemp_normal)
	..()
	. = 1

/datum/reagent/medicine/rhigoxane/expose_mob(mob/living/carbon/M, method=VAPOR, reac_volume)
	if(method != VAPOR)
		return

	M.adjust_bodytemperature(-reac_volume * TEMPERATURE_DAMAGE_COEFFICIENT * 20, 200)
	M.adjust_fire_stacks(-reac_volume / 2)
	if(reac_volume >= metabolization_rate)
		M.ExtinguishMob()

	..()

/datum/reagent/medicine/rhigoxane/overdose_process(mob/living/carbon/M)
	M.adjustFireLoss(3*REM, 0.)
	M.adjust_bodytemperature(-35 * TEMPERATURE_DAMAGE_COEFFICIENT, 50)
	..()


/datum/reagent/medicine/thializid
	name = "Thializid"
	description = "A potent antidote for intravenous use with a narrow therapeutic index, it is considered an active prodrug of oxalizid."
	reagent_state = LIQUID
	color = "#8CDF24" // heavy saturation to make the color blend better
	metabolization_rate = 0.75 * REAGENTS_METABOLISM
	overdose_threshold = 6
	var/conversion_amount

/datum/reagent/medicine/thializid/on_transfer(atom/A, method=INJECT, trans_volume)
	if(method != INJECT || !iscarbon(A))
		return
	var/mob/living/carbon/C = A
	if(trans_volume >= 0.6) //prevents cheesing with ultralow doses.
		C.adjustToxLoss(-1.5 * min(2, trans_volume) * REM, 0)	  //This is to promote iv pole use for that chemotherapy feel.
	var/obj/item/organ/liver/L = C.internal_organs_slot[ORGAN_SLOT_LIVER]
	if((L.organ_flags & ORGAN_FAILING) || !L)
		return
	conversion_amount = trans_volume * (min(100 -C.getOrganLoss(ORGAN_SLOT_LIVER), 80) / 100) //the more damaged the liver the worse we metabolize.
	C.reagents.remove_reagent(/datum/reagent/medicine/thializid, conversion_amount)
	C.reagents.add_reagent(/datum/reagent/medicine/oxalizid, conversion_amount)
	..()

/datum/reagent/medicine/thializid/on_mob_life(mob/living/carbon/M)
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 0.8)
	M.adjustToxLoss(-1*REM, 0)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,1)

	..()
	. = 1

/datum/reagent/medicine/thializid/overdose_process(mob/living/carbon/M)
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 1.5)
	M.adjust_disgust(3)
	M.reagents.add_reagent(/datum/reagent/medicine/oxalizid, 0.225 * REM)
	..()
	. = 1

/datum/reagent/medicine/oxalizid
	name = "Oxalizid"
	description = "The active metabolite of thializid. Causes muscle weakness on overdose"
	reagent_state = LIQUID
	color = "#DFD54E"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 25
	var/datum/brain_trauma/mild/muscle_weakness/U

/datum/reagent/medicine/oxalizid/on_mob_life(mob/living/carbon/M)
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 0.1)
	M.adjustToxLoss(-1*REM, 0)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,1)
	..()
	. = 1

/datum/reagent/medicine/oxalizid/overdose_start(mob/living/carbon/M)
	U = new()
	M.gain_trauma(U, TRAUMA_RESILIENCE_ABSOLUTE)
	..()

/datum/reagent/medicine/oxalizid/on_mob_delete(mob/living/carbon/M)
	if(U)
		QDEL_NULL(U)
	return ..()

/datum/reagent/medicine/oxalizid/overdose_process(mob/living/carbon/M)
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 1.5)
	M.adjust_disgust(3)
	..()
	. = 1

/datum/reagent/medicine/soulus
	name = "Soulus Dust"
	description = "Ground legion cores. The dust quickly seals wounds yet slowly causes the tissue to undergo necrosis."
	reagent_state = SOLID
	color = "#302f20"
	metabolization_rate = REAGENTS_METABOLISM * 0.8
	overdose_threshold = 100
	var/clone_dam = 0.25

/datum/reagent/medicine/soulus/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, INJECT))
			M.jitteriness += reac_volume
			if(M.getFireLoss())
				M.adjustFireLoss(-reac_volume*1.2)
			if(M.getBruteLoss())
				M.adjustBruteLoss(-reac_volume*1.2)
	if(prob(50))
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "legion", /datum/mood_event/legion_good, name)
	else
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "legion", /datum/mood_event/legion_bad, name)
	..()

/datum/reagent/medicine/soulus/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-0.1*REM, 0)
	M.adjustBruteLoss(-0.1*REM, 0)
	M.adjustCloneLoss(clone_dam *REM, 0)
	..()

/datum/reagent/medicine/soulus/overdose_process(mob/living/M)
	M.ForceContractDisease(new /datum/disease/transformation/legionvirus(), FALSE, TRUE)
	..()

/datum/reagent/medicine/soulus/on_mob_end_metabolize(mob/living/M)
	SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "legion")
	..()

/datum/reagent/medicine/soulus/pure
	name = "Purified Soulus Dust"
	description = "Ground legion cores."
	reagent_state = SOLID
	color = "#302f20"
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 100
	clone_dam = 0

/datum/reagent/medicine/puce_essence		// P U C E
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

/datum/reagent/medicine/lavaland_extract
	name = "Lavaland Extract"
	description = "An extract of lavaland atmospheric and mineral elements. Heals the user in small doses, but is extremely toxic otherwise."
	color = "#6B372E" //dark and red like lavaland
	metabolization_rate = REAGENTS_METABOLISM * 0.5
	overdose_threshold = 10

/datum/reagent/medicine/lavaland_extract/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	ADD_TRAIT(M, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	..()

/datum/reagent/medicine/lavaland_extract/on_mob_end_metabolize(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	..()

/datum/reagent/medicine/lavaland_extract/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-1*REM, 0)
	M.adjustBruteLoss(-1*REM, 0)
	M.adjustToxLoss(-1*REM, 0)
	if(M.health <= M.crit_threshold)
		M.adjustOxyLoss(-1*REM, 0)
	..()
	return TRUE

/datum/reagent/medicine/lavaland_extract/overdose_process(mob/living/M)		// Thanks to actioninja
	if(prob(2) && iscarbon(M))
		var/selected_part = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		var/obj/item/bodypart/bp = M.get_bodypart(selected_part)
		if(bp)
			M.visible_message("<span class='warning'>[M] feels a spike of pain!!</span>", "<span class='danger'>You feel a spike of pain!!</span>")
			bp.receive_damage(0, 0, 200)
		else	//SUCH A LUST FOR REVENGE!!!
			to_chat(M, "<span class='warning'>A phantom limb hurts!</span>")
			M.say("Why are we still here, just to suffer?", forced = /datum/reagent/medicine/lavaland_extract)
	return ..()

/datum/reagent/medicine/skeletons_boon
	name = "Skeleton’s Boon"
	description = "A robust solution of minerals that greatly strengthens the bones."
	color = "#dbdfa2"
	metabolization_rate = REAGENTS_METABOLISM * 0.125
	overdose_threshold = 50
	var/plasma_armor = 33
	var/skele_armor = 20
	var/added_armor = 0

/datum/reagent/medicine/skeletons_boon/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	ADD_TRAIT(M, TRAIT_NOBREAK, TRAIT_GENERIC)
	if(isplasmaman(M))
		var/mob/living/carbon/human/H = M
		H.physiology.armor.melee += plasma_armor
		H.physiology.armor.bullet += plasma_armor
		added_armor = plasma_armor
	if(isskeleton(M))
		var/mob/living/carbon/human/H = M
		H.physiology.armor.melee += skele_armor
		H.physiology.armor.bullet += skele_armor
		added_armor = skele_armor
	..()

/datum/reagent/medicine/skeletons_boon/on_mob_end_metabolize(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_NOBREAK, TRAIT_GENERIC)
	REMOVE_TRAIT(M, TRAIT_ALLBREAK, TRAIT_GENERIC)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.physiology.armor.melee -= added_armor
		H.physiology.armor.bullet -= added_armor		// No, you can't change species to get a permanant brute resist
	..()

/datum/reagent/medicine/skeletons_boon/overdose_process(mob/living/M)
	ADD_TRAIT(M, TRAIT_ALLBREAK, TRAIT_GENERIC)
	REMOVE_TRAIT(M, TRAIT_NOBREAK, TRAIT_GENERIC)
	..()

/datum/reagent/medicine/molten_bubbles
	name = "Molten Bubbles"
	description = "Refreshing softdrink made for the desert."
	color = "#3d1916"
	metabolization_rate = REAGENTS_METABOLISM
	taste_description = "boiling sugar"

/datum/reagent/medicine/molten_bubbles/on_mob_life(mob/living/carbon/M)
	M.heal_bodypart_damage(1,1,0)
	if(M.bodytemperature > M.get_body_temp_normal(apply_change=FALSE))
		M.adjust_bodytemperature(-10 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal(apply_change=FALSE))
	else if(M.bodytemperature < (M.get_body_temp_normal(apply_change=FALSE) + 1))
		M.adjust_bodytemperature(10 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal(apply_change=FALSE))
	..()

/datum/reagent/medicine/molten_bubbles/plasma
	name = "Plasma Bubbles"
	description = "Molten Bubbles with the refreshing taste of plasma."
	color = "#852e63"
	taste_description = "grape flavored cleaning solution"

/datum/reagent/medicine/molten_bubbles/sand
	name = "Sandblast Sarsaparilla"
	description = "Extra refreshing for those long desert days."
	color = "#af9938"
	taste_description = "root-beer and asbestos"
