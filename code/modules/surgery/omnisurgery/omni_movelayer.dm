/datum/surgery_step/omni/skindown
	name = "Dermal Incision"
	implements = list(
		TOOL_SCALPEL = 100)
	time = 2.5 SECONDS
	priority = 99
	show = TRUE
	required_layer = 0

/datum/surgery_step/omni/skindown/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer++
	return ..()

/datum/surgery_step/omni/muscledown
	name = "Retract Muscle"
	implements = list(
		TOOL_RETRACTOR = 100)
	time = 2.5 SECONDS
	priority = 99
	show = TRUE
	required_layer = 1

/datum/surgery_step/omni/muscledown/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer++
	return ..()
