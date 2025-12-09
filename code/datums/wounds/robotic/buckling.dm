#define MAX_TAPE_STACKS 5
#define DAMAGE_PER_STACK 10
#define TAPE_SCALE 50

#define TAPE_FACTOR_CALC(amount, strength) (TAPE_SCALE / (TAPE_SCALE + (amount * strength)**2))

/datum/wound/buckling
	name = "Buckling Wound"
	sound_effect = 'sound/machines/clockcult/integration_cog_install.ogg'
	wound_type = WOUND_BUCKLING
	wound_flags = PLATING_DAMAGE
	bio_state_required = BIO_METAL

	/// The tape applied to this wound.
	var/obj/item/stack/tape/applied_tape

/datum/wound/buckling/moderate
	name = "Bent Plating"
	desc = "Patient's external plating is bent out of shape."
	treat_text = "Recommend prying the external plate back into place."
	examine_desc = "is bent out of shape"
	occur_text = "suddenly bends out of shape"
	sound_effect = 'sound/effects/bin_open.ogg'
	treatable_tool = TOOL_CROWBAR
	severity = WOUND_SEVERITY_MODERATE
	interaction_efficiency_penalty = 1.2
	threshold_minimum = 35
	threshold_penalty = 15
	limp_slowdown = 2.25
	limp_chance = 50

/datum/wound/buckling/severe
	name = "Buckled Chassis"
	desc = "Patient's chassis is buckled inwards, causing disruption to mobility."
	treat_text = "Recommend replacement of external plating."
	examine_desc = "is buckled inwards"
	occur_text = "creaks and buckles inwards"
	severity = WOUND_SEVERITY_SEVERE
	treatable_tool = TOOL_WIRECUTTER // for tape removal
	treatable_by = list(/obj/item/stack/tape)
	interaction_efficiency_penalty = 2
	threshold_minimum = 70
	threshold_penalty = 30
	limp_slowdown = 6
	limp_chance = 60

/datum/wound/buckling/critical
	name = "Sheared Frame"
	desc = "Patient's limb is sheared, rendering it inoperable."
	treat_text = "Recommend replacement of internal frame and external plating."
	examine_desc = "is sheared off, barely hanging on by the wires"
	occur_text = "violently snaps as its frame shears apart"
	wound_flags = MANGLES_LIMB | PLATING_DAMAGE
	severity = WOUND_SEVERITY_CRITICAL
	treatable_tool = TOOL_WIRECUTTER // for tape removal
	treatable_by = list(/obj/item/stack/tape) // duct tape will fix anything
	disabling = TRUE
	interaction_efficiency_penalty = 2.5
	threshold_minimum = 115
	threshold_penalty = 50
	limp_slowdown = 9
	limp_chance = 70

/datum/wound/buckling/wound_injury(datum/wound/old_wound, attack_direction)
	update_inefficiencies()

/datum/wound/buckling/remove_wound(ignore_limb, replaced)
	limp_slowdown = 0
	limp_chance = 0
	if(applied_tape)
		QDEL_NULL(applied_tape)
	return ..()

/datum/wound/buckling/treat(obj/item/treatment, mob/user)
	if(istype(treatment, /obj/item/stack/tape))
		INVOKE_ASYNC(src, PROC_REF(apply_tape), treatment, user)
		return
	if(treatment.tool_behaviour == TOOL_WIRECUTTER)
		remove_tape(treatment, user)
		return
	if(treatment.tool_behaviour == TOOL_CROWBAR)
		pry_chassis(treatment, user)
		return

/// Applies tape to the wound. This loops and should be called asyncronously.
/datum/wound/buckling/proc/apply_tape(obj/item/stack/tape/new_tape, mob/user, recursive = FALSE)
	if(applied_tape?.amount >= MAX_TAPE_STACKS)
		to_chat(user, span_notice("[limb] has too much tape on it already!"))
		return
	if(new_tape.amount < 1)
		to_chat(user, span_notice("[new_tape] does not contain enough tape!"))
		return
	victim.visible_message(
		span_notice("[user] starts applying [new_tape.name] to [victim]'s [limb]."),
		span_notice("[user] starts applying [new_tape.name] to your [limb]."),
	)
	while(applied_tape?.amount < MAX_TAPE_STACKS && new_tape.use_tool(victim, user, 2 SECONDS, amount = 1))
		if(!applied_tape)
			applied_tape = new new_tape.type(null, FALSE, 1)
		else
			applied_tape.add(1)
		update_inefficiencies()
		if(applied_tape.amount >= MAX_TAPE_STACKS)
			victim.visible_message(
				span_notice("[user] finishes applying [applied_tape.name] to [victim]'s [limb]."),
				span_notice("[user] finishes applying [applied_tape.name] to your [limb]."),
			)
			return
		victim.visible_message(
			span_notice("[user] applies some [applied_tape.name] to [victim]'s [limb]."),
			span_notice("[user] applies some [applied_tape.name] to your [limb]."),
		)


/// Removes tape from the round.
/datum/wound/buckling/proc/remove_tape(obj/item/tool, mob/user)
	victim.visible_message(
		span_notice("[user] tries to remove the [applied_tape] from [victim]'s [limb.name]."),
		span_danger("[user] tries to remove the [applied_tape] from your [limb.name]!"),
	)
	if(!tool.use_tool(victim, user, 3 SECONDS, volume = 50))
		return
	victim.visible_message(
		span_notice("[user] removes the [applied_tape.name] from [victim]'s [limb.name]."),
		span_danger("[user] removes the [applied_tape.name] from your [limb]."),
	)
	QDEL_NULL(applied_tape)

/// Pries moderately buckled limbs back into shape
/datum/wound/buckling/proc/pry_chassis(obj/item/tool, mob/user)
	victim.visible_message(
		span_notice("[user] starts prying the plating on [victim]'s [limb.name] back into place."),
		span_notice("[user] starts prying the plating on your [limb.name] back into place."),
	)
	if(!tool.use_tool(victim, user, 5 SECONDS, volume = 50))
		return
	victim.visible_message(
		span_notice("[user] pries the plating on [victim]'s [limb.name] back into place."),
		span_notice("[user] pries the plating on your [limb.name] back into place."),
	)
	qdel(src)

/datum/wound/buckling/receive_damage(list/wounding_types, total_wound_dmg, wound_bonus, attack_direction)
	if(!applied_tape)
		return
	applied_tape.use(round(total_wound_dmg / DAMAGE_PER_STACK))
	update_inefficiencies()

/datum/wound/buckling/proc/update_inefficiencies()
	if(limb.body_part & LEGS)
		victim.apply_status_effect(STATUS_EFFECT_LIMP)

	if(applied_tape)
		var/tape_factor = TAPE_FACTOR_CALC(applied_tape.amount, applied_tape.nonorganic_heal)
		interaction_efficiency_penalty = src::interaction_efficiency_penalty * tape_factor
		limp_slowdown = src::limp_slowdown * tape_factor
		if(applied_tape.amount >= MAX_TAPE_STACKS)
			set_disabling(FALSE)
		else if(applied_tape.amount < CEILING(MAX_TAPE_STACKS / 2, 1))
			set_disabling(src::disabling)
	else
		interaction_efficiency_penalty = src::interaction_efficiency_penalty
		limp_slowdown = src::limp_slowdown
		set_disabling(src::disabling)

	limb.update_wounds()

/datum/wound/buckling/get_examine_description(mob/user)
	if(!applied_tape)
		return ..()
	var/tape_msg
	var/tape_strength = 1 - TAPE_FACTOR_CALC(applied_tape.amount, applied_tape.nonorganic_heal)
	switch(tape_strength)
		if(0.75 to INFINITY)
			tape_msg = "tightly"
		if(0.5 to 0.75)
			tape_msg = "somewhat"
		if(0.25 to 0.5)
			tape_msg = "loosely"
		else
			tape_msg = "just barely"
	return "<B>[victim.p_their(TRUE)] [limb.name] is [tape_msg] held together with [applied_tape.name]!</B>"

#undef TAPE_FACTOR_CALC

#undef TAPE_SCALE
#undef DAMAGE_PER_STACK
#undef MAX_TAPE_STACKS
