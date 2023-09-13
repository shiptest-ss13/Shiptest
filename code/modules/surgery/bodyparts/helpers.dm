/mob/living/proc/get_bodypart(zone)
	return

/mob/living/carbon/get_bodypart(zone)
	if(!zone)
		zone = BODY_ZONE_CHEST
	for(var/obj/item/bodypart/L as anything in bodyparts)
		if(L.body_zone == zone)
			return L


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
	return list()

/mob/living/carbon/get_missing_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	for(var/zone in full)
		if(get_bodypart(zone))
			full -= zone
	return full

/mob/living/carbon/alien/larva/get_missing_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	for(var/zone in full)
		if(get_bodypart(zone))
			full -= zone
	return full

/mob/living/proc/get_disabled_limbs()
	return list()

/mob/living/carbon/get_disabled_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	var/list/disabled = list()
	for(var/zone in full)
		var/obj/item/bodypart/affecting = get_bodypart(zone)
		if(affecting?.bodypart_disabled)
			disabled += zone
	return disabled

/mob/living/carbon/alien/larva/get_disabled_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	var/list/disabled = list()
	for(var/zone in full)
		var/obj/item/bodypart/affecting = get_bodypart(zone)
		if(affecting?.bodypart_disabled)
			disabled += zone
	return disabled

/mob/proc/get_broken_limbs()
	return 0

///Gets a list of broken bodyparts
/mob/living/carbon/get_broken_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	var/list/broken = list()
	for(var/zone in full)
		var/obj/item/bodypart/affecting = get_bodypart(zone)
		if(affecting && affecting.bone_status == BONE_FLAG_BROKEN)
			broken += zone
	return broken

///Gets how many legs are broken (of the two possible.) Used for slowdown calculation.
/mob/proc/get_broken_legs()
	return 0

/mob/living/carbon/get_broken_legs()
	var/brokenlegs = 0
	for(var/obj/item/bodypart/X in bodyparts)
		if(X && X.bone_status == BONE_FLAG_BROKEN || X.bone_status == BONE_FLAG_SPLINTED)
			if(X.body_part == LEG_RIGHT || X.body_part == LEG_LEFT)
				brokenlegs++
	return brokenlegs

///Remove a specific embedded item from the carbon mob
/mob/living/carbon/proc/remove_embedded_object(obj/item/I)
	SEND_SIGNAL(src, COMSIG_CARBON_EMBED_REMOVAL, I)

///Remove all embedded objects from all limbs on the carbon mob
/mob/living/carbon/proc/remove_all_embedded_objects()
	for(var/obj/item/bodypart/L as anything in bodyparts)
		for(var/obj/item/I in L.embedded_objects)
			remove_embedded_object(I)

/mob/living/carbon/proc/has_embedded_objects(include_harmless=FALSE)
	for(var/obj/item/bodypart/L as anything in bodyparts)
		for(var/obj/item/I in L.embedded_objects)
			if(!include_harmless && I.isEmbedHarmless())
				continue
			return TRUE

//Helper for quickly creating a new limb - used by augment code in species.dm spec_attacked_by
//
// FUCK YOU AUGMENT CODE - With love, Kapu
//Hi Kapu
// this code was perfectly fine kapu
/mob/living/carbon/proc/new_body_part(zone, robotic, fixed_icon, datum/species/species)
	species ||= dna.species
	var/obj/item/bodypart/L
	switch(zone)
		if(BODY_ZONE_L_ARM)
			L = robotic ? new species.species_robotic_l_arm() : new species.species_l_arm()
		if(BODY_ZONE_R_ARM)
			L = robotic ? new species.species_robotic_r_arm() : new species.species_r_arm()
		if(BODY_ZONE_HEAD)
			L = robotic ? new species.species_robotic_head() : new species.species_head()
		if(BODY_ZONE_L_LEG)
			if(species.is_digitigrade(src))
				L = robotic ? new species.species_robotic_digi_l_leg() : new species.species_digi_l_leg()
			else
				L = robotic ? new species.species_robotic_l_leg() : new species.species_l_leg()
		if(BODY_ZONE_R_LEG)
			if(species.is_digitigrade(src))
				L = robotic ? new species.species_robotic_digi_r_leg() : new species.species_digi_r_leg()
			else
				L = robotic ? new species.species_robotic_r_leg() : new species.species_r_leg()
		if(BODY_ZONE_CHEST)
			L = robotic ? new species.species_robotic_chest() : new species.species_chest()
	. = L

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

