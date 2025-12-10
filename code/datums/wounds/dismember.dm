/datum/wound_pregen_data/loss
	abstract = FALSE

	wound_path_to_generate = /datum/wound/loss
	required_limb_biostate = NONE
	require_any_biostate = TRUE

	required_wounding_types = list(WOUND_ALL)

	wound_series = WOUND_SERIES_LOSS_BASIC

	threshold_minimum = WOUND_DISMEMBER_OUTRIGHT_THRESH // not actually used since dismembering is handled differently, but may as well assign it since we got it

/datum/wound/loss
	name = "Dismemberment Wound"
	desc = "Tis but a flesh wound."

	sound_effect = 'sound/effects/wounds/dismember.ogg'
	severity = WOUND_SEVERITY_LOSS
	status_effect_type = null
	wound_flags = null

	/// The wounding_type of the attack that caused us. Used to generate the description of our scar. Currently unused, but primarily exists in case non-biological wounds are added.
	var/loss_wounding_type

/// Our special proc for our special dismembering, the wounding type only matters for what text we have
/datum/wound/loss/proc/apply_dismember(obj/item/bodypart/dismembered_part, wounding_type = WOUND_SLASH, outright = FALSE, attack_direction)
	if(!istype(dismembered_part) || !dismembered_part.owner || (dismembered_part.body_zone in get_excluded_zones()) || isalien(dismembered_part.owner) || !dismembered_part.can_dismember())
		qdel(src)
		return

	victim = dismembered_part.owner

	if(dismembered_part.body_zone == BODY_ZONE_CHEST)
		occur_text = "is split open, causing [victim.p_their()] internals organs to spill out!"
	else
		occur_text = dismembered_part.get_dismember_message(wounding_type, outright)

	var/msg = span_bolddanger("[victim]'s [dismembered_part.name] [occur_text]!")

	victim.visible_message(msg, span_userdanger("Your [dismembered_part.name] [occur_text]!"))

	loss_wounding_type = wounding_type

	set_limb(dismembered_part)
	second_wind()
	log_wound(victim, src)
	if(dismembered_part.can_bleed() && wounding_type != WOUND_BURN && victim.blood_volume)
		victim.spray_blood(attack_direction, severity)
	dismembered_part.dismember(dam_type = (wounding_type == WOUND_BURN ? BURN : BRUTE))
	qdel(src)
	return TRUE

/obj/item/bodypart/proc/get_dismember_message(wounding_type, outright)
	var/occur_text

	if(outright)
		switch(wounding_type)
			if(WOUND_BLUNT)
				occur_text = "is outright smashed to [(biological_state & BIO_METAL) ? "pieces" : "a gross pulp"], severing it completely!"
			if(WOUND_SLASH)
				occur_text = "is outright slashed off, severing it completely!"
			if(WOUND_PIERCE)
				occur_text = "is outright blasted apart, severing it completely!"
			if(WOUND_BURN)
				occur_text = "is outright incinerated, falling to dust!"
	else
		var/bone_text = get_internal_description()
		var/tissue_text = get_external_description()

		switch(wounding_type)
			if(WOUND_BLUNT)
				occur_text = "is shattered through the last [bone_text] holding it together, severing it completely!"
			if(WOUND_SLASH)
				occur_text = "is slashed through the last [tissue_text] holding it together, severing it completely!"
			if(WOUND_PIERCE)
				occur_text = "is pierced through the last [tissue_text] holding it together, severing it completely!"
			if(WOUND_BURN)
				occur_text = "is completely incinerated, [(biological_state & BIO_METAL) ? "melting to slag" : "falling to dust"]!"

	return occur_text
