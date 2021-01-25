/datum/reagent/consumable/laughsyrup
	name = "Laughin' Syrup"
	description = "The product of juicing Laughin' Peas. Fizzy, and seems to change flavour based on what it's used with!"
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#803280"
	taste_mult = 2
	taste_description = "fizzy sweetness"

/datum/reagent/consumable/pyre_elementum
	name = "Pyre Elementum"
	description = "This is what makes Fireblossoms even hotter."
	color = "#d30639"
	taste_description = "burning heat"
	taste_mult = 8.0
	nutriment_factor = -1 * REAGENTS_METABOLISM
	var/ingested = FALSE

/datum/reagent/consumable/pyre_elementum/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == INGEST)
		ingested = TRUE
		return
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "pyre_elementum", /datum/mood_event/irritate, name)		// Applied if not eaten
	if(method == TOUCH || method == VAPOR)
		M.adjust_fire_stacks(reac_volume / 5)
		return
	..()

/datum/reagent/consumable/pyre_elementum/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal())		// Doesn't kill you like capsaicin
	if(!ingested)							// Unless you didn't eat it
		M.adjustFireLoss(0.25*REM, 0)
	..()

/datum/reagent/consumable/pyre_elementum/on_mob_end_metabolize(mob/living/M)
	SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "pyre_elementum")
	..()

/datum/reagent/consumable/fervor
	name = "Fervor Ignium"
	description = "Healing chem made from mushrooms."
	color = "#b6a076"
	taste_description = "mushrooms"
	nutriment_factor = -1 * REAGENTS_METABOLISM

/datum/reagent/consumable/fervor/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustBruteLoss(-2*REM, 0)
		M.adjustFireLoss(-2*REM, 0)
	M.adjustStaminaLoss(-5*REM, 0)
	..()
