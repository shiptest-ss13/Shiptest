/// Anesthetics, for use in surgery - to stop pain.
/datum/status_effect/grouped/anesthetic
	id = "anesthetics"
	alert_type = /atom/movable/screen/alert/status_effect/anesthetics

/datum/status_effect/grouped/anesthetic/on_creation(mob/living/new_owner, source)
	if(!istype(get_area(new_owner), /area/ship/medical))
		// if we're NOT in medical, give no alert. N2O floods or whatever.
		alert_type = null

	return ..()

/datum/status_effect/grouped/anesthetic/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_ON_ANESTHETIC, id)

/datum/status_effect/grouped/anesthetic/get_examine_text()
	return span_notice("They're out cold")

/datum/status_effect/grouped/anesthetic/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_ON_ANESTHETIC, id)

/atom/movable/screen/alert/status_effect/anesthetics
	name = "Anesthetic"
	desc = "Everything's woozy... The world goes dark... You're on anesthetics. \
		Good luck in surgery! If it's actually surgery, that is."
	icon_state = "paralysis"
