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
