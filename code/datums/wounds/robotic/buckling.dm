#define MAX_TAPE_STACKS 5
#define DAMAGE_PER_STACK 10
#define TAPE_SCALE 50

#define TAPE_FACTOR_CALC(amount, strength) (TAPE_SCALE / (TAPE_SCALE + (amount * strength)**2))

/datum/wound/blunt/buckling
	name = "Blunt (Metal) Wound"
	sound_effect = 'sound/machines/clockcult/integration_cog_install.ogg'
	wound_flags = PLATING_DAMAGE
	bio_state_required = BIO_METAL

	/// The tape applied to this wound.
	var/obj/item/stack/tape/applied_tape

/datum/wound_pregen_data/buckling
	abstract = TRUE
	required_limb_biostate = BIO_METAL

	required_wounding_types = list(WOUND_BLUNT)

	wound_series = WOUND_SERIES_METAL_BUCKLING

/datum/wound/blunt/buckling/moderate
	name = "Bent Plating"
	desc = "Patient's external plating is bent out of shape."
	treat_text = "Recommend prying the external plate back into place."
	examine_desc = "is bent out of shape"
	occur_text = "suddenly bends out of shape"
	sound_effect = 'sound/effects/bin_open.ogg'
	treatable_tools = list(TOOL_CROWBAR, TOOL_WIRECUTTER)
	treatable_by = list(/obj/item/stack/tape)
	severity = WOUND_SEVERITY_MODERATE
	interaction_efficiency_penalty = 1.2
	threshold_penalty = 20
	limp_slowdown = 2.25
	limp_chance = 50

/datum/wound_pregen_data/buckling/dented
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/buckling/moderate
	threshold_minimum = 35

/datum/wound/blunt/buckling/severe
	name = "Buckled Chassis"
	desc = "Patient's chassis is buckled inwards, causing disruption to mobility. Applying duct tape can temporarily secure the limb until proper repairs."
	treat_text = "Recommend replacement of external plating."
	examine_desc = "is buckled inwards"
	occur_text = "creaks and buckles inwards"
	severity = WOUND_SEVERITY_SEVERE
	wound_flags = MANGLES_INTERIOR | PLATING_DAMAGE
	treatable_tools = list(TOOL_WIRECUTTER) // for tape removal
	treatable_by = list(/obj/item/stack/tape)
	interaction_efficiency_penalty = 2
	threshold_penalty = 40
	limp_slowdown = 6
	limp_chance = 60

/datum/wound_pregen_data/buckling/buckled
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/buckling/severe
	threshold_minimum = 70

/datum/wound/blunt/buckling/critical
	name = "Sheared Frame"
	desc = "Patient's limb is sheared, rendering it inoperable."
	treat_text = "Recommend replacement of internal frame and external plating. Applying duct tape can temporarily secure the limb until proper repairs."
	examine_desc = "is sheared off, barely hanging on by the wires"
	occur_text = "violently snaps as its frame shears apart"
	wound_flags = MANGLES_INTERIOR | PLATING_DAMAGE
	severity = WOUND_SEVERITY_CRITICAL
	treatable_tools = list(TOOL_WIRECUTTER) // for tape removal
	treatable_by = list(/obj/item/stack/tape) // duct tape will fix anything
	disabling = TRUE
	interaction_efficiency_penalty = 2.5
	threshold_penalty = 50
	limp_slowdown = 9
	limp_chance = 70

/datum/wound_pregen_data/buckling/sheared
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/buckling/critical
	threshold_minimum = 125

/datum/wound/blunt/buckling/remove_wound(ignore_limb, replaced)
	limp_slowdown = 0
	limp_chance = 0
	if(applied_tape)
		QDEL_NULL(applied_tape)
	return ..()

/datum/wound/blunt/buckling/treat(obj/item/treatment, mob/user)
	if(istype(treatment, /obj/item/stack/tape))
		return apply_tape(treatment, user)
	if(treatment.tool_behaviour == TOOL_WIRECUTTER)
		return remove_tape(treatment, user)
	if(treatment.tool_behaviour == TOOL_CROWBAR)
		return pry_chassis(treatment, user)

/// Applies tape to the wound.
/datum/wound/blunt/buckling/proc/apply_tape(obj/item/stack/tape/new_tape, mob/user)
	if(applied_tape?.amount >= MAX_TAPE_STACKS)
		to_chat(user, span_notice("[limb] has too much tape on it already!"))
		return TRUE
	if(new_tape.amount < 1)
		to_chat(user, span_notice("[new_tape] does not contain enough tape!"))
		return TRUE
	victim.visible_message(
		span_notice("[user] starts applying [new_tape.name] to [victim]'s [limb]."),
		span_notice("[user] starts applying [new_tape.name] to your [limb]."),
	)
	while(applied_tape?.amount < MAX_TAPE_STACKS && new_tape.use_tool(victim, user, 2 SECONDS, amount = 1, volume = 50))
		if(!applied_tape)
			applied_tape = new new_tape.type(null, 1)
		else
			applied_tape.add(1)
		update_inefficiencies()
		if(applied_tape.amount >= MAX_TAPE_STACKS)
			victim.visible_message(
				span_notice("[user] finishes applying [applied_tape.name] to [victim]'s [limb]."),
				span_notice("[user] finishes applying [applied_tape.name] to your [limb]."),
			)
			return TRUE
		victim.visible_message(
			span_notice("[user] applies some [applied_tape.name] to [victim]'s [limb]."),
			span_notice("[user] applies some [applied_tape.name] to your [limb]."),
		)
	return TRUE

/// Removes tape from the round.
/datum/wound/blunt/buckling/proc/remove_tape(obj/item/tool, mob/user)
	victim.visible_message(
		span_notice("[user] tries to remove the [applied_tape] from [victim]'s [limb.name]."),
		span_danger("[user] tries to remove the [applied_tape] from your [limb.name]!"),
	)
	if(!tool.use_tool(victim, user, 3 SECONDS, volume = 50))
		return TRUE
	victim.visible_message(
		span_notice("[user] removes the [applied_tape.name] from [victim]'s [limb.name]."),
		span_danger("[user] removes the [applied_tape.name] from your [limb]."),
	)
	QDEL_NULL(applied_tape)
	return TRUE

/// Pries moderately buckled limbs back into shape
/datum/wound/blunt/buckling/proc/pry_chassis(obj/item/tool, mob/user)
	victim.visible_message(
		span_notice("[user] starts prying the plating on [victim]'s [limb.name] back into place."),
		span_notice("[user] starts prying the plating on your [limb.name] back into place."),
	)
	if(!tool.use_tool(victim, user, 5 SECONDS, volume = 50))
		return TRUE
	victim.visible_message(
		span_notice("[user] pries the plating on [victim]'s [limb.name] back into place."),
		span_notice("[user] pries the plating on your [limb.name] back into place."),
	)
	qdel(src)
	return TRUE

/datum/wound/blunt/buckling/receive_damage(list/wounding_types, total_wound_dmg, wound_bonus, attack_direction)
	if(!applied_tape)
		return
	applied_tape.use(round(total_wound_dmg / DAMAGE_PER_STACK))
	if(QDELETED(applied_tape))
		if(victim)
			victim.visible_message(
				span_warning("The [applied_tape.name] on [victim]'s [limb.name] falls apart!"),
				span_danger("The [applied_tape.name] on your [limb.name] falls apart!")
			)
		applied_tape = null
	update_inefficiencies()

/datum/wound/blunt/buckling/update_inefficiencies()
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
	start_limping_if_we_should()

/datum/wound/blunt/buckling/modify_desc_before_span(desc, mob/user)
	if(!applied_tape)
		return desc
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
	return "[victim.p_their(TRUE)] [limb.name] is [tape_msg] held together with [applied_tape.name]"

#undef TAPE_FACTOR_CALC

#undef TAPE_SCALE
#undef DAMAGE_PER_STACK
#undef MAX_TAPE_STACKS
