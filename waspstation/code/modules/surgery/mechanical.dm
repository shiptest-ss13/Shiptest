/*\ Mechanical Surgery for IPC's and the augmented \*/

/datum/surgery/brain_surgery/mechanic
	name = "Mechanical brain surgery"
	requires_bodypart_type = BODYPART_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fix_brain,
		/datum/surgery_step/mechanic_close
	)
	lying_required = FALSE
	self_operable = TRUE

/datum/surgery/healing/mechanic
	name = "Repair machinery"
	requires_bodypart_type = BODYPART_ROBOTIC
	replaced_by = null
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/heal/mechanic,
		/datum/surgery_step/mechanic_close
	)
	lying_required = FALSE
	self_operable = TRUE

/datum/surgery_step/heal/mechanic
	name = "repair components"
	implements = list(TOOL_WELDER = 100, TOOL_CAUTERY = 60, /obj/item/melee/transforming/energy = 40, /obj/item/gun/energy/laser = 20, TOOL_WIRECUTTER = 100, TOOL_HEMOSTAT = 60, TOOL_RETRACTOR = 60)
	time = 20
	missinghpbonus = 10

/datum/surgery_step/heal/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/repairtype
	if(tool.tool_behaviour == TOOL_WELDER || tool.tool_behaviour == TOOL_CAUTERY || istype(tool, /obj/item/melee/transforming/energy) || istype(tool, /obj/item/gun/energy/laser))
		brutehealing = 5
		burnhealing = 0
		repairtype = "dents"
	if(tool.tool_behaviour == TOOL_WIRECUTTER || tool.tool_behaviour == TOOL_HEMOSTAT || tool.tool_behaviour == TOOL_RETRACTOR)
		burnhealing = 5
		brutehealing = 0
		repairtype = "wiring"
	if(istype(surgery,/datum/surgery/healing))
		var/datum/surgery/healing/the_surgery = surgery
		if(!the_surgery.antispam)
			display_results(user, target, "<span class='notice'>You attempt to fix some of [target]'s [repairtype].</span>",
		"<span class='notice'>[user] attempts to fix some of [target]'s [repairtype].</span>",
		"<span class='notice'>[user] attempts to fix some of [target]'s [repairtype].</span>")

/datum/surgery_step/heal/mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/umsg = "You succeed in fixing some of [target]'s damages" //no period, add initial space to "addons"
	var/tmsg = "[user] fixes some of [target]'s damages" //see above
	var/urhealedamt_brute = brutehealing
	var/urhealedamt_burn = burnhealing
	if(missinghpbonus)
		urhealedamt_brute += round((target.getBruteLoss()/ missinghpbonus),0.1)
		urhealedamt_burn += round((target.getFireLoss()/ missinghpbonus),0.1)

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
	return TRUE

/datum/surgery_step/heal/mechanic/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob)
	display_results(user, target, "<span class='warning'>You screwed up!</span>",
		"<span class='warning'>[user] screws up!</span>",
		"<span class='notice'>[user] fixes some of [target]'s damages.</span>", TRUE)
	var/urdamageamt_burn = brutehealing * 0.8
	var/urdamageamt_brute = burnhealing * 0.8
	//Reset heal checks
	burnhealing = 0
	brutehealing = 0
	if(missinghpbonus)
		urdamageamt_brute += round((target.getBruteLoss()/ (missinghpbonus*2)),0.1)
		urdamageamt_burn += round((target.getFireLoss()/ (missinghpbonus*2)),0.1)
	if((fail_prob > 50) && (tool.tool_behaviour == TOOL_WIRECUTTER || tool.tool_behaviour == TOOL_HEMOSTAT || tool.tool_behaviour == TOOL_RETRACTOR))
		do_sparks(3, TRUE, target)
		if(isliving(user))
			var/mob/living/L = user
			L.electrocute_act(urdamageamt_burn, target)
	target.take_bodypart_damage(urdamageamt_brute, urdamageamt_burn)
	return FALSE
