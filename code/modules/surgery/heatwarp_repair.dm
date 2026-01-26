/datum/surgery/repair_heat_warp
	name = "Repair Deformed Chassis"
	desc = "Replaces the heat-warped plating and frame of a robotic limb."
	steps = list(
		/datum/surgery_step/cut_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/replace_frame,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/add_plating,
		/datum/surgery_step/weld_plating,
	)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	self_operable = TRUE
	targetable_wound = /datum/wound/burn/heat_warping/critical

/datum/surgery/repair_sheared_frame/can_start(mob/user, mob/living/patient)
	if(!..())
		return FALSE
	var/obj/item/bodypart/targeted_bodypart = patient.get_bodypart(user.zone_selected)
	return !isnull(targeted_bodypart.get_wound_type(targetable_wound))
