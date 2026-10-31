// How basic humans burn

// burning hurts us at a player's rate, less what our clothes keep out, and a full fire suit keeps all of it out
/mob/living/basic/human/on_fire_stack(seconds_per_tick, datum/status_effect/fire_handler/fire_stacks/fire_handler)
	var/thermal_protection = get_outfit_thermal_protection()
	if(thermal_protection >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
		return
	if(thermal_protection >= FIRE_SUIT_MAX_TEMP_PROTECT)
		adjust_bodytemperature(5.5 * seconds_per_tick)
		return
	adjust_bodytemperature((HUMAN_BODYTEMP_HEATING_MAX + (fire_handler.stacks * 12)) * 0.5 * seconds_per_tick)
	apply_damage(fire_handler.stacks * 0.5, BURN, blocked = run_armor_check(null, FIRE, armour_penetration = fire_handler.stacks * 5, silent = TRUE))

/mob/living/basic/human/get_fire_overlay(stacks, on_fire)
	var/datum/species/species_type = mob_species
	var/species_fire = ispath(species_type, /datum/species) ? initial(species_type.fire_overlay) : null
	var/fire_icon = "[species_fire || "human"]_[stacks > MOB_BIG_FIRE_STACK_THRESHOLD ? "big_fire" : "small_fire"]"
	if(!GLOB.fire_appearances[fire_icon])
		GLOB.fire_appearances[fire_icon] = mutable_appearance('icons/mob/onfire.dmi', fire_icon, -HIGHEST_LAYER, appearance_flags = RESET_COLOR)
	return GLOB.fire_appearances[fire_icon]

// stop, drop and roll!
/mob/living/basic/human/resist_fire()
	rolling_out_fire = TRUE // for the first roll's knockdown, before the roll's on us
	. = !!apply_status_effect(/datum/status_effect/stop_drop_roll)
	rolling_out_fire = FALSE

// whether we can pat out someone's fire without burning our hands
/mob/living/basic/human/proc/has_hot_hands()
	if(HAS_TRAIT(src, TRAIT_RESISTHEAT) || HAS_TRAIT(src, TRAIT_RESISTHEATHANDS))
		return TRUE
	return get_outfit_protection()[OUTFIT_HOT_HANDS]

/mob/living/basic/human/proc/get_outfit_thermal_protection()
	return get_outfit_protection()[OUTFIT_THERMAL_PROTECTION]

// whether a full fire suit keeps air this hot off us
/mob/living/basic/human/proc/insulated_from_heat(temperature)
	return get_outfit_thermal_protection() >= max(temperature, FIRE_SUIT_MAX_TEMP_PROTECT)
