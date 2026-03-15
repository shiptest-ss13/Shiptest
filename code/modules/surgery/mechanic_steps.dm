//open shell
/datum/surgery_step/mechanic_open
	name = "unscrew shell"
	implements = list(
		TOOL_SCREWDRIVER		= 100,
		TOOL_SCALPEL 			= 75, // med borgs could try to unscrew shell with scalpel
		/obj/item/melee/knife/kitchen	= 50,
		/obj/item				= 10)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/screwdriver.ogg'
	success_sound = 'sound/items/screwdriver2.ogg'

/datum/surgery_step/mechanic_open/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to unscrew the shell of [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins to unscrew the shell of [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] begins to unscrew the shell of [target]'s [parse_zone(target_zone)]."))

/datum/surgery_step/mechanic_open/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	if(tool.usesound)
		preop_sound = tool.usesound
	return ..()

//close shell
/datum/surgery_step/mechanic_close
	name = "screw shell"
	implements = list(
		TOOL_SCREWDRIVER		= 100,
		TOOL_SCALPEL 			= 75,
		/obj/item/melee/knife/kitchen	= 50,
		/obj/item				= 10)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/screwdriver.ogg'
	success_sound = 'sound/items/screwdriver2.ogg'

/datum/surgery_step/mechanic_close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to screw the shell of [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins to screw the shell of [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] begins to screw the shell of [target]'s [parse_zone(target_zone)]."))

/datum/surgery_step/mechanic_close/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	if(tool.usesound)
		preop_sound = tool.usesound
	return ..()

//prepare electronics
/datum/surgery_step/prepare_electronics
	name = "prepare electronics"
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_HEMOSTAT = 10) // try to reboot internal controllers via short circuit with some conductor
	time = 2.4 SECONDS
	preop_sound = 'sound/items/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder_close.ogg'
	failure_sound = 'sound/machines/defib_zap.ogg'

/datum/surgery_step/prepare_electronics/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to prepare electronics in [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins to prepare electronics in [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] begins to prepare electronics in [target]'s [parse_zone(target_zone)]."))

//unwrench
/datum/surgery_step/mechanic_unwrench
	name = "unwrench bolts"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 10)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/ratchet.ogg'

/datum/surgery_step/mechanic_unwrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to unwrench some bolts in [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins to unwrench some bolts in [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] begins to unwrench some bolts in [target]'s [parse_zone(target_zone)]."))

/datum/surgery_step/mechanic_unwrench/tool_check(mob/user, obj/item/tool)
	if(tool.usesound)
		preop_sound = tool.usesound
	. = ..()

//wrench
/datum/surgery_step/mechanic_wrench
	name = "wrench bolts"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 10)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/ratchet.ogg'

/datum/surgery_step/mechanic_wrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to wrench some bolts in [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins to wrench some bolts in [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] begins to wrench some bolts in [target]'s [parse_zone(target_zone)]."))

/datum/surgery_step/mechanic_wrench/tool_check(mob/user, obj/item/tool)
	if(tool.usesound)
		preop_sound = tool.usesound
	. = ..()

//open hatch
/datum/surgery_step/open_hatch
	name = "open the hatch"
	accept_hand = TRUE
	time = 1 SECONDS
	preop_sound = 'sound/items/ratchet.ogg'
	success_sound = 'sound/machines/doorclick.ogg'

/datum/surgery_step/open_hatch/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to open the hatch holders in [target]'s [parse_zone(target_zone)]..."),
		span_notice("[user] begins to open the hatch holders in [target]'s [parse_zone(target_zone)]."),
		span_notice("[user] begins to open the hatch holders in [target]'s [parse_zone(target_zone)]."))

//close hatch

/datum/surgery_step/close_hatch
	name = "close the hatch"
	accept_hand = TRUE
	time = 1 SECONDS
	preop_sound = 'sound/machines/doorclick.ogg'
	success_sound = 'sound/items/ratchet.ogg'

/datum/surgery_step/close_hatch/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to close the hatch holders in [target]'s [parse_zone(target_zone)]..."),
		span_notice("[user] begins to close the hatch holders in [target]'s [parse_zone(target_zone)]."),
		span_notice("[user] begins to close the hatch holders in [target]'s [parse_zone(target_zone)]."))

//manipulate organs (metal edition)
/datum/surgery_step/manipulate_organs/mechanic
	name = "manipulate mechanical organs"
	preop_sound = 'sound/surgery/organ2.ogg'
	success_sound = 'sound/surgery/organ1.ogg'
	implements_extract = list(
		TOOL_HEMOSTAT = 55,
		TOOL_CROWBAR = 100,
		/obj/item/kitchen/fork = 35)

//prosthesis removal
/datum/surgery_step/prosthesis_removal
	name = "detach prosthesis"
	accept_hand = TRUE //once a prosthesis is unseated, it should be a simple matter of removing it without tools
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_CROWBAR = 100) //exists just in case you want to reflavor your prosthesis as something a little more integrated
	time = 2.8 SECONDS
	preop_sound = 'sound/items/ratchet.ogg'
	success_sound = 'sound/machines/doorclick.ogg'

/datum/surgery_step/prosthesis_removal/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to unseat [target]'s [parse_zone(target_zone)]..."),
		span_notice("[user] begins to unseat [target]'s [parse_zone(target_zone)]!"),
		span_notice("[user] begins to unseat [target]'s [parse_zone(target_zone)]!"))

/datum/surgery_step/prosthesis_removal/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/mob/living/carbon/human/L = target
	display_results(user, target, span_notice("You detach [L]'s [parse_zone(target_zone)]."),
		span_notice("[user] detaches [L]'s [parse_zone(target_zone)]!"),
		span_notice("[user] detaches [L]'s [parse_zone(target_zone)]!"))
	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		target_limb.drop_limb()

//Add prosthetic
/datum/surgery_step/add_prosthetic
	name = "add prosthetic"
	implements = list(
		/obj/item/bodypart = 100)
	time = 32
	experience_given = MEDICAL_SKILL_ORGAN_FIX //won't get full XP if rejected
	var/organ_rejection_dam = 0

/datum/surgery_step/add_prosthetic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(!istype(tool, /obj/item/bodypart))
		to_chat(user, span_warning("[tool] isn't a mechanical prosthesis!"))
		return FALSE
	var/obj/item/bodypart/BP = tool
	if(ishuman(target))
		if(IS_ORGANIC_LIMB(BP))
			to_chat(user, span_warning("[BP] isn't a mechanical prosthesis!"))
			return -1

	if(target_zone != BP.body_zone) //so we can't replace a leg with an arm, or a human arm with a monkey arm.
		to_chat(user, span_warning("[tool] isn't the right type for [parse_zone(target_zone)]."))
		return -1
	display_results(user, target, span_notice("You begin to replace [target]'s [parse_zone(target_zone)] with [tool]..."),
		span_notice("[user] begins to replace [target]'s [parse_zone(target_zone)] with [tool]."),
		span_notice("[user] begins to replace [target]'s [parse_zone(target_zone)]."))

/datum/surgery_step/add_prosthetic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(HAS_TRAIT(tool, TRAIT_NODROP))
		display_results(user, target, "<span class= 'warning'>The [tool] is stuck in your hand!</span>",
			"<span class= 'warning'>The [tool] seems stuck to [user]'s hand!</span>",
			"<span class= 'warning'>The [tool] seems stuck to [user]'s hand!</span>")
		return FALSE
	var/obj/item/bodypart/L = tool
	if(!L.attach_limb(target))
		display_results(user, target, span_warning("You fail to replace [target]'s [parse_zone(target_zone)]! Their body has rejected [L]!"),
			span_warning("[user] fails to replace [target]'s [parse_zone(target_zone)]!"),
			span_warning("[user] fails to replace [target]'s [parse_zone(target_zone)]!"))
		return FALSE
	display_results(user, target, span_notice("You succeed in replacing [target]'s [parse_zone(target_zone)]."),
		span_notice("[user] successfully replaces [target]'s [parse_zone(target_zone)] with [tool]!"),
		span_notice("[user] successfully replaces [target]'s [parse_zone(target_zone)]!"))
	return ..()

// Repair of specific robotic wounds.

/datum/surgery_step/cut_plating
	name = "cut plating"
	implements = list(
		TOOL_DECONSTRUCT = 100,
		TOOL_WELDER = 100,
		TOOL_SAW = 50,
	)
	time = 4 SECONDS

/datum/surgery_step/cut_plating/tool_check(mob/user, obj/item/tool)
	if(tool.usesound)
		preop_sound = pick(tool.usesound)
		success_sound = pick(tool.usesound)
	return ..()

/datum/surgery_step/cut_plating/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(user, target,
			"You begin cutting the plating off of [target]'s [parse_zone(target_zone)]...",
			"[user] begins cutting the plating off of [target]'s [parse_zone(target_zone)] with [tool]...",
			"[user] begins cutting the plating off of [target]'s [parse_zone(target_zone)]...",
		)

/datum/surgery_step/add_plating
	name = "add new plating"
	implements = list(
		/obj/item/construction/rcd = 100,
		/obj/item/stack/sheet/plasteel = 100,
		/obj/item/stack/sheet/mineral/titanium = 100,
		/obj/item/stack/sheet/mineral/plastitanium = 100,
	)
	preop_sound = 'sound/machines/pda_button1.ogg'
	success_sound = 'sound/machines/doorclick.ogg'
	time = 2 SECONDS

/datum/surgery_step/add_plating/tool_check(mob/user, obj/item/tool)
	if(isstack(tool))
		var/obj/item/stack/new_plating = tool
		if(new_plating.amount < 2)
			to_chat(user, span_warning("You need 2 sheets to replace the plating!"))
			return FALSE
	if(istype(tool, /obj/item/construction/rcd))
		var/obj/item/construction/rcd/constructor = tool
		if(constructor.matter < 20)
			to_chat(user, constructor.no_ammo_message)
			return FALSE
	return ..()

/datum/surgery_step/add_plating/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(!surgery.operated_wound)
		return
	if(istype(tool, /obj/item/construction/rcd))
		display_results(user, target,
			span_notice("You begin reconstructing the plating on [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins reconstructing the plating on [target]'s [parse_zone(target_zone)] with [tool]..."),
			span_notice("[user] begins reconstructing the plating on [target]'s [parse_zone(target_zone)]..."),
		)
	else
		display_results(user, target,
			span_notice("You begin replacing the plating on [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins replacing the plating on [target]'s [parse_zone(target_zone)] with [tool]..."),
			span_notice("[user] begins replacing the plating on [target]'s [parse_zone(target_zone)]..."),
		)

/datum/surgery_step/add_plating/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(surgery.operated_wound)
		if(isstack(tool))
			var/obj/item/stack/used_stack = tool
			used_stack.use(2)
		if(istype(tool, /obj/item/construction/rcd))
			var/obj/item/construction/rcd/used_rcd = tool
			used_rcd.useResource(20, user)
			display_results(user, target,
				span_notice("You reconstruct the plating on [target]'s [parse_zone(target_zone)]"),
				span_notice("[user] reconstructs the plating on [target]'s [parse_zone(target_zone)] with [tool]"),
				span_notice("[user] reconstructs the plating on [target]'s [parse_zone(target_zone)]"),
			)
		else
			display_results(user, target,
				span_notice("You replace the plating on [target]'s [parse_zone(target_zone)]"),
				span_notice("[user] replace the plating on [target]'s [parse_zone(target_zone)] with [tool]"),
				span_notice("[user] replace the plating on [target]'s [parse_zone(target_zone)]"),
			)
	return ..()

/datum/surgery_step/add_plating/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob)
	. = ..()
	if(isstack(tool))
		var/obj/item/stack/used_stack = tool
		used_stack.use(2)
	if(istype(tool, /obj/item/construction/rcd))
		var/obj/item/construction/rcd/used_rcd = tool
		used_rcd.useResource(20, user)

/datum/surgery_step/replace_frame
	name = "replace frame"
	implements = list(
		/obj/item/stack/rods = 100,
		/obj/item/construction/rcd = 100,
	)
	preop_sound = 'sound/items/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder_close.ogg'
	time = 2 SECONDS

/datum/surgery_step/replace_frame/tool_check(mob/user, obj/item/tool)
	if(isstack(tool))
		var/obj/item/stack/new_plating = tool
		if(new_plating.amount < 4)
			to_chat(user, span_warning("You need 4 rods to replace the frame!"))
			return FALSE
	if(istype(tool, /obj/item/construction/rcd))
		var/obj/item/construction/rcd/constructor = tool
		if(constructor.matter < 20)
			to_chat(user, constructor.no_ammo_message)
			return FALSE
	return ..()

/datum/surgery_step/replace_frame/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(!surgery.operated_wound)
		return
	if(istype(tool, /obj/item/construction/rcd))
		display_results(user, target,
			span_notice("You begin reconstructing the frame inside [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins reconstructing the frame inside [target]'s [parse_zone(target_zone)] with [tool]..."),
			span_notice("[user] begins reconstructing the frame inside [target]'s [parse_zone(target_zone)]..."),
		)
	else
		display_results(user, target,
			span_notice("You begin replacing the frame inside [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins replacing the frame inside [target]'s [parse_zone(target_zone)] with [tool]..."),
			span_notice("[user] begins replacing the frame inside [target]'s [parse_zone(target_zone)]..."),
		)

/datum/surgery_step/replace_frame/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(surgery.operated_wound)
		if(isstack(tool))
			var/obj/item/stack/used_stack = tool
			used_stack.use(4)
		if(istype(tool, /obj/item/construction/rcd))
			var/obj/item/construction/rcd/used_rcd = tool
			used_rcd.useResource(20, user)
			display_results(user, target,
				span_notice("You reconstruct the frame inside [target]'s [parse_zone(target_zone)]."),
				span_notice("[user] reconstructs the frame inside [target]'s [parse_zone(target_zone)] with [tool]."),
				span_notice("[user] reconstructs the frame inside [target]'s [parse_zone(target_zone)]."),
			)
		else
			display_results(user, target,
				span_notice("You replace the frame inside [target]'s [parse_zone(target_zone)]."),
				span_notice("[user] replace the frame inside [target]'s [parse_zone(target_zone)] with [tool]."),
				span_notice("[user] replace the frame inside [target]'s [parse_zone(target_zone)]."),
			)
	return ..()

/datum/surgery_step/replace_frame/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob)
	. = ..()
	if(isstack(tool))
		var/obj/item/stack/used_stack = tool
		used_stack.use(4)
	if(istype(tool, /obj/item/construction/rcd))
		var/obj/item/construction/rcd/used_rcd = tool
		used_rcd.useResource(20, user)

/datum/surgery_step/weld_plating
	name = "weld plating"
	implements = list(
		TOOL_WELDER = 100,
	)
	time = 3 SECONDS

/datum/surgery_step/weld_plating/tool_check(mob/user, obj/item/tool)
	if(tool.usesound)
		preop_sound = pick(tool.usesound)
		success_sound = pick(tool.usesound)
	return ..()

/datum/surgery_step/weld_plating/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target,
		span_notice("You start welding the plating onto [target]'s [parse_zone(target_zone)]..."),
		span_notice("[user] starts welding the plating onto [target]'s [parse_zone(target_zone)] with [tool]..."),
		span_notice("[user] starts welding the plating onto [target]'s [parse_zone(target_zone)]..."),
	)

/datum/surgery_step/weld_plating/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(surgery.operated_wound)
		display_results(user, target,
			span_notice("You weld the plating onto [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] welds the plating onto [target]'s [parse_zone(target_zone)] with [tool]."),
			span_notice("[user] welds the plating onto [target]'s [parse_zone(target_zone)]."),
		)
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		for(var/datum/wound/plating_wound as anything in targeted_bodypart.wounds) // might have more than one wound solved by replacing the plating
			if(!(plating_wound.wound_flags & PLATING_DAMAGE))
				continue
			if(plating_wound.attached_surgery == surgery)
				plating_wound.attached_surgery = null // detach the wound from this surgery so that it can be completed properly
			qdel(plating_wound)
		if(QDELETED(surgery.operated_wound))
			surgery.operated_wound = null
	return ..()
