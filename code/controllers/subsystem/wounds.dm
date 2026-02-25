SUBSYSTEM_DEF(wounds)
	name = "Wounds"
	init_order = INIT_ORDER_WOUNDS
	flags = SS_NO_FIRE

	/// A "chronological" list of wound severities, starting at the least severe.
	var/static/list/severities_chronological = list(
		"[WOUND_SEVERITY_TRIVIAL]",
		"[WOUND_SEVERITY_MODERATE]",
		"[WOUND_SEVERITY_SEVERE]",
		"[WOUND_SEVERITY_CRITICAL]"
	)

	/// A assoc list of BIO_ define to EXTERIOR/INTERIOR defines.
	/// This is where the interior/exterior state of a given biostate is set.
	/// Note that not all biostates are guaranteed to be one of these - and in fact, many are not
	/// IMPORTANT NOTE: All keys are stored as text and must be converted via text2num
	var/static/list/bio_state_anatomy = list(
		"[BIO_WIRED]" = ANATOMY_EXTERIOR,
		"[BIO_METAL]" = ANATOMY_INTERIOR,
		"[BIO_FLESH]" = ANATOMY_EXTERIOR,
		"[BIO_BONE]" = ANATOMY_INTERIOR,
	)

	/// Associated list of wound types and their pregen data.
	var/list/datum/wound_pregen_data/pregen_data

	// A wound series "collection" is merely a way for us to track what is in what series, and what their types are.
	// Without this, we have no centralized way to determine what type is in what series outside of iterating over every pregen data.

	/// A branching assoc list of (series -> list(severity -> list(typepath -> weight))). Allows you to say "I want a generic slash wound",
	/// then "Of severity 2", and get a wound of that description - via get_corresponding_wound_type()
	/// Series: A generic wound_series, such as WOUND_SERIES_BONE_BLUNT_BASIC
	/// Severity: Any wounds held within this will be of this severity.
	/// Typepath, Weight: Merely a pairing of a given typepath to its weight, held for convenience in pickweight.
	var/list/series_collection

	/// A branching assoc list of (wounding_type -> list(wound_series)).
	/// Allows for determining of which wound series are caused by what.
	var/static/list/types_to_series = list(
		WOUND_BLUNT = list(
			WOUND_SERIES_BONE_BLUNT_BASIC,
			WOUND_SERIES_METAL_BUCKLING,
			WOUND_SERIES_FLESH_MUSCLE,
		),
		WOUND_SLASH = list(
			WOUND_SERIES_FLESH_SLASH_BLEED,
			WOUND_SERIES_WIRED_ELECTRICAL,
		),
		WOUND_BURN = list(
			WOUND_SERIES_FLESH_BURN_BASIC,
			WOUND_SERIES_METAL_HEAT_WARPING,
			WOUND_SERIES_WIRED_ELECTRICAL,
		),
		WOUND_PIERCE = list(
			WOUND_SERIES_FLESH_PUNCTURE_BLEED,
			WOUND_SERIES_WIRED_ELECTRICAL,
		),
	)

/datum/controller/subsystem/wounds/Initialize(timeofday)
	generate_wound_static_data()
	generate_wound_series_collection()
	return ..()

/// Constructs [all_wound_pregen_data] by iterating through a typecache of pregen data, ignoring abstract types, and instantiating the rest.
/datum/controller/subsystem/wounds/proc/generate_wound_static_data()
	var/list/datum/wound_pregen_data/all_pregen_data = list()

	for (var/datum/wound_pregen_data/iterated_path as anything in typecacheof(path = /datum/wound_pregen_data, ignore_root_path = TRUE))
		if (initial(iterated_path.abstract))
			continue

		if (!isnull(all_pregen_data[initial(iterated_path.wound_path_to_generate)]))
			stack_trace("pre-existing pregen data for [initial(iterated_path.wound_path_to_generate)] when [iterated_path] was being considered: [all_pregen_data[initial(iterated_path.wound_path_to_generate)]]. \
						this is definitely a bug, and is probably because one of the two pregen data have the wrong wound typepath defined. [iterated_path] will not be instantiated")

			continue

		var/datum/wound_pregen_data/new_data = new iterated_path
		LAZYSET(pregen_data, new_data.wound_path_to_generate, new_data)

// Series -> severity -> type -> weight
/// Generates [wound_series_collections] by iterating through all pregen_data. Refer to the mentioned list for documentation
/datum/controller/subsystem/wounds/proc/generate_wound_series_collection()
	for (var/datum/wound/wound_typepath as anything in typecacheof(/datum/wound, FALSE, TRUE))
		var/datum/wound_pregen_data/data = pregen_data[wound_typepath]
		if (!data)
			continue

		if (data.abstract)
			stack_trace("somehow, a abstract wound_pregen_data instance ([data.type]) was instantiated and made it to generate_wound_series_collection()! \
						i literally have no idea how! please fix this!")
			continue

		var/series = data.wound_series
		var/list/datum/wound/series_list = series_collection[series]
		if (isnull(series_list))
			series_collection[series] = list()
			series_list = series_collection[series]

		var/severity = "[(initial(wound_typepath.severity))]"
		var/list/datum/wound/severity_list = series_list[severity]
		if (isnull(severity_list))
			series_list[severity] = list()
			severity_list = series_list[severity]

		severity_list[wound_typepath] = data.weight

/**
 * Searches through all wounds for any of proper type, series, and biostate, and then returns a single one via pickweight.
 * Is able to discern between, say, a flesh slash wound, and a metallic slash wound, and will return the respective one for the provided limb.
 *
 * The severity_max and severity_pick_mode args mostly exist in case you want a wound in a series that may not have your ideal severity wound, as it lets you
 * essentially set a "fallback", where if your ideal wound doesnt exist, it'll still return something, trying to get closest to your ideal severity.
 *
 * Generally speaking, if you want a critical/severe/moderate wound, you should set severity_min to WOUND_SEVERITY_MODERATE, severity_max to your ideal wound,
 * and severity_pick_mode to WOUND_PICK_HIGHEST_SEVERITY - UNLESS you for some reason want the LOWEST severity, in which case you should set
 * severity_max to the highest wound you're willing to tolerate, and severity_pick_mode to WOUND_PICK_LOWEST_SEVERITY.
 *
 * Args:
 * * list/wounding_types: A list of wounding_types. Only wounds that accept these wound types will be considered.
 * * obj/item/bodypart/part: The limb we are considering. Extremely important for biostates.
 * * severity_min: The minimum wound severity we will search for.
 * * severity_max = severity_min: The maximum wound severity we will search for.
 * * severity_pick_mode = WOUND_PICK_HIGHEST_SEVERITY: The "pick mode" we will use when considering multiple wounds of acceptable severity. See the above defines.
 * * random_roll = TRUE: If this is considered a "random" consideration. If true, only wounds that can be randomly generated will be considered.
 * * duplicates_allowed = FALSE: If exact duplicates of a given wound on part are tolerated. Useful for simply getting a path and not instantiating.
 * * care_about_existing_wounds = TRUE: If we iterate over wounds to see if any are above or at a given wounds severity, and disregard it if any are. Useful for simply getting a path and not instantiating.
 *
 * Returns:
 * A randomly picked wound typepath meeting all the above criteria and being applicable to the part's biotype - or null if there were none.
 */
/datum/controller/subsystem/wounds/proc/get_corresponding_wound_type(list/wounding_types, obj/item/bodypart/part, severity_min, severity_max = severity_min, severity_pick_mode = WOUND_PICK_HIGHEST_SEVERITY, random_roll = TRUE, duplicates_allowed = FALSE, care_about_existing_wounds = TRUE)
	RETURN_TYPE(/datum/wound) // note that just because its set to return this doesnt mean its non-nullable

	var/list/wounding_type_list = list()
	for (var/wounding_type as anything in wounding_types)
		wounding_type_list |= SSwounds.types_to_series[wounding_type]
	if (!length(wounding_type_list))
		return null

	var/list/datum/wound/paths_to_pick_from = list()
	for (var/series as anything in shuffle(wounding_type_list))
		var/list/severity_list = series_collection[series]
		if (!length(severity_list))
			continue

		var/picked_severity
		for (var/severity_text as anything in shuffle(severities_chronological))
			var/severity = text2num(severity_text)
			if (severity > severity_min || severity < severity_max)
				continue

			if (isnull(picked_severity) || ((severity_pick_mode == WOUND_PICK_HIGHEST_SEVERITY && severity > picked_severity) || (severity_pick_mode == WOUND_PICK_LOWEST_SEVERITY && severity < picked_severity)))
				picked_severity = severity

		var/list/wound_typepaths = severity_list["[picked_severity]"]
		if (!length(wound_typepaths))
			continue

		for (var/datum/wound/iterated_path as anything in wound_typepaths)
			var/datum/wound_pregen_data/pregen_data = SSwounds.pregen_data[iterated_path]
			if (pregen_data.can_be_applied_to(part, wounding_types, random_roll = random_roll, duplicates_allowed = duplicates_allowed, care_about_existing_wounds = care_about_existing_wounds))
				paths_to_pick_from[iterated_path] = wound_typepaths[iterated_path]

	return pick_weight(paths_to_pick_from) // we found our winners!
