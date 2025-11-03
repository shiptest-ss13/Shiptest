
/mob/living/proc/run_armor_check(
		def_zone = null, attack_flag = "melee", armour_penetration = 0,
		absorb_text = null, soften_text = null, penetrated_text = null, silent = FALSE
	)
	var/base_armor = getarmor(def_zone, attack_flag)
	// if negative or 0 armor, no modifications are necessary
	if(base_armor <= 0)
		return base_armor

	var/armor
	if(armour_penetration >= 0)
		armor = max(0, base_armor - armour_penetration)
	else
		// negative armor penetration increases the effect of armor
		// armour penetration of -100 or lower would either divide by zero or give neg. armor (bad)
		armor = armour_penetration > -100 ? base_armor * (100 / (100 + armour_penetration)) : 100

	if(silent)
		return armor

	if(armor >= 100)
		to_chat(src, span_notice("[absorb_text || "Your armor absorbs the blow!"]"))
	else if(armour_penetration <= 0)
		// armor has to be > 0 due to early return, and no armor pen, so blow was softened
		to_chat(src, span_warning("[soften_text || "Your armor softens the blow!"]"))
	else
		// historic present
		to_chat(src, span_userdanger("[penetrated_text || "Your armor is penetrated!"]"))
	return armor

/mob/living/proc/getarmor(def_zone, type)
	return 0

//this returns the mob's protection against eye damage (number between -1 and 2) from bright lights
/mob/living/proc/get_eye_protection()
	return 0

//this returns the mob's protection against ear damage (0:no protection; 1: some ear protection; 2: has no ears)
/mob/living/proc/get_ear_protection()
	return 0

/mob/living/proc/is_mouth_covered(head_only = 0, mask_only = 0)
	return FALSE

/mob/living/proc/is_eyes_covered(check_glasses = 1, check_head = 1, check_mask = 1)
	return FALSE
/mob/living/proc/is_pepper_proof(check_head = TRUE, check_mask = TRUE)
	return FALSE
/mob/living/proc/on_hit(obj/projectile/P)
	return BULLET_ACT_HIT

/mob/living/bullet_act(obj/projectile/P, def_zone, piercing_hit = FALSE)
	if(check_concealment(P))
		return BULLET_ACT_FORCE_PIERCE
	var/armor = run_armor_check(def_zone, P.flag, P.armour_penetration, silent = TRUE)
	var/on_hit_state = P.on_hit(src, armor, piercing_hit)
	if(!P.nodamage && on_hit_state != BULLET_ACT_BLOCK && !QDELETED(src)) //QDELETED literally just for the instagib rifle. Yeah.
		var/attack_direction = get_dir(P.starting, src)
		apply_damage(P.damage, P.damage_type, def_zone, armor, wound_bonus=P.wound_bonus, bare_wound_bonus=P.bare_wound_bonus, sharpness = P.sharpness, attack_direction = attack_direction)
		apply_effects(P.stun, P.knockdown, P.unconscious, P.irradiate, P.slur, P.stutter, P.eyeblur, P.drowsy, armor, P.stamina, P.jitter, P.paralyze, P.immobilize)
		if(P.dismemberment)
			check_projectile_dismemberment(P, def_zone)
	return on_hit_state ? BULLET_ACT_HIT : BULLET_ACT_BLOCK

/mob/living/proc/check_concealment(obj/projectile/P)
	var/datum/status_effect/concealed/concealment = has_status_effect(/datum/status_effect/concealed)
	if(P.ignore_concealment)
		return FALSE
	if(concealment)
		var/dist = get_dist(P, P.starting)
		if(dist <= 1)
			return FALSE // point blank, we get hit
		else
			var/dist_modifier = max((4 - dist), 1)
			if(prob((concealment.concealment_power/dist_modifier)))
				return TRUE // we are concealed and the bullet misses
	return FALSE

/mob/living/proc/check_projectile_dismemberment(obj/projectile/P, def_zone)
	return 0

/obj/item/proc/get_volume_by_throwforce_and_or_w_class()
		if(throwforce && w_class)
				return clamp((throwforce + w_class) * 5, 30, 100)// Add the item's throwforce to its weight class and multiply by 5, then clamp the value between 30 and 100
		else if(w_class)
				return clamp(w_class * 8, 20, 100) // Multiply the item's weight class by 8, then clamp the value between 20 and 100
		else
				return 0

/mob/living/hitby(atom/movable/AM, skipcatch, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	if(istype(AM, /obj/item))
		var/obj/item/I = AM
		var/zone = ran_zone(BODY_ZONE_CHEST, 65)//Hits a random part of the body, geared towards the chest
		var/dtype = BRUTE
		var/nosell_hit = SEND_SIGNAL(I, COMSIG_MOVABLE_IMPACT_ZONE, src, zone, throwingdatum) // TODO: find a better way to handle hitpush and skipcatch for humans
		if(nosell_hit)
			skipcatch = TRUE
			hitpush = FALSE

		dtype = I.damtype
		if(!blocked)
			if(I.thrownby)
				log_combat(I.thrownby, src, "threw and hit", I)
			if(!nosell_hit)
				visible_message(
					span_danger("[src] is hit by [I]!"),
					span_userdanger("You're hit by [I]!"),
				)
				if(!I.throwforce)
					return
				var/armor = run_armor_check(zone, "melee", I.armour_penetration, "Your armor has protected your [parse_zone(zone)].", "Your armor has softened hit to your [parse_zone(zone)].")
				apply_damage(I.throwforce, dtype, zone, armor, sharpness=I.get_sharpness(), wound_bonus=(nosell_hit * CANT_WOUND))
		else
			return TRUE
	else
		playsound(loc, 'sound/weapons/genhit.ogg', 50, TRUE, -1) //Item sounds are handled in the item itself

	if(body_position == LYING_DOWN) // physics says it's significantly harder to push someone by constantly chucking random furniture at them if they are down on the floor.
		hitpush = FALSE
	..()



/mob/living/mech_melee_attack(obj/mecha/M)
	if(M.occupant.a_intent == INTENT_HARM)
		if(HAS_TRAIT(M.occupant, TRAIT_PACIFISM))
			to_chat(M.occupant, span_warning("You don't want to harm other living beings!"))
			return
		M.do_attack_animation(src)
		if(M.damtype == "brute")
			step_away(src,M,15)
		switch(M.damtype)
			if(BRUTE)
				Unconscious(20)
				take_overall_damage(rand(M.force/2, M.force))
				playsound(src, 'sound/weapons/punch4.ogg', 50, TRUE)
			if(BURN)
				take_overall_damage(0, rand(M.force/2, M.force))
				playsound(src, 'sound/items/welder.ogg', 50, TRUE)
			if(TOX)
				M.mech_toxin_damage(src)
			else
				return
		updatehealth()
		visible_message(span_danger("[M.name] hits [src]!"), \
						span_userdanger("[M.name] hits you!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
		to_chat(M, span_danger("You hit [src]!"))
		log_combat(M.occupant, src, "attacked", M, "(INTENT: [uppertext(M.occupant.a_intent)]) (DAMTYPE: [uppertext(M.damtype)])")
	else
		step_away(src,M)
		log_combat(M.occupant, src, "pushed", M)
		visible_message(span_warning("[M] pushes [src] out of the way."), \
						span_warning("[M] pushes you out of the way."), span_hear("You hear aggressive shuffling!"), 5, M)
		to_chat(M, span_danger("You push [src] out of the way."))

/mob/living/fire_act()
	adjust_fire_stacks(3)
	IgniteMob()

/mob/living/proc/grabbedby(mob/living/carbon/user, supress_message = FALSE)
	if(user == src || anchored || !isturf(user.loc))
		return FALSE
	if(!user.pulling || user.pulling != src)
		user.start_pulling(src, supress_message = supress_message)
		return

	if(!(status_flags & CANPUSH) || HAS_TRAIT(src, TRAIT_PUSHIMMUNE))
		to_chat(user, span_warning("[src] can't be grabbed more aggressively!"))
		return FALSE

	if(user.grab_state >= GRAB_AGGRESSIVE && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You don't want to risk hurting [src]!"))
		return FALSE
	grippedby(user)

//proc to upgrade a simple pull into a more aggressive grab.
/mob/living/proc/grippedby(mob/living/carbon/user, instant = FALSE)
	if(user.grab_state < GRAB_KILL)
		user.changeNext_move(CLICK_CD_GRABBING)
		var/sound_to_play = 'sound/weapons/thudswoosh.ogg'
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.dna.species.grab_sound)
				sound_to_play = H.dna.species.grab_sound
		playsound(src.loc, sound_to_play, 50, TRUE, -1)

		if(user.grab_state) //only the first upgrade is instantaneous
			var/old_grab_state = user.grab_state
			var/grab_upgrade_time = instant ? 0 : 30
			visible_message(span_danger("[user] starts to tighten [user.p_their()] grip on [src]!"), \
							span_userdanger("[user] starts to tighten [user.p_their()] grip on you!"), span_hear("You hear aggressive shuffling!"), null, user)
			to_chat(user, span_danger("You start to tighten your grip on [src]!"))
			switch(user.grab_state)
				if(GRAB_AGGRESSIVE)
					log_combat(user, src, "attempted to neck grab", addition="neck grab")
				if(GRAB_NECK)
					log_combat(user, src, "attempted to strangle", addition="kill grab")
			if(!do_after(user, grab_upgrade_time, src))
				return 0
			if(!user.pulling || user.pulling != src || user.grab_state != old_grab_state)
				return 0
			if(user.a_intent != INTENT_GRAB)
				to_chat(user, span_warning("You must be on grab intent to upgrade your grab further!"))
				return 0
		user.setGrabState(user.grab_state + 1)
		switch(user.grab_state)
			if(GRAB_AGGRESSIVE)
				var/add_log = ""
				if(HAS_TRAIT(user, TRAIT_PACIFISM))
					visible_message(span_danger("[user] firmly grips [src]!"),
									span_danger("[user] firmly grips you!"), span_hear("You hear aggressive shuffling!"), null, user)
					to_chat(user, span_danger("You firmly grip [src]!"))
					add_log = " (pacifist)"
				else
					visible_message(span_danger("[user] grabs [src] aggressively!"), \
									span_userdanger("[user] grabs you aggressively!"), span_hear("You hear aggressive shuffling!"), null, user)
					to_chat(user, span_danger("You grab [src] aggressively!"))
				drop_all_held_items()
				stop_pulling()
				log_combat(user, src, "grabbed", addition="aggressive grab[add_log]")
			if(GRAB_NECK)
				log_combat(user, src, "grabbed", addition="neck grab")
				visible_message(span_danger("[user] grabs [src] by the neck!"),\
								span_userdanger("[user] grabs you by the neck!"), span_hear("You hear aggressive shuffling!"), null, user)
				to_chat(user, span_danger("You grab [src] by the neck!"))
				if(!buckled && !density)
					Move(user.loc)
			if(GRAB_KILL)
				log_combat(user, src, "strangled", addition="kill grab")
				visible_message(span_danger("[user] is strangling [src]!"), \
								span_userdanger("[user] is strangling you!"), span_hear("You hear aggressive shuffling!"), null, user)
				to_chat(user, span_danger("You're strangling [src]!"))
				if(!buckled && !density)
					Move(user.loc)
		user.set_pull_offsets(src, grab_state)
		return 1


/mob/living/attack_slime(mob/living/simple_animal/slime/M)
	if(!SSticker.HasRoundStarted())
		to_chat(M, "You cannot attack people before the game has started.")
		return

	if(M.buckled)
		if(M in buckled_mobs)
			M.Feedstop()
		return // can't attack while eating!

	if(HAS_TRAIT(src, TRAIT_PACIFISM))
		to_chat(M, span_warning("You don't want to hurt anyone!"))
		return FALSE

	if (stat != DEAD)
		log_combat(M, src, "attacked")
		M.do_attack_animation(src)
		visible_message(span_danger("\The [M.name] glomps [src]!"), \
						span_userdanger("\The [M.name] glomps you!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
		to_chat(M, span_danger("You glomp [src]!"))
		return TRUE

/mob/living/attack_basic_mob(mob/living/basic/user, list/modifiers)
	if(user.melee_damage_upper == 0)
		if(user != src)
			visible_message(span_notice("\The [user] [user.friendly_verb_continuous] [src]!"), \
							span_notice("\The [user] [user.friendly_verb_continuous] you!"), null, COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_notice("You [user.friendly_verb_simple] [src]!"))
		return FALSE
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You don't want to hurt anyone!"))
		return FALSE

	if(user.attack_sound)
		playsound(loc, user.attack_sound, 50, TRUE, TRUE)
	user.do_attack_animation(src)
	visible_message(span_danger("\The [user] [user.attack_verb_continuous] [src]!"), \
					span_userdanger("\The [user] [user.attack_verb_continuous] you!"), null, COMBAT_MESSAGE_RANGE, user)
	to_chat(user, span_danger("You [user.attack_verb_simple] [src]!"))
	log_combat(user, src, "attacked")
	return TRUE

/mob/living/attack_animal(mob/living/simple_animal/M)
	M.face_atom(src)
	if(M.melee_damage_upper == 0)
		visible_message(span_notice("\The [M] [M.friendly_verb_continuous] [src]!"), \
						span_notice("\The [M] [M.friendly_verb_continuous] you!"), null, COMBAT_MESSAGE_RANGE, M)
		to_chat(M, span_notice("You [M.friendly_verb_simple] [src]!"))
		return FALSE
	if(HAS_TRAIT(M, TRAIT_PACIFISM))
		to_chat(M, span_warning("You don't want to hurt anyone!"))
		return FALSE

	if(M.attack_sound)
		playsound(loc, M.attack_sound, 50, TRUE, TRUE)
	M.do_attack_animation(src)
	visible_message(span_danger("\The [M] [M.attack_verb_continuous] [src]!"), \
					span_userdanger("\The [M] [M.attack_verb_continuous] you!"), null, COMBAT_MESSAGE_RANGE, M)
	to_chat(M, span_danger("You [M.attack_verb_simple] [src]!"))
	log_combat(M, src, "attacked")
	return TRUE


/mob/living/attack_paw(mob/living/carbon/monkey/M)
	if(isturf(loc) && istype(loc.loc, /area/start))
		to_chat(M, "No attacking people at spawn, you jackass.")
		return FALSE

	if (M.a_intent == INTENT_HARM)
		if(HAS_TRAIT(M, TRAIT_PACIFISM))
			to_chat(M, span_warning("You don't want to hurt anyone!"))
			return FALSE

		if(M.is_muzzled() || M.is_mouth_covered(FALSE, TRUE))
			to_chat(M, span_warning("You can't bite with your mouth covered!"))
			return FALSE
		M.do_attack_animation(src, ATTACK_EFFECT_BITE)
		if (prob(75))
			log_combat(M, src, "attacked")
			playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
			visible_message(span_danger("[M.name] bites [src]!"), \
							span_userdanger("[M.name] bites you!"), span_hear("You hear a chomp!"), COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_danger("You bite [src]!"))
			return TRUE
		else
			visible_message(span_danger("[M.name]'s bite misses [src]!"), \
							span_danger("You avoid [M.name]'s bite!"), span_hear("You hear the sound of jaws snapping shut!"), COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_warning("Your bite misses [src]!"))
	return FALSE

/mob/living/attack_larva(mob/living/carbon/alien/larva/L)
	switch(L.a_intent)
		if("help")
			visible_message(span_notice("[L.name] rubs its head against [src]."), \
							span_notice("[L.name] rubs its head against you."), null, null, L)
			to_chat(L, span_notice("You rub your head against [src]."))
			return FALSE

		else
			if(HAS_TRAIT(L, TRAIT_PACIFISM))
				to_chat(L, span_warning("You don't want to hurt anyone!"))
				return

			L.do_attack_animation(src)
			if(prob(90))
				log_combat(L, src, "attacked")
				visible_message(span_danger("[L.name] bites [src]!"), \
								span_userdanger("[L.name] bites you!"), span_hear("You hear a chomp!"), COMBAT_MESSAGE_RANGE, L)
				to_chat(L, span_danger("You bite [src]!"))
				playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
				return TRUE
			else
				visible_message(span_danger("[L.name]'s bite misses [src]!"), \
								span_danger("You avoid [L.name]'s bite!"), span_hear("You hear the sound of jaws snapping shut!"), COMBAT_MESSAGE_RANGE, L)
				to_chat(L, span_warning("Your bite misses [src]!"))
	return FALSE

/mob/living/attack_alien(mob/living/carbon/alien/humanoid/M)
	switch(M.a_intent)
		if ("help")
			visible_message(span_notice("[M] caresses [src] with its scythe-like arm."), \
							span_notice("[M] caresses you with its scythe-like arm."), null, null, M)
			to_chat(M, span_notice("You caress [src] with your scythe-like arm."))
			return FALSE
		if ("grab")
			grabbedby(M)
			return FALSE
		if("harm")
			if(HAS_TRAIT(M, TRAIT_PACIFISM))
				to_chat(M, span_warning("You don't want to hurt anyone!"))
				return FALSE
			M.do_attack_animation(src)
			return TRUE
		if("disarm")
			M.do_attack_animation(src, ATTACK_EFFECT_DISARM)
			return TRUE

/mob/living/attack_hulk(mob/living/carbon/human/user)
	..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You don't want to hurt [src]!"))
		return FALSE
	return TRUE

/mob/living/ex_act(severity, target, origin)
	if(origin && istype(origin, /datum/spacevine_mutation) && isvineimmune(src))
		return
	..()

//Looking for irradiate()? It's been moved to radiation.dm under the rad_act() for mobs.

/mob/living/acid_act(acidpwr, acid_volume)
	take_bodypart_damage(acidpwr * min(1, acid_volume * 0.1))
	return 1

///As the name suggests, this should be called to apply electric shocks.
/mob/living/proc/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	SEND_SIGNAL(src, COMSIG_LIVING_ELECTROCUTE_ACT, shock_damage, source, siemens_coeff, flags)
	shock_damage *= siemens_coeff
	if((flags & SHOCK_TESLA) && HAS_TRAIT(src, TRAIT_TESLA_SHOCKIMMUNE))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_SHOCKIMMUNE))
		return FALSE
	if(shock_damage < 1)
		return FALSE
	if(!(flags & SHOCK_ILLUSION))
		adjustFireLoss(shock_damage)
	else
		adjustStaminaLoss(shock_damage)
	if(!(flags & SHOCK_SUPPRESS_MESSAGE))
		visible_message(
			span_danger("[src] was shocked by \the [source]!"), \
			span_userdanger("You feel a powerful shock coursing through your body!"), \
			span_hear("You hear a heavy electrical crack.")\
		)
	return shock_damage

/mob/living/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_CONTENTS)
		return
	for(var/obj/O in contents)
		O.emp_act(severity)

///Logs, gibs and returns point values of whatever mob is unfortunate enough to get eaten.
/mob/living/singularity_act()
	investigate_log("([key_name(src)]) has been consumed by the singularity.", INVESTIGATE_SINGULO) //Oh that's where the clown ended up!
	gib()
	return 20

//called when the mob receives a bright flash
/mob/living/proc/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0, type = /atom/movable/screen/fullscreen/flash)
	if(HAS_TRAIT(src, TRAIT_NOFLASH))
		return FALSE
	if(get_eye_protection() < intensity && (override_blindness_check || !is_blind()))
		overlay_fullscreen("flash", type)
		addtimer(CALLBACK(src, PROC_REF(clear_fullscreen), "flash", 25), 25)
		return TRUE
	return FALSE

//called when the mob receives a loud bang
/mob/living/proc/soundbang_act()
	return 0

//to damage the clothes worn by a mob
/mob/living/proc/damage_clothes(damage_amount, damage_type = BRUTE, damage_flag = 0, def_zone)
	return


/mob/living/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!used_item)
		used_item = get_active_held_item()
	..()

/** Handles exposing a mob to reagents.
 *
 * If the method is INGEST the mob tastes the reagents.
 * If the method is VAPOR it incorporates permiability protection.
 */
/mob/living/expose_reagents(list/reagents, datum/reagents/source, method=TOUCH, volume_modifier=1, show_message=TRUE)
	if((. = ..()) & COMPONENT_NO_EXPOSE_REAGENTS)
		return

	if(method == INGEST)
		taste(source)

	var/touch_protection = (method == VAPOR) ? get_permeability_protection() : 0
	for(var/reagent in reagents)
		var/datum/reagent/R = reagent
		. |= R.expose_mob(src, method, reagents[R], show_message, touch_protection)
