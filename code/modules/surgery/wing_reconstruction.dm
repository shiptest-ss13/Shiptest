/datum/surgery/wing_repair
	name = "Repair wings"
	desc = "A procedure involving synthflesh to repair the wings of a mothperson"
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/wing_repair
		)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery/wing_repair/can_start(mob/living/user, mob/living/carbon/target)
	if(target.dna.features["moth_wings"] == "Burnt Off")
		return TRUE

/datum/surgery_step/wing_repair
	name = "Repair wings"
	implements = list(
		TOOL_HEMOSTAT = 100,
		TOOL_SCREWDRIVER = 40)
	time = 10 SECONDS
	preop_sound = 'sound/surgery/hemostat1.ogg'
	success_sound = 'sound/surgery/hemostat1.ogg'
	failure_sound = 'sound/surgery/organ2.ogg'
	chems_needed = list(/datum/reagent/medicine/synthflesh)
	experience_given = MEDICAL_SKILL_MEDIUM
	fuckup_damage = 15

/datum/surgery_step/wing_repair/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to repair [target]'s wings..."),
		span_notice("[user] begins to repair [target]'s wings."),
		span_notice("[user] begins to repair [target]'s wings."))

/datum/surgery_step/wing_repair/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/obj/item/organ/moth_wings/M = target.getorganslot(ORGAN_SLOT_WINGS)
	target.dna.features["moth_wings"] = M.original_wings
	target.dna.species.handle_mutant_bodyparts(target)
	display_results(user, target, span_notice("You successfully repair [target]'s wings."),
		span_notice("[user] successfully repairs [target]'s wings."),
		span_notice("[user] successfully repairs [target]'s wings."))
	return ..()

/datum/surgery_step/wing_repair/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery)
	display_results(user, target, span_warning("You fail to repair [target]'s wings!"),
		span_warning("[user] fails to repair [target]'s wings!"),
		span_warning("[user] fails to repair [target]'s wings!"))
