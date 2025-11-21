/mob/living/carbon/Initialize()
	. = ..()
	create_reagents(1000)
	// assign_bodypart_ownership()
	update_body_parts() //to update the carbon's new bodyparts appearance
	GLOB.carbon_list += src

/mob/living/carbon/Destroy()
	//This must be done first, so the mob ghosts correctly before DNA etc is nulled
	. =  ..()

	QDEL_LIST(hand_bodyparts)
	QDEL_LIST(internal_organs)
	internal_organs_slot.Cut()
	QDEL_LIST_ASSOC_VAL(bodyparts)
	QDEL_LIST(implants)
	for(var/wound in all_wounds) // these LAZYREMOVE themselves when deleted so no need to remove the list here
		qdel(wound)
	remove_from_all_data_huds()
	QDEL_NULL(dna)
	GLOB.carbon_list -= src

/mob/living/carbon/swap_hand(held_index)
	. = ..()
	if(!.)
		var/obj/item/held_item = get_active_held_item()
		to_chat(usr, span_warning("Your other hand is too busy holding [held_item]."))
		return

	if(!held_index)
		held_index = (active_hand_index % held_items.len)+1

	if(!isnum(held_index))
		CRASH("You passed [held_index] into swap_hand instead of a number. WTF man")

	var/oindex = active_hand_index
	active_hand_index = held_index
	if(hud_used)
		var/atom/movable/screen/inventory/hand/H
		H = hud_used.hand_slots["[oindex]"]
		if(H)
			H.update_appearance()
		H = hud_used.hand_slots["[held_index]"]
		if(H)
			H.update_appearance()


/mob/living/carbon/activate_hand(selhand) //l/r OR 1-held_items.len
	if(!selhand)
		selhand = (active_hand_index % held_items.len)+1

	if(istext(selhand))
		selhand = lowertext(selhand)
		if(selhand == "right" || selhand == "r")
			selhand = 2
		if(selhand == "left" || selhand == "l")
			selhand = 1

	if(selhand != active_hand_index)
		swap_hand(selhand)
	else
		mode() // Activate held item

/mob/living/carbon/attackby(obj/item/I, mob/user, params)
	if(!all_wounds || !(user.a_intent == INTENT_HELP || user == src))
		return ..()

	for(var/i in shuffle(all_wounds))
		var/datum/wound/W = i
		if(W.try_treating(I, user))
			return 1

	return ..()

/mob/living/carbon/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	var/hurt = TRUE
	var/extra_speed = 0

	if(throwingdatum.thrower != src)
		extra_speed = min(max(0, throwingdatum.speed - initial(throw_speed)), 3)

	if(istype(throwingdatum, /datum/thrownthing))
		hurt = !throwingdatum.gentle

	if(hit_atom.density && isturf(hit_atom))
		if(hurt)
			Paralyze(20)
			take_bodypart_damage(10 + 5 * extra_speed, check_armor = TRUE, wound_bonus = extra_speed * 5)

	if(iscarbon(hit_atom) && hit_atom != src)
		var/mob/living/carbon/victim = hit_atom
		if(victim.movement_type & FLYING)
			return
		if(hurt)
			victim.take_bodypart_damage(10 + 5 * extra_speed, check_armor = TRUE, wound_bonus = extra_speed * 5)
			take_bodypart_damage(10 + 5 * extra_speed, check_armor = TRUE, wound_bonus = extra_speed * 5)
			victim.Paralyze(20)
			Paralyze(20)
			visible_message(
				span_danger("[src] crashes into [victim] [extra_speed ? "really hard" : ""], knocking them both over!"),
				span_userdanger("You violently crash into [victim] [extra_speed ? "extra hard" : ""]!"),
			)
		playsound(src,'sound/weapons/punch1.ogg',50,TRUE)


//Throwing stuff
/mob/living/carbon/proc/toggle_throw_mode()
	if(stat)
		return
	if(throw_mode)
		throw_mode_off(THROW_MODE_TOGGLE)
	else
		throw_mode_on(THROW_MODE_TOGGLE)


/mob/living/carbon/proc/throw_mode_off(method)
	if(throw_mode > method) //A toggle doesnt affect a hold
		return
	throw_mode = THROW_MODE_DISABLED
	if(client && hud_used)
		hud_used.throw_icon.icon_state = "act_throw_off"


/mob/living/carbon/proc/throw_mode_on(mode = THROW_MODE_TOGGLE)
	throw_mode = mode
	if(client && hud_used)
		hud_used.throw_icon.icon_state = "act_throw_on"

/mob/proc/throw_item(atom/target)
	SEND_SIGNAL(src, COMSIG_MOB_THROW, target)
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_CARBON_THROW_THING, src, target)
	return

/mob/living/carbon/throw_item(atom/target)
	. = ..()
	throw_mode_off(THROW_MODE_TOGGLE)
	if(!target || !isturf(loc))
		return
	if(istype(target, /atom/movable/screen))
		return

	var/atom/movable/thrown_thing
	var/obj/item/I = get_active_held_item()

	if(!I)
		if(pulling && isliving(pulling) && grab_state >= GRAB_AGGRESSIVE)
			var/mob/living/throwable_mob = pulling
			if(!throwable_mob.buckled)
				thrown_thing = throwable_mob
				stop_pulling()
				if(HAS_TRAIT(src, TRAIT_PACIFISM))
					to_chat(src, span_notice("You gently let go of [throwable_mob]."))
					return
	else
		thrown_thing = I.on_thrown(src, target)

	if(thrown_thing)
		if(isliving(thrown_thing))
			var/turf/start_T = get_turf(loc) //Get the start and target tile for the descriptors
			var/turf/end_T = get_turf(target)
			if(start_T && end_T)
				log_combat(src, thrown_thing, "thrown", addition="grab from tile in [AREACOORD(start_T)] towards tile at [AREACOORD(end_T)]")
		do_attack_animation(target, no_effect = 1)
		playsound(loc, 'sound/weapons/punchmiss.ogg', 50, TRUE, -1)

		var/power_throw = 0
		if(pulling && grab_state >= GRAB_NECK)
			power_throw++
		visible_message(
			span_danger("[src] throws [thrown_thing][power_throw ? " really hard!" : "."]"),
			span_danger("You throw [thrown_thing][power_throw ? " really hard!" : "."]"),
		)
		log_message("has thrown [thrown_thing] [power_throw ? "really hard" : ""]", LOG_ATTACK)
		newtonian_move(get_dir(target, src))
		thrown_thing.safe_throw_at(target, thrown_thing.throw_range, thrown_thing.throw_speed + power_throw, src, null, null, null, move_force)


/mob/living/carbon/proc/canBeHandcuffed()
	return FALSE


/mob/living/carbon/show_inv(mob/user)
	user.set_machine(src)
	var/has_breathable_mask = istype(wear_mask, /obj/item/clothing/mask)
	var/obscured = check_obscured_slots()
	var/list/dat = list()

	dat += "<table>"
	for(var/i in 1 to held_items.len)
		var/obj/item/I = get_item_for_held_index(i)
		dat += "<tr><td><B>[get_held_index_name(i)]:</B></td><td><A href='byond://?src=[REF(src)];item=[ITEM_SLOT_HANDS];hand_index=[i]'>[(I && !(I.item_flags & ABSTRACT)) ? I : "<font color=grey>Empty</font>"]</a></td></tr>"
	dat += "<tr><td>&nbsp;</td></tr>"

	dat += "<tr><td><B>Back:</B></td><td><A href='byond://?src=[REF(src)];item=[ITEM_SLOT_BACK]'>[(back && !(back.item_flags & ABSTRACT)) ? back : "<font color=grey>Empty</font>"]</A>"
	if(has_breathable_mask && istype(back, /obj/item/tank))
		dat += "&nbsp;<A href='byond://?src=[REF(src)];internal=[ITEM_SLOT_BACK]'>[internal ? "Disable Internals" : "Set Internals"]</A>"

	dat += "</td></tr><tr><td>&nbsp;</td></tr>"

	dat += "<tr><td><B>Head:</B></td><td><A href='byond://?src=[REF(src)];item=[ITEM_SLOT_HEAD]'>[(head && !(head.item_flags & ABSTRACT)) ? head : "<font color=grey>Empty</font>"]</A></td></tr>"

	if(obscured & ITEM_SLOT_MASK)
		dat += "<tr><td><font color=grey><B>Mask:</B></font></td><td><font color=grey>Obscured</font></td></tr>"
	else
		dat += "<tr><td><B>Mask:</B></td><td><A href='byond://?src=[REF(src)];item=[ITEM_SLOT_MASK]'>[(wear_mask && !(wear_mask.item_flags & ABSTRACT)) ? wear_mask : "<font color=grey>Empty</font>"]</A></td></tr>"

	dat += "<tr><td><B>Neck:</B></td><td><A href='byond://?src=[REF(src)];item=[ITEM_SLOT_NECK]'>[(wear_neck && !(wear_neck.item_flags & ABSTRACT)) ? wear_neck : "<font color=grey>Empty</font>"]</A></td></tr>"

	if(handcuffed)
		dat += "<tr><td><B>Handcuffed:</B> <A href='byond://?src=[REF(src)];item=[ITEM_SLOT_HANDCUFFED]'>Remove</A></td></tr>"
	if(legcuffed)
		dat += "<tr><td><B>Legcuffed:</B> <A href='byond://?src=[REF(src)];item=[ITEM_SLOT_LEGCUFFED]'>Remove</A></td></tr>"

	dat += {"</table>
	<A href='byond://?src=[REF(user)];mach_close=mob[REF(src)]'>Close</A>
	"}

	var/datum/browser/popup = new(user, "mob[REF(src)]", "[src]", 440, 510)
	popup.set_content(dat.Join())
	popup.open()

/mob/living/carbon/Topic(href, href_list)
	..()
	//strip panel
	if(href_list["internal"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/slot = text2num(href_list["internal"])
		var/obj/item/ITEM = get_item_by_slot(slot)
		if(ITEM && istype(ITEM, /obj/item/tank) && wear_mask && (wear_mask.clothing_flags & ALLOWINTERNALS))
			visible_message(span_danger("[usr] tries to [internal ? "close" : "open"] the valve on [src]'s [ITEM.name]."), \
							span_userdanger("[usr] tries to [internal ? "close" : "open"] the valve on your [ITEM.name]."), null, null, usr)
			to_chat(usr, span_notice("You try to [internal ? "close" : "open"] the valve on [src]'s [ITEM.name]..."))
			if(do_after(usr, POCKET_STRIP_DELAY, src))
				if(internal)
					internal = null
					update_internals_hud_icon(0)
				else if(ITEM && istype(ITEM, /obj/item/tank))
					if((wear_mask && (wear_mask.clothing_flags & ALLOWINTERNALS)) || getorganslot(ORGAN_SLOT_BREATHING_TUBE))
						internal = ITEM
						update_internals_hud_icon(1)

				visible_message(span_danger("[usr] [internal ? "opens" : "closes"] the valve on [src]'s [ITEM.name]."), \
								span_userdanger("[usr] [internal ? "opens" : "closes"] the valve on your [ITEM.name]."), null, null, usr)
				to_chat(usr, span_notice("You [internal ? "open" : "close"] the valve on [src]'s [ITEM.name]."))

	if(href_list["embedded_object"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["embedded_limb"]) in get_all_bodyparts()
		if(!L)
			return
		var/obj/item/I = locate(href_list["embedded_object"]) in L.embedded_objects
		if(!I || I.loc != src) //no item, no limb, or item is not in limb or in the person anymore
			return
		SEND_SIGNAL(src, COMSIG_CARBON_EMBED_RIP, I, L)
		return

	if(href_list["show_paper_note"])
		var/obj/item/paper/paper_note = locate(href_list["show_paper_note"])
		if(!paper_note)
			return

		paper_note.show_through_camera(usr)

/mob/living/carbon/on_fall()
	. = ..()
	loc?.handle_fall(src)//it's loc so it doesn't call the mob's handle_fall which does nothing

/mob/living/carbon/is_muzzled()
	return(istype(src.wear_mask, /obj/item/clothing/mask/muzzle))

/mob/living/carbon/hallucinating()
	if(hallucination)
		return TRUE
	else
		return FALSE

/mob/living/carbon/resist_buckle()
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		changeNext_move(CLICK_CD_BREAKOUT)
		last_special = world.time + CLICK_CD_BREAKOUT
		var/buckle_cd = 600
		if(handcuffed)
			var/obj/item/restraints/O = src.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
			buckle_cd = O.breakouttime
		visible_message(span_warning("[src] attempts to unbuckle [p_them()]self!"), \
					span_notice("You attempt to unbuckle yourself... (This will take around [round(buckle_cd/600,1)] minute\s, and you need to stay still.)"))
		if(do_after(src, buckle_cd, target = src, timed_action_flags = IGNORE_HELD_ITEM))
			if(!buckled)
				return
			buckled.user_unbuckle_mob(src,src)
		else
			if(src && buckled)
				to_chat(src, span_warning("You fail to unbuckle yourself!"))
	else
		buckled.user_unbuckle_mob(src,src)

/mob/living/carbon/resist_fire()
	return !!apply_status_effect(/datum/status_effect/stop_drop_roll)

/mob/living/carbon/resist_restraints()
	var/obj/item/I = null
	var/type = 0
	if(handcuffed)
		I = handcuffed
		type = 1
	else if(legcuffed)
		I = legcuffed
		type = 2
	if(I)
		if(type == 1)
			changeNext_move(CLICK_CD_BREAKOUT)
			last_special = world.time + CLICK_CD_BREAKOUT
		if(type == 2)
			changeNext_move(CLICK_CD_RANGE)
			last_special = world.time + CLICK_CD_RANGE
		cuff_resist(I)


/mob/living/carbon/proc/cuff_resist(obj/item/I, breakouttime = 600, cuff_break = 0)
	if(I.item_flags & BEING_REMOVED)
		to_chat(src, span_warning("You're already attempting to remove [I]!"))
		return
	I.item_flags |= BEING_REMOVED
	breakouttime = I.breakouttime
	if(!cuff_break)
		visible_message(span_warning("[src] attempts to remove [I]!"))
		to_chat(src, span_notice("You attempt to remove [I]... (This will take around [DisplayTimeText(breakouttime)] and you need to stand still.)"))
		if(do_after(src, breakouttime, target = src, timed_action_flags = IGNORE_HELD_ITEM))
			. = clear_cuffs(I, cuff_break)
		else
			to_chat(src, span_warning("You fail to remove [I]!"))

	else if(cuff_break == FAST_CUFFBREAK)
		breakouttime = 50
		visible_message(span_warning("[src] is trying to break [I]!"))
		to_chat(src, span_notice("You attempt to break [I]... (This will take around 5 seconds and you need to stand still.)"))
		if(do_after(src, breakouttime, target = src, timed_action_flags = IGNORE_HELD_ITEM))
			. = clear_cuffs(I, cuff_break)
		else
			to_chat(src, span_warning("You fail to break [I]!"))

	else if(cuff_break == INSTANT_CUFFBREAK)
		. = clear_cuffs(I, cuff_break)
	I.item_flags &= ~BEING_REMOVED

/mob/living/carbon/proc/uncuff()
	if (handcuffed)
		var/obj/item/W = handcuffed
		set_handcuffed(null)
		if (buckled && buckled.buckle_requires_restraints)
			buckled.unbuckle_mob(src)
		update_handcuffed()
		if (client)
			client.screen -= W
		if (W)
			W.forceMove(drop_location())
			W.dropped(src)
			if (W)
				W.layer = initial(W.layer)
				W.plane = initial(W.plane)
		changeNext_move(0)
	if (legcuffed)
		var/obj/item/W = legcuffed
		legcuffed = null
		update_inv_legcuffed()
		if (client)
			client.screen -= W
		if (W)
			W.forceMove(drop_location())
			W.dropped(src)
			if (W)
				W.layer = initial(W.layer)
				W.plane = initial(W.plane)
		changeNext_move(0)
	update_equipment_speed_mods() // In case cuffs ever change speed

/mob/living/carbon/proc/clear_cuffs(obj/item/I, cuff_break)
	if(!I.loc || buckled)
		return FALSE
	if(I != handcuffed && I != legcuffed)
		return FALSE
	visible_message(span_danger("[src] manages to [cuff_break ? "break" : "remove"] [I]!"))
	to_chat(src, span_notice("You successfully [cuff_break ? "break" : "remove"] [I]."))

	if(cuff_break)
		. = !((I == handcuffed) || (I == legcuffed))
		qdel(I)
		return TRUE

	else
		if(I == handcuffed)
			handcuffed.forceMove(drop_location())
			set_handcuffed(null)
			I.dropped(src)
			if(buckled && buckled.buckle_requires_restraints)
				buckled.unbuckle_mob(src)
			update_handcuffed()
			return TRUE
		if(I == legcuffed)
			legcuffed.forceMove(drop_location())
			legcuffed = null
			I.dropped(src)
			update_inv_legcuffed()
			return TRUE

/mob/living/carbon/get_standard_pixel_y_offset(lying = 0)
	if(lying)
		return PIXEL_Y_OFFSET_LYING
	else
		return initial(pixel_y)

/mob/living/carbon/proc/accident(obj/item/I)
	if(!I || (I.item_flags & ABSTRACT) || HAS_TRAIT(I, TRAIT_NODROP))
		return

	dropItemToGround(I)

	var/modifier = 0
	if(HAS_TRAIT(src, TRAIT_CLUMSY))
		modifier -= 40 //Clumsy people are more likely to hit themselves -Honk!

	switch(rand(1,100)+modifier) //91-100=Nothing special happens
		if(-INFINITY to 0) //attack yourself
			INVOKE_ASYNC(I, TYPE_PROC_REF(/obj/item, attack), src, src)
		if(1 to 30) //throw it at yourself
			I.throw_impact(src)
		if(31 to 60) //Throw object in facing direction
			var/turf/target = get_turf(loc)
			var/range = rand(2,I.throw_range)
			for(var/i = 1; i < range; i++)
				var/turf/new_turf = get_step(target, dir)
				target = new_turf
				if(new_turf.density)
					break
			I.throw_at(target,I.throw_range,I.throw_speed,src)
		if(61 to 90) //throw it down to the floor
			var/turf/target = get_turf(loc)
			I.safe_throw_at(target,I.throw_range,I.throw_speed,src, force = move_force)

/mob/living/carbon/get_proc_holders()
	. = ..()
	. += add_abilities_to_panel()

/mob/living/carbon/attack_ui(slot)
	if(!has_hand_for_held_index(active_hand_index))
		return 0
	return ..()

/mob/living/carbon/proc/vomit(lost_nutrition = 10, blood = FALSE, stun = TRUE, distance = 1, message = TRUE, toxic = FALSE, harm = TRUE, force = FALSE, purge = FALSE)
	if((HAS_TRAIT(src, TRAIT_NOHUNGER) || HAS_TRAIT(src, TRAIT_TOXINLOVER)) && !force)
		return TRUE
	if(!has_mouth())
		return 1

	if(nutrition < 100 && !blood)
		if(message)
			visible_message(span_warning("[src] dry heaves!"), \
							span_userdanger("You try to throw up, but there's nothing in your stomach!"))
		if(stun)
			Immobilize(30)
		return TRUE

	if(is_mouth_covered()) //make this add a blood/vomit overlay later it'll be hilarious
		if(message)
			visible_message(span_danger("[src] throws up all over [p_them()]self!"), \
							span_userdanger("You throw up all over yourself!"))
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "vomit", /datum/mood_event/vomitself)
		distance = 0
	else
		if(message)
			visible_message(span_danger("[src] throws up!"), span_userdanger("You throw up!"))
			if(!isflyperson(src))
				SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "vomit", /datum/mood_event/vomit)

	if(stun)
		Immobilize(10)

	playsound(get_turf(src), 'sound/effects/splat.ogg', 50, TRUE)
	var/turf/T = get_turf(src)
	if(!blood)
		adjust_nutrition(-lost_nutrition)
		adjustToxLoss(-3)
	var/obj/item/organ/stomach/belly = getorganslot(ORGAN_SLOT_STOMACH)
	for(var/i=0 to distance)
		if(blood)
			if(T)
				add_splatter_floor(T)
			if(harm)
				adjustBruteLoss(3)
		else
			if(belly?.reagents.has_reagent(/datum/reagent/consumable/ethanol/blazaam, needs_metabolizing = TRUE))
				if(T)
					T.add_vomit_floor(src, VOMIT_PURPLE)
			else
				if(T)
					T.add_vomit_floor(src, VOMIT_TOXIC, purge) //toxic barf looks different || call purge when doing detoxicfication to pump more chems out of the stomach.
		T = get_step(T, dir)
		if (T?.is_blocked_turf())
			break
	adjust_disgust(-(lost_nutrition*rand(0.5, 2)))
	return TRUE

/**
 * Expel the reagents you just tried to ingest
 *
 * When you try to ingest reagents but you do not have a stomach
 * you will spew the reagents on the floor.
 *
 * Vars:
 * * bite: /atom the reagents to expel
 * * amount: int The amount of reagent
 */

/mob/living/carbon/proc/expel_ingested(atom/bite, amount)
	visible_message(span_userdanger("[src] throws up all over [p_them()]self!"), \
					span_userdanger("You are unable to keep the [bite] down without a stomach!"))
	var/turf/floor = get_turf(src)
	var/obj/effect/decal/cleanable/vomit/spew = new(floor, get_static_viruses())
	bite.reagents.trans_to(spew, amount, transfered_by = src)

/mob/living/carbon/proc/spew_organ(power = 5, amt = 1)
	for(var/i in 1 to amt)
		if(!internal_organs.len)
			break //Guess we're out of organs!
		var/obj/item/organ/guts = pick(internal_organs)
		var/turf/T = get_turf(src)
		guts.Remove(src)
		guts.forceMove(T)
		var/atom/throw_target = get_edge_target_turf(guts, dir)
		guts.throw_at(throw_target, power, 4, src)


/mob/living/carbon/fully_replace_character_name(oldname,newname)
	..()
	if(dna)
		dna.real_name = real_name


/mob/living/carbon/set_body_position(new_value)
	. = ..()
	if(isnull(.))
		return
	if(new_value == LYING_DOWN)
		add_movespeed_modifier(/datum/movespeed_modifier/carbon_crawling)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/carbon_crawling)


//Updates the mob's health from bodyparts and mob damage variables
/mob/living/carbon/updatehealth()
	if(status_flags & GODMODE)
		return
	var/total_burn	= 0
	var/total_brute	= 0
	var/total_stamina = 0
	var/obj/item/bodypart/limb
	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		if(!limb)
			continue
		total_brute	+= (limb.brute_dam * limb.body_damage_coeff)
		total_burn	+= (limb.burn_dam * limb.body_damage_coeff)
		total_stamina += (limb.stamina_dam * limb.stam_damage_coeff)
	set_health(round(maxHealth - getOxyLoss() - getToxLoss() - getCloneLoss() - total_burn - total_brute, DAMAGE_PRECISION))
	staminaloss = round(total_stamina, DAMAGE_PRECISION)
	update_stat()
	if(((maxHealth - total_burn) < HEALTH_THRESHOLD_DEAD*2) && stat == DEAD)
		become_husk("burn")

	med_hud_set_health()

	if(stat == SOFT_CRIT)
		add_movespeed_modifier(/datum/movespeed_modifier/carbon_softcrit)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/carbon_softcrit)

/mob/living/carbon/update_stamina()
	var/stam = getStaminaLoss()
	if(stam > DAMAGE_PRECISION && (health - stam) <= crit_threshold && !stat)		//WS edit - Stamina stacks with health damage
		enter_stamcrit()
	else if(HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, STAMINA))
		REMOVE_TRAIT(src, TRAIT_INCAPACITATED, STAMINA)
		REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, STAMINA)
		REMOVE_TRAIT(src, TRAIT_FLOORED, STAMINA)
		REMOVE_TRAIT(src, TRAIT_HANDS_BLOCKED, STAMINA)
	else
		return
	update_health_hud()

/mob/living/carbon/update_sight()
	if(!client)
		return
	if(stat == DEAD)
		sight = (SEE_TURFS|SEE_MOBS|SEE_OBJS)
		see_in_dark = 8
		see_invisible = SEE_INVISIBLE_OBSERVER
		return

	sight = initial(sight)
	lighting_alpha = initial(lighting_alpha)
	var/obj/item/organ/eyes/E = getorganslot(ORGAN_SLOT_EYES)
	if(!E)
		update_tint()
	else
		see_invisible = E.see_invisible
		see_in_dark = E.see_in_dark
		sight |= E.sight_flags
		if(!isnull(E.lighting_alpha))
			lighting_alpha = E.lighting_alpha

	if(client.eye != src)
		var/atom/A = client.eye
		if(A.update_remote_sight(src)) //returns 1 if we override all other sight updates.
			return

	if(glasses)
		var/obj/item/clothing/glasses/G = glasses
		sight |= G.vision_flags
		see_in_dark = max(G.darkness_view, see_in_dark)
		if(G.invis_override)
			see_invisible = G.invis_override
		else
			see_invisible = max(G.invis_view, see_invisible)
		if(!isnull(G.lighting_alpha))
			lighting_alpha = min(lighting_alpha, G.lighting_alpha)
	if(head)
		var/obj/item/clothing/head/headslot = head
		sight |= headslot.vision_flags
		see_in_dark = max(headslot.darkness_view, see_in_dark)
		if(headslot.invis_override)
			see_invisible = max(see_invisible, headslot.invis_override)
		else
			see_invisible = max(headslot.invis_view, see_invisible)
		if(!isnull(headslot.lighting_alpha))
			lighting_alpha = min(lighting_alpha, headslot.lighting_alpha)

	if(HAS_TRAIT(src, TRAIT_CHEMICAL_NIGHTVISION))
		lighting_alpha = min(lighting_alpha, LIGHTING_PLANE_ALPHA_NV_DRUG)
		see_in_dark = max(see_in_dark, 4)

	if(HAS_TRAIT(src, TRAIT_THERMAL_VISION))
		sight |= (SEE_MOBS)
		lighting_alpha = min(lighting_alpha, LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE)

	if(HAS_TRAIT(src, TRAIT_GOOD_CHEMICAL_NIGHTVISION))
		lighting_alpha = min(lighting_alpha, LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE)
		see_in_dark = max(see_in_dark, 6)

	if(HAS_TRAIT(src, TRAIT_XRAY_VISION))
		sight |= (SEE_TURFS|SEE_MOBS|SEE_OBJS)
		see_in_dark = max(see_in_dark, 8)

	if(see_override)
		see_invisible = see_override
	. = ..()


//to recalculate and update the mob's total tint from tinted equipment it's wearing.
/mob/living/carbon/proc/update_tint()
	if(!GLOB.tinted_weldhelh)
		return
	tinttotal = get_total_tint()
	if(tinttotal >= TINT_BLIND)
		become_blind(EYES_COVERED)
	else if(tinttotal >= TINT_DARKENED)
		cure_blind(EYES_COVERED)
		overlay_fullscreen("tint", /atom/movable/screen/fullscreen/impaired, 2)
	else
		cure_blind(EYES_COVERED)
		clear_fullscreen("tint", 0)

/mob/living/carbon/proc/get_total_tint()
	. = 0
	if(isclothing(head))
		. += head.tint
	if(isclothing(wear_mask))
		. += wear_mask.tint

	var/obj/item/organ/eyes/E = getorganslot(ORGAN_SLOT_EYES)
	if(E)
		. += E.tint

	else
		. += INFINITY

/mob/living/carbon/get_permeability_protection(list/target_zones = list(HANDS,CHEST,GROIN,LEGS,FEET,ARMS,HEAD))
	var/list/tally = list()
	for(var/obj/item/I in get_equipped_items())
		for(var/zone in target_zones)
			if(I.body_parts_covered & zone)
				tally["[zone]"] = max(1 - I.permeability_coefficient, target_zones["[zone]"])
	var/protection = 0
	for(var/key in tally)
		protection += tally[key]
	protection *= INVERSE(target_zones.len)
	return protection

//this handles hud updates
/mob/living/carbon/update_damage_hud()

	if(!client)
		return

	if(health <= crit_threshold)
		var/severity = 0
		switch(health)
			if(-20 to -10)
				severity = 1
			if(-30 to -20)
				severity = 2
			if(-40 to -30)
				severity = 3
			if(-50 to -40)
				severity = 4
			if(-50 to -40)
				severity = 5
			if(-60 to -50)
				severity = 6
			if(-70 to -60)
				severity = 7
			if(-90 to -70)
				severity = 8
			if(-95 to -90)
				severity = 9
			if(-INFINITY to -95)
				severity = 10
		if(stat != HARD_CRIT)
			var/visionseverity = 4
			switch(health)
				if(-8 to -4)
					visionseverity = 5
				if(-12 to -8)
					visionseverity = 6
				if(-16 to -12)
					visionseverity = 7
				if(-20 to -16)
					visionseverity = 8
				if(-24 to -20)
					visionseverity = 9
				if(-INFINITY to -24)
					visionseverity = 10
			overlay_fullscreen("critvision", /atom/movable/screen/fullscreen/crit/vision, visionseverity)
		else
			clear_fullscreen("critvision")
		overlay_fullscreen("crit", /atom/movable/screen/fullscreen/crit, severity)
	else
		clear_fullscreen("crit")
		clear_fullscreen("critvision")

	//Oxygen damage overlay
	if(oxyloss)
		var/severity = 0
		switch(oxyloss)
			if(10 to 20)
				severity = 1
			if(20 to 25)
				severity = 2
			if(25 to 30)
				severity = 3
			if(30 to 35)
				severity = 4
			if(35 to 40)
				severity = 5
			if(40 to 45)
				severity = 6
			if(45 to INFINITY)
				severity = 7
		overlay_fullscreen("oxy", /atom/movable/screen/fullscreen/oxy, severity)
	else
		clear_fullscreen("oxy")

	//Fire and Brute damage overlay (BSSR)
	var/hurtdamage = getBruteLoss() + getFireLoss() + damageoverlaytemp
	if(HAS_TRAIT(src, TRAIT_PAIN_RESIST))
		hurtdamage = round(hurtdamage/2)
	if(hurtdamage && !HAS_TRAIT(src, TRAIT_ANALGESIA))
		var/severity = 0
		switch(hurtdamage)
			if(5 to 15)
				severity = 1
			if(15 to 30)
				severity = 2
			if(30 to 45)
				severity = 3
			if(45 to 70)
				severity = 4
			if(70 to 85)
				severity = 5
			if(85 to INFINITY)
				severity = 6
		overlay_fullscreen("brute", /atom/movable/screen/fullscreen/brute, severity)
	else
		clear_fullscreen("brute")

/mob/living/carbon/update_health_hud(shown_health_amount)
	if(!client || !hud_used)
		return
	if(hud_used.healths)
		if(stat != DEAD)
			. = 1
			if(shown_health_amount == null)
				shown_health_amount = health
			if(shown_health_amount >= maxHealth)
				hud_used.healths.icon_state = "health0"
			else if(shown_health_amount > maxHealth*0.8)
				hud_used.healths.icon_state = "health1"
			else if(shown_health_amount > maxHealth*0.6)
				hud_used.healths.icon_state = "health2"
			else if(shown_health_amount > maxHealth*0.4)
				hud_used.healths.icon_state = "health3"
			else if(shown_health_amount > maxHealth*0.2)
				hud_used.healths.icon_state = "health4"
			else if(shown_health_amount > 0)
				hud_used.healths.icon_state = "health5"
			else
				hud_used.healths.icon_state = "health6"
		else
			hud_used.healths.icon_state = "health7"

/mob/living/carbon/proc/update_internals_hud_icon(internal_state = 0)
	if(hud_used && hud_used.internals)
		hud_used.internals.icon_state = "internal[internal_state]"

/*WS revert
/mob/living/carbon/proc/update_spacesuit_hud_icon(cell_state = "empty")
	if(hud_used && hud_used.spacesuit)
		hud_used.spacesuit.icon_state = "spacesuit_[cell_state]"
*/

/mob/living/carbon/set_health(new_value)
	. = ..()
	if(. > hardcrit_threshold)
		if(health <= hardcrit_threshold && !HAS_TRAIT(src, TRAIT_NOHARDCRIT))
			ADD_TRAIT(src, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT)
	else if(health > hardcrit_threshold)
		REMOVE_TRAIT(src, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT)
	if(CONFIG_GET(flag/near_death_experience))
		if(. > HEALTH_THRESHOLD_NEARDEATH)
			if(health <= HEALTH_THRESHOLD_NEARDEATH && !HAS_TRAIT(src, TRAIT_NODEATH))
				ADD_TRAIT(src, TRAIT_SIXTHSENSE, "near-death")
		else if(health > HEALTH_THRESHOLD_NEARDEATH)
			REMOVE_TRAIT(src, TRAIT_SIXTHSENSE, "near-death")


/mob/living/carbon/update_stat()
	if(status_flags & GODMODE)
		return
	if(stat != DEAD)
		if(health <= HEALTH_THRESHOLD_DEAD && !HAS_TRAIT(src, TRAIT_NODEATH))
			death()
			return
		if(health <= hardcrit_threshold && !HAS_TRAIT(src, TRAIT_NOHARDCRIT))
			set_stat(HARD_CRIT)
		else if(HAS_TRAIT(src, TRAIT_KNOCKEDOUT))
			set_stat(UNCONSCIOUS)
		else if(health <= crit_threshold && !HAS_TRAIT(src, TRAIT_NOSOFTCRIT))
			set_stat(SOFT_CRIT)
		else
			set_stat(CONSCIOUS)
	update_damage_hud()
	update_health_hud()
	med_hud_set_status()


//called when we get cuffed/uncuffed
/mob/living/carbon/proc/update_handcuffed()
	if(handcuffed)
		drop_all_held_items()
		stop_pulling()
		throw_alert("handcuffed", /atom/movable/screen/alert/restrained/handcuffed, new_master = src.handcuffed)
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "handcuffed", /datum/mood_event/handcuffed)
	else
		clear_alert("handcuffed")
		SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "handcuffed")
	update_action_buttons_icon() //some of our action buttons might be unusable when we're handcuffed.
	update_inv_handcuffed()
	update_hud_handcuffed()


/mob/living/carbon/fully_heal(admin_revive = FALSE)
	if(reagents)
		reagents.clear_reagents()
		for(var/addi in reagents.addiction_list)
			reagents.remove_addiction(addi)
	for(var/O in internal_organs)
		var/obj/item/organ/organ = O
		organ.setOrganDamage(0)
	for(var/thing in diseases)
		var/datum/disease/D = thing
		if(D.severity != DISEASE_SEVERITY_POSITIVE)
			D.cure(FALSE)
	for(var/thing in all_wounds)
		var/datum/wound/W = thing
		W.remove_wound()
	if(admin_revive)
		regenerate_limbs()
		regenerate_organs()
		set_handcuffed(null)
		for(var/obj/item/restraints/R in contents) //actually remove cuffs from inventory
			qdel(R)
		update_handcuffed()
		if(reagents)
			reagents.addiction_list = list()
	cure_all_traumas(TRAUMA_RESILIENCE_MAGIC)
	..()
	// heal ears after healing traits, since ears check TRAIT_DEAF trait
	// when healing.
	restoreEars()

/mob/living/carbon/can_be_revived()
	. = ..()
	if(!getorgan(/obj/item/organ/brain) && (!mind || !mind.has_antag_datum(/datum/antagonist/changeling)))
		return 0

/mob/living/carbon/proc/can_defib()
	var/obj/item/organ/heart = getorgan(/obj/item/organ/heart)
	if (HAS_TRAIT(src, TRAIT_HUSK))
		return
	if((getBruteLoss() >= MAX_REVIVE_BRUTE_DAMAGE) || (getFireLoss() >= MAX_REVIVE_FIRE_DAMAGE))
		return
	if(!heart || (heart.organ_flags & ORGAN_FAILING))
		return
	var/obj/item/organ/brain/BR = getorgan(/obj/item/organ/brain)
	if(QDELETED(BR) || (BR.organ_flags & ORGAN_FAILING))
		return
	return TRUE

/mob/living/carbon/harvest(mob/living/user)
	if(QDELETED(src))
		return
	var/organs_amt = 0
	for(var/X in internal_organs)
		var/obj/item/organ/O = X
		if(prob(50))
			organs_amt++
			O.Remove(src)
			O.forceMove(drop_location())
	if(organs_amt)
		to_chat(user, span_notice("You retrieve some of [src]\'s internal organs!"))

/mob/living/carbon/extinguish_mob()
	for(var/X in get_equipped_items())
		var/obj/item/I = X
		I.acid_level = 0 //washes off the acid on our clothes
		I.extinguish() //extinguishes our clothes
	..()

/mob/living/carbon/proc/create_bodyparts()
	var/l_arm_index_next = -1
	var/r_arm_index_next = 0
	var/obj/item/bodypart/bodypart_instance
	for(var/zone in bodyparts)
		bodypart_instance = bodyparts[zone]
		if(!bodypart_instance)
			continue
		bodypart_instance = new bodypart_instance()
		bodyparts[zone] = null
		bodypart_instance.set_owner(src)
		add_bodypart(bodypart_instance)
		switch(bodypart_instance.body_part)
			if(ARM_LEFT)
				l_arm_index_next += 2
				bodypart_instance.held_index = l_arm_index_next //1, 3, 5, 7...
				hand_bodyparts += bodypart_instance
			if(ARM_RIGHT)
				r_arm_index_next += 2
				bodypart_instance.held_index = r_arm_index_next //2, 4, 6, 8...
				hand_bodyparts += bodypart_instance


///Proc to hook behavior on bodypart additions.
/mob/living/carbon/proc/add_bodypart(obj/item/bodypart/new_bodypart)
	bodyparts[new_bodypart.body_zone] = new_bodypart

	if(new_bodypart.body_part & LEGS)
		set_num_legs(num_legs + 1)
		if(!new_bodypart.bodypart_disabled)
			set_usable_legs(usable_legs + 1)
	if(new_bodypart.body_part & ARMS)
		set_num_hands(num_hands + 1)
		if(!new_bodypart.bodypart_disabled)
			set_usable_hands(usable_hands + 1)


///Proc to hook behavior on bodypart removals.
/mob/living/carbon/proc/remove_bodypart(obj/item/bodypart/old_bodypart)
	var/removed_zone = old_bodypart.body_zone
	bodyparts[removed_zone] = null // order of the bodypart list must be preserved to prevent layering issues
	if(!(removed_zone in dna?.species.species_limbs))
		bodyparts -= removed_zone

	if(old_bodypart.body_part & LEGS)
		set_num_legs(num_legs - 1)
		if(!old_bodypart.bodypart_disabled)
			set_usable_legs(usable_legs - 1)
	if(old_bodypart.body_part & ARMS)
		set_num_hands(num_hands - 1)
		if(!old_bodypart.bodypart_disabled)
			set_usable_hands(usable_hands - 1)

///Returns the first available bodypart, used as a fallback in case the original part used for something goes missing
/mob/living/carbon/proc/get_first_available_bodypart()
	var/limb
	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		if(limb)
			return limb

/mob/living/carbon/do_after_coefficent()
	. = ..()
	var/datum/component/mood/mood = src.GetComponent(/datum/component/mood) //Currently, only carbons or higher use mood, move this once that changes.
	if(mood)
		switch(mood.sanity) //Alters do_after delay based on how sane you are
			if(-INFINITY to SANITY_DISTURBED)
				. *= 1.25
			if(SANITY_NEUTRAL to INFINITY)
				. *= 0.90

	// for(var/i in status_effects)
	// 	var/datum/status_effect/S = i
	// 	. *= S.interact_speed_modifier() //todo: fix/remove

/mob/living/carbon/proc/create_internal_organs()
	for(var/X in internal_organs)
		var/obj/item/organ/I = X
		I.Insert(src)

/mob/living/carbon/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "---------")
	VV_DROPDOWN_OPTION(VV_HK_MAKE_AI, "Make AI")
	VV_DROPDOWN_OPTION(VV_HK_MODIFY_BODYPART, "Modify bodypart")
	VV_DROPDOWN_OPTION(VV_HK_MODIFY_ORGANS, "Modify organs")
	VV_DROPDOWN_OPTION(VV_HK_HALLUCINATION, "Hallucinate")
	VV_DROPDOWN_OPTION(VV_HK_MARTIAL_ART, "Give Martial Arts")
	VV_DROPDOWN_OPTION(VV_HK_GIVE_TRAUMA, "Give Brain Trauma")
	VV_DROPDOWN_OPTION(VV_HK_CURE_TRAUMA, "Cure Brain Traumas")

/mob/living/carbon/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_MODIFY_BODYPART])
		if(!check_rights(R_SPAWN))
			return
		var/edit_action = input(usr, "What would you like to do?","Modify Body Part") as null|anything in list("replace","remove")
		if(!edit_action)
			return
		var/list/limb_list = list()
		if(edit_action == "remove")
			var/obj/item/bodypart/limb
			for(var/zone in bodyparts)
				limb = bodyparts[zone]
				if(!limb)
					continue
				if(limb.body_zone == BODY_ZONE_CHEST)
					continue
				limb_list += limb.body_zone
		else
			limb_list = list(BODY_ZONE_HEAD, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_CHEST)
		var/result = input(usr, "Please choose which bodypart to [edit_action]","[capitalize(edit_action)] Bodypart") as null|anything in sortList(limb_list)
		if(result)
			var/obj/item/bodypart/BP = get_bodypart(result)
			if(edit_action == "remove")
				if(BP)
					BP.drop_limb(TRUE)
					admin_ticket_log("[key_name_admin(usr)] has removed [src]'s [parse_zone(BP.body_zone)]")
				else
					to_chat(usr, span_boldwarning("[src] doesn't have such bodypart."))
					admin_ticket_log("[key_name_admin(usr)] has attempted to modify the bodyparts of [src]")
			else
				var/list/limbtypes = list()
				switch(result)
					if(BODY_ZONE_CHEST)
						limbtypes = typesof(/obj/item/bodypart/chest)
					if(BODY_ZONE_R_ARM)
						limbtypes = typesof(/obj/item/bodypart/r_arm)
					if(BODY_ZONE_L_ARM)
						limbtypes = typesof(/obj/item/bodypart/l_arm)
					if(BODY_ZONE_HEAD)
						limbtypes = typesof(/obj/item/bodypart/head)
					if(BODY_ZONE_L_LEG)
						limbtypes = typesof(/obj/item/bodypart/leg/left)
					if(BODY_ZONE_R_LEG)
						limbtypes = typesof(/obj/item/bodypart/leg/right)

				if((edit_action == "add") && BP)
					to_chat(usr, span_boldwarning("[src] already has such bodypart."))
				else
					var/limb2add = input(usr, "Select a bodypart type to add", "Add/Replace Bodypart") as null|anything in sortList(limbtypes)
					var/obj/item/bodypart/new_bp = new limb2add()

					if(new_bp.replace_limb(src, TRUE, TRUE))
						admin_ticket_log("key_name_admin(usr)] has replaced [src]'s [BP.type] with [new_bp.type]")
						qdel(BP)
					else
						to_chat(usr, "Failed to replace bodypart! They might be incompatible.")
						admin_ticket_log("[key_name_admin(usr)] has attempted to modify the bodyparts of [src]")


	if(href_list[VV_HK_MAKE_AI])
		if(!check_rights(R_SPAWN))
			return
		if(alert("Confirm mob type change?",,"Transform","Cancel") != "Transform")
			return
		usr.client.holder.Topic("vv_override", list("makeai"=href_list[VV_HK_TARGET]))
	if(href_list[VV_HK_MODIFY_ORGANS])
		if(!check_rights(NONE))
			return
		usr.client.manipulate_organs(src)
	if(href_list[VV_HK_MARTIAL_ART])
		if(!check_rights(NONE))
			return
		var/list/artpaths = subtypesof(/datum/martial_art)
		var/list/artnames = list()
		for(var/i in artpaths)
			var/datum/martial_art/M = i
			artnames[initial(M.name)] = M
		var/result = input(usr, "Choose the martial art to teach","JUDO CHOP") as null|anything in sortList(artnames, /proc/cmp_typepaths_asc)
		if(!usr)
			return
		if(QDELETED(src))
			to_chat(usr, span_boldwarning("Mob doesn't exist anymore."))
			return
		if(result)
			var/chosenart = artnames[result]
			var/datum/martial_art/MA = new chosenart
			MA.teach(src)
			log_admin("[key_name(usr)] has taught [MA] to [key_name(src)].")
			message_admins(span_notice("[key_name_admin(usr)] has taught [MA] to [key_name_admin(src)]."))
	if(href_list[VV_HK_GIVE_TRAUMA])
		if(!check_rights(NONE))
			return
		var/list/traumas = subtypesof(/datum/brain_trauma)
		var/result = input(usr, "Choose the brain trauma to apply","Traumatize") as null|anything in sortList(traumas, /proc/cmp_typepaths_asc)
		if(!usr)
			return
		if(QDELETED(src))
			to_chat(usr, "Mob doesn't exist anymore")
			return
		if(!result)
			return
		var/datum/brain_trauma/BT = gain_trauma(result)
		if(BT)
			log_admin("[key_name(usr)] has traumatized [key_name(src)] with [BT.name]")
			message_admins(span_notice("[key_name_admin(usr)] has traumatized [key_name_admin(src)] with [BT.name]."))
	if(href_list[VV_HK_CURE_TRAUMA])
		if(!check_rights(NONE))
			return
		cure_all_traumas(TRAUMA_RESILIENCE_ABSOLUTE)
		log_admin("[key_name(usr)] has cured all traumas from [key_name(src)].")
		message_admins(span_notice("[key_name_admin(usr)] has cured all traumas from [key_name_admin(src)]."))
	if(href_list[VV_HK_HALLUCINATION])
		if(!check_rights(NONE))
			return
		var/list/hallucinations = subtypesof(/datum/hallucination)
		var/result = input(usr, "Choose the hallucination to apply","Send Hallucination") as null|anything in sortList(hallucinations, /proc/cmp_typepaths_asc)
		if(!usr)
			return
		if(QDELETED(src))
			to_chat(usr, "Mob doesn't exist anymore")
			return
		if(result)
			new result(src, TRUE)

/mob/living/carbon/has_mouth()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	if(head && head.mouth)
		return TRUE

/mob/living/carbon/can_resist()
	return get_bodypart_count() > 2 && ..()

/mob/living/carbon/proc/hypnosis_vulnerable()
	if(HAS_TRAIT(src, TRAIT_MINDSHIELD))
		return FALSE
	if(hallucinating())
		return TRUE
	if(IsSleeping())
		return TRUE
	if(HAS_TRAIT(src, TRAIT_DUMB))
		return TRUE
	var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
	if(mood)
		if(mood.sanity < SANITY_UNSTABLE)
			return TRUE

/mob/living/carbon/wash(clean_types)
	. = ..()

	// Wash equipped stuff that cannot be covered
	for(var/i in held_items)
		var/obj/item/held_thing = i
		if(held_thing?.wash(clean_types))
			. = TRUE

	if(back?.wash(clean_types))
		update_inv_back(0)
		. = TRUE

	if(head?.wash(clean_types))
		update_inv_head()
		. = TRUE

	// Check and wash stuff that can be covered
	var/list/obscured = check_obscured_slots()

	// If the eyes are covered by anything but glasses, that thing will be covering any potential glasses as well.
	if(glasses && is_eyes_covered(FALSE, TRUE, TRUE) && glasses.wash(clean_types))
		update_inv_glasses()
		. = TRUE

	if(wear_mask && !(ITEM_SLOT_MASK in obscured) && wear_mask.wash(clean_types))
		update_inv_wear_mask()
		. = TRUE

	if(ears && !(ITEM_SLOT_EARS in obscured) && ears.wash(clean_types))
		update_inv_ears()
		. = TRUE

	if(wear_neck && !(ITEM_SLOT_NECK in obscured) && wear_neck.wash(clean_types))
		update_inv_neck()
		. = TRUE

	if(shoes && !(ITEM_SLOT_FEET in obscured) && shoes.wash(clean_types))
		update_inv_shoes()
		. = TRUE

	if(gloves && !(ITEM_SLOT_GLOVES in obscured) && gloves.wash(clean_types))
		update_inv_gloves()
		. = TRUE

/// if any of our bodyparts are bleeding
/mob/living/carbon/proc/is_bleeding()
	var/obj/item/bodypart/limb
	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		if(limb.get_part_bleed_rate())
			return TRUE
	return FALSE

/// get our total bleedrate
/mob/living/carbon/proc/get_total_bleed_rate()
	var/total_bleed_rate = 0
	var/obj/item/bodypart/limb
	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		total_bleed_rate += limb.get_part_bleed_rate()
	return total_bleed_rate

/mob/living/carbon/proc/update_flavor_text_feature(new_text)
	if(!dna)
		return
	dna.features["flavor_text"] = new_text

/// Returns whether or not the carbon should be able to be shocked
/mob/living/carbon/proc/should_electrocute(power_source)
	if (ismecha(loc))
		return FALSE

	if (wearing_shock_proof_gloves())
		return FALSE

	if(!get_powernet_info_from_source(power_source))
		return FALSE

	if (HAS_TRAIT(src, TRAIT_SHOCKIMMUNE))
		return FALSE

	return TRUE

/// Returns if the carbon is wearing shock proof gloves
/mob/living/carbon/proc/wearing_shock_proof_gloves()
	return gloves?.siemens_coefficient == 0

/mob/living/carbon/is_face_visible()
	return !(wear_mask?.flags_inv & HIDEFACE) && !(head?.flags_inv & HIDEFACE)

/**
 * get_biological_state is a helper used to see what kind of wounds we roll for. By default we just assume carbons (read:monkeys) are flesh and bone, but humans rely on their species datums
 *
 * go look at the species def for more info [/datum/species/proc/get_biological_state]
 */
/mob/living/carbon/proc/get_biological_state() //todo: silicon wounds for ipcs
	return BIO_FLESH_BONE

/// Modifies the handcuffed value if a different value is passed, returning FALSE otherwise. The variable should only be changed through this proc.
/mob/living/carbon/proc/set_handcuffed(new_value)
	if(handcuffed == new_value)
		return FALSE
	. = handcuffed
	handcuffed = new_value
	if(.)
		if(!handcuffed)
			REMOVE_TRAIT(src, TRAIT_RESTRAINED, HANDCUFFED_TRAIT)
	else if(handcuffed)
		ADD_TRAIT(src, TRAIT_RESTRAINED, HANDCUFFED_TRAIT)


/mob/living/carbon/on_lying_down(new_lying_angle)
	. = ..()
	if(!buckled || buckled.buckle_lying != 0)
		lying_angle_on_lying_down(new_lying_angle)

/// Special carbon interaction on lying down, to transform its sprite by a rotation.
/mob/living/carbon/proc/lying_angle_on_lying_down(new_lying_angle)
	if(!new_lying_angle)
		set_lying_angle(pick(90, 270))
	else
		set_lying_angle(new_lying_angle)

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
