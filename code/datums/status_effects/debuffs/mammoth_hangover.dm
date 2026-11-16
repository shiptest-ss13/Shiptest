// MAMMOTH HANGOVER EFFECT //
/datum/status_effect/mammoth_crash
	id = "mammoth_crash"
	tick_interval = 2 SECONDS
	alert_type = null
	remove_on_fullheal = TRUE

/datum/status_effect/mammoth_crash/on_creation(mob/living/new_owner, duration = 5 MINUTES)
	src.duration = duration
	return ..()

/datum/status_effect/mammoth_crash/on_apply()
	RegisterSignal(owner, COMSIG_MOB_DEATH, PROC_REF(clear_self))
	owner.add_movespeed_modifier(/datum/movespeed_modifier/reagent/mammoth_crash)
	if(ishuman(owner))
		var/mob/living/carbon/human/tweaker = owner
		tweaker.physiology.do_after_speed -= 0.3
	return TRUE

/datum/status_effect/mammoth_crash/on_remove()
	UnregisterSignal(owner, COMSIG_MOB_DEATH)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/mammoth_crash)
	if(ishuman(owner))
		var/mob/living/carbon/human/tweaker = owner
		tweaker.physiology.do_after_speed += 0.3
	return TRUE

// remove hangover on death
/datum/status_effect/mammoth_crash/proc/clear_self(datum/source)
	SIGNAL_HANDLER
	qdel(src)

/datum/status_effect/mammoth_crash/tick()
	if(prob(5))
		var/suffering_message = pick(
		"Your head pounds.",
		"You can't focus.",
		"You feel slow.",
		"You feel sluggish.",
		"You feel dizzy.",
		"You feel lightheaded.",
		"You feel nauseous.",
		"You feel terrible.",
		"You feel horrific.",
		"Every muscle in your body burns.",
		"A searing pain shoots through your chest.")
		to_chat(owner, span_warning(suffering_message))
