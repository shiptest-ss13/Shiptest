/mob/living/carbon
	var/obj/item/pull_hand/pull_hand

// item that occupies a hand slot when pulling
/obj/item/pull_hand
	name = "pull"
	desc = "Your grip on whatever you're pulling."
	icon_state = "pullitem"
	w_class = WEIGHT_CLASS_HUGE
	item_flags = ABSTRACT | DROPDEL | NOBLUDGEON | HAND_ITEM | SLOWS_WHILE_IN_HAND
	slowdown = 0.25
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/pull_hand/attack_self(mob/user)
	user.stop_pulling()

// throwing the grip throws a grabbed mob
/obj/item/pull_hand/on_thrown(mob/living/carbon/user, atom/target)
	var/mob/living/throwable_mob = user.pulling
	if(!isliving(throwable_mob) || user.grab_state < GRAB_AGGRESSIVE || throwable_mob.buckled)
		return
	user.stop_pulling()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_notice("You gently let go of [throwable_mob]."))
		return
	return throwable_mob

/obj/item/pull_hand/dropped(mob/user, silent)
	. = ..()
	var/mob/living/carbon/carbon_user = user
	if(istype(carbon_user) && carbon_user.pull_hand == src)
		carbon_user.pull_hand = null
		carbon_user.stop_pulling()

// act like an empty hand for most interactions
/obj/item/pull_hand/pre_attack(atom/target, mob/living/user, params)
	if(target != user.pulling)
		target.pull_hand_act(user, user.pulling)
		return TRUE
	var/list/modifiers = params2list(params)
	if(isitem(target))
		var/obj/item/pulled_item = target
		user.stop_pulling()
		user.UnarmedAttack(pulled_item, TRUE, modifiers)
		if(!QDELETED(pulled_item) && !user.is_holding(pulled_item) && user.Adjacent(pulled_item))
			user.start_pulling(pulled_item, supress_message = TRUE)
		return TRUE
	if(ismob(target))
		if(user.a_intent == INTENT_HARM) //no fun allowed, punch em with your free hand/weapon in the other hand
			user.balloon_alert(user, "use a free hand!")
			return TRUE
		user.changeNext_move(CLICK_CD_MELEE)
	user.UnarmedAttack(target, TRUE, modifiers)
	return TRUE

/mob/living/carbon/start_pulling(atom/movable/pull_target, state, force = pull_force, supress_message = FALSE)
	if(!pull_target || pull_target == pulling || throwing || !(mobility_flags & MOBILITY_PULL) || !pull_target.can_be_pulled(src, state, force))
		return ..()
	if(pulling)
		stop_pulling()
	var/hand_index = get_pull_hand_index()
	if(!hand_index)
		if(HAS_TRAIT(src, TRAIT_RESTRAINED))
			balloon_alert(src, "restrained!")
		else if(!usable_hands)
			balloon_alert(src, "no usable hands!")
		else
			balloon_alert(src, "hands full!")
		return FALSE
	. = ..()
	if(pulling != pull_target)
		return
	pull_hand = new(src)
	pull_hand.name = "pulling [pull_target.name]"
	if(!put_in_hand(pull_hand, hand_index))
		stop_pulling()
		return FALSE

/mob/living/carbon/stop_pulling()
	if(pull_hand)
		var/obj/item/pull_hand/old_grip = pull_hand
		pull_hand = null
		qdel(old_grip)
	return ..()

// try to get an empty hand to use
/mob/living/carbon/proc/get_pull_hand_index()
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		return null
	if(!held_items[active_hand_index] && has_hand_for_held_index(active_hand_index))
		return active_hand_index
	for(var/hand_index in 1 to length(held_items))
		if(!held_items[hand_index] && has_hand_for_held_index(hand_index))
			return hand_index
	for(var/obj/item/held_item in held_items)
		if(!HAS_TRAIT(held_item, TRAIT_WIELDED))
			continue
		var/datum/component/two_handed/two_handed = held_item.GetComponent(/datum/component/two_handed)
		if(!two_handed || two_handed.require_twohands || !two_handed.offhand_item)
			continue
		var/offhand_index = get_held_index_of_item(two_handed.offhand_item)
		if(!has_hand_for_held_index(offhand_index))
			continue
		two_handed.unwield(src)
		if(!held_items[offhand_index])
			return offhand_index
	return null

// we walk backwards facing what we drag, except standing mobs (leading them by the hand)
/mob/living/carbon/proc/faces_pulled()
	var/mob/living/pulled_mob = pulling
	return pulling && !(istype(pulled_mob) && pulled_mob.body_position == STANDING_UP)

// walking while dragging, so movement decides our facing instead of the mouse
/mob/living/carbon/proc/is_drag_walking()
	if(!client || !faces_pulled())
		return FALSE
	for(var/held_key in client.keys_held)
		if(client.movement_keys[held_key])
			return TRUE
	return FALSE
