/datum/status_effect/fire_handler
	duration = -1
	alert_type = null
	status_type = STATUS_EFFECT_REFRESH //Custom code
	on_remove_on_mob_delete = TRUE
	tick_interval = 2 SECONDS
	/// Current amount of stacks we have
	var/stacks
	/// Maximum of stacks that we could possibly get
	var/stack_limit = MAX_FIRE_STACKS
	/// What status effect types do we remove uppon being applied. These are just deleted without any deduction from our or their stacks when forced.
	var/list/enemy_types
	/// What status effect types do we merge into if they exist. Ignored when forced.
	var/list/merge_types
	/// What status effect types do we override if they exist. These are simply deleted when forced.
	var/list/override_types
	/// For how much firestacks does one our stack count
	var/stack_modifier = 1

/datum/status_effect/fire_handler/refresh(mob/living/new_owner, new_stacks, forced = FALSE)
	if(forced)
		set_stacks(new_stacks)
	else
		adjust_stacks(new_stacks)

/datum/status_effect/fire_handler/on_creation(mob/living/new_owner, new_stacks, forced = FALSE)
	. = ..()

	if(isanimal(owner))
		qdel(src)
		return

	owner = new_owner
	set_stacks(new_stacks)

	for(var/enemy_type in enemy_types)
		var/datum/status_effect/fire_handler/enemy_effect = owner.has_status_effect(enemy_type)
		if(enemy_effect)
			if(forced)
				qdel(enemy_effect)
				continue

			var/cur_stacks = stacks
			adjust_stacks(-abs(enemy_effect.stacks * enemy_effect.stack_modifier / stack_modifier))
			enemy_effect.adjust_stacks(-abs(cur_stacks * stack_modifier / enemy_effect.stack_modifier))
			if(enemy_effect.stacks <= 0)
				qdel(enemy_effect)

			if(stacks <= 0)
				qdel(src)
				return

	if(!forced)
		var/list/merge_effects = list()
		for(var/merge_type in merge_types)
			var/datum/status_effect/fire_handler/merge_effect = owner.has_status_effect(merge_type)
			if(merge_effect)
				merge_effects += merge_effects

		if(LAZYLEN(merge_effects))
			for(var/datum/status_effect/fire_handler/merge_effect in merge_effects)
				merge_effect.adjust_stacks(stacks * stack_modifier / merge_effect.stack_modifier / LAZYLEN(merge_effects))
			qdel(src)
			return

	for(var/override_type in override_types)
		var/datum/status_effect/fire_handler/override_effect = owner.has_status_effect(override_type)
		if(override_effect)
			if(forced)
				qdel(override_effect)
				continue

			adjust_stacks(override_effect.stacks)
			qdel(override_effect)

/**
 * Setter and adjuster procs for firestacks
 *
 * Arguments:
 * - new_stacks
 *
 */

/datum/status_effect/fire_handler/proc/set_stacks(new_stacks)
	stacks = max(0, min(stack_limit, new_stacks))
	cache_stacks()

/datum/status_effect/fire_handler/proc/adjust_stacks(new_stacks)
	stacks = max(0, min(stack_limit, stacks + new_stacks))
	cache_stacks()

/**
 * Refresher for mob's fire_stacks
 */

/datum/status_effect/fire_handler/proc/cache_stacks()
	owner.fire_stacks = 0
	var/was_on_fire = owner.on_fire
	owner.on_fire = FALSE
	for(var/datum/status_effect/fire_handler/possible_fire in owner.status_effects)
		owner.fire_stacks += possible_fire.stacks * possible_fire.stack_modifier

		if(!istype(possible_fire, /datum/status_effect/fire_handler/fire_stacks))
			continue

		var/datum/status_effect/fire_handler/fire_stacks/our_fire = possible_fire
		if(our_fire.on_fire)
			owner.on_fire = TRUE

	if(was_on_fire && !owner.on_fire)
		owner.clear_alert(ALERT_FIRE)
	else if(!was_on_fire && owner.on_fire)
		owner.throw_alert(ALERT_FIRE, /atom/movable/screen/alert/fire)
	owner.update_appearance(UPDATE_OVERLAYS)

/datum/status_effect/fire_handler/fire_stacks
	id = "fire_stacks" //fire_stacks and wet_stacks should have different IDs or else has_status_effect won't work

	enemy_types = list(/datum/status_effect/fire_handler/wet_stacks)
	stack_modifier = 1

	/// If we're on fire
	var/on_fire = FALSE
	/// A weakref to the mob light emitter
	var/datum/weakref/firelight_ref
	/// Type of mob light emitter we use when on fire
	var/firelight_type = /obj/effect/dummy/lighting_obj/moblight/fire

/datum/status_effect/fire_handler/fire_stacks/tick(seconds_per_tick, times_fired)
	if(stacks <= 0)
		qdel(src)
		return TRUE

	if(!on_fire || isanimal(owner))
		return TRUE

	if(iscyborg(owner))
		adjust_stacks(-0.55 * seconds_per_tick)
	else
		adjust_stacks(-0.05 * seconds_per_tick)

	if(stacks <= 0)
		qdel(src)
		return TRUE

	var/datum/gas_mixture/air = owner.loc.return_air() // Check if we're standing in an oxygenless environment
	if(air.get_moles(GAS_O2) < 1)
		qdel(src)
		return TRUE

	deal_damage(seconds_per_tick, times_fired)

/**
 * Proc that handles damage dealing and all special effects
 *
 * Arguments:
 * - seconds_per_tick
 * - times_fired
 *
 */

/datum/status_effect/fire_handler/fire_stacks/proc/deal_damage(seconds_per_tick, times_fired)
	owner.on_fire_stack(seconds_per_tick, times_fired, src)

	var/turf/location = get_turf(owner)
	location.hotspot_expose(700, 25 * seconds_per_tick, TRUE)

/**
 * Used to deal damage to humans and count their protection.
 *
 * Arguments:
 * - seconds_per_tick
 * - times_fired
 * - no_protection: When set to TRUE, fire will ignore any possible fire protection
 *
 */

/datum/status_effect/fire_handler/fire_stacks/proc/harm_human(seconds_per_tick, times_fired, no_protection = FALSE)
	var/mob/living/carbon/human/victim = owner
	var/thermal_protection = victim.get_thermal_protection()

	if(!no_protection)
		if(thermal_protection >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
			return
		if(thermal_protection >= FIRE_SUIT_MAX_TEMP_PROTECT)
			victim.adjust_bodytemperature(5.5 * seconds_per_tick)
			return

	victim.adjust_bodytemperature((victim.dna.species.bodytemp_heating_rate_max + (stacks * 12)) * 0.5 * seconds_per_tick)
	victim.apply_damage((stacks * 0.5), FIRE, blocked = victim.run_armor_check(null, "fire", armour_penetration=stacks*5, silent=TRUE), spread_damage = TRUE)
	if(SPT_PROB(20, seconds_per_tick))
		var/obj/item/bodypart/it_burns = victim.get_bodypart(pick(BODY_ZONE_L_ARM,BODY_ZONE_L_LEG, BODY_ZONE_R_ARM, BODY_ZONE_R_LEG, BODY_ZONE_CHEST, BODY_ZONE_HEAD))
		if(it_burns)
			var/datum/wound/burn_injury
			switch(stacks)
				if(1 to 3)
					EMPTY_BLOCK_GUARD
				if(3 to 7)
					burn_injury = new /datum/wound/burn/moderate
				if(7 to 14)
					burn_injury = new /datum/wound/burn/severe
				if(14 to 20)
					burn_injury = new /datum/wound/burn/critical
			if(burn_injury)
				burn_injury.apply_wound(it_burns)
	SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "on_fire", /datum/mood_event/on_fire)

/**
 * Handles mob ignition, should be the only way to set on_fire to TRUE
 *
 * Arguments:
 * - silent: When set to TRUE, no message is displayed
 *
 */

/datum/status_effect/fire_handler/fire_stacks/proc/ignite(silent = FALSE)
	if(HAS_TRAIT(owner, TRAIT_NOFIRE))
		return FALSE

	on_fire = TRUE
	if(!silent)
		owner.visible_message(span_warning("[owner] catches fire!"), span_userdanger("You're set on fire!"))

	if(firelight_type)
		firelight_ref = WEAKREF(new firelight_type(owner))

	SEND_SIGNAL(owner, COMSIG_LIVING_IGNITED, owner)
	cache_stacks()
	owner.update_overlays()

/**
 * Handles mob extinguishing, should be the only way to set on_fire to FALSE
 */

/datum/status_effect/fire_handler/fire_stacks/proc/extinguish()
	if(firelight_ref)
		qdel(firelight_ref)

	on_fire = FALSE
	SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "on_fire")
	SEND_SIGNAL(owner, COMSIG_LIVING_EXTINGUISHED, owner)
	cache_stacks()
	for(var/obj/item/equipped in (owner.get_equipped_items(TRUE)))
		equipped.extinguish()

/datum/status_effect/fire_handler/fire_stacks/on_remove()
	if(on_fire)
		extinguish()
	set_stacks(0)

/datum/status_effect/fire_handler/fire_stacks/get_examine_text()
	switch(stacks)
		if(1 to 20)
			return span_warning("[owner.p_they(TRUE)] [owner.p_are()] covered in something flammable.")
	return null

/datum/status_effect/fire_handler/fire_stacks/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(add_fire_overlay))
	owner.update_appearance(UPDATE_OVERLAYS)

/datum/status_effect/fire_handler/fire_stacks/proc/add_fire_overlay(mob/living/source, list/overlays)
	SIGNAL_HANDLER

	if(stacks <= 0 || !on_fire)
		return

	var/mutable_appearance/created_overlay = owner.get_fire_overlay(stacks, on_fire)
	if(isnull(created_overlay))
		return

	overlays |= created_overlay

/datum/status_effect/fire_handler/wet_stacks
	id = "wet_stacks"

	enemy_types = list(/datum/status_effect/fire_handler/fire_stacks)
	stack_modifier = -1

/datum/status_effect/fire_handler/wet_stacks/tick(seconds_per_tick)
	adjust_stacks(-0.5 * seconds_per_tick)
	if(stacks <= 0)
		qdel(src)

/datum/status_effect/fire_handler/wet_stacks/get_examine_text()
	switch(stacks)
		if(1 to 15)
			return span_warning("[owner.p_they(TRUE)] looks a little soaked.")
		if(15 to 20)
			return span_boldwarning("[owner.p_they(TRUE)] is completely sopping!")
	return null
