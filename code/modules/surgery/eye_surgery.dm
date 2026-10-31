/datum/surgery/eye_surgery
	name = "Eye surgery"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/retract_skin, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/fix_eyes, /datum/surgery_step/close)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_PRECISE_EYES)
	requires_bodypart_type = BODYTYPE_ORGANIC

//fix eyes
/datum/surgery_step/fix_eyes
	name = "fix eyes"
	implements = list(
		TOOL_HEMOSTAT = 100,
		TOOL_SCREWDRIVER = 40) //ow! my eyes !
	time = 64
	experience_given = (MEDICAL_SKILL_ORGAN_FIX*0.6) //repeatable and can be done at any damage

/datum/surgery/eye_surgery/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/eyes/E = target.getorganslot(ORGAN_SLOT_EYES)
	if(!E)
		to_chat(user, span_warning("It's hard to do surgery on someone's eyes when [target.p_they()] [target.p_do()]n't have any."))
		return FALSE
	return TRUE

/datum/surgery_step/fix_eyes/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to fix [target]'s eyes..."),
		span_notice("[user] begins to fix [target]'s eyes."),
		span_notice("[user] begins to perform surgery on [target]'s eyes."))

/datum/surgery_step/fix_eyes/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/obj/item/organ/eyes/E = target.getorganslot(ORGAN_SLOT_EYES)
	user.visible_message(span_notice("[user] successfully fixes [target]'s eyes!"), span_notice("You succeed in fixing [target]'s eyes."))
	display_results(user, target, span_notice("You succeed in fixing [target]'s eyes."),
		span_notice("[user] successfully fixes [target]'s eyes!"),
		span_notice("[user] completes the surgery on [target]'s eyes."))
	target.cure_blind(list(EYE_DAMAGE))
	target.set_blindness(0)
	target.cure_nearsighted(list(EYE_DAMAGE))
	target.blur_eyes(35)	//this will fix itself slowly.
	E.setOrganDamage(0)
	return ..()

/datum/surgery_step/fix_eyes/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.getorgan(/obj/item/organ/brain))
		display_results(user, target, span_warning("You accidentally stab [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"),
			span_warning("[user] accidentally stabs [target] right in the brain!"))
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 70)
	else
		display_results(user, target, span_warning("You accidentally stab [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain! Or would have, if [target] had a brain."),
			span_warning("[user] accidentally stabs [target] right in the brain!"))
	return FALSE

/datum/surgery/eye_surgery/mechanic
	name = "Eye repair"
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/replace_wiring,
		/datum/surgery_step/replace_sensor,
		/datum/surgery_step/fix_mechanical_eyes,
		/datum/surgery_step/mechanic_close
	)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_PRECISE_EYES)
	requires_bodypart_type = BODYTYPE_ROBOTIC

//fix eyes
/datum/surgery_step/fix_mechanical_eyes
	name = "recalibrate ocular sensor"
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_ANALYZER = 40,
		TOOL_SCREWDRIVER = 10
	)
	time = 64
	preop_sound = 'sound/items/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder_close.ogg'
	failure_sound = 'sound/machines/defib_zap.ogg'

/datum/surgery_step/fix_mechanical_eyes/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to fix [target]'s eyes..."),
		span_notice("[user] begins to fix [target]'s eyes."),
		span_notice("[user] begins to perform surgery on [target]'s eyes."))

/datum/surgery_step/fix_mechanical_eyes/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/obj/item/organ/eyes/E = target.getorganslot(ORGAN_SLOT_EYES)
	user.visible_message(span_notice("[user] successfully calibrates [target]'s eyes!"), span_notice("You succeed in calibrating [target]'s eyes."))
	display_results(user, target, span_notice("You succeed in calibrating [target]'s eyes."),
		span_notice("[user] successfully calibrates [target]'s eyes!"),
		span_notice("[user] completes the repair on [target]'s eyes."))
	target.cure_blind(list(EYE_DAMAGE))
	target.set_blindness(0)
	target.cure_nearsighted(list(EYE_DAMAGE))
	target.blur_eyes(20)
	E.setOrganDamage(0)
	return ..()

/datum/surgery_step/fix_mechanical_eyes/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_warning("You cause an electrical shock as calibration fails!"),
		span_warning("[user] accidentally causes a shock to arc!"),
		span_warning("[user] accidentally causes a shock to arc!"),
	)
	if(isliving(user))
		var/mob/living/dipshit = user
		dipshit.electrocute_act(10, target)
	do_sparks(2, FALSE, target)
	return FALSE

/datum/surgery_step/replace_sensor
	name = "replace sensor"
	implements = list(
		/obj/item/stock_parts/scanning_module = 100,
	)
	preop_sound = 'sound/items/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder_close.ogg'
	failure_sound = 'sound/machines/defib_zap.ogg'
	time = 3 SECONDS

/datum/surgery_step/replace_sensor/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target,
		span_notice("You start replacing the electronic components inside [target]'s [parse_zone(target_zone)]..."),
		span_notice("[user] starts replacing the electronic components inside [target]'s [parse_zone(target_zone)] with [tool]..."),
		span_notice("[user] starts replacing the electronic components inside [target]'s [parse_zone(target_zone)]...")
	)

/datum/surgery_step/replace_capacitor/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	qdel(tool)
	return ..()
