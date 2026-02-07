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
	mob_traits = list(TRAIT_ASTHMATIC)

	/// The amount of inflammation we will receive when our owner breathes smoke.
	var/inflammation_on_smoke = 7.5

	/// Inflammation caused per point of stamina damage on the owner.
	var/inflammation_on_stamina = 0.05

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

	/// Every second, an asthma attack can happen via this probability. 0-100.
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
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(exposed_to_reagents))
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

	if(quirk_holder.reagents.has_reagent(/datum/reagent/medicine/salbutamol))
		return

	var/stamina_dam = quirk_holder.getStaminaLoss()
	if (stamina_dam > 0)
		quirk_holder.adjust_lung_inflammation(inflammation_on_stamina * stamina_dam * seconds_per_tick)

	// asthma attacks dont happen if theres no client, because they can just kill you and some need immediate response
	if (quirk_holder.client && isnull(current_attack) && COOLDOWN_FINISHED(src, next_attack_cooldown) && SPT_PROB(chance_for_attack_to_happen_per_second, seconds_per_tick))
		do_asthma_attack()

/// Causes an asthma attack via infecting our owner with the attack disease. Notifies ghosts.
/datum/quirk/asthma/proc/do_asthma_attack()
	var/datum/disease/asthma_attack/typepath = pick_weight(asthma_attack_rarities)

	current_attack = new typepath
	current_attack.infect(quirk_holder, make_copy = FALSE) // dont leave make_copy on TRUE. worst mistake ive ever made
	RegisterSignal(current_attack, COMSIG_QDELETING, PROC_REF(attack_deleting))

	if (current_attack.alert_ghosts)
		notify_ghosts("[quirk_holder] is having an asthma attack: [current_attack.name]!", source = quirk_holder, flashwindow = FALSE, header = "Asthma attack!")

/// Signal proc for when we are exposed to smoke. Increases inflammation.
/datum/quirk/asthma/proc/holder_exposed_to_smoke(datum/signal_source, seconds_per_tick)
	SIGNAL_HANDLER

	quirk_holder.adjust_lung_inflammation(inflammation_on_smoke * seconds_per_tick)

/// Signal proc for when our owner receives reagents. If we are smoking, we increase inflammation.
/datum/quirk/asthma/proc/exposed_to_reagents(atom/source, list/reagents, datum/reagents/source_reagents, methods, volume_modifier, show_message)
	SIGNAL_HANDLER

	if (!(methods & INHALE))
		return

	var/final_total = 0
	for (var/datum/reagent/reagent as anything in reagents)
		final_total += reagents[reagent]
	if (istype(source_reagents.my_atom, /obj/item/clothing/mask/cigarette)) // smoking is bad, kids
		quirk_holder.adjust_lung_inflammation(inflammation_on_smoke * final_total * 5)

/// Signal proc for when our asthma attack qdels. Unsets our refs to it and resets [next_attack_cooldown].
/datum/quirk/asthma/proc/attack_deleting(datum/signal_source)
	SIGNAL_HANDLER

	UnregisterSignal(current_attack, COMSIG_QDELETING)
	current_attack = null

	COOLDOWN_START(src, next_attack_cooldown, rand(min_time_between_attacks, max_time_between_attacks))
