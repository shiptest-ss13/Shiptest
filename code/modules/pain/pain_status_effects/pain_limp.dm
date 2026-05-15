/// Limping from extreme pain in the legs.
/datum/status_effect/limp/pain
	id = "limp_pain"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/limp/pain
	examine_text = "They're limping with every move."

/datum/status_effect/limp/pain/on_apply()
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/human/owner_human = owner
	if(!istype(owner_human) || !owner_human.pain_controller)
		return FALSE

	RegisterSignal(owner, list(COMSIG_CARBON_PAIN_GAINED, COMSIG_CARBON_PAIN_LOST), .proc/update_limp)
	examine_text = span_warning("[owner.p_theyre(TRUE)] limping with every move.")

/datum/status_effect/limp/pain/on_remove()
	. = ..()
	UnregisterSignal(owner, list(COMSIG_CARBON_PAIN_GAINED, COMSIG_CARBON_PAIN_LOST))
	to_chat(owner, span_green("Your pained limp stops!"))

/datum/status_effect/limp/pain/update_limp()
	var/mob/living/carbon/human/limping_human = owner
	if(!istype(limping_human) || !limping_human.pain_controller)
		qdel(src)
		return

	left = limping_human.pain_controller.body_zones[BODY_ZONE_L_LEG]
	right = limping_human.pain_controller.body_zones[BODY_ZONE_R_LEG]

	if(!left && !right)
		qdel(src)
		return

	slowdown_left = 0
	slowdown_right = 0

	if(left?.get_modified_pain() >= 30)
		slowdown_left = left.get_modified_pain() / 10

	if(right?.get_modified_pain() >= 30)
		slowdown_right = right.get_modified_pain() / 10

	// this handles losing your leg with the limp and the other one being in good shape as well
	if(slowdown_left < 3 && slowdown_right < 3)
		qdel(src)

/atom/movable/screen/alert/status_effect/limp/pain
	name = "Pained Limping"
	desc = "The pain in your legs is unbearable, forcing you to limp!"
