/**
 * This is the proc that handles the order of an item_attack.
 *
 * The order of procs called is:
 * * [/atom/proc/tool_act] on the target. If it returns TRUE, the chain will be stopped.
 * * [/obj/item/proc/pre_attack] on src. If this returns TRUE, the chain will be stopped.
 * * [/atom/proc/attackby] on the target. If it returns TRUE, the chain will be stopped.
 * * [/obj/item/proc/afterattack]. The return value does not matter.
 */
/obj/item/proc/melee_attack_chain(mob/user, atom/target, params)
	if(tool_behaviour && target.tool_act(user, src, tool_behaviour))
		return
	if(pre_attack(target, user, params))
		return
	if(target.attackby(src,user, params))
		return
	if(QDELETED(src) || QDELETED(target))
		attack_qdeleted(target, user, TRUE, params)
		return
	afterattack(target, user, TRUE, params)

/// Called when the item is in the active hand, and clicked; alternately, there is an 'activate held object' verb or you can hit pagedown.
/obj/item/proc/attack_self(mob/user)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_SELF, user) & COMPONENT_NO_INTERACT)
		return
	interact(user)

/**
 * Called on the item before it hits something
 *
 * Arguments:
 * * atom/A - The atom about to be hit
 * * mob/living/user - The mob doing the htting
 * * params - click params such as alt/shift etc
 *
 * See: [/obj/item/proc/melee_attack_chain]
 */
/obj/item/proc/pre_attack(atom/A, mob/living/user, params) //do stuff before attackby!
	if(SEND_SIGNAL(src, COMSIG_ITEM_PRE_ATTACK, A, user, params) & COMPONENT_NO_ATTACK)
		return TRUE
	return FALSE //return TRUE to avoid calling attackby after this proc does stuff

/**
 * Called on an object being hit by an item
 *
 * Arguments:
 * * obj/item/W - The item hitting this atom
 * * mob/user - The wielder of this item
 * * params - click params such as alt/shift etc
 *
 * See: [/obj/item/proc/melee_attack_chain]
 */
/atom/proc/attackby(obj/item/W, mob/user, params)
	if(SEND_SIGNAL(src, COMSIG_PARENT_ATTACKBY, W, user, params) & COMPONENT_NO_AFTERATTACK)
		return TRUE
	return FALSE

/obj/attackby(obj/item/I, mob/living/user, params)
	return ..() || ((obj_flags & CAN_BE_HIT) && I.attack_obj(src, user))

/mob/living/attackby(obj/item/I, mob/living/user, params)
	if(..())
		return TRUE
	if(user.a_intent == INTENT_HELP || user.a_intent == INTENT_DISARM)
		for(var/datum/surgery/S in surgeries)
			if(body_position != LYING_DOWN && S.lying_required)
				continue
			if(!S.self_operable && user == src)
				continue
			if(S.next_step(user, user.a_intent))
				return TRUE
	if((I.item_flags & SURGICAL_TOOL) && user.a_intent == INTENT_HELP)
		if(attempt_initiate_surgery(I, src, user))
			return TRUE
	//This should really be in attack but 2 much logic doesnt call parent
	user.changeNext_move(I.attack_cooldown)
	return I.attack(src, user)

/mob/living/attack_hand(mob/living/user)
	if(..())
		return TRUE
	for(var/datum/surgery/S in surgeries)
		if(body_position != LYING_DOWN && S.lying_required)
			continue
		if(!S.self_operable && user == src)
			continue
		if(S.next_step(user, user.a_intent))
			return TRUE

/**
 * Called from [/mob/living/attackby]
 *
 * Arguments:
 * * mob/living/M - The mob being hit by this item
 * * mob/living/user - The mob hitting with this item
 */
/obj/item/proc/attack(mob/living/target_mob, mob/living/user)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK, target_mob, user) & COMPONENT_ITEM_NO_ATTACK)
		return
	SEND_SIGNAL(user, COMSIG_MOB_ITEM_ATTACK, target_mob, user)
	if(item_flags & NOBLUDGEON)
		return

	if(force && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You don't want to harm other living beings!"))
		return

	if(item_flags & EYE_STAB && user.zone_selected == BODY_ZONE_PRECISE_EYES)
		if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
			target_mob = user
		return eyestab(target_mob,user)

	if(!force)
		playsound(loc, 'sound/weapons/tap.ogg', get_clamped_volume(), TRUE, -1)
	else if(hitsound)
		playsound(loc, hitsound, get_clamped_volume(), TRUE, extrarange = stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)

	target_mob.lastattacker = user.real_name
	target_mob.lastattackerckey = user.ckey

	if(force && target_mob == user && user.client)
		user.client.give_award(/datum/award/achievement/misc/selfouch, user)

	user.do_attack_animation(target_mob)
	target_mob.attacked_by(src, user)

	SEND_SIGNAL(src, COMSIG_ITEM_POST_ATTACK, target_mob, user)

	log_combat(user, target_mob, "attacked", src.name, "(INTENT: [uppertext(user.a_intent)]) (DAMTYPE: [uppertext(damtype)])")
	add_fingerprint(user)

/// The equivalent of the standard version of [/obj/item/proc/attack] but for object targets.
/obj/item/proc/attack_obj(obj/O, mob/living/user)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_OBJ, O, user) & COMPONENT_NO_ATTACK_OBJ)
		return
	if(item_flags & NOBLUDGEON)
		return
	user.changeNext_move(attack_cooldown)
	user.do_attack_animation(O)
	O.attacked_by(src, user)

/// if an item should have special behavior when attacking a wall
/obj/item/proc/closed_turf_attack(turf/closed/wall, mob/living/user, params)
	return

/// Called from [/obj/item/proc/attack_obj] and [/obj/item/proc/attack] if the attack succeeds
/atom/movable/proc/attacked_by()
	return

/obj/attacked_by(obj/item/attacking_item, mob/living/user)
	if(!attacking_item.force)
		return

	var/total_force
	if(is_type_in_list(src, list(/obj/structure, /obj/machinery)))
		total_force = (attacking_item.force * attacking_item.demolition_mod)

	else
		total_force = (attacking_item.force)

	var/damage = take_damage(total_force, attacking_item.damtype, "melee", TRUE, get_dir(src, user), attacking_item.armour_penetration)

	var/damage_verb = "hit"

	if(attacking_item.demolition_mod > 1 && damage)
		damage_verb = "pulverise"
	if(attacking_item.demolition_mod < 1)
		damage_verb = "ineffectively pierce"

	user.visible_message(span_danger("[user] [damage_verb]s [src] with [attacking_item][damage ? "." : ", without leaving a mark!"]"), \
		span_danger("You [damage_verb] [src] with [attacking_item][damage ? "." : ", without leaving a mark!"]"), null, COMBAT_MESSAGE_RANGE)
	log_combat(user, src, "attacked", attacking_item)

/mob/living/attacked_by(obj/item/attacking_item, mob/living/user)
	var/armor_value = run_armor_check(attack_flag = "melee", armour_penetration = attacking_item.armour_penetration)

	send_item_attack_message(attacking_item, user)

	if(!attacking_item.force)
		return FALSE

	apply_damage(attacking_item.force, attacking_item.damtype, blocked = armor_value)

	if(attacking_item.damtype == BRUTE && prob(33))
		attacking_item.add_mob_blood(src)
		var/turf/location = get_turf(src)
		add_splatter_floor(location)

		if(get_dist(user, src) <= 1)	//people with TK won't get smeared with blood
			user.add_mob_blood(src)

		return TRUE //successful attack

/mob/living/simple_animal/attacked_by(obj/item/I, mob/living/user)
	if(I.force < force_threshold || I.damtype == STAMINA)
		playsound(loc, 'sound/weapons/tap.ogg', I.get_clamped_volume(), TRUE, -1)
	else
		return ..()

/mob/living/basic/attacked_by(obj/item/I, mob/living/user)
	if(!attack_threshold_check(I.force, I.damtype, MELEE, FALSE))
		playsound(loc, 'sound/weapons/tap.ogg', I.get_clamped_volume(), TRUE, -1)
	else
		return ..()

/**
 * Last proc in the [/obj/item/proc/melee_attack_chain]
 *
 * Arguments:
 * * atom/target - The thing that was hit
 * * mob/user - The mob doing the hitting
 * * proximity_flag - is 1 if this afterattack was called on something adjacent, in your square, or on your person.
 * * click_parameters - is the params string from byond [/atom/proc/Click] code, see that documentation.
 */
/obj/item/proc/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	SEND_SIGNAL(src, COMSIG_ITEM_AFTERATTACK, target, user, proximity_flag, click_parameters)
	SEND_SIGNAL(user, COMSIG_MOB_ITEM_AFTERATTACK, target, user, proximity_flag, click_parameters)

/// Called if the target gets deleted by our attack
/obj/item/proc/attack_qdeleted(atom/target, mob/user, proximity_flag, click_parameters)
	SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_QDELETED, target, user, proximity_flag, click_parameters)
	SEND_SIGNAL(user, COMSIG_MOB_ITEM_ATTACK_QDELETED, target, user, proximity_flag, click_parameters)

/obj/item/proc/get_clamped_volume()
	if(w_class)
		if(force)
			return clamp((force + w_class) * 4, 30, 100)// Add the item's force to its weight class and multiply by 4, then clamp the value between 30 and 100
		else
			return clamp(w_class * 6, 10, 100) // Multiply the item's weight class by 6, then clamp the value between 10 and 100

/mob/living/proc/send_item_attack_message(obj/item/attacking_item, mob/living/user, hit_area, obj/item/bodypart/hit_bodypart)
	var/message_verb = "attacked"
	if(length(attacking_item.attack_verb))
		message_verb = "[pick(attacking_item.attack_verb)]"
	else if(!attacking_item.force)
		return

	var/message_hit_area = ""
	if(hit_area)
		message_hit_area = " in the [hit_area]"

	var/attack_message = "[src] is [message_verb][message_hit_area] with [attacking_item]!"
	var/attack_message_local = "You're [message_verb][message_hit_area] with [attacking_item]!"
	if(user in viewers(src, null))
		attack_message = "[user] [message_verb] [src][message_hit_area] with [attacking_item]!"
		attack_message_local = "[user] [message_verb] you[message_hit_area] with [attacking_item]!"

	if(user == src)
		attack_message_local = "You [message_verb] yourself[message_hit_area] with [attacking_item]"

	visible_message(
		span_danger("[attack_message]"),
		span_userdanger("[attack_message_local]"),
		null,
		COMBAT_MESSAGE_RANGE,
	)
	return 1
