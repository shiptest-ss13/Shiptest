/obj/item/organ/lungs
	var/failed = FALSE
	var/operated = FALSE	//whether we can still have our damages fixed through surgery
	name = "lungs"
	icon_state = "lungs"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_LUNGS
	gender = PLURAL
	w_class = WEIGHT_CLASS_SMALL

	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = STANDARD_ORGAN_DECAY

	low_threshold_passed = span_warning("You feel short of breath.")
	high_threshold_passed = span_warning("You feel some sort of constriction around your chest as your breathing becomes shallow and rapid.")
	now_fixed = span_warning("Your lungs seem to once again be able to hold air.")
	low_threshold_cleared = span_info("You can breathe normally again.")
	high_threshold_cleared = span_info("The constriction around your chest loosens as your breathing calms down.")


	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue = 5, /datum/reagent/medicine/salbutamol = 5)

	//Breath damage

	var/breathing_class = BREATH_OXY // can be a gas instead of a breathing class
	var/safe_breath_min = 16
	var/safe_breath_max = 50
	var/safe_breath_dam_min = MIN_TOXIC_GAS_DAMAGE
	var/safe_breath_dam_max = MAX_TOXIC_GAS_DAMAGE
	var/safe_damage_type = OXY
	var/list/gas_min = list()
	var/list/gas_max = list(
		GAS_CO2 = 30, // Yes it's an arbitrary value who cares?
		GAS_PLASMA = MOLES_GAS_VISIBLE
	)
	var/list/gas_damage = list(
		"default" = list(
			min = MIN_TOXIC_GAS_DAMAGE,
			max = MAX_TOXIC_GAS_DAMAGE,
			damage_type = OXY
		),
		GAS_PLASMA = list(
			min = MIN_TOXIC_GAS_DAMAGE,
			max = MAX_TOXIC_GAS_DAMAGE,
			damage_type = TOX
		)
	)

	var/SA_para_min = 1 //nitrous values
	var/SA_sleep_min = 5
	var/BZ_trip_balls_min = 0.1 //BZ gas
	var/BZ_brain_damage_min = 1
	var/gas_stimulation_min = 0.002 //Nitryl, Stimulum and Freon

	/// All incoming breaths will have their pressure multiplied against this. Higher values allow more air to be breathed at once,
	/// while lower values can cause suffocation in low pressure environments.
	var/received_pressure_mult = 1

	var/cold_message = "your face freezing and an icicle forming"
	var/chilly_message = "chilly air"
	var/chlly_threshold = T20C-20
	var/cold_level_1_threshold = 240
	var/cold_level_2_threshold = 220
	var/cold_level_3_threshold = 200
	var/cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	var/cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	var/cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	var/cold_damage_type = BURN

	var/hot_message = "your face burning and a searing heat"
	var/warm_message = "warm air"
	var/warm_threshold = T20C+20
	var/heat_level_1_threshold = 323
	var/heat_level_2_threshold = 335
	var/heat_level_3_threshold = 350
	var/heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_1
	var/heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	var/heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	var/heat_damage_type = BURN

	var/crit_stabilizing_reagent = /datum/reagent/medicine/epinephrine

	///Can we smell odors? If false then we don't smell certain gases
	var/can_smell = TRUE

/obj/item/organ/lungs/New()
	. = ..()
	populate_gas_info()

/obj/item/organ/lungs/Insert(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	if(.)
		update_bronchodilation_alerts()

/obj/item/organ/lungs/proc/populate_gas_info()
	gas_min[breathing_class] = safe_breath_min
	gas_max[breathing_class] = safe_breath_max
	gas_damage[breathing_class] = list(
		min = safe_breath_dam_min,
		max = safe_breath_dam_max,
		damage_type = safe_damage_type
	)

/obj/item/organ/lungs/proc/check_breath	(datum/gas_mixture/breath, mob/living/carbon/human/H)
//TODO: add lung damage = less oxygen gains
	var/breathModifier = (5-(5*(damage/maxHealth)/2)) //range 2.5 - 5
	if(H.status_flags & GODMODE)
		return
	if(HAS_TRAIT(H, TRAIT_NOBREATH))
		return

	if(!breath || (breath.total_moles() == 0))
		if(H.has_reagent(crit_stabilizing_reagent, needs_metabolizing = TRUE))
			return
		if(H.health >= H.crit_threshold)
			H.adjustOxyLoss(HUMAN_MAX_OXYLOSS)
		else if(!HAS_TRAIT(H, TRAIT_NOCRITDAMAGE))
			H.adjustOxyLoss(HUMAN_CRIT_MAX_OXYLOSS)

		H.failed_last_breath = TRUE
		var/alert_category
		var/alert_type
		if(ispath(breathing_class))
			var/datum/breathing_class/class = GLOB.gas_data.breathing_classes[breathing_class]
			alert_category = class.low_alert_category
			alert_type = class.low_alert_datum
		else
			var/list/breath_alert_info = GLOB.gas_data.breath_alert_info
			if(breathing_class in breath_alert_info)
				var/list/alert = breath_alert_info[breathing_class]["not_enough_alert"]
				alert_category = alert["alert_category"]
				alert_type = alert["alert_type"]
		if(alert_category)
			H.throw_alert(alert_category, alert_type)
		return FALSE

	#define PP_MOLES(X) ((X / total_moles) * pressure * received_pressure_mult)

	#define PP(air, gas) PP_MOLES(air.get_moles(gas))

	SEND_SIGNAL(H, COMSIG_CARBON_INHALED_GAS, breath, received_pressure_mult)

	var/gas_breathed = 0

	var/pressure = breath.return_pressure()
	var/total_moles = breath.total_moles()
	var/list/breath_alert_info = GLOB.gas_data.breath_alert_info
	var/list/breath_results = GLOB.gas_data.breath_results
	var/list/breathing_classes = GLOB.gas_data.breathing_classes
	var/list/mole_adjustments = list()
	for(var/entry in gas_min)
		var/required_pp = 0
		var/required_moles = 0
		var/safe_min = gas_min[entry]
		var/alert_category = null
		var/alert_type = null
		if(ispath(entry))
			var/datum/breathing_class/class = breathing_classes[entry]
			var/list/gases = class.gases
			var/list/products = class.products
			alert_category = class.low_alert_category
			alert_type = class.low_alert_datum
			for(var/gas in gases)
				var/moles = breath.get_moles(gas)
				var/multiplier = gases[gas]
				mole_adjustments[gas] = (gas in mole_adjustments) ? mole_adjustments[gas] - moles : -moles
				required_pp += PP_MOLES(moles) * multiplier
				required_moles += moles
				if(multiplier > 0)
					var/to_add = moles * multiplier
					for(var/product in products)
						mole_adjustments[product] = (product in mole_adjustments) ? mole_adjustments[product] + to_add : to_add
		else
			required_moles = breath.get_moles(entry)
			required_pp = PP_MOLES(required_moles)
			if(entry in breath_alert_info)
				var/list/alert = breath_alert_info[entry]["not_enough_alert"]
				alert_category = alert["alert_category"]
				alert_type = alert["alert_type"]
			mole_adjustments[entry] = -required_moles
			mole_adjustments[breath_results[entry]] = required_moles
		if(required_pp < safe_min)
			var/multiplier = handle_too_little_breath(H, required_pp, safe_min, required_moles)
			if(required_moles > 0)
				multiplier /= required_moles
			for(var/adjustment in mole_adjustments)
				mole_adjustments[adjustment] *= multiplier
			if(alert_category)
				H.throw_alert(alert_category, alert_type)
		else
			H.failed_last_breath = FALSE
			if(H.health >= H.crit_threshold)
				H.adjustOxyLoss(-breathModifier * received_pressure_mult)
			if(alert_category)
				H.clear_alert(alert_category)
	var/list/danger_reagents = GLOB.gas_data.breath_reagents_dangerous
	for(var/entry in gas_max)
		var/found_pp = 0
		var/datum/breathing_class/breathing_class = entry
		var/datum/reagent/danger_reagent = null
		var/alert_category = null
		var/alert_type = null
		if(ispath(breathing_class))
			breathing_class = breathing_classes[breathing_class]
			alert_category = breathing_class.high_alert_category
			alert_type = breathing_class.high_alert_datum
			danger_reagent = breathing_class.danger_reagent
			found_pp = breathing_class.get_effective_pp(breath) * received_pressure_mult
		else
			danger_reagent = danger_reagents[entry]
			if(entry in breath_alert_info)
				var/list/alert = breath_alert_info[entry]["too_much_alert"]
				alert_category = alert["alert_category"]
				alert_type = alert["alert_type"]
			found_pp = PP(breath, entry)
		if(found_pp > gas_max[entry])
			if(istype(danger_reagent))
				H.reagents.add_reagent(danger_reagent,1)
			var/list/damage_info = (entry in gas_damage) ? gas_damage[entry] : gas_damage["default"]
			var/dam = found_pp / gas_max[entry] * 10
			H.apply_damage_type(clamp(dam, damage_info["min"], damage_info["max"]), damage_info["damage_type"])
			if(alert_category && alert_type)
				H.throw_alert(alert_category, alert_type)
		else if(alert_category)
			H.clear_alert(alert_category)

	var/inflammatory_kpa = 0
	var/list/breath_reagents = GLOB.gas_data.breath_reagents
	for(var/gas in breath.get_gases())
		var/breath_moles = breath.get_moles(gas)
		if(GLOB.gas_data.flags[gas] & GAS_FLAG_IRRITANT)
			inflammatory_kpa += PP_MOLES(breath_moles)
		if(gas in breath_reagents)
			var/datum/reagent/breath_reagent = new breath_reagents[gas]
			breath_reagent.expose_mob(H, INHALE, breath_moles * 2) // 2 represents molarity of O2, we don't have citadel molarity
			mole_adjustments[gas] = (gas in mole_adjustments) ? mole_adjustments[gas] - breath_moles : -breath_moles

	if(inflammatory_kpa)
		H.adjust_lung_inflammation(inflammatory_kpa * (HAS_TRAIT(H, TRAIT_ASTHMATIC) ? 10 : 2))

	if(can_smell)
		handle_smell(breath, H)

	for(var/gas in mole_adjustments)
		breath.adjust_moles(gas, mole_adjustments[gas])


	//-- TRACES --//

	if(breath)	// If there's some other shit in the air lets deal with it here.

	// N2O

		var/SA_pp = PP(breath, GAS_NITROUS)
		if(SA_pp > SA_para_min) // Enough to make us stunned for a bit
			H.Unconscious(60) // 60 gives them one second to wake up and run away a bit!
			if(SA_pp > SA_sleep_min) // Enough to make us sleep as well
				H.Sleeping(200)
				ADD_TRAIT(owner, TRAIT_ANALGESIA, GAS_NITROUS)
		else if(SA_pp > 0.01)	// There is sleeping gas in their lungs, but only a little, so give them a bit of a warning
			if(prob(20))
				H.emote(pick("giggle", "laugh"))
				SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "chemical_euphoria", /datum/mood_event/chemical_euphoria)
		else
			SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "chemical_euphoria")
			REMOVE_TRAIT(owner, TRAIT_ANALGESIA, GAS_NITROUS)


	// BZ

		var/bz_pp = PP(breath, GAS_BZ)
		if(bz_pp > BZ_brain_damage_min)
			H.hallucination += 10
			H.reagents.add_reagent(/datum/reagent/bz_metabolites,5)
			if(prob(33))
				H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 3, 150)

		else if(bz_pp > BZ_trip_balls_min)
			H.hallucination += 5
			H.reagents.add_reagent(/datum/reagent/bz_metabolites,1)

	// Freon
		var/freon_pp = PP(breath,GAS_FREON)
		if (prob(freon_pp))
			to_chat(H, span_alert("Your mouth feels like it's burning!"))
		if (freon_pp >40)
			H.emote("gasp")
			H.adjustOxyLoss(15)
			if (prob(freon_pp/2))
				to_chat(H, span_alert("Your throat closes up!"))
				H.silent = max(H.silent, 3)
		else
			H.adjustOxyLoss(freon_pp/4)
		gas_breathed = breath.get_moles(GAS_FREON)
		if (gas_breathed > gas_stimulation_min)
			H.reagents.add_reagent(/datum/reagent/freon,1)

		breath.adjust_moles(GAS_FREON, -gas_breathed)

	// Chlorine
		var/chlorine_pp = PP(breath,GAS_CHLORINE)
		if (prob(chlorine_pp))
			to_chat(H, span_alert("Your lungs feel awful!"))
		if (chlorine_pp >20)
			H.emote("gasp")
			H.adjustOxyLoss(5)
			if (prob(chlorine_pp/2))
				to_chat(H, span_alert("Your throat closes up!"))
				H.silent = max(H.silent, 3)
		else
			H.adjustOxyLoss(round(chlorine_pp/8))
		gas_breathed = breath.get_moles(GAS_CHLORINE)
		if (gas_breathed > gas_stimulation_min)
			H.reagents.add_reagent(/datum/reagent/chlorine,1)

		breath.adjust_moles(GAS_CHLORINE, -gas_breathed)
	// Hydrogen Chloride
		var/hydrogen_chloride_pp = PP(breath,GAS_HYDROGEN_CHLORIDE)
		if (prob(hydrogen_chloride_pp))
			to_chat(H, span_alert("Your lungs feel terrible!"))
		if (hydrogen_chloride_pp >20)
			H.emote("gasp")
			H.adjustOxyLoss(10)
			if (prob(hydrogen_chloride_pp/2))
				to_chat(H, span_alert("Your throat closes up!"))
				H.silent = max(H.silent, 3)
		else
			H.adjustOxyLoss(round(hydrogen_chloride_pp/4))
		if (gas_breathed > gas_stimulation_min)
			H.reagents.add_reagent(/datum/reagent/hydrogen_chloride)

		breath.adjust_moles(GAS_HYDROGEN_CHLORIDE, -gas_breathed)

	//TODO: This probably should be a status effect, While all gas effects are standardized here, monoxide is way too complicated for this system.
	// Carbon Monoxide
	/* commenting out while it's not a status effect
		var/carbon_monoxide_pp = PP(breath,GAS_CO)
		if (carbon_monoxide_pp > gas_stimulation_min)
			H.reagents.add_reagent(/datum/reagent/carbon_monoxide, 2)
			var/datum/reagent/carbon_monoxide/monoxide_reagent = H.has_reagent(/datum/reagent/carbon_monoxide)
			if(monoxide_reagent.volume > 10)
				monoxide_reagent.metabolization_rate = (10 - carbon_monoxide_pp)
			else
				monoxide_reagent.metabolization_rate = monoxide_reagent::metabolization_rate
			switch(carbon_monoxide_pp)
				if (0 to 20)
					monoxide_reagent.accumulation = min(monoxide_reagent.accumulation,50)
				if (20 to 100)
					monoxide_reagent.accumulation = min(monoxide_reagent.accumulation, 150)
					H.reagents.add_reagent(/datum/reagent/carbon_monoxide,2)
				if (100 to 200)
					monoxide_reagent.accumulation = min(monoxide_reagent.accumulation, 250)
					H.reagents.add_reagent(/datum/reagent/carbon_monoxide,4)
				if (200 to 400)
					monoxide_reagent.accumulation = min(monoxide_reagent.accumulation, 250)
					H.reagents.add_reagent(/datum/reagent/carbon_monoxide,8)
				if (400 to INFINITY)
					monoxide_reagent.accumulation = max(monoxide_reagent.accumulation, 450)
					H.reagents.add_reagent(/datum/reagent/carbon_monoxide,16)
		else
			var/datum/reagent/carbon_monoxide/monoxide_reagent = H.has_reagent(/datum/reagent/carbon_monoxide)
			if(monoxide_reagent)
				monoxide_reagent.accumulation = min(monoxide_reagent.accumulation, 150)
				monoxide_reagent.metabolization_rate = 10 //purges 10 per tick
		breath.adjust_moles(GAS_CO, -gas_breathed)
	*/
	// Sulfur Dioxide
		var/sulfur_dioxide_pp = PP(breath,GAS_SO2)
		if (prob(sulfur_dioxide_pp) && !HAS_TRAIT(H, TRAIT_ANALGESIA))
			to_chat(H, span_alert("It hurts to breath."))
		if (sulfur_dioxide_pp >40)
			H.emote("gasp")
			H.adjustOxyLoss(5)
			if (prob(sulfur_dioxide_pp/2))
				to_chat(H, span_alert("Your throat closes up!"))
				H.silent = max(H.silent, 3)
		else
			H.adjustOxyLoss(round(sulfur_dioxide_pp/8))
		gas_breathed = breath.get_moles(GAS_SO2)
		if (gas_breathed > gas_stimulation_min)
			H.reagents.add_reagent(/datum/reagent/sulfur_dioxide,1)

		breath.adjust_moles(GAS_SO2, -gas_breathed)

	// Ozone
		var/ozone_pp = PP(breath,GAS_O3)
		if (prob(ozone_pp))
			to_chat(H, span_alert("Your heart feels funny."))
		if (ozone_pp >40)
			H.emote("gasp")
			H.adjustOxyLoss(5)
			if (prob(ozone_pp/2))
				to_chat(H, span_alert("Your throat closes up!"))
				H.silent = max(H.silent, 3)
		gas_breathed = breath.get_moles(GAS_O3)
		if (gas_breathed > gas_stimulation_min)
			H.reagents.add_reagent(/datum/reagent/ozone,1)

		breath.adjust_moles(GAS_O3, -gas_breathed)

	// Ammonia
		var/ammonia_pp = PP(breath,GAS_AMMONIA)
		if (prob(ammonia_pp)*2)
			to_chat(H, span_alert("Your lungs feel terrible!"))

		if (ammonia_pp > 10)
			H.emote("gasp")
			H.adjustOxyLoss(5)
			H.adjustOxyLoss(round(ammonia_pp/8))
			if (prob(ammonia_pp/2))
				to_chat(H, span_alert("Your throat burns!</span>"))
				H.silent = max(H.silent, 2)
		else
			H.adjustOxyLoss(round(ammonia_pp/8))
		gas_breathed = breath.get_moles(GAS_AMMONIA)
		if (gas_breathed > gas_stimulation_min)
			if(prob(25))//unlike the chlorine reagent ammonia doesnt do lung damage do we handle it here instead
				H.adjustOrganLoss(ORGAN_SLOT_LUNGS,2*1.6)
			//ammonia is actually disposed of naturally by humans, but extremely poorly by non mammals, maybe we can make it toxic ONLY to certain species (plural) sometime?
			H.reagents.add_reagent(/datum/reagent/ammonia,1)

		breath.adjust_moles(GAS_AMMONIA, -gas_breathed)

///handles the smell a few gases have
/obj/item/organ/lungs/proc/handle_smell(datum/gas_mixture/breath, mob/living/carbon/human/H)
	var/pressure = breath.return_pressure()
	var/total_moles = breath.total_moles()

	var/list/gases_id = breath.get_gases()
	var/list/gases = list()

	for(var/ID as anything in gases_id)
		LAZYADD(gases, GLOB.gas_data.datums[ID])
	for(var/datum/gas/checked_gas as anything in gases)
		if(!istype(checked_gas))
			continue
		if(!checked_gas.odor_power || !checked_gas.odor)
			continue

		var/odor_pp = PP(breath,checked_gas.id) * checked_gas.odor_power

		if(odor_pp > 8) //level 3
			if(checked_gas.odor[4])
				to_chat(H, checked_gas.odor[4])
			if(checked_gas.odor_emotes && prob(20))
				H.emote("cough")

		else if(odor_pp > 2) //level 2
			if(checked_gas.odor[3])
				to_chat(H, checked_gas.odor[3])
			if(checked_gas.odor_emotes && prob(5))
				H.emote("cough")

		else if(odor_pp > gas_stimulation_min) //level 1
			if(checked_gas.odor[2])
				to_chat(H, checked_gas.odor[2]) // danger becuse this might be over safety threshold in the case of ammonia

		else if (prob(odor_pp)*20) //level 0
			if(checked_gas.odor[1])
				to_chat(H, checked_gas.odor[1])

/obj/item/organ/lungs/proc/handle_too_little_breath(mob/living/carbon/human/H = null, breath_pp = 0, safe_breath_min = 0, true_pp = 0)
	. = 0
	if(!H || !safe_breath_min) //the other args are either: Ok being 0 or Specifically handled.
		return FALSE

	if(prob(20))
		H.emote("gasp")
	if(breath_pp > 0)
		var/ratio = safe_breath_min/breath_pp
		H.adjustOxyLoss(min(5*ratio, HUMAN_MAX_OXYLOSS)) // Don't fuck them up too fast (space only does HUMAN_MAX_OXYLOSS after all!
		H.failed_last_breath = TRUE
		. = true_pp*ratio/6
	else
		H.adjustOxyLoss(HUMAN_MAX_OXYLOSS)
		H.failed_last_breath = TRUE


/obj/item/organ/lungs/proc/handle_breath_temperature(datum/gas_mixture/breath, mob/living/carbon/human/breather) // called by human/life, handles temperatures
	if(!breath)
		return
	var/breath_temperature = breath.return_temperature()

	if(!HAS_TRAIT(breather, TRAIT_RESISTCOLD)) // COLD DAMAGE
		var/cold_modifier = breather.dna.species.coldmod
		var/breath_effect_prob = 0
		if(breath_temperature < cold_level_3_threshold)
			breather.apply_damage(cold_level_3_damage * cold_modifier, cold_damage_type, spread_damage = TRUE)
			breath_effect_prob = 100
		if(breath_temperature > cold_level_3_threshold && breath_temperature < cold_level_2_threshold)
			breather.apply_damage(cold_level_2_damage * cold_modifier, cold_damage_type, spread_damage = TRUE)
			breath_effect_prob = 75
		if(breath_temperature > cold_level_2_threshold && breath_temperature < cold_level_1_threshold)
			breather.apply_damage(cold_level_1_damage * cold_modifier, cold_damage_type, spread_damage = TRUE)
			breath_effect_prob = 50
		if(breath_temperature > cold_level_1_threshold)
			breath_effect_prob = 25

		if(breath_temperature < cold_level_1_threshold)
			if(prob(sqrt(breath_effect_prob) * 6))
				to_chat(breather, span_warning("You feel [cold_message] in your [name]!"))
		else if(breath_temperature < chlly_threshold)
			if(!breath_effect_prob)
				breath_effect_prob = 20
			if(prob(sqrt(breath_effect_prob) * 6))
				to_chat(breather, span_warning("You feel [chilly_message] in your [name]."))
		if(breath_temperature < chlly_threshold)
			if(HAS_TRAIT(breather, TRAIT_ASTHMATIC)) // cold air typically causes problems in my experience
				breather.adjust_lung_inflammation(round(1 + (chlly_threshold - breath_temperature) / 30, 0.1))
			if(breath_effect_prob)
				// Breathing into your mask, no particle. We can add fogged up glasses later
				if(breather.is_mouth_covered())
					return
				// Even though breathing via internals TECHNICALLY exhales into the environment, we'll still block it
				if(breather.internal)
					return

	if(!HAS_TRAIT(breather, TRAIT_RESISTHEAT)) // HEAT DAMAGE
		var/heat_modifier = breather.dna.species.heatmod
		var/heat_message_prob = 0
		if(breath_temperature > heat_level_1_threshold && breath_temperature < heat_level_2_threshold)
			breather.apply_damage(heat_level_1_damage * heat_modifier, heat_damage_type, spread_damage = TRUE)
			heat_message_prob = 100
		if(breath_temperature > heat_level_2_threshold && breath_temperature < heat_level_3_threshold)
			breather.apply_damage(heat_level_2_damage * heat_modifier, heat_damage_type, spread_damage = TRUE)
			heat_message_prob = 75
		if(breath_temperature > heat_level_3_threshold)
			breather.apply_damage(heat_level_3_damage * heat_modifier, heat_damage_type, spread_damage = TRUE)
			heat_message_prob = 50
		if(breath_temperature > heat_level_1_threshold)
			heat_message_prob = 25

		if(breath_temperature > heat_level_1_threshold)
			if(prob(sqrt(heat_message_prob) * 6))
				to_chat(breather, span_warning("You feel [hot_message] in your [name]!"))
		else if(breath_temperature > warm_threshold)
			if(!heat_message_prob)
				heat_message_prob = 20
			if(prob(sqrt(heat_message_prob) * 6))
				to_chat(breather, span_warning("You feel [warm_message] in your [name]."))



	// The air you breathe out should match your body temperature
	breath.set_temperature(breather.bodytemperature)

/// Adjusting proc for [received_pressure_mult]. Updates bronchodilation alerts.
/obj/item/organ/lungs/proc/adjust_received_pressure_mult(adjustment)
	set_received_pressure_mult(received_pressure_mult + adjustment)

/// Setter proc for [received_pressure_mult]. Updates bronchodilation alerts.
/obj/item/organ/lungs/proc/set_received_pressure_mult(new_value)
	if(new_value <= 0 && received_pressure_mult > 0)
		ADD_TRAIT(owner, TRAIT_MUTE, ALERT_BRONCHOCONSTRICTION)
	else if(new_value > 0 && received_pressure_mult <= 0)
		REMOVE_TRAIT(owner, TRAIT_MUTE, ALERT_BRONCHOCONSTRICTION)
	received_pressure_mult = max(new_value, 0)
	update_bronchodilation_alerts()

#define LUNG_CAPACITY_ALERT_BUFFER 0.003
/// Depending on [received_pressure_mult], gives either a bronchocontraction or bronchoconstriction alert to our owner (if we have one), or clears the alert
/// if [received_pressure_mult] is near 1.
/obj/item/organ/lungs/proc/update_bronchodilation_alerts()
	if (!owner)
		return

	var/initial_value = initial(received_pressure_mult)

	// you wont really notice if youre only breathing a bit more or a bit less
	var/dilated = (received_pressure_mult > (initial_value + LUNG_CAPACITY_ALERT_BUFFER))
	var/constricted = (received_pressure_mult < (initial_value - LUNG_CAPACITY_ALERT_BUFFER))

	if (dilated)
		owner.throw_alert(ALERT_BRONCHODILATION, /atom/movable/screen/alert/bronchodilated)
	else if (constricted)
		owner.throw_alert(ALERT_BRONCHODILATION, /atom/movable/screen/alert/bronchoconstricted)
	else
		owner.clear_alert(ALERT_BRONCHODILATION)

#undef LUNG_CAPACITY_ALERT_BUFFER

/obj/item/organ/lungs/on_life()
	. = ..()
	if(failed && !(organ_flags & ORGAN_FAILING))
		failed = FALSE
		return
	if(damage >= low_threshold)
		var/do_i_cough = damage < high_threshold ? prob(5) : prob(10) // between : past high
		if(do_i_cough)
			owner.emote("cough")
	if(organ_flags & ORGAN_FAILING && owner.stat == CONSCIOUS)
		owner.visible_message(span_danger("[owner] grabs [owner.p_their()] throat, struggling for breath!"), span_userdanger("You suddenly feel like you can't breathe!"))
		failed = TRUE

/obj/item/organ/lungs/get_availability(datum/species/S)
	return !(TRAIT_NOBREATH in S.species_traits)

/obj/item/organ/lungs/plasmaman
	name = "plasma filter"
	desc = "A spongy rib-shaped mass for filtering plasma from the air."
	icon_state = "lungs-plasma"

	breathing_class = BREATH_PLASMA

	can_smell = FALSE

/obj/item/organ/lungs/plasmaman/populate_gas_info()
	..()
	gas_max -= GAS_PLASMA

/obj/item/organ/lungs/slime
	name = "vacuole"
	desc = "A large organelle designed to store oxygen and other important gasses."

/obj/item/organ/lungs/slime/check_breath(datum/gas_mixture/breath, mob/living/carbon/human/H)
	. = ..()
	if (breath)
		var/total_moles = breath.total_moles()
		var/pressure = breath.return_pressure()
		var/plasma_pp = PP(breath, GAS_PLASMA)
		owner.blood_volume += (0.2 * plasma_pp) // 10/s when breathing literally nothing but plasma, which will suffocate you.

/obj/item/organ/lungs/cybernetic
	name = "basic cybernetic lungs"
	desc = "A basic cybernetic version of the lungs found in traditional humanoid entities."
	icon_state = "lungs-c"
	organ_flags = ORGAN_SYNTHETIC
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5
	safe_breath_min = 13
	safe_breath_max = 100

	var/emp_vulnerability = 80	//Chance of permanent effects if emp-ed.

/obj/item/organ/lungs/cybernetic/tier2
	name = "cybernetic lungs"
	desc = "A cybernetic version of the lungs found in traditional humanoid entities. Allows for greater intakes of oxygen than organic lungs, requiring slightly less pressure."
	icon_state = "lungs-c-u"
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	emp_vulnerability = 40

/obj/item/organ/lungs/cybernetic/tier3
	name = "upgraded cybernetic lungs"
	desc = "A more advanced version of the stock cybernetic lungs. Features the ability to filter out lower levels of toxins and carbon dioxide."
	icon_state = "lungs-c-u2"
	safe_breath_min = 4
	safe_breath_max = 250
	gas_max = list(
		GAS_PLASMA = 30,
		GAS_CO2 = 30
	)
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	emp_vulnerability = 20

	cold_level_1_threshold = 200
	cold_level_2_threshold = 140
	cold_level_3_threshold = 100

/obj/item/organ/lungs/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(world.time > severe_cooldown) //So we cant just spam emp to kill people.
		owner.losebreath += 10
		severe_cooldown = world.time + 30 SECONDS

#undef PP
#undef PP_MOLES
