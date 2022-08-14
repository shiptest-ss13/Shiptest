/datum/component/interdiction
	var/datum/overmap/ship/controlled/aggressor
	var/datum/beam/tether

/datum/component/interdiction/Initialize(aggressor)
	. = ..()
	src.aggressor = aggressor

/datum/component/interdiction/RegisterWithParent()
	var/datum/overmap/parent = src.parent
	tether = aggressor.token.Beam(parent.token)

/datum/component/interdiction/UnregisterFromParent()
	qdel(tether)
