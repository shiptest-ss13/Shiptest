/// Anesthetics, for use in surgery - to stop pain.
/datum/status_effect/grouped/anesthetic
	id = "anesthetics"
	alert_type = /atom/movable/screen/alert/status_effect/anesthetics
	examine_text = "They're out cold."

/datum/status_effect/grouped/anesthetic/on_creation(mob/living/new_owner, source)
	if(!istype(get_area(new_owner), /area/medical))
		// if we're NOT in medical, give no alert. N2O floods or whatever.
		alert_type = null

	return ..()

/datum/status_effect/grouped/anesthetic/on_apply()
	. = ..()
	examine_text = span_notice("[owner.p_theyre(TRUE)] out cold.")
	ADD_TRAIT(owner, TRAIT_ON_ANESTHETIC, id)

/datum/status_effect/grouped/anesthetic/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_ON_ANESTHETIC, id)

/atom/movable/screen/alert/status_effect/anesthetics
	name = "Anesthetic"
	desc = "Everything's woozy... The world goes dark... You're on anesthetics. \
		Good luck in surgery! If it's actually surgery, that is."
	icon_state = "paralysis"
