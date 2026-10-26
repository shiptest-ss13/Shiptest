// walks over to someone downed and finishes them up close
/datum/ai_behavior/execute_downed
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION // so we still notice who else turns up, and the subtree can call it off
	required_distance = 1
	action_cooldown = 0.2 SECONDS

/datum/ai_behavior/execute_downed/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/mob/living/victim = controller.blackboard[target_key]
	if(!ishuman(victim))
		return FALSE
	ADD_TRAIT(victim, TRAIT_AI_EXECUTION_CLAIMED, REF(controller.pawn)) // so the rest of our side leave them to us
	controller.set_blackboard_key(BB_BASIC_MOB_EXECUTION_VICTIM, victim)
	set_movement_target(controller, victim)

/datum/ai_behavior/execute_downed/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/basic/human/executioner = controller.pawn
	var/mob/living/carbon/human/victim = controller.blackboard[target_key]
	if(!istype(executioner) || QDELETED(victim) || victim != controller.blackboard[BB_BASIC_MOB_EXECUTION_VICTIM] || !ai_is_downed(victim) || victim.stat == DEAD)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED // back up, or dead already, or we're after someone else now
	if(!executioner.Adjacent(victim) || executioner.incapacitated() || HAS_TRAIT(executioner, TRAIT_FLOORED))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED // like if they were dragged off, or we were knocked down
	var/style = executioner.get_execution_style()
	if(!style)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	var/started = controller.blackboard[BB_BASIC_MOB_EXECUTION_STARTED]
	if(isnull(started))
		if(style == AI_EXECUTION_GUN && !gun_loaded(executioner))
			return AI_BEHAVIOR_DELAY // no point putting an empty gun to their head, so we load it first
		start_execution(controller, executioner, victim, style)
		return AI_BEHAVIOR_DELAY
	if(controller.blackboard[BB_BASIC_MOB_LAST_HURT_TIME] > started)
		// someone's fighting for them, so we leave it a while
		AI_LOG_DECISION(controller, "execute_downed: hurt while finishing off [victim], backing off")
		victim.visible_message(span_notice("[executioner] is forced away from [victim]!"))
		tell_unseeing(victim, span_notice("The grip on you loosens, and whoever it was is gone... for now."))
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_EXECUTION, world.time + AI_EXECUTION_RETRY_DELAY)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	executioner.face_atom(victim)
	if(world.time < started + AI_EXECUTION_TIME)
		return AI_BEHAVIOR_DELAY
	if(style == AI_EXECUTION_GUN && (SEND_SIGNAL(executioner, COMSIG_BASICMOB_PRE_RANGED_ATTACK, victim) & COMPONENT_CANCEL_RANGED_ATTACK))
		return AI_BEHAVIOR_DELAY // the round comes out of our magazine like any other, and if it's somehow empty, we reload and then fire
	finish_off(executioner, victim, style)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/execute_downed/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	var/mob/living/victim = controller.blackboard[BB_BASIC_MOB_EXECUTION_VICTIM]
	if(victim)
		REMOVE_TRAIT(victim, TRAIT_AI_EXECUTION_CLAIMED, REF(controller.pawn))
		var/mob/living/executioner = controller.pawn
		if(executioner.pulling == victim)
			executioner.stop_pulling() // done with them, however it went
	controller.clear_blackboard_key(BB_BASIC_MOB_EXECUTION_VICTIM)
	controller.clear_blackboard_key(BB_BASIC_MOB_EXECUTION_STARTED)
	controller.clear_blackboard_key(BB_BASIC_MOB_EXECUTION_SPOT)

// the same, but from the spot beside them we picked as covered from the rest of theirs
/datum/ai_behavior/execute_downed/from_cover
	required_distance = 0

/datum/ai_behavior/execute_downed/from_cover/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/turf/spot = controller.blackboard[BB_BASIC_MOB_EXECUTION_SPOT]
	if(. && spot)
		set_movement_target(controller, spot)

/datum/ai_behavior/execute_downed/proc/gun_loaded(mob/living/basic/human/executioner)
	var/datum/component/ai_magazine/magazine = executioner.GetComponent(/datum/component/ai_magazine)
	if(!magazine)
		return TRUE
	magazine.top_off()
	if(magazine.shots_left <= 0)
		magazine.start_reload()
		return FALSE
	return !magazine.reloading || magazine.single_loads

/datum/ai_behavior/execute_downed/proc/start_execution(datum/ai_controller/controller, mob/living/basic/human/executioner, mob/living/carbon/human/victim, style)
	AI_LOG_DECISION(controller, "execute_downed: finishing off [victim] with a [style]")
	controller.set_blackboard_key(BB_BASIC_MOB_EXECUTION_STARTED, world.time)
	executioner.face_atom(victim)
	grab_victim(executioner, victim)
	ai_callout(executioner, AI_CALLOUT_EXECUTING, interrupt = TRUE, subject = victim)
	log_combat(executioner, victim, "started executing")
	if(style == AI_EXECUTION_GUN)
		var/obj/item/gun/gun_type = executioner.get_gun_type()
		var/gun_name = gun_type ? initial(gun_type.name) : "gun"
		victim.visible_message(span_warning("[executioner] points [executioner.p_their()] [gun_name] at [victim]'s head, ready to pull the trigger..."), \
			span_userdanger("[executioner] points [executioner.p_their()] [gun_name] at your head, ready to pull the trigger..."))
		tell_unseeing(victim, span_userdanger("Cold metal presses against your head..."))
		return
	victim.visible_message(span_danger("[executioner] is slitting [victim]'s throat!"), \
		span_userdanger("Your throat is being slit by [executioner]!"))
	tell_unseeing(victim, span_userdanger("A blade presses against your throat..."))
	playsound(victim, 'sound/weapons/slice.ogg', 50, TRUE, -1)

// people in hard crit can't see visible_message
/datum/ai_behavior/execute_downed/proc/tell_unseeing(mob/living/carbon/human/victim, message)
	if(victim.is_blind())
		to_chat(victim, message)

/datum/ai_behavior/execute_downed/proc/grab_victim(mob/living/basic/human/executioner, mob/living/carbon/human/victim)
	if(executioner.pulling != victim)
		executioner.start_pulling(victim, supress_message = TRUE)
	if(executioner.pulling != victim)
		return
	executioner.setGrabState(GRAB_AGGRESSIVE)
	victim.visible_message(span_danger("[executioner] grabs [victim] aggressively!"), span_userdanger("[executioner] grabs you aggressively!"))
	tell_unseeing(victim, span_userdanger("Rough hands seize you and hold you still..."))
	log_combat(executioner, victim, "grabbed", addition = "aggressive grab")

/datum/ai_behavior/execute_downed/proc/fire_follow_up(datum/weakref/executioner_ref, datum/weakref/victim_ref)
	var/mob/living/basic/human/executioner = executioner_ref?.resolve()
	var/mob/living/carbon/human/victim = victim_ref?.resolve()
	if(QDELETED(executioner) || executioner.stat != CONSCIOUS || QDELETED(victim) || !executioner.Adjacent(victim))
		return
	if(SEND_SIGNAL(executioner, COMSIG_BASICMOB_PRE_RANGED_ATTACK, victim) & COMPONENT_CANCEL_RANGED_ATTACK)
		return
	playsound(executioner, executioner.projectile_sound, 100, TRUE)
	announce_hit(executioner, victim)
	spray_blood(executioner, victim)

// the same line a round hitting them would give
/datum/ai_behavior/execute_downed/proc/announce_hit(mob/living/basic/human/executioner, mob/living/carbon/human/victim)
	var/datum/component/ranged_attacks/ranged_attack = executioner.GetComponent(/datum/component/ranged_attacks)
	var/obj/projectile/fired_type = ranged_attack?.get_projectile_type()
	if(!fired_type)
		return
	var/hitsound = initial(fired_type.hitsound)
	if(hitsound)
		playsound(get_turf(victim), hitsound, 100, TRUE, -1)
	var/proj_name = initial(fired_type.name)
	var/obj/item/ammo_casing/casing = executioner.casing_type
	var/pellets = ispath(casing) ? initial(casing.pellets) : 1
	if(pellets > 1)
		victim.visible_message(span_danger("[victim] is hit by [pellets] [proj_name]s in the head!"), span_userdanger("You're hit by [pellets] [proj_name]s in the head!"), null, COMBAT_MESSAGE_RANGE)
		return
	victim.visible_message(span_danger("[victim] is hit by \a [proj_name] in the head!"), span_userdanger("You're hit by \a [proj_name] in the head!"), null, COMBAT_MESSAGE_RANGE)

// cosmetic blood since the damage is "faked"
/datum/ai_behavior/execute_downed/proc/spray_blood(mob/living/basic/human/executioner, mob/living/carbon/human/victim)
	if(!victim.blood_volume)
		return
	var/turf/victim_turf = get_turf(victim)
	var/obj/item/bodypart/head = victim.get_bodypart(BODY_ZONE_HEAD)
	if(head && !IS_ORGANIC_LIMB(head))
		do_sparks(2, FALSE, victim_turf) // a robotic head sparks instead
		return
	new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim_turf, get_dir(executioner, victim), victim.dna.blood_type.color)
	victim.add_splatter_floor(victim_turf)

// only as much damage as it takes to kill them
/datum/ai_behavior/execute_downed/proc/finish_off(mob/living/basic/human/executioner, mob/living/carbon/human/victim, style)
	if(style == AI_EXECUTION_GUN)
		victim.visible_message(span_warning("[executioner] pulls the trigger!"), span_big(span_userdanger("[executioner] pulls the trigger!")))
		tell_unseeing(victim, span_big(span_userdanger("A deafening crack, and then nothing.")))
		playsound(executioner, executioner.projectile_sound, 100, TRUE)
		alert_ai_to_gunfire(executioner, SUPPRESSED_NONE, FALSE, executioner)
		announce_hit(executioner, victim)
		var/list/pattern = get_gun_trigger_pattern(executioner.get_gun_type())
		if(pattern)
			for(var/shot in 2 to pattern[1])
				addtimer(CALLBACK(src, PROC_REF(fire_follow_up), WEAKREF(executioner), WEAKREF(victim)), (shot - 1) * pattern[2])
	else
		victim.visible_message(span_danger("[executioner] slits [victim]'s throat!"), span_big(span_userdanger("[executioner] slits your throat!")))
		tell_unseeing(victim, span_big(span_userdanger("The blade draws across, and everything fades.")))
		playsound(victim, 'sound/weapons/slice.ogg', 50, TRUE, -1)
	spray_blood(executioner, victim)
	var/damage_type = BRUTE
	var/sharpness
	var/wound_bonus = 0
	var/bare_wound_bonus = 0
	if(style == AI_EXECUTION_GUN)
		var/datum/component/ranged_attacks/ranged_attack = executioner.GetComponent(/datum/component/ranged_attacks)
		var/obj/projectile/fired_type = ranged_attack?.get_projectile_type()
		if(fired_type)
			damage_type = initial(fired_type.damage_type)
			sharpness = initial(fired_type.sharpness)
			wound_bonus = initial(fired_type.wound_bonus)
			bare_wound_bonus = initial(fired_type.bare_wound_bonus)
	else
		var/obj/item/blade = get_ai_item_template(executioner.get_execution_blade())
		damage_type = blade.damtype
		sharpness = blade.get_sharpness()
		wound_bonus = blade.wound_bonus
		bare_wound_bonus = blade.bare_wound_bonus
	var/attack_direction = get_dir(executioner, victim)
	// never ever decap or debrain
	var/list/kept_dismemberable = list()
	for(var/zone in list(BODY_ZONE_HEAD, BODY_ZONE_CHEST))
		var/obj/item/bodypart/part = victim.get_bodypart(zone)
		if(part)
			kept_dismemberable[part] = part.dismemberable
			part.dismemberable = FALSE
	victim.apply_damage(victim.health - HEALTH_THRESHOLD_DEAD + 1, damage_type, BODY_ZONE_HEAD, forced = TRUE, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness, attack_direction = attack_direction)
	if(victim.stat != DEAD) // roll over excess damage to the chest
		victim.apply_damage(victim.health - HEALTH_THRESHOLD_DEAD + 1, damage_type, BODY_ZONE_CHEST, forced = TRUE, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness, attack_direction = attack_direction)
	for(var/obj/item/bodypart/part as anything in kept_dismemberable)
		if(!QDELETED(part))
			part.dismemberable = kept_dismemberable[part]
	log_combat(executioner, victim, "executed")
	var/datum/component/ai_callouts/callouts = executioner.GetComponent(/datum/component/ai_callouts)
	callouts?.call_out_downed(WEAKREF(victim), REF(victim)) // our kill, and if they were the last, it's over
