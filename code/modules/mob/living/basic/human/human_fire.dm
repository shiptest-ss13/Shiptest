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
	var/static/list/hot_hands_by_outfit = list()
	var/outfit_key = "[mob_spawner]|[armor_base]|[armored_all_over]"
	if(!isnull(hot_hands_by_outfit[outfit_key]))
		return hot_hands_by_outfit[outfit_key]
	var/list/worn = list()
	if(mob_spawner && !armored_all_over)
		worn += get_spawner_clothing(mob_spawner)
	if(ispath(armor_base, /obj/item/clothing))
		worn += armor_base
	var/hot_hands = FALSE
	for(var/obj/item/clothing/gloves/gloves_type as anything in worn)
		if(ispath(gloves_type, /obj/item/clothing/gloves) && initial(gloves_type.max_heat_protection_temperature) > 360)
			hot_hands = TRUE
			break
	hot_hands_by_outfit[outfit_key] = hot_hands
	return hot_hands

/mob/living/basic/human/proc/get_outfit_thermal_protection()
	var/static/list/protection_by_outfit = list()
	var/outfit_key = "[mob_spawner]|[armor_base]|[armored_all_over]"
	if(!isnull(protection_by_outfit[outfit_key]))
		return protection_by_outfit[outfit_key]
	var/list/worn = list()
	if(mob_spawner && !armored_all_over)
		worn += get_spawner_clothing(mob_spawner)
	if(ispath(armor_base, /obj/item/clothing))
		worn += armor_base
	var/suit_protection = 0
	var/head_protection = 0
	for(var/obj/item/clothing/clothing_type as anything in worn)
		var/max_heat = ispath(clothing_type, /obj/item/clothing) ? initial(clothing_type.max_heat_protection_temperature) : 0
		if(ispath(clothing_type, /obj/item/clothing/suit) && max_heat >= FIRE_SUIT_MAX_TEMP_PROTECT)
			suit_protection = max(suit_protection, max_heat * 0.7)
		else if(ispath(clothing_type, /obj/item/clothing/head) && max_heat >= FIRE_HELM_MAX_TEMP_PROTECT)
			head_protection = max(head_protection, max_heat * 0.3)
	var/thermal_protection = round(suit_protection + head_protection)
	protection_by_outfit[outfit_key] = thermal_protection
	return thermal_protection
