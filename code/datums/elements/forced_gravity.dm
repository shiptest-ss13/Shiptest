/datum/element/forced_gravity
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2
	var/gravity
	var/ignore_space

/datum/element/forced_gravity/Attach(datum/target, gravity=1, ignore_space=FALSE)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	var/our_ref = REF(src)
	if(HAS_TRAIT_FROM(target, TRAIT_FORCED_GRAVITY, our_ref))
		return

	src.gravity = gravity
	src.ignore_space = ignore_space

	RegisterSignal(target, COMSIG_ATOM_HAS_GRAVITY, PROC_REF(gravity_check))
	if(isturf(target))
		RegisterSignal(target, COMSIG_TURF_HAS_GRAVITY, PROC_REF(turf_gravity_check))

	ADD_TRAIT(target, TRAIT_FORCED_GRAVITY, our_ref)

/datum/element/forced_gravity/Detach(datum/source, force)
	. = ..()
	var/static/list/signals_b_gone = list(COMSIG_ATOM_HAS_GRAVITY, COMSIG_TURF_HAS_GRAVITY)
	UnregisterSignal(source, signals_b_gone)
	REMOVE_TRAIT(source, TRAIT_FORCED_GRAVITY, REF(src))

/datum/element/forced_gravity/proc/gravity_check(datum/source, turf/location, list/gravs)
	SIGNAL_HANDLER

	if(!ignore_space && isspaceturf(location))
		return
	gravs += gravity

/datum/element/forced_gravity/proc/turf_gravity_check(datum/source, atom/checker, list/gravs)
	SIGNAL_HANDLER

	return gravity_check(null, source, gravs)
