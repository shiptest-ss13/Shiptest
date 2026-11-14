/**
 * Dazzled.
 * Used when we need to blind someone for entering an area, but only temporarily.
 */
/datum/status_effect/dazzled
	id = "dazzled"
	status_type = STATUS_EFFECT_REFRESH
	duration = 5 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/dazzled

/datum/status_effect/dazzled/on_creation(mob/living/new_owner, set_duration)
	if(isnum(set_duration))
		duration = set_duration
	. = ..()

/atom/movable/screen/alert/status_effect/dazzled
	name = "Dazzled"
	desc = "You're dazzled from the bright light! The blinding effects will wear off after a bit once you get used to it, making you immune to further dazzling until your eyes return to normal."
	icon = 'icons/obj/machines/searchlight.dmi'
	icon_state = "searchlight_on"
