// Category 2 medicines are medicines that have an ill effect regardless of volume/OD to dissuade doping. Mostly used as emergency chemicals OR to convert damage (and heal a bit in the process). The type is used to prompt borgs that the medicine is harmful.
/datum/reagent/medicine/c2
	name = "Category two reagent"
	harmful = TRUE
	metabolization_rate = 0.2

/******TOXIN******/
/*Suffix: -iver*/

/datum/reagent/medicine/c2/seiver //a bit of a gray joke
	name = "Seiver"
	description = "A medicine that shifts functionality based on temperature. Colder temperatures incurs radiation removal while hotter temperatures promote antitoxicity. Damages the heart." //CHEM HOLDER TEMPS, NOT AIR TEMPS
	var/radbonustemp = (T0C - 100) //being below this number gives you 10% off rads.

/datum/reagent/medicine/c2/seiver/on_mob_metabolize(mob/living/carbon/human/M)
	. = ..()
	radbonustemp = rand(radbonustemp - 50, radbonustemp + 50) // Basically this means 50K and below will always give the percent heal, and upto 150K could. Calculated once.

/datum/reagent/medicine/c2/seiver/on_mob_life(mob/living/carbon/human/M)
	var/chemtemp = min(holder.chem_temp, 1000)
	chemtemp = chemtemp ? chemtemp : 273 //why do you have null sweaty
	var/healypoints = 0 //5 healypoints = 1 heart damage; 5 rads = 1 tox damage healed for the purpose of healypoints

	//you're hot
	var/toxcalc = min(round((chemtemp-1000)/175+5,0.1),5) //max 5 tox healing a tick
	if(toxcalc > 0)
		M.adjustToxLoss(toxcalc*-1)
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

/datum/reagent/medicine/c2/multiver //enhanced with MULTIple medicines
	name = "Multiver"
	description = "A chem-purger that becomes more effective the more unique medicines present. Slightly heals toxicity but causes lung damage (mitigatable by unique medicines)."

/datum/reagent/medicine/c2/multiver/on_mob_life(mob/living/carbon/human/M)
	var/medibonus = 0 //it will always have itself which makes it REALLY start @ 1
	for(var/r in M.reagents.reagent_list)
		var/datum/reagent/the_reagent = r
		if(istype(the_reagent, /datum/reagent/medicine))
			medibonus += 1
	M.adjustToxLoss(-0.5 * min(medibonus, 3)) //not great at healing but if you have nothing else it will work
	M.adjustOrganLoss(ORGAN_SLOT_LUNGS, 0.5) //kills at 40u
	for(var/r2 in M.reagents.reagent_list)
		var/datum/reagent/the_reagent2 = r2
		if(the_reagent2 == src)
			continue
		var/amount2purge = 3
		if(medibonus >= 3 && istype(the_reagent2, /datum/reagent/medicine)) //3 unique meds (2+multiver) will make it not purge medicines
			continue
		M.reagents.remove_reagent(the_reagent2.type, amount2purge)
	..()
	return TRUE

/******ORGAN HEALING******/
/*Suffix: -rite*/



/******NICHE******/
//todo
