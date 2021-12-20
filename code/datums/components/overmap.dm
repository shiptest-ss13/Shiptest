/// A component used exclusively for overmap entities, to modularize behavior
/// and streamline networking with the overmap display.
/datum/component/overmap
	/// String ID used to identify the component in the overmap UI.
	/// If null, this component will not be communicated to the overmap UI.
	var/overmap_ui_comp_id = null

// DEBUG FIX -- unify subtype default value behavior on initialize
/datum/component/overmap/Initialize()
	// this comp type is exclusive to overmap entities
	if(!istype(parent, /datum/overmap_ent))
		return COMPONENT_INCOMPATIBLE

/datum/component/overmap/RegisterWithParent()
	if(overmap_ui_comp_id)
		RegisterSignal(parent, COMSIG_OVERMAP_GET_UI_DATA, .proc/get_ui_data)

/datum/component/overmap/UnregisterFromParent()
	// UnregisterSignal doesn't care if the signal isn't registered
	UnregisterSignal(parent, COMSIG_OVERMAP_GET_UI_DATA)

/datum/component/overmap/proc/get_ui_data(datum/D, list/data)
	SIGNAL_HANDLER
	data[overmap_ui_comp_id] = list()
	return
