#define PER_ITERATION_XP_CAP MEDICAL_SKILL_MEDIUM //TW XP gain scales with repeated iterations so we cap it.
/datum/surgery_step/omni/heal
	name = "repair body"
	implements = list(
		TOOL_HEMOSTAT = 100,
		TOOL_SCREWDRIVER = 40)//something else could be added here - but I would prefer not. Hemostat is not that hard to come by and SHOULD be standard for ship equipment.
	repeatable = TRUE
	time = 2.5 SECONDS
	success_sound = 'sound/surgery/retractor2.ogg'
	failure_sound = 'sound/surgery/organ2.ogg'
	var/brutehealing = 0
	var/burnhealing = 0
	var/missinghpbonus = 0 //heals an extra point of damager per X missing damage of type (burn damage for burn healing, brute for brute). Smaller Number = More Healing!
	show = TRUE
	required_layer = list(1)


/datum/surgery_step/omni/heal/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/woundtype
	if(brutehealing && burnhealing)
		woundtype = "wounds"
	else if(brutehealing)
		woundtype = "bruises"
	else //why are you trying to 0,0...?
		woundtype = "burns"
	if(istype(surgery,/datum/surgery/healing))
		var/datum/surgery/healing/the_surgery = surgery
		if(!the_surgery.antispam)
			display_results(user, target, "<span class='notice'>You attempt to patch some of [target]'s [woundtype].</span>",
		"<span class='notice'>[user] attempts to patch some of [target]'s [woundtype].</span>",
		"<span class='notice'>[user] attempts to patch some of [target]'s [woundtype].</span>")

/datum/surgery_step/omni/heal/initiate(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	if(!..())
		return
	while((brutehealing && target.getBruteLoss()) || (burnhealing && target.getFireLoss()))
		if(!..())
			break

/datum/surgery_step/omni/heal/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/umsg = "You succeed in fixing some of [target]'s wounds" //no period, add initial space to "addons"
	var/tmsg = "[user] fixes some of [target]'s wounds" //see above
	var/urhealedamt_brute = brutehealing
	var/urhealedamt_burn = burnhealing
	if(missinghpbonus)
		if(target.stat != DEAD)
			urhealedamt_brute += brutehealing ? round((target.getBruteLoss()/ missinghpbonus),0.1) : 0
			urhealedamt_burn += burnhealing ? round((target.getFireLoss()/ missinghpbonus),0.1) : 0
		else //less healing bonus for the dead since they're expected to have lots of damage to begin with (to make TW into defib not TOO simple)
			urhealedamt_brute += brutehealing ? round((target.getBruteLoss()/ (missinghpbonus*5)),0.1) : 0
			urhealedamt_burn += burnhealing ? round((target.getFireLoss()/ (missinghpbonus*5)),0.1) : 0
	if(!get_location_accessible(target, target_zone))
		urhealedamt_brute *= 0.55
		urhealedamt_burn *= 0.55
		umsg += " as best as you can while they have clothing on"
		tmsg += " as best as they can while [target] has clothing on"
	experience_given = CEILING((target.heal_bodypart_damage(urhealedamt_brute,urhealedamt_burn)/5),1)
	display_results(user, target, "<span class='notice'>[umsg].</span>",
		"[tmsg].",
		"[tmsg].")
	if(istype(surgery, /datum/surgery/healing))
		var/datum/surgery/healing/the_surgery = surgery
		the_surgery.antispam = TRUE
	return ..()

/datum/surgery_step/omni/heal/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='warning'>You screwed up!</span>",
		"<span class='warning'>[user] screws up!</span>",
		"<span class='notice'>[user] fixes some of [target]'s wounds.</span>", TRUE)
	var/urdamageamt_burn = brutehealing * 0.8
	var/urdamageamt_brute = burnhealing * 0.8
	if(missinghpbonus)
		urdamageamt_brute += round((target.getBruteLoss()/ (missinghpbonus*2)),0.1)
		urdamageamt_burn += round((target.getFireLoss()/ (missinghpbonus*2)),0.1)

	target.take_bodypart_damage(urdamageamt_brute, urdamageamt_burn)
	return FALSE
/********************BRUTE STEPS********************/
/*
/datum/surgery_step/omni/heal/brute/basic
	name = "tend bruises"
	brutehealing = 5
	missinghpbonus = 15
/datum/surgery_step/omni/heal/brute/upgraded
	brutehealing = 5
	missinghpbonus = 10

/datum/surgery_step/omni/heal/brute/upgraded/femto
	brutehealing = 5
	missinghpbonus = 5
*/
/********************BURN STEPS********************/
/*
/datum/surgery_step/omni/heal/burn/basic
	name = "tend burn wounds"
	burnhealing = 5
	missinghpbonus = 15
/datum/surgery_step/omni/heal/burn/upgraded
	burnhealing = 5
	missinghpbonus = 10

/datum/surgery_step/omni/heal/burn/upgraded/femto
	burnhealing = 5
	missinghpbonus = 5
*/
/********************COMBO STEPS********************/
/datum/surgery_step/omni/heal/combo
	name = "tend physical wounds"
	brutehealing = 3
	burnhealing = 3
	missinghpbonus = 15
	time = 10
/*
/datum/surgery_step/omni/heal/combo/upgraded
	brutehealing = 3
	burnhealing = 3
	missinghpbonus = 10

/datum/surgery_step/omni/heal/combo/upgraded/femto
	brutehealing = 1
	burnhealing = 1
	missinghpbonus = 2.5

/datum/surgery_step/omni/heal/combo/upgraded/femto/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='warning'>You screwed up!</span>",
		"<span class='warning'>[user] screws up!</span>",
		"<span class='notice'>[user] fixes some of [target]'s wounds.</span>", TRUE)
	target.take_bodypart_damage(5,5)
*/
#undef PER_ITERATION_XP_CAP
