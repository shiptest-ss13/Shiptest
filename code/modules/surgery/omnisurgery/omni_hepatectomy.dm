////hepatectomy, removes damaged parts of the liver so that the liver may regenerate properly
//95% chance of success, not 100 because organs are delicate
/datum/surgery_step/omni/hepatectomy
	name = "Remove damaged liver section"
	implements = list(
		TOOL_SCALPEL = 95,
		/obj/item/melee/transforming/energy/sword = 33,
		/obj/item/kitchen/knife = 40,
		/obj/item/shard = 25)
	time = 52
	experience_given = (MEDICAL_SKILL_ORGAN_FIX*0.8) //repeatable so not as much xp
	valid_locations = list(BODY_ZONE_CHEST)
	required_layer = list(4)
	show = TRUE
/datum/surgery_step/omni/hepatectomy/test_op(mob/user, mob/living/target, datum/surgery/omni/surgery)
	var/obj/item/organ/liver/L = target.getorganslot(ORGAN_SLOT_LIVER)
	if(L?.damage > 50 && !(L.organ_flags & ORGAN_FAILING))
		return TRUE
	return FALSE


/datum/surgery_step/omni/hepatectomy/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to cut out a damaged peice of [target]'s liver...</span>",
		"<span class='notice'>[user] begins to make an incision in [target].</span>",
		"<span class='notice'>[user] begins to make an incision in [target].</span>")

/datum/surgery_step/omni/hepatectomy/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/mob/living/carbon/human/H = target
	H.setOrganLoss(ORGAN_SLOT_LIVER, 10) //not bad, not great
	display_results(user, target, "<span class='notice'>You successfully remove the damaged part of [target]'s liver.</span>",
		"<span class='notice'>[user] successfully removes the damaged part of [target]'s liver.</span>",
		"<span class='notice'>[user] successfully removes the damaged part of [target]'s liver.</span>")
	return ..()

/datum/surgery_step/omni/hepatectomy/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery)
	var/mob/living/carbon/human/H = target
	H.adjustOrganLoss(ORGAN_SLOT_LIVER, 20)
	display_results(user, target, "<span class='warning'>You cut the wrong part of [target]'s liver!</span>",
		"<span class='warning'>[user] cuts the wrong part of [target]'s liver!</span>",
		"<span class='warning'>[user] cuts the wrong part of [target]'s liver!</span>")
