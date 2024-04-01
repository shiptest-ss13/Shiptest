/*
	Outpost landmarks (used to find specific tiles in loaded maps)
*/

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


/obj/effect/landmark/outpost/hangar_numbers
	name = "hangar numbers landmark"

/obj/effect/landmark/outpost/hangar_numbers/proc/write_number(num)
	num = round(num)
	var/low_digit = num % 10
	var/high_digit = ((num - low_digit) / 10) % 10

	var/low_type = get_number_decal(low_digit, EAST)
	var/high_type = get_number_decal(high_digit, WEST)

	new low_type(loc)
	new high_type(loc)

	qdel(src)


/obj/effect/landmark/outpost/elevator
	name = "outpost elevator landmark"
	/// Specifies the unique elevator shaft this landmark is associated with, for linking floor elevator machines to the correct shaft.
	/// This variable is only used in the "main" outpost map, and is not required nor respected for hangar maps, as only one shaft is allowed.
	/// Should be a string, as it is communicated to players.
	var/shaft


/obj/effect/landmark/outpost/elevator_machine
	name = "outpost elevator machine landmark"
	/// Specifies the unique elevator shaft this landmark is associated with, for linking floor elevator machines to the correct shaft.
	/// This is only used in the "main" outpost map, and is not required nor respected for hangar maps, as only one shaft is allowed.
	/// Should be a string, as it is communicated to players.
	var/shaft


// This solution sucks. It turns out that both the area vars and type-level atom vars aren't respected, because
// they get overwritten in LateInitialize. I had to do this instead. Eventually somebody will rewrite light fixture code.
/obj/machinery/light/floor/hangar/LateInitialize()
	. = ..()
	brightness = 20
