/datum/surgery_step/omni/drill_tooth
	name = "Drill Tooth"
	implements = list(
		TOOL_DRILL = 100
	)
	valid_locations = list(BODY_ZONE_PRECISE_MOUTH)
	required_layer = list(1)
	show = TRUE
	time = 16

// Ensure last surgery wasn't drill tooth. Otherwise you could infinitely drill holes into someone's mouth.
/datum/surgery_step/omni/drill_tooth/test_op(mob/user, mob/living/target, datum/surgery/omni/surgery)
	if(!istype(surgery.last_step,/datum/surgery_step/omni/drill_tooth))
		return TRUE
	return FALSE

/datum/surgery_step/omni/implant_pill
	name = "Implant Pill"
	implements = list(
		/obj/item/reagent_containers/pill = 100)
	valid_locations = list(BODY_ZONE_PRECISE_MOUTH)
	required_layer = list(1)
	time = 16
	experience_given = (MEDICAL_SKILL_MEDIUM*0.4) //quick to do

// Ensure last surgery wasn't to implant the pill to ensure you can't keep looping pills into the same tooth infinitely
/datum/surgery_step/omni/implant_pill/test_op(mob/user, mob/living/target, datum/surgery/omni/surgery)
	if(!istype(surgery.last_step,/datum/surgery_step/omni/implant_pill))
		return TRUE
	return FALSE

/datum/surgery_step/omni/implant_pill/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to wedge [tool] in [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to wedge \the [tool] in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to wedge something in [target]'s [parse_zone(target_zone)].</span>")

/datum/surgery_step/omni/implant_pill/success(mob/user, mob/living/carbon/target, target_zone, obj/item/reagent_containers/pill/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(!istype(tool))
		return 0

	user.transferItemToLoc(tool, target, TRUE)

	var/datum/action/item_action/hands_free/activate_pill/P = new(tool)
	P.button.name = "Activate [tool.name]"
	P.target = tool
	P.Grant(target)	//The pill never actually goes in an inventory slot, so the owner doesn't inherit actions from it

	display_results(user, target, "<span class='notice'>You wedge [tool] into [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] wedges \the [tool] into [target]'s [parse_zone(target_zone)]!</span>",
			"<span class='notice'>[user] wedges something into [target]'s [parse_zone(target_zone)]!</span>")
	return ..()

/datum/action/item_action/hands_free/activate_pill
	name = "Activate Pill"

/datum/action/item_action/hands_free/activate_pill/Trigger()
	if(!..())
		return FALSE
	to_chat(owner, "<span class='notice'>You grit your teeth and burst the implanted [target.name]!</span>")
	log_combat(owner, null, "swallowed an implanted pill", target)
	if(target.reagents.total_volume)
		target.reagents.trans_to(owner, target.reagents.total_volume, transfered_by = owner, method = INGEST)
	qdel(target)
	return TRUE
