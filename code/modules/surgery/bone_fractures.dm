/// Operations ///

// Repair Hairline Fracture (Severe)
/datum/surgery/repair_hairline_fracture
	name = "repair hairline fracture"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/repair_hairline_fracture, /datum/surgery_step/close)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_R_ARM,BODY_ZONE_L_ARM,BODY_ZONE_R_LEG,BODY_ZONE_L_LEG,BODY_ZONE_CHEST,BODY_ZONE_HEAD)
	requires_real_bodypart = TRUE
	targetable_wound = /datum/wound/blunt/bone/severe

/datum/surgery/repair_hairline_fracture/can_start(mob/living/user, mob/living/carbon/target)
	if(..())
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		return(targeted_bodypart.get_wound_type(targetable_wound))

// Repair Compound Fracture (Critical)
/datum/surgery/repair_bone_compound
	name = "repair compound fracture"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/retract_skin, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/reset_compound_fracture, /datum/surgery_step/repair_compound_fracture, /datum/surgery_step/close)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_R_ARM,BODY_ZONE_L_ARM,BODY_ZONE_R_LEG,BODY_ZONE_L_LEG,BODY_ZONE_CHEST,BODY_ZONE_HEAD)
	requires_real_bodypart = TRUE
	targetable_wound = /datum/wound/blunt/bone/critical

/datum/surgery/reset_compound_fracture/can_start(mob/living/user, mob/living/carbon/target)
	if(..())
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		return(targeted_bodypart.get_wound_type(targetable_wound))

/// Steps ///

// Hairline
/datum/surgery_step/repair_hairline_fracture
	name = "repair hairline fracture"
	implements = list(/obj/item/bonesetter = 100, /obj/item/stack/medical/bone_gel = 100, /obj/item/stack/sticky_tape/surgical = 100, /obj/item/stack/sticky_tape/super = 50, /obj/item/stack/sticky_tape = 30)
	time = 40

/datum/surgery_step/repair_hairline_fracture/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(user, target, "<span class='notice'>You begin to repair the fracture in [target]'s [parse_zone(user.zone_selected)]...</span>",
			"<span class='notice'>[user] begins to repair the fracture in [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
			"<span class='notice'>[user] begins to repair the fracture in [target]'s [parse_zone(user.zone_selected)].</span>")
	else
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/repair_hairline_fracture/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(surgery.operated_wound)
		if(istype(tool, /obj/item/stack))
			var/obj/item/stack/used_stack = tool
			used_stack.use(1)
		display_results(user, target, "<span class='notice'>You successfully repair the fracture in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] successfully repairs the fracture in [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully repairs the fracture in [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "repaired a hairline fracture in", addition="INTENT: [uppertext(user.a_intent)]")
		surgery.operated_wound.attached_surgery = null
		QDEL_NULL(surgery.operated_wound)
	else
		to_chat(user, "<span class='warning'>[target] has no hairline fracture there!</span>")
	return ..()

/datum/surgery_step/repair_hairline_fracture/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob = 0)
	..()
	if(istype(tool, /obj/item/stack))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)

// Reset Compound
/datum/surgery_step/reset_compound_fracture
	name = "reset compound fracture"
	implements = list(/obj/item/bonesetter = 100, /obj/item/stack/medical/bone_gel = 100, /obj/item/stack/sticky_tape/surgical = 100, /obj/item/stack/sticky_tape/super = 50, /obj/item/stack/sticky_tape = 30)
	time = 40

/datum/surgery_step/reset_compound_fracture/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(user, target, "<span class='notice'>You begin to reset the bone in [target]'s [parse_zone(user.zone_selected)]...</span>",
			"<span class='notice'>[user] begins to reset the bone in [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
			"<span class='notice'>[user] begins to reset the bone in [target]'s [parse_zone(user.zone_selected)].</span>")
	else
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/reset_compound_fracture/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(surgery.operated_wound)
		if(istype(tool, /obj/item/stack))
			var/obj/item/stack/used_stack = tool
			used_stack.use(1)
		display_results(user, target, "<span class='notice'>You successfully repair the fracture in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] successfully repairs the fracture in [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully repairs the fracture in [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "repaired a compound fracture in", addition="INTENT: [uppertext(user.a_intent)]")
		surgery.operated_wound.attached_surgery = null
		QDEL_NULL(surgery.operated_wound)
	else
		to_chat(user, "<span class='warning'>[target] has no compound fracture there!</span>")
	return ..()

/datum/surgery_step/reset_compound_fracture/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob = 0)
	..()
	if(istype(tool, /obj/item/stack))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)

//Repair compound
/datum/surgery_step/repair_compound_fracture
	name = "repair compound fracture"
	implements = list(/obj/item/bonesetter = 100, /obj/item/stack/medical/bone_gel = 100, /obj/item/stack/sticky_tape/surgical = 100, /obj/item/stack/sticky_tape/super = 50, /obj/item/stack/sticky_tape = 30)
	time = 40

/datum/surgery/repair_compound_fracture/can_start(mob/living/user, mob/living/carbon/target)
	if(..())
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		return(targeted_bodypart.get_wound_type(targetable_wound))

/datum/surgery_step/repair_compound_fracture/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(user, target, "<span class='notice'>You begin to repair the fracture in [target]'s [parse_zone(user.zone_selected)]...</span>",
			"<span class='notice'>[user] begins to repair the fracture in [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
			"<span class='notice'>[user] begins to repair the fracture in [target]'s [parse_zone(user.zone_selected)].</span>")
	else
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/repair_compound_fracture/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(surgery.operated_wound)
		if(istype(tool, /obj/item/stack))
			var/obj/item/stack/used_stack = tool
			used_stack.use(1)
		display_results(user, target, "<span class='notice'>You successfully repair the fracture in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] successfully repairs the fracture in [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully repairs the fracture in [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "repaired a compound fracture in", addition="INTENT: [uppertext(user.a_intent)]")
		QDEL_NULL(surgery.operated_wound)
	else
		to_chat(user, "<span class='warning'>[target] has no compound fracture there!</span>")
	return ..()
