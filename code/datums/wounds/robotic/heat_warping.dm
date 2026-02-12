/// The flame temperature required to re-heat the chassis.
#define CHASSIS_MELTING_POINT 1900

/datum/wound/burn/heat_warping
	name = "Heat-Warping Wound"
	sound_effect = 'sound/machines/clockcult/steam_whoosh.ogg'

	wound_flags = PLATING_DAMAGE
	bio_state_required = BIO_METAL

	/// Whether the limb has been re-heated, allowing it to be bent back into shape
	var/re_heated = FALSE

/datum/wound_pregen_data/heat_warping
	abstract = TRUE
	required_limb_biostate = BIO_METAL

	required_wounding_types = list(WOUND_BURN)

	wound_series = WOUND_SERIES_METAL_HEAT_WARPING

/datum/wound/burn/heat_warping/set_limb(obj/item/bodypart/new_value, replaced)
	var/obj/item/bodypart/old_limb = ..()
	if(old_limb && !replaced && !QDELETED(old_limb))
		old_limb.heal_damage(burn = min(old_limb.max_damage, WOUND_MAX_INTEGRITY_CONSIDERED) * limb_integrity_penalty)
	if(new_value)
		var/limb_damage = limb.get_damage()
		if(limb_damage < limb.wound_integrity_loss)
			limb.set_burn_dam(CEILING(limb.burn_dam + limb.wound_integrity_loss - limb_damage, DAMAGE_PRECISION))
	return old_limb

/datum/wound/burn/heat_warping/treat(obj/item/tool, mob/user)
	if(tool.tool_behaviour == TOOL_WELDER)
		return heat_chassis(tool, user)
	if(tool.tool_behaviour == TOOL_CROWBAR)
		return bend_chassis(tool, user)
	return ..()

/datum/wound/burn/heat_warping/check_grab_treatments(obj/item/tool, mob/user)
	if(tool.get_temperature() > CHASSIS_MELTING_POINT)
		INVOKE_ASYNC(src, PROC_REF(heat_chassis), tool, user)
		return TRUE
	return FALSE

/datum/wound/burn/heat_warping/get_examine_description(mob/user)
	. = ..()
	if(re_heated)
		. += span_notice("<B> It has been re-heated and can be bent back into shape.</B>")

/datum/wound/burn/heat_warping/proc/heat_chassis(obj/item/tool, mob/user)
	if(re_heated)
		to_chat(user, span_warning("[victim]'s [limb.name] is already hot!"))
		return TRUE
	victim.visible_message(
		span_notice("[user] begins re-heating [victim]'s [limb.name]..."),
		span_notice("[user] begins re-heating your [limb.name]..."),
	)
	if(!tool.use_tool(victim, user, 5 SECONDS, volume = 50))
		return TRUE
	victim.visible_message(
		span_notice("[victim]'s [limb.name] glows red-hot, ready to be reformed."),
		span_notice("Your [limb.name] glows red-hot, ready to be reformed."),
	)
	re_heated = TRUE
	addtimer(CALLBACK(src, PROC_REF(cool_down)), 1 MINUTES, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_DELETE_ME)
	return TRUE

/datum/wound/burn/heat_warping/proc/bend_chassis(obj/item/tool, mob/user)
	if(!re_heated)
		return FALSE
	victim.visible_message(
		span_notice("[user] starts to bend [victim]'s [limb.name] back into shape..."),
		span_notice("[user] starts to bend your [limb.name] back into shape..."),
	)
	if(!tool.use_tool(victim, user, 4 SECONDS, volume = 50))
		return TRUE
	victim.visible_message(
		span_notice("[user] starts to bend [victim]'s [limb.name] back into shape..."),
		span_notice("[user] starts to bend your [limb.name] back into shape..."),
	)
	qdel(src)
	return TRUE

/datum/wound/burn/heat_warping/proc/cool_down()
	victim.visible_message(
		span_warning("[victim]'s [limb.name] cools back down."),
		span_warning("Your [limb.name] cools back down."),
	)
	re_heated = FALSE

/datum/wound/burn/heat_warping/moderate
	name = "Surface Oxidization"
	desc = "Patient's external plating has been oxidized by high temperature."
	treat_text = "Recommend applying a cleaning agent to remove the oxidized layer, or burning it off with a welding tool."
	examine_desc = "is oxidized across much of its surface"
	occur_text = "starts to become discolored"
	severity = WOUND_SEVERITY_MODERATE
	treatable_tools = list(TOOL_WELDER)
	threshold_penalty = 20
	limb_integrity_penalty = 0.1

/datum/wound_pregen_data/heat_warping/oxidation
	abstract = FALSE

	wound_path_to_generate = /datum/wound/burn/heat_warping/moderate
	threshold_minimum = 30

/datum/wound/burn/heat_warping/oxidation/moderate/set_victim(new_victim)
	if(victim)
		UnregisterSignal(victim, COMSIG_ATOM_EXPOSE_REAGENTS)
	if(new_victim)
		RegisterSignal(victim, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(on_expose))
	return ..()

/datum/wound/burn/heat_warping/moderate/heat_chassis(obj/item/tool, mob/user)
	victim.visible_message(
		span_notice("[user] starts to burn the oxidized layer off of [victim]'s [limb.name]..."),
		span_notice("[user] starts to burn the oxidized layer off of your [limb.name]..."),
	)
	if(!tool.use_tool(victim, user, 4 SECONDS, volume = 50))
		return TRUE
	victim.visible_message(
		span_notice("[user] burns the oxidized layer off of [victim]'s [limb.name]."),
		span_notice("[user] burns the oxidized layer off of your [limb.name]."),
	)
	qdel(src)
	return TRUE

/datum/wound/burn/heat_warping/oxidation/moderate/proc/on_expose(atom/source, list/reagents, datum/reagents/source_reagents, methods, volume_modifier, show_message)
	SIGNAL_HANDLER

	if(!(methods & (TOUCH|VAPOR|PATCH)))
		return
	var/total_clean_power = 0
	for(var/datum/reagent/space_cleaner/cleaner in reagents)
		total_clean_power += cleaner.volume * cleaner.robot_clean_power * volume_modifier
	if (total_clean_power)
		source.visible_message(
			span_notice("The surface of [victim]'s [limb.name] begins to bubble."),
			span_notice("The surface of your [limb.name] begins to bubble."),
		)
		playsound(victim, 'sound/effects/bubbles.ogg', 25 + total_clean_power * 2)
		handle_regen_progress()

/datum/wound/burn/heat_warping/severe
	name = "Warped Plating"
	desc = "Patient's external plating has been warped by thermal stress, threatening its structural integrity."
	treat_text = "Recommend re-heating the external plating and bending it back into shape."
	examine_desc = "is heat-warped and charred"
	occur_text = "warps from the high temperature"
	severity = WOUND_SEVERITY_SEVERE
	treatable_tools = list(TOOL_WELDER, TOOL_CROWBAR)
	threshold_penalty = 30
	limb_integrity_penalty = 0.2

/datum/wound_pregen_data/heat_warping/thermal_stress
	abstract = FALSE

	wound_path_to_generate = /datum/wound/burn/heat_warping/severe
	threshold_minimum = 75

/datum/wound/burn/heat_warping/critical
	name = "Deformed Chassis"
	desc = "Patient's chassis has been severely deformed from temperatures close to its melting point and can no longer function."
	treat_text = "Recommend replacement of the warped external plating."
	examine_desc = "is a deformed mass of metal and slag"
	occur_text = "glows red-hot and begins to deform"
	severity = WOUND_SEVERITY_CRITICAL
	wound_flags = PLATING_DAMAGE | MANGLES_INTERIOR
	disabling = TRUE
	threshold_penalty = 40
	limb_integrity_penalty = 0.3

/datum/wound_pregen_data/heat_warping/deformed_slag
	abstract = FALSE

	wound_path_to_generate = /datum/wound/burn/heat_warping/critical
	threshold_minimum = 130

#undef CHASSIS_MELTING_POINT
