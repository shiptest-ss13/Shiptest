// Formerly prosthetic_replacement.dm

/datum/surgery/limb_grafting
	name = "Limb grafting"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/graft_limb)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_HEAD)
	requires_bodypart = FALSE //need a missing limb
	requires_bodypart_type = 0

/datum/surgery/limb_grafting/can_start(mob/user, mob/living/carbon/target)
	if(!iscarbon(target))
		return 0
	var/mob/living/carbon/C = target
	if(!C.get_bodypart(user.zone_selected)) //can only start if limb is missing
		return 1

/datum/surgery_step/graft_limb
	name = "graft limb"
	implements = list(
		/obj/item/bodypart = 100,
		/obj/item/organ_storage = 100)
//		/obj/item/chainsaw = 100,
//		/obj/item/melee/synthetic_arm_blade = 100)
// Frankly these have always bothered me. They fill like a bad fit for Shiptest.
// Marking out for now. Keeping the later code used to install unconventional prostheses just in case someone finds a good use for it.

	time = 32
	experience_given = MEDICAL_SKILL_ORGAN_FIX //won't get full XP if rejected
	var/organ_rejection_dam = 0

/datum/surgery_step/graft_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(istype(tool, /obj/item/organ_storage))
		if(!tool.contents.len)
			to_chat(user, span_warning("There is nothing inside [tool]!"))
			return -1
		var/obj/item/I = tool.contents[1]
		if(!isbodypart(I))
			to_chat(user, span_warning("[I] cannot be attached!"))
			return -1
		tool = I
	if(istype(tool, /obj/item/bodypart))
		var/obj/item/bodypart/BP = tool
		if(ismonkey(target))// monkey patient only accept organic monkey limbs
			if(!IS_ORGANIC_LIMB(BP) || BP.animal_origin != MONKEY_BODYPART)
				to_chat(user, span_warning("[BP] doesn't match the patient's morphology."))
				return -1
		if(IS_ORGANIC_LIMB(BP))
			organ_rejection_dam = 10
			if(ishuman(target))
				if(BP.animal_origin)
					to_chat(user, span_warning("[BP] doesn't match the patient's morphology."))
					return -1
				var/mob/living/carbon/human/H = target
				if(H.dna.species.id != BP.limb_id)
					organ_rejection_dam = 30

		if(target_zone == BP.body_zone) //so we can't replace a leg with an arm, or a human arm with a monkey arm.
			display_results(user, target, span_notice("You begin to replace [target]'s [parse_zone(target_zone)] with [tool]..."),
				span_notice("[user] begins to replace [target]'s [parse_zone(target_zone)] with [tool]."),
				span_notice("[user] begins to replace [target]'s [parse_zone(target_zone)]."))
		else
			to_chat(user, span_warning("[tool] isn't the right type for [parse_zone(target_zone)]."))
			return -1
	else if(target_zone == BODY_ZONE_L_ARM || target_zone == BODY_ZONE_R_ARM)
		display_results(user, target, span_notice("You begin to attach [tool] onto [target]..."),
			span_notice("[user] begins to attach [tool] onto [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] begins to attach something onto [target]'s [parse_zone(target_zone)]."))
	else
		to_chat(user, span_warning("[tool] must be installed onto an arm."))
		return -1

/datum/surgery_step/graft_limb/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(istype(tool, /obj/item/organ_storage))
		tool.icon_state = initial(tool.icon_state)
		tool.desc = initial(tool.desc)
		tool.cut_overlays()
		tool = tool.contents[1]
	if(istype(tool, /obj/item/bodypart) && user.temporarilyRemoveItemFromInventory(tool))
		var/obj/item/bodypart/L = tool
		if(!L.attach_limb(target))
			display_results(user, target, span_warning("You fail in replacing [target]'s [parse_zone(target_zone)]! Their body has rejected [L]!"),
				span_warning("[user] fails to replace [target]'s [parse_zone(target_zone)]!"),
				span_warning("[user] fails to replaces [target]'s [parse_zone(target_zone)]!"))
			L.forceMove(target.loc)
			return
		if(organ_rejection_dam)
			target.adjustToxLoss(organ_rejection_dam)
			experience_given -= (round(organ_rejection_dam/10))
		display_results(user, target, span_notice("You succeed in replacing [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] successfully replaces [target]'s [parse_zone(target_zone)] with [tool]!"),
			span_notice("[user] successfully replaces [target]'s [parse_zone(target_zone)]!"))
		return
	else
		var/obj/item/bodypart/L = target.new_body_part(target_zone, FALSE, FALSE)
		L.is_pseudopart = TRUE
		if(!L.attach_limb(target))
			display_results(user, target, span_warning("You fail in attaching [target]'s [parse_zone(target_zone)]! Their body has rejected [L]!"),
				span_warning("[user] fails to attach [target]'s [parse_zone(target_zone)]!"),
				span_warning("[user] fails to attach [target]'s [parse_zone(target_zone)]!"))
			L.forceMove(target.loc)
			return
		user.visible_message(span_notice("[user] finishes attaching [tool]!"), span_notice("You attach [tool]."))
		display_results(user, target, span_notice("You attach [tool]."),
			span_notice("[user] finishes attaching [tool]!"),
			span_notice("[user] finishes the attachment procedure!"))
		qdel(tool)
		if(istype(tool, /obj/item/chainsaw))
			var/obj/item/mounted_chainsaw/new_arm = new(target)
			target_zone == BODY_ZONE_R_ARM ? target.put_in_r_hand(new_arm) : target.put_in_l_hand(new_arm)
			return
		else if(istype(tool, /obj/item/melee/synthetic_arm_blade))
			var/obj/item/melee/arm_blade/new_arm = new(target,TRUE,TRUE)
			target_zone == BODY_ZONE_R_ARM ? target.put_in_r_hand(new_arm) : target.put_in_l_hand(new_arm)
			return
	return ..() //if for some reason we fail everything we'll print out some text okay?
