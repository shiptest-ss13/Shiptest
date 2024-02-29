/datum/surgery/omni/stomach_pump/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/stomach/S = target.getorganslot(ORGAN_SLOT_STOMACH)
	if(target.stat != DEAD)	//shamelessly lifted off the revival surgery but we're looking for the same critera here, a dead, non-husked, revivable patient.
		return FALSE
	if(HAS_TRAIT(target, TRAIT_HUSK))
		return FALSE
	if(!S)
		return FALSE
	return ..()

//Working the stomach by hand in such a way that you induce vomiting.
/datum/surgery_step/omni/stomach_pump
	name = "Pump Stomach"
	accept_hand = TRUE
	repeatable = TRUE
	time = 20
	experience_given = 0
	required_layer = list(2)
	show = TRUE
	valid_locations = list(BODY_ZONE_CHEST)

/datum/surgery_step/omni/stomach_pump/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin pumping [target]'s stomach...</span>",
		"<span class='notice'>[user] begins to pump [target]'s stomach.</span>",
		"<span class='notice'>[user] begins to press on [target]'s chest.</span>")

/datum/surgery_step/omni/stomach_pump/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/reagents_volume_before_pump = H.reagents.total_volume
		display_results(user, target, "<span class='notice'>[user] forces [H] to vomit, cleansing their stomach of some chemicals!</span>",
				"<span class='notice'>[user] forces [H] to vomit, cleansing their stomach of some chemicals!</span>",
				"[user] forces [H] to vomit!")
		H.vomit(20, FALSE, TRUE, 1, TRUE, FALSE, purge = TRUE) //called with purge as true to lose more reagents
		if(istype(surgery,/datum/surgery/stomach_pump))
			var/datum/surgery/stomach_pump/stom_pump = surgery
			if(stom_pump.accumulated_experience > MEDICAL_SKILL_MEDIUM*10) //capped so you can't dope bodies and purge for ezxp
				experience_given = (H.reagents.total_volume - reagents_volume_before_pump)/(MEDICAL_SKILL_MEDIUM)
				stom_pump.accumulated_experience += experience_given
	return ..()

/datum/surgery_step/omni/stomach_pump/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		display_results(user, target, "<span class='warning'>You screw up, brusing [H]'s chest!</span>",
			"<span class='warning'>[user] screws up, brusing [H]'s chest!</span>",
			"<span class='warning'>[user] screws up!</span>")
		H.adjustOrganLoss(ORGAN_SLOT_STOMACH, 5)
		target.apply_damage(15, BRUTE, "[target_zone]")
