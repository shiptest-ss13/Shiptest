/datum/surgery_step/omni/apply_bonegel
	name = "Apply Bone Gel"
	time = 6.4 SECONDS
	implements = list(
		TOOL_BONEGEL = 100
		)
	show = TRUE
	preop_sound = 'sound/surgery/bone1.ogg'
	success_sound = 'sound/surgery/bone3.ogg'
	required_layer = list(2)
	radial_icon = /obj/item/kinetic_crusher

// Checks if the bone is broken or splinted and Apply Bonegel surgery wasn't done recently
/datum/surgery_step/omni/apply_bonegel/test_op(mob/user, mob/living/target, datum/surgery/omni/surgery)
	if(istype(target,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		var/obj/item/bodypart/affected = H.get_bodypart(user.zone_selected)
		if(affected && affected.bone_status >= BONE_FLAG_BROKEN && !istype(surgery.last_step,/datum/surgery_step/omni/apply_bonegel))
			return TRUE
		return FALSE

/datum/surgery_step/omni/set_bone
	name = "Set Bone"
	time = 6.4 SECONDS
	implements = list(
		TOOL_BONESETTER = 100
		)
	show = TRUE
	preop_sound = 'sound/surgery/bone1.ogg'
	success_sound = 'sound/surgery/bone3.ogg'
	required_layer = list(2)
	radial_icon = /obj/item/kinetic_crusher

// Literally the same check as before to ensure we can even do this surgery unless the bone magically repaired itself somehow
/datum/surgery_step/omni/set_bone/test_op(mob/user, mob/living/target, datum/surgery/omni/surgery)
	if(istype(target,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		var/obj/item/bodypart/affected = H.get_bodypart(user.zone_selected)
		if(affected && affected.bone_status >= BONE_FLAG_BROKEN && istype(surgery.last_step,/datum/surgery_step/omni/apply_bonegel))	
			return TRUE
		return FALSE

/datum/surgery_step/omni/set_bone/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target_zone == BODY_ZONE_HEAD)
		user.visible_message("[user] begins to set [target]'s skull with [tool]...", "<span class='notice'>You begin to set [target]'s skull with [tool]...</span>")
	else
		user.visible_message("[user] begins to set the bones in [target]'s [parse_zone(target_zone)] with [tool]...", "<span class='notice'>You begin setting the bones in [target]'s [parse_zone(target_zone)] with [tool]...</span>")

/datum/surgery_step/omni/set_bone/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("[user] successfully sets the bones in [target]'s [parse_zone(target_zone)]!", "<span class='notice'>You successfully set the bones in [target]'s [parse_zone(target_zone)].</span>")
	surgery.operated_bodypart.fix_bone()
	return TRUE
