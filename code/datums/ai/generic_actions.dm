
/datum/ai_behavior/resist/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	living_pawn.resist()
	finish_action(controller, TRUE)

/datum/ai_behavior/battle_screech
	///List of possible screeches the behavior has
	var/list/screeches

/datum/ai_behavior/battle_screech/perform(delta_time, datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	INVOKE_ASYNC(living_pawn, TYPE_PROC_REF(/mob, emote), pick(screeches))
	finish_action(controller, TRUE)

/// Use in hand the currently held item
/datum/ai_behavior/use_in_hand
	behavior_flags = AI_BEHAVIOR_MOVE_AND_PERFORM

/datum/ai_behavior/use_in_hand/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/pawn = controller.pawn
	var/obj/item/held = pawn.get_item_by_slot(pawn.get_active_hand())
	if(!held)
		finish_action(controller, FALSE)
		return
	pawn.activate_hand(pawn.get_active_hand())
	finish_action(controller, TRUE)

/// Use the currently held item, or unarmed, on an object in the world
/datum/ai_behavior/use_on_object
	required_distance = 1
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/use_on_object/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/pawn = controller.pawn
	var/obj/item/held_item = pawn.get_item_by_slot(pawn.get_active_hand())
	var/atom/target = controller.current_movement_target

	if(!target || !pawn.CanReach(target))
		finish_action(controller, FALSE)
		return

	pawn.a_intent = INTENT_HELP

	if(held_item)
		held_item.melee_attack_chain(pawn, target)
	else
		pawn.UnarmedAttack(target, TRUE)

	finish_action(controller, TRUE)

/datum/ai_behavior/give
	required_distance = 1
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/give/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/pawn = controller.pawn
	var/obj/item/held_item = pawn.get_item_by_slot(pawn.get_active_hand())
	var/atom/target = controller.current_movement_target

	if(!target || !pawn.CanReach(target) || !isliving(target))
		finish_action(controller, FALSE)
		return

	var/mob/living/living_target = target
	controller.PauseAi(1.5 SECONDS)
	living_target.visible_message(
		"<span class='info'>[pawn] starts trying to give [held_item] to [living_target]!</span>",
		"<span class='warning'>[pawn] tries to give you [held_item]!</span>"
	)
	if(!do_after(pawn, 1 SECONDS, living_target))
		return
	if(QDELETED(held_item) || QDELETED(living_target))
		finish_action(controller, FALSE)
		return
	var/pocket_choice = prob(50) ? ITEM_SLOT_RPOCKET : ITEM_SLOT_LPOCKET
	if(prob(50) && living_target.can_put_in_hand(held_item))
		living_target.put_in_hand(held_item)
	else if(held_item.mob_can_equip(living_target, pawn, pocket_choice, TRUE))
		living_target.equip_to_slot(held_item, pocket_choice)

	finish_action(controller, TRUE)

/datum/ai_behavior/consume
	required_distance = 1
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT
	action_cooldown = 2 SECONDS

/datum/ai_behavior/consume/setup(datum/ai_controller/controller, obj/item/target)
	. = ..()
	controller.current_movement_target = target

/datum/ai_behavior/consume/perform(delta_time, datum/ai_controller/controller, obj/item/target)
	. = ..()
	var/mob/living/pawn = controller.pawn

	if(!(target in pawn.held_items))
		if(!pawn.put_in_hand_check(target))
			finish_action(controller, FALSE)
			return

		pawn.put_in_hands(target)

	target.melee_attack_chain(pawn, pawn)

	if(QDELETED(target) || prob(10)) // Even if we don't finish it all we can randomly decide to be done
		finish_action(controller, TRUE)
