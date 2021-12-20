
/// Data-holder overmap component for a basic circle sprite.
/datum/component/overmap/circle_vis
	overmap_ui_comp_id = OVER_COMP_ID_CIRCLE
	var/color
	var/radius

/datum/component/overmap/circle_vis/Initialize(_radius, _color)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	radius = _radius
	color = _color

/datum/component/overmap/circle_vis/get_ui_data(datum/C, list/data)
	. = ..()
	data[overmap_ui_comp_id]["radius"] = radius
	data[overmap_ui_comp_id]["color"] = color

/// Data-holder overmap component for a basic rectangle sprite.
/datum/component/overmap/rect_vis
	overmap_ui_comp_id = OVER_COMP_ID_RECT
	var/color
	var/width
	var/height

/datum/component/overmap/rect_vis/Initialize(_width, _height, _color)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	width = _width
	height = _height
	color = _color

/datum/component/overmap/rect_vis/get_ui_data(datum/C, list/data)
	. = ..()
	data[overmap_ui_comp_id]["width"] = width
	data[overmap_ui_comp_id]["height"] = height
	data[overmap_ui_comp_id]["color"] = color

/// Data-holder overmap component for orbit line visualization.
/datum/component/overmap/orbit_line
	overmap_ui_comp_id = OVER_COMP_ID_ORBIT
	/// The length of the semi-major axis of the displayed orbit.
	var/semi_major
	/// The eccentricity of the displayed orbit.
	var/eccentricity
	/// Whether the displayed orbit is clockwise or counterclockwise.
	var/counterclockwise
	/// The argument of periapsis of the displayed orbit.
	var/arg_of_periapsis

/datum/component/overmap/orbit_line/Initialize(_semi_major, _eccentricity, _counterclockwise, _arg_of_periapsis)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	semi_major = _semi_major
	eccentricity = _eccentricity
	counterclockwise = _counterclockwise
	arg_of_periapsis = _arg_of_periapsis

/datum/component/overmap/orbit_line/get_ui_data(datum/D, list/data)
	. = ..()
	data[overmap_ui_comp_id]["semi_major"] = semi_major
	data[overmap_ui_comp_id]["eccentricity"] = eccentricity
	data[overmap_ui_comp_id]["counterclockwise"] = counterclockwise
	data[overmap_ui_comp_id]["arg_of_periapsis"] = arg_of_periapsis
