/obj/item/bodypart
	name = "limb"
	desc = "Why is it detached..."
	force = 3
	throwforce = 3
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/mob/human_parts_greyscale.dmi'
	var/husk_icon = 'icons/mob/human_parts.dmi'
	var/husk_type = "humanoid"
	var/static_icon = 'icons/mob/human_parts.dmi' //Uncolorable sprites
	icon_state = ""
	layer = BELOW_MOB_LAYER //so it isn't hidden behind objects when on the floor
	var/mob/living/carbon/owner = null
	var/datum/weakref/original_owner = null
	///List of bodytypes flags, important for fitting clothing. If you'd like to know if a bodypart is organic, please use is_organic_limb()
	var/bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC

	///The types of wounds this bodypart is capable of receiving.
	var/biological_state = BIO_STANDARD_UNJOINTED

	///Whether the clothing being worn forces the limb into being "squished" to plantigrade/standard humanoid compliance
	var/plantigrade_forced = FALSE
	///Whether the limb is husked
	var/is_husked = FALSE
	///This is effectively the icon_state prefix for limbs.
	var/limb_id = SPECIES_HUMAN
	///Defines what sprite the limb should use if it is also sexually dimorphic.
	var/limb_gender = "m"
	///Does this limb have a greyscale version?
	var/uses_mutcolor = TRUE
	///Is there a sprite difference between male and female?
	var/is_dimorphic = FALSE
	///Greyscale draw color
	var/draw_color
	///Should it automatically rename itself based on limb_id and body_zone?
	var/dynamic_rename = TRUE

	/// The icon state of the limb's overlay, colored with a different color
	var/overlay_icon_state
	/// The color of the limb's overlay
	var/species_secondary_color

	var/body_zone //BODY_ZONE_CHEST, BODY_ZONE_L_ARM, etc , used for def_zone
	/// The body zone of this part in english ("chest", "left arm", etc) without the species attached to it
	var/plaintext_zone
	var/aux_zone // used for hands
	var/aux_layer
	///bitflag used to check which clothes cover this bodypart
	var/body_part = null
	var/list/embedded_objects = list()
	///Are we a hand? if so, which one!
	var/held_index = 0
	///For limbs that don't really exist, eg chainsaws
	var/is_pseudopart = FALSE

	///If disabled, limb is as good as missing.
	var/bodypart_disabled = FALSE
	///Multiplied by max_damage it returns the threshold which defines a limb being disabled or not. From 0 to 1. 0 means no disable thru damage
	var/disable_threshold = 1
	///Controls whether bodypart_disabled makes sense or not for this limb.
	var/can_be_disabled = FALSE
	///Multiplier of the limb's damage that gets applied to the mob
	var/body_damage_coeff = 1
	var/stam_damage_coeff = 0.75  //Why is this the default??? - Kapu
	var/brutestate = 0
	var/burnstate = 0
	var/brute_dam = 0
	var/burn_dam = 0
	var/stamina_dam = 0
	var/max_stamina_damage = 0
	var/max_damage = 0

	///Gradually increases while burning when at full damage, destroys the limb when at 100
	var/cremation_progress = 0

	///Subtracted from brute damage taken
	var/brute_reduction = 0
	///Subtracted from burn damage taken
	var/burn_reduction = 0

	//Coloring and proper item icon update
	var/skin_tone = ""
	///Limbs need this information as a back-up incase they are generated outside of a carbon (limbgrower)
	var/should_draw_greyscale = TRUE
	var/species_color = ""
	var/mutation_color = ""
	/// The colour of damage done to this bodypart
	var/damage_color = ""
	/// Should we even use a color?
	var/use_damage_color = FALSE
	var/no_update = 0

	/// If it's a nonhuman bodypart (e.g. monkey)
	var/animal_origin = null
	/// Whether it can be dismembered with a weapon
	var/dismemberable = TRUE

	var/px_x = 0
	var/px_y = 0

	var/species_flags_list = list()

	///the type of damage overlay (if any) to use when this bodypart is bruised/burned.
	var/dmg_overlay_type
	///the path for dmg overlay icons.
	var/dmg_overlay_icon = 'icons/mob/dam_mob.dmi'
	/// If we're bleeding, which icon are we displaying on this part
	var/bleed_overlay_icon

	//Damage messages used by help_shake_act()
	var/light_brute_msg = "bruised"
	var/medium_brute_msg = "battered"
	var/heavy_brute_msg = "mangled"

	var/light_burn_msg = "numb"
	var/medium_burn_msg = "blistered"
	var/heavy_burn_msg = "peeling away"

	/// The wounds currently afflicting this body part
	var/list/wounds

	/// The scars currently afflicting this body part
	var/list/scars
	/// Our current stored wound damage multiplier
	var/wound_damage_multiplier = 1
	/// The amount of damage on this limb that cannot be healed until the wounds causing it are fixed
	var/wound_integrity_loss = 0

	/// This number is subtracted from all wound rolls on this bodypart, higher numbers mean more defense, negative means easier to wound
	var/wound_resistance = 0
	/// When this bodypart hits max damage, this number is added to all wound rolls. Obviously only relevant for bodyparts that have damage caps.
	var/disabled_wound_penalty = 15

	/// A hat won't cover your face, but a shirt covering your chest will cover your... you know, chest
	var/scars_covered_by_clothes = TRUE
	/// So we know if we need to scream if this limb hits max damage
	var/last_maxed
	/// How much generic bleedstacks we have on this bodypart
	var/generic_bleedstacks
	/// If we have a gauze wrapping currently applied
	var/datum/bodypart_aid/gauze/current_gauze
	/// If we have a splint currently applied
	var/datum/bodypart_aid/splint/current_splint
	/// If something is currently grasping this bodypart and trying to staunch bleeding (see [/obj/item/grasp_self])
	var/obj/item/self_grasp/grasped_by

//band-aid for blood overlays & other external overlays until they get refactored
	var/stored_icon_state

	/// In the case we dont have dismemberable features, or literally cant get wounds, we will use this percent to determine when we can be dismembered.
	/// Compared to our ABSOLUTE maximum. Stored in decimal; 0.8 = 80%.
	var/hp_percent_to_dismemberable = 0.8
	/// If true, we will use [hp_percent_to_dismemberable] even if we are dismemberable via wounds. Useful for things with extreme wound resistance.
	var/use_alternate_dismemberment_calc_even_if_mangleable = FALSE
	/// If false, no wound that can be applied to us can mangle our exterior. Used for determining if we should use [hp_percent_to_dismemberable] instead of normal dismemberment.
	var/any_existing_wound_can_mangle_our_exterior
	/// If false, no wound that can be applied to us can mangle our interior. Used for determining if we should use [hp_percent_to_dismemberable] instead of normal dismemberment.
	var/any_existing_wound_can_mangle_our_interior

/obj/item/bodypart/Initialize()
	. = ..()
	if(dynamic_rename)
		name = "[limb_id] [parse_zone(body_zone)]"
	update_icon_dropped()

	if(!IS_ORGANIC_LIMB(src))
		grind_results = null

/obj/item/bodypart/forceMove(atom/destination) //Please. Never forcemove a limb if its's actually in use. This is only for borgs.
	. = ..()
	if(isturf(destination))
		update_icon_dropped()

/obj/item/bodypart/Initialize(mapload)
	. = ..()
	if(can_be_disabled)
		RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS), PROC_REF(on_paralysis_trait_gain))
		RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS), PROC_REF(on_paralysis_trait_loss))

/obj/item/bodypart/Destroy()
	if(owner)
		owner.remove_bodypart(src)
		set_owner(null)
	for(var/wound in wounds)
		qdel(wound) // wounds is a lazylist, and each wound removes itself from it on deletion.
	if(length(wounds))
		stack_trace("[type] qdeleted with [length(wounds)] uncleared wounds")
		wounds.Cut()
	if(current_gauze)
		qdel(current_gauze)
	if(current_splint)
		qdel(current_splint)
	return ..()

/obj/item/bodypart/examine(mob/user)
	. = ..()
	if(brute_dam > DAMAGE_PRECISION)
		. += span_warning("This limb has [brute_dam > 30 ? "severe" : "minor"] bruising.")
	if(burn_dam > DAMAGE_PRECISION)
		. += span_warning("This limb has [burn_dam > 30 ? "severe" : "minor"] burns.")

/obj/item/bodypart/attack(mob/living/carbon/C, mob/user)
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(HAS_TRAIT(C, TRAIT_LIMBATTACHMENT))
			if(!H.get_bodypart(body_zone) && !animal_origin)
				user.temporarilyRemoveItemFromInventory(src, TRUE)
				if(!attach_limb(C))
					to_chat(user, span_warning("[H]'s body rejects [src]!"))
					forceMove(H.loc)
				if(H == user)
					H.visible_message(span_warning("[H] jams [src] into [H.p_their()] empty socket!"),\
					span_notice("You force [src] into your empty socket, and it locks into place!"))
				else
					H.visible_message(span_warning("[user] jams [src] into [H]'s empty socket!"),\
					span_notice("[user] forces [src] into your empty socket, and it locks into place!"))
				return
	..()

/obj/item/bodypart/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		add_fingerprint(user)
		if(!contents.len)
			to_chat(user, span_warning("There is nothing left inside [src]!"))
			return
		playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
		user.visible_message(span_warning("[user] begins to cut open [src]."),\
			span_notice("You begin to cut open [src]..."))
		if(do_after(user, 54, target = src))
			drop_organs(user, TRUE)
	else
		return ..()

/obj/item/bodypart/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	if(IS_ORGANIC_LIMB(src))
		playsound(get_turf(src), 'sound/misc/splort.ogg', 50, TRUE, -1)
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3)

//empties the bodypart from its organs and other things inside it
/obj/item/bodypart/proc/drop_organs(mob/user, violent_removal)
	var/turf/T = get_turf(src)
	if(IS_ORGANIC_LIMB(src))
		playsound(T, 'sound/misc/splort.ogg', 50, TRUE, -1)
	if(current_gauze)
		qdel(current_gauze)
	if(current_splint)
		qdel(current_splint)
	for(var/obj/item/organ/drop_organ as anything in get_organs())
		drop_organ.transfer_to_limb(src, owner)
	for(var/obj/item/I in src)
		I.forceMove(T)

///since organs aren't actually stored in the bodypart themselves while attached to a person, we have to query the owner for what we should have
/obj/item/bodypart/proc/get_organs(required_status)
	if(!owner)
		return FALSE

	var/list/bodypart_organs
	for(var/obj/item/organ/organ_check as anything in owner.internal_organs) //internal organs inside the dismembered limb are dropped.
		if(required_status && required_status != organ_check.status)
			continue
		if(check_zone(organ_check.zone) == body_zone)
			LAZYADD(bodypart_organs, organ_check) // this way if we don't have any, it'll just return null

	return bodypart_organs

//Return TRUE to get whatever mob this is in to update health.
/obj/item/bodypart/proc/on_life()
	SHOULD_CALL_PARENT(TRUE)

	if(stamina_dam > DAMAGE_PRECISION && owner.stam_regen_start_time <= world.time) //DO NOT update health here, it'll be done in the carbon's life.
		heal_damage(0, 0, INFINITY, null, FALSE)
		. |= BODYPART_LIFE_UPDATE_HEALTH

//Applies brute and burn damage to the organ. Returns 1 if the damage-icon states changed at all.
//Damage will not exceed max_damage using this proc
//Cannot apply negative damage
/obj/item/bodypart/proc/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE, attack_direction = null, ignore_reduction = 0)
	var/hit_percent = (100-blocked)/100
	if((!brute && !burn && !stamina) || hit_percent <= 0)
		return FALSE

	if(owner && (owner.status_flags & GODMODE))
		return FALSE

	if(required_status && !(bodytype & required_status))
		return FALSE

	var/dmg_mlt = CONFIG_GET(number/damage_multiplier) * hit_percent
	brute = round(max(brute * dmg_mlt, 0),DAMAGE_PRECISION)
	burn = round(max(burn * dmg_mlt, 0),DAMAGE_PRECISION)
	stamina = round(max(stamina * dmg_mlt, 0),DAMAGE_PRECISION)
	brute = max(0, brute - max(brute_reduction - ignore_reduction, 0))
	burn = max(0, burn - max(burn_reduction - ignore_reduction, 0))

	if(!brute && !burn && !stamina)
		return FALSE

	brute *= wound_damage_multiplier
	burn *= wound_damage_multiplier

	switch(animal_origin)
		if(ALIEN_BODYPART,LARVA_BODYPART) //aliens take double burn //nothing can burn with so much snowflake code around
			burn *= 2

	if(wound_roll(brute, burn, wound_bonus, bare_wound_bonus, sharpness, attack_direction))
		return // stop here if dismembered

	//back to our regularly scheduled program, we now actually apply damage if there's room below limb damage cap
	var/can_inflict = max_damage - get_damage()
	var/total_damage = brute + burn
	if(total_damage > can_inflict && total_damage > 0) // TODO: the second part of this check should be removed once disabling is all done
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)

	if(can_inflict <= 0)
		return FALSE
	if(brute)
		set_brute_dam(brute_dam + brute)
	if(burn)
		set_burn_dam(burn_dam + burn)

	//We've dealt the physical damages, if there's room lets apply the stamina damage.
	if(stamina)
		set_stamina_dam(stamina_dam + round(clamp(stamina, 0, max_stamina_damage - stamina_dam), DAMAGE_PRECISION))

	if(owner)
		if(can_be_disabled)
			update_disabled()
		if(updating_health)
			owner.updatehealth()
			if(stamina > DAMAGE_PRECISION)
				owner.update_stamina()
				owner.stam_regen_start_time = world.time + STAMINA_REGEN_BLOCK_TIME
				. = TRUE
	return update_bodypart_damage_state() || .

/// Rolls for wounds, returning TRUE if the limb was dismembered.
/obj/item/bodypart/proc/wound_roll(brute, burn, wound_bonus = 0, bare_wound_bonus = 0, sharpness=SHARP_NONE, attack_direction, no_dismember = FALSE)
	if(wound_bonus == CANT_WOUND)
		return

	// if we have easydismember, we don't reduce damage when redirecting damage to different types (slashing weapons on mangled/skinless limbs attack at 100% instead of 50%)
	var/easy_dismember = HAS_TRAIT(owner, TRAIT_EASYDISMEMBER) || HAS_TRAIT(src, TRAIT_EASYDISMEMBER)

	/// Associated list of each wound type and how much effective wounding damage can be done of that type.
	var/list/wounding_types
	switch(sharpness)
		if(SHARP_NONE)
			if(brute)
				LAZYSET(wounding_types, WOUND_BLUNT, brute)
		if(SHARP_EDGED)
			LAZYSET(wounding_types, WOUND_SLASH, brute + burn)
			if(brute)
				LAZYSET(wounding_types, WOUND_BLUNT, brute * (easy_dismember ? 1 : 0.6))
		if(SHARP_POINTY)
			LAZYSET(wounding_types, WOUND_PIERCE, brute + burn)
			if(brute)
				LAZYSET(wounding_types, WOUND_BLUNT, brute * (easy_dismember ? 1 : 0.6))
	if(burn)
		LAZYSET(wounding_types, WOUND_BURN, burn)

	if(!no_dismember && (dismemberable_by_wound() || dismemberable_by_total_damage()) && try_dismember(wounding_types, wound_bonus, bare_wound_bonus))
		return TRUE

	var/highest_damage = 0
	// now we have our wounding_type and are ready to carry on with wounds and dealing the actual damage
	if(LAZYLEN(wounding_types))
		if(current_gauze)
			current_gauze.take_damage()
		if(current_splint)
			current_splint.take_damage()
		for(var/wound_type in wounding_types)
			if(!owner)
				break
			highest_damage = max(highest_damage, wounding_types[wound_type])
		check_wounding(wounding_types, wound_bonus, bare_wound_bonus, attack_direction, no_dismember)

	for(var/datum/wound/iter_wound as anything in wounds)
		iter_wound.receive_damage(wounding_types, highest_damage, wound_bonus)

/**
 * check_wounding() is where we handle rolling for, selecting, and applying a wound if we meet the criteria
 *
 * We generate a "score" for how woundable the attack was based on the damage and other factors discussed in [/obj/item/bodypart/proc/check_wounding_mods], then go down the list from most severe to least severe wounds in that category.
 * We can promote a wound from a lesser to a higher severity this way, but we give up if we have a wound of the given type and fail to roll a higher severity, so no sidegrades/downgrades
 *
 * Arguments:
 * * woundtype- Either WOUND_BLUNT, WOUND_SLASH, WOUND_PIERCE, or WOUND_BURN based on the attack type.
 * * damage- How much damage is tied to this attack, since wounding potential scales with damage in an attack (see: WOUND_DAMAGE_EXPONENT)
 * * wound_bonus- The wound_bonus of an attack
 * * bare_wound_bonus- The bare_wound_bonus of an attack
 */
/obj/item/bodypart/proc/check_wounding(list/wounding_types, wound_bonus, bare_wound_bonus, attack_direction, no_dismember = FALSE)
	var/damage_mult = 1

	// note that these are fed into an exponent, so these are magnified
	if(HAS_TRAIT(owner, TRAIT_EASILY_WOUNDED))
		damage_mult *= 1.5

	if(HAS_TRAIT(owner,TRAIT_HARDLY_WOUNDED))
		damage_mult *= 0.85

	if(HAS_TRAIT(owner, TRAIT_VERY_HARDLY_WOUNDED))
		damage_mult *= 0.6

	if(HAS_TRAIT(owner, TRAIT_EASYDISMEMBER))
		damage_mult *= 1.1

	var/wounding_mods = check_woundings_mods(wound_bonus, bare_wound_bonus)
	var/highest_roll = 0
	var/highest_wound_type
	var/list/wound_rolls = list()
	for(var/wounding_type in wounding_types)
		for(var/wounding_series in SSwounds.types_to_series[wounding_type])
			var/injury_roll = rand(1, round(min(wounding_types[wounding_type], WOUND_MAX_CONSIDERED_DAMAGE) * damage_mult) ** WOUND_DAMAGE_EXPONENT) + wounding_mods
			if(injury_roll > highest_roll)
				highest_wound_type = wounding_type
				highest_roll = highest_roll
			wound_rolls[wounding_series] = max(injury_roll, wound_rolls[wounding_series])
	if(!wound_rolls.len)
		CRASH("check_wounding called with a null wounding_types list!")
	if(!no_dismember && highest_roll > WOUND_DISMEMBER_OUTRIGHT_THRESH && prob(get_damage() / max_damage * 100))
		var/datum/wound/loss/dismembering = new
		dismembering.apply_dismember(src, highest_wound_type, outright = TRUE, attack_direction = attack_direction)
		return

	var/list/series_wounding_mods = check_series_wounding_mods()

	var/list/datum/wound/possible_wounds = list()
	for(var/datum/wound/wound_type as anything in SSwounds.pregen_data)
		var/datum/wound_pregen_data/pregen_data = SSwounds.pregen_data[wound_type]
		if(pregen_data.can_be_applied_to(src, wounding_types, random_roll = TRUE))
			possible_wounds[wound_type] = pregen_data.get_weight(src, wounding_types, attack_direction)

	// quick re-check to see if bare_wound_bonus applies, for the benefit of log_wound(), see about getting the check from check_woundings_mods() somehow
	if(ishuman(owner))
		var/mob/living/carbon/human/human_wearer = owner
		var/list/clothing = human_wearer.get_clothing_on_part(src)
		for(var/obj/item/clothing/clothes_check as anything in clothing)
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			if(clothes_check.armor.getRating(WOUND))
				bare_wound_bonus = 0
				break

	for(var/datum/wound/iterated_path as anything in possible_wounds)
		for(var/datum/wound/existing_wound as anything in wounds)
			if(iterated_path == existing_wound.type)
				possible_wounds -= iterated_path
				break // breaks out of the nested loop

		var/datum/wound_pregen_data/pregen_data = SSwounds.pregen_data[iterated_path]
		var/specific_injury_roll = (wound_rolls[pregen_data.wound_series] + series_wounding_mods[pregen_data.wound_series])
		if(pregen_data.get_threshold_for(src, attack_direction) > specific_injury_roll)
			possible_wounds -= iterated_path
			continue

		if(pregen_data.compete_for_wounding)
			for(var/datum/wound/other_path as anything in possible_wounds)
				if(other_path == iterated_path)
					continue
				if(iterated_path::severity == other_path::severity && pregen_data.overpower_wounds_of_even_severity)
					possible_wounds -= other_path
					continue
				else if(pregen_data.competition_mode == WOUND_COMPETITION_OVERPOWER_LESSERS)
					if(iterated_path::severity > other_path::severity)
						possible_wounds -= other_path
						continue
				else if(pregen_data.competition_mode == WOUND_COMPETITION_OVERPOWER_GREATERS)
					if(iterated_path::severity < other_path::severity)
						possible_wounds -= other_path
						continue

	var/list/datum/wound/applied_wounds
	while(length(possible_wounds))
		var/datum/wound/possible_wound = pick_weight(possible_wounds)
		var/datum/wound_pregen_data/possible_pregen_data = SSwounds.pregen_data[possible_wound]
		possible_wounds -= possible_wound

		// this makes muscle wounds show up less consistently at the same time as others
		if(LAZYLEN(applied_wounds) && !prob(possible_wounds[possible_wound]))
			continue

		var/datum/wound/replaced_wound
		for(var/i in wounds)
			var/datum/wound/existing_wound = i
			var/datum/wound_pregen_data/existing_pregen_data = SSwounds.pregen_data[existing_wound.type]
			if(existing_pregen_data.wound_series == possible_pregen_data.wound_series)
				if(existing_wound.severity >= possible_wound::severity)
					continue
				else
					replaced_wound = existing_wound

		// if we get through this whole loop without continuing, we found our winner
		var/datum/wound/new_wound = new possible_wound
		if(replaced_wound)
			new_wound = replaced_wound.replace_wound(new_wound, attack_direction = attack_direction)
		else
			new_wound.apply_wound(src, attack_direction = attack_direction)
		LAZYADD(applied_wounds, new_wound)

	if(LAZYLEN(applied_wounds)) // dismembering wounds are logged in the apply_wound() for loss wounds since they delete themselves immediately, these will be immediately returned
		log_wound(owner, src, applied_wounds, wounding_types, wound_bonus, bare_wound_bonus, wound_rolls)
	return applied_wounds

// try forcing a specific wound, but only if there isn't already a wound of that severity or greater for that type on this bodypart
/obj/item/bodypart/proc/force_wound_upwards(datum/wound/potential_wound, smited = FALSE, wound_source)
	SHOULD_NOT_OVERRIDE(TRUE)

	if (isnull(potential_wound))
		return

	var/datum/wound_pregen_data/pregen_data = SSwounds.pregen_data[potential_wound]
	for(var/datum/wound/existing_wound as anything in wounds)
		var/datum/wound_pregen_data/existing_pregen_data = existing_wound.get_pregen_data()
		if(existing_pregen_data.wound_series == pregen_data.wound_series)
			if(existing_wound.severity < potential_wound::severity) // we only try if the existing one is inferior to the one we're trying to force
				existing_wound.replace_wound(new potential_wound, smited)
			return

	var/datum/wound/new_wound = new potential_wound
	new_wound.apply_wound(src, smited = smited)
	return new_wound

/**
 *  A simple proc to force a type of wound onto this mob. If you just want to force a specific mainline (fractures, bleeding, etc.) wound, you only need to care about the first 3 args.
 *
 * Args:
 * * wounding_type: The wounding_type, e.g. WOUND_BLUNT, WOUND_SLASH to force onto the mob. Can be a list.
 * * obj/item/bodypart/limb: The limb we wil be applying the wound to. If null, a random bodypart will be picked.
 * * min_severity: The minimum severity that will be considered.
 * * max_severity: The maximum severity that will be considered.
 * * severity_pick_mode: The "pick mode" to be used. See get_corresponding_wound_type's documentation
 * * wound_source: The source of the wound to be applied. Nullable.
 *
 * For the rest of the args, refer to get_corresponding_wound_type().
 *
 * Returns:
 * A new wound instance if the application was successful, null otherwise.
*/
/mob/living/carbon/proc/cause_wound_of_type_and_severity(wounding_type, obj/item/bodypart/limb, min_severity, max_severity = min_severity, severity_pick_mode = WOUND_PICK_HIGHEST_SEVERITY, wound_source)
	if(isnull(limb))
		limb = pick(bodyparts)

	var/list/type_list = wounding_type
	if(!islist(type_list))
		type_list = list(type_list)

	var/datum/wound/corresponding_typepath = SSwounds.get_corresponding_wound_type(type_list, limb, min_severity, max_severity, severity_pick_mode)
	if(corresponding_typepath)
		return limb.force_wound_upwards(corresponding_typepath, wound_source = wound_source)

/// Limb is nullable, but picks a random one. Defers to limb.get_wound_threshold_of_wound_type, see it for documentation.
/mob/living/carbon/proc/get_wound_threshold_of_wound_type(wounding_type, severity, default, obj/item/bodypart/limb, wound_source)
	if(isnull(limb))
		limb = pick(bodyparts)

	if(!limb)
		return default

	return limb.get_wound_threshold_of_wound_type(wounding_type, severity, default, wound_source)

/**
 * A simple proc that gets the best wound to fit the criteria laid out, then returns its wound threshold.
 *
 * Args:
 * * wounding_type: The wounding_type, e.g. WOUND_BLUNT, WOUND_SLASH to force onto the mob. Can be a list of wounding_types.
 * * severity: The severity that will be considered.
 * * return_value_if_no_wound: If no wound is found, we will return this instead. (It is reccomended to use named args for this one, as its unclear what it is without)
 * * wound_source: The theoretical source of the wound. Nullable.
 *
 * Returns:
 * return_value_if_no_wound if no wound is found - if one IS found, the wound threshold for that wound.
 */
/obj/item/bodypart/proc/get_wound_threshold_of_wound_type(wounding_type, severity, return_value_if_no_wound, wound_source)
	var/list/type_list = wounding_type
	if(!islist(type_list))
		type_list = list(type_list)

	var/datum/wound/wound_path = SSwounds.get_corresponding_wound_type(type_list, src, severity, duplicates_allowed = TRUE, care_about_existing_wounds = FALSE)
	if(wound_path)
		var/datum/wound_pregen_data/pregen_data = SSwounds.pregen_data[wound_path]
		return pregen_data.get_threshold_for(src, damage_source = wound_source)

	return return_value_if_no_wound

/**
 * check_wounding_mods() is where we handle the various modifiers of a wound roll
 *
 * A short list of things we consider: any armor a human target may be wearing, and if they have no wound armor on the limb, if we have a bare_wound_bonus to apply, plus the plain wound_bonus
 * We also flick through all of the wounds we currently have on this limb and add their threshold penalties, so that having lots of bad wounds makes you more liable to get hurt worse
 * Lastly, we add the inherent wound_resistance variable the bodypart has (heads and chests are slightly harder to wound), and a small bonus if the limb is already disabled
 *
 * Arguments:
 * * It's the same ones on [/obj/item/bodypart/proc/receive_damage]
 */
/obj/item/bodypart/proc/check_woundings_mods(wound_bonus, bare_wound_bonus)
	var/armor_ablation = 0
	var/injury_mod = 0

	if(owner && ishuman(owner))
		var/mob/living/carbon/human/H = owner
		var/list/clothing = H.get_clothing_on_part(src)
		for(var/obj/item/clothing/C as anything in clothing)
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			armor_ablation += C.armor.getRating("wound")

		if(!armor_ablation)
			injury_mod += bare_wound_bonus

	injury_mod -= armor_ablation
	injury_mod += wound_bonus

	for(var/datum/wound/wound as anything in wounds)
		injury_mod += wound.threshold_penalty

	var/part_mod = -wound_resistance
	if(bodypart_disabled >= max_damage)
		part_mod += disabled_wound_penalty

	injury_mod += part_mod

	return injury_mod

/// Returns a bitflag using ANATOMY_EXTERIOR or ANATOMY_INTERIOR. Used to determine if we as a whole have a interior or exterior biostate, or both.
/obj/item/bodypart/proc/get_bio_state_status()
	SHOULD_BE_PURE(TRUE)

	var/bio_status = NONE

	for (var/state as anything in SSwounds.bio_state_anatomy)
		var/flag = text2num(state)
		if (!(biological_state & flag))
			continue

		var/value = SSwounds.bio_state_anatomy[state]
		if (value & ANATOMY_EXTERIOR)
			bio_status |= ANATOMY_EXTERIOR
		if (value & ANATOMY_INTERIOR)
			bio_status |= ANATOMY_INTERIOR

		if ((bio_status & ANATOMY_EXTERIOR_AND_INTERIOR) == ANATOMY_EXTERIOR_AND_INTERIOR)
			break

	return bio_status

/// Returns if our current mangling status allows us to be dismembered. Requires both no exterior/mangled exterior and no interior/mangled interior.
/obj/item/bodypart/proc/dismemberable_by_wound()
	SHOULD_BE_PURE(TRUE)

	var/mangled_state = get_mangled_state()

	var/bio_status = get_bio_state_status()

	var/has_exterior = ((bio_status & ANATOMY_EXTERIOR))
	var/has_interior = ((bio_status & ANATOMY_INTERIOR))

	var/exterior_ready_to_dismember = (!has_exterior || ((mangled_state & BODYPART_MANGLED_EXTERIOR)))
	var/interior_ready_to_dismember = (!has_interior || ((mangled_state & BODYPART_MANGLED_INTERIOR)))

	return (exterior_ready_to_dismember && interior_ready_to_dismember)

/// Returns TRUE if our total percent damage is more or equal to our dismemberable percentage, but FALSE if a wound can cause us to be dismembered.
/obj/item/bodypart/proc/dismemberable_by_total_damage()

	update_wound_theory()

	var/bio_status = get_bio_state_status()

	var/has_interior = ((bio_status & ANATOMY_INTERIOR))
	var/can_theoretically_be_dismembered_by_wound = (any_existing_wound_can_mangle_our_interior || (any_existing_wound_can_mangle_our_exterior && has_interior))

	var/wound_dismemberable = dismemberable_by_wound()
	var/ready_to_use_alternate_formula = (use_alternate_dismemberment_calc_even_if_mangleable || (!wound_dismemberable && !can_theoretically_be_dismembered_by_wound))

	if (ready_to_use_alternate_formula)
		var/percent_to_total_max = (get_damage() / max_damage)
		if (percent_to_total_max >= hp_percent_to_dismemberable)
			return TRUE

	return FALSE

/// Updates our "can be theoretically dismembered by wounds" variables by iterating through all wound static data.
/obj/item/bodypart/proc/update_wound_theory()
	// We put this here so we dont increase init time by doing this all at once on initialization
	// Effectively, we "lazy load"
	if (isnull(any_existing_wound_can_mangle_our_interior) || isnull(any_existing_wound_can_mangle_our_exterior))
		any_existing_wound_can_mangle_our_interior = FALSE
		any_existing_wound_can_mangle_our_exterior = FALSE
		for (var/datum/wound/wound_type as anything in SSwounds.pregen_data)
			var/datum/wound_pregen_data/pregen_data = SSwounds.pregen_data[wound_type]
			if (!pregen_data.can_be_applied_to(src, random_roll = TRUE)) // we only consider randoms because non-randoms are usually really specific
				continue
			if (initial(pregen_data.wound_path_to_generate.wound_flags) & MANGLES_EXTERIOR)
				any_existing_wound_can_mangle_our_exterior = TRUE
			if (initial(pregen_data.wound_path_to_generate.wound_flags) & MANGLES_INTERIOR)
				any_existing_wound_can_mangle_our_interior = TRUE

			if (any_existing_wound_can_mangle_our_interior && any_existing_wound_can_mangle_our_exterior)
				break

//Heals brute and burn damage for the organ. Returns 1 if the damage-icon states changed at all.
//Damage cannot go below zero, or min_damage.
//Cannot remove negative damage (i.e. apply damage)
/obj/item/bodypart/proc/heal_damage(brute, burn, stamina, required_status, updating_health = TRUE)
	if(required_status && !(bodytype & required_status)) //So we can only heal certain kinds of limbs, ie robotic vs organic.
		return
	if(brute)
		set_brute_dam(round(max(brute_dam - brute, wound_integrity_loss - burn_dam, 0), DAMAGE_PRECISION))
	if(burn)
		set_burn_dam(round(max(burn_dam - burn, wound_integrity_loss - brute_dam, 0), DAMAGE_PRECISION))
	if(stamina)
		set_stamina_dam(round(max(stamina_dam - stamina, 0), DAMAGE_PRECISION))
	if(owner)
		if(can_be_disabled)
			update_disabled()
		if(updating_health)
			owner.updatehealth()
		if(owner.dna?.species && (REVIVESBYHEALING in owner.dna.species.species_traits))
			if(owner.health > 0)
				owner.revive(FALSE)
				owner.cure_husk() // If it has REVIVESBYHEALING, it probably can't be cloned. No husk cure.
	cremation_progress = min(0, cremation_progress - ((brute_dam + burn_dam)*(100/max_damage)))
	return update_bodypart_damage_state()

///Proc to hook behavior associated to the change of the brute_dam variable's value.
/obj/item/bodypart/proc/set_brute_dam(new_value)
	if(brute_dam == new_value)
		return
	. = brute_dam
	brute_dam = new_value

///Proc to hook behavior associated to the change of the burn_dam variable's value.
/obj/item/bodypart/proc/set_burn_dam(new_value)
	if(burn_dam == new_value)
		return
	. = burn_dam
	burn_dam = new_value

///Proc to hook behavior associated to the change of the stamina_dam variable's value.
/obj/item/bodypart/proc/set_stamina_dam(new_value)
	if(stamina_dam == new_value)
		return
	. = stamina_dam
	stamina_dam = new_value

//Returns total damage.
/obj/item/bodypart/proc/get_damage(include_stamina = FALSE)
	var/total = brute_dam + burn_dam
	if(include_stamina)
		total = max(total, stamina_dam)
	return total

//Checks disabled status thresholds
/obj/item/bodypart/proc/update_disabled()
	if(!owner)
		return

	if(!can_be_disabled)
		set_disabled(FALSE)
		CRASH("update_disabled called with can_be_disabled false")
	if(HAS_TRAIT(src, TRAIT_PARALYSIS))
		set_disabled(TRUE)
		return

	var/total_damage = max(brute_dam + burn_dam, stamina_dam)

	// this block of checks is for limbs that can be disabled, but not through pure damage (AKA limbs that suffer wounds, human/monkey parts and such)
	if(!disable_threshold)
		if(total_damage < max_damage)
			last_maxed = FALSE
		else
			if(!last_maxed && owner.stat < UNCONSCIOUS)
				INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "scream")
			last_maxed = TRUE
		set_disabled(FALSE) // we only care about the paralysis trait
		return

	// we're now dealing solely with limbs that can be disabled through pure damage, AKA robot parts
	if(total_damage >= max_damage * disable_threshold)
		if(!last_maxed)
			if(owner.stat < UNCONSCIOUS && !HAS_TRAIT(owner, TRAIT_ANALGESIA))
				INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "scream")
			last_maxed = TRUE
		set_disabled(TRUE)
		return

	if(bodypart_disabled && total_damage <= max_damage * 0.5) // reenable the limb at 50% health
		last_maxed = FALSE
		set_disabled(FALSE)

///Proc to change the value of the `disabled` variable and react to the event of its change.
/obj/item/bodypart/proc/set_disabled(new_disabled)
	if(bodypart_disabled == new_disabled)
		return
	. = bodypart_disabled
	bodypart_disabled = new_disabled

	if(!owner)
		return
	owner.update_health_hud() //update the healthdoll
	owner.update_body()

///Proc to change the value of the `owner` variable and react to the event of its change.
/obj/item/bodypart/proc/set_owner(new_owner)
	if(owner == new_owner)
		return FALSE //`null` is a valid option, so we need to use a num var to make it clear no change was made.
	. = owner
	owner = new_owner

	var/needs_update_disabled = FALSE //Only really relevant if there's an owner
	if(.)
		var/mob/living/carbon/old_owner = .
		if(initial(can_be_disabled))
			if(HAS_TRAIT(old_owner, TRAIT_NOLIMBDISABLE))
				if(!owner || !HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
					set_can_be_disabled(initial(can_be_disabled))
					needs_update_disabled = TRUE
			UnregisterSignal(old_owner, list(
				SIGNAL_REMOVETRAIT(TRAIT_NOLIMBDISABLE),
				SIGNAL_ADDTRAIT(TRAIT_NOLIMBDISABLE),
				))

	if(owner)
		if(initial(can_be_disabled))
			if(HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
				set_can_be_disabled(FALSE)
				needs_update_disabled = FALSE
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_NOLIMBDISABLE), PROC_REF(on_owner_nolimbdisable_trait_loss))
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_NOLIMBDISABLE), PROC_REF(on_owner_nolimbdisable_trait_gain))
		if(needs_update_disabled)
			update_disabled()


///Proc to change the value of the `can_be_disabled` variable and react to the event of its change.
/obj/item/bodypart/proc/set_can_be_disabled(new_can_be_disabled)
	if(can_be_disabled == new_can_be_disabled)
		return
	. = can_be_disabled
	can_be_disabled = new_can_be_disabled

	if(can_be_disabled)
		if(owner)
			if(HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
				CRASH("set_can_be_disabled to TRUE with for limb whose owner has TRAIT_NOLIMBDISABLE")
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS), PROC_REF(on_paralysis_trait_gain))
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS), PROC_REF(on_paralysis_trait_loss))
		update_disabled()
	else if(.)
		if(owner)
			UnregisterSignal(owner, list(
				SIGNAL_ADDTRAIT(TRAIT_PARALYSIS),
				SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS),
				))
		set_disabled(FALSE)


///Called when TRAIT_PARALYSIS is added to the limb.
/obj/item/bodypart/proc/on_paralysis_trait_gain(obj/item/bodypart/source)
	SIGNAL_HANDLER
	if(can_be_disabled)
		set_disabled(TRUE)


///Called when TRAIT_PARALYSIS is removed from the limb.
/obj/item/bodypart/proc/on_paralysis_trait_loss(obj/item/bodypart/source)
	SIGNAL_HANDLER
	if(can_be_disabled)
		update_disabled()


///Called when TRAIT_NOLIMBDISABLE is added to the owner.
/obj/item/bodypart/proc/on_owner_nolimbdisable_trait_gain(mob/living/carbon/source)
	SIGNAL_HANDLER
	set_can_be_disabled(FALSE)


///Called when TRAIT_NOLIMBDISABLE is removed from the owner.
/obj/item/bodypart/proc/on_owner_nolimbdisable_trait_loss(mob/living/carbon/source)
	SIGNAL_HANDLER
	set_can_be_disabled(initial(can_be_disabled))

//Updates an organ's brute/burn states for use by update_ss()
//Returns 1 if we need to update overlays. 0 otherwise.
/obj/item/bodypart/proc/update_bodypart_damage_state()
	var/tbrute = min(round((brute_dam/max_damage)*6, 1), 3)
	var/tburn = min(round((burn_dam/max_damage)*6, 1), 3)
	if((tbrute != brutestate) || (tburn != burnstate))
		brutestate = tbrute
		burnstate = tburn
		return TRUE
	return FALSE

//Change limb between
//Note:This proc only exists because I can't be arsed to remove it yet. Theres no real reason this should ever be used.
//Don't look at me, I'm just half-assedly porting everything I see.
/obj/item/bodypart/proc/change_bodypart_status(new_limb_status, heal_limb, change_icon_to_default)
	if(!(bodytype & new_limb_status))
		bodytype &= ~(BODYTYPE_ROBOTIC & BODYTYPE_ORGANIC)
		bodytype |= new_limb_status
	else
		bodytype = bodytype & ~BODYTYPE_ORGANIC
		bodytype = bodytype | BODYTYPE_ROBOTIC

	if(heal_limb)
		burn_dam = 0
		brute_dam = 0
		brutestate = 0
		burnstate = 0

	if(change_icon_to_default)
		if(IS_ORGANIC_LIMB(src))
			icon = DEFAULT_BODYPART_ICON_ORGANIC
		else
			icon = DEFAULT_BODYPART_ICON_ROBOTIC

	if(owner)
		owner.updatehealth()
		owner.update_body() //if our head becomes robotic, we remove the lizard horns and human hair.
		owner.update_hair()
		owner.update_damage_overlays()

//we inform the bodypart of the changes that happened to the owner, or give it the informations from a source mob.
//set is_creating to true if you want to change the appearance of the limb outside of mutation changes or forced changes.
/obj/item/bodypart/proc/update_limb(dropping_limb, mob/living/carbon/source, is_creating = FALSE)
	var/mob/living/carbon/C
	if(source)
		C = source
		if(!original_owner)
			original_owner = source
	else
		C = owner
		if(original_owner && original_owner != owner) //Foreign limb
			no_update = TRUE
		else
			no_update = FALSE

	if(HAS_TRAIT(C, TRAIT_HUSK) && IS_ORGANIC_LIMB(src))
		//dmg_overlay_type = "" //no damage overlay shown when husked
		is_husked = TRUE
	else
		//dmg_overlay_type = initial(dmg_overlay_type)
		is_husked = FALSE

	if(!dropping_limb && C.dna?.check_mutation(HULK)) //Please remove hulk from the game. I beg you.
		mutation_color = "00aa00"
	else
		mutation_color = null

	if(mutation_color) //I hate mutations
		draw_color = mutation_color
	else if(should_draw_greyscale)
		draw_color = (species_color) || (skin_tone && skintone2hex(skin_tone))
	else
		draw_color = null

	if(C?.dna?.blood_type?.color)
		damage_color = C.dna.blood_type.color
	else
		damage_color = COLOR_BLOOD

	if(no_update)
		return

	if(!is_creating || !owner)
		return

	if(!animal_origin && ishuman(C))
		var/mob/living/carbon/human/H = C

		var/datum/species/S = H.dna.species
		species_flags_list = H.dna.species.species_traits //Literally only exists for a single use of NOBLOOD, but, no reason to remove it i guess...?
		limb_gender = (H.gender == MALE) ? "m" : "f"

		if(S.use_skintones)
			skin_tone = H.skin_tone
		else
			skin_tone = ""

		use_damage_color = S.use_damage_color
		if(((MUTCOLORS in S.species_traits) || (DYNCOLORS in S.species_traits)) && uses_mutcolor) //Ethereal code. Motherfuckers.
			if(S.fixed_mut_color)
				species_color = S.fixed_mut_color
			else
				species_color = H.dna.features["mcolor"]
		else
			species_color = null

		if(overlay_icon_state)
			species_secondary_color = H.dna.features["mcolor2"]

		UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

		draw_color = mutation_color
		if(should_draw_greyscale) //Should the limb be colored?
			draw_color ||= (species_color) || (skin_tone && skintone2hex(skin_tone))

		dmg_overlay_type = S.damage_overlay_type

	else if(animal_origin == MONKEY_BODYPART) //currently monkeys are the only non human mob to have damage overlays.
		dmg_overlay_type = animal_origin

	if(!IS_ORGANIC_LIMB(src))
		dmg_overlay_type = "robotic"

	if(dropping_limb)
		no_update = TRUE //when attached, the limb won't be affected by the appearance changes of its mob owner.

//to update the bodypart's icon when not attached to a mob
/obj/item/bodypart/proc/update_icon_dropped()
	cut_overlays()
	var/list/standing = get_limb_icon(1)
	if(!standing.len)
		icon_state = initial(icon_state)//no overlays found, we default back to initial icon.
		return
	for(var/image/I in standing)
		I.pixel_x = px_x
		I.pixel_y = px_y
	add_overlay(standing)

/obj/item/bodypart/proc/get_limb_icon(dropped)
	icon_state = "" //to erase the default sprite, we're building the visual aspects of the bodypart through overlays alone.

	. = list()

	//Handles dropped icons
	var/image_dir = NONE
	if(dropped)
		image_dir = SOUTH
		if(dmg_overlay_type)
			if(brutestate)
				var/image/bruteoverlay = image(dmg_overlay_icon, "[dmg_overlay_type]_[body_zone]_[brutestate]0", -DAMAGE_LAYER, image_dir)
				if(use_damage_color)
					bruteoverlay.color = damage_color
				. += bruteoverlay
			if(burnstate)
				. += image(dmg_overlay_icon, "[dmg_overlay_type]_[body_zone]_0[burnstate]", -DAMAGE_LAYER, image_dir)

	var/image/limb = image(layer = -BODYPARTS_LAYER, dir = image_dir)
	var/image/aux
	//. += limb

	if(animal_origin) //Cringe ass animal-specific code.
		if(IS_ORGANIC_LIMB(src))
			limb.icon = 'icons/mob/animal_parts.dmi'
			if(is_husked)
				limb.icon_state = "[animal_origin]_husk_[body_zone]"
			else
				limb.icon_state = "[animal_origin]_[body_zone]"
		else
			limb.icon = 'icons/mob/augmentation/augments.dmi'
			limb.icon_state = "[animal_origin]_[body_zone]"
		. += limb
		return

	if(is_husked)
		limb.icon = husk_icon
		limb.icon_state = "[husk_type]_husk_[body_zone]"
		. += limb
		if(aux_zone) //Hand shit
			aux = image(limb.icon, "[husk_type]_husk_[aux_zone]", -aux_layer, image_dir)
			. += aux
		return

	////This is the MEAT of limb icon code
	limb.icon = icon
	if(!should_draw_greyscale || !icon)
		limb.icon = static_icon

	limb.icon_state = "[limb_id]_[body_zone]"

	if(is_dimorphic) //Does this type of limb have sexual dimorphism?
		limb.icon_state += "_[limb_gender]"
	if(bodytype & BODYTYPE_DIGITIGRADE && !plantigrade_forced)
		limb.icon_state += "_digitigrade"

	if(!icon_exists(limb.icon, limb.icon_state))
		limb_stacktrace("Limb generated with nonexistant icon. File: [limb.icon] | State: [limb.icon_state]", GLOB.Debug) //If you *really* want more of these, you can set the *other* global debug flag manually.

	if(!is_husked)
		. += limb

		if(aux_zone) //Hand shit
			aux = image(limb.icon, "[limb_id]_[aux_zone]", -aux_layer, image_dir)
			. += aux
			if(overlay_icon_state)
				var/image/overlay = image(limb.icon, "[limb_id]_[aux_zone]_overlay", -aux_layer, image_dir)
				overlay.color = "#[species_secondary_color]"
				. += overlay

		draw_color = mutation_color
		if(should_draw_greyscale) //Should the limb be colored outside of a forced color?
			draw_color ||= (species_color) || (skin_tone && skintone2hex(skin_tone))

		if(draw_color)
			limb.color = "#[draw_color]"
			if(aux_zone)
				aux.color = "#[draw_color]"

		if(overlay_icon_state)
			var/image/overlay = image(limb.icon, "[limb.icon_state]_overlay", -BODY_ADJ_LAYER, image_dir)
			overlay.color = "#[species_secondary_color]"
			. += overlay

	//Ok so legs are a bit goofy in regards to layering, and we will need two images instead of one to fix that
	if((body_zone == BODY_ZONE_R_LEG) || (body_zone == BODY_ZONE_L_LEG))
		var/obj/item/bodypart/leg/leg_source = src
		for(var/image/limb_image in .)
			//remove the old, unmasked image
			. -= limb_image
			//add two masked images based on the old one
			. += leg_source.generate_masked_leg(limb_image, image_dir)

	/*if(!is_husked)
		//Draw external organs like horns and frills
		for(var/obj/item/organ/external/external_organ as anything in external_organs)
			if(!dropped && !external_organ.can_draw_on_bodypart(owner))
				continue
			//Some externals have multiple layers for background, foreground and between
			for(var/external_layer in external_organ.all_layers)
				if(external_organ.layers & external_layer)
					external_organ.generate_and_retrieve_overlays(
						.,
						image_dir,
						external_organ.bitflag_to_layer(external_layer),
						limb_gender,
					)*/

	stored_icon_state = limb.icon_state

	return

/obj/item/bodypart/deconstruct(disassembled = TRUE)
	drop_organs()
	qdel(src)

/// Should return an assoc list of (wound_series -> penalty). Will be used in determining series-specific penalties for wounding.
/obj/item/bodypart/proc/check_series_wounding_mods()
	RETURN_TYPE(/list)

	var/list/series_mods = list()

	for (var/datum/wound/iterated_wound as anything in wounds)
		var/datum/wound_pregen_data/pregen_data = SSwounds.pregen_data[iterated_wound.type]

		series_mods[pregen_data.wound_series] += iterated_wound.series_threshold_penalty

	return series_mods

/// Get whatever wound of the given type is currently attached to this limb, if any
/obj/item/bodypart/proc/get_wound_type(checking_type)
	if(isnull(wounds))
		return

	for(var/i in wounds)
		if(istype(i, checking_type))
			return i

/**
 * update_wounds() is called whenever a wound is gained or lost on this bodypart, as well as if there's a change of some kind on a bone wound possibly changing disabled status
 *
 * Covers tabulating the damage multipliers we have from wounds (burn specifically), as well as deleting our gauze wrapping if we don't have any wounds that can use bandaging
 *
 * Arguments:
 * * replaced- If true, this is being called from the remove_wound() of a wound that's being replaced, so the bandage that already existed is still relevant, but the new wound hasn't been added yet
 */
/obj/item/bodypart/proc/update_wounds(replaced = FALSE)
	var/dam_mul = 1 //initial(wound_damage_multiplier)
	var/integrity_mul = 0

	// we can (normally) only have one wound per type, but remember there's multiple types (smites like :B:loodless can generate multiple cuts on a limb)
	for(var/datum/wound/iter_wound as anything in wounds)
		dam_mul *= iter_wound.damage_mulitplier_penalty
		integrity_mul += iter_wound.limb_integrity_penalty

	wound_damage_multiplier = dam_mul
	wound_integrity_loss = min(max_damage, WOUND_MAX_INTEGRITY_CONSIDERED) * integrity_mul

/**
 * Calculates how much blood this limb is losing per life tick
 *
 * Arguments:
 * * ignore_modifiers - If TRUE, ignore the bleed reduction for laying down and grabbing your limb
 */
/obj/item/bodypart/proc/get_part_bleed_rate(ignore_modifiers = FALSE)
	if(HAS_TRAIT(owner, TRAIT_NOBLEED))
		return

	var/bleed_rate = 0
	if(generic_bleedstacks > 0)
		bleed_rate++

	//We want an accurate reading of .len
	listclearnulls(embedded_objects)
	for(var/obj/item/embeddies as anything in embedded_objects)
		if(!embeddies.isEmbedHarmless())
			bleed_rate += 0.25

	for(var/datum/wound/iter_wound as anything in wounds)
		// causes a gauzed wound to naturally bleed less as it clears up.
		bleed_rate += iter_wound.blood_flow

	if(!ignore_modifiers)
		if(owner.body_position == LYING_DOWN)
			bleed_rate *= 0.75
		if(grasped_by)
			bleed_rate *= 0.75
		if(current_gauze)
			bleed_rate *= current_gauze.bleed_suppress

	if(!bleed_rate)
		QDEL_NULL(grasped_by)

	return bleed_rate

// how much blood the limb needs to be losing per tick (not counting laying down/self grasping modifiers) to get the different bleed icons
#define BLEED_OVERLAY_LOW 0.5
#define BLEED_OVERLAY_MED 1.5
#define BLEED_OVERLAY_GUSH 3.25

/obj/item/bodypart/proc/update_part_wound_overlay() //todo SPECIES SUPPORT
	if(!owner)
		return FALSE
	if(HAS_TRAIT(owner, TRAIT_NOBLEED))
		if(bleed_overlay_icon)
			bleed_overlay_icon = null
			owner.update_wound_overlays()
		return FALSE

	var/bleed_rate = get_part_bleed_rate(ignore_modifiers = TRUE)
	var/new_bleed_icon = null

	switch(bleed_rate)
		if(-INFINITY to BLEED_OVERLAY_LOW)
			new_bleed_icon = null
		if(BLEED_OVERLAY_LOW to BLEED_OVERLAY_MED)
			new_bleed_icon = "[body_zone]_1"
		if(BLEED_OVERLAY_MED to BLEED_OVERLAY_GUSH)
			if(owner.body_position == LYING_DOWN || IS_IN_STASIS(owner) || owner.stat == DEAD)
				new_bleed_icon = "[body_zone]_2s"
			else
				new_bleed_icon = "[body_zone]_2"
		if(BLEED_OVERLAY_GUSH to INFINITY)
			if(IS_IN_STASIS(owner) || owner.stat == DEAD)
				new_bleed_icon = "[body_zone]_2s"
			else
				new_bleed_icon = "[body_zone]_3"

	if(new_bleed_icon != bleed_overlay_icon)
		bleed_overlay_icon = new_bleed_icon
		return TRUE

#undef BLEED_OVERLAY_LOW
#undef BLEED_OVERLAY_MED
#undef BLEED_OVERLAY_GUSH

/obj/item/bodypart/proc/can_bleed()
	SHOULD_BE_PURE(TRUE)

	return ((biological_state & BIO_BLOODED) && (!owner || !HAS_TRAIT(owner, TRAIT_NOBLOOD)))

/**
 * apply_gauze() is used to- well, apply gauze to a bodypart
 *
 * As of the Wounds 2 PR, all bleeding is now bodypart based rather than the old bleedstacks system, and 90% of standard bleeding comes from flesh wounds (the exception is embedded weapons).
 * The same way bleeding is totaled up by bodyparts, gauze now applies to all wounds on the same part. Thus, having a slash wound, a pierce wound, and a broken bone wound would have the gauze
 * applying blood staunching to the first two wounds, while also acting as a sling for the third one. Once enough blood has been absorbed or all wounds with the ACCEPTS_GAUZE flag have been cleared,
 * the gauze falls off.
 *
 * Arguments:
 * * new_gauze- Just the gauze stack we're taking a sheet from to apply here
 */
/obj/item/bodypart/proc/apply_gauze(obj/item/stack/medical/gauze/new_gauze)
	if(!istype(new_gauze) || current_gauze)
		return
	current_gauze = new new_gauze.gauze_type(src)
	new_gauze.use(1)

/**
 * apply_splint() much like above, except with a splint
 *
 * * This proc applies a splint to a bodypart. Splints are used to stabilize muscle and bone wounds, aswell as to protect from hits causing internal bleeding
 *
 * Arguments:
 * * new_splint- Just the gauze stack we're taking a sheet from to apply here
 */
/obj/item/bodypart/proc/apply_splint(obj/item/stack/medical/splint/new_splint)
	if(!istype(new_splint) || current_splint)
		return
	current_splint = new new_splint.splint_type(src)
	new_splint.use(1)

/* NOTE: it makes absolutely NO sense for wires to be "external," it should likely be renamed to hard/soft materials but i'm too lazy to do that right now */

/// Returns the generic description of our BIO_EXTERNAL feature(s), prioritizing certain ones over others. Returns error on failure.
/obj/item/bodypart/proc/get_external_description()
	if (biological_state & BIO_FLESH)
		return "flesh"
	if (biological_state & BIO_WIRED)
		return "wiring"

	return "error"

/// Returns the generic description of our BIO_INTERNAL feature(s), prioritizing certain ones over others. Returns error on failure.
/obj/item/bodypart/proc/get_internal_description()
	if (biological_state & BIO_BONE)
		return "bone"
	if (biological_state & BIO_METAL)
		return "metal"

	return "error"
