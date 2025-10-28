/datum/quirk/asthma
	name = "Asthma"
	desc = "You suffer from asthma, a inflammatory disorder that causes your airpipe to squeeze shut! Be careful around smoke and irritating gases!"
	//icon = FA_ICON_LUNGS_VIRUS
	value = -2 // trivialized by NOBREATH but still quite dangerous
	gain_text = span_danger("You have a harder time breathing.")
	lose_text = span_notice("You suddenly feel like your lungs just got a lot better at breathing!")
	medical_record_text = "Patient suffers from asthma."
	//hardcore_value = 2
	//quirk_flags = QUIRK_HUMAN_ONLY

	/// At this percentage of inflammation, our lung pressure mult reaches 0. From 0-1.
	var/hit_max_mult_at_inflammation_percent = 0.9

	/// Current inflammation of the lungs.
	var/inflammation = 0
	/// Highest possible inflammation. Interacts with [hit_max_mult_at_inflammation_percent]
	var/max_inflammation = 500

	/// The amount [inflammation] reduces every second while our owner is off stasis and alive.
	var/passive_inflammation_reduction = 0.15

	/// The amount of inflammation we will receive when our owner breathes smoke.
	var/inflammation_on_smoke = 7.5
	/// The amount of inflammation we will receive per partial kilopascal when inhaling irritating gas.
	var/inflammation_on_gas = 10

	/// If our owner is metabolizing histamine, inflammation will increase by this per tick.
	var/histamine_inflammation = 2
	/// If our owner is ODing on histamine, inflammation will increase by this per tick.
	var/histamine_OD_inflammation = 10 // allergic reactions tend to fuck people up

	/// A tracker variable for how much salbutamol has been inhaled.
	var/inhaled_salbutamol = 0
	/// If [inhaled_salbutamol] is above 0, we will reduce inflammation by this much per tick.
	var/salbutamol_inflammation_reduction = 3
	/// When salbutamol is inhaled, inflammation will be reduced via (inhaled_salbutamol * salbutamol_inflammation_reduction * salbutamol_immediate_reduction_mult)
	var/salbutamol_immediate_reduction_mult = 4

	/// The current asthma attack trying to kill our owner.
	var/datum/disease/asthma_attack/current_attack
	/// Can we cause an asthma attack?
	COOLDOWN_DECLARE(next_attack_cooldown)

	/// world.time + this is the time the first attack can happen. Used on spawn.
	var/time_first_attack_can_happen = 10 MINUTES

	/// After an attack ends, this is the minimum time we must wait before we attack again.
	var/min_time_between_attacks = 15 MINUTES
	/// After an attack ends, this is the maximum time we must wait before we attack again.
	var/max_time_between_attacks = 25 MINUTES

	/// Every second, an asthma attack can happen via this probability. 0-1.
	var/chance_for_attack_to_happen_per_second = 0.05

	/// Assoc list of (/datum/disease/asthma_attack typepath -> number). Used in pickweight for when we pick a random asthma attack to apply.
	var/static/list/asthma_attack_rarities = list(
		/datum/disease/asthma_attack/minor = 300,
		/datum/disease/asthma_attack/moderate = 400,
		/datum/disease/asthma_attack/severe = 100,
		/datum/disease/asthma_attack/critical = 1, // this can quickly kill you, so its rarity is justified
	)

/datum/quirk/asthma/on_spawn()
	. = ..()

	var/obj/item/inhaler/salbutamol/rescue/rescue_inhaler = new(get_turf(quirk_holder))
	var/mob/living/carbon/carbon_holder = quirk_holder
	var/static/list/inhaler_slots = list(
		"backpack" = ITEM_SLOT_BACKPACK,
		"hands" = ITEM_SLOT_HANDS,
	)
	var/slot_equipped = carbon_holder.equip_in_one_of_slots(rescue_inhaler, inhaler_slots, qdel_on_fail = FALSE)
	if(!slot_equipped)
		slot_equipped = "hands... or had, you must have dropped it."
	to_chat(carbon_holder, span_warning("<b>You have \a [rescue_inhaler] in your [slot_equipped]. You can use this to quickly relieve the symptoms of your asthma.</b>"))
	//give_item_to_holder(rescue_inhaler, list(LOCATION_BACKPACK, LOCATION_HANDS), flavour_text = "You can use this to quickly relieve the symptoms of your asthma.")

	RegisterSignal(quirk_holder, COMSIG_CARBON_EXPOSED_TO_SMOKE, PROC_REF(holder_exposed_to_smoke))
	RegisterSignal(quirk_holder, COMSIG_CARBON_INHALED_GAS, PROC_REF(inhaled_gas))
	RegisterSignal(quirk_holder, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(organ_removed))
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(exposed_to_reagents))
	RegisterSignal(quirk_holder, COMSIG_LIVING_POST_FULLY_HEAL, PROC_REF(on_full_heal))
	RegisterSignal(quirk_holder, COMSIG_LIVING_LIFE, PROC_REF(on_life))

	COOLDOWN_START(src, next_attack_cooldown, time_first_attack_can_happen)

/datum/quirk/asthma/remove()
	. = ..()

	current_attack?.cure()
	UnregisterSignal(quirk_holder, list(
		COMSIG_CARBON_EXPOSED_TO_SMOKE,
		COMSIG_CARBON_INHALED_GAS,
		COMSIG_CARBON_LOSE_ORGAN,
		COMSIG_ATOM_EXPOSE_REAGENTS,
		COMSIG_LIVING_POST_FULLY_HEAL,
		COMSIG_LIVING_LIFE,
	))

/datum/quirk/asthma/proc/on_life(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	if (quirk_holder.stat == DEAD)
		return

	if (HAS_TRAIT(quirk_holder, TRAIT_STASIS))
		return

	var/obj/item/organ/lungs/holder_lungs = quirk_holder.getorganslot(ORGAN_SLOT_LUNGS)
	if (isnull(holder_lungs))
		return

	adjust_inflammation(-passive_inflammation_reduction * seconds_per_tick)

	var/datum/reagent/toxin/histamine/holder_histamine = quirk_holder.reagents.has_reagent(/datum/reagent/toxin/histamine)
	if (holder_histamine)
		if (holder_histamine.overdosed) // uh oh!
			if (SPT_PROB(15, seconds_per_tick))
				to_chat(quirk_holder, span_boldwarning("You feel your neck swelling, squeezing on your windpipe more and more!"))
			adjust_inflammation(histamine_OD_inflammation * seconds_per_tick)
		else
			if (SPT_PROB(5, seconds_per_tick))
				to_chat(quirk_holder, span_warning("You find yourself wheezing a little harder as your neck swells..."))
			adjust_inflammation(histamine_inflammation * seconds_per_tick)

	var/datum/reagent/medicine/salbutamol/salbutamol = quirk_holder.reagents.has_reagent(/datum/reagent/medicine/salbutamol)
	if (!salbutamol) // sanity - couldve been purged. can be 0 or null which is why we just use a !
		inhaled_salbutamol = 0
	else
		inhaled_salbutamol = min(salbutamol.volume, inhaled_salbutamol)

	if (inhaled_salbutamol > 0)
		adjust_inflammation(-(salbutamol_inflammation_reduction * seconds_per_tick))

	// asthma attacks dont happen if theres no client, because they can just kill you and some need immediate response
	else if (quirk_holder.client && isnull(current_attack) && COOLDOWN_FINISHED(src, next_attack_cooldown) && SPT_PROB(chance_for_attack_to_happen_per_second, seconds_per_tick))
		do_asthma_attack()

/// Causes an asthma attack via infecting our owner with the attack disease. Notifies ghosts.
/datum/quirk/asthma/proc/do_asthma_attack()
	var/datum/disease/asthma_attack/typepath = pick_weight(asthma_attack_rarities)

	current_attack = new typepath
	current_attack.infect(quirk_holder, make_copy = FALSE) // dont leave make_copy on TRUE. worst mistake ive ever made
	RegisterSignal(current_attack, COMSIG_PARENT_QDELETING, PROC_REF(attack_deleting))

	if (current_attack.alert_ghosts)
		notify_ghosts("[quirk_holder] is having an asthma attack: [current_attack.name]!", source = quirk_holder, flashwindow = FALSE, header = "Asthma attack!")

/// Setter proc for [inflammation]. Adjusts the amount by lung health, adjusts pressure mult, gives feedback messages if silent is FALSE.
/datum/quirk/asthma/proc/adjust_inflammation(amount, silent = FALSE)
	var/old_inflammation = inflammation

	var/obj/item/organ/lungs/holder_lungs = quirk_holder.getorganslot(ORGAN_SLOT_LUNGS)
	var/health_mult = get_lung_health_mult(holder_lungs)
	if (amount > 0) // make it worse
		amount *= (2 - health_mult)
	else // reduce the reduction
		amount *= health_mult

	var/old_pressure_mult = get_pressure_mult()
	inflammation = (clamp(inflammation + amount, 0, max_inflammation))
	var/difference = (old_inflammation - inflammation)
	if (difference != 0)
		var/new_pressure_mult = get_pressure_mult()
		var/pressure_difference = new_pressure_mult - old_pressure_mult

		holder_lungs?.adjust_received_pressure_mult(pressure_difference)

		if (!silent)
			INVOKE_ASYNC(src, PROC_REF(do_inflammation_change_feedback), difference)

/// Setter proc for [inhaled_salbutamol]. Adjusts inflammation immediately.
/datum/quirk/asthma/proc/adjust_salbutamol_levels(adjustment)
	if (adjustment > 0)
		var/obj/item/organ/lungs/holder_lungs = quirk_holder.getorganslot(ORGAN_SLOT_LUNGS)

		if (isnull(holder_lungs) || holder_lungs.received_pressure_mult <= 0) // it didnt go into the lungs get fucked
			return

		adjust_inflammation(-(salbutamol_inflammation_reduction * salbutamol_immediate_reduction_mult))

	inhaled_salbutamol += adjustment

/// Returns the pressure mult to be applied to our lungs.
/datum/quirk/asthma/proc/get_pressure_mult()
	var/virtual_max = (max_inflammation * hit_max_mult_at_inflammation_percent)

	return (1 - (min(inflammation/virtual_max, 1)))

/// Sends feedback to our owner of which direction our asthma is intensifying/recovering.
/datum/quirk/asthma/proc/do_inflammation_change_feedback(difference)
	var/change_mult = 1 + (difference / 300) // 300 is arbitrary
	if (difference > 0) // it decreased
		if (prob(1 * change_mult))
			// in my experience with asthma an inhaler causes a bunch of mucous and you tend to cough it up
			to_chat(quirk_holder, span_notice("The phlem in your throat forces you to cough!"))
			quirk_holder.emote("cough")

	else if (difference < 0)// it increased
		if (prob(1 * change_mult))
			quirk_holder.emote("wheeze")
		if (prob(5 * change_mult))
			to_chat(quirk_holder, span_warning("You feel your windpipe tightening..."))

/// Returns the % of health our lungs have, from 1-0. Used in reducing recovery and intensifying inflammation.
/datum/quirk/asthma/proc/get_lung_health_mult()
	var/mob/living/carbon/carbon_quirk_holder = quirk_holder
	var/obj/item/organ/lungs/holder_lungs = carbon_quirk_holder.getorganslot(ORGAN_SLOT_LUNGS)
	if (isnull(holder_lungs))
		return 1
	if (holder_lungs.organ_flags & ORGAN_FAILING)
		return 0
	return (1 - (holder_lungs.damage / holder_lungs.maxHealth))

/// Signal proc for when we are exposed to smoke. Increases inflammation.
/datum/quirk/asthma/proc/holder_exposed_to_smoke(datum/signal_source, seconds_per_tick)
	SIGNAL_HANDLER

	adjust_inflammation(inflammation_on_smoke * seconds_per_tick)

/// Signal proc for when our lungs are removed. Resets all our variables.
/datum/quirk/asthma/proc/organ_removed(datum/signal_source, obj/item/organ/removed)
	SIGNAL_HANDLER

	if (istype(removed, /obj/item/organ/lungs))
		reset_asthma()

/// Signal proc for when our owner receives reagents. If we receive salbutamol via inhalation, we adjust inhaled salbutamol by that amount. If we are smoking, we increase inflammation.
/datum/quirk/asthma/proc/exposed_to_reagents(atom/source, list/reagents, datum/reagents/source_reagents, methods, volume_modifier, show_message)
	SIGNAL_HANDLER

	var/final_total = 0

	for (var/datum/reagent/reagent as anything in reagents)
		var/amount = reagents[reagent]
		if (istype(reagent, /datum/reagent/medicine/salbutamol))
			adjust_salbutamol_levels(amount)
		final_total += amount

	if (!(methods & INHALE))
		return
	if (istype(source_reagents.my_atom, /obj/item/clothing/mask/cigarette)) // smoking is bad, kids
		adjust_inflammation(inflammation_on_smoke * final_total * 5)

/// Signal proc for when our owner breathes in gas.
/datum/quirk/asthma/proc/inhaled_gas(atom/source, datum/gas_mixture/breath, received_pressure_mult)
	SIGNAL_HANDLER

	var/final_total = 0
	var/total_moles = breath.total_moles()
	var/breath_pressure = breath.return_pressure()
	if(!breath_pressure)
		return

	for(var/gas_id in breath.get_gases())
		if(GLOB.gas_data.flags[gas_id] & GAS_FLAG_IRRITANT)
			final_total += breath_pressure * breath.get_moles(gas_id) / total_moles

	if(final_total)
		adjust_inflammation(inflammation_on_gas * final_total * received_pressure_mult)

/// Signal proc for when our asthma attack qdels. Unsets our refs to it and resets [next_attack_cooldown].
/datum/quirk/asthma/proc/attack_deleting(datum/signal_source)
	SIGNAL_HANDLER

	UnregisterSignal(current_attack, COMSIG_PARENT_QDELETING)
	current_attack = null

	COOLDOWN_START(src, next_attack_cooldown, rand(min_time_between_attacks, max_time_between_attacks))

/// Signal handler for COMSIG_LIVING_POST_FULLY_HEAL. Heals our asthma.
/datum/quirk/asthma/proc/on_full_heal(datum/signal_source, admin_revive)
	SIGNAL_HANDLER

	if (admin_revive)
		reset_asthma()

/// Resets our asthma to normal. No inflammation, no pressure mult.
/datum/quirk/asthma/proc/reset_asthma()
	inflammation = 0
	var/obj/item/organ/lungs/holder_lungs = quirk_holder.getorganslot(ORGAN_SLOT_LUNGS)
	holder_lungs?.set_received_pressure_mult(holder_lungs::received_pressure_mult)
