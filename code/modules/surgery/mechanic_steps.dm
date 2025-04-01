//open shell
/datum/surgery_step/mechanic_open
	name = "unscrew shell"
	implements = list(
		TOOL_SCREWDRIVER		= 100,
		TOOL_SCALPEL 			= 75, // med borgs could try to unscrew shell with scalpel
		/obj/item/melee/knife/kitchen	= 50,
		/obj/item				= 10)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/screwdriver.ogg'
	success_sound = 'sound/items/screwdriver2.ogg'

/datum/surgery_step/mechanic_open/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to unscrew the shell of [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to unscrew the shell of [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to unscrew the shell of [target]'s [parse_zone(target_zone)].</span>")

/datum/surgery_step/mechanic_open/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	if(tool.usesound)
		preop_sound = tool.usesound
	return ..()

//close shell
/datum/surgery_step/mechanic_close
	name = "screw shell"
	implements = list(
		TOOL_SCREWDRIVER		= 100,
		TOOL_SCALPEL 			= 75,
		/obj/item/melee/knife/kitchen	= 50,
		/obj/item				= 10)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/screwdriver.ogg'
	success_sound = 'sound/items/screwdriver2.ogg'

/datum/surgery_step/mechanic_close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to screw the shell of [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to screw the shell of [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to screw the shell of [target]'s [parse_zone(target_zone)].</span>")

/datum/surgery_step/mechanic_close/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	if(tool.usesound)
		preop_sound = tool.usesound
	return ..()

//prepare electronics
/datum/surgery_step/prepare_electronics
	name = "prepare electronics"
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_HEMOSTAT = 10) // try to reboot internal controllers via short circuit with some conductor
	time = 2.4 SECONDS
	preop_sound = 'sound/items/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder_close.ogg'
	failure_sound = 'sound/machines/defib_zap.ogg'

/datum/surgery_step/prepare_electronics/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to prepare electronics in [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to prepare electronics in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to prepare electronics in [target]'s [parse_zone(target_zone)].</span>")

//unwrench
/datum/surgery_step/mechanic_unwrench
	name = "unwrench bolts"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 10)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/ratchet.ogg'

/datum/surgery_step/mechanic_unwrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to unwrench some bolts in [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to unwrench some bolts in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to unwrench some bolts in [target]'s [parse_zone(target_zone)].</span>")

/datum/surgery_step/mechanic_unwrench/tool_check(mob/user, obj/item/tool)
	if(tool.usesound)
		preop_sound = tool.usesound
	. = ..()

//wrench
/datum/surgery_step/mechanic_wrench
	name = "wrench bolts"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 10)
	time = 2.4 SECONDS
	preop_sound = 'sound/items/ratchet.ogg'

/datum/surgery_step/mechanic_wrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to wrench some bolts in [target]'s [parse_zone(target_zone)]...</span>",
			"<span class='notice'>[user] begins to wrench some bolts in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] begins to wrench some bolts in [target]'s [parse_zone(target_zone)].</span>")

/datum/surgery_step/mechanic_wrench/tool_check(mob/user, obj/item/tool)
	if(tool.usesound)
		preop_sound = tool.usesound
	. = ..()

//open hatch
/datum/surgery_step/open_hatch
	name = "open the hatch"
	accept_hand = TRUE
	time = 1 SECONDS
	preop_sound = 'sound/items/ratchet.ogg'
	success_sound = 'sound/machines/doorclick.ogg'

/datum/surgery_step/open_hatch/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to open the hatch holders in [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] begins to open the hatch holders in [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] begins to open the hatch holders in [target]'s [parse_zone(target_zone)].</span>")

//close hatch

/datum/surgery_step/close_hatch
	name = "close the hatch"
	accept_hand = TRUE
	time = 1 SECONDS
	preop_sound = 'sound/machines/doorclick.ogg'
	success_sound = 'sound/items/ratchet.ogg'

/datum/surgery_step/close_hatch/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to close the hatch holders in [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] begins to close the hatch holders in [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] begins to close the hatch holders in [target]'s [parse_zone(target_zone)].</span>")

//manipulate organs (metal edition)
/datum/surgery_step/manipulate_organs/mechanic
	name = "manipulate mechanical organs"
	preop_sound = 'sound/surgery/organ2.ogg'
	success_sound = 'sound/surgery/organ1.ogg'
	implements_extract = list(
		TOOL_HEMOSTAT = 55,
		TOOL_CROWBAR = 100,
		/obj/item/kitchen/fork = 35)

//prosthesis removal
/datum/surgery_step/prosthesis_removal
	name = "detach prosthesis"
	accept_hand = TRUE //once a prosthesis is unseated, it should be a simple matter of removing it without tools
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_CROWBAR = 100) //exists just in case you want to reflavor your prosthesis as something a little more integrated
	time = 2.8 SECONDS
	preop_sound = 'sound/items/ratchet.ogg'
	success_sound = 'sound/machines/doorclick.ogg'

/datum/surgery_step/prosthesis_removal/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to unseat [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] begins to unseat [target]'s [parse_zone(target_zone)]!</span>",
		"<span class='notice'>[user] begins to unseat [target]'s [parse_zone(target_zone)]!</span>")

/datum/surgery_step/prosthesis_removal/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/mob/living/carbon/human/L = target
	display_results(user, target, "<span class='notice'>You detach [L]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] detaches [L]'s [parse_zone(target_zone)]!</span>",
		"<span class='notice'>[user] detaches [L]'s [parse_zone(target_zone)]!</span>")
	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		target_limb.drop_limb()

//Add prosthetic
/datum/surgery_step/add_prosthetic
	name = "add prosthetic"
	implements = list(
		/obj/item/bodypart = 100)
	time = 32
	experience_given = MEDICAL_SKILL_ORGAN_FIX //won't get full XP if rejected
	var/organ_rejection_dam = 0

/datum/surgery_step/add_prosthetic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(!istype(tool, /obj/item/bodypart))
		to_chat(user, "<span class='warning'>[tool] isn't a mechanical prosthesis!</span>")
		return FALSE
	var/obj/item/bodypart/BP = tool
	if(ishuman(target))
		if(IS_ORGANIC_LIMB(BP))
			to_chat(user, "<span class='warning'>[BP] isn't a mechanical prosthesis!</span>")
			return -1

	if(target_zone != BP.body_zone) //so we can't replace a leg with an arm, or a human arm with a monkey arm.
		to_chat(user, "<span class='warning'>[tool] isn't the right type for [parse_zone(target_zone)].</span>")
		return -1
	display_results(user, target, "<span class='notice'>You begin to replace [target]'s [parse_zone(target_zone)] with [tool]...</span>",
		"<span class='notice'>[user] begins to replace [target]'s [parse_zone(target_zone)] with [tool].</span>",
		"<span class='notice'>[user] begins to replace [target]'s [parse_zone(target_zone)].</span>")

/datum/surgery_step/add_prosthetic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(HAS_TRAIT(tool, TRAIT_NODROP))
		display_results(user, target, "<span class= 'warning'>The [tool] is stuck in your hand!</span>",
			"<span class= 'warning'>The [tool] seems stuck to [user]'s hand!</span>",
			"<span class= 'warning'>The [tool] seems stuck to [user]'s hand!</span>")
		return FALSE
	var/obj/item/bodypart/L = tool
	if(!L.attach_limb(target))
		display_results(user, target, "<span class='warning'>You fail to replace [target]'s [parse_zone(target_zone)]! Their body has rejected [L]!</span>",
			"<span class='warning'>[user] fails to replace [target]'s [parse_zone(target_zone)]!</span>",
			"<span class='warning'>[user] fails to replace [target]'s [parse_zone(target_zone)]!</span>")
		return FALSE
	display_results(user, target, "<span class='notice'>You succeed in replacing [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] successfully replaces [target]'s [parse_zone(target_zone)] with [tool]!</span>",
		"<span class='notice'>[user] successfully replaces [target]'s [parse_zone(target_zone)]!</span>")
	return ..()
