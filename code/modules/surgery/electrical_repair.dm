/// Minimum temperature to melt the solder.
#define SOLDER_MELTING_POINT 600

/datum/surgery/repair_electrical_damage
	name = "Repair Damaged Electronics"
	desc = "Repairs damaged electronics inside a robotic limb."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/replace_wiring,
		/datum/surgery_step/solder_wiring,
		/datum/surgery_step/close_hatch,
		/datum/surgery_step/mechanic_close,
	)
	lying_required = FALSE
	self_operable = TRUE
	targetable_wound = /datum/wound/electric/severe

/datum/surgery/repair_electrical_damage/can_start(mob/user, mob/living/patient)
	if(!..())
		return FALSE
	var/obj/item/bodypart/targeted_bodypart = patient.get_bodypart(user.zone_selected)
	var/datum/wound/electric/targeted_wound = targeted_bodypart.get_wound_type(targetable_wound)
	if(isnull(targeted_wound))
		return FALSE
	if(user == patient && targeted_wound.affected_organ?.slot == ORGAN_SLOT_BRAIN)
		return FALSE // can't operate on your own brain
	return TRUE

/datum/surgery/repair_short_circuit
	name = "Repair Short Circuit"
	desc = "Repairs short-circuiting electronics inside a robotic limb."
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/replace_capacitor,
		/datum/surgery_step/replace_wiring,
		/datum/surgery_step/solder_wiring,
		/datum/surgery_step/close_hatch,
		/datum/surgery_step/mechanic_close,
	)
	lying_required = FALSE
	self_operable = TRUE
	targetable_wound = /datum/wound/electric/critical

/datum/surgery/repair_short_circuit/can_start(mob/user, mob/living/patient)
	if(!..())
		return FALSE
	var/obj/item/bodypart/targeted_bodypart = patient.get_bodypart(user.zone_selected)
	var/datum/wound/electric/targeted_wound = targeted_bodypart.get_wound_type(targetable_wound)
	if(isnull(targeted_wound))
		return FALSE
	if(user == patient && targeted_wound.affected_organ?.slot == ORGAN_SLOT_BRAIN)
		return FALSE
	return TRUE

/datum/surgery_step/replace_capacitor
	name = "replace capacitor"
	implements = list(
		/obj/item/stock_parts/capacitor = 100,
	)
	preop_sound = 'sound/items/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder_close.ogg'
	failure_sound = 'sound/machines/defib_zap.ogg'
	time = 3 SECONDS

/datum/surgery_step/replace_capacitor/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target,
		span_notice("You start replacing the electronic components inside [target]'s [parse_zone(target_zone)]..."),
		span_notice("[user] starts replacing the electronic components inside [target]'s [parse_zone(target_zone)] with [tool]..."),
		span_notice("[user] starts replacing the electronic components inside [target]'s [parse_zone(target_zone)]...")
	)
/datum/surgery_step/replace_capacitor/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(surgery.operated_wound)
		qdel(tool)
	return ..()

/datum/surgery_step/replace_wiring
	name = "replace wiring"
	implements = list(
		/obj/item/stack/cable_coil = 100,
	)
	time = 3 SECONDS

/datum/surgery_step/replace_wiring/tool_check(mob/user, obj/item/tool)
	if(isstack(tool))
		var/obj/item/stack/new_wiring = tool
		if(new_wiring.amount < 5)
			to_chat(user, span_warning("You need 5 lengths of cable to replace the wiring!"))
			return FALSE
	return ..()

/datum/surgery_step/replace_wiring/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target,
		span_notice("You start replacing the wires inside [target]'s [parse_zone(target_zone)]..."),
		span_notice("[user] starts replacing the wires inside [target]'s [parse_zone(target_zone)] with [tool]..."),
		span_notice("[user] starts replacing the wires inside [target]'s [parse_zone(target_zone)]...")
	)

/datum/surgery_step/replace_wiring/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	. = ..()
	tool.use(5)

/datum/surgery_step/solder_wiring
	name = "solder wiring"
	implements = list(
		TOOL_WELDER = 100,
		TOOL_CAUTERY = 100,
		/obj/item/reagent_containers = 100,
		/obj/item = 40,
	)
	time = 5 SECONDS

/datum/surgery_step/solder_wiring/tool_check(mob/user, obj/item/tool)
	if(tool.type == /obj/item && tool.get_temperature() < SOLDER_MELTING_POINT)
		return FALSE
	if(istype(tool, /obj/item/reagent_containers) && tool.reagents?.get_reagent_amount(/datum/reagent/medicine/liquid_solder) < 2)
		to_chat(user, span_warning("You need more liquid solder to repair the wiring!"))
		return FALSE
	if(tool.usesound)
		preop_sound = pick(tool.usesound)
		success_sound = pick(tool.usesound)
	return ..()

/datum/surgery_step/solder_wiring/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(istype(tool, /obj/item/reagent_containers))
		display_results(user, target,
			span_notice("You start adding new solder to [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] starts adding new solder to [target]'s [parse_zone(target_zone)] with [tool]..."),
			span_notice("[user] starts adding new solder to [target]'s [parse_zone(target_zone)]...")
		)
	else
		display_results(user, target,
			span_notice("You start heating the solder inside [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] starts heating the solder inside [target]'s [parse_zone(target_zone)] with [tool]..."),
			span_notice("[user] starts heating the solder inside [target]'s [parse_zone(target_zone)]...")
		)

/datum/surgery_step/solder_wiring/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if(surgery.operated_wound)
		display_results(user, target,
			span_notice("You solder the new wiring inside [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] solders the new wiring inside [target]'s [parse_zone(target_zone)] with [tool]."),
			span_notice("[user] solders the new wiring inside [target]'s [parse_zone(target_zone)].")
		)
		surgery.operated_wound.attached_surgery = null
		QDEL_NULL(surgery.operated_wound)
	return ..()

/datum/surgery_step/solder_wiring/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob)
	if(surgery.operated_bodypart)
		surgery.operated_bodypart.wound_roll(0, rand(20, 40))
	return ..()

#undef SOLDER_MELTING_POINT
