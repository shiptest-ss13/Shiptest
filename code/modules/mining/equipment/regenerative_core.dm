/*********************Hivelord stabilizer****************/
/obj/item/hivelordstabilizer
	name = "stabilizing serum"
	icon = 'icons/obj/chemical/medicine.dmi'
	icon_state = "bottle19"
	desc = "Inject certain types of monster organs with this stabilizer to preserve their healing powers indefinitely."
	w_class = WEIGHT_CLASS_TINY
	custom_price = 400

/obj/item/hivelordstabilizer/afterattack(obj/item/organ/M, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	var/obj/item/organ/regenerative_core/C = M
	if(!istype(C, /obj/item/organ/regenerative_core))
		to_chat(user, "<span class='warning'>The stabilizer only works on certain types of monster organs, generally regenerative in nature.</span>")
		return

	C.preserved()
	to_chat(user, "<span class='notice'>You inject the [M] with the stabilizer. It will no longer go inert.</span>")
	qdel(src)

/************************Hivelord core*******************/
/obj/item/organ/regenerative_core
	name = "regenerative core"
	desc = "All that remains of a hivelord. It can be used to help keep your body going, but it will rapidly decay into uselessness."
	icon_state = "roro core 2"
	item_flags = NOBLUDGEON
	slot = ORGAN_SLOT_REGENERATIVE_CORE
	force = 0
	actions_types = list(/datum/action/item_action/organ_action/use)
	var/inert = 0
	var/preserved = 0
	var/crackle_animation = TRUE //shows the red "crackle" overlay when not inert

/obj/item/organ/regenerative_core/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(inert_check)), 2400)

/obj/item/organ/regenerative_core/proc/inert_check()
	if(!preserved)
		go_inert()

/obj/item/organ/regenerative_core/proc/preserved(implanted = 0)
	inert = FALSE
	preserved = TRUE
	update_appearance()
	desc = "All that remains of a hivelord. It is preserved, allowing you to use it to heal completely without danger of decay."
	if(implanted)
		SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "implanted"))
	else
		SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "stabilizer"))

/obj/item/organ/regenerative_core/proc/go_inert()
	inert = TRUE
	name = "decayed regenerative core"
	desc = "All that remains of a hivelord. It has decayed, and is completely useless."
	SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "inert"))
	update_appearance()

/obj/item/organ/regenerative_core/ui_action_click()
	if(inert)
		to_chat(owner, "<span class='notice'>[src] breaks down as it tries to activate.</span>")
	else
		owner.adjustBruteLoss(-100) //previously heal proc
		owner.adjustFireLoss(-100)
		owner.adjustOxyLoss(-50)
		owner.adjustToxLoss(-50)
		if(owner.dna.species.id != SPECIES_IPC)
			owner.adjustCloneLoss(20) //dont abuse it or take cloneloss (organic only)
	qdel(src)

/obj/item/organ/regenerative_core/on_life()
	..()
	if(owner.health <= owner.crit_threshold)
		ui_action_click()

///Handles applying the core, logging and status/mood events.
/obj/item/organ/regenerative_core/proc/applyto(atom/target, mob/user)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.dna.species.id == SPECIES_IPC)
			to_chat(user, span_notice("[src] has no effect on silicate life."))
			return
		if(inert)
			to_chat(user, span_notice("[src] has decayed past usabality."))
			return
		else
			if(H.stat == DEAD)
				to_chat(user, span_notice("[src] is useless on the dead."))
				return
			if(H != user)
				H.visible_message(span_notice("[user] smears [src] across [H]... malignant black tendrils entangle and reinforce [H.p_their()] flesh!"))
				SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "other"))
			else
				to_chat(user, span_notice("You smear [src] across your body. Malignant black tendrils start to grow around the application site, reinforcing your flesh!"))
				SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "self"))
			H.apply_status_effect(STATUS_EFFECT_REGENERATIVE_CORE)
			H.force_scream()
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "core", /datum/mood_event/healsbadman)
			qdel(src)

/obj/item/organ/regenerative_core/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag)
		applyto(target, user)

/obj/item/organ/regenerative_core/attack_self(mob/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		applyto(user, user)

/obj/item/organ/regenerative_core/Insert(mob/living/carbon/M, special = 0, drop_if_replaced = TRUE)
	. = ..()
	if(!preserved && !inert)
		preserved(TRUE)
		owner.visible_message("<span class='notice'>[src] stabilizes as it's inserted.</span>")

/obj/item/organ/regenerative_core/Remove(mob/living/carbon/M, special = 0)
	if(!inert && !special)
		owner.visible_message("<span class='notice'>[src] rapidly decays as it's removed.</span>")
		go_inert()
	return ..()

/*************************Legion core********************/
/obj/item/organ/regenerative_core/legion
	desc = "A strange rock that crackles with power. It can be used to heal completely, but it will rapidly decay into uselessness."
	icon_state = "legion_soul"
	grind_results = list(/datum/reagent/ash = 30)
	var/list/preserved_grind_results
	var/list/unpreserved_grind_results

/obj/item/organ/regenerative_core/legion/Initialize()
	. = ..()
	preserved_grind_results = list(/datum/reagent/medicine/soulus = rand(5, 30), /datum/reagent/ash = 30)
	unpreserved_grind_results = list(/datum/reagent/medicine/soulus = 30, /datum/reagent/blood = rand(5, 15))

/obj/item/organ/regenerative_core/legion/grind_requirements(obj/machinery/reagentgrinder/R)
	return !inert

/obj/item/organ/regenerative_core/legion/on_grind()
	if(inert) // Sanity check
		return -1
	if (preserved)
		grind_results = preserved_grind_results
	else
		grind_results = unpreserved_grind_results
	. = ..()

/obj/item/organ/regenerative_core/legion/Initialize()
	. = ..()
	update_appearance()

/obj/item/organ/regenerative_core/update_icon_state()
	icon_state = inert ? "[icon_state]_inert" : "[icon_state]"
	return ..()

/obj/item/organ/regenerative_core/update_overlays()
	. = ..()
	if(!inert && !preserved && crackle_animation)
		. += "legion_soul_crackle"

/obj/item/organ/regenerative_core/legion/go_inert()
	..()
	desc = "[src] has become inert. It has decayed, and is completely useless."

/obj/item/organ/regenerative_core/legion/preserved(implanted = 0)
	..()
	desc = "[src] has been stabilized. It is preserved, allowing you to use it to heal completely without danger of decay."

/*************************Crystal heart ************************/
/obj/item/organ/regenerative_core/legion/crystal
	name = "crystal heart"
	desc = "A strange rock in the shape of a heart symbol. Applying will repair your body with crystals, but may have additional side effects. It seems it can't survive for very long outside a host."
	icon_state = "crystal_heart"
	crackle_animation = FALSE

/obj/item/organ/regenerative_core/legion/crystal/Initialize()
	. = ..()
	preserved_grind_results = list(/datum/reagent/medicine/soulus = rand(1, 30), /datum/reagent/ash = 30, /datum/reagent/determination = 1)
	unpreserved_grind_results = list(/datum/reagent/medicine/soulus = 30, /datum/reagent/blood = rand(5, 15), /datum/reagent/determination = 1)

/obj/item/organ/regenerative_core/legion/crystal/applyto(atom/target, mob/user)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(inert)
			to_chat(user, span_notice("[src] has decayed beyond usability."))
			return
		else
			if(H.stat == DEAD)
				to_chat(user, span_notice("[src] is useless on the dead."))
				return
			if(H != user)
				H.visible_message(span_notice("[user] smears [src] across [H]... malignant crystals and cancerous tendrils grow on and reinforce [H.p_them()]!</span>"))
				SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "other"))
			else
				to_chat(user, span_notice("You smear [src] across yourself. malignant crystals and cancerous tendrils grow on you, toughening and healing where they touch."))
				SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "self"))
			H.apply_status_effect(STATUS_EFFECT_REGENERATIVE_CORE)
			H.reagents.add_reagent(/datum/reagent/determination, 4)
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "core", /datum/mood_event/healsbadman)
			qdel(src)

/obj/item/organ/regenerative_core/legion/crystal/update_icon_state()
	if(preserved)
		icon_state = "crystal_heart_preserved"
	return ..()
