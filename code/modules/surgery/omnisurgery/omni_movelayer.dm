/datum/surgery_step/omni/skindown
	name = "Dermal Incision"
	implements = list(
		TOOL_SCALPEL = 100)
	time = 2.5 SECONDS
	show = TRUE
	required_layer = list(0)

/datum/surgery_step/omni/skindown/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer++
	return ..()

/datum/surgery_step/omni/muscledown
	name = "Retract Muscle"
	implements = list(
		TOOL_RETRACTOR = 100)
	time = 2.5 SECONDS
	show = TRUE
	required_layer = list(1)

/datum/surgery_step/omni/muscledown/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer++
	return ..()

/datum/surgery_step/omni/close
	name = "Finish Surgery"
	implements = list(
		TOOL_CAUTERY = 100,
		TOOL_WELDER = 40,
		/obj/item/gun/energy/laser = 60)
	time = 2.4 SECONDS
	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/cautery2.ogg'
	show = TRUE
	required_layer = list(0,1,2)


/datum/surgery_step/omni/close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to mend the incision in [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] begins to mend the incision in [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] begins to mend the incision in [target]'s [parse_zone(target_zone)].</span>")

/datum/surgery_step/omni/close/tool_check(mob/user, obj/item/tool)
	if(implement_type == TOOL_WELDER || implement_type == /obj/item)
		return tool.get_temperature()

	return TRUE

/datum/surgery_step/omni/close/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if (ishuman(target))
		var/mob/living/carbon/human/H = target
		H.bleed_rate = max((H.bleed_rate - 3), 0)
	surgery.complete()
	return ..()
