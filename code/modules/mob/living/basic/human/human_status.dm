// Procs for handling how basicmobs get affected by status effects, knockdowns, stuns etc

// crawling while we're down, as slowly as a player does
/mob/living/basic/human/set_body_position(new_value, fall_sound_played)
	. = ..()
	if(isnull(.))
		return
	if(new_value == LYING_DOWN)
		add_movespeed_modifier(/datum/movespeed_modifier/carbon_crawling)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/carbon_crawling)
		on_get_up() // only once we're actually on our feet, after the second it takes to stand

// back on our feet if we're lying about with nothing keeping us down
/mob/living/basic/human/Life(seconds_per_tick = SSMOBS_DT, times_fired)
	. = ..()
	if(body_position == LYING_DOWN && !resting && !client && stat == CONSCIOUS && !HAS_TRAIT(src, TRAIT_FLOORED) && !LAZYACCESS(do_afters, DOAFTER_SOURCE_GETTING_UP))
		get_up()
	// unbuckle self if you can, chair cheese mitigation
	if(buckled && !client && stat == CONSCIOUS && !incapacitated())
		buckled.user_unbuckle_mob(src, src)
	// try to escape from locker/containment unit. same length of time as normal player
	if(!isturf(loc) && !client && stat == CONSCIOUS && can_resist() && !LAZYACCESS(do_afters, loc))
		INVOKE_ASYNC(loc, TYPE_PROC_REF(/atom, container_resist_act), src)

// clear out stuttering eventually
/mob/living/basic/human/handle_status_effects(seconds_per_tick, times_fired)
	. = ..()
	if(stuttering)
		stuttering = max(stuttering - (0.5 * seconds_per_tick), 0)
	if(slurring)
		slurring = max(slurring - (0.5 * seconds_per_tick), 0)
	// do cult and clockcult even exist outside of admemes?
	if(cultslurring)
		cultslurring = max(cultslurring - (0.5 * seconds_per_tick), 0)
	if(clockcultslurring)
		clockcultslurring = max(clockcultslurring - (0.5 * seconds_per_tick), 0)

// dont melee while down
/mob/living/basic/human/proc/on_pre_melee(datum/source, atom/target)
	SIGNAL_HANDLER
	if(!client && (HAS_TRAIT(src, TRAIT_FLOORED) || body_position == LYING_DOWN || world.time < off_balance_until)) // still on the floor while we get up, too
		return COMPONENT_HOSTILE_NO_ATTACK

// back on our feet after a knockdown, delaying firing and resetting aim
/mob/living/basic/human/proc/on_get_up()
	if(client || stat != CONSCIOUS)
		return
	var/datum/component/ranged_attacks/ranged_attack = GetComponent(/datum/component/ranged_attacks)
	ranged_attack?.delay_next_volley(AI_GET_UP_FIRE_DELAY)
	ai_controller?.clear_blackboard_key(BB_BASIC_MOB_LAST_FIRED_TIME) // first contact spread again after getting up, as if recovering
	ai_controller?.clear_blackboard_key(BB_BASIC_MOB_AIMED_AT) // on everyone, as it's our aim that's off

// knocked flat by a blast, less their bomb armour, on top of the damage every basic mob takes
/mob/living/basic/human/ex_act(severity, target, light_dam = EX_LIGHT_BASE_DAM, light_item_dam = EX_LIGHT_BASE_ITEM_DAM, heavy_dam = EX_HEAVY_BASE_DAM, heavy_item_dam = EX_HEAVY_BASE_ITEM_DAM, origin)
	. = ..()
	if(QDELETED(src) || stat == DEAD)
		return
	var/bomb_armor = getarmor(null, BOMB)
	switch(severity)
		if(EXPLODE_HEAVY)
			Unconscious(2 SECONDS)
			Knockdown(max(20 SECONDS - bomb_armor * 1.6, 0))
		if(EXPLODE_LIGHT)
			Knockdown(max(16 SECONDS - bomb_armor * 1.6, 0))

/mob/living/basic/human/Stun(amount, ignore_canstun = FALSE)
	return ..(diminish_stun(amount * stun_multiplier, STUN_DR_HARD, IsStun()), ignore_canstun)

/mob/living/basic/human/Knockdown(amount, ignore_canstun = FALSE)
	if(rolling_out_fire || HAS_TRAIT_FROM(src, TRAIT_HANDS_BLOCKED, "stop_drop_roll"))
		return ..(amount, ignore_canstun)
	if(knockdowns_slow_instead)
		return stagger(amount * stun_multiplier)
	var/was_down = HAS_TRAIT(src, TRAIT_FLOORED)
	. = ..(diminish_stun(amount * stun_multiplier, STUN_DR_KNOCKDOWN, IsKnockdown()), ignore_canstun)
	call_out_going_down(was_down)

/mob/living/basic/human/Immobilize(amount, ignore_canstun = FALSE)
	return ..(diminish_stun(amount * stun_multiplier, STUN_DR_IMMOBILIZE, IsImmobilized()), ignore_canstun)

/mob/living/basic/human/Paralyze(amount, ignore_canstun = FALSE)
	if(knockdowns_slow_instead)
		return stagger(amount * stun_multiplier)
	var/was_down = HAS_TRAIT(src, TRAIT_FLOORED)
	. = ..(diminish_stun(amount * stun_multiplier, STUN_DR_HARD, IsParalyzed()), ignore_canstun)
	call_out_going_down(was_down)

// diminishing returns on stuns on basicmobs
/mob/living/basic/human/proc/diminish_stun(amount, kind, datum/status_effect/already_on)
	if(amount <= 0 || client || rolling_out_fire || HAS_TRAIT_FROM(src, TRAIT_HANDS_BLOCKED, "stop_drop_roll"))
		return amount
	if(already_on && (already_on.duration == -1 || world.time + amount <= already_on.duration))
		return amount // ends before what's already on us, so don't count it
	if(world.time >= stun_dr_reset_at)
		stun_dr_steps = null // free of every kind for long enough that it's a fresh start
	var/times_already = LAZYACCESS(stun_dr_steps, kind) || 0
	LAZYSET(stun_dr_steps, kind, times_already + 1)
	var/diminished_amount = 0 // assume we're already immune
	if(times_already < BASIC_MOB_STUN_DR_STEPS)
		diminished_amount = amount * (0.5 ** times_already) // halved for each we've had already: all of it, then half, then a quarter
	note_disabled_until(world.time + diminished_amount)
	return diminished_amount


// shared timer, so swapping between different CCs can't keep us down by letting each one recover while another's on us
/mob/living/basic/human/proc/note_disabled_until(until)
	stun_dr_reset_at = max(stun_dr_reset_at, until + BASIC_MOB_STUN_DR_WINDOW)

/mob/living/basic/human/proc/call_out_going_down(was_down)
	if(!was_down && HAS_TRAIT(src, TRAIT_FLOORED) && stat == CONSCIOUS && !client)
		ai_callout(src, AI_CALLOUT_KNOCKED_DOWN, interrupt = TRUE)

/mob/living/basic/human/get_eye_protection()
	return ..() + flash_protection

/mob/living/basic/human/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0, type = /atom/movable/screen/fullscreen/flash)
	. = ..()
	if((. & FLASH_EFFECT) && stat == CONSCIOUS && !client)
		ai_callout(src, AI_CALLOUT_FLASHED, interrupt = TRUE)

/mob/living/basic/human/Unconscious(amount, ignore_canstun = FALSE)
	if(knockdowns_slow_instead)
		return stagger(amount * stun_multiplier)
	return ..(diminish_stun(amount * stun_multiplier, STUN_DR_HARD, IsUnconscious()), ignore_canstun)

// with knockdowns_slow_instead, slowed for a while rather than knocked down, up to AI_STAGGER_MAX_TIME
/mob/living/basic/human/proc/stagger(amount)
	if(amount <= 0 || stat == DEAD)
		return
	var/new_end = world.time + min(amount, AI_STAGGER_MAX_TIME)
	if(new_end <= staggered_until)
		return
	if(world.time >= staggered_until && stat == CONSCIOUS && !client)
		ai_callout(src, AI_CALLOUT_STAGGERED, interrupt = TRUE) // only as it starts, not each time it's topped up
	staggered_until = new_end
	add_movespeed_modifier(/datum/movespeed_modifier/ai_staggered)
	addtimer(CALLBACK(src, PROC_REF(end_stagger)), new_end - world.time, TIMER_UNIQUE | TIMER_OVERRIDE)

/mob/living/basic/human/proc/end_stagger()
	staggered_until = 0
	remove_movespeed_modifier(/datum/movespeed_modifier/ai_staggered)

/mob/living/basic/human/update_stamina()
	var/stamina_damage = getStaminaLoss()
	if(stamina_damage > DAMAGE_PRECISION && health - stamina_damage <= 0 && stat == CONSCIOUS)
		if(HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, STAMINA))
			return
		if(world.time < stamina_collapse_grace_until && !client)
			return // only just back up from it, so we stay on our feet a moment, rather than being kept down for as long as they keep at us
		if(knockdowns_slow_instead)
			stagger(AI_STAGGER_MAX_TIME) // too hardy to collapse, it just slows us down
			return
		visible_message(span_warning("[src] collapses, too exhausted to keep going!"))
		ADD_TRAIT(src, TRAIT_INCAPACITATED, STAMINA)
		ADD_TRAIT(src, TRAIT_IMMOBILIZED, STAMINA)
		ADD_TRAIT(src, TRAIT_FLOORED, STAMINA)
		ADD_TRAIT(src, TRAIT_HANDS_BLOCKED, STAMINA)
		if(maxHealth - health + stamina_damage > 120) // a little further in, so it isn't over the moment it starts
			adjustStaminaLoss(30, FALSE)
		if(!client)
			addtimer(CALLBACK(src, PROC_REF(end_stamina_collapse)), BASIC_MOB_STAMINA_COLLAPSE_MAX, TIMER_UNIQUE | TIMER_OVERRIDE)
			note_disabled_until(world.time + BASIC_MOB_STAMINA_COLLAPSE_MAX) // floored is floored, so it keeps the rest from wearing off too
	else if(HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, STAMINA))
		REMOVE_TRAIT(src, TRAIT_INCAPACITATED, STAMINA)
		REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, STAMINA)
		REMOVE_TRAIT(src, TRAIT_FLOORED, STAMINA)
		REMOVE_TRAIT(src, TRAIT_HANDS_BLOCKED, STAMINA)
		stamina_collapse_grace_until = world.time + BASIC_MOB_STAMINA_COLLAPSE_GRACE

// down from exhaustion for BASIC_MOB_STAMINA_COLLAPSE_MAX, so we get back up with just enough left in us to stand, rather than staying down for as long as they keep hitting us
// update_stamina() then has us up, and keeps us up for BASIC_MOB_STAMINA_COLLAPSE_GRACE
/mob/living/basic/human/proc/end_stamina_collapse()
	if(client || stat != CONSCIOUS || !HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, STAMINA))
		return
	visible_message(span_warning("[src] staggers back to [p_their()] feet!"))
	setStaminaLoss(max(health - 10, 0), FALSE)
	update_stamina()

/mob/living/basic/human/proc/pepper_act()
	if(pepper_proof || stat == DEAD)
		return
	if(!has_status_effect(/datum/status_effect/ai_peppered) && stat == CONSCIOUS && !client)
		ai_callout(src, AI_CALLOUT_GASSED, interrupt = TRUE) // as it first gets us, not each breath of it
	Knockdown(3 SECONDS)
	apply_status_effect(/datum/status_effect/ai_peppered)

/datum/status_effect/ai_peppered
	id = "ai_peppered"
	duration = 10 SECONDS
	tick_interval = 2 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null
	// how much worse our aim gets, in degrees
	var/spread_penalty = 30
	var/blurred_vision_range = 2
	// what our sight was before, to give back
	var/old_vision_range

/datum/status_effect/ai_peppered/on_apply()
	. = ..()
	var/datum/component/ranged_attacks/ranged_attack = owner.GetComponent(/datum/component/ranged_attacks)
	if(ranged_attack)
		ranged_attack.spread += spread_penalty
	var/datum/ai_controller/controller = owner.ai_controller
	if(controller)
		old_vision_range = controller.blackboard[BB_BASIC_MOB_VISION_RANGE]
		controller.set_blackboard_key(BB_BASIC_MOB_VISION_RANGE, blurred_vision_range)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/reagent/pepperspray)

/datum/status_effect/ai_peppered/on_remove()
	var/datum/component/ranged_attacks/ranged_attack = owner.GetComponent(/datum/component/ranged_attacks)
	if(ranged_attack)
		ranged_attack.spread -= spread_penalty
	var/datum/ai_controller/controller = owner.ai_controller
	if(controller)
		if(isnull(old_vision_range))
			controller.clear_blackboard_key(BB_BASIC_MOB_VISION_RANGE)
		else
			controller.set_blackboard_key(BB_BASIC_MOB_VISION_RANGE, old_vision_range)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/pepperspray)
	return ..()

/datum/status_effect/ai_peppered/tick(seconds_per_tick, times_fired)
	if(prob(40) && owner.stat == CONSCIOUS)
		owner.visible_message(span_warning("[owner] [pick("coughs!", "splutters!", "dry heaves!", "rubs at their streaming eyes!")]"))

// lets them get shoved
/mob/living/basic/human/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if(user.a_intent != INTENT_DISARM || stat != CONSCIOUS || user == src)
		return ..()
	if(blocks_shove_with_shield(user))
		user.do_attack_animation(src, ATTACK_EFFECT_DISARM)
		user.changeNext_move(CLICK_CD_BLOCKED) // as a player's shield blocking it would
		log_combat(user, src, "shoved", "blocked by their shield")
		return
	var/turf/old_turf = loc
	. = ..()
	if(stat != CONSCIOUS)
		return
	if(loc == old_turf)
		if(!blocks_shove_knockdown())
			Stun(1.5 SECONDS) // up against something, so we're sent reeling, unless we're in something like riot armour, as players are
		return
	if(!has_movespeed_modifier(/datum/movespeed_modifier/shove))
		add_movespeed_modifier(/datum/movespeed_modifier/shove)
		addtimer(CALLBACK(src, PROC_REF(clear_shove_slowdown)), SHOVE_SLOWDOWN_LENGTH)
	// staggered, so we can't swing straight back the moment we're in reach again, which we'd otherwise be far quicker at than a player
	if(world.time >= off_balance_immune_until)
		off_balance_until = world.time + AI_SHOVE_OFF_BALANCE_TIME
		off_balance_immune_until = off_balance_until + AI_SHOVE_OFF_BALANCE_IMMUNITY

/mob/living/basic/human/proc/clear_shove_slowdown()
	remove_movespeed_modifier(/datum/movespeed_modifier/shove)
