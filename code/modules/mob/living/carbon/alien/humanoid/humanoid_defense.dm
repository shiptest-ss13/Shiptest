/mob/living/carbon/alien/humanoid/attack_hulk(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	adjustBruteLoss(15)
	var/hitverb = "hit"
	if(mob_size < MOB_SIZE_LARGE)
		safe_throw_at(get_edge_target_turf(src, get_dir(user, src)), 2, 1, user)
		hitverb = "slam"
	playsound(loc, "punch", 25, TRUE, -1)
	visible_message(span_danger("[user] [hitverb]s [src]!"), \
					span_userdanger("[user] [hitverb]s you!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, user)
	to_chat(user, span_danger("You [hitverb] [src]!"))

/mob/living/carbon/alien/humanoid/attack_hand(mob/living/carbon/human/M)
	if(..())
		switch(M.a_intent)
			if ("harm")
				var/damage = rand(1, 9)
				if (prob(90))
					playsound(loc, "punch", 25, TRUE, -1)
					visible_message(span_danger("[M] punches [src]!"), \
									span_userdanger("[M] punches you!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_danger("You punch [src]!"))
					if ((stat != DEAD) && (damage > 9 || prob(5)))//Regular humans have a very small chance of knocking an alien down.
						Unconscious(40)
						visible_message(span_danger("[M] knocks [src] down!"), \
										span_userdanger("[M] knocks you down!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, M)
						to_chat(M, span_danger("You knock [src] down!"))
					var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.zone_selected))
					apply_damage(damage, BRUTE, affecting)
					log_combat(M, src, "attacked")
				else
					playsound(loc, 'sound/weapons/punchmiss.ogg', 25, TRUE, -1)
					visible_message(span_danger("[M]'s punch misses [src]!"), \
									span_danger("You avoid [M]'s punch!"), span_hear("You hear a swoosh!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_warning("Your punch misses [src]!"))

			if ("disarm")
				if(stat < UNCONSCIOUS)
					M.disarm(src)



/mob/living/carbon/alien/humanoid/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!no_effect && !visual_effect_icon)
		visual_effect_icon = ATTACK_EFFECT_CLAW
	..()
