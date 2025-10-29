/datum/status_effect/lung_inflammation
	id = "lung_inflammation"
	tick_interval = 2 SECONDS
	status_type = STATUS_EFFECT_REPLACE
	remove_on_fullheal = TRUE
	alert_type = null // handled by bronchodilation/constriction alerts already

	/// At this percentage of inflammation, our lung pressure mult reaches 0. From 0-1.
	var/hit_max_mult_at_inflammation_percent = 0.9

	/// Current inflammation of the lungs.
	var/inflammation = 0
	/// Highest possible inflammation. Interacts with [hit_max_mult_at_inflammation_percent]
	var/max_inflammation = 500

	/// The amount [inflammation] reduces every second while our owner is off stasis and alive.
	var/passive_inflammation_reduction = 0.15

	/// A tracker variable for how much salbutamol has been inhaled.
	var/inhaled_salbutamol = 0
	/// If [inhaled_salbutamol] is above 0, we will reduce inflammation by this much per tick.
	var/salbutamol_inflammation_reduction = 3
	/// When salbutamol is inhaled, inflammation will be reduced via (inhaled_salbutamol * salbutamol_inflammation_reduction * salbutamol_immediate_reduction_mult)
	var/salbutamol_immediate_reduction_mult = 4

/datum/status_effect/lung_inflammation/on_apply()
	RegisterSignal(owner, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(organ_removed))
	inhaled_salbutamol = owner.reagents.get_reagent_amount(/datum/reagent/medicine/salbutamol)
	return ..()

/datum/status_effect/lung_inflammation/on_remove()
	UnregisterSignal(owner,	COMSIG_CARBON_LOSE_ORGAN)
	if(inflammation)
		adjust_inflammation(-inflammation)
	return ..()

/datum/status_effect/lung_inflammation/tick(seconds_per_tick)
	if (owner.stat == DEAD)
		return

	if (HAS_TRAIT(owner, TRAIT_STASIS))
		return

	var/obj/item/organ/lungs/holder_lungs = owner.getorganslot(ORGAN_SLOT_LUNGS)
	if (isnull(holder_lungs))
		return

	adjust_inflammation(-passive_inflammation_reduction * seconds_per_tick)

	var/datum/reagent/medicine/salbutamol/salbutamol = owner.reagents.has_reagent(/datum/reagent/medicine/salbutamol)
	if (!salbutamol) // sanity - couldve been purged. can be 0 or null which is why we just use a !
		inhaled_salbutamol = 0
	else
		inhaled_salbutamol = min(salbutamol.volume, inhaled_salbutamol)

	if (inhaled_salbutamol > 0)
		adjust_inflammation(-(salbutamol_inflammation_reduction * seconds_per_tick))

	else if(!inflammation)
		qdel(src) // only delete itself after the salbutamol is depleted, else it'll be wasted if the status gets applied again right after

/// Setter proc for [inflammation]. Adjusts the amount by lung health, adjusts pressure mult, gives feedback messages if silent is FALSE.
/datum/status_effect/lung_inflammation/proc/adjust_inflammation(amount, silent = FALSE)
	var/old_inflammation = inflammation

	var/obj/item/organ/lungs/holder_lungs = owner.getorganslot(ORGAN_SLOT_LUNGS)
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
/datum/status_effect/lung_inflammation/proc/adjust_salbutamol_levels(adjustment)
	if (adjustment > 0)
		var/obj/item/organ/lungs/holder_lungs = owner.getorganslot(ORGAN_SLOT_LUNGS)

		if (isnull(holder_lungs) || holder_lungs.received_pressure_mult <= 0) // it didnt go into the lungs get fucked
			return

		adjust_inflammation(-(salbutamol_inflammation_reduction * salbutamol_immediate_reduction_mult))

	inhaled_salbutamol += adjustment

/// Returns the pressure mult to be applied to our lungs.
/datum/status_effect/lung_inflammation/proc/get_pressure_mult()
	var/virtual_max = (max_inflammation * hit_max_mult_at_inflammation_percent)

	return (1 - (min(inflammation/virtual_max, 1)))

/// Sends feedback to our owner of which direction our asthma is intensifying/recovering.
/datum/status_effect/lung_inflammation/proc/do_inflammation_change_feedback(difference)
	var/change_mult = 1 + (difference / 300) // 300 is arbitrary
	if (difference > 0) // it decreased
		if (prob(1 * change_mult))
			// in my experience with asthma an inhaler causes a bunch of mucous and you tend to cough it up
			to_chat(owner, span_notice("The phlem in your throat forces you to cough!"))
			owner.emote("cough")

	else if (difference < 0)// it increased
		if (prob(1 * change_mult))
			owner.emote("wheeze")
		if (prob(5 * change_mult))
			to_chat(owner, span_warning("You feel your windpipe tightening..."))

/// Returns the % of health our lungs have, from 1-0. Used in reducing recovery and intensifying inflammation.
/datum/status_effect/lung_inflammation/proc/get_lung_health_mult()
	var/mob/living/carbon/carbon_owner = owner
	var/obj/item/organ/lungs/holder_lungs = carbon_owner.getorganslot(ORGAN_SLOT_LUNGS)
	if (isnull(holder_lungs))
		return 1
	if (holder_lungs.organ_flags & ORGAN_FAILING)
		return 0
	return (1 - (holder_lungs.damage / holder_lungs.maxHealth))

/// Signal proc for when our lungs are removed. Resets all our variables.
/datum/status_effect/lung_inflammation/proc/organ_removed(datum/signal_source, obj/item/organ/removed)
	SIGNAL_HANDLER

	if (istype(removed, /obj/item/organ/lungs))
		reset_asthma()

/// Resets our asthma to normal. No inflammation, no pressure mult.
/datum/status_effect/lung_inflammation/proc/reset_asthma()
	var/obj/item/organ/lungs/holder_lungs = owner.getorganslot(ORGAN_SLOT_LUNGS)
	holder_lungs?.set_received_pressure_mult(holder_lungs::received_pressure_mult)
	qdel(src)
