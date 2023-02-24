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

// DEBUG: the worst solution i've come up with yet
/obj/machinery/light/floor/hangar
	brightness = 20

/obj/machinery/light/floor/hangar/LateInitialize()
	. = ..()
	brightness = 20
