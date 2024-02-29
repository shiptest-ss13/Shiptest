//an incision but with greater bleed, and a 90% base success chance
/datum/surgery_step/omni/incise_head
	name = "incise head"
	implements = list(
		TOOL_SCALPEL = 90,
		/obj/item/kitchen/knife = 40,
		/obj/item/shard = 33)
	time = 1.6 SECONDS
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/scalpel2.ogg'
	failure_sound = 'sound/surgery/organ2.ogg'
	required_layer = list(2)
	show = TRUE
	valid_locations = list(BODY_ZONE_HEAD)

/datum/surgery_step/omni/incise_head/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to make an incision in [target]'s head...</span>",
		"<span class='notice'>[user] begins to make an incision in [target]'s head.</span>",
		"<span class='notice'>[user] begins to make an incision in [target]'s head.</span>")

/datum/surgery_step/omni/incise_head/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if (!(NOBLOOD in H.dna.species.species_traits))
			display_results(user, target, "<span class='notice'>Blood pools around the incision in [H]'s head.</span>",
				"<span class='notice'>Blood pools around the incision in [H]'s head.</span>",
				"")
			H.bleed_rate += 10
			target.apply_damage(15, BRUTE, "[target_zone]")
	return ..()

//revive after incision
/datum/surgery_step/omni/revive
	name = "shock brain"
	implements = list(
		/obj/item/shockpaddles = 100,	//this is useful for reviving simepeople.
		/obj/item/melee/baton = 40,		//i hate this a lot
		/obj/item/gun/energy = 30,		//should be tasers only
		/obj/item/inducer = 30)			//why not
	time = 3 SECONDS
	success_sound = 'sound/magic/lightningbolt.ogg'
	failure_sound = 'sound/machines/defib_zap.ogg'
	repeatable = TRUE
	experience_given = MEDICAL_SKILL_ADVANCED
	required_layer = list(2)
	show = TRUE
	valid_locations = list(BODY_ZONE_HEAD)

/datum/surgery_step/omni/revive/test_op(mob/user, mob/living/target,datum/surgery/omni/surgery)
	var/obj/item/organ/heart/H = target.getorganslot(ORGAN_SLOT_HEART)
	if(!istype(surgery.last_step,/datum/surgery_step/omni/incise_head))
		return FALSE
	if(H)
		if(H.damage > 60 && !H.operated)
			return TRUE
	return FALSE

/datum/surgery_step/omni/revive/tool_check(mob/user, obj/item/tool)
	. = TRUE
	if(istype(tool, /obj/item/shockpaddles))
		var/obj/item/shockpaddles/S = tool
		if((S.req_defib && !S.defib.powered) || !S.wielded || S.cooldown || S.busy)
			to_chat(user, "<span class='warning'>You need to wield both paddles, and [S.defib] must be powered!</span>")
			return FALSE
	if(istype(tool, /obj/item/melee/baton))
		var/obj/item/melee/baton/B = tool
		if(!B.turned_on)
			to_chat(user, "<span class='warning'>[B] needs to be active!</span>")
			return FALSE
	if(istype(tool, /obj/item/gun/energy))
		var/obj/item/gun/energy/E = tool
		if(E.chambered && istype(E.chambered, /obj/item/ammo_casing/energy/electrode))
			return TRUE
		else
			to_chat(user, "<span class='warning'>You need an electrode for this!</span>")
			return FALSE

/datum/surgery_step/omni/revive/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You prepare to give [target]'s brain the spark of life with [tool].</span>",
		"<span class='notice'>[user] prepares to shock [target]'s brain with [tool].</span>",
		"<span class='notice'>[user] prepares to shock [target]'s brain with [tool].</span>")
	target.notify_ghost_cloning("Someone is trying to zap your brain. Re-enter your corpse if you want to be revived!", source = target)

/datum/surgery_step/omni/revive/play_preop_sound(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(istype(tool, /obj/item/shockpaddles))
		playsound(tool, 'sound/machines/defib_charge.ogg', 75, 0)
	else
		..()

/datum/surgery_step/omni/revive/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	display_results(user, target, "<span class='notice'>You successfully shock [target]'s brain with [tool]...</span>",
		"<span class='notice'>[user] send a powerful shock to [target]'s brain with [tool]...</span>",
		"<span class='notice'>[user] send a powerful shock to [target]'s brain with [tool]...</span>")
	target.adjustOxyLoss(-50, 0)
	target.updatehealth()
	if(target.revive(full_heal = FALSE, admin_revive = FALSE))
		target.visible_message("<span class='notice'>...[target] wakes up, alive and aware!</span>")
		target.emote("gasp")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 50, 199) //MAD SCIENCE
		return TRUE
	else
		target.visible_message("<span class='warning'>...[target.p_they()] convulses, then lies still.</span>")
		return FALSE

/datum/surgery_step/omni/revive/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You shock [target]'s brain with [tool], but [target.p_they()] doesn't react.</span>",
		"<span class='notice'>[user] send a powerful shock to [target]'s brain with [tool], but [target.p_they()] doesn't react.</span>",
		"<span class='notice'>[user] send a powerful shock to [target]'s brain with [tool], but [target.p_they()] doesn't react.</span>")
	playsound(get_turf(target), 'sound/magic/lightningbolt.ogg', 50, TRUE)
	target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20, 180)
	return FALSE
