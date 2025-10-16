/mob/living/proc/get_bodypart(zone)
	return

/// Returns a bodypart occupying a specific zone. If using a precise zone and no such part is present, it falls back to a non-precise zone.
/mob/living/carbon/get_bodypart(zone, simplify = FALSE)
	if(!zone)
		zone = BODY_ZONE_CHEST
	var/returned_part = bodyparts[zone]
	if(!returned_part)
		returned_part = bodyparts[check_zone(zone)]
	return returned_part

/// Returns all bodyparts that exist on the mob.
/mob/living/proc/get_all_bodyparts()
	return

// Try not to use this too much, it's more expensive than doing it directly when iterating
/mob/living/carbon/get_all_bodyparts()
	var/list/all_parts = list()
	var/obj/item/bodypart/limb
	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		if(!limb)
			continue
		all_parts += limb
	return all_parts

/// Returns a random available bodypart.
/mob/living/proc/get_random_bodypart()
	return

/mob/living/carbon/get_random_bodypart()
	var/list/all_parts = list()
	var/obj/item/bodypart/limb
	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		if(!limb)
			continue
		all_parts += limb
	return pick(all_parts)

/// Returns the number of bodyparts.
/mob/living/proc/get_bodypart_count()
	return

/mob/living/carbon/get_bodypart_count()
	var/list/all_parts = list()
	var/obj/item/bodypart/limb
	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		if(!limb)
			continue
		all_parts += limb
	return all_parts.len

/mob/living/carbon/has_hand_for_held_index(i)
	if(!i)
		return FALSE
	var/obj/item/bodypart/hand_instance = hand_bodyparts[i]
	if(hand_instance && !hand_instance.bodypart_disabled)
		return hand_instance
	return FALSE


///Get the bodypart for whatever hand we have active, Only relevant for carbons
/mob/proc/get_active_hand()
	return FALSE

/mob/living/carbon/get_active_hand()
	var/which_hand = BODY_ZONE_PRECISE_L_HAND
	if(!(active_hand_index % 2))
		which_hand = BODY_ZONE_PRECISE_R_HAND
	return get_bodypart(check_zone(which_hand))


/mob/proc/has_left_hand(check_disabled = TRUE)
	return TRUE


/mob/living/carbon/has_left_hand(check_disabled = TRUE)
	for(var/obj/item/bodypart/hand_instance in hand_bodyparts)
		if(!(hand_instance.held_index % 2) || (check_disabled && hand_instance.bodypart_disabled))
			continue
		return TRUE
	return FALSE


/mob/living/carbon/alien/larva/has_left_hand()
	return 1


/mob/proc/has_right_hand(check_disabled = TRUE)
	return TRUE


/mob/living/carbon/has_right_hand(check_disabled = TRUE)
	for(var/obj/item/bodypart/hand_instance in hand_bodyparts)
		if(hand_instance.held_index % 2 || (check_disabled && hand_instance.bodypart_disabled))
			continue
		return TRUE
	return FALSE


/mob/living/carbon/alien/larva/has_right_hand()
	return 1


/mob/living/proc/get_missing_limbs()
	RETURN_TYPE(/list)
	return list()

/mob/living/carbon/get_missing_limbs()
	var/list/missing_limbs = list()
	for(var/zone in bodyparts)
		if(!bodyparts[zone])
			missing_limbs += zone
	return missing_limbs

/mob/living/proc/get_disabled_limbs()
	return list()

/mob/living/carbon/get_disabled_limbs()
	var/list/disabled = list()
	var/obj/item/bodypart/affecting
	for(var/zone in bodyparts)
		affecting = bodyparts[zone]
		if(affecting?.bodypart_disabled)
			disabled += zone
	return disabled

///Remove a specific embedded item from the carbon mob
/mob/living/carbon/proc/remove_embedded_object(obj/item/I)
	SEND_SIGNAL(src, COMSIG_CARBON_EMBED_REMOVAL, I)

///Remove all embedded objects from all limbs on the carbon mob
/mob/living/carbon/proc/remove_all_embedded_objects()
	var/obj/item/bodypart/body_part
	for(var/zone in bodyparts)
		body_part = bodyparts[zone]
		if(!body_part)
			continue
		for(var/obj/item/I in body_part.embedded_objects)
			remove_embedded_object(I)

/mob/living/carbon/proc/has_embedded_objects(include_harmless=FALSE)
	var/obj/item/bodypart/body_part
	for(var/zone in bodyparts)
		body_part = bodyparts[zone]
		if(!body_part)
			continue
		for(var/obj/item/I in body_part.embedded_objects)
			if(!include_harmless && I.isEmbedHarmless())
				continue
			return TRUE

//Helper for quickly creating a new limb - used by augment code in species.dm spec_attacked_by
//
// FUCK YOU AUGMENT CODE - With love, Kapu
//Hi Kapu
// this code was perfectly fine kapu
// No it's wasnt, but now it is. -sarah
/mob/living/carbon/proc/new_body_part(zone, robotic, fixed_icon, datum/species/species)
	species ||= dna.species
	var/bodypart_type = robotic ? species.species_robotic_limbs[zone] : species.species_limbs[zone]
	if(!bodypart_type)
		return null
	return new bodypart_type()

/mob/living/carbon/monkey/new_body_part(zone, robotic, fixed_icon, datum/species/species)
	var/obj/item/bodypart/L
	switch(zone)
		if(BODY_ZONE_L_ARM)
			L = new /obj/item/bodypart/l_arm/monkey()
		if(BODY_ZONE_R_ARM)
			L = new /obj/item/bodypart/r_arm/monkey()
		if(BODY_ZONE_HEAD)
			L = new /obj/item/bodypart/head/monkey()
		if(BODY_ZONE_L_LEG)
			L = new /obj/item/bodypart/leg/left/monkey()
		if(BODY_ZONE_R_LEG)
			L = new /obj/item/bodypart/leg/right/monkey()
		if(BODY_ZONE_CHEST)
			L = new /obj/item/bodypart/chest/monkey()
	if(L)
		L.update_limb(fixed_icon, src)
		if(robotic)
			L.change_bodypart_status(BODYTYPE_ROBOTIC)
	. = L

/mob/living/carbon/alien/larva/new_body_part(zone, robotic, fixed_icon, datum/species/species)
	var/obj/item/bodypart/L
	switch(zone)
		if(BODY_ZONE_HEAD)
			L = new /obj/item/bodypart/head/larva()
		if(BODY_ZONE_CHEST)
			L = new /obj/item/bodypart/chest/larva()
	if(L)
		L.update_limb(fixed_icon, src)
		if(robotic)
			L.change_bodypart_status(BODYTYPE_ROBOTIC)
	. = L

/mob/living/carbon/alien/humanoid/new_body_part(zone, robotic, fixed_icon, datum/species/species)
	var/obj/item/bodypart/L
	switch(zone)
		if(BODY_ZONE_L_ARM)
			L = new /obj/item/bodypart/l_arm/alien()
		if(BODY_ZONE_R_ARM)
			L = new /obj/item/bodypart/r_arm/alien()
		if(BODY_ZONE_HEAD)
			L = new /obj/item/bodypart/head/alien()
		if(BODY_ZONE_L_LEG)
			L = new /obj/item/bodypart/leg/left/alien()
		if(BODY_ZONE_R_LEG)
			L = new /obj/item/bodypart/leg/right/alien()
		if(BODY_ZONE_CHEST)
			L = new /obj/item/bodypart/chest/alien()
	if(L)
		L.update_limb(fixed_icon, src)
		if(robotic)
			L.change_bodypart_status(BODYTYPE_ROBOTIC)
	. = L


/proc/skintone2hex(skin_tone)
	. = 0
	switch(skin_tone)
		if("caucasian1")
			. = "ffe0d1"
		if("caucasian2")
			. = "fcccb3"
		if("caucasian3")
			. = "e8b59b"
		if("latino")
			. = "d9ae96"
		if("mediterranean")
			. = "c79b8b"
		if("asian1")
			. = "ffdeb3"
		if("asian2")
			. = "e3ba84"
		if("arab")
			. = "c4915e"
		if("indian")
			. = "b87840"
		if("african1")
			. = "754523"
		if("african2")
			. = "471c18"
		if("albino")
			. = "fff4e6"
		if("orange")
			. = "ffc905"

