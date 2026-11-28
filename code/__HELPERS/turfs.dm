/*

Gets the turf this atom's *ICON* appears to inhabit
It takes into account:
 * Pixel_x/y
 * Matrix x/y

NOTE: if your atom has non-standard bounds then this proc
will handle it, but:
 * if the bounds are even, then there are an even amount of "middle" turfs, the one to the EAST, NORTH, or BOTH is picked
(this may seem bad, but you're atleast as close to the center of the atom as possible, better than byond's default loc being all the way off)
 * if the bounds are odd, the true middle turf of the atom is returned

*/

/proc/get_turf_pixel(atom/checked_atom)
	if(!istype(checked_atom))
		return

	var/turf/atom_turf = get_turf(checked_atom) //use checked_atom's turfs, as it's coords are the same as checked_atom's AND checked_atom's coords are lost if it is inside another atom
	if(!atom_turf)
		return null

	var/list/offsets = get_visual_offset(checked_atom)
	return pixel_offset_turf(atom_turf, offsets)

/**
 * Returns how visually "off" the atom is from its source turf as a list of x, y (in pixel steps)
 * it takes into account:
 * Pixel_x/y
 * Matrix x/y
 * Icon width/height
**/
/proc/get_visual_offset(atom/checked_atom)
	//Find checked_atom's matrix so we can use its X/Y pixel shifts
	var/matrix/atom_matrix = checked_atom.transform

	var/pixel_x_offset = checked_atom.pixel_x + checked_atom.pixel_w + atom_matrix.c
	var/pixel_y_offset = checked_atom.pixel_y + checked_atom.pixel_z + atom_matrix.f

	//Irregular objects
	var/list/icon_dimensions = get_icon_dimensions(checked_atom.icon)
	var/checked_atom_icon_height = icon_dimensions["height"]
	var/checked_atom_icon_width = icon_dimensions["width"]
	if(checked_atom_icon_height != ICON_SIZE_Y || checked_atom_icon_width != ICON_SIZE_X)
		pixel_x_offset += ((checked_atom_icon_width / ICON_SIZE_X) - 1) * (ICON_SIZE_X * 0.5)
		pixel_y_offset += ((checked_atom_icon_height / ICON_SIZE_Y) - 1) * (ICON_SIZE_Y * 0.5)

	return list(pixel_x_offset, pixel_y_offset)

/**
 * Takes a turf, and a list of x and y pixel offsets and returns the turf that the offset position best lands in
**/
/proc/pixel_offset_turf(turf/offset_from, list/offsets)
	//DY and DX
	var/rough_x = round(round(offsets[1], ICON_SIZE_X) / ICON_SIZE_X)
	var/rough_y = round(round(offsets[2], ICON_SIZE_Y) / ICON_SIZE_Y)

	var/final_x = clamp(offset_from.x + rough_x, 1, world.maxx)
	var/final_y = clamp(offset_from.y + rough_y, 1, world.maxy)

	if(final_x || final_y)
		return locate(final_x, final_y, offset_from.z)
	return offset_from
