/*
	Outpost landmarks (used to find specific tiles in loaded maps)
*/

// DEBUG: better methodology? landmark-based approach requires a lot of annoying book-making in /datum/overmap/outpost. maybe something that collects information in its late_initialize()?
GLOBAL_LIST_EMPTY(outpost_landmarks)

/obj/effect/landmark/outpost
	name = "outpost landmark (UNUSED)"

/obj/effect/landmark/outpost/Initialize(...)
	. = ..()
	GLOB.outpost_landmarks += src

/obj/effect/landmark/outpost/Destroy(...)
	GLOB.outpost_landmarks -= src
	. = ..()

/obj/effect/landmark/outpost/hangar_dock
	name = "hangar dock landmark"

/obj/effect/landmark/outpost/elevator
	name = "outpost elevator landmark"
	/// Specifies the unique elevator shaft this landmark is associated with, for linking floor elevator machines to the correct shaft.
	/// This is only used in the "main" outpost map, and is not required nor respected for hangar maps, as only one shaft is allowed.
	/// Should be a string.
	// DEBUG: is string restriction sensible? use or remove shaft_type
	var/shaft
	var/shaft_type = ELEVATOR_SHAFT_NORMAL

/obj/effect/landmark/outpost/elevator_machine
	name = "outpost elevator machine landmark"
	/// Specifies the unique elevator shaft this landmark is associated with, for linking floor elevator machines to the correct shaft.
	/// This is only used in the "main" outpost map, and is not required nor respected for hangar maps, as only one shaft is allowed.
	/// Should be a string.
	var/shaft

/*
	Areas
*/

// DEBUG: make this better. add a dedicated area sprite for mappers?
/area/hangar
	area_flags = UNIQUE_AREA | NOTELEPORT
	// DEBUG: does this still cause audio popping?
	sound_environment = SOUND_AREA_LARGE_ENCLOSED
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	has_gravity = STANDARD_GRAVITY

	requires_power = FALSE
	power_equip = FALSE // nice try, but you can't power your machines just by placing them outside the ship // DEBUG: does this break doors?
	power_light = TRUE
	power_environ = TRUE
