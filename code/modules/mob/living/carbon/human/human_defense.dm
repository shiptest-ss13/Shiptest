/mob/living/carbon/human/getarmor(def_zone, type)
	var/armorval = 0
	var/organnum = 0

	if(def_zone)
		if(isbodypart(def_zone))
			var/obj/item/bodypart/bp = def_zone
			if(bp)
				return checkarmor(def_zone, type)
		var/obj/item/bodypart/affecting = get_bodypart(check_zone(def_zone))
		if(affecting)
			return checkarmor(affecting, type)
		//If a specific bodypart is targetted, check how that bodypart is protected and return the value.

	//If you don't specify a bodypart, it checks ALL your bodyparts for protection, and averages out the values
	var/obj/item/bodypart/body_part
	for(var/zone in bodyparts)
		body_part = bodyparts[zone]
		if(!body_part)
			continue
		armorval += checkarmor(body_part, type)
		organnum++
	return (armorval/max(organnum, 1))


/mob/living/carbon/human/proc/checkarmor(obj/item/bodypart/def_zone, d_type)
	if(!d_type)
		return 0
	var/protection = 0
	var/list/body_parts = list(head, wear_mask, wear_suit, w_uniform, back, gloves, shoes, belt, s_store, glasses, ears, wear_id, wear_neck) //Everything but pockets. Pockets are l_store and r_store. (if pockets were allowed, putting something armored, gloves or hats for example, would double up on the armor)
	for(var/bp in body_parts)
		if(!bp)
			continue
		if(bp && istype(bp , /obj/item/clothing))
			var/obj/item/clothing/C = bp
			if(C.body_parts_covered & def_zone.body_part)
				protection += C.armor.getRating(d_type)
	protection += physiology.armor.getRating(d_type) * (100 - protection) / 100		//WS Edit - Makes armor multiplicative
	return protection

///Get all the clothing on a specific body part
/mob/living/carbon/human/proc/clothingonpart(obj/item/bodypart/def_zone)
	var/list/covering_part = list()
	var/list/body_parts = list(head, wear_mask, wear_suit, w_uniform, back, gloves, shoes, belt, s_store, glasses, ears, wear_id, wear_neck) //Everything but pockets. Pockets are l_store and r_store. (if pockets were allowed, putting something armored, gloves or hats for example, would double up on the armor)
	for(var/bp in body_parts)
		if(!bp)
			continue
		if(bp && istype(bp , /obj/item/clothing))
			var/obj/item/clothing/C = bp
			if(C.body_parts_covered & def_zone.body_part)
				covering_part += C
	return covering_part

/mob/living/carbon/human/on_hit(obj/projectile/P)
	if(dna && dna.species)
		dna.species.on_hit(P, src)

/mob/living/carbon/human/bullet_act(obj/projectile/P, def_zone, piercing_hit = FALSE)
	if(dna?.species)
		var/spec_return = dna.species.bullet_act(P, src)
		if(spec_return)
			return spec_return

	//MARTIAL ART STUFF
	if(mind)
		if(mind.martial_art && mind.martial_art.can_use(src)) //Some martial arts users can deflect projectiles!
			var/martial_art_result = mind.martial_art.on_projectile_hit(src, P, def_zone)
			if(!(martial_art_result == BULLET_ACT_HIT))
				return martial_art_result

	if(!(P.original == src && P.firer == src)) //can't block or reflect when shooting yourself
		if(P.reflectable & REFLECT_NORMAL)
			if(check_reflect(def_zone)) // Checks if you've passed a reflection% check
				visible_message(span_danger("The [P.name] gets reflected by [src]!"), \
								span_userdanger("The [P.name] gets reflected by [src]!"))
				// Find a turf near or on the original location to bounce to
				if(!isturf(loc)) //Open canopy mech (ripley) check. if we're inside something and still got hit
					P.force_hit = TRUE //The thing we're in passed the bullet to us. Pass it back, and tell it to take the damage.
					loc.bullet_act(P, def_zone, piercing_hit)
					return BULLET_ACT_HIT
				if(P.starting)
					var/new_x = P.starting.x + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
					var/new_y = P.starting.y + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
					var/turf/curloc = get_turf(src)

					// redirect the projectile
					P.original = locate(new_x, new_y, P.z)
					P.starting = curloc
					P.firer = src
					P.yo = new_y - curloc.y
					P.xo = new_x - curloc.x
					var/new_angle_s = P.Angle + rand(120,240)
					while(new_angle_s > 180)	// Translate to regular projectile degrees
						new_angle_s -= 360
					P.setAngle(new_angle_s)

				return BULLET_ACT_FORCE_PIERCE // complete projectile permutation

		if(check_shields(P, P.damage, "the [P.name]", PROJECTILE_ATTACK, P.armour_penetration))
			P.on_hit(src, 100, def_zone, piercing_hit)
			return BULLET_ACT_HIT

	return ..()

///Reflection checks for anything in your l_hand, r_hand, or wear_suit based on the reflection chance of the object
/mob/living/carbon/human/proc/check_reflect(def_zone)
	if(wear_suit)
		if(wear_suit.IsReflect(def_zone))
			return TRUE
	if(head)
		if(head.IsReflect(def_zone))
			return TRUE
	for(var/obj/item/I in held_items)
		if(I.IsReflect(def_zone))
			return TRUE
	if(SEND_SIGNAL(src, COMSIG_CHECK_REFLECT, def_zone))
		return TRUE
	if(HAS_TRAIT(src, TRAIT_REFLECTIVE))
		return TRUE
	return FALSE

/mob/living/carbon/human/proc/check_shields(atom/AM, damage, attack_text = "the attack", attack_type = MELEE_ATTACK, armour_penetration = 0)
	var/block_chance_modifier = round(damage / -3)

	var/obj/item/shield = get_best_shield()
	if(shield)
		var/final_block_chance = shield.block_chance - (clamp((armour_penetration - shield.armour_penetration)/2,0,100)) + block_chance_modifier
		var/shield_result = shield.hit_reaction(src, AM, attack_text, final_block_chance, damage, attack_type)
		if(shield_result >= 1)
			return TRUE
		if(shield_result == -1)
			return -1

	if(wear_suit)
		var/final_block_chance = wear_suit.block_chance - (clamp((armour_penetration - wear_suit.armour_penetration)/2,0,100)) + block_chance_modifier
		if(wear_suit.hit_reaction(src, AM, attack_text, final_block_chance, damage, attack_type))
			return TRUE
	if(w_uniform)
		var/final_block_chance = w_uniform.block_chance - (clamp((armour_penetration - w_uniform.armour_penetration)/2,0,100)) + block_chance_modifier
		if(w_uniform.hit_reaction(src, AM, attack_text, final_block_chance, damage, attack_type))
			return TRUE
	if(wear_neck)
		var/final_block_chance = wear_neck.block_chance - (clamp((armour_penetration - wear_neck.armour_penetration)/2,0,100)) + block_chance_modifier
		if(wear_neck.hit_reaction(src, AM, attack_text, final_block_chance, damage, attack_type))
			return TRUE
	if(head)
		var/final_block_chance = head.block_chance - (clamp((armour_penetration - head.armour_penetration)/2,0,100)) + block_chance_modifier
		if(head.hit_reaction(src, AM, attack_text, final_block_chance, damage, attack_type))
			return TRUE

	return FALSE


/mob/living/carbon/human/proc/get_best_shield()
	var/obj/item/l_hand = held_items[1]
	var/obj/item/r_hand = held_items[2]
	if(!(r_hand || l_hand))
		return r_hand || l_hand
	else if(r_hand?.block_chance > l_hand?.block_chance)
		return r_hand
	else
		return l_hand

/mob/living/carbon/human/proc/check_block()
	if(mind)
		if(mind.martial_art && prob(mind.martial_art.block_chance) && mind.martial_art.can_use(src) && throw_mode && !incapacitated(FALSE, TRUE))
			return TRUE
	return FALSE

/mob/living/carbon/human/hitby(atom/movable/AM, skipcatch = FALSE, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	if(dna && dna.species)
		var/spec_return = dna.species.spec_hitby(AM, src)
		if(spec_return)
			return spec_return
	var/obj/item/I
	var/throwpower = 30
	if(istype(AM, /obj/item))
		I = AM
		throwpower = I.throwforce
		if(I.thrownby == WEAKREF(src)) //No throwing stuff at yourself to trigger hit reactions
			return ..()
	if(check_shields(AM, throwpower, "\the [AM.name]", THROWN_PROJECTILE_ATTACK))
		hitpush = FALSE
		skipcatch = TRUE
		blocked = TRUE

	return ..()

/mob/living/carbon/human/grippedby(mob/living/user, instant = FALSE)
	if(w_uniform)
		w_uniform.add_fingerprint(user)
	..()


/mob/living/carbon/human/attacked_by(obj/item/I, mob/living/user)
	if(!I || !user)
		return 0

	var/obj/item/bodypart/affecting
	if(user == src)
		affecting = get_bodypart(check_zone(user.zone_selected)) //stabbing yourself always hits the right target
	else
		var/zone_hit_chance = 80
		if(body_position == LYING_DOWN) // half as likely to hit a different zone if they're on the ground
			zone_hit_chance += 10
		affecting = get_bodypart(ran_zone(user.zone_selected, zone_hit_chance))
	var/target_area = parse_zone(check_zone(user.zone_selected)) //our intended target

	if(affecting)
		if(I.force && I.damtype != STAMINA && (!IS_ORGANIC_LIMB(affecting))) // Bodpart_robotic sparks when hit, but only when it does real damage
			if(I.force >= 5)
				do_sparks(1, FALSE, loc)

	SEND_SIGNAL(I, COMSIG_ITEM_ATTACK_ZONE, src, user, affecting)

	SSblackbox.record_feedback("nested tally", "item_used_for_combat", 1, list("[I.force]", "[I.type]"))
	SSblackbox.record_feedback("tally", "zone_targeted", 1, target_area)

	// the attacked_by code varies among species
	return dna.species.spec_attacked_by(I, user, affecting, a_intent, src)

/mob/living/carbon/human/attack_hulk(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	var/hulk_verb = pick("smash","pummel")
	if(check_shields(user, 15, "the [hulk_verb]ing"))
		return
	playsound(loc, user.dna.species.attack_sound, 25, TRUE, -1)
	visible_message(span_danger("[user] [hulk_verb]ed [src]!"), \
					span_userdanger("[user] [hulk_verb]ed [src]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, user)
	to_chat(user, span_danger("You [hulk_verb] [src]!"))
	apply_damage(15, BRUTE, wound_bonus=10)

/mob/living/carbon/human/attack_hand(mob/user)
	if(..())	//to allow surgery to return properly.
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		dna.species.spec_attack_hand(H, src)

/mob/living/carbon/human/attack_paw(mob/living/carbon/monkey/M)
	var/dam_zone = pick(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
	if(!affecting)
		affecting = get_bodypart(BODY_ZONE_CHEST)
	if(M.a_intent == INTENT_HELP)
		..() //shaking
		return 0

	if(M.a_intent == INTENT_DISARM) //Always drop item in hand, if no item, get stunned instead.
		var/obj/item/I = get_active_held_item()
		if(I && !(I.item_flags & ABSTRACT) && dropItemToGround(I))
			playsound(loc, 'sound/weapons/slash.ogg', 25, TRUE, -1)
			visible_message(span_danger("[M] disarmed [src]!"), \
							span_userdanger("[M] disarmed you!"), span_hear("You hear aggressive shuffling!"), null, M)
			to_chat(M, span_danger("You disarm [src]!"))
		else if(!M.client || prob(5)) // only natural monkeys get to stun reliably, (they only do it occasionaly)
			playsound(loc, 'sound/weapons/pierce.ogg', 25, TRUE, -1)
			if (src.IsKnockdown() && !src.IsParalyzed())
				Paralyze(40)
				log_combat(M, src, "pinned")
				visible_message(span_danger("[M] pins [src] down!"), \
								span_userdanger("[M] pins you down!"), span_hear("You hear shuffling and a muffled groan!"), null, M)
				to_chat(M, span_danger("You pin [src] down!"))
			else
				Knockdown(30)
				log_combat(M, src, "tackled")
				visible_message(span_danger("[M] tackles [src] down!"), \
								span_userdanger("[M] tackles you down!"), span_hear("You hear aggressive shuffling followed by a loud thud!"), null, M)
				to_chat(M, span_danger("You tackle [src] down!"))

	if(M.limb_destroyer)
		dismembering_strike(M, affecting.body_zone)

	if(can_inject(M, 1, affecting))//Thick suits can stop monkey bites.
		if(..()) //successful monkey bite, this handles disease contraction.
			var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
			if(!damage)
				return
			if(check_shields(M, damage, "the [M.name]"))
				return 0
			if(stat != DEAD)
				apply_damage(damage, BRUTE, affecting, run_armor_check(affecting, "melee"))
		return 1

/mob/living/carbon/human/attack_alien(mob/living/carbon/alien/humanoid/M)
	if(check_shields(M, 0, "the M.name"))
		visible_message(span_danger("[M] attempts to touch [src]!"), \
						span_danger("[M] attempts to touch you!"), span_hear("You hear a swoosh!"), null, M)
		to_chat(M, span_warning("You attempt to touch [src]!"))
		return FALSE
	. = ..()
	if(!.)
		return
	if(M.a_intent == INTENT_HARM)
		if (w_uniform)
			w_uniform.add_fingerprint(M)
		var/damage = prob(90) ? rand(M.melee_damage_lower, M.melee_damage_upper) : 0
		if(!damage)
			playsound(loc, 'sound/weapons/slashmiss.ogg', 50, TRUE, -1)
			visible_message(span_danger("[M] lunges at [src]!"), \
							span_userdanger("[M] lunges at you!"), span_hear("You hear a swoosh!"), null, M)
			to_chat(M, span_danger("You lunge at [src]!"))
			return FALSE
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.zone_selected))
		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)
		var/armor_block = run_armor_check(affecting, "melee", 10, silent = TRUE)

		playsound(loc, 'sound/weapons/slice.ogg', 25, TRUE, -1)
		visible_message(span_danger("[M] slashes at [src]!"), \
						span_userdanger("[M] slashes at you!"), span_hear("You hear a sickening sound of a slice!"), null, M)
		to_chat(M, span_danger("You slash at [src]!"))
		log_combat(M, src, "attacked")
		if(!dismembering_strike(M, M.zone_selected)) //Dismemberment successful
			return TRUE
		apply_damage(damage, BRUTE, affecting, armor_block)

	if(M.a_intent == INTENT_DISARM) //Always drop item in hand on first go.  If no item exists, try to shove them back.  If you share the tile with the target, slam them directly into the ground to stun them and slightly damage them.
		var/obj/item/I = get_active_held_item()
		if(I && dropItemToGround(I) && prob(50))
			playsound(loc, 'sound/weapons/slash.ogg', 25, TRUE, -1)
			visible_message(span_danger("[M] disarms [src]!"), \
							span_userdanger("[M] disarms you!"), span_hear("You hear aggressive shuffling!"), null, M)
			to_chat(M, span_danger("You disarm [src]!"))
		else if(get_dist(src, M) != 0)
			playsound(loc, 'sound/weapons/pierce.ogg', 25, TRUE, -1)
			var/shovetarget = get_edge_target_turf(M, get_dir(M, get_step_away(src, M)))
			Knockdown(0.3 SECONDS)
			throw_at(shovetarget, 4, 2, M, force = MOVE_FORCE_OVERPOWERING)
			log_combat(M, src, "shoved")
			visible_message(span_danger("[M] tackles [src] down!"), \
							span_userdanger("[M] shoves you with great force!"), span_hear("You hear aggressive shuffling followed by a loud thud!"), null, M)
			to_chat(M, span_danger("You shove [src] with great force!"))
		else
			Paralyze(1 SECONDS)
			adjustBruteLoss(5)
			playsound(loc, 'sound/weapons/punch3.ogg', 25, TRUE, -1)
			visible_message(span_danger("[M] slams [src] into the floor!"), \
							span_userdanger("[M] slams you into the ground!"), span_hear("You hear something slam loudly onto the floor!"), null, M)
			to_chat(M, span_danger("You slam [src] into the floor beneath you!"))
			log_combat(M, src, "slammed into the ground")

/mob/living/carbon/human/attack_larva(mob/living/carbon/alien/larva/L)

	if(..()) //successful larva bite.
		var/damage = rand(L.melee_damage_lower, L.melee_damage_upper)
		if(!damage)
			return
		if(check_shields(L, damage, "the [L.name]"))
			return 0
		if(stat != DEAD)
			L.amount_grown = min(L.amount_grown + damage, L.max_grown)
			var/obj/item/bodypart/affecting = get_bodypart(ran_zone(L.zone_selected))
			if(!affecting)
				affecting = get_bodypart(BODY_ZONE_CHEST)
			var/armor_block = run_armor_check(affecting, "melee")
			apply_damage(damage, BRUTE, affecting, armor_block)

/mob/living/carbon/human/attack_basic_mob(mob/living/basic/user, list/modifiers)
	. = ..()
	if(!.)
		return
	var/damage = rand(user.melee_damage_lower, user.melee_damage_upper)
	if(check_shields(user, damage, "the [user.name]", MELEE_ATTACK, user.armour_penetration))
		return FALSE
	var/dam_zone = dismembering_strike(user, pick(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
	if(!dam_zone) //Dismemberment successful
		return TRUE
	var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
	if(!affecting)
		affecting = get_bodypart(BODY_ZONE_CHEST)
	var/armor = run_armor_check(affecting, MELEE, armour_penetration = user.armour_penetration)
	apply_damage(damage, user.melee_damage_type, affecting, armor, sharpness = user.sharpness)


/mob/living/carbon/human/attack_animal(mob/living/simple_animal/M)
	. = ..()
	if(.)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		if(check_shields(M, damage, "the [M.name]", MELEE_ATTACK, M.armour_penetration))
			return FALSE
		var/dam_zone = dismembering_strike(M, pick_weight(list(BODY_ZONE_HEAD = 4, BODY_ZONE_CHEST = 64, BODY_ZONE_L_ARM = 8, BODY_ZONE_R_ARM = 8, BODY_ZONE_L_LEG = 8, BODY_ZONE_R_LEG = 8)))
		if(!dam_zone) //Dismemberment successful
			return TRUE
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)
		var/armor = run_armor_check(affecting, "melee", armour_penetration = M.armour_penetration)
		var/attack_direction = get_dir(M, src)
		apply_damage(damage, M.melee_damage_type, affecting, armor, wound_bonus = M.wound_bonus, bare_wound_bonus = M.bare_wound_bonus, sharpness = M.sharpness, attack_direction = attack_direction)

/mob/living/carbon/human/attack_slime(mob/living/simple_animal/slime/M)
	if(..()) //successful slime attack
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		var/wound_mod = -45 // 25^1.4=90, 90-45=45
		if(!damage)
			return
		if(M.is_adult)
			damage += rand(5, 10)
			wound_mod = -90 // 35^1.4=145, 145-90=55

		if(check_shields(M, damage, "the [M.name]"))
			return 0

		var/dam_zone = dismembering_strike(M, pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(!dam_zone) //Dismemberment successful
			return 1

		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)
		var/armor_block = run_armor_check(affecting, "melee", M.armour_penetration)
		apply_damage(damage, BRUTE, affecting, armor_block, wound_bonus=wound_mod)

/mob/living/carbon/human/mech_melee_attack(obj/mecha/M)

	if(M.occupant.a_intent == INTENT_HARM)
		if(HAS_TRAIT(M.occupant, TRAIT_PACIFISM))
			to_chat(M.occupant, span_warning("You don't want to harm other living beings!"))
			return
		M.do_attack_animation(src)
		if(M.damtype == "brute")
			step_away(src,M,15)
		var/obj/item/bodypart/temp = get_bodypart(pick(BODY_ZONE_CHEST, BODY_ZONE_CHEST, BODY_ZONE_CHEST, BODY_ZONE_HEAD))
		if(temp)
			var/update = 0
			var/dmg = rand(M.force/2, M.force)
			switch(M.damtype)
				if("brute")
					if(M.force > 35) // durand and other heavy mechas
						Unconscious(20)
					else if(M.force > 20 && !IsKnockdown()) // lightweight mechas like gygax
						Knockdown(40)
					update |= temp.receive_damage(dmg, 0)
					playsound(src, 'sound/weapons/punch4.ogg', 50, TRUE)
				if("fire")
					update |= temp.receive_damage(0, dmg)
					playsound(src, 'sound/items/welder.ogg', 50, TRUE)
				if("tox")
					M.mech_toxin_damage(src)
				else
					return
			if(update)
				update_damage_overlays()
			updatehealth()

		visible_message(span_danger("[M.name] hits [src]!"), \
						span_userdanger("[M.name] hits you!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
		to_chat(M, span_danger("You hit [src]!"))
		log_combat(M.occupant, src, "attacked", M, "(INTENT: [uppertext(M.occupant.a_intent)]) (DAMTYPE: [uppertext(M.damtype)])")

	else
		..()


/mob/living/carbon/human/ex_act(severity, target, origin)
	if(TRAIT_BOMBIMMUNE in dna.species.species_traits)
		return
	..()
	if (!severity || QDELETED(src))
		return
	var/brute_loss = 0
	var/burn_loss = 0
	var/bomb_armor = getarmor(null, "bomb")
	var/intensity = 1
	var/ear_damage = 0
	var/deafness_power = 0

//200 max knockdown for EXPLODE_HEAVY
//160 max knockdown for EXPLODE_LIGHT


	switch (severity)
		if (EXPLODE_DEVASTATE)
			if(bomb_armor < EXPLODE_GIB_THRESHOLD) //gibs the mob if their bomb armor is lower than EXPLODE_GIB_THRESHOLD
				for(var/I in contents)
					var/atom/A = I
					if(!QDELETED(A))
						switch(severity)
							if(EXPLODE_DEVASTATE)
								SSexplosions.highobj += A
							if(EXPLODE_HEAVY)
								SSexplosions.medobj += A
							if(EXPLODE_LIGHT)
								SSexplosions.lowobj += A
				gib()
				return
			else
				brute_loss = 500
				var/atom/throw_target = get_edge_target_turf(src, get_dir(src, get_step_away(src, src)))
				throw_at(throw_target, 200, 4)
				damage_clothes(400 - bomb_armor, BRUTE, "bomb")

		if (EXPLODE_HEAVY)
			brute_loss = 35
			burn_loss = 35
			if(bomb_armor)
				brute_loss = 20*(2 - round(bomb_armor*0.01, 0.05))
				burn_loss = brute_loss				//damage gets reduced from 120 to up to 60 combined brute+burn
			intensity = 2
			ear_damage = 30
			deafness_power = 120
			damage_clothes(max(rand(90,150) - bomb_armor, 0), BRUTE, "bomb")
			Unconscious(20)							//short amount of time for follow up attacks against elusive enemies like wizards
			Knockdown(200 - (bomb_armor * 1.6)) 	//between ~4 and ~20 seconds of knockdown depending on bomb armor

		if(EXPLODE_LIGHT)
			brute_loss = 20
			burn_loss = 20
			if(bomb_armor)
				brute_loss = 15*(2 - round(bomb_armor*0.01, 0.05))
				burn_loss = bruteloss
			damage_clothes(max(rand(10,90) - bomb_armor, 0), BRUTE, "bomb")
			intensity = 1.5
			ear_damage = 15
			deafness_power = 60
			Knockdown(160 - (bomb_armor * 1.6))		//100 bomb armor will prevent knockdown altogether

	take_overall_damage(brute_loss,burn_loss)
	soundbang_act(intensity, 0, ear_damage, deafness_power)

	//attempt to dismember bodyparts
	if(severity <= 2 || !bomb_armor)
		var/max_limb_loss = round(4/severity) //so you don't lose four limbs at severity 3.
		var/obj/item/bodypart/body_part
		for(var/zone in bodyparts)
			body_part = bodyparts[zone]
			if(!body_part)
				continue
			if(prob(50/severity) && !prob(getarmor(body_part, "bomb")) && !(body_part.body_part & CHEST|HEAD))
				body_part.brute_dam = body_part.max_damage
				body_part.dismember()
				max_limb_loss--
				if(!max_limb_loss)
					break

///Calculates the siemens coeff based on clothing and species, can also restart hearts.
/mob/living/carbon/human/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	//If it doesnt have physiology its prob still initializing.
	if(!physiology)
		return
	//Calculates the siemens coeff based on clothing. Completely ignores the arguments
	if(flags & SHOCK_TESLA) //I hate this entire block. This gets the siemens_coeff for tesla shocks
		if(gloves && gloves.siemens_coefficient <= 0)
			siemens_coeff -= 0.5
		if(wear_suit)
			if(wear_suit.siemens_coefficient == -1)
				siemens_coeff -= 1
			else if(wear_suit.siemens_coefficient <= 0)
				siemens_coeff -= 0.95
		siemens_coeff = max(siemens_coeff, 0)
	else if(!(flags & SHOCK_NOGLOVES)) //This gets the siemens_coeff for all non tesla shocks
		if(gloves)
			siemens_coeff *= gloves.siemens_coefficient
	//If it doesnt have physiology its prob still initializing.
	if(!physiology)
		. = ..()
		return
	siemens_coeff *= physiology.siemens_coeff
	siemens_coeff *= dna.species.siemens_coeff
	. = ..()
	//Don't go further if the shock was blocked/too weak.
	if(!.)
		return
	//Note we both check that the user is in cardiac arrest and can actually heartattack
	//If they can't, they're missing their heart and this would runtime
	if(undergoing_cardiac_arrest() && can_heartattack() && !(flags & SHOCK_ILLUSION))
		if(shock_damage * siemens_coeff >= 1 && prob(25))
			var/obj/item/organ/heart/heart = getorganslot(ORGAN_SLOT_HEART)
			if(heart.Restart() && stat == CONSCIOUS)
				to_chat(src, span_notice("You feel your heart beating again!"))
	//WS - Bootleg IPC revival
	if(stat == DEAD && isipc(src) && can_be_revived())
		if(shock_damage * siemens_coeff >= 1 && prob(25))
			revive(FALSE, FALSE)
	//WS - END
	electrocution_animation(40)

/mob/living/carbon/human/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_CONTENTS)
		return
	var/informed = FALSE
	var/obj/item/bodypart/body_part
	for(var/zone in bodyparts)
		body_part = bodyparts[zone]
		if(!body_part)
			continue
		if(!IS_ORGANIC_LIMB(body_part))
			if(!informed && !HAS_TRAIT(src, TRAIT_ANALGESIA))
				to_chat(src, span_userdanger("You feel a sharp pain as your robotic limbs overload."))
				informed = TRUE
			switch(severity)
				if(1)
					body_part.receive_damage(0,5,5)
					Paralyze(2 SECONDS)
				if(2)
					body_part.receive_damage(0,1,5)
					Knockdown(2 SECONDS)
			if(HAS_TRAIT(body_part, TRAIT_EASYDISMEMBER) && zone != BODY_ZONE_CHEST)
				if(prob(20))
					body_part.dismember(BRUTE)

/mob/living/carbon/human/acid_act(acidpwr, acid_volume, bodyzone_hit) //todo: update this to utilize check_obscured_slots() //and make sure it's check_obscured_slots(TRUE) to stop aciding through visors etc
	var/list/damaged = list()
	var/list/inventory_items_to_kill = list()
	var/acidity = acidpwr * min(acid_volume*0.005, 0.1)
	//HEAD//
	if(!bodyzone_hit || bodyzone_hit == BODY_ZONE_HEAD) //only if we didn't specify a zone or if that zone is the head.
		var/obj/item/clothing/head_clothes = null
		if(glasses)
			head_clothes = glasses
		if(wear_mask)
			head_clothes = wear_mask
		if(wear_neck)
			head_clothes = wear_neck
		if(head)
			head_clothes = head
		if(head_clothes)
			if(!(head_clothes.resistance_flags & UNACIDABLE))
				head_clothes.acid_act(acidpwr, acid_volume)
				update_inv_glasses()
				update_inv_wear_mask()
				update_inv_neck()
				update_inv_head()
			else
				to_chat(src, span_notice("Your [head_clothes.name] protects your head and face from the acid!"))
		else
			. = get_bodypart(BODY_ZONE_HEAD)
			if(.)
				damaged += .
			if(ears)
				inventory_items_to_kill += ears

	//CHEST//
	if(!bodyzone_hit || bodyzone_hit == BODY_ZONE_CHEST)
		var/obj/item/clothing/chest_clothes = null
		if(w_uniform)
			chest_clothes = w_uniform
		if(wear_suit)
			chest_clothes = wear_suit
		if(chest_clothes)
			if(!(chest_clothes.resistance_flags & UNACIDABLE))
				chest_clothes.acid_act(acidpwr, acid_volume)
				update_inv_w_uniform()
				update_inv_wear_suit()
			else
				to_chat(src, span_notice("Your [chest_clothes.name] protects your body from the acid!"))
		else
			. = get_bodypart(BODY_ZONE_CHEST)
			if(.)
				damaged += .
			if(wear_id)
				inventory_items_to_kill += wear_id
			if(r_store)
				inventory_items_to_kill += r_store
			if(l_store)
				inventory_items_to_kill += l_store
			if(s_store)
				inventory_items_to_kill += s_store


	//ARMS & HANDS//
	if(!bodyzone_hit || bodyzone_hit == BODY_ZONE_L_ARM || bodyzone_hit == BODY_ZONE_R_ARM)
		var/obj/item/clothing/arm_clothes = null
		if(gloves)
			arm_clothes = gloves
		if(w_uniform && ((w_uniform.body_parts_covered & HANDS) || (w_uniform.body_parts_covered & ARMS)))
			arm_clothes = w_uniform
		if(wear_suit && ((wear_suit.body_parts_covered & HANDS) || (wear_suit.body_parts_covered & ARMS)))
			arm_clothes = wear_suit

		if(arm_clothes)
			if(!(arm_clothes.resistance_flags & UNACIDABLE))
				arm_clothes.acid_act(acidpwr, acid_volume)
				update_inv_gloves()
				update_inv_w_uniform()
				update_inv_wear_suit()
			else
				to_chat(src, span_notice("Your [arm_clothes.name] protects your arms and hands from the acid!"))
		else
			. = get_bodypart(BODY_ZONE_R_ARM)
			if(.)
				damaged += .
			. = get_bodypart(BODY_ZONE_L_ARM)
			if(.)
				damaged += .


	//LEGS & FEET//
	if(!bodyzone_hit || bodyzone_hit == BODY_ZONE_L_LEG || bodyzone_hit == BODY_ZONE_R_LEG || bodyzone_hit == "feet")
		var/obj/item/clothing/leg_clothes = null
		if(shoes)
			leg_clothes = shoes
		if(w_uniform && ((w_uniform.body_parts_covered & FEET) || (bodyzone_hit != "feet" && (w_uniform.body_parts_covered & LEGS))))
			leg_clothes = w_uniform
		if(wear_suit && ((wear_suit.body_parts_covered & FEET) || (bodyzone_hit != "feet" && (wear_suit.body_parts_covered & LEGS))))
			leg_clothes = wear_suit
		if(leg_clothes)
			if(!(leg_clothes.resistance_flags & UNACIDABLE))
				leg_clothes.acid_act(acidpwr, acid_volume)
				update_inv_shoes()
				update_inv_w_uniform()
				update_inv_wear_suit()
			else
				to_chat(src, span_notice("Your [leg_clothes.name] protects your legs and feet from the acid!"))
		else
			. = get_bodypart(BODY_ZONE_R_LEG)
			if(.)
				damaged += .
			. = get_bodypart(BODY_ZONE_L_LEG)
			if(.)
				damaged += .


	//DAMAGE//
	for(var/obj/item/bodypart/affecting in damaged)
		affecting.receive_damage(acidity, 2*acidity)

		if(affecting.name == BODY_ZONE_HEAD)
			if(prob(min(acidpwr*acid_volume/10, 90))) //Applies disfigurement
				affecting.receive_damage(acidity, 2*acidity)
				force_scream()
				facial_hairstyle = "Shaved"
				hairstyle = "Bald"
				update_hair()
				ADD_TRAIT(src, TRAIT_DISFIGURED, TRAIT_GENERIC)

		update_damage_overlays()

	//MELTING INVENTORY ITEMS//
	//these items are all outside of armour visually, so melt regardless.
	if(!bodyzone_hit)
		if(back)
			inventory_items_to_kill += back
		if(belt)
			inventory_items_to_kill += belt

		inventory_items_to_kill += held_items

	for(var/obj/item/I in inventory_items_to_kill)
		I.acid_act(acidpwr, acid_volume)
	return 1

///Overrides the point value that the mob is worth
/mob/living/carbon/human/singularity_act()
	. = 20
	if(mind)
		if((mind.assigned_role == "Station Engineer") || (mind.assigned_role == "Chief Engineer") )
			. = 100
	..() //Called afterwards because getting the mind after getting gibbed is sketchy

/mob/living/carbon/human/help_shake_act(mob/living/carbon/M)
	if(!istype(M))
		return

	if(src == M)
		check_self_for_injuries()

	else
		if(wear_suit)
			wear_suit.add_fingerprint(M)
		else if(w_uniform)
			w_uniform.add_fingerprint(M)

		..()

/mob/living/carbon/human/check_self_for_injuries()
	if(stat >= UNCONSCIOUS)
		return
	var/list/combined_msg = list()

	visible_message(span_notice("[src] examines [p_them()]self."))

	combined_msg += span_notice("<b>You check yourself for injuries.</b>")

	var/list/missing = list()

	var/obj/item/bodypart/body_part
	for(var/zone in bodyparts)
		body_part = bodyparts[zone]
		if(!body_part)
			missing += zone
			continue
		if(body_part.is_pseudopart) //don't show injury text for fake bodyparts; ie chainsaw arms or synthetic armblades
			continue
		var/self_aware = FALSE
		if(HAS_TRAIT(src, TRAIT_SELF_AWARE))
			self_aware = TRUE
		var/limb_max_damage = body_part.max_damage
		var/status = ""
		var/brutedamage = body_part.brute_dam
		var/burndamage = body_part.burn_dam
		if(hallucination)
			if(prob(30))
				brutedamage += rand(30,40)
			if(prob(30))
				burndamage += rand(30,40)

		if(HAS_TRAIT(src, TRAIT_SELF_AWARE))
			status = "[brutedamage] brute damage and [burndamage] burn damage"
			if(!brutedamage && !burndamage)
				status = "no damage"

		else
			if(brutedamage > 0)
				status = body_part.light_brute_msg
			if(brutedamage > (limb_max_damage*0.4))
				status = body_part.medium_brute_msg
			if(brutedamage > (limb_max_damage*0.8))
				status = body_part.heavy_brute_msg
			if(brutedamage > 0 && burndamage > 0)
				status += " and "

			if(burndamage > (limb_max_damage*0.8))
				status += body_part.heavy_burn_msg
			else if(burndamage > (limb_max_damage*0.2))
				status += body_part.medium_burn_msg
			else if(burndamage > 0)
				status += body_part.light_burn_msg

			if(status == "")
				status = "OK"
		var/no_damage
		if(status == "OK" || status == "no damage")
			no_damage = TRUE
		var/isdisabled = ""
		if(body_part.bodypart_disabled)
			isdisabled = " is disabled"
			if(no_damage)
				isdisabled += " but otherwise"
			else
				isdisabled += " and"
		combined_msg += "\t <span class='[no_damage ? "notice" : "warning"]'>Your [body_part.name][isdisabled][self_aware ? " has " : " is "][status].</span>"

		for(var/thing in body_part.wounds)
			var/datum/wound/W = thing
			var/msg
			switch(W.severity)
				if(WOUND_SEVERITY_TRIVIAL)
					msg = "\t <span class='danger'>Your [body_part.name] is suffering [W.a_or_from] [W.get_topic_name(src)].</span>"
				if(WOUND_SEVERITY_MODERATE)
					msg = "\t <span class='warning'>Your [body_part.name] is suffering [W.a_or_from] [W.get_topic_name(src)]!</span>"
				if(WOUND_SEVERITY_SEVERE)
					msg = "\t <span class='warning'><b>Your [body_part.name] is suffering [W.a_or_from] [W.get_topic_name(src)]!</b></span>"
				if(WOUND_SEVERITY_CRITICAL)
					msg = "\t <span class='warning'><b>Your [body_part.name] is suffering [W.a_or_from] [W.get_topic_name(src)]!!</b></span>"
			combined_msg += msg

		if(body_part.current_gauze)
			var/datum/bodypart_aid/current_gauze = body_part.current_gauze
			combined_msg += "\t <span class='notice'>Your [body_part.name] is [current_gauze.desc_prefix] with <a href='?src=[REF(current_gauze)];remove=1'>[current_gauze.get_description()]</a>.</span>"
		if(body_part.current_splint)
			var/datum/bodypart_aid/current_splint = body_part.current_splint
			combined_msg += "\t <span class='notice'>Your [body_part.name] is [current_splint.desc_prefix] with <a href='?src=[REF(current_splint)];remove=1'>[current_splint.get_description()]</a>.</span>"

		for(var/obj/item/I in body_part.embedded_objects)
			if(I.isEmbedHarmless())
				combined_msg += "\t <a href='byond://?src=[REF(src)];embedded_object=[REF(I)];embedded_limb=[REF(body_part)]' class='warning'>There is \a [I] stuck to your [body_part.name]!</a>"
			else
				combined_msg += "\t <a href='byond://?src=[REF(src)];embedded_object=[REF(I)];embedded_limb=[REF(body_part)]' class='warning'>There is \a [I] embedded in your [body_part.name]!</a>"

	for(var/t in missing)
		combined_msg += span_boldannounce("Your [parse_zone(t)] is missing!</span>")

	if(is_bleeding())
		var/list/obj/item/bodypart/bleeding_limbs = list()
		for(var/zone in bodyparts)
			body_part = bodyparts[zone]
			if(!body_part)
				continue
			if(body_part.get_part_bleed_rate())
				bleeding_limbs += body_part

		var/num_bleeds = LAZYLEN(bleeding_limbs)
		var/bleed_text = "<span class='danger'>You are bleeding from your"
		switch(num_bleeds)
			if(1 to 2)
				bleed_text += " [bleeding_limbs[1].name][num_bleeds == 2 ? " and [bleeding_limbs[2].name]" : ""]"
			if(3 to INFINITY)
				for(var/i in 1 to (num_bleeds - 1))
					var/obj/item/bodypart/BP = bleeding_limbs[i]
					bleed_text += " [BP.name],"
				bleed_text += " and [bleeding_limbs[num_bleeds].name]"
		bleed_text += "!</span>"
		to_chat(src, bleed_text)

	if(getStaminaLoss())
		if(getStaminaLoss() > 30)
			combined_msg += span_info("You're completely exhausted.")
		else
			combined_msg += span_info("You feel fatigued.")

	if(HAS_TRAIT(src, TRAIT_SELF_AWARE))
		if(toxloss)
			if(toxloss > 10)
				combined_msg += span_danger("You feel sick.")
			else if(toxloss > 20)
				combined_msg += span_danger("You feel nauseated.")
			else if(toxloss > 40)
				combined_msg += span_danger("You feel very unwell!")
		if(oxyloss)
			if(oxyloss > 10)
				combined_msg += span_danger("You feel lightheaded.")
			else if(oxyloss > 20)
				combined_msg += span_danger("Your thinking is clouded and distant.")
			else if(oxyloss > 30)
				combined_msg += span_danger("You're choking!")

	if(!HAS_TRAIT(src, TRAIT_NOHUNGER))
		switch(nutrition)
			if(NUTRITION_LEVEL_FULL to INFINITY)
				combined_msg += span_info("You're completely stuffed!")
			if(NUTRITION_LEVEL_WELL_FED to NUTRITION_LEVEL_FULL)
				combined_msg += span_info("You're well fed!")
			if(NUTRITION_LEVEL_FED to NUTRITION_LEVEL_WELL_FED)
				combined_msg += span_info("You're not hungry.")
			if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FED)
				combined_msg += span_info("You could use a bite to eat.")
			if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
				combined_msg += span_info("You feel quite hungry.")
			if(0 to NUTRITION_LEVEL_STARVING)
				combined_msg += span_danger("You're starving!")

	//Compiles then shows the list of damaged organs and broken organs
	var/list/broken = list()
	var/list/damaged = list()
	var/broken_message
	var/damaged_message
	var/broken_plural
	var/damaged_plural
	//Sets organs into their proper list
	for(var/O in internal_organs)
		var/obj/item/organ/organ = O
		if(organ.organ_flags & ORGAN_FAILING)
			if(broken.len)
				broken += ", "
			broken += organ.name
		else if(organ.damage > organ.low_threshold)
			if(damaged.len)
				damaged += ", "
			damaged += organ.name
	//Checks to enforce proper grammar, inserts words as necessary into the list
	if(broken.len)
		if(broken.len > 1)
			broken.Insert(broken.len, "and ")
			broken_plural = TRUE
		else
			var/holder = broken[1]	//our one and only element
			if(holder[length(holder)] == "s")
				broken_plural = TRUE
		//Put the items in that list into a string of text
		for(var/B in broken)
			broken_message += B
		combined_msg += span_warning("Your [broken_message] [broken_plural ? "are" : "is"] non-functional!")
	if(damaged.len)
		if(damaged.len > 1)
			damaged.Insert(damaged.len, "and ")
			damaged_plural = TRUE
		else
			var/holder = damaged[1]
			if(holder[length(holder)] == "s")
				damaged_plural = TRUE
		for(var/D in damaged)
			damaged_message += D
		combined_msg += span_info("Your [damaged_message] [damaged_plural ? "are" : "is"] hurt.")

	if(roundstart_quirks.len)
		combined_msg += span_notice("You have these quirks: [get_trait_string(see_all=TRUE)].")

	to_chat(src, boxed_message(combined_msg.Join("\n")))

/mob/living/carbon/human/damage_clothes(damage_amount, damage_type = BRUTE, damage_flag = 0, def_zone)
	if(damage_type != BRUTE && damage_type != BURN)
		return
	damage_amount *= 0.5 //0.5 multiplier for balance reason, we don't want clothes to be too easily destroyed
	var/list/torn_items = list()

	//HEAD//
	if(!def_zone || def_zone == BODY_ZONE_HEAD)
		var/obj/item/clothing/head_clothes = null
		if(glasses)
			head_clothes = glasses
		if(wear_mask)
			head_clothes = wear_mask
		if(wear_neck)
			head_clothes = wear_neck
		if(head)
			head_clothes = head
		if(head_clothes)
			torn_items += head_clothes
		else if(ears)
			torn_items += ears

	//CHEST//
	if(!def_zone || def_zone == BODY_ZONE_CHEST)
		var/obj/item/clothing/chest_clothes = null
		if(w_uniform)
			chest_clothes = w_uniform
		if(wear_suit)
			chest_clothes = wear_suit
		if(chest_clothes)
			torn_items += chest_clothes

	//ARMS & HANDS//
	if(!def_zone || def_zone == BODY_ZONE_L_ARM || def_zone == BODY_ZONE_R_ARM)
		var/obj/item/clothing/arm_clothes = null
		if(gloves)
			arm_clothes = gloves
		if(w_uniform && ((w_uniform.body_parts_covered & HANDS) || (w_uniform.body_parts_covered & ARMS)))
			arm_clothes = w_uniform
		if(wear_suit && ((wear_suit.body_parts_covered & HANDS) || (wear_suit.body_parts_covered & ARMS)))
			arm_clothes = wear_suit
		if(arm_clothes)
			torn_items |= arm_clothes

	//LEGS & FEET//
	if(!def_zone || def_zone == BODY_ZONE_L_LEG || def_zone == BODY_ZONE_R_LEG)
		var/obj/item/clothing/leg_clothes = null
		if(shoes)
			leg_clothes = shoes
		if(w_uniform && ((w_uniform.body_parts_covered & FEET) || (w_uniform.body_parts_covered & LEGS)))
			leg_clothes = w_uniform
		if(wear_suit && ((wear_suit.body_parts_covered & FEET) || (wear_suit.body_parts_covered & LEGS)))
			leg_clothes = wear_suit
		if(leg_clothes)
			torn_items |= leg_clothes

	for(var/obj/item/I in torn_items)
		I.take_damage(damage_amount, damage_type, damage_flag, 0)

/**
 * Used by fire code to damage worn items.
 *
 * Arguments:
 * - delta_time
 * - times_fired
 * - stacks: Current amount of firestacks
 *
 */

/mob/living/carbon/human/proc/burn_clothing(delta_time, times_fired, stacks)
	var/list/burning_items = list()
	var/obscured = check_obscured_slots(TRUE)
	//HEAD//

	if(glasses && !(obscured & ITEM_SLOT_EYES))
		burning_items += glasses
	if(wear_mask && !(obscured & ITEM_SLOT_MASK))
		burning_items += wear_mask
	if(wear_neck && !(obscured & ITEM_SLOT_NECK))
		burning_items += wear_neck
	if(ears && !(obscured & ITEM_SLOT_EARS))
		burning_items += ears
	if(head)
		burning_items += head

	//CHEST//
	if(w_uniform && !(obscured & ITEM_SLOT_ICLOTHING))
		burning_items += w_uniform
	if(wear_suit)
		burning_items += wear_suit

	//ARMS & HANDS//
	var/obj/item/clothing/arm_clothes = null
	if(gloves && !(obscured & ITEM_SLOT_GLOVES))
		arm_clothes = gloves
	else if(wear_suit && ((wear_suit.body_parts_covered & HANDS) || (wear_suit.body_parts_covered & ARMS)))
		arm_clothes = wear_suit
	else if(w_uniform && ((w_uniform.body_parts_covered & HANDS) || (w_uniform.body_parts_covered & ARMS)))
		arm_clothes = w_uniform
	if(arm_clothes)
		burning_items |= arm_clothes

	//LEGS & FEET//
	var/obj/item/clothing/leg_clothes = null
	if(shoes && !(obscured & ITEM_SLOT_FEET))
		leg_clothes = shoes
	else if(wear_suit && ((wear_suit.body_parts_covered & FEET) || (wear_suit.body_parts_covered & LEGS)))
		leg_clothes = wear_suit
	else if(w_uniform && ((w_uniform.body_parts_covered & FEET) || (w_uniform.body_parts_covered & LEGS)))
		leg_clothes = w_uniform
	if(leg_clothes)
		burning_items |= leg_clothes

	for(var/obj/item/burning in burning_items)
		burning.fire_act((stacks * 25 * delta_time)) //damage taken is reduced to 2% of this value by fire_act()

/mob/living/carbon/get_fire_overlay(stacks, on_fire)
	var/fire_icon = "[dna?.species.fire_overlay || "human"]_[stacks > MOB_BIG_FIRE_STACK_THRESHOLD ? "big_fire" : "small_fire"]"

	if(!GLOB.fire_appearances[fire_icon])
		GLOB.fire_appearances[fire_icon] = mutable_appearance(
			'icons/mob/onfire.dmi',
			fire_icon,
			-HIGHEST_LAYER,
			appearance_flags = RESET_COLOR,
		)

	return GLOB.fire_appearances[fire_icon]

/mob/living/carbon/human/on_fire_stack(delta_time, times_fired, datum/status_effect/fire_handler/fire_stacks/fire_handler)
	SEND_SIGNAL(src, COMSIG_HUMAN_BURNING)
	burn_clothing(delta_time, times_fired, fire_handler.stacks)
	var/no_protection = FALSE
	if(dna && dna.species)
		no_protection = dna.species.handle_fire(src, delta_time, times_fired, no_protection)
	fire_handler.harm_human(delta_time, times_fired, no_protection)
