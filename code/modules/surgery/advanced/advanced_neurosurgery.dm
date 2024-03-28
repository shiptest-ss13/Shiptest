/datum/surgery/advanced/advanced_neurosurgery
	name = "Advanced Neurosurgery"
	desc = "A lengthy, precise brain surgery. Utilizes operating computer algorithms to visualize, identify and produce surgery steps to heal even the most deep-rooted of brain traumas."
	steps = list(
	/datum/surgery_step/incise,
	/datum/surgery_step/retract_skin,
	/datum/surgery_step/saw,
	/datum/surgery_step/clamp_bleeders,
	/datum/surgery_step/advanced_neurosurgery,
	/datum/surgery_step/close)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_HEAD)
	requires_bodypart_type = 0

/datum/surgery/advanced/advanced_neurosurgery/can_start(mob/user, mob/living/carbon/target)
	if(!..())
		return FALSE
	var/obj/item/organ/brain/B = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(!B)
		return FALSE
	return TRUE

/datum/surgery_step/advanced_neurosurgery
	name = "perform advanced_neurosurgery"
	implements = list(
		TOOL_HEMOSTAT = 95
	) // No ghetto tools; this is an advanced surgery. If you have access to this, you SHOULD have access to a hemostat in the first place.
	time = 20 SECONDS
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/scalpel2.ogg'
	failure_sound = 'sound/surgery/organ2.ogg'
	experience_given = MEDICAL_SKILL_ADVANCED //lose XP if you end up giving them bad traumas

/datum/surgery_step/advanced_neurosurgery/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to perform advanced neurosurgery on [target]'s brain...</span>",
		"<span class='notice'>[user] begins to perform advanced neurosurgery on [target]'s brain.</span>",
		"<span class='notice'>[user] begins to perform surgery on [target]'s brain.</span>")

/datum/surgery_step/advanced_neurosurgery/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(user, target, "<span class='notice'>You succeed in mending the structure of [target]'s brain.</span>",
			"<span class='notice'>[user] successfully mend the structure of [target]'s brain!</span>",
			"<span class='notice'>[user] completes the surgery on [target]'s brain.</span>")
	target.cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/brainwashed))
		target.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	return ..()

/datum/surgery_step/advanced_neurosurgery/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/organ/brain/B = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(B)
		display_results(user, target, "<span class='warning'>You accidentally mend the wrong parts of [target]'s brain together, causing even more damage!</span>",
			"<span class='notice'>[user] successfully mends the structure of [target]'s brain!</span>",
			"<span class='notice'>[user] completes the surgery on [target]'s brain.</span>")
	else
		user.visible_message("<span class='warning'>[user] suddenly notices that the brain [user.p_they()] [user.p_were()] working on is not there anymore.</span>", "<span class='warning'>You suddenly notice that the brain you were working on is not there anymore.</span>")
	return FALSE
