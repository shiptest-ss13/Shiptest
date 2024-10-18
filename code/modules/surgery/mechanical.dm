/*\ Mechanical Surgery for IPC's and the augmented \*/

/datum/surgery/brain_surgery/mechanic
	name = "Mechanical brain surgery"
	requires_bodypart_type = BODYTYPE_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/fix_brain,
		/datum/surgery_step/close_hatch,
		/datum/surgery_step/mechanic_close
	)
	lying_required = FALSE
	self_operable = TRUE

/datum/surgery/healing/mechanic
	name = "Repair machinery"
	requires_bodypart_type = BODYTYPE_ROBOTIC
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
	implements = list(TOOL_WELDER = 100,
				TOOL_WIRECUTTER = 100,
				TOOL_CAUTERY = 60,
				TOOL_HEMOSTAT = 60,
				TOOL_RETRACTOR = 60,
				/obj/item/melee/transforming/energy = 40,
				/obj/item/gun/energy/laser = 20)
	time = 2 SECONDS
	missinghpbonus = 10

/datum/surgery_step/heal/mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/repairtype
	if(tool.tool_behaviour == TOOL_WELDER || tool.tool_behaviour == TOOL_CAUTERY || istype(tool, /obj/item/melee/transforming/energy) || istype(tool, /obj/item/gun/energy/laser))
		brutehealing = 5
		burnhealing = 0
		repairtype = "dents"
		preop_sound = 'sound/items/welder.ogg'
		success_sound = 'sound/items/welder2.ogg'
	if(tool.tool_behaviour == TOOL_WIRECUTTER || tool.tool_behaviour == TOOL_HEMOSTAT || tool.tool_behaviour == TOOL_RETRACTOR)
		burnhealing = 5
		brutehealing = 0
		repairtype = "wiring"
		success_sound = 'sound/items/wirecutter.ogg'
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
	time = 6.4 SECONDS
	implements = list(
		/obj/item/stack/rods = 100
		)
	preop_sound = 'sound/items/ratchet.ogg'
	success_sound = 'sound/items/taperecorder_close.ogg'

/datum/surgery_step/repair_structure/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/stack/rods = tool
	if(!tool || rods.get_amount() < 2)
		to_chat(user, "<span class='warning'>You need at least two rods to do this!</span>")
		return -1
	if(target_zone == BODY_ZONE_HEAD)
		user.visible_message("[user] begins to reinforce [target]'s skull with [tool]...", "<span class='notice'>You begin to reinforce [target]'s skull with [tool]...</span>")
	else
		user.visible_message("[user] begins to replace the rods in [target]'s [parse_zone(target_zone)]...", "<span class='notice'>You begin replacing the rods in [target]'s [parse_zone(target_zone)]...</span>")

/datum/surgery_step/repair_structure/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/stack/rods = tool
	if(!tool || rods.get_amount() < 2)
		to_chat(user, "<span class='warning'>You need at least two rods to do this!</span>")
		return FALSE
	user.visible_message("[user] successfully restores integrity to [target]'s [parse_zone(target_zone)]!", "<span class='notice'>You successfully restore integrity to [target]'s [parse_zone(target_zone)].</span>")
	surgery.operated_bodypart.integrity_loss = 0
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
