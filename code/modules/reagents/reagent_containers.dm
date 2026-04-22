/obj/item/reagent_containers
	name = "Container"
	desc = "..."
	icon = 'icons/obj/chemical/beakers.dmi'
	icon_state = null
	w_class = WEIGHT_CLASS_TINY
	var/amount_per_transfer_from_this = 5
	var/list/possible_transfer_amounts = list(5,10,15,20,25,30)
	var/volume = 30
	var/reagent_flags
	var/list/list_reagents = null
	var/spawned_disease = null
	var/disease_amount = 20
	var/spillable = FALSE
	var/list/fill_icon_thresholds = null
	var/fill_icon_state = null // Optional custom name for reagent fill icon_state prefix
	var/fill_icon = 'icons/obj/reagentfillings.dmi'

	/// To enable caps, set can_have_cap to TRUE and define a cap_icon_state. Do not change at runtime.
	var/can_have_cap = FALSE
	VAR_PROTECTED/cap_icon_state = null
	/// Whether the container has a cap on. Do not set directly at runtime; use set_cap_status().
	VAR_PROTECTED/cap_on = FALSE
	VAR_PRIVATE/cap_lost = FALSE
	VAR_PRIVATE/mutable_appearance/cap_overlay = null

/obj/item/reagent_containers/Initialize(mapload, vol)
	. = ..()
	if(can_have_cap && cap_icon_state)
		cap_overlay = mutable_appearance(icon, cap_icon_state)
	if(isnum(vol) && vol > 0)
		volume = vol
	create_reagents(volume, reagent_flags)
	if(spawned_disease)
		var/datum/disease/F = new spawned_disease()
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent(/datum/reagent/blood, disease_amount, data)
	add_initial_reagents()

	if(can_have_cap)
		if(!cap_icon_state)
			WARNING("Container that allows caps is lacking a cap_icon_state!")
		set_cap_status(cap_on)
	else
		cap_on = FALSE

/obj/item/reagent_containers/proc/add_initial_reagents()
	if(list_reagents)
		reagents.add_reagent_list(list_reagents)

/// Adds the container's cap if TRUE is passed in, and removes it if FALSE is passed in. Container must be able to accept a cap.
/obj/item/reagent_containers/proc/set_cap_status(value_to_set)
	if(!can_have_cap)
		CRASH("Cannot change cap status of reagent container that disallows caps!")

	if(value_to_set)
		cap_on = TRUE
		spillable = FALSE
	else
		cap_on = FALSE
		spillable = TRUE

	update_appearance()

/obj/item/reagent_containers/examine(mob/user)
	. = ..()
	if(istype(src, /obj/item/reagent_containers/glass))
		. += span_notice("Currently transferring [amount_per_transfer_from_this]u with each pour.")
	if(istype(src, /obj/item/reagent_containers/dropper))
		. += span_notice("Currently squeezing out [amount_per_transfer_from_this]u drops.")
	if(istype(src, /obj/item/reagent_containers/syringe))
		. += span_notice("Currently injecting [amount_per_transfer_from_this]u at a time.")
	if(!can_have_cap)
		return
	else
		if(cap_lost)
			. += span_notice("The cap seems to be missing.")
		else if(cap_on)
			. += span_notice("The cap is firmly on to prevent spilling. <b>Right-Click</b> to remove the cap.")
		else
			. += span_notice("The cap has been taken off. <b>Right-Click</b> to put a cap on.")

/obj/item/reagent_containers/is_injectable(mob/user, allowmobs = TRUE)
	if(can_have_cap && cap_on)
		return FALSE
	return ..()

/obj/item/reagent_containers/is_drawable(mob/user, allowmobs = TRUE)
	if(can_have_cap && cap_on)
		return FALSE
	return ..()

/obj/item/reagent_containers/is_refillable()
	if(can_have_cap && cap_on)
		return FALSE
	return ..()

/obj/item/reagent_containers/is_drainable()
	if(can_have_cap && cap_on)
		return FALSE
	return ..()

/obj/item/reagent_containers/attack_self(mob/user)
	if(possible_transfer_amounts.len)
		var/i=0
		for(var/A in possible_transfer_amounts)
			i++
			if(A == amount_per_transfer_from_this)
				if(i<possible_transfer_amounts.len)
					amount_per_transfer_from_this = possible_transfer_amounts[i+1]
				else
					amount_per_transfer_from_this = possible_transfer_amounts[1]
				balloon_alert(user, "transferring [amount_per_transfer_from_this]u")
				return

/obj/item/reagent_containers/attack(mob/M, mob/user, def_zone)
	if(user.a_intent == INTENT_HARM)
		return ..()

/obj/item/reagent_containers/proc/attempt_pour(atom/target, mob/user)
	if(ismob(target) || !reagents.total_volume || !check_allowed_items(target, target_self = FALSE))
		return

	target.visible_message(span_notice("[user] attempts to pour [src] onto [target]."))
	if(!do_after(user, 3 SECONDS, target=target))
		return
	// reagents may have been emptied
	if(!is_drainable() || !reagents.total_volume)
		return

	playsound(src, 'sound/items/glass_splash.ogg', 50, 1)
	target.visible_message(span_notice("[user] pours [src] onto [target]."))
	log_combat(user, target, "poured [english_list(reagents.reagent_list)]", "in [AREACOORD(target)]")
	log_game("[key_name(user)] poured [english_list(reagents.reagent_list)] on [target] in [AREACOORD(target)].")

	var/frac = min(amount_per_transfer_from_this/reagents.total_volume, 1)
	// don't use trans_to, because we're not ADDING it to the object, we're just... pouring it.
	reagents.expose(target, TOUCH, frac)
	for(var/datum/reagent/reag as anything in reagents.reagent_list)
		reagents.remove_reagent(reag.type, reag.volume * frac)

/obj/item/reagent_containers/attack_self_secondary(mob/user)
	if(!can_interact(user))
		return
	. = ..()
	if(can_have_cap)
		if(cap_lost)
			to_chat(user, span_warning("The cap seems to be missing! Where did it go?"))
			return

		var/fumbled = HAS_TRAIT(user, TRAIT_CLUMSY) && prob(5)
		if(cap_on || fumbled)
			set_cap_status(FALSE)
			if(fumbled)
				to_chat(user, span_warning("You fumble with [src]'s cap! The cap falls onto the ground and simply vanishes. Where the hell did it go?"))
				cap_lost = TRUE
			else
				to_chat(user, span_notice("You remove the cap from [src]."))
		else
			set_cap_status(TRUE)
			to_chat(user, span_notice("You put the cap on [src]."))
		playsound(src, 'sound/items/glass_cap.ogg', 50, 1)

/obj/item/reagent_containers/proc/canconsume(mob/eater, mob/user)
	if(!iscarbon(eater))
		return 0
	var/mob/living/carbon/C = eater
	var/covered = ""
	if(C.is_mouth_covered(head_only = 1))
		covered = "headgear"
	else if(C.is_mouth_covered(mask_only = 1))
		covered = "mask"
	if(covered)
		var/who = (isnull(user) || eater == user) ? "your" : "[eater.p_their()]"
		to_chat(user, span_warning("You have to remove [who] [covered] first!"))
		return 0
	if(!eater.has_mouth())
		if(eater == user)
			to_chat(eater, span_warning("You have no mouth, and cannot eat."))
		else
			to_chat(user, span_warning("You can't feed [eater], because they have no mouth!"))
		return 0
	return 1

/obj/item/reagent_containers/ex_act()
	if(reagents)
		for(var/datum/reagent/R in reagents.reagent_list)
			R.on_ex_act()
	if(!QDELETED(src))
		..()

/obj/item/reagent_containers/fire_act(exposed_temperature, exposed_volume)
	reagents.expose_temperature(exposed_temperature)
	..()

/obj/item/reagent_containers/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	SplashReagents(hit_atom, TRUE)

/obj/item/reagent_containers/proc/bartender_check(atom/target)
	. = FALSE
	var/mob/thrown_by = thrownby?.resolve()
	if(target.CanPass(src, get_dir(target, src)) && thrown_by && HAS_TRAIT(thrown_by, TRAIT_BOOZE_SLIDER))
		. = TRUE

/obj/item/reagent_containers/proc/SplashReagents(atom/target, thrown = FALSE)
	if(!reagents || !reagents.total_volume || !spillable)
		return
	var/mob/thrown_by = thrownby?.resolve()

	if(ismob(target) && target.reagents)
		if(thrown)
			reagents.total_volume *= rand(5,10) * 0.1 //Not all of it makes contact with the target
		var/mob/M = target
		var/R
		playsound(src, 'sound/items/glass_splash.ogg', 50, 1)
		target.visible_message(span_danger("[M] is splashed with something!"), \
						span_userdanger("[M] is splashed with something!"))
		for(var/datum/reagent/A in reagents.reagent_list)
			R += "[A.type]  ([num2text(A.volume)]),"

		if(thrown_by)
			log_combat(thrown_by, M, "splashed", R)
		reagents.expose(target, TOUCH)

	else if(bartender_check(target) && thrown)
		visible_message(span_notice("[src] lands onto the [target.name] without spilling a single drop."))
		return

	else
		if(isturf(target) && reagents.reagent_list.len && thrown_by)
			log_combat(thrown_by, target, "splashed (thrown) [english_list(reagents.reagent_list)]", "in [AREACOORD(target)]")
			log_game("[key_name(thrown_by)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] in [AREACOORD(target)].")
			message_admins("[ADMIN_LOOKUPFLW(thrown_by)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] in [ADMIN_VERBOSEJMP(target)].")
		playsound(src, 'sound/items/glass_splash.ogg', 50, 1)
		visible_message(span_notice("[src] spills its contents all over [target]."))
		reagents.expose(target, TOUCH)
		if(QDELETED(src))
			return

	reagents.clear_reagents()

/obj/item/reagent_containers/microwave_act(obj/machinery/microwave/M)
	reagents.expose_temperature(1000)
	..()

/obj/item/reagent_containers/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	reagents.expose_temperature(exposed_temperature)

/obj/item/reagent_containers/attackby(obj/item/I, mob/user, params) //procs dip_object any time an object is used on a container, makes the noises if any reagent returned true
	var/success = FALSE
	if(is_refillable())
		for(var/datum/reagent/R in reagents.reagent_list)
			if(R.dip_object(I, user, src))
				success = TRUE
		if(success)
			to_chat(user, span_notice("You dip [I] into [src], and the solution begins to bubble."))
			playsound(src, 'sound/effects/bubbles.ogg', 80, TRUE)
			return TRUE
	return ..()

/obj/item/reagent_containers/on_reagent_change(changetype)
	update_appearance()

/obj/item/reagent_containers/update_overlays()
	. = ..()
	if(cap_on)
		. += cap_overlay
	if(!fill_icon_thresholds)
		return
	if(!reagents.total_volume)
		return

	var/fill_name = fill_icon_state? fill_icon_state : icon_state
	var/mutable_appearance/filling = mutable_appearance(fill_icon, "[fill_name][fill_icon_thresholds[1]]")

	var/percent = round((reagents.total_volume / volume) * 100)
	for(var/i in 1 to fill_icon_thresholds.len)
		var/threshold = fill_icon_thresholds[i]
		var/threshold_end = (i == fill_icon_thresholds.len)? INFINITY : fill_icon_thresholds[i+1]
		if(threshold <= percent && percent < threshold_end)
			filling.icon_state = "[fill_name][fill_icon_thresholds[i]]"

	filling.color = mix_color_from_reagents(reagents.reagent_list)
	. += filling

/obj/item/reagent_containers/get_save_vars()
	//Leave it null.
	if(reagents.total_volume <= 0)
		return ..()

	list_reagents = list()
	for(var/reagent in reagents.reagent_list)
		var/datum/reagent/R = reagent
		list_reagents[R.type] = R.volume
	return ..() + "list_reagents"
