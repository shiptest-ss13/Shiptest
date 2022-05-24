/// Some ruins still use assets that came from Hilbert's Hotel.
/turf/closed/indestructible/hotelwall
	name = "hotel wall"
	desc = "A wall designed to protect the security of the hotel's guests."
	icon_state = "hotelwall"
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_HOTEL_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_HOTEL_WALLS)
	explosion_block = INFINITY

/turf/open/indestructible/hotelwood
	desc = "Stylish dark wood with extra reinforcement. Secured firmly to the floor to prevent tampering."
	icon_state = "wood"
	footstep = FOOTSTEP_WOOD
	tiled_dirt = FALSE

/turf/open/indestructible/hoteltile
	desc = "Smooth tile with extra reinforcement. Secured firmly to the floor to prevent tampering."
	icon_state = "showroomfloor"
	footstep = FOOTSTEP_FLOOR
	tiled_dirt = FALSE
