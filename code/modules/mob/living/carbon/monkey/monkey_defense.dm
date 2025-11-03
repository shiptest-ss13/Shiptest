/mob/living/carbon/monkey/help_shake_act(mob/living/carbon/M)
	if(health < 0 && ishuman(M))
		var/mob/living/carbon/human/H = M
		H.do_cpr(src)
	else
		..()

/mob/living/carbon/monkey/attack_paw(mob/living/M)
	if(..()) //successful monkey bite.
		var/dam_zone = pick(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)
		if(M.limb_destroyer)
			dismembering_strike(M, affecting.body_zone)
		if(stat != DEAD)
			var/dmg = rand(1, 5)
			apply_damage(dmg, BRUTE, affecting)

/mob/living/carbon/monkey/attack_larva(mob/living/carbon/alien/larva/L)
	if(..()) //successful larva bite.
		var/damage = rand(1, 3)
		if(stat != DEAD)
			L.amount_grown = min(L.amount_grown + damage, L.max_grown)
			var/obj/item/bodypart/affecting = get_bodypart(ran_zone(L.zone_selected))
			if(!affecting)
				affecting = get_bodypart(BODY_ZONE_CHEST)
			apply_damage(damage, BRUTE, affecting)

/mob/living/carbon/monkey/attack_hand(mob/living/carbon/human/M)
	if(..())	//To allow surgery to return properly.
		return

	switch(M.a_intent)
		if("help")
			help_shake_act(M)
		if("grab")
			grabbedby(M)
		if("harm")
			M.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
			if (prob(75))
				visible_message(span_danger("[M] punches [name]!"), \
								span_userdanger("[M] punches you!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
				to_chat(M, span_danger("You punch [name]!"))

				playsound(loc, "punch", 25, TRUE, -1)
				var/damage = rand(5, 10)
				if(prob(40))
					damage = rand(10, 15)
					if(AmountUnconscious() < 100 && health > 0)
						Unconscious(rand(200, 300))
						visible_message(span_danger("[M] knocks [name] out!"), \
										span_userdanger("[M] knocks you out!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), 5, M)
						to_chat(M, span_danger("You knock [name] out!"))
				var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.zone_selected))
				if(!affecting)
					affecting = get_bodypart(BODY_ZONE_CHEST)
				apply_damage(damage, BRUTE, affecting)
				log_combat(M, src, "attacked")

			else
				playsound(loc, 'sound/weapons/punchmiss.ogg', 25, TRUE, -1)
				visible_message(span_danger("[M]'s punch misses [name]!"), \
								span_danger("You avoid [M]'s punch!"), span_hear("You hear a swoosh!"), COMBAT_MESSAGE_RANGE, M)
				to_chat(M, span_warning("Your punch misses [name]!"))
		if("disarm")
			if(stat < UNCONSCIOUS)
				M.disarm(src)

/mob/living/carbon/monkey/attack_alien(mob/living/carbon/alien/humanoid/M)
	if(..()) //if harm or disarm intent.
		if (M.a_intent == INTENT_HARM)
			if ((prob(95) && health > 0))
				playsound(loc, 'sound/weapons/slice.ogg', 25, TRUE, -1)
				var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
				if(AmountUnconscious() < 300)
					Unconscious(rand(200, 300))
					visible_message(span_danger("[M] wounds [name]!"), \
									span_userdanger("[M] wounds you!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_danger("You wound [name]!"))
				else
					visible_message(span_danger("[M] slashes [name]!"), \
									span_userdanger("[M] slashes you!"), span_hear("You hear a sickening sound of a slice!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_danger("You slash [name]!"))

				var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.zone_selected))
				log_combat(M, src, "attacked")
				if(!affecting)
					affecting = get_bodypart(BODY_ZONE_CHEST)
				if(!dismembering_strike(M, affecting.body_zone)) //Dismemberment successful
					return 1
				apply_damage(damage, BRUTE, affecting)

			else
				playsound(loc, 'sound/weapons/slashmiss.ogg', 25, TRUE, -1)
				visible_message(span_danger("[M]'s lunge misses [name]!"), \
								span_danger("You avoid [M]'s lunge!"), span_hear("You hear a swoosh!"), COMBAT_MESSAGE_RANGE, M)
				to_chat(M, span_warning("Your lunge misses [name]!"))

		if (M.a_intent == INTENT_DISARM)
			var/obj/item/I = null
			playsound(loc, 'sound/weapons/pierce.ogg', 25, TRUE, -1)
			if(prob(95))
				Paralyze(20)
				visible_message(span_danger("[M] tackles [name] down!"), \
								span_userdanger("[M] tackles you down!"), span_hear("You hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, M)
				to_chat(M, span_danger("You tackle [name] down!"))
			else
				I = get_active_held_item()
				if(dropItemToGround(I))
					visible_message(span_danger("[M] disarms [name]!"), \
									span_userdanger("[M] disarms you!"), span_hear("You hear aggressive shuffling!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_danger("You disarm [name]!"))
				else
					I = null
			log_combat(M, src, "disarmed", "[I ? " removing \the [I]" : ""]")
			updatehealth()

//TG turned monkeys into carbons so im copy pasting attack_animal cause I dont care about this interaction that much.
/mob/living/carbon/monkey/attack_basic_mob(mob/living/basic/user, list/modifiers)
	. = ..()
	if(.)
		var/damage = rand(user.melee_damage_lower, user.melee_damage_upper)
		var/dam_zone = dismembering_strike(user, pick(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(!dam_zone) //Dismemberment successful
			return TRUE
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)
		apply_damage(damage, user.melee_damage_type, affecting)

/mob/living/carbon/monkey/attack_animal(mob/living/simple_animal/M)
	. = ..()
	if(.)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		var/dam_zone = dismembering_strike(M, pick(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(!dam_zone) //Dismemberment successful
			return TRUE
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)
		apply_damage(damage, M.melee_damage_type, affecting)

/mob/living/carbon/monkey/attack_slime(mob/living/simple_animal/slime/M)
	if(..()) //successful slime attack
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(M.is_adult)
			damage = rand(20, 40)
		var/dam_zone = dismembering_strike(M, pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(!dam_zone) //Dismemberment successful
			return 1
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)
		apply_damage(damage, BRUTE, affecting)

/mob/living/carbon/monkey/acid_act(acidpwr, acid_volume, bodyzone_hit)
	. = 1
	if(!bodyzone_hit || bodyzone_hit == BODY_ZONE_HEAD)
		if(wear_mask)
			if(!(wear_mask.resistance_flags & UNACIDABLE))
				wear_mask.acid_act(acidpwr, acid_volume)
			else
				to_chat(src, span_warning("Your mask protects you from the acid."))
			return
		if(head)
			if(!(head.resistance_flags & UNACIDABLE))
				head.acid_act(acidpwr, acid_volume)
			else
				to_chat(src, span_warning("Your hat protects you from the acid."))
			return
	take_bodypart_damage(acidpwr * min(0.6, acid_volume*0.1))


/mob/living/carbon/monkey/ex_act(severity, target, origin)
	if(origin && istype(origin, /datum/spacevine_mutation) && isvineimmune(src))
		return
	..()
	if(QDELETED(src))
		return
	switch (severity)
		if (EXPLODE_DEVASTATE)
			gib()
			return

		if (EXPLODE_HEAVY)
			take_overall_damage(60, 60)
			damage_clothes(200, BRUTE, "bomb")
			adjustEarDamage(30, 120)
			if(prob(70))
				Unconscious(200)

		if(EXPLODE_LIGHT)
			take_overall_damage(30, 0)
			damage_clothes(50, BRUTE, "bomb")
			adjustEarDamage(15,60)
			if (prob(50))
				Unconscious(160)


	//attempt to dismember bodyparts
	if(severity <= 2)
		var/max_limb_loss = round(4/severity) //so you don't lose four limbs at severity 3.
		var/obj/item/bodypart/body_part
		for(var/zone in bodyparts)
			body_part = bodyparts[zone]
			if(!body_part)
				continue
			if(prob(50/severity) && zone != BODY_ZONE_CHEST)
				body_part.brute_dam = body_part.max_damage
				body_part.dismember()
				max_limb_loss--
				if(!max_limb_loss)
					break
