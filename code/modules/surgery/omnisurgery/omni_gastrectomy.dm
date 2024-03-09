////Gastrectomy, because we truly needed a way to repair stomachs.
//95% chance of success to be consistent with most organ-repairing surgeries.
/datum/surgery_step/omni/gastrectomy
	name = "remove lower duodenum"
	implements = list(
		TOOL_SCALPEL = 95,
		/obj/item/melee/transforming/energy/sword = 33,
		/obj/item/kitchen/knife = 40,
		/obj/item/shard = 10)
	time = 52
	experience_given = (MEDICAL_SKILL_ORGAN_FIX*0.8) //for consistency across organ surgeries
	required_layer = list(4)
	show = TRUE
	valid_locations = list(BODY_ZONE_CHEST)

/datum/surgery_step/omni/gastrectomy/test_op(mob/user, mob/living/target, datum/surgery/omni/surgery)
	var/obj/item/organ/stomach/L = target.getorganslot(ORGAN_SLOT_STOMACH)
	if(L?.damage > 50 && !(L.organ_flags & ORGAN_FAILING))
		return TRUE
	return FALSE

/datum/surgery_step/omni/gastrectomy/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to cut out a damaged piece of [target]'s stomach...</span>",
		"<span class='notice'>[user] begins to make an incision in [target].</span>",
		"<span class='notice'>[user] begins to make an incision in [target].</span>")

/datum/surgery_step/omni/gastrectomy/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/mob/living/carbon/human/H = target
	H.setOrganLoss(ORGAN_SLOT_STOMACH, 10) // Stomachs have a threshold for being able to even digest food, so I might tweak this number
	display_results(user, target, "<span class='notice'>You successfully remove the damaged part of [target]'s stomach.</span>",
		"<span class='notice'>[user] successfully removes the damaged part of [target]'s stomach.</span>",
		"<span class='notice'>[user] successfully removes the damaged part of [target]'s stomach.</span>")
	return ..()

/datum/surgery_step/omni/gastrectomy/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery)
	var/mob/living/carbon/human/H = target
	H.adjustOrganLoss(ORGAN_SLOT_STOMACH, 20)
	display_results(user, target, "<span class='warning'>You cut the wrong part of [target]'s stomach!</span>",
		"<span class='warning'>[user] cuts the wrong part of [target]'s stomach!</span>",
		"<span class='warning'>[user] cuts the wrong part of [target]'s stomach!</span>")
