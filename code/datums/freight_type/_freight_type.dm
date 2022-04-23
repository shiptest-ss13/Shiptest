
// A parent datum for holding the singular and group types in a single list
// Avoids using two identical loops to check two different kinds of datums that basically do the same thing. One just happens to be a recursive group
// If you need to access a variable recursively but the variable is defined in /single, move it here to the topmost datum so /group can quickly iterate over the list
// See _group.dm proc get_supply_request_form_segment

/datum/freight_type
	var/add_approved_contents_to_check = TRUE
	var/datum/overmap_objective/cargo/objective = null

	// Stores a list of initialized atoms
	// Set to TRUE to automatically place this item in a prepackaged large wooden crate, for simpler transfer objectives
	// If allow_replacements is TRUE, and an item is provided in a prepackaged large wooden crate but the players open/destroy it, the players may be able to repackage or source a replacement to deliver
	// item is a required field if send_prepackaged_item is TRUE.
	// overmap_objective is a required field if send_prepackaged_item is TRUE. Simply pass in the overmap_objective on objective self initialize
	var/send_prepackaged_item = FALSE
	var/list/prepackaged_items = list()

	// The superior version of require_inner_contents
	// Setting this to a typepath will require all items checked to reside inside this loc object before approving
	var/require_loc

	// Set the loc name to update the briefing description
	var/require_loc_name

/datum/freight_type/proc/check_contents()

/datum/freight_type/proc/get_item_name()

/datum/freight_type/proc/get_target()

/datum/freight_type/proc/deliver_package()

/datum/freight_type/proc/get_brief_segment()

/datum/freight_type/proc/get_supply_request_form_segment()

/datum/freight_type/proc/set_objective( var/datum/overmap_objective/O )
	objective = O

/datum/freight_type/proc/in_required_loc_or_is_required_loc( var/atom/a ) // I am literally one inconvenience away from trashing the social supplies objective
	return ( !require_loc || ( require_loc && ( recursive_loc_check( a, require_loc ) || istype( a, require_loc ) ) ) )
