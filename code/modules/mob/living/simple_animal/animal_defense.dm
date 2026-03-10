

/mob/living/simple_animal/attack_hand(mob/living/carbon/human/M)
	..()
	switch(M.a_intent)
		if("help")
			if (health > 0)
				visible_message(span_notice("[M] [response_help_continuous] [src]."), \
								span_notice("[M] [response_help_continuous] you."), null, null, M)
				to_chat(M, span_notice("You [response_help_simple] [src]."))
				playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)

		if("grab")
			grabbedby(M)

		if("harm", "disarm")
			if(HAS_TRAIT(M, TRAIT_PACIFISM))
				to_chat(M, span_warning("You don't want to hurt [src]!"))
				return
			M.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
			visible_message(span_danger("[M] [response_harm_continuous] [src]!"),\
							span_userdanger("[M] [response_harm_continuous] you!"), null, COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_danger("You [response_harm_simple] [src]!"))
			playsound(loc, attacked_sound, 25, TRUE, -1)
			attack_threshold_check(harm_intent_damage)
			log_combat(M, src, "attacked")
			updatehealth()
			return TRUE

/mob/living/simple_animal/attack_hulk(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	playsound(loc, "punch", 25, TRUE, -1)
	visible_message(span_danger("[user] punches [src]!"), \
					span_userdanger("You're punched by [user]!"), null, COMBAT_MESSAGE_RANGE, user)
	to_chat(user, span_danger("You punch [src]!"))
	apply_damage(15, BRUTE, wound_bonus=10)

/mob/living/simple_animal/attack_paw(mob/living/carbon/monkey/M)
	if(..()) //successful monkey bite.
		if(stat != DEAD)
			var/damage = rand(1, 3)
			attack_threshold_check(damage)
			return 1
	if (M.a_intent == INTENT_HELP)
		if (health > 0)
			visible_message(span_notice("[M.name] [response_help_continuous] [src]."), \
							span_notice("[M.name] [response_help_continuous] you."), null, COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_notice("You [response_help_simple] [src]."))
			playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)


/mob/living/simple_animal/attack_alien(mob/living/carbon/alien/humanoid/M)
	if(..()) //if harm or disarm intent.
		if(M.a_intent == INTENT_DISARM)
			playsound(loc, 'sound/weapons/pierce.ogg', 25, TRUE, -1)
			visible_message(span_danger("[M] [response_disarm_continuous] [name]!"), \
							span_userdanger("[M] [response_disarm_continuous] you!"), null, COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_danger("You [response_disarm_simple] [name]!"))
			log_combat(M, src, "disarmed")
		else
			var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
			visible_message(span_danger("[M] slashes at [src]!"), \
							span_userdanger("You're slashed at by [M]!"), null, COMBAT_MESSAGE_RANGE, M)
			to_chat(M, span_danger("You slash at [src]!"))
			playsound(loc, 'sound/weapons/slice.ogg', 25, TRUE, -1)
			attack_threshold_check(damage)
			log_combat(M, src, "attacked")
		return 1

/mob/living/simple_animal/attack_larva(mob/living/carbon/alien/larva/L)
	. = ..()
	if(. && stat != DEAD) //successful larva bite
		var/damage = rand(5, 10)
		. = attack_threshold_check(damage)
		if(.)
			L.amount_grown = min(L.amount_grown + damage, L.max_grown)

/mob/living/simple_animal/attack_basic_mob(mob/living/basic/user, list/modifiers)
	. = ..()
	if(.)
		var/damage = rand(user.melee_damage_lower, user.melee_damage_upper)
		return attack_threshold_check(damage, user.melee_damage_type)

/mob/living/simple_animal/attack_animal(mob/living/simple_animal/M)
	. = ..()
	if(.)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		return attack_threshold_check(damage, M.melee_damage_type, armour_pen = M.armour_penetration)

/mob/living/simple_animal/attack_slime(mob/living/simple_animal/slime/M)
	if(..()) //successful slime attack
		var/damage = rand(15, 25)
		if(M.is_adult)
			damage = rand(20, 35)
		return attack_threshold_check(damage, M.melee_damage_type, armour_pen = M.armour_penetration)

/mob/living/simple_animal/attack_drone(mob/living/simple_animal/drone/M)
	if(M.a_intent == INTENT_HARM) //No kicking dogs even as a rogue drone. Use a weapon.
		return
	return ..()

/mob/living/simple_animal/proc/attack_threshold_check(damage, damagetype = BRUTE, armor_type = "melee", armour_pen = 0)
	var/temp_damage = damage
	if(!damage_coeff[damagetype])
		temp_damage = 0
	else
		temp_damage *= damage_coeff[damagetype]

	if(temp_damage >= 0 && temp_damage <= force_threshold)
		visible_message(span_warning("[src] looks unharmed!"))
		return FALSE
	else
		apply_damage(damage, damagetype, null, run_armor_check(null, armor_type, armour_pen, silent=TRUE))
		return TRUE

/mob/living/simple_animal/ex_act(severity, target, origin)
	if(origin && istype(origin, /datum/spacevine_mutation) && isvineimmune(src))
		return
	..()
	if(QDELETED(src))
		return
	var/bomb_armor = getarmor(null, "bomb")
	switch (severity)
		if (EXPLODE_DEVASTATE)
			if(prob(bomb_armor))
				adjustBruteLoss(500)
			else
				gib()
				return
		if (EXPLODE_HEAVY)
			var/bloss = 60
			if(prob(bomb_armor))
				bloss = bloss / 1.5
			adjustBruteLoss(bloss)

		if(EXPLODE_LIGHT)
			var/bloss = 30
			if(prob(bomb_armor))
				bloss = bloss / 1.5
			adjustBruteLoss(bloss)

/mob/living/simple_animal/do_attack_animation(atom/A, visual_effect_icon, used_item, no_effect)
	if(!no_effect && !visual_effect_icon && melee_damage_upper)
		if(melee_damage_upper < 10)
			visual_effect_icon = ATTACK_EFFECT_PUNCH
		else
			visual_effect_icon = ATTACK_EFFECT_SMASH
	..()
