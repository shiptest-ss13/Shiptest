datum/status_effect/metab_frozen
	id = "metab_frozen"
	duration = 5 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null

/datum/status_effect/metab_frozen/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_NOMETABOLISM, "[STATUS_EFFECT_TRAIT]_[id]")

/datum/status_effect/metab_frozen/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_NOMETABOLISM, "[STATUS_EFFECT_TRAIT]_[id]")
