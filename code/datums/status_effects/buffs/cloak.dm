/datum/status_effect/concealed/cloaked
	concealment_power = 25
	alert_type = /atom/movable/screen/alert/status_effect/cloaked
	tick_interval = 3
	var/min_alpha = 50

/datum/status_effect/concealed/cloaked/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	owner.add_filter("cloak_distort", 1, displacement_map_filter(icon=icon('icons/effects/effects.dmi', "static_base"), size = 0))
	animate(owner.get_filter("cloak_distort"), 20, size = 4)

/datum/status_effect/concealed/cloaked/tick()
	owner.alpha = max(min_alpha, owner.alpha - 25)
	if(prob(20))
		if(!owner.get_filter("cloak_distort"))
			owner.add_filter("cloak_distort", 1, displacement_map_filter(icon=icon('icons/effects/effects.dmi', "static_base"), size = 0))
		animate(owner.get_filter("cloak_distort"), 5, size = rand(-4,4))

/datum/status_effect/concealed/cloaked/proc/on_move()
	SIGNAL_HANDLER

	owner.alpha = min(255, owner.alpha + 15)

/datum/status_effect/concealed/cloaked/on_remove()
	if(..())
		return
	owner.alpha = 255
	animate(owner.get_filter("cloak_distort"), 20, size = 0)
	addtimer(CALLBACK(owner, PROC_REF(remove_filter), "cloak_distort"), 20)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

/atom/movable/screen/alert/status_effect/cloaked
	name = "Cloaked"
	desc = "You're currently cloaking from sight, and harder to hit with projectiles."
	icon_state = "concealed"

/datum/status_effect/concealed/cloaked/static_cloak
	concealment_power = 90
	alert_type = /atom/movable/screen/alert/status_effect/static_cloak
	tick_interval = 4
	min_alpha = 25
	var/mutable_appearance/static_overlay

/datum/status_effect/concealed/cloaked/static_cloak/on_apply()
	static_overlay = mutable_appearance('icons/effects/effects.dmi', "static", layer = ABOVE_MOB_LAYER)
	owner.add_overlay(static_overlay)
	. = ..()

/datum/status_effect/concealed/cloaked/static_cloak/tick()
	. = ..()
	if(prob(5))
		to_chat(owner, span_mind_control(pick(GLOB.tvstatic_sayings)))

/datum/status_effect/concealed/cloaked/static_cloak/on_remove()
	. = ..()
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/atom, cut_overlay), static_overlay), 20)

/atom/movable/screen/alert/status_effect/static_cloak
	name = "Static Cloak"
	desc = "You're concealed by the protective wrap of static. You are much harder to hit with projectiles."
	icon_state = "concealed"
