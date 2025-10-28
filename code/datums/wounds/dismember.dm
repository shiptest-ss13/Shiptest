/datum/wound/loss
	name = "Dismemberment Wound"
	desc = "Tis but a flesh wound."

	sound_effect = 'sound/effects/wounds/dismember.ogg'
	severity = WOUND_SEVERITY_LOSS
	threshold_minimum = WOUND_DISMEMBER_OUTRIGHT_THRESH // not actually used since dismembering is handled differently, but may as well assign it since we got it
	status_effect_type = null
	wound_flags = null

/// Our special proc for our special dismembering, the wounding type only matters for what text we have
/datum/wound/loss/proc/apply_dismember(obj/item/bodypart/dismembered_part, wounding_type = WOUND_SLASH, outright = FALSE, attack_direction)
	if(!istype(dismembered_part) || !dismembered_part.owner || !(dismembered_part.body_zone in viable_zones) || isalien(dismembered_part.owner) || !dismembered_part.can_dismember())
		qdel(src)
		return

	victim = dismembered_part.owner

	if(dismembered_part.body_zone == BODY_ZONE_CHEST)
		occur_text = "is split open, causing [victim.p_their()] internals organs to spill out!"
	else if(outright)
		switch(wounding_type)
			if(WOUND_BLUNT)
				occur_text = "is outright smashed to a gross pulp, severing it completely!"
			if(WOUND_SLASH)
				occur_text = "is outright slashed off, severing it completely!"
			if(WOUND_PIERCE)
				occur_text = "is outright blasted apart, severing it completely!"
			if(WOUND_BURN)
				occur_text = "is outright incinerated, falling to dust!"
	else
		switch(wounding_type)
			if(WOUND_BLUNT)
				occur_text = "is shattered through the last bone holding it together, severing it completely!"
			if(WOUND_SLASH)
				occur_text = "is slashed through the last tissue holding it together, severing it completely!"
			if(WOUND_PIERCE)
				occur_text = "is pierced through the last tissue holding it together, severing it completely!"
			if(WOUND_BURN)
				occur_text = "is completely incinerated, falling to dust!"

	var/msg = span_bolddanger("[victim]'s [dismembered_part.name] [occur_text]!")

	victim.visible_message(msg, span_userdanger("Your [dismembered_part.name] [occur_text]!"))

	set_limb(dismembered_part)
	second_wind()
	log_wound(victim, src)
	if(wounding_type != WOUND_BURN && victim.blood_volume)
		victim.spray_blood(attack_direction, severity)
	dismembered_part.dismember(wounding_type == WOUND_BURN ? BURN : BRUTE)
	qdel(src)
	return TRUE
