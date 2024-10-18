/mob/living/carbon/attackby(obj/item/W, mob/user, params)
	var/obj/item/bodypart/BP = get_bodypart(check_zone(user.zone_selected))
	var/has_painkillers = reagents.has_reagent(/datum/reagent/medicine/morphine, needs_metabolizing = TRUE)
	if(W.tool_behaviour == TOOL_WELDER && IS_ROBOTIC_LIMB(BP) && BP.brute_dam) //prioritize healing if we're synthetic
		return ..()
	if(user.a_intent != INTENT_HELP || !W.get_temperature() || !BP.can_bandage()) //this will also catch low damage synthetic welding
		return ..()
	. = TRUE
	var/heal_time = 2 SECONDS
	playsound(user, 'sound/surgery/cautery1.ogg', 20)
	balloon_alert(user, "cauterizing...")
	if(src == user && !has_painkillers)
		heal_time *= 2 //oof ouch owie
	user.visible_message(span_nicegreen("[user] holds [W] up to [user == src ? "their" : "[src]'s"] [parse_zone(BP.body_zone)], trying to slow [p_their()] bleeding..."), span_nicegreen("You hold [W] up to [user == src ? "your" : "[src]'s"] [parse_zone(BP.body_zone)], trying to slow [user == src ? "your" : p_their()] bleeding..."))
	if(do_after(user, heal_time, target = src))
		playsound(user, 'sound/surgery/cautery2.ogg', 20)
		BP.apply_bandage(0.005, W.get_temperature()/BLOOD_CAUTERIZATION_RATIO, "cauterization") //not particularly fast, this is the "I really would prefer not to be bleeding right now" option
		BP.receive_damage(burn = W.get_temperature()/BLOOD_CAUTERIZATION_DAMAGE_RATIO) //my body is a MACHINE that turns BLEEDING into BURN DAMAGE
		user.visible_message(span_nicegreen("[user] cauterizes the bleeding on [user == src ? "their" : "[src]'s"] [parse_zone(BP.body_zone)]!"), span_nicegreen("You cauterize the bleeding on [user == src ? "your" : "[src]'s"] [parse_zone(BP.body_zone)]!"))
	else
		to_chat(user, span_warning("You were interrupted!"))

/mob/living/carbon/get_eye_protection()
	. = ..()
	var/obj/item/organ/eyes/E = getorganslot(ORGAN_SLOT_EYES)
	if(!E)
		return INFINITY //Can't get flashed without eyes
	else
		. += E.flash_protect
	if(isclothing(head)) //Adds head protection
		. += head.flash_protect
	if(isclothing(glasses)) //Glasses
		. += glasses.flash_protect
	if(isclothing(wear_mask)) //Mask
		. += wear_mask.flash_protect

/mob/living/carbon/get_ear_protection()
	. = ..()
	var/obj/item/organ/ears/E = getorganslot(ORGAN_SLOT_EARS)
	if(!E)
		return INFINITY
	else
		. += E.bang_protect

/mob/living/carbon/is_mouth_covered(head_only = 0, mask_only = 0)
	if((!mask_only && head && (head.flags_cover & HEADCOVERSMOUTH)) || (!head_only && wear_mask && (wear_mask.flags_cover & MASKCOVERSMOUTH)))
		return TRUE

/mob/living/carbon/is_eyes_covered(check_glasses = TRUE, check_head = TRUE, check_mask = TRUE)
	if(check_head && head && (head.flags_cover & HEADCOVERSEYES))
		return head
	if(check_mask && wear_mask && (wear_mask.flags_cover & MASKCOVERSEYES))
		return wear_mask
	if(check_glasses && glasses && (glasses.flags_cover & GLASSESCOVERSEYES))
		return glasses
/mob/living/carbon/is_pepper_proof(check_head = TRUE, check_mask = TRUE)
	if(check_head &&(head?.flags_cover & PEPPERPROOF))
		return head
	if(check_mask &&(wear_mask?.flags_cover & PEPPERPROOF))
		return wear_mask

/mob/living/carbon/check_projectile_dismemberment(obj/projectile/P, def_zone)
	var/obj/item/bodypart/affecting = get_bodypart(def_zone)
	if(affecting && affecting.dismemberable && affecting.get_damage() >= (affecting.max_damage - P.dismemberment))
		affecting.dismember(P.damtype)

/mob/living/carbon/proc/can_catch_item(skip_throw_mode_check)
	. = FALSE
	if(!skip_throw_mode_check && !throw_mode)
		return
	if(get_active_held_item())
		return
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		return
	return TRUE

/mob/living/carbon/hitby(atom/movable/AM, skipcatch, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	if(!skipcatch)	//ugly, but easy
		if(can_catch_item())
			if(istype(AM, /obj/item))
				var/obj/item/I = AM
				if(isturf(I.loc))
					I.attack_hand(src)
					if(get_active_held_item() == I) //if our attack_hand() picks up the item...
						visible_message("<span class='warning'>[src] catches [I]!</span>", \
										"<span class='userdanger'>You catch [I] in mid-air!</span>")
						throw_mode_off(THROW_MODE_TOGGLE)
						return 1
	..()


/mob/living/carbon/attacked_by(obj/item/I, mob/living/user)
	var/obj/item/bodypart/affecting
	if(user == src)
		affecting = get_bodypart(check_zone(user.zone_selected)) //we're self-mutilating! yay!
	else
		var/zone_hit_chance = 80
		if(body_position == LYING_DOWN) // half as likely to hit a different zone if they're on the ground
			zone_hit_chance += 10
		affecting = get_bodypart(ran_zone(user.zone_selected, zone_hit_chance))
	if(!affecting) //missing limb? we select the first bodypart (you can never have zero, because of chest)
		affecting = bodyparts[1]
	SEND_SIGNAL(I, COMSIG_ITEM_ATTACK_ZONE, src, user, affecting)
	send_item_attack_message(I, user, parse_zone(affecting.body_zone))
	if(I.force)
		apply_damage(I.force, I.damtype, affecting)
		if(I.damtype == BRUTE && (IS_ORGANIC_LIMB(affecting)))
			if(prob(33))
				I.add_mob_blood(src)
				var/turf/location = get_turf(src)
				add_splatter_floor(location)
				if(get_dist(user, src) <= 1)	//people with TK won't get smeared with blood
					user.add_mob_blood(src)
				if(affecting.body_zone == BODY_ZONE_HEAD)
					if(wear_mask)
						wear_mask.add_mob_blood(src)
						update_inv_wear_mask()
					if(wear_neck)
						wear_neck.add_mob_blood(src)
						update_inv_neck()
					if(head)
						head.add_mob_blood(src)
						update_inv_head()

		//dismemberment
		var/probability = I.get_dismemberment_chance(affecting)
		if(prob(probability))
			if(affecting.dismember(I.damtype))
				I.add_mob_blood(src)
				playsound(get_turf(src), I.get_dismember_sound(), 80, TRUE)
		return TRUE //successful attack

/mob/living/carbon/attack_drone(mob/living/simple_animal/drone/user)
	return //so we don't call the carbon's attack_hand().

//ATTACK HAND IGNORING PARENT RETURN VALUE
/mob/living/carbon/attack_hand(mob/living/carbon/human/user)

	for(var/datum/surgery/S in surgeries)
		if(body_position != LYING_DOWN && S.lying_required)
			continue
		if(!S.self_operable && user == src)
			continue
		if(S.next_step(user, user.a_intent))
			return TRUE

	for(var/thing in diseases)
		var/datum/disease/D = thing
		if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			user.ContactContractDisease(D)

	for(var/thing in user.diseases)
		var/datum/disease/D = thing
		if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			ContactContractDisease(D)

	return 0


/mob/living/carbon/attack_paw(mob/living/carbon/monkey/M)

	if(can_inject(M, TRUE))
		for(var/thing in diseases)
			var/datum/disease/D = thing
			if((D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN) && prob(85))
				M.ContactContractDisease(D)

	for(var/thing in M.diseases)
		var/datum/disease/D = thing
		if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			ContactContractDisease(D)

	if(M.a_intent == INTENT_HELP)
		help_shake_act(M)
		return 0

	if(..()) //successful monkey bite.
		for(var/thing in M.diseases)
			var/datum/disease/D = thing
			ForceContractDisease(D)
		return 1


/mob/living/carbon/attack_slime(mob/living/simple_animal/slime/M)
	if(..()) //successful slime attack
		if(M.powerlevel > 0)
			var/stunprob = M.powerlevel * 7 + 10  // 17 at level 1, 80 at level 10
			if(prob(stunprob))
				M.powerlevel -= 3
				if(M.powerlevel < 0)
					M.powerlevel = 0

				visible_message("<span class='danger'>The [M.name] shocks [src]!</span>", \
				"<span class='userdanger'>The [M.name] shocks you!</span>")

				do_sparks(5, TRUE, src)
				var/power = M.powerlevel + rand(0,3)
				Paralyze(power*20)
				if(stuttering < power)
					stuttering = power
				if (prob(stunprob) && M.powerlevel >= 8)
					adjustFireLoss(M.powerlevel * rand(6,10))
					updatehealth()
		return 1

/mob/living/carbon/proc/dismembering_strike(mob/living/attacker, dam_zone)
	if(!attacker.limb_destroyer)
		return dam_zone
	var/obj/item/bodypart/affecting
	if(dam_zone && attacker.client)
		affecting = get_bodypart(ran_zone(dam_zone))
	else
		var/list/things_to_ruin = shuffle(bodyparts.Copy())
		for(var/B in things_to_ruin)
			var/obj/item/bodypart/bodypart = B
			if(bodypart.body_zone == BODY_ZONE_HEAD || bodypart.body_zone == BODY_ZONE_CHEST)
				continue
			if(!affecting || ((affecting.get_damage() / affecting.max_damage) < (bodypart.get_damage() / bodypart.max_damage)))
				affecting = bodypart
	if(affecting)
		dam_zone = affecting.body_zone
		if(affecting.get_damage() >= affecting.max_damage)
			affecting.dismember()
			return null
		return affecting.body_zone
	return dam_zone


/**
 * Attempt to disarm the target mob.
 * Will shove the target mob back, and drop them if they're in front of something dense
 * or another carbon.
*/
/mob/living/carbon/proc/disarm(mob/living/carbon/target)
	do_attack_animation(target, ATTACK_EFFECT_DISARM)
	playsound(target, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)

	if (ishuman(target))
		var/mob/living/carbon/human/human_target = target
		human_target.w_uniform?.add_fingerprint(src)

	SEND_SIGNAL(target, COMSIG_HUMAN_DISARM_HIT, src, zone_selected)

	var/turf/target_oldturf = target.loc
	var/shove_dir = get_dir(loc, target_oldturf)
	var/turf/target_shove_turf = get_step(target.loc, shove_dir)
	var/mob/living/carbon/target_collateral_carbon
	var/obj/structure/table/target_table
	var/obj/machinery/disposal/bin/target_disposal_bin
	var/shove_blocked = FALSE //Used to check if a shove is blocked so that if it is knockdown logic can be applied

	//Thank you based whoneedsspace
	target_collateral_carbon = locate(/mob/living/carbon) in target_shove_turf.contents

	// If we can't shove the target into the carbon (such as if it's an alien), then just pretend nothing was there
	if (!target_collateral_carbon?.can_be_shoved_into)
		target_collateral_carbon = null

	if(target_collateral_carbon)
		shove_blocked = TRUE
	else
		target.Move(target_shove_turf, shove_dir)
		if(get_turf(target) == target_oldturf)
			target_table = locate(/obj/structure/table) in target_shove_turf.contents
			target_disposal_bin = locate(/obj/machinery/disposal/bin) in target_shove_turf.contents
			shove_blocked = TRUE

	if(target.IsKnockdown() && !target.IsParalyzed())
		target.Paralyze(SHOVE_CHAIN_PARALYZE)
		target.visible_message("<span class='danger'>[name] kicks [target.name] onto [target.p_their()] side!</span>",
						"<span class='userdanger'>You're kicked onto your side by [name]!</span>", "<span class='hear'>You hear aggressive shuffling followed by a loud thud!</span>", COMBAT_MESSAGE_RANGE, src)
		to_chat(src, "<span class='danger'>You kick [target.name] onto [target.p_their()] side!</span>")
		addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living, SetKnockdown), 0), SHOVE_CHAIN_PARALYZE)
		log_combat(src, target, "kicks", "onto their side (paralyzing)")

	if(shove_blocked && !target.is_shove_knockdown_blocked() && !target.buckled)
		var/directional_blocked = FALSE
		if(shove_dir in GLOB.cardinals) //Directional checks to make sure that we're not shoving through a windoor or something like that
			var/target_turf = get_turf(target)
			for(var/obj/obj_content in target_turf)
				if(obj_content.flags_1 & ON_BORDER_1 && obj_content.dir == shove_dir && obj_content.density)
					directional_blocked = TRUE
					break
			if(target_turf != target_shove_turf) //Make sure that we don't run the exact same check twice on the same tile
				for(var/obj/obj_content in target_shove_turf)
					if(obj_content.flags_1 & ON_BORDER_1 && obj_content.dir == turn(shove_dir, 180) && obj_content.density)
						directional_blocked = TRUE
						break
		if((!target_table && !target_collateral_carbon && !target_disposal_bin) || directional_blocked)
			target.Knockdown(SHOVE_KNOCKDOWN_SOLID)
			target.visible_message("<span class='danger'>[name] shoves [target.name], knocking [target.p_them()] down!</span>",
							"<span class='userdanger'>You're knocked down from a shove by [name]!</span>", "<span class='hear'>You hear aggressive shuffling followed by a loud thud!</span>", COMBAT_MESSAGE_RANGE, src)
			to_chat(src, "<span class='danger'>You shove [target.name], knocking [target.p_them()] down!</span>")
			log_combat(src, target, "shoved", "knocking them down")
		else if(target_table)
			target.Knockdown(SHOVE_KNOCKDOWN_TABLE)
			target.visible_message("<span class='danger'>[name] shoves [target.name] onto \the [target_table]!</span>",
							"<span class='userdanger'>You're shoved onto \the [target_table] by [name]!</span>", "<span class='hear'>You hear aggressive shuffling followed by a loud thud!</span>", COMBAT_MESSAGE_RANGE, src)
			to_chat(src, "<span class='danger'>You shove [target.name] onto \the [target_table]!</span>")
			target.throw_at(target_table, 1, 1, null, FALSE) //1 speed throws with no spin are basically just forcemoves with a hard collision check
			log_combat(src, target, "shoved", "onto [target_table] (table)")
		else if(target_collateral_carbon)
			target.Knockdown(SHOVE_KNOCKDOWN_HUMAN)
			target_collateral_carbon.Knockdown(SHOVE_KNOCKDOWN_COLLATERAL)
			target.visible_message("<span class='danger'>[name] shoves [target.name] into [target_collateral_carbon.name]!</span>",
				"<span class='userdanger'>You're shoved into [target_collateral_carbon.name] by [name]!</span>", "<span class='hear'>You hear aggressive shuffling followed by a loud thud!</span>", COMBAT_MESSAGE_RANGE, src)
			to_chat(src, "<span class='danger'>You shove [target.name] into [target_collateral_carbon.name]!</span>")
			log_combat(src, target, "shoved", "into [target_collateral_carbon.name]")
		else if(target_disposal_bin)
			target.Knockdown(SHOVE_KNOCKDOWN_SOLID)
			target.forceMove(target_disposal_bin)
			target.visible_message("<span class='danger'>[name] shoves [target.name] into \the [target_disposal_bin]!</span>",
							"<span class='userdanger'>You're shoved into \the [target_disposal_bin] by [target.name]!</span>", "<span class='hear'>You hear aggressive shuffling followed by a loud thud!</span>", COMBAT_MESSAGE_RANGE, src)
			to_chat(src, "<span class='danger'>You shove [target.name] into \the [target_disposal_bin]!</span>")
			log_combat(src, target, "shoved", "into [target_disposal_bin] (disposal bin)")
	else
		target.visible_message("<span class='danger'>[name] shoves [target.name]!</span>",
						"<span class='userdanger'>You're shoved by [name]!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", COMBAT_MESSAGE_RANGE, src)
		to_chat(src, "<span class='danger'>You shove [target.name]!</span>")
		var/target_held_item = target.get_active_held_item()
		var/knocked_item = FALSE
		if(!is_type_in_typecache(target_held_item, GLOB.shove_disarming_types))
			target_held_item = null
		if(!target.has_movespeed_modifier(/datum/movespeed_modifier/shove))
			target.add_movespeed_modifier(/datum/movespeed_modifier/shove)
			if(target_held_item)
				target.visible_message("<span class='danger'>[target.name]'s grip on \the [target_held_item] loosens!</span>",
					"<span class='warning'>Your grip on \the [target_held_item] loosens!</span>", null, COMBAT_MESSAGE_RANGE)
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon, clear_shove_slowdown)), SHOVE_SLOWDOWN_LENGTH)
		else if(target_held_item)
			target.dropItemToGround(target_held_item)
			knocked_item = TRUE
			target.visible_message("<span class='danger'>[target.name] drops \the [target_held_item]!</span>",
				"<span class='warning'>You drop \the [target_held_item]!</span>", null, COMBAT_MESSAGE_RANGE)
		var/append_message = ""
		if(target_held_item)
			if(knocked_item)
				append_message = "causing [target.p_them()] to drop [target_held_item]"
			else
				append_message = "loosening [target.p_their()] grip on [target_held_item]"
		log_combat(src, target, "shoved", append_message)

/mob/living/carbon/proc/is_shove_knockdown_blocked() //If you want to add more things that block shove knockdown, extend this
	for (var/obj/item/clothing/clothing in get_equipped_items())
		if(clothing.clothing_flags & BLOCKS_SHOVE_KNOCKDOWN)
			return TRUE
	return FALSE

/mob/living/carbon/proc/clear_shove_slowdown()
	remove_movespeed_modifier(/datum/movespeed_modifier/shove)
	var/active_item = get_active_held_item()
	if(is_type_in_typecache(active_item, GLOB.shove_disarming_types))
		visible_message("<span class='warning'>[name] regains their grip on \the [active_item]!</span>", "<span class='warning'>You regain your grip on \the [active_item]</span>", null, COMBAT_MESSAGE_RANGE)

/mob/living/carbon/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_CONTENTS)
		return
	for(var/X in internal_organs)
		var/obj/item/organ/O = X
		O.emp_act(severity)

///Adds to the parent by also adding functionality to propagate shocks through pulling and doing some fluff effects.
/mob/living/carbon/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	. = ..()
	if(!.)
		return
	//Propagation through pulling, fireman carry
	if(!(flags & SHOCK_ILLUSION))
		var/list/shocking_queue = list()
		if(iscarbon(pulling) && source != pulling)
			shocking_queue += pulling
		if(iscarbon(pulledby) && source != pulledby)
			shocking_queue += pulledby
		if(iscarbon(buckled) && source != buckled)
			shocking_queue += buckled
		for(var/mob/living/carbon/carried in buckled_mobs)
			if(source != carried)
				shocking_queue += carried
		//Found our victims, now lets shock them all
		for(var/victim in shocking_queue)
			var/mob/living/carbon/C = victim
			C.electrocute_act(shock_damage*0.75, src, 1, flags)
	//Stun
	var/should_stun = (!(flags & SHOCK_TESLA) || siemens_coeff > 0.5) && !(flags & SHOCK_NOSTUN)
	if(should_stun)
		Paralyze(40)
	//Jitter and other fluff.
	jitteriness += 1000
	do_jitter_animation(jitteriness)
	stuttering += 2
	addtimer(CALLBACK(src, PROC_REF(secondary_shock), should_stun), 20)
	return shock_damage

///Called slightly after electrocute act to reduce jittering and apply a secondary stun.
/mob/living/carbon/proc/secondary_shock(should_stun)
	jitteriness = max(jitteriness - 990, 10)
	if(should_stun)
		Paralyze(60)

/mob/living/carbon/proc/help_shake_act(mob/living/carbon/M)
	var/datum/component/mood/hugger_mood = M.GetComponent(/datum/component/mood)
	var/nosound = FALSE
	if(on_fire)
		to_chat(M, "<span class='warning'>You can't put [p_them()] out with just your bare hands!</span>")
		return

	if(M == src && check_self_for_injuries())
		return

	if(M.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		var/obj/item/clothing/mask/cigarette/theircig = wear_mask
		var/obj/item/clothing/mask/cigarette/ourcig = M.wear_mask
		if(istype(ourcig) && istype(theircig))
			if(ourcig.lit && !theircig.lit)
				theircig.light(span_notice("[M] leans towards [src], lighting [p_their()] [theircig.name] with [M.p_their()] own."))
				return

	if(body_position == LYING_DOWN)
		if(buckled)
			to_chat(M, "<span class='warning'>You need to unbuckle [src] first to do that!</span>")
			return
		M.visible_message("<span class='notice'>[M] shakes [src] trying to get [p_them()] up!</span>", \
						null, "<span class='hear'>You hear the rustling of clothes.</span>", DEFAULT_MESSAGE_RANGE, list(M, src))
		to_chat(M, "<span class='notice'>You shake [src] trying to pick [p_them()] up!</span>")
		to_chat(src, "<span class='notice'>[M] shakes you to get you up!</span>")
		if(istype(M.dna.species, /datum/species/moth)) //WS edit - moth dust from hugging
			mothdust += 10;
		if(istype(dna.species, /datum/species/moth))
			M.mothdust += 10; // End WS edit

	if(M.zone_selected == BODY_ZONE_PRECISE_MOUTH) // Nose boops!
		nosound = TRUE
		playsound(src, 'sound/effects/boop.ogg', 50, 0)
		if (HAS_TRAIT(M, TRAIT_FRIENDLY))
			M.visible_message(span_notice("[M] playfully boops your nose."), span_notice("You playfully boop [src]'s nose."))
			if (hugger_mood.sanity >= SANITY_GREAT)
				new /obj/effect/temp_visual/heart(loc)
				SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "best_boop", /datum/mood_event/best_boop, M)
		else
			M.visible_message(span_notice("[M] boops [src]'s nose."), span_notice("You boop [src] on the nose."))
		if(HAS_TRAIT(src, TRAIT_BADTOUCH))
			to_chat(M, span_warning("A scowl forms on [src]'s face as you daringly press your finger against [p_their()] nose."))
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "bad_boop", /datum/mood_event/bad_boop, M)


	else if(check_zone(M.zone_selected) == BODY_ZONE_HEAD) //Headpats!
		SEND_SIGNAL(src, COMSIG_CARBON_HEADPAT, M)
		M.visible_message("<span class='notice'>[M] gives [src] a pat on the head to make [p_them()] feel better!</span>", \
					null, "<span class='hear'>You hear a soft patter.</span>", DEFAULT_MESSAGE_RANGE, list(M, src))
		to_chat(M, "<span class='notice'>You give [src] a pat on the head to make [p_them()] feel better!</span>")
		to_chat(src, "<span class='notice'>[M] gives you a pat on the head to make you feel better! </span>")
		if(istype(M.dna.species, /datum/species/moth)) //WS edit - moth dust from hugging
			mothdust += 5;
		if(istype(dna.species, /datum/species/moth))
			M.mothdust += 5; // End WS edit

		if(HAS_TRAIT(src, TRAIT_BADTOUCH))
			to_chat(M, "<span class='warning'>[src] looks visibly upset as you pat [p_them()] on the head.</span>")

// Tail pulls!
	else if((M.zone_selected == BODY_ZONE_PRECISE_GROIN) && !isnull(src.getorgan(/obj/item/organ/tail)))
		M.visible_message(span_notice("[M] pulls on [src]'s tail!"), \
					null, span_hear("You hear a soft patter."), DEFAULT_MESSAGE_RANGE, list(M, src))
		to_chat(M, span_notice("You pull on [src]'s tail!"))
		to_chat(src, span_notice("[M] pulls on your tail!"))

// Rips off fake tails
	else if((M.zone_selected == BODY_ZONE_PRECISE_GROIN) && (istype(head, /obj/item/clothing/head/kitty) || istype(head, /obj/item/clothing/head/collectable/kitty)))
		var/obj/item/clothing/head/faketail = head
		M.visible_message(span_danger("[M] pulls on [src]'s tail... and it rips off!"), \
					null, span_hear("You hear a ripping sound."), DEFAULT_MESSAGE_RANGE, list(M, src))
		to_chat(M, span_danger("You pull on [src]'s tail... and it rips off!"))
		to_chat(src, span_userdanger("[M] pulls on your tail... and it rips off!"))
		playsound(loc, 'sound/effects/rip1.ogg', 75, TRUE)
		dropItemToGround(faketail)
		M.put_in_hands(faketail)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "rippedtail", /datum/mood_event/rippedtail)

	else if(M.zone_selected == BODY_ZONE_CHEST || M.zone_selected == BODY_ZONE_PRECISE_GROIN)			//WS Edit - Adds more help emotes
		SEND_SIGNAL(src, COMSIG_CARBON_HUGGED, M)
		SEND_SIGNAL(M, COMSIG_CARBON_HUG, M, src)
		if (M.grab_state >= GRAB_AGGRESSIVE)
			M.visible_message(span_notice("[M] embraces [src] in a tight bear hug!"), \
						null, span_hear("You hear the rustling of clothes."), DEFAULT_MESSAGE_RANGE, list(M, src))
			to_chat(M, span_notice("You wrap [src] into a tight bear hug!"))
			to_chat(src, span_notice("[M] squeezes you super tightly in a firm bear hug!"))
		else
			M.visible_message("<span class='notice'>[M] hugs [src] to make [p_them()] feel better!</span>", \
					"<span class='notice'>You hug [src] to make [p_them()] feel better!</span>")
		if(istype(M.dna.species, /datum/species/moth)) //WS edit - moth dust from hugging
			mothdust += 15;
		if(istype(dna.species, /datum/species/moth))
			M.mothdust += 15; // End WS edit

		// Warm them up with hugs
		share_bodytemperature(M)

		// No moodlets for people who hate touches
		if(!HAS_TRAIT(src, TRAIT_BADTOUCH))
			if (M.grab_state >= GRAB_AGGRESSIVE)
				SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "hug", /datum/mood_event/bear_hug)
				if(bodytemperature > M.bodytemperature)
					if(!HAS_TRAIT(M, TRAIT_BADTOUCH))
						SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "hug", /datum/mood_event/warmhug) // Hugger got a warm hug (Unless they hate hugs)
					SEND_SIGNAL(M, "hug", /datum/mood_event/hug) // Receiver always gets a mood for being hugged
				else
					SEND_SIGNAL(M, "hug", /datum/mood_event/warmhug,) // You got a warm hug
		else
			if (M.grab_state >= GRAB_AGGRESSIVE)
				SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "hug", /datum/mood_event/bad_touch_bear_hug)

		// Let people know if they hugged someone really warm or really cold
		if(M.bodytemperature > M.dna.species.bodytemp_heat_damage_limit)
			to_chat(src, "<span class='warning'>It feels like [M] is over heating as they hug you.</span>")
		else if(M.bodytemperature < M.dna.species.bodytemp_cold_damage_limit)
			to_chat(src, "<span class='warning'>It feels like [M] is freezing as they hug you.</span>")

		if(bodytemperature > dna.species.bodytemp_heat_damage_limit)
			to_chat(M, "<span class='warning'>It feels like [src] is over heating as you hug them.</span>")
		else if(bodytemperature < dna.species.bodytemp_cold_damage_limit)
			to_chat(M, "<span class='warning'>It feels like [src] is freezing as you hug them.</span>")

		if(HAS_TRAIT(M, TRAIT_FRIENDLY))
			if (hugger_mood.sanity >= SANITY_GREAT)
				new /obj/effect/temp_visual/heart(loc)
				SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "friendly_hug", /datum/mood_event/besthug, M)
			else if (hugger_mood.sanity >= SANITY_DISTURBED)
				SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "friendly_hug", /datum/mood_event/betterhug, M)

		if(HAS_TRAIT(src, TRAIT_BADTOUCH))
			to_chat(M, "<span class='warning'>[src] looks visibly upset as you hug [p_them()].</span>")

	else if((M.zone_selected == BODY_ZONE_L_ARM) || (M.zone_selected == BODY_ZONE_R_ARM))
		if(!get_bodypart(check_zone(M.zone_selected)))
			to_chat(M, "<span class='warning'>[src] does not have a [M.zone_selected == BODY_ZONE_L_ARM ? "left" : "right"] arm!</span>")
		else
			M.visible_message("<span class='notice'>[M] shakes [src]'s hand.</span>", \
						"<span class='notice'>You shake [src]'s hand.</span>")
	else if((M.zone_selected == BODY_ZONE_L_LEG) || (M.zone_selected == BODY_ZONE_R_LEG))
		if(!get_bodypart(check_zone(M.zone_selected)))
			to_chat(M, "<span class='warning'>[src] does not have a [M.zone_selected == BODY_ZONE_L_LEG ? "left" : "right"] leg!</span>")
		else
			M.visible_message("<span class='notice'>[M] pokes [src]'s leg.</span>", \
						"<span class='notice'>You poke [src]'s leg.</span>")		//WS Edit End
	AdjustStun(-60)
	AdjustKnockdown(-60)
	AdjustUnconscious(-60)
	AdjustSleeping(-100)
	AdjustParalyzed(-60)
	AdjustImmobilized(-60)
	set_resting(FALSE)
	if(!nosound)
		playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)

// Shake animation
#define SHAKE_ANIMATION_OFFSET (4)
	if (incapacitated())
		var/direction = prob(50) ? -1 : 1
		animate(src, pixel_x = pixel_x + SHAKE_ANIMATION_OFFSET * direction, time = 1, easing = QUAD_EASING | EASE_OUT, flags = ANIMATION_PARALLEL)
		animate(pixel_x = pixel_x - (SHAKE_ANIMATION_OFFSET * 2 * direction), time = 1)
		animate(pixel_x = pixel_x + SHAKE_ANIMATION_OFFSET * direction, time = 1, easing = QUAD_EASING | EASE_IN)
#undef SHAKE_ANIMATION_OFFSET

/// Check ourselves to see if we've got any shrapnel, return true if we do. This is a much simpler version of what humans do, we only indicate we're checking ourselves if there's actually shrapnel
/mob/living/carbon/proc/check_self_for_injuries()
	if(stat >= UNCONSCIOUS)
		return

	var/embeds = FALSE
	for(var/obj/item/bodypart/LB as anything in bodyparts)
		for(var/obj/item/I in LB.embedded_objects)
			if(!embeds)
				embeds = TRUE
				// this way, we only visibly try to examine ourselves if we have something embedded, otherwise we'll still hug ourselves :)
				visible_message("<span class='notice'>[src] examines [p_them()]self.</span>", \
					"<span class='notice'>You check yourself for shrapnel.</span>")
			if(I.isEmbedHarmless())
				to_chat(src, "\t <a href='?src=[REF(src)];embedded_object=[REF(I)];embedded_limb=[REF(LB)]' class='warning'>There is \a [I] stuck to your [LB.name]!</a>")
			else
				to_chat(src, "\t <a href='?src=[REF(src)];embedded_object=[REF(I)];embedded_limb=[REF(LB)]' class='warning'>There is \a [I] embedded in your [LB.name]!</a>")

	return embeds


/mob/living/carbon/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0)
	var/obj/item/organ/eyes/eyes = getorganslot(ORGAN_SLOT_EYES)
	if(!eyes) //can't flash what can't see!
		return

	. = ..()

	var/damage = intensity - get_eye_protection()
	if(.) // we've been flashed
		if(visual)
			return

		if (damage == 1)
			to_chat(src, "<span class='warning'>Your eyes sting a little.</span>")
			if(prob(40))
				eyes.applyOrganDamage(1)

		else if (damage == 2)
			to_chat(src, "<span class='warning'>Your eyes burn.</span>")
			eyes.applyOrganDamage(rand(2, 4))

		else if(damage >= 3)
			to_chat(src, "<span class='warning'>Your eyes itch and burn severely!</span>")
			eyes.applyOrganDamage(rand(12, 16))

		if(eyes.damage > 10)
			blind_eyes(damage)
			blur_eyes(damage * rand(3, 6))

			if(eyes.damage > 20)
				if(prob(eyes.damage - 20))
					if(!HAS_TRAIT(src, TRAIT_NEARSIGHT))
						to_chat(src, "<span class='warning'>Your eyes start to burn badly!</span>")
					become_nearsighted(EYE_DAMAGE)

				else if(prob(eyes.damage - 25))
					if(!is_blind())
						to_chat(src, "<span class='warning'>You can't see anything!</span>")
					eyes.applyOrganDamage(eyes.maxHealth)

			else
				to_chat(src, "<span class='warning'>Your eyes are really starting to hurt. This can't be good for you!</span>")
		return 1
	else if(damage == 0) // just enough protection
		if(prob(20))
			to_chat(src, "<span class='notice'>Something bright flashes in the corner of your vision!</span>")


/mob/living/carbon/soundbang_act(intensity = 1, stun_pwr = 20, damage_pwr = 5, deafen_pwr = 15)
	var/list/reflist = list(intensity) // Need to wrap this in a list so we can pass a reference
	SEND_SIGNAL(src, COMSIG_CARBON_SOUNDBANG, reflist)
	intensity = reflist[1]
	var/ear_safety = get_ear_protection()
	var/obj/item/organ/ears/ears = getorganslot(ORGAN_SLOT_EARS)
	var/effect_amount = intensity - ear_safety
	if(effect_amount > 0)
		if(stun_pwr)
			Paralyze((stun_pwr*effect_amount)*0.1)
			Knockdown(stun_pwr*effect_amount)

		if(istype(ears) && (deafen_pwr || damage_pwr))
			var/ear_damage = damage_pwr * effect_amount
			var/deaf = deafen_pwr * effect_amount
			adjustEarDamage(ear_damage,deaf)

			if(ears.damage >= 15)
				to_chat(src, "<span class='warning'>Your ears start to ring badly!</span>")
				if(prob(ears.damage - 5))
					to_chat(src, "<span class='userdanger'>You can't hear anything!</span>")
					ears.damage = min(ears.damage, ears.maxHealth)
					// you need earmuffs, inacusiate, or replacement
			else if(ears.damage >= 5)
				to_chat(src, "<span class='warning'>Your ears start to ring!</span>")
			SEND_SOUND(src, sound('sound/weapons/flash_ring.ogg',0,1,0,250))
		return effect_amount //how soundbanged we are


/mob/living/carbon/damage_clothes(damage_amount, damage_type = BRUTE, damage_flag = 0, def_zone)
	if(damage_type != BRUTE && damage_type != BURN)
		return
	damage_amount *= 0.5 //0.5 multiplier for balance reason, we don't want clothes to be too easily destroyed
	if(!def_zone || def_zone == BODY_ZONE_HEAD)
		var/obj/item/clothing/hit_clothes
		if(wear_mask)
			hit_clothes = wear_mask
		if(wear_neck)
			hit_clothes = wear_neck
		if(head)
			hit_clothes = head
		if(hit_clothes)
			hit_clothes.take_damage(damage_amount, damage_type, damage_flag, 0)

/mob/living/carbon/can_hear()
	. = FALSE
	var/obj/item/organ/ears/ears = getorganslot(ORGAN_SLOT_EARS)
	if(istype(ears) && !ears.deaf)
		. = TRUE


/mob/living/carbon/adjustOxyLoss(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(isnull(.))
		return
	if(. <= 50)
		if(getOxyLoss() > 50)
			ADD_TRAIT(src, TRAIT_KNOCKEDOUT, OXYLOSS_TRAIT)
	else if(getOxyLoss() <= 50)
		REMOVE_TRAIT(src, TRAIT_KNOCKEDOUT, OXYLOSS_TRAIT)


/mob/living/carbon/setOxyLoss(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(isnull(.))
		return
	if(. <= 50)
		if(getOxyLoss() > 50)
			ADD_TRAIT(src, TRAIT_KNOCKEDOUT, OXYLOSS_TRAIT)
	else if(getOxyLoss() <= 50)
		REMOVE_TRAIT(src, TRAIT_KNOCKEDOUT, OXYLOSS_TRAIT)

/mob/living/carbon/bullet_act(obj/projectile/P, def_zone, piercing_hit = FALSE)
	var/armor = run_armor_check(def_zone, P.flag, P.armour_penetration, silent = TRUE)
	var/on_hit_state = P.on_hit(src, armor, piercing_hit)
	if(!P.nodamage && on_hit_state != BULLET_ACT_BLOCK && !QDELETED(src)) //QDELETED literally just for the instagib rifle. Yeah.
		apply_damage(P.damage, P.damage_type, def_zone, armor, sharpness = TRUE)
		if(P.damage-armor >= 15 && P.damage_type == BRUTE && (!armor || prob(40) || P.damage-armor >= 25))
			spray_blood(get_dir(P.starting,src), (P.damage-armor)/5)
			bleed((P.damage-armor)/2)

		recoil_camera(src, clamp((P.damage-armor)/4,0.5,10), clamp((P.damage-armor)/4,0.5,10), P.damage/8, P.Angle)
		apply_effects(P.stun, P.knockdown, P.unconscious, P.irradiate, P.slur, P.stutter, P.eyeblur, P.drowsy, armor, P.stamina, P.jitter, P.paralyze, P.immobilize)
		if(P.dismemberment)
			check_projectile_dismemberment(P, def_zone)
	return on_hit_state ? BULLET_ACT_HIT : BULLET_ACT_BLOCK
