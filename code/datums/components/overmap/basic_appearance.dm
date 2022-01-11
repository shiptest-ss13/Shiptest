
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
	data[overmap_ui_comp_id] = list(
		radius = radius,
		color = color
	)

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
	data[overmap_ui_comp_id] = list(
		width = width,
		height = height,
		color = color
	)
