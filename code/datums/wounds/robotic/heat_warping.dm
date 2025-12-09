/// The flame temperature required to re-heat the chassis.
#define CHASSIS_MELTING_POINT 1900

/datum/wound/heat_warping
	name = "Heat-Warping Wound"
	sound_effect = 'sound/machines/clockcult/steam_whoosh.ogg'

	wound_type = WOUND_WARP
	wound_flags = PLATING_DAMAGE
	bio_state_required = BIO_METAL

	/// The proportion of max integrity lost to this wound.
	var/integrity_loss = 0
	/// Whether the limb has been re-heated, allowing it to be bent back into shape
	var/re_heated = FALSE

/datum/wound/heat_warping/severe
	name = "Warped Plating"
	desc = "Patient's external plating has been warped by thermal stress, threatening its structural integrity."
	treat_text = "Recommend re-heating the external plating and bending it back into shape."
	examine_desc = "is heat-warped and oxidized"
	occur_text = "warps from the high temperature"
	severity = WOUND_SEVERITY_SEVERE
	treatable_tool = TOOL_WELDER
	threshold_minimum = 80
	threshold_penalty = 20
	integrity_loss = 0.4

/datum/wound/heat_warping/critical
	name = "Deformed Chassis"
	desc = "Patient's chassis has been severely deformed from high temperatures and can no longer function."
	treat_text = "Recommend replacement of the warped external plating."
	examine_desc = "is a deformed mass of charred metal"
	occur_text = "glows red-hot and begins to deform"
	severity = WOUND_SEVERITY_CRITICAL
	disabling = TRUE
	threshold_minimum = 120
	threshold_penalty = 40
	integrity_loss = 0.6

/datum/wound/heat_warping/wound_injury(datum/wound/old_wound, attack_direction)
	update_limb_integrity()

/datum/wound/heat_warping/remove_wound(ignore_limb, replaced)
	if(!replaced)
		update_limb_integrity()
	return ..()

/datum/wound/heat_warping/proc/update_limb_integrity()
	limb.min_damage = min(limb.max_damage, victim.maxHealth) * integrity_loss
	var/limb_damage = limb.get_damage()
	if(limb_damage < limb.min_damage)
		limb.set_burn_dam(CEILING(limb.burn_dam + limb.min_damage - limb_damage, DAMAGE_PRECISION))

/datum/wound/heat_warping/treat(obj/item/tool, mob/user)
	if(tool.tool_behaviour == TOOL_WELDER)
		heat_chassis(tool, user)
		return
	if(tool.tool_behaviour == TOOL_CROWBAR)
		bend_chassis(tool, user)
		return

/datum/wound/heat_warping/check_grab_treatments(obj/item/tool, mob/user)
	if(tool.get_temperature() > CHASSIS_MELTING_POINT)
		INVOKE_ASYNC(src, PROC_REF(heat_chassis), tool, user)
		return TRUE
	return FALSE

/datum/wound/heat_warping/get_examine_description(mob/user)
	. = ..()
	if(re_heated)
		. += span_notice("<B> It has been re-heated and can be bent back into shape.</B>")

/datum/wound/heat_warping/proc/heat_chassis(obj/item/tool, mob/user)
	victim.visible_message(
		span_notice("[user] begins re-heating [victim]'s [limb.name]..."),
		span_notice("[user] begins re-heating your [limb.name]..."),
	)
	if(!tool.use_tool(victim, user, 5 SECONDS, volume = 50))
		return
	victim.visible_message(
		span_notice("[victim]'s [limb.name] glows red-hot, ready to be reformed."),
		span_notice("Your [limb.name] glows red-hot, ready to be reformed."),
	)
	treatable_tool = TOOL_CROWBAR
	re_heated = TRUE
	addtimer(CALLBACK(src, PROC_REF(cool_down)), 1 MINUTES, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_DELETE_ME)

/datum/wound/heat_warping/proc/bend_chassis(obj/item/tool, mob/user)
	victim.visible_message(
		span_notice("[user] starts to bend [victim]'s [limb.name] back into shape..."),
		span_notice("[user] starts to bend your [limb.name] back into shape..."),
	)
	if(!tool.use_tool(victim, user, 4 SECONDS, volume = 50))
		return
	victim.visible_message(
		span_notice("[user] starts to bend [victim]'s [limb.name] back into shape..."),
		span_notice("[user] starts to bend your [limb.name] back into shape..."),
	)
	qdel(src)

/datum/wound/heat_warping/proc/cool_down()
	victim.visible_message(
		span_warning("[victim]'s [limb.name] cools back down."),
		span_warning("Your [limb.name] cools back down."),
	)
	treatable_tool = TOOL_WELDER
	re_heated = FALSE
