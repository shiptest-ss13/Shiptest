/datum/component/overmap/damageable
	var/max_health
	var/health

/datum/component/overmap/damageable/Initialize(_max_health, _health)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return

	max_health = _max_health
	health = _health
