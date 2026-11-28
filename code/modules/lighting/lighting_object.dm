/atom/movable/lighting_object
	name          = ""

	anchored      = TRUE

	icon             = LIGHTING_ICON
	icon_state       = "transparent"
	color            = null // we used to set color in initialize; now we wait until update.
	plane            = LIGHTING_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer            = LIGHTING_LAYER
	invisibility     = INVISIBILITY_LIGHTING
	vis_flags = VIS_HIDE

	var/needs_update = FALSE
	var/turf/myturf

/atom/movable/lighting_object/Initialize(mapload)
	. = ..()
	verbs.Cut()
	// There used to be code here to set the color to LIGHTING_BASE_MATRIX, but it was redundant
	// and it ended up increasing init times slightly. It didn't matter one bit, since our starting
	// icon_state is "transparent", which is pure white even with null color.

	myturf = loc
	if (myturf.lighting_object)
		qdel(myturf.lighting_object, force = TRUE)
	myturf.lighting_object = src
	var/area/turf_area = myturf.loc
	// Base lit turfs stay visible even where no light source reaches.
	myturf.luminosity = turf_area.area_has_base_lighting ? 1 : 0

	needs_update = TRUE
	SSlighting.objects_queue += src

/atom/movable/lighting_object/Destroy(force)
	if (force)
		SSlighting.objects_queue -= src
		if (loc != myturf && loc)
			var/turf/oldturf = get_turf(myturf)
			var/turf/newturf = get_turf(loc)
			stack_trace("A lighting object was qdeleted with a different loc then it is suppose to have ([COORD(oldturf)] -> [COORD(newturf)])")
		if (isturf(myturf))
			myturf.lighting_object = null
			myturf.luminosity = 1
		myturf = null

		return ..()

	else
		return QDEL_HINT_LETMELIVE

/atom/movable/lighting_object/proc/update()
	if (loc != myturf)
		if (loc)
			var/turf/oldturf = get_turf(myturf)
			var/turf/newturf = get_turf(loc)
			warning("A lighting object realised it's loc had changed in update() ([myturf]\[[myturf ? myturf.type : "null"]]([COORD(oldturf)]) -> [loc]\[[ loc ? loc.type : "null"]]([COORD(newturf)]))!")

		qdel(src, TRUE)
		return

	// To the future coder who sees this and thinks
	// "Why didn't he just use a loop?"
	// Well my man, it's because the loop performed like shit.
	// And there's no way to improve it because
	// without a loop you can make the list all at once which is the fastest you're gonna get.
	// Oh it's also shorter line wise.
	// Including with these comments.

	// See LIGHTING_CORNER_DIAGONAL in lighting_corner.dm for why these values are what they are.
	var/static/datum/lighting_corner/dummy/dummy_lighting_corner = new

	var/datum/lighting_corner/red_corner = myturf.lighting_corner_SW || dummy_lighting_corner
	var/datum/lighting_corner/green_corner = myturf.lighting_corner_SE || dummy_lighting_corner
	var/datum/lighting_corner/blue_corner = myturf.lighting_corner_NW || dummy_lighting_corner
	var/datum/lighting_corner/alpha_corner = myturf.lighting_corner_NE || dummy_lighting_corner

	var/max = max(red_corner.largest_color_luminosity, green_corner.largest_color_luminosity, blue_corner.largest_color_luminosity, alpha_corner.largest_color_luminosity)

	#if LIGHTING_SOFT_THRESHOLD != 0
	var/set_luminosity = max > LIGHTING_SOFT_THRESHOLD
	#else
	// Because of floating points™?, it won't even be a flat 0.
	// This number is mostly arbitrary.
	var/set_luminosity = max > 1e-6
	#endif

	var/area/turf_area = myturf.loc
	var/new_layer = turf_area.base_lighting_is_daylight ? LIGHTING_ABOVE_BASE_LAYER : LIGHTING_LAYER
	if(layer != new_layer)
		layer = new_layer

	if(turf_area.base_lighting_is_daylight)
		icon_state = null
		// Opaque tiles show daylight, since light never reaches their own corners.
		var/opaque = IS_OPAQUE_TURF(myturf)
		color = daylight_color(turf_area.base_lighting_channels, red_corner, green_corner, blue_corner, alpha_corner, opaque)
	else if(!set_luminosity)
		icon_state = "dark"
		color = null
	else
		icon_state = null
		color = list(
			red_corner.cache_r, red_corner.cache_g, red_corner.cache_b, 00,
			green_corner.cache_r, green_corner.cache_g, green_corner.cache_b, 00,
			blue_corner.cache_r, blue_corner.cache_g, blue_corner.cache_b, 00,
			alpha_corner.cache_r, alpha_corner.cache_g, alpha_corner.cache_b, 00,
			00, 00, 00, 01
		)

	luminosity = set_luminosity

/atom/movable/lighting_object/proc/daylight_color(list/daylight_channels, datum/lighting_corner/red_corner, datum/lighting_corner/green_corner, datum/lighting_corner/blue_corner, datum/lighting_corner/alpha_corner, opaque)
	return daylight_corner(daylight_channels, red_corner, opaque) \
		+ daylight_corner(daylight_channels, green_corner, opaque) \
		+ daylight_corner(daylight_channels, blue_corner, opaque) \
		+ daylight_corner(daylight_channels, alpha_corner, opaque) \
		+ list(00, 00, 00, 01)

/atom/movable/lighting_object/proc/daylight_corner(list/daylight_channels, datum/lighting_corner/corner, opaque)
	if(!opaque && corner.largest_color_luminosity && corner.touches_exact_daylight())
		return list(corner.cache_r, corner.cache_g, corner.cache_b, 00)
	return list(max(daylight_channels[1], corner.cache_r), max(daylight_channels[2], corner.cache_g), max(daylight_channels[3], corner.cache_b), 00)

// Variety of overrides so the overlays don't get affected by weird things.

/atom/movable/lighting_object/ex_act(severity)
	return 0

/atom/movable/lighting_object/singularity_act()
	return

/atom/movable/lighting_object/singularity_pull()
	return

/atom/movable/lighting_object/wash(clean_types)
	return

// Override here to prevent things accidentally moving around overlays.
/atom/movable/lighting_object/forceMove(atom/destination, no_tp=FALSE, harderforce = FALSE)
	if(harderforce)
		. = ..()
