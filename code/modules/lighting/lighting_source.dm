/// Cached global list of generated lighting sheets. See: datum/light_source/proc/get_sheet()
GLOBAL_LIST_EMPTY(lighting_sheets)

// This is where the fun begins.
// These are the main datums that emit light.

/datum/light_source
	///The atom we're emitting light from (for example a mob if we're from a flashlight that's being held).
	var/atom/top_atom
	///The atom that we belong to.
	var/atom/source_atom

	///The turf under the source atom.
	var/turf/source_turf
	/// How much to x shift our light by when displaying it
	var/offset_x = 0
	/// How much to y shift our light by when displaying it
	var/offset_y = 0
	/// How much larger our light sheet should be, based off offset_x and y
	/// We clamp to at least 1, so if offset_x is 0.1, then this'll be 1
	var/visual_offset

	///Intensity of the emitter light.
	var/light_power
	/// The range of the emitted light.
	var/light_range
	/// The colour of the light, string, decomposed by parse_light_color()
	var/light_color

	// Variables for keeping track of the colour.
	var/lum_r
	var/lum_g
	var/lum_b

	// The lumcount values used to apply the light.
	var/tmp/applied_lum_r
	var/tmp/applied_lum_g
	var/tmp/applied_lum_b

	/// List used to store how much we're affecting corners.
	var/list/datum/lighting_corner/effect_str

	/// Whether we have applied our light yet or not.
	var/applied = FALSE
	/// whether we are to be added to SSlighting's sources_queue list for an update
	var/needs_update = LIGHTING_NO_UPDATE


/datum/light_source/New(atom/owner, atom/top)
	source_atom = owner // Set our new owner.
	LAZYADD(source_atom.light_sources, src)
	top_atom = top
	if (top_atom != source_atom)
		LAZYADD(top_atom.light_sources, src)

	source_turf = top_atom

	light_power = source_atom.light_power
	light_range = source_atom.light_range
	light_color = source_atom.light_color

	PARSE_LIGHT_COLOR(src)

	update()

/datum/light_source/Destroy(force)
	remove_lum()
	if (source_atom)
		LAZYREMOVE(source_atom.light_sources, src)

	if (top_atom)
		LAZYREMOVE(top_atom.light_sources, src)

	if (needs_update)
		SSlighting.sources_queue -= src

	top_atom = null
	source_atom = null
	source_turf = null

	return ..()

// Yes this doesn't align correctly on anything other than 4 width tabs.
// If you want it to go switch everybody to elastic tab stops.
// Actually that'd be great if you could!
#define EFFECT_UPDATE(level)                  \
	if (needs_update == LIGHTING_NO_UPDATE) { \
		SSlighting.sources_queue += src;      \
	}                                         \
	if (needs_update < level) {               \
		needs_update = level;                 \
	}

/// This proc will cause the light source to update the top atom, and add itself to the update queue.
/datum/light_source/proc/update(atom/new_top_atom)
	// This top atom is different.
	if (new_top_atom && new_top_atom != top_atom)
		if(top_atom != source_atom && top_atom.light_sources) // Remove ourselves from the light sources of that top atom.
			LAZYREMOVE(top_atom.light_sources, src)

		top_atom = new_top_atom

		if (top_atom != source_atom)
			LAZYADD(top_atom.light_sources, src) // Add ourselves to the light sources of our new top atom.

	EFFECT_UPDATE(LIGHTING_CHECK_UPDATE)

// Will force an update without checking if it's actually needed.
/datum/light_source/proc/force_update()
	EFFECT_UPDATE(LIGHTING_FORCE_UPDATE)

// Will cause the light source to recalculate turfs that were removed or added to visibility only.
/datum/light_source/proc/vis_update()
	EFFECT_UPDATE(LIGHTING_VIS_UPDATE)

// This exists so we can cache the vars used in this macro, and save MASSIVE time :)
// Most of this is saving off datum var accesses, tho some of it does actually cache computation
// You will NEED to call this before you call APPLY_CORNER
#define SETUP_CORNERS_CACHE(lighting_source)                                                               \
	var/_turf_x = lighting_source.source_turf.x;                                                            \
	var/_turf_y = lighting_source.source_turf.y;                                                            \
	var/list/_sheet = lighting_source.get_sheet();                                                         \
	var/_range_offset = CEILING(lighting_source.light_range, 1) + 0.5 + 1 + lighting_source.visual_offset; \
	var/_light_power = lighting_source.light_power;                                                        \
	var/_applied_lum_r = lighting_source.applied_lum_r;                                                    \
	var/_applied_lum_g = lighting_source.applied_lum_g;                                                    \
	var/_applied_lum_b = lighting_source.applied_lum_b;                                                    \
	var/_lum_r = lighting_source.lum_r;                                                                    \
	var/_lum_g = lighting_source.lum_g;                                                                    \
	var/_lum_b = lighting_source.lum_b;

#define SETUP_CORNERS_REMOVAL_CACHE(lighting_source)    \
	var/_applied_lum_r = lighting_source.applied_lum_r; \
	var/_applied_lum_g = lighting_source.applied_lum_g; \
	var/_applied_lum_b = lighting_source.applied_lum_b;

// Read out of our sources light sheet, a map of offsets -> the luminosity to use
#define LUM_FALLOFF(C) _sheet[C.x - _turf_x + _range_offset][C.y - _turf_y + _range_offset]

// Macro that applies light to a new corner.
// It is a macro in the interest of speed, yet not having to copy paste it.
// If you're wondering what's with the backslashes, the backslashes cause BYOND to not automatically end the line.
// As such this all gets counted as a single line.
// The braces and semicolons are there to be able to do this on a single line.
#define APPLY_CORNER(C)                          \
	. = LUM_FALLOFF(C);                          \
	. *= _light_power;                           \
	var/OLD = effect_str[C];                     \
	C.update_lumcount                            \
	(                                            \
		(. * _lum_r) - (OLD * _applied_lum_r),   \
		(. * _lum_g) - (OLD * _applied_lum_g),   \
		(. * _lum_b) - (OLD * _applied_lum_b)    \
	);

#define REMOVE_CORNER(C)                         \
	. = -effect_str[C];                          \
	C.update_lumcount                            \
	(                                            \
		. * _applied_lum_r,                      \
		. * _applied_lum_g,                      \
		. * _applied_lum_b                       \
	);

/// Returns a list of lists, indexed with ints, that can be read to get the lighting multiplier at any one point
/datum/light_source/proc/get_sheet()
	var/range = max(1, light_range)
	var/key = "[range]-[visual_offset]-[offset_x]-[offset_y]"
	var/list/hand_back = GLOB.lighting_sheets[key]
	if(!hand_back)
		hand_back = generate_sheet(range, visual_offset, offset_x, offset_y)
		GLOB.lighting_sheets[key] = hand_back
	return hand_back

/// Returns a list of lists that encodes the light falloff of our source
/// Takes anything that impacts our generation as input
/// This function should be "pure", no side effects or reads from the source object
/datum/light_source/proc/generate_sheet(range, visual_offset, x_offset, y_offset)
	var/list/encode = list()
	// How far away the turfs we get are, and how many there are are often not the same calculation
	// So we need to include the visual offset, so we can ensure our sheet is large enough to accept all the distance differences
	var/bound_range = ceil(range) + visual_offset

	// Corners are placed at 0.5 offsets
	// We need our coords to reflect that (though x_offsets that change the basis for how things are calculated are fine too)
	for(var/corner_x in (-(bound_range) + x_offset - 0.5) to (bound_range + x_offset + 0.5))
		var/list/row = list()
		for(var/corner_y in (-(bound_range) + y_offset - 0.5) to (bound_range + y_offset + 0.5))
			row += falloff_at_coord(corner_x, corner_y, range)
		encode += list(row)
	return encode

/// Takes x and y offsets from the source as input, alongside our source's range
/// Returns a value between 0 and 1, 0 being dark on that tile, 1 being fully lit
/datum/light_source/proc/falloff_at_coord(corner_x, corner_y, range)
	var/range_divisor = max(1, range)
	return 1 - CLAMP01(sqrt(corner_x ** 2 + corner_y ** 2 + LIGHTING_HEIGHT) / range_divisor)

/// This is the define used to calculate falloff.
/datum/light_source/proc/remove_lum()
	SETUP_CORNERS_REMOVAL_CACHE(src)
	applied = FALSE
	for (var/datum/lighting_corner/corner as anything in effect_str)
		REMOVE_CORNER(corner)
		LAZYREMOVE(corner.affecting, src)

	effect_str = null

/datum/light_source/proc/recalc_corner(datum/lighting_corner/corner)
	SETUP_CORNERS_CACHE(src)
	LAZYINITLIST(effect_str)
	if (effect_str[corner]) // Already have one.
		REMOVE_CORNER(corner)
		effect_str[corner] = 0

	APPLY_CORNER(corner)
	effect_str[corner] = .


// Keep in mind. Lighting corners accept the bottom left (northwest) set of cords to them as input
#define GENERATE_MISSING_CORNERS(gen_for)                                                                 \
	if (!gen_for.lighting_corner_NE) {                                                                    \
		gen_for.lighting_corner_NE = new /datum/lighting_corner(gen_for.x, gen_for.y, gen_for.z);         \
	}                                                                                                     \
	if (!gen_for.lighting_corner_SE) {                                                                    \
		gen_for.lighting_corner_SE = new /datum/lighting_corner(gen_for.x, gen_for.y - 1, gen_for.z);     \
	}                                                                                                     \
	if (!gen_for.lighting_corner_SW) {                                                                    \
		gen_for.lighting_corner_SW = new /datum/lighting_corner(gen_for.x - 1, gen_for.y - 1, gen_for.z); \
	}                                                                                                     \
	if (!gen_for.lighting_corner_NW) {                                                                    \
		gen_for.lighting_corner_NW = new /datum/lighting_corner(gen_for.x - 1, gen_for.y, gen_for.z);     \
	}                                                                                                     \
	gen_for.lighting_corners_initialised = TRUE;

#define INSERT_CORNERS(insert_into, draw_from)             \
	if (!draw_from.lighting_corners_initialised) {         \
		GENERATE_MISSING_CORNERS(draw_from);               \
	}                                                      \
	insert_into[draw_from.lighting_corner_NE] = 0;         \
	insert_into[draw_from.lighting_corner_SE] = 0;         \
	insert_into[draw_from.lighting_corner_SW] = 0;         \
	insert_into[draw_from.lighting_corner_NW] = 0;

/// Refreshes our lighting source to match its parent atom
/// Returns TRUE if an update is needed, FALSE otherwise
/datum/light_source/proc/refresh_values()
	var/update = FALSE
	var/atom/source_atom = src.source_atom
	var/turf/old_source_turf = source_turf

	if (QDELETED(source_atom))
		qdel(src)
		return FALSE

	if (source_atom.light_power != light_power)
		light_power = source_atom.light_power
		update = TRUE

	if (source_atom.light_range != light_range)
		light_range = source_atom.light_range
		update = TRUE

	if (!top_atom)
		top_atom = source_atom
		update = TRUE

	if (!light_range || !light_power)
		qdel(src)
		return FALSE

	var/atom/visual_source = source_atom
	if(isturf(top_atom))
		visual_source = source_atom
		if(source_turf != top_atom)
			source_turf = top_atom
			update = TRUE
	else
		visual_source = top_atom
		if(top_atom.loc != source_turf)
			source_turf = top_atom.loc
			update = TRUE

	if (!isturf(source_turf))
		if (applied)
			remove_lum()
		return FALSE

	if (light_range && light_power && !applied)
		update = TRUE

	if (source_atom.light_color != light_color)
		light_color = source_atom.light_color
		PARSE_LIGHT_COLOR(src)
		update = TRUE

	else if (applied_lum_r != lum_r || applied_lum_g != lum_g || applied_lum_b != lum_b)
		update = TRUE

	var/list/visual_offsets = calculate_light_offset(visual_source)
	if(visual_offsets[1] != offset_x || visual_offsets[2] != offset_y || source_turf != old_source_turf)
		offset_x = visual_offsets[1]
		offset_y = visual_offsets[2]
		visual_offset = max(ceil(abs(offset_x)), ceil(abs(offset_y)))
		update = TRUE

	// If we need to update, well, update
	if (update)
		needs_update = LIGHTING_CHECK_UPDATE
		applied = TRUE
		return TRUE

	// Otherwise, go off the needs_update var. If it requires an update provide one, otherwise we're kosher
	if (needs_update == LIGHTING_CHECK_UPDATE)
		return FALSE //nothing's changed
	return TRUE

/// Returns a list of lighting corners this source impacts
/datum/light_source/proc/impacted_corners()
	var/list/datum/lighting_corner/corners = list()
	if (!source_turf)
		return list()

	var/old_luminosity = source_turf.luminosity
	var/working_range = ceil(light_range + visual_offset)
	source_turf.luminosity = working_range
	for(var/turf/seen_turf in view(working_range, source_turf))
		if(IS_OPAQUE_TURF(seen_turf))
			continue
		INSERT_CORNERS(corners, seen_turf)
	source_turf.luminosity = old_luminosity
	return corners

/// Drops corners whose position is outside our light sheet, since reading them would crash the lighting subsystem
/datum/light_source/proc/remove_unreachable_corners(list/datum/lighting_corner/corners)
	var/list/sheet = get_sheet()
	var/range_offset = CEILING(light_range, 1) + 0.5 + 1 + visual_offset
	var/list/datum/lighting_corner/unreachable_corners
	for(var/datum/lighting_corner/corner as anything in corners)
		var/sheet_column = corner.x - source_turf.x + range_offset
		var/sheet_row = corner.y - source_turf.y + range_offset
		if(corner.z == source_turf.z && sheet_column >= 1 && sheet_column <= length(sheet) && sheet_row >= 1 && sheet_row <= length(sheet[sheet_column]))
			continue
		LAZYADD(unreachable_corners, corner)
	if(!unreachable_corners)
		return
	var/datum/lighting_corner/first_corner = unreachable_corners[1]
	var/list/holders = list()
	for(var/turf/nearby_turf as anything in RANGE_TURFS(ceil(light_range + visual_offset) + 1, source_turf))
		if(first_corner in list(nearby_turf.lighting_corner_NE, nearby_turf.lighting_corner_SE, nearby_turf.lighting_corner_SW, nearby_turf.lighting_corner_NW))
			holders += "[nearby_turf.x],[nearby_turf.y] [nearby_turf.type]"
	var/owned_by_masters = first_corner.master_NE?.lighting_corner_SW == first_corner || first_corner.master_SW?.lighting_corner_NE == first_corner
	stack_trace("Light at [source_turf.x],[source_turf.y],[source_turf.z] from [source_atom] ([source_atom?.type]) on [top_atom] ([top_atom?.type]), range [light_range], offset [offset_x],[offset_y], visual offset [visual_offset], got [length(unreachable_corners)] corner(s) outside its reach, first at [first_corner.x],[first_corner.y],[first_corner.z] (masters NE [first_corner.master_NE?.x],[first_corner.master_NE?.y] SW [first_corner.master_SW?.x],[first_corner.master_SW?.y], its masters still point at it: [owned_by_masters ? "yes" : "no"], held by nearby turfs: [length(holders) ? jointext(holders, "; ") : "none"])")
	corners -= unreachable_corners

/datum/light_source/proc/update_corners()
	if(!refresh_values())
		return

	var/list/datum/lighting_corner/corners = impacted_corners()
	remove_unreachable_corners(corners)
	SETUP_CORNERS_CACHE(src)
	var/had_effects = length(effect_str)
	var/list/datum/lighting_corner/new_corners = (corners - effect_str)
	LAZYINITLIST(effect_str)
	for (var/datum/lighting_corner/corner as anything in new_corners)
		APPLY_CORNER(corner)
		if (. != 0)
			LAZYADD(corner.affecting, src)
			effect_str[corner] = .

	// New corners are a subset of corners. so if they're both the same length, there are NO old corners!
	if (needs_update != LIGHTING_VIS_UPDATE && length(corners) != length(new_corners))
		for (var/datum/lighting_corner/corner as anything in corners - new_corners) // Existing corners
			APPLY_CORNER(corner)
			if (. != 0)
				effect_str[corner] = .
			else
				LAZYREMOVE(corner.affecting, src)
				effect_str -= corner

	if (had_effects)
		var/list/datum/lighting_corner/gone_corners = effect_str - corners
		for (var/datum/lighting_corner/corner as anything in gone_corners)
			REMOVE_CORNER(corner)
			LAZYREMOVE(corner.affecting, src)
		effect_str -= gone_corners

	applied_lum_r = lum_r
	applied_lum_g = lum_g
	applied_lum_b = lum_b

	UNSETEMPTY(effect_str)

#undef APPLY_CORNER
#undef EFFECT_UPDATE
#undef GENERATE_MISSING_CORNERS
#undef INSERT_CORNERS
#undef LUM_FALLOFF
#undef REMOVE_CORNER
#undef SETUP_CORNERS_CACHE
#undef SETUP_CORNERS_REMOVAL_CACHE
