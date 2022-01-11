/datum/component/overmap/orbit_line
	overmap_ui_comp_id = OVER_COMP_ID_ORBIT
	// list of orbit_data datums corresponding to individual orbit lines
	var/list/datum/orbit_data/orbits

/datum/component/overmap/orbit_line/Initialize(_orbits)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	orbits = _orbits

/datum/component/overmap/orbit_line/get_ui_data(datum/D, list/data)
	. = ..()
	var/list/orbit_list = list()
	for(var/O in orbits)
		var/datum/orbit_data/orbit = O
		// gotta double wrap the list for it add correctly
		orbit_list += list(list(
			semi_major = orbit.semi_major,
			eccentricity = orbit.eccentricity,
			counterclockwise = orbit.counterclockwise,
			arg_of_periapsis = orbit.arg_of_periapsis
		))
	data[overmap_ui_comp_id] = list(
		orbits = orbit_list
	)


// DEBUG FIX -- let the physics component proc take this as an arg. move this out of this file
/datum/orbit_data
	/// Length of the orbit's semi-major axis.
	var/semi_major
	/// Eccentricity of the orbit.
	var/eccentricity
	/// Whether the orbit is clockwise or counterclockwise. Affects periapsis location.
	var/counterclockwise
	/// The angular position of the orbit's periapsis, in degrees, in the direction of the orbit.
	var/arg_of_periapsis

/datum/orbit_data/New(_semi_major, _eccentricity, _counterclockwise, _arg_of_periapsis)
	semi_major = _semi_major
	eccentricity = _eccentricity
	counterclockwise = _counterclockwise
	arg_of_periapsis = _arg_of_periapsis
