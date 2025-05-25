/*\ Mechanical Surgery for IPC's and the augmented \*/

/datum/surgery/brain_surgery/mechanic
	name = "Mechanical brain surgery"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fix_brain/mechanic,
		/datum/surgery_step/close_hatch,
		/datum/surgery_step/mechanic_close
	)
	lying_required = FALSE
	self_operable = TRUE

/datum/surgery_step/fix_brain/mechanic
	implements = list(
		TOOL_MULTITOOL = 85,
		TOOL_HEMOSTAT = 85,
		TOOL_SCREWDRIVER = 40,
		/obj/item/pen = 5
	)

/datum/surgery/prosthesis_removal
	name = "Detach prosthesis"
	steps = list(/datum/surgery_step/mechanic_open, /datum/surgery_step/open_hatch, /datum/surgery_step/prepare_electronics, /datum/surgery_step/mechanic_unwrench, /datum/surgery_step/prosthesis_removal)
	possible_locs = list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG) // adding BODY_ZONE_HEAD would allow IPCs to remove their heads, could be funny if it weren't for the fact that it breaks their mutcolors and kills FBPs. Future explorers, if you want to fix these issues, you have my blessing
	requires_bodypart_type = BODYTYPE_ROBOTIC
	lying_required = FALSE
	self_operable = TRUE
	ignore_clothes = TRUE

/datum/surgery/prosthesis_attachment
	name = "Prosthesis attachment"
	steps = list(/datum/surgery_step/mechanic_wrench, /datum/surgery_step/prepare_electronics, /datum/surgery_step/add_prosthetic, /datum/surgery_step/close_hatch, /datum/surgery_step/mechanic_close)
	possible_locs = list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_HEAD)
	requires_bodypart = FALSE //need a missing limb
	requires_bodypart_type = 0
	lying_required = FALSE
	self_operable = TRUE
	ignore_clothes = TRUE

/datum/surgery/prosthesis_attachment/can_start(mob/user, mob/living/carbon/target)
	if(!iscarbon(target))
		return FALSE
	var/mob/living/carbon/C = target
	if(!C.get_bodypart(user.zone_selected)) //can only start if limb is missing
		return TRUE

/datum/surgery_step/repair_structure
	name = "replace structural rods"
	time = 3.4 SECONDS
	implements = list(
		/obj/item/stack/rods = 100
		)
	preop_sound = 'sound/items/ratchet.ogg'
	success_sound = 'sound/items/taperecorder_close.ogg'

/datum/surgery_step/repair_structure/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/stack/rods = tool
	if(!tool || rods.get_amount() < 2)
		to_chat(user, span_warning("You need at least two rods to do this!"))
		return -1
	if(target_zone == BODY_ZONE_HEAD)
		user.visible_message("[user] begins to reinforce [target]'s skull with [tool]...", span_notice("You begin to reinforce [target]'s skull with [tool]..."))
	else
		user.visible_message("[user] begins to replace the rods in [target]'s [parse_zone(target_zone)]...", span_notice("You begin replacing the rods in [target]'s [parse_zone(target_zone)]..."))

/datum/surgery_step/repair_structure/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/stack/rods = tool
	if(!tool || rods.get_amount() < 2)
		to_chat(user, span_warning("You need at least two rods to do this!"))
		return FALSE
	user.visible_message("[user] successfully restores integrity to [target]'s [parse_zone(target_zone)]!", span_notice("You successfully restore integrity to [target]'s [parse_zone(target_zone)]."))
	//restore all integrity-induced damage, so that they don't just weld themselves into a mess again
	var/integ_heal = surgery.operated_bodypart.integrity_loss //ignore integrity_ignored as a little surgery bonus
	var/brute_heal = min(surgery.operated_bodypart.brute_dam,integ_heal)
	var/burn_heal = max(0,integ_heal-brute_heal)
	surgery.operated_bodypart.integrity_loss = 0
	surgery.operated_bodypart.heal_damage(brute_heal,burn_heal,0,null,BODYTYPE_ROBOTIC)
	tool.use(2)
	return TRUE


/datum/surgery/integrity
	name = "Replace structure"
	possible_locs = list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/repair_structure,
		/datum/surgery_step/mechanic_close
	)
	requires_bodypart = TRUE
	lying_required = TRUE
	self_operable = FALSE
