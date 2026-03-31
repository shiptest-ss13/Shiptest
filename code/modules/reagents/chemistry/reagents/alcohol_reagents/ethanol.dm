//////////////
// ALCOHOLS //
//////////////

/datum/reagent/consumable/ethanol
	name = "Ethanol"
	description = "A well-known alcohol with a variety of applications."
	color = "#404030" // rgb: 64, 64, 48
	nutriment_factor = 0
	taste_description = "alcohol"
	metabolization_rate = ETHANOL_METABOLISM
	var/boozepwr = 65 //Higher numbers equal higher hardness, higher hardness equals more intense alcohol poisoning
	accelerant_quality = 5

/datum/reagent/consumable/ethanol/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(src, 1))
		mytray.adjustHealth(-round(chems.get_reagent_amount(type) * 0.05))
		mytray.adjustPests(-round(boozepwr * 0.05))


// -CHART OUT OF DATE- -ERIKA //

/*
Boozepwr Chart
Note that all higher effects of alcohol poisoning will inherit effects for smaller amounts (i.e. light poisoning inherts from slight poisoning)
In addition, severe effects won't always trigger unless the drink is poisonously strong
All effects don't start immediately, but rather get worse over time; the rate is affected by the imbiber's alcohol tolerance

0: Non-alcoholic
1-10: Barely classifiable as alcohol - occassional slurring
11-20: Slight alcohol content - slurring
21-30: Below average - imbiber begins to look slightly drunk
31-40: Just below average - no unique effects
41-50: Average - mild disorientation, imbiber begins to look drunk
51-60: Just above average - disorientation, vomiting, imbiber begins to look heavily drunk
61-70: Above average - small chance of blurry vision, imbiber begins to look smashed
71-80: High alcohol content - blurry vision, imbiber completely shitfaced
81-90: Extremely high alcohol content - heavy toxin damage, passing out
91-100: Dangerously toxic - swift death
*/

/datum/reagent/consumable/ethanol/on_mob_life(mob/living/carbon/drinker)
	if(drinker.get_drunk_amount() < volume * boozepwr * ALCOHOL_THRESHOLD_MODIFIER || boozepwr < 0)
		var/booze_power = boozepwr
		if(HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE)) //we're an accomplished drinker
			booze_power *= 0.7
		if(HAS_TRAIT(drinker, TRAIT_LIGHT_DRINKER))
			booze_power *= 2
		// Volume, power, and server alcohol rate effect how quickly one gets drunk
		drinker.adjust_drunk_effect(sqrt(volume) * booze_power * ALCOHOL_RATE * REM)
		if(boozepwr > 0)
			var/obj/item/organ/liver/drinker_liver = drinker.getorganslot(ORGAN_SLOT_LIVER)
			if (istype(drinker_liver))
				drinker_liver.applyOrganDamage(((max(sqrt(volume) * (boozepwr ** ALCOHOL_EXPONENT) * drinker_liver.alcohol_tolerance, 0))/150))
	return ..()

/datum/reagent/consumable/ethanol/expose_obj(obj/O, reac_volume)
	if(istype(O, /obj/item/paper))
		var/obj/item/paper/paperaffected = O
		paperaffected.clear_paper()
		to_chat(usr, span_notice("[paperaffected]'s ink washes away."))
	if(istype(O, /obj/item/book))
		if(reac_volume >= 5)
			var/obj/item/book/affectedbook = O
			affectedbook.dat = null
			O.visible_message(span_notice("[O]'s writing is washed away by [name]!"))
		else
			O.visible_message(span_warning("[O]'s ink is smeared by [name], but doesn't wash away!"))
	return

/datum/reagent/consumable/ethanol/expose_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with ethanol isn't quite as good as fuel.
	if(!isliving(M))
		return

	if(method in list(TOUCH, VAPOR, PATCH))
		M.adjust_fire_stacks(reac_volume / 15)

		if(iscarbon(M))
			var/mob/living/carbon/C = M
			var/power_multiplier = boozepwr / 65 // Weak alcohol has less sterilizing power

			for(var/s in C.surgeries)
				var/datum/surgery/S = s
				S.speed_modifier = max(0.1*power_multiplier, S.speed_modifier)
	return ..()
