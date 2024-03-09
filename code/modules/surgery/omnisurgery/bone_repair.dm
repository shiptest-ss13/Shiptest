/datum/surgery_step/omni/set_bone
	name = "set bone"
	time = 6.4 SECONDS
	implements = list(
		TOOL_HEMOSTAT = 100,
		TOOL_WRENCH = 40)
	show = TRUE
	preop_sound = 'sound/surgery/bone1.ogg'
	success_sound = 'sound/surgery/bone3.ogg'
	required_layer = list(2)
	radial_icon = /obj/item/kinetic_crusher

/datum/surgery_step/omni/set_bone/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target_zone == BODY_ZONE_HEAD)
		user.visible_message("[user] begins to set [target]'s skull with [tool]...", "<span class='notice'>You begin to set [target]'s skull with [tool]...</span>")
	else
		user.visible_message("[user] begins to set the bones in [target]'s [parse_zone(target_zone)] with [tool]...", "<span class='notice'>You begin setting the bones in [target]'s [parse_zone(target_zone)] with [tool]...</span>")

/datum/surgery_step/omni/set_bone/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("[user] successfully sets the bones in [target]'s [parse_zone(target_zone)]!", "<span class='notice'>You successfully set the bones in [target]'s [parse_zone(target_zone)].</span>")
	surgery.operated_bodypart.fix_bone()
	return TRUE
