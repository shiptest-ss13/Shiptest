
/proc/Get_Angle(atom/movable/start,atom/movable/end)//For beams.
	if(!start || !end)
		return 0
	var/dy
	var/dx
	dy=(32*end.y+end.pixel_y)-(32*start.y+start.pixel_y)
	dx=(32*end.x+end.pixel_x)-(32*start.x+start.pixel_x)
	if(!dy)
		return (dx>=0)?90:270
	.=arctan(dx/dy)
	if(dy<0)
		.+=180
	else if(dx<0)
		.+=360

////Tile coordinates (x, y) to absolute coordinates (in number of pixels). Center of a tile is generally assumed to be (16,16), but can be offset.
#define ABS_COOR(c) (((c - 1) * 32) + 16)
#define ABS_COOR_OFFSET(c, o) (((c - 1) * 32) + o)

/proc/get_angle_with_scatter(atom/start, atom/end, scatter, x_offset = 16, y_offset = 16)
	var/end_apx
	var/end_apy
	if(isliving(end)) //Center mass.
		end_apx = ABS_COOR(end.x)
		end_apy = ABS_COOR(end.y)
	else //Exact pixel.
		end_apx = ABS_COOR_OFFSET(end.x, x_offset)
		end_apy = ABS_COOR_OFFSET(end.y, y_offset)
	scatter = ((rand(0, min(scatter, 45))) * (prob(50) ? 1 : -1)) //Up to 45 degrees deviation to either side.
	. = round((90 - ATAN2(end_apx - ABS_COOR(start.x), end_apy - ABS_COOR(start.y))), 1) + scatter
	if(. < 0)
		. += 360
	else if(. >= 360)
		. -= 360

/proc/Get_Pixel_Angle(y, x)//for getting the angle when animating something's pixel_x and pixel_y
	if(!y)
		return (x>=0)?90:270
	.=arctan(x/y)
	if(y<0)
		.+=180
	else if(x<0)
		.+=360

///Returns one of the 8 directions based on an angle
/proc/angle_to_dir(angle)
	switch(angle)
		if(338 to 360, 0 to 22)
			return NORTH
		if(23 to 67)
			return NORTHEAST
		if(68 to 112)
			return EAST
		if(113 to 157)
			return SOUTHEAST
		if(158 to 202)
			return SOUTH
		if(203 to 247)
			return SOUTHWEST
		if(248 to 292)
			return WEST
		if(293 to 337)
			return NORTHWEST

///Returns one of the 4 cardinal directions based on an angle
/proc/angle_to_cardinal_dir(angle)
	switch(angle)
		if(316 to 360, 0 to 45)
			return NORTH
		if(46 to 135)
			return EAST
		if(136 to 225)
			return SOUTH
		if(226 to 315)
			return WEST
