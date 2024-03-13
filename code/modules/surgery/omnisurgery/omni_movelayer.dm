// Assume surgeries with no valid_locations in this file can be done at any location 

// [Going Down Layers]
/datum/surgery_step/omni/skindown
	name = "Dermal Incision"
	implements = list(
		TOOL_SCALPEL = 100)
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/scalpel2.ogg'
	time = 2.5 SECONDS
	show = TRUE
	required_layer = list(0)

/datum/surgery_step/omni/skindown/test_op(mob/user, mob/living/target, datum/surgery/omni/surgery)
	var/mob/living/carbon/C = target
	if(!C.get_bodypart(user.zone_selected) && !(user.zone_selected in PRECISE_BODY_ZONES)) //Can't remove skin of non-existent limb
		return FALSE
	return TRUE

/datum/surgery_step/omni/skindown/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer++
	return ..()

/datum/surgery_step/omni/muscledown
	name = "Retract Muscle" //Should cause minor bleeding
	implements = list(
		TOOL_RETRACTOR = 100)
	time = 3.5 SECONDS
	preop_sound = 'sound/surgery/retractor1.ogg'
	success_sound = 'sound/surgery/retractor2.ogg'
	show = TRUE
	required_layer = list(1)

/datum/surgery_step/omni/muscledown/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer++
	return ..()

/datum/surgery_step/omni/bonedown
	name = "Saw Bone" //Should not cause bleeding, but should cause damage
	implements = list(
		TOOL_SAW = 100)
	time = 10 SECONDS
	preop_sound = 'sound/surgery/saw.ogg'
	success_sound = 'sound/surgery/bone3.ogg'
	show = TRUE
	required_layer = list(2)

/datum/surgery_step/omni/bonedown/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer++
	return ..()

/datum/surgery_step/omni/membranedown
	name = "Pierce Membrane" //Must implement bleeding
	implements = list(
		TOOL_SCALPEL = 100)
	time = 2.5 SECONDS
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/scalpel2.ogg'
	show = TRUE
	required_layer = list(3)

/datum/surgery_step/omni/membranedown/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer++
	return ..()

// [Going Up Layers] (All cautery for now for the sake of simplicity, otherwise there'll be lots of radial menus)
/datum/surgery_step/omni/membraneup
	name = "Seal Membrane"
	implements = list(
		TOOL_CAUTERY = 100)
	time = 2.5 SECONDS
	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/retractor2.ogg'
	show = TRUE
	required_layer = list(4)

/datum/surgery_step/omni/membraneup/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer--
	return ..()

/datum/surgery_step/omni/boneup
	name = "Mend Bone"
	implements = list(
		TOOL_HEMOSTAT = 100)
	time = 2.5 SECONDS
	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/bone3.ogg'
	show = TRUE
	required_layer = list(3)

/datum/surgery_step/omni/boneup/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer--
	return ..()

/datum/surgery_step/omni/muscleup
	name = "Mend Muscle"
	implements = list(
		TOOL_CAUTERY = 100)
	time = 2.5 SECONDS
	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/retractor2.ogg'
	show = TRUE
	required_layer = list(2)

/datum/surgery_step/omni/muscleup/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, default_display_results)
	surgery.atlayer--
	return ..()

/datum/surgery_step/omni/close
	name = "Finish Surgery"
	implements = list(
		TOOL_CAUTERY = 100,
		TOOL_WELDER = 40,
		/obj/item/gun/energy/laser = 60)
	time = 2.5 SECONDS
	preop_sound = 'sound/surgery/cautery1.ogg'
	success_sound = 'sound/surgery/cautery2.ogg'
	show = TRUE
	required_layer = list(0,1)


/datum/surgery_step/omni/close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to mend the incision in [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] begins to mend the incision in [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] begins to mend the incision in [target]'s [parse_zone(target_zone)].</span>")

/datum/surgery_step/omni/close/tool_check(mob/user, obj/item/tool)
	if(implement_type == TOOL_WELDER || implement_type == /obj/item)
		return tool.get_temperature()

	return TRUE

/datum/surgery_step/omni/close/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	if (ishuman(target))
		var/mob/living/carbon/human/H = target
		//H.bleed_rate = max((H.bleed_rate - 3), 0) Disabling for test purposes
		H.bleed_rate = 0 //Setting this to 0 until Clamp Bleeders gets figured out
	surgery.complete()
	return ..()

// [Lost-Limb Surgeries] Surgeries that can be done on areas with missing limbs..
