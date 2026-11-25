// MAMMOTH BERSERK MARTIAL ART //
/datum/martial_art/berserk
	name = "Berserk!"
	id = MARTIALART_BERSERK

// HARM - Punch for MASSIVELY increased damage
/datum/martial_art/berserk/harm_act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/choice = rand(1, 4)
	var/static/hit_verbs = list("slam", "smash", "pulverize", "crush")
	var/static/hit_verbs_past = list("slammed", "smashed", "pulverized", "crushed")
	if(!can_use(user))
		return FALSE
	log_combat(user, target, "attacked (berserk)")
	user.do_attack_animation(target, ATTACK_EFFECT_PUNCH)
	playsound(get_turf(user), 'sound/weapons/melee/slam.ogg', 50, TRUE, -1)
	target.visible_message(
		span_danger("[user] [hit_verbs_past[choice]] [target]!"),
		span_userdanger("You're [hit_verbs_past[choice]] by [user]!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE, user)
	to_chat(user, span_danger("You [hit_verbs[choice]] [target]!"))

	var/obj/item/bodypart/limb = target.get_bodypart(target.run_zone(user.zone_selected))
	var/limb_armor = target.run_armor_check(limb, "melee")
	target.apply_damage(rand(20, 30), BRUTE, limb, limb_armor)

	return TRUE

// GRAB - Instantly obtain aggressive grabs, a la CQC
/datum/martial_art/berserk/grab_act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target && can_use(user)) // no grabbing yourself
		var/old_grab_state = user.grab_state
		target.grabbedby(user, 1)
		if(old_grab_state == GRAB_PASSIVE)
			target.visible_message(
				span_warning("[user] violently grabs [target]!"),
				span_userdanger("You're grabbed violently by [user]!"),
				span_hear("You hear aggressive shuffling!"),
				COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_danger("You violently grab [target]!"))

			log_combat(user, target, "grabbed", addition = "aggressively")

			// grisp
			target.drop_all_held_items()
			user.setGrabState(GRAB_AGGRESSIVE)
			playsound(target, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)

			return TRUE
	else
		return FALSE

// DISARM - Tear off limbs of people we are grabbing. Get it. Becau
/datum/martial_art/berserk/disarm_act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.grab_state >= GRAB_AGGRESSIVE && user.pulling == target)
		var/rip_time = 3 SECONDS // how long it takes to rip a limb off

		// first, some checks
		if(user.zone_selected == BODY_ZONE_CHEST)
			return FALSE // no disemboweling, sorry
		if(user.zone_selected == BODY_ZONE_HEAD)
			rip_time = 5 SECONDS // head ripping takes longer

		// make sure we have a limb...
		var/obj/item/bodypart/limb = target.get_bodypart(user.zone_selected)
		var/limb_wording = parse_zone(user.zone_selected)

		if(!limb) // no limb? no dismember
			to_chat(user, span_danger("There is no limb here to tear off!"))
			return TRUE

		if(!limb.can_dismember()) // make sure it's dismemberable
			to_chat(user, span_danger("Despite your strength, there's no way you're ripping this off!"))
			return TRUE

		// begin tearing
		target.visible_message(
			span_warning("[user] starts to tear off [target]'s [limb_wording]!"),
			span_userdanger("[user] is trying to tear your [limb_wording] off!"),
			span_hear("You hear grappling!"),
			COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_danger("You start to tear [target]'s [limb_wording] off..."))

		log_combat(user, target, "attempted to tear off", addition = limb_wording)

		if(!do_after(user, rip_time, target = target))
			return TRUE

		// tear off the limb
		if(!limb) // ...if it still exists, of course
			to_chat(user, span_danger("The limb you were trying to tear off is no longer there!"))
			return TRUE

		if(!limb.can_dismember()) // ...and it's still dismemberable
			to_chat(user, span_danger("You pull on [limb_wording] but it refuses to come off!"))
			return TRUE

		if(!target || !(user.grab_state >= GRAB_AGGRESSIVE) || !(user.pulling == target)) // ...and we still have our grab
			to_chat(user, span_danger("You fail to keep your grip on [target]!"))
			return TRUE

		target.visible_message(
			span_warning("[user] tears off [target]'s [limb_wording]!"),
			span_userdanger("Your [limb_wording] is torn off by [user]!"),
			span_hear("You hear a gruesome tearing sound!"),
			COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_danger("You tear [target]'s [limb_wording] off!"))

		log_combat(user, target, "tore off", addition = limb_wording)

		limb.dismember(BRUTE)

		return TRUE
	else
		return FALSE
